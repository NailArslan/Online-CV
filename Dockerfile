# Use ASP.NET runtime for running the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

# Use .NET SDK for building the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .

# Restore and publish the app
RUN dotnet restore "./Online_CV.csproj"
RUN dotnet publish "./Online_CV.csproj" -c Release -o /app/publish

# Final runtime image
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Online_CV.dll"]

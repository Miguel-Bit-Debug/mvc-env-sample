FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["DemoShop.csproj", "."]
RUN dotnet restore "./DemoShop.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "DemoShop.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "DemoShop.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DemoShop.dll"]
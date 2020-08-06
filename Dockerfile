FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS builder
WORKDIR /build

COPY ./src/ ./src
RUN dotnet publish -c Release -o /app ./src/DotnetDockerSample.Api/DotnetDockerSample.Api.csproj

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app

COPY --from=builder /app .
STOPSIGNAL SIGINT

ENV ASPNETCORE_ENVIRONMENT=Production
ENV ASPNETCORE_URLS=http://*:80
EXPOSE 80

ENTRYPOINT [ "dotnet", "DotnetDockerSample.Api.dll" ]
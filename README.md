# Corporate Website 
The Corporate Website (fbitn.com).

## Architecture
UNDER CONSTRUCTION. Component diagram describing the architecture

## Tools and Technologies

The applicationn is built with following tools and technologies -

- Source Control - [Azure Repos](https://azure.microsoft.com/en-us/services/devops/repos/)
- Programming Languages - [Typescript](https://www.typescriptlang.org/)
- Frameworks - [React](https://reactjs.org/), [NEXT.js](https://nextjs.org/)
- Testing Framework - [Jest](https://jestjs.io/)
- Infrastructure - [Azure](https://azure.microsoft.com/en-us/) defined in [Bicep](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview?tabs=bicep) as code
- CI/CD - [Azure Pipelines in YAML](https://azure.microsoft.com/en-us/services/devops/pipelines/)
- Logging - [Splunk](https://www.splunk.com/)
- Monitoring - [Dynatrace](https://www.dynatrace.com/?utm_source=google&utm_medium=cpc&utm_term=dynatrace&utm_campaign=us-brand&utm_content=none&gclid=CjwKCAjw4ayUBhA4EiwATWyBrqOozxRoJ_pBVspJk0FXJPPygRVKvmlP11gNbdKDuFmOH4CrTVNKaBoCCBEQAvD_BwE&gclsrc=aw.ds)
- Development IDE - [Visual Studio Code](https://code.visualstudio.com/)
- Code Quality - [Sonar Cloud](https://sonarcloud.io/?gads_campaign=North-America-SonarClouds&gads_ad_group=SonarCloud&gads_keyword=sonarcloud&gclid=CjwKCAjw4ayUBhA4EiwATWyBrssDdH6dkh-KHMql_DfJJYBtZ0m87-8TiZtv8ekDASOtq-1NTHG4fRoCUmwQAvD_BwE)
- Package Manager - [Npm](https://www.npmjs.com/)

## Repository Folder Structure

This repository holds the application source code, the infrastructure(defined as code) and the pipelines(in yaml) for build and deploy.
- app
    - This folder contains the application source code written in typescript. All application functionality code will live in this folder.
- infrastructure
    - This folder contains Azure infrastructure components defined in bicep. All services and components needed for running this application are defined in this folder.
- pipelines
    - This folder contains the pipeline definitions for CI/CD. The pipelines are defined in YAML.

## Local Development

### Pre-requisites 

The following software are needed to run the application locally.

- [Npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)
- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Visual Studio Code](https://code.visualstudio.com/download)

### Run Locally

- Clone the repository - `git clone https://inchworksinch@dev.azure.com/inchworksinch/My%20Account/_git/my-account-web`
- Make a branch - `git checkout -b <branch_name>`
- Open the cloned folder in `VSCode`.
- Change directory to app - `cd app`.
- Install Dependencies - `npm install`.
- Build application - `npm run build`.
- Run tests - `npm run test` (Optional).
- Run Application - `npm start`. Application will be served on `http://localhost:3000`

## CI/CD

UNDER CONSTRUCTION. Azure Pipeline links specific to the app need to be added here.

## Monitoring

UNDER CONSTRUCTION. Dynatrace links and sample queries specific to the app need to be added here.

## Logging

UNDER CONSTRUCTION. Splunk index links and sample queries specific to the app need to be added here.

## Useful links

- [Solution Architecture Visio](https://fbitn.sharepoint.com/:u:/r/sites/PMOProjects/DigTrans/_layouts/15/Doc.aspx?sourcedoc=%7B17046C9B-51B6-4EBD-8B09-17ED634CA4C3%7D&file=Solution-Architecture-Diagrams.vsdx&action=default&mobileredirect=true)
- [Rally Board]()
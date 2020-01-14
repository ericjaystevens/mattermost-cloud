# Mattermost Private Cloud ![CircleCI branch](https://img.shields.io/circleci/project/github/mattermost/mattermost-cloud/master.svg)

Mattermost Private Cloud is a SaaS offering meant to smooth and accelerate the customer journey from trial to full adoption. There is a significant amount of friction for a customer to set up a trial of Mattermost, and even more friction to run an extended length proof of concept. Both require hardware and technical personnel resources that create a significant barrier to potential customers. Mattermost Cloud aims to remove this barrier by providing a service to provision and host Mattermost instances that can be used by customers who have no technical experience. This will accelerate the customer journey to a full adoption of Mattermost either in the form of moving to a self-hosted instance or by continuing to use the cloud service.

Read more about the [Mattermost Private Cloud Architecture](https://docs.google.com/document/d/1DZRrJ4LymdNA-D130i44VICLKmTzwAZMTMjiYNYIfiM/edit#).

## Other Resources

This repository houses the open-source components of Mattermost Private Cloud. Other resources are linked below:

- [Mattermost the server and user interface](https://github.com/mattermost/mattermost-server)
- [Helm chart for Mattermost Enterprise Edition](https://github.com/mattermost/mattermost-kubernetes)
- [Experimental Mattermost operator for Kubernetes](https://github.com/mattermost/mattermost-operator)

## Get Involved

- [Join the discussion on Private Cloud](https://community.mattermost.com/core/channels/cloud)

## Developing

### Environment Setup

#### Clone repository

```
git clone  https://github.com/mattermost/mattermost-cloud.git
```

#### Create a docker image

From cloned repository run

```
docker build -t mattermost:clouddev .
```

#### Modify Environment file

```
cp mattermost-cloud.sample mattermost-cloud.env
```

In your preferred text editor open and edit ```mattermost-cloud.env```


### Running

Before running the server the first time you must set up the DB with:

```
$ docker run --env-file=mattermost-cloud.env mattermost:clouddev cloud schema migrate
```

To run the server you will need a certificate ARN, private and public Route53 IDs, and a private DNS from AWS. For staff developers you can get these in our dev AWS account.

Run the server with:

```
$ docker run --env-file=mattermost-cloud.env mattermost:cloudev cloud server
```

### Testing

Run the go tests to test:

```
$ docker run go test ./...
```
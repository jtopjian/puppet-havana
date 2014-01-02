Havana Reference Module
=======================

This module is a reference implementation for the [cubbystack](https://github.com/jtopjian/puppet-cubbystack) OpenStack Module.

#### Table of Contents

1. [Introduction](#introduction)
2. [Setup](#setup)
  * [Requirements](#requirements)
3. [Usage](#usage)
  * [Module Installation](#module-installation)
  * [Hiera Configuration](#hiera-configuration)
  * [Roles](#roles)
4. [Limitations](#limitations)
5. [Credits](#credits)

## Introduction

This module is able to deploy a multi-node OpenStack environment out of the box. It currently supports two types of nodes:

  * Cloud Controller: Runs all services except for `nova-compute`
  * Compute Node: Runs `nova-compute`

In the future, this module will support more types as well as different variations on those types. Each type will probably be broken out into its own branch.

## Setup

### Requirements

This module has been tested with Ubuntu 12.04. Each node only requires one network interface, although support for three interfaces is included in the configuration.

Puppet 3.2. You must also have the [future parser](http://docs.puppetlabs.com/puppet/3/reference/experiments_future.html) enabled.

Hiera 1.3.

The [cubbystack](https://github.com/jtopjian/puppet-cubbystack) module.

## Usage

### Module Installation

This module installs just like any other Puppet module. Make sure it is located in a correct `modulepath` directory such as `/etc/puppet/modules`.

### Hiera Configuration

This modules includes an example Hiera configuration file and data source. If you'd like to use the examples provided, first copy the Hiera configuration:

```bash
$ sudo cp hiera/hiera.yaml /etc/
$ sudo cp hiera/hiera.yaml /etc/puppet/
```

Then copy the example data source:

```bash
$ sudo mkdir /etc/puppet/hieradata
$ sudo cp hiera/common.yaml /etc/puppet/hieradata/
```

Finally, review the `common.yaml` file and change any parameters that need modified to suit your environment.

### Roles

Once the module is installed and Hiera is configured, the last step is to apply a role to a node. This module comes with two roles: a cloud controller and compute node:

```puppet
node 'cloud.example.com' {
  include havana::roles::controller
}

node /c[0-9]+.example.com/ {
  include havana::roles::compute
}
```

## Limitations

This module is a reference module. Its purpose is to show you can use [cubbystack](https://github.com/jtopjian/cubbystack) in a practical way. Therefore this module will not cover all different types of OpenStack environments.

## Credits

This module is based off of Chris Hoges's excellent [Puppet work](https://github.com/hogepodge/puppetlabs-havana).

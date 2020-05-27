Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E901E51DB
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 01:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgE0Xdh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 19:33:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:5622 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgE0Xdh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 19:33:37 -0400
IronPort-SDR: /l5IuLshM/QuBwP3A7zENPhxLwGJap9Mwi6LTiJxekzMWqacfq7FjEvJdhbPoirI5pMr/70k3B
 altpWPZ4WCKw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 16:33:34 -0700
IronPort-SDR: HMWuZc9UA65huIpRwjE839U5OA+Euh9xF6afh0ONzu4nm1qddD8W7LXIoazbH5MUli196Wybjk
 +62NrqZvT/RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; 
   d="scan'208";a="468903647"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 May 2020 16:33:33 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1je5YC-00080U-RV; Thu, 28 May 2020 07:33:32 +0800
Date:   Thu, 28 May 2020 07:33:25 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:master] BUILD SUCCESS
 119aadf816f5373dc82ca4109d6d5b777e00475b
Message-ID: <5ecef8c5.qCiSqiF89yQ5mj8O%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git  master
branch HEAD: 119aadf816f5373dc82ca4109d6d5b777e00475b  mac80211_hwsim: report the WIPHY_FLAG_SUPPORTS_5_10_MHZ capability

Warning in current branch:

net/ethtool/cabletest.c:230:5: sparse: sparse: symbol 'ethnl_act_cable_test_tdr_cfg' was not declared. Should it be static?
net/ethtool/cabletest.c:230:5: warning: no previous prototype for 'ethnl_act_cable_test_tdr_cfg' [-Wmissing-prototypes]

Warning ids grouped by kconfigs:

recent_errors
|-- alpha-randconfig-r024-20200527
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- arm-randconfig-c003-20200527
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- c6x-allyesconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- c6x-randconfig-c024-20200527
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- c6x-randconfig-r001-20200527
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- csky-defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- h8300-allyesconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- i386-allnoconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- i386-allyesconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- i386-debian-10.3
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- i386-defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- i386-randconfig-a003-20200527
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- i386-randconfig-a004-20200527
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- i386-randconfig-a006-20200527
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- i386-randconfig-a013-20200527
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- i386-randconfig-m021-20200527
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- i386-randconfig-r004-20200527
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- ia64-allyesconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- ia64-defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- ia64-randconfig-c004-20200527
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- ia64-randconfig-r002-20200527
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- m68k-allyesconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- m68k-defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- m68k-sun3_defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- microblaze-randconfig-c021-20200527
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- mips-allyesconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- mips-randconfig-c004-20200527
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- mips-randconfig-c022-20200527
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- nds32-defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- nios2-allyesconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- nios2-defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- nios2-randconfig-c003-20200527
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- openrisc-allyesconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- openrisc-defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- parisc-allyesconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- parisc-defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- parisc-randconfig-m031-20200527
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- riscv-allyesconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- riscv-defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- s390-allyesconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- s390-defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- sparc-allyesconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- sparc-randconfig-r003-20200527
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- sparc64-randconfig-s031-20200527
|   |-- net-ethtool-cabletest.c:sparse:sparse:symbol-ethnl_act_cable_test_tdr_cfg-was-not-declared.-Should-it-be-static
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- um-allyesconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- um-defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- x86_64-allyesconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- x86_64-randconfig-c002-20200527
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- x86_64-randconfig-s022-20200527
|   |-- net-ethtool-cabletest.c:sparse:sparse:symbol-ethnl_act_cable_test_tdr_cfg-was-not-declared.-Should-it-be-static
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
`-- xtensa-allyesconfig
    `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg

elapsed time: 910m

configs tested: 103
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                               allnoconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
mips                malta_kvm_guest_defconfig
arm                         socfpga_defconfig
nds32                             allnoconfig
mips                          malta_defconfig
arc                              alldefconfig
arm                         orion5x_defconfig
arc                     nsimosci_hs_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                                defconfig
ia64                              allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                              defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
arc                                 defconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
arc                              allyesconfig
nios2                            allyesconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20200527
i386                 randconfig-a004-20200527
i386                 randconfig-a003-20200527
i386                 randconfig-a006-20200527
i386                 randconfig-a002-20200527
i386                 randconfig-a005-20200527
x86_64               randconfig-a006-20200527
x86_64               randconfig-a002-20200527
x86_64               randconfig-a005-20200527
x86_64               randconfig-a003-20200527
x86_64               randconfig-a004-20200527
x86_64               randconfig-a001-20200527
i386                 randconfig-a013-20200527
i386                 randconfig-a015-20200527
i386                 randconfig-a012-20200527
i386                 randconfig-a011-20200527
i386                 randconfig-a016-20200527
i386                 randconfig-a014-20200527
riscv                             allnoconfig
riscv                               defconfig
riscv                            allyesconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
um                               allyesconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

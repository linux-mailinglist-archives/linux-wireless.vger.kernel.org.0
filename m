Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30551E9D2D
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2020 07:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgFAFUN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jun 2020 01:20:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:35499 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgFAFUM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jun 2020 01:20:12 -0400
IronPort-SDR: TQTdHUOFeI+Lt+h7TB+zHRmqQ6QIBhbwz7fBiVCRugaOlkVzaUmWnhHKeaVT+7WgsDOGaUog0E
 vWeCMK1sdXAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 22:20:12 -0700
IronPort-SDR: iUmvOvEMhHET+ssr6bT9wPNlKZl2n5eCrdMBD0q+cuNbBzBLMhcte1eIkDfNhQ8ta4MODeZFUg
 gz0aWI7d/zKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="257143168"
Received: from lkp-server01.sh.intel.com (HELO 49d03d9b0ee7) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 31 May 2020 22:20:10 -0700
Received: from kbuild by 49d03d9b0ee7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jfcrp-0000Ev-J5; Mon, 01 Jun 2020 05:20:09 +0000
Date:   Mon, 01 Jun 2020 13:19:09 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:master] BUILD SUCCESS
 093a48d2aa4b74db3134b61d7b7a061dbe79177b
Message-ID: <5ed48fcd.dF8z+ld0u94zBTsR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git  master
branch HEAD: 093a48d2aa4b74db3134b61d7b7a061dbe79177b  cfg80211: support bigger kek/kck key length

Warning in current branch:

net/ethtool/cabletest.c:230:5: warning: no previous prototype for 'ethnl_act_cable_test_tdr_cfg' [-Wmissing-prototypes]

Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- alpha-defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- arm-hisi_defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- arm-mainstone_defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- arm-shannon_defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- c6x-randconfig-c003-20200531
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- c6x-randconfig-c004-20200531
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- c6x-randconfig-c022-20200531
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- csky-defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- m68k-allyesconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- m68k-multi_defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- microblaze-nommu_defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- mips-allyesconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- mips-randconfig-r033-20200531
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- nds32-defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- nds32-randconfig-c021-20200531
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- openrisc-randconfig-c024-20200531
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- parisc-randconfig-r032-20200531
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- powerpc-mpc83xx_defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- powerpc-ppc6xx_defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- sparc-allyesconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- sparc-defconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- sparc64-allyesconfig
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- x86_64-fedora-25
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- x86_64-kexec
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- x86_64-lkp
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- x86_64-randconfig-c002-20200531
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- x86_64-rhel
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- x86_64-rhel-7.2-clear
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
|-- x86_64-rhel-7.6
|   `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg
`-- x86_64-rhel-7.6-kselftests
    `-- net-ethtool-cabletest.c:warning:no-previous-prototype-for-ethnl_act_cable_test_tdr_cfg

elapsed time: 934m

configs tested: 110
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
powerpc                      mgcoge_defconfig
nds32                             allnoconfig
s390                              allnoconfig
arm                         vf610m4_defconfig
arm                          pxa168_defconfig
arm                         shannon_defconfig
powerpc                      ppc6xx_defconfig
powerpc64                        alldefconfig
microblaze                    nommu_defconfig
arm                       mainstone_defconfig
arm                            hisi_defconfig
powerpc                     mpc83xx_defconfig
m68k                          multi_defconfig
m68k                             allyesconfig
arm                            dove_defconfig
h8300                            alldefconfig
powerpc                     pseries_defconfig
nds32                            alldefconfig
arm                         s3c6400_defconfig
m68k                        mvme16x_defconfig
mips                      pistachio_defconfig
c6x                         dsk6455_defconfig
riscv                    nommu_virt_defconfig
sh                        apsh4ad0a_defconfig
sh                           se7343_defconfig
mips                          rm200_defconfig
arm                        mvebu_v5_defconfig
arm                         assabet_defconfig
xtensa                           alldefconfig
powerpc                      tqm8xx_defconfig
sh                           se7750_defconfig
xtensa                         virt_defconfig
sh                            shmin_defconfig
arm                        multi_v5_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
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

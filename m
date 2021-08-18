Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBBA3EF991
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 06:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbhHREjC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 00:39:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:26861 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231853AbhHREi7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 00:38:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="279989704"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="279989704"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 21:38:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="520747460"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2021 21:38:23 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mGDLK-000Saj-OV; Wed, 18 Aug 2021 04:38:22 +0000
Date:   Wed, 18 Aug 2021 12:37:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:master] BUILD SUCCESS WITH WARNING
 f50d2ff8f016b79a2ff4acd5943a1eda40c545d4
Message-ID: <611c8ea0.qAyvFkrBP1e7cmEQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
branch HEAD: f50d2ff8f016b79a2ff4acd5943a1eda40c545d4  mac80211: Fix insufficient headroom issue for AMSDU

Warning reports:

https://lore.kernel.org/linux-wireless/202108180511.rF93CENm-lkp@intel.com

Warning in current branch:

net/wireless/./trace.h:3637:30: warning: implicit conversion from 'enum nl80211_commands' to 'enum nl80211_bss_scan_width' [-Wenum-conversion]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-allyesconfig
|   `-- net-wireless-.-trace.h:warning:implicit-conversion-from-enum-nl80211_commands-to-enum-nl80211_bss_scan_width
|-- arc-randconfig-r043-20210816
|   `-- net-wireless-.-trace.h:warning:implicit-conversion-from-enum-nl80211_commands-to-enum-nl80211_bss_scan_width
|-- arm-allmodconfig
|   `-- net-wireless-.-trace.h:warning:implicit-conversion-from-enum-nl80211_commands-to-enum-nl80211_bss_scan_width
|-- arm-allyesconfig
|   `-- net-wireless-.-trace.h:warning:implicit-conversion-from-enum-nl80211_commands-to-enum-nl80211_bss_scan_width
|-- arm-defconfig
|   `-- net-wireless-.-trace.h:warning:implicit-conversion-from-enum-nl80211_commands-to-enum-nl80211_bss_scan_width
|-- arm64-allyesconfig
|   `-- net-wireless-.-trace.h:warning:implicit-conversion-from-enum-nl80211_commands-to-enum-nl80211_bss_scan_width
|-- mips-allmodconfig
|   `-- net-wireless-.-trace.h:warning:implicit-conversion-from-enum-nl80211_commands-to-enum-nl80211_bss_scan_width
|-- mips-allyesconfig
|   `-- net-wireless-.-trace.h:warning:implicit-conversion-from-enum-nl80211_commands-to-enum-nl80211_bss_scan_width
|-- nds32-allyesconfig
|   `-- net-wireless-.-trace.h:warning:implicit-conversion-from-enum-nl80211_commands-to-enum-nl80211_bss_scan_width
|-- parisc-allyesconfig
|   `-- net-wireless-.-trace.h:warning:implicit-conversion-from-enum-nl80211_commands-to-enum-nl80211_bss_scan_width
|-- riscv-allmodconfig
|   `-- net-wireless-.-trace.h:warning:implicit-conversion-from-enum-nl80211_commands-to-enum-nl80211_bss_scan_width
|-- riscv-allyesconfig
|   `-- net-wireless-.-trace.h:warning:implicit-conversion-from-enum-nl80211_commands-to-enum-nl80211_bss_scan_width
|-- sh-allmodconfig
|   `-- net-wireless-.-trace.h:warning:implicit-conversion-from-enum-nl80211_commands-to-enum-nl80211_bss_scan_width
|-- sparc-allyesconfig
|   `-- net-wireless-.-trace.h:warning:implicit-conversion-from-enum-nl80211_commands-to-enum-nl80211_bss_scan_width
`-- xtensa-allyesconfig
    `-- net-wireless-.-trace.h:warning:implicit-conversion-from-enum-nl80211_commands-to-enum-nl80211_bss_scan_width

elapsed time: 727m

configs tested: 103
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210816
i386                             alldefconfig
powerpc               mpc834x_itxgp_defconfig
arm                        magician_defconfig
arm                        multi_v5_defconfig
openrisc                    or1ksim_defconfig
sh                     magicpanelr2_defconfig
powerpc                      mgcoge_defconfig
arc                         haps_hs_defconfig
arm                       aspeed_g5_defconfig
powerpc                mpc7448_hpc2_defconfig
ia64                             alldefconfig
arc                        nsim_700_defconfig
mips                            e55_defconfig
arm                          lpd270_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                  iss476-smp_defconfig
powerpc                      katmai_defconfig
x86_64                            allnoconfig
powerpc                   currituck_defconfig
powerpc                 canyonlands_defconfig
sh                         ecovec24_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210816
x86_64               randconfig-a004-20210816
x86_64               randconfig-a003-20210816
x86_64               randconfig-a001-20210816
x86_64               randconfig-a005-20210816
x86_64               randconfig-a002-20210816
x86_64               randconfig-a004-20210818
x86_64               randconfig-a006-20210818
x86_64               randconfig-a003-20210818
x86_64               randconfig-a005-20210818
x86_64               randconfig-a002-20210818
x86_64               randconfig-a001-20210818
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
i386                 randconfig-a004-20210817
i386                 randconfig-a003-20210817
i386                 randconfig-a001-20210817
i386                 randconfig-a002-20210817
i386                 randconfig-a006-20210817
i386                 randconfig-a005-20210817
x86_64               randconfig-a011-20210816
x86_64               randconfig-a013-20210816
x86_64               randconfig-a016-20210816
x86_64               randconfig-a012-20210816
x86_64               randconfig-a015-20210816
x86_64               randconfig-a014-20210816
i386                 randconfig-a011-20210816
i386                 randconfig-a015-20210816
i386                 randconfig-a013-20210816
i386                 randconfig-a014-20210816
i386                 randconfig-a016-20210816
i386                 randconfig-a012-20210816

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E2E27B936
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 03:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgI2BNj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 21:13:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:5955 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbgI2BNj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 21:13:39 -0400
IronPort-SDR: 77qN2T3DFMPiPqxS+9gJW8k1Z/CL9jHaTC/8TEhsfl2Hw/Wi4IRaZz/rHO7gROP06XdZww2Qqp
 32UauUl+JT8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="226233913"
X-IronPort-AV: E=Sophos;i="5.77,316,1596524400"; 
   d="scan'208";a="226233913"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 18:13:38 -0700
IronPort-SDR: 2K0VejRrIIx9mv9/+fTm5Dogc0p7ZpQAeM/EfhBPjEP2IYaGkw59ROW6c9YtBXkcHLNWpUhKsf
 F2gA+ob2qXhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,316,1596524400"; 
   d="scan'208";a="294078702"
Received: from lkp-server01.sh.intel.com (HELO 0e0978ea3297) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 28 Sep 2020 18:13:37 -0700
Received: from kbuild by 0e0978ea3297 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kN4D2-0000T1-Rp; Tue, 29 Sep 2020 01:13:36 +0000
Date:   Tue, 29 Sep 2020 09:13:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:master] BUILD SUCCESS
 f5bec330e3010450daeb5cb6a94a4a7c54afa306
Message-ID: <5f728a36.Q2puGzfI1JjgwsJg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git  master
branch HEAD: f5bec330e3010450daeb5cb6a94a4a7c54afa306  nl80211: extend support to config spatial reuse parameter set

elapsed time: 722m

configs tested: 136
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      arches_defconfig
powerpc                      cm5200_defconfig
sparc                       sparc32_defconfig
arm                          badge4_defconfig
powerpc                        cell_defconfig
arm                       imx_v6_v7_defconfig
m68k                            mac_defconfig
sh                              ul2_defconfig
mips                        vocore2_defconfig
openrisc                    or1ksim_defconfig
sh                          rsk7269_defconfig
powerpc                    adder875_defconfig
powerpc                 mpc8560_ads_defconfig
m68k                         amcore_defconfig
sparc64                          alldefconfig
powerpc                      acadia_defconfig
nios2                         3c120_defconfig
powerpc                     rainier_defconfig
powerpc                     mpc512x_defconfig
mips                       lemote2f_defconfig
riscv                          rv32_defconfig
sh                        edosk7760_defconfig
mips                      bmips_stb_defconfig
sh                        apsh4ad0a_defconfig
arm                        magician_defconfig
mips                           ip22_defconfig
arm                        spear6xx_defconfig
mips                         db1xxx_defconfig
mips                     loongson1b_defconfig
xtensa                    smp_lx200_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                       ebony_defconfig
arm                       cns3420vb_defconfig
powerpc                     pseries_defconfig
arm                         vf610m4_defconfig
mips                           gcw0_defconfig
m68k                             allmodconfig
mips                       rbtx49xx_defconfig
nios2                         10m50_defconfig
mips                     cu1000-neo_defconfig
sh                           se7619_defconfig
powerpc                     stx_gp3_defconfig
powerpc                 mpc8540_ads_defconfig
sh                            titan_defconfig
powerpc                   currituck_defconfig
mips                        bcm47xx_defconfig
sh                          polaris_defconfig
powerpc                      walnut_defconfig
sh                         microdev_defconfig
arm                           sunxi_defconfig
microblaze                    nommu_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                 randconfig-a002-20200927
i386                 randconfig-a006-20200927
i386                 randconfig-a003-20200927
i386                 randconfig-a004-20200927
i386                 randconfig-a005-20200927
i386                 randconfig-a001-20200927
i386                 randconfig-a006-20200928
i386                 randconfig-a002-20200928
i386                 randconfig-a003-20200928
i386                 randconfig-a004-20200928
i386                 randconfig-a005-20200928
i386                 randconfig-a001-20200928
x86_64               randconfig-a005-20200928
x86_64               randconfig-a003-20200928
x86_64               randconfig-a004-20200928
x86_64               randconfig-a002-20200928
x86_64               randconfig-a006-20200928
x86_64               randconfig-a001-20200928
x86_64               randconfig-a011-20200927
x86_64               randconfig-a013-20200927
x86_64               randconfig-a014-20200927
x86_64               randconfig-a015-20200927
x86_64               randconfig-a012-20200927
x86_64               randconfig-a016-20200927
i386                 randconfig-a012-20200928
i386                 randconfig-a016-20200928
i386                 randconfig-a014-20200928
i386                 randconfig-a013-20200928
i386                 randconfig-a015-20200928
i386                 randconfig-a011-20200928
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20200928
x86_64               randconfig-a013-20200928
x86_64               randconfig-a015-20200928
x86_64               randconfig-a014-20200928
x86_64               randconfig-a016-20200928
x86_64               randconfig-a012-20200928

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

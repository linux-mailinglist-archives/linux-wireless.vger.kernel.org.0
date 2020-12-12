Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4812D83AB
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Dec 2020 01:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437958AbgLLAze (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 19:55:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:10028 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437954AbgLLAzS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 19:55:18 -0500
IronPort-SDR: zLzG9RgkqmgBue5L5MYOP/k85jInjNisAUa3bB5HeQ8Iz4D5dd0Nio3fHc2D2EvZtrV9h+nlxG
 F5RWU3LaPoJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9832"; a="174629866"
X-IronPort-AV: E=Sophos;i="5.78,413,1599548400"; 
   d="scan'208";a="174629866"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 16:54:38 -0800
IronPort-SDR: nfKYRCapFMAsMQGq6V8q4aYg0Xy4FePI7I0oSmgsKuFGOAhO/+KAjoiXXoCBoS8QPavH9VmeDY
 M9H5J6Yxd4wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,413,1599548400"; 
   d="scan'208";a="365746064"
Received: from lkp-server01.sh.intel.com (HELO ecc0cebe68d1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 11 Dec 2020 16:54:36 -0800
Received: from kbuild by ecc0cebe68d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kntBE-0001Ax-54; Sat, 12 Dec 2020 00:54:36 +0000
Date:   Sat, 12 Dec 2020 08:53:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:master] BUILD SUCCESS
 c534e093d865d926d042e0a3f228d1152627ccab
Message-ID: <5fd414a7.y4lBfS+GhjY+s0JP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git  master
branch HEAD: c534e093d865d926d042e0a3f228d1152627ccab  mac80211: add ieee80211_set_sar_specs

elapsed time: 722m

configs tested: 173
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 linkstation_defconfig
sh                         apsh4a3a_defconfig
arm                           omap1_defconfig
powerpc                     mpc512x_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
nios2                         3c120_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                     tqm8548_defconfig
m68k                           sun3_defconfig
parisc                generic-32bit_defconfig
m68k                       m5275evb_defconfig
arm                          exynos_defconfig
arm                      integrator_defconfig
sh                           se7343_defconfig
arm                            qcom_defconfig
sh                          rsk7264_defconfig
mips                     cu1000-neo_defconfig
powerpc                        cell_defconfig
arm                      jornada720_defconfig
sh                          urquell_defconfig
mips                           mtx1_defconfig
powerpc                    mvme5100_defconfig
mips                         cobalt_defconfig
powerpc                     tqm8541_defconfig
sh                          landisk_defconfig
powerpc                       holly_defconfig
s390                                defconfig
arm                            zeus_defconfig
sh                            migor_defconfig
mips                        vocore2_defconfig
arm                         orion5x_defconfig
powerpc                 mpc836x_mds_defconfig
arm                          gemini_defconfig
sh                          rsk7269_defconfig
sh                        apsh4ad0a_defconfig
m68k                        m5272c3_defconfig
mips                   sb1250_swarm_defconfig
parisc                           alldefconfig
powerpc                    klondike_defconfig
mips                      loongson3_defconfig
arm                       spear13xx_defconfig
arm                        trizeps4_defconfig
alpha                            alldefconfig
sh                         microdev_defconfig
arm                           u8500_defconfig
powerpc                        icon_defconfig
powerpc                  mpc885_ads_defconfig
mips                           xway_defconfig
powerpc                      cm5200_defconfig
arm                      footbridge_defconfig
mips                      pistachio_defconfig
mips                      maltaaprp_defconfig
m68k                             alldefconfig
sh                          r7785rp_defconfig
sh                   secureedge5410_defconfig
ia64                          tiger_defconfig
arm                        mini2440_defconfig
sh                              ul2_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc64                           defconfig
powerpc                     rainier_defconfig
powerpc                        warp_defconfig
arm                          badge4_defconfig
s390                          debug_defconfig
powerpc                    ge_imp3a_defconfig
mips                      bmips_stb_defconfig
arm                         lubbock_defconfig
xtensa                         virt_defconfig
xtensa                generic_kc705_defconfig
sparc                            allyesconfig
powerpc                          g5_defconfig
m68k                       bvme6000_defconfig
powerpc                      pasemi_defconfig
xtensa                    smp_lx200_defconfig
sh                           se7619_defconfig
nds32                               defconfig
arm                         mv78xx0_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          simpad_defconfig
arm                       omap2plus_defconfig
powerpc                       ebony_defconfig
arc                         haps_hs_defconfig
arm                         s5pv210_defconfig
microblaze                      mmu_defconfig
powerpc                      makalu_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                           se7724_defconfig
c6x                                 defconfig
sh                            hp6xx_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                             allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a001-20201210
i386                 randconfig-a004-20201210
i386                 randconfig-a003-20201210
i386                 randconfig-a002-20201210
i386                 randconfig-a005-20201210
i386                 randconfig-a006-20201210
i386                 randconfig-a004-20201209
i386                 randconfig-a005-20201209
i386                 randconfig-a001-20201209
i386                 randconfig-a002-20201209
i386                 randconfig-a006-20201209
i386                 randconfig-a003-20201209
x86_64               randconfig-a016-20201209
x86_64               randconfig-a012-20201209
x86_64               randconfig-a013-20201209
x86_64               randconfig-a014-20201209
x86_64               randconfig-a015-20201209
x86_64               randconfig-a011-20201209
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
i386                 randconfig-a014-20201211
i386                 randconfig-a013-20201211
i386                 randconfig-a012-20201211
i386                 randconfig-a011-20201211
i386                 randconfig-a016-20201211
i386                 randconfig-a015-20201211
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

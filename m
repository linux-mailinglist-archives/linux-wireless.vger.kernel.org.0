Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D7C45F7C1
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Nov 2021 02:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344304AbhK0BFi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 20:05:38 -0500
Received: from mga05.intel.com ([192.55.52.43]:14452 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344182AbhK0BDi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 20:03:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="321963185"
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="321963185"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 17:00:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="675693989"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 26 Nov 2021 17:00:23 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqm4k-0008r9-E9; Sat, 27 Nov 2021 01:00:22 +0000
Date:   Sat, 27 Nov 2021 08:59:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [jberg-mac80211:master] BUILD SUCCESS
 8f9dcc29566626f683843ccac6113a12208315ca
Message-ID: <61a18306.P9PZIqbU8ZemZrRJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
branch HEAD: 8f9dcc29566626f683843ccac6113a12208315ca  mac80211: fix a memory leak where sta_info is not freed

elapsed time: 723m

configs tested: 149
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211126
powerpc              randconfig-c003-20211126
mips                 randconfig-c004-20211126
sh                          rsk7269_defconfig
powerpc                    adder875_defconfig
sh                               j2_defconfig
powerpc                     akebono_defconfig
arm                         axm55xx_defconfig
arm                           omap1_defconfig
parisc                generic-32bit_defconfig
csky                                defconfig
arm                          pcm027_defconfig
arm                            zeus_defconfig
arm                  colibri_pxa300_defconfig
arm                         lpc32xx_defconfig
ia64                             allyesconfig
powerpc                      chrp32_defconfig
arm                         hackkit_defconfig
arm                        clps711x_defconfig
sh                          rsk7203_defconfig
sh                        edosk7760_defconfig
powerpc                 mpc8560_ads_defconfig
m68k                          sun3x_defconfig
arm                          ep93xx_defconfig
arm                          simpad_defconfig
riscv                            alldefconfig
sparc                       sparc64_defconfig
powerpc                        warp_defconfig
arm                        mvebu_v7_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                     tqm8540_defconfig
arm                       aspeed_g4_defconfig
sh                          kfr2r09_defconfig
ia64                          tiger_defconfig
ia64                         bigsur_defconfig
powerpc                     ksi8560_defconfig
arm64                            alldefconfig
powerpc                     rainier_defconfig
xtensa                  audio_kc705_defconfig
powerpc                     mpc5200_defconfig
sh                           se7722_defconfig
sh                          sdk7780_defconfig
powerpc                    gamecube_defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     stx_gp3_defconfig
arm                              alldefconfig
m68k                         apollo_defconfig
m68k                        m5407c3_defconfig
arm                            pleb_defconfig
sh                            titan_defconfig
xtensa                    smp_lx200_defconfig
arm                          gemini_defconfig
arm                       imx_v6_v7_defconfig
arm                     am200epdkit_defconfig
arm                         mv78xx0_defconfig
sh                 kfr2r09-romimage_defconfig
arm                     eseries_pxa_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                           sh2007_defconfig
arm                       imx_v4_v5_defconfig
arm                         s3c6400_defconfig
sh                         microdev_defconfig
arm                  colibri_pxa270_defconfig
arm                  randconfig-c002-20211126
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a014-20211126
x86_64               randconfig-a011-20211126
x86_64               randconfig-a012-20211126
x86_64               randconfig-a016-20211126
x86_64               randconfig-a013-20211126
x86_64               randconfig-a015-20211126
i386                 randconfig-a016-20211126
i386                 randconfig-a015-20211126
i386                 randconfig-a012-20211126
i386                 randconfig-a013-20211126
i386                 randconfig-a014-20211126
i386                 randconfig-a011-20211126
arc                  randconfig-r043-20211126
s390                 randconfig-r044-20211126
riscv                randconfig-r042-20211126
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
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20211126
i386                 randconfig-c001-20211126
powerpc              randconfig-c003-20211126
riscv                randconfig-c006-20211126
arm                  randconfig-c002-20211126
x86_64               randconfig-c007-20211126
mips                 randconfig-c004-20211126
x86_64               randconfig-a001-20211126
x86_64               randconfig-a003-20211126
x86_64               randconfig-a006-20211126
x86_64               randconfig-a004-20211126
x86_64               randconfig-a005-20211126
x86_64               randconfig-a002-20211126
i386                 randconfig-a002-20211126
i386                 randconfig-a001-20211126
i386                 randconfig-a005-20211126
i386                 randconfig-a006-20211126
i386                 randconfig-a004-20211126
i386                 randconfig-a003-20211126
hexagon              randconfig-r045-20211126
hexagon              randconfig-r041-20211126

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

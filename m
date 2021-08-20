Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339AD3F344D
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 21:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbhHTTJZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 15:09:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:25750 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230470AbhHTTJY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 15:09:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="213705358"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="213705358"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 12:08:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="680383454"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Aug 2021 12:08:44 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mH9si-000V7Y-1n; Fri, 20 Aug 2021 19:08:44 +0000
Date:   Sat, 21 Aug 2021 03:08:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 a8f89fa27773a8c96fd09fb4e2f4892d794f21f6
Message-ID: <611ffda1.fHPPFaBViej5F5+p%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
branch HEAD: a8f89fa27773a8c96fd09fb4e2f4892d794f21f6  ice: do not abort devlink info if board identifier can't be found

elapsed time: 1001m

configs tested: 171
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210820
i386                 randconfig-c001-20210821
powerpc                 mpc8272_ads_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                            lart_defconfig
powerpc                         wii_defconfig
sh                           se7780_defconfig
arm                         hackkit_defconfig
arm                             ezx_defconfig
mips                  decstation_64_defconfig
arm                        trizeps4_defconfig
m68k                          multi_defconfig
arm                         lpc18xx_defconfig
sh                         ap325rxa_defconfig
mips                         db1xxx_defconfig
arm                        vexpress_defconfig
powerpc                     tqm8560_defconfig
powerpc                 mpc836x_mds_defconfig
sh                          r7780mp_defconfig
sh                           se7724_defconfig
arc                    vdk_hs38_smp_defconfig
sparc                            alldefconfig
arm                          iop32x_defconfig
sh                              ul2_defconfig
powerpc                     mpc5200_defconfig
openrisc                  or1klitex_defconfig
powerpc                 mpc8540_ads_defconfig
sh                               j2_defconfig
sh                           se7619_defconfig
sh                      rts7751r2d1_defconfig
mips                           gcw0_defconfig
arc                         haps_hs_defconfig
mips                       rbtx49xx_defconfig
arc                          axs103_defconfig
sh                          landisk_defconfig
mips                  maltasmvp_eva_defconfig
s390                             allyesconfig
xtensa                    smp_lx200_defconfig
arm                          badge4_defconfig
mips                        nlm_xlr_defconfig
mips                         bigsur_defconfig
arm                        spear6xx_defconfig
m68k                        mvme16x_defconfig
um                                  defconfig
mips                 decstation_r4k_defconfig
arc                              allyesconfig
alpha                               defconfig
mips                     decstation_defconfig
powerpc                      katmai_defconfig
arm                            hisi_defconfig
arm                         assabet_defconfig
powerpc                     stx_gp3_defconfig
sh                         ecovec24_defconfig
mips                         rt305x_defconfig
arm                             pxa_defconfig
powerpc                      chrp32_defconfig
mips                     loongson2k_defconfig
arm                              alldefconfig
powerpc                  mpc866_ads_defconfig
nios2                         10m50_defconfig
powerpc                     rainier_defconfig
powerpc                      ppc6xx_defconfig
arc                     haps_hs_smp_defconfig
powerpc                    klondike_defconfig
powerpc                        fsp2_defconfig
mips                       capcella_defconfig
mips                          ath25_defconfig
arm                           viper_defconfig
xtensa                  audio_kc705_defconfig
sparc                       sparc32_defconfig
sh                            shmin_defconfig
powerpc                 canyonlands_defconfig
powerpc                 mpc85xx_cds_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
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
x86_64               randconfig-a004-20210818
x86_64               randconfig-a006-20210818
x86_64               randconfig-a003-20210818
x86_64               randconfig-a005-20210818
x86_64               randconfig-a002-20210818
x86_64               randconfig-a001-20210818
x86_64               randconfig-a005-20210820
x86_64               randconfig-a006-20210820
x86_64               randconfig-a001-20210820
x86_64               randconfig-a003-20210820
x86_64               randconfig-a004-20210820
x86_64               randconfig-a002-20210820
i386                 randconfig-a006-20210820
i386                 randconfig-a001-20210820
i386                 randconfig-a002-20210820
i386                 randconfig-a005-20210820
i386                 randconfig-a003-20210820
i386                 randconfig-a004-20210820
x86_64               randconfig-a013-20210819
x86_64               randconfig-a011-20210819
x86_64               randconfig-a012-20210819
x86_64               randconfig-a016-20210819
x86_64               randconfig-a014-20210819
x86_64               randconfig-a015-20210819
i386                 randconfig-a015-20210819
i386                 randconfig-a011-20210819
i386                 randconfig-a014-20210819
i386                 randconfig-a013-20210819
i386                 randconfig-a016-20210819
i386                 randconfig-a012-20210819
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
i386                 randconfig-c001-20210820
i386                 randconfig-c001-20210818
x86_64               randconfig-a014-20210820
x86_64               randconfig-a016-20210820
x86_64               randconfig-a015-20210820
x86_64               randconfig-a013-20210820
x86_64               randconfig-a012-20210820
x86_64               randconfig-a011-20210820
i386                 randconfig-a011-20210820
i386                 randconfig-a016-20210820
i386                 randconfig-a012-20210820
i386                 randconfig-a014-20210820
i386                 randconfig-a013-20210820
i386                 randconfig-a015-20210820
i386                 randconfig-a015-20210818
i386                 randconfig-a011-20210818
i386                 randconfig-a013-20210818
i386                 randconfig-a014-20210818
i386                 randconfig-a016-20210818
i386                 randconfig-a012-20210818

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

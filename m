Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DF24624CD
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 23:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhK2W20 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 17:28:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:53884 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhK2W16 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 17:27:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="223316284"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="223316284"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 14:24:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="458604387"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 29 Nov 2021 14:24:22 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrp4P-000CQ7-CR; Mon, 29 Nov 2021 22:24:21 +0000
Date:   Tue, 30 Nov 2021 06:23:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [jberg-mac80211:master] BUILD SUCCESS WITH WARNING
 1eda919126b420fee6b8d546f7f728fbbd4b8f11
Message-ID: <61a552e7.I/DaJ4wJvKLaoKlD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
branch HEAD: 1eda919126b420fee6b8d546f7f728fbbd4b8f11  nl80211: reset regdom when reloading regdb

Warning reports:

https://lore.kernel.org/linux-wireless/202111292027.ZZFNfeUA-lkp@intel.com

Warning in current branch:

net/wireless/reg.c:1137:28: warning: implicit conversion from 'enum nl80211_user_reg_hint_type' to 'enum nl80211_reg_initiator' [-Wenum-conversion]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- alpha-allyesconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- arc-allyesconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- arc-buildonly-randconfig-r001-20211128
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- arc-randconfig-r036-20211128
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- arm-allmodconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- arm-allyesconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- arm-defconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- arm-exynos_defconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- arm-imx_v6_v7_defconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- arm-mvebu_v7_defconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- arm-omap2plus_defconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- arm-qcom_defconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- arm-randconfig-c023-20211128
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- arm-u8500_defconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- arm64-allyesconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- arm64-defconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- arm64-randconfig-r012-20211128
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- arm64-randconfig-r015-20211128
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- arm64-randconfig-r026-20211128
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- h8300-allyesconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- h8300-buildonly-randconfig-r005-20211128
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- ia64-allmodconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- ia64-allyesconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- ia64-buildonly-randconfig-r003-20211128
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- ia64-randconfig-c004-20211128
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- m68k-allmodconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- m68k-allyesconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- m68k-randconfig-r014-20211128
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- m68k-randconfig-r031-20211128
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- m68k-randconfig-r035-20211129
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- microblaze-allmodconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- microblaze-randconfig-r015-20211129
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- mips-allmodconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- mips-allyesconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- mips-gcw0_defconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- mips-maltaup_xpa_defconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- mips-randconfig-r005-20211128
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- nds32-allyesconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- nds32-randconfig-r004-20211128
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- nios2-allyesconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- nios2-randconfig-m031-20211128
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- nios2-randconfig-r025-20211128
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- openrisc-buildonly-randconfig-r006-20211129
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- openrisc-randconfig-r034-20211129
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- openrisc-randconfig-r035-20211129
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- parisc-allyesconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- parisc-randconfig-r003-20211128
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- parisc-randconfig-r026-20211129
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- parisc-randconfig-r033-20211129
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- parisc-randconfig-r034-20211129
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- powerpc-allmodconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- powerpc-allyesconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- riscv-allmodconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- riscv-allyesconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- sh-allmodconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- sh-randconfig-r013-20211129
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- sparc-allyesconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- sparc-randconfig-r024-20211129
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- sparc-randconfig-r036-20211129
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- sparc64-randconfig-r031-20211129
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- xtensa-allyesconfig
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
|-- xtensa-buildonly-randconfig-r006-20211128
|   `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator
`-- xtensa-randconfig-s032-20211128
    `-- net-wireless-reg.c:warning:implicit-conversion-from-enum-nl80211_user_reg_hint_type-to-enum-nl80211_reg_initiator

elapsed time: 723m

configs tested: 174
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211128
powerpc                   bluestone_defconfig
sh                          rsk7269_defconfig
sh                          sdk7780_defconfig
powerpc                   lite5200b_defconfig
powerpc                        warp_defconfig
s390                          debug_defconfig
arm                         axm55xx_defconfig
sh                             espt_defconfig
sh                        apsh4ad0a_defconfig
arm                     davinci_all_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                      cm5200_defconfig
mips                        qi_lb60_defconfig
sh                           se7619_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                        icon_defconfig
arm                              alldefconfig
sparc                               defconfig
mips                          rm200_defconfig
arm                        magician_defconfig
arm                          exynos_defconfig
ia64                            zx1_defconfig
mips                         tb0219_defconfig
arm                            qcom_defconfig
mips                           xway_defconfig
parisc                generic-64bit_defconfig
powerpc                      makalu_defconfig
arm                        mvebu_v7_defconfig
x86_64                              defconfig
arm                       versatile_defconfig
microblaze                      mmu_defconfig
arm                         orion5x_defconfig
mips                           ip22_defconfig
arm                       imx_v4_v5_defconfig
sh                                  defconfig
arm                         s3c6400_defconfig
powerpc                      ppc40x_defconfig
arm                      jornada720_defconfig
s390                       zfcpdump_defconfig
powerpc                    socrates_defconfig
riscv             nommu_k210_sdcard_defconfig
sparc                       sparc32_defconfig
mips                         cobalt_defconfig
sh                           se7722_defconfig
arc                                 defconfig
mips                        omega2p_defconfig
parisc                           allyesconfig
powerpc                     tqm8541_defconfig
i386                             alldefconfig
sh                           se7712_defconfig
mips                    maltaup_xpa_defconfig
mips                           ip32_defconfig
mips                           gcw0_defconfig
arm                       imx_v6_v7_defconfig
arm                           h5000_defconfig
mips                           rs90_defconfig
openrisc                            defconfig
arm                          pcm027_defconfig
mips                 decstation_r4k_defconfig
arm                       omap2plus_defconfig
mips                             allyesconfig
arm                          iop32x_defconfig
mips                          rb532_defconfig
powerpc                  iss476-smp_defconfig
arc                        vdk_hs38_defconfig
arm                         socfpga_defconfig
ia64                          tiger_defconfig
powerpc64                        alldefconfig
arm                         cm_x300_defconfig
powerpc                     ep8248e_defconfig
arm                         shannon_defconfig
sh                          rsk7203_defconfig
arm                           u8500_defconfig
arm                        cerfcube_defconfig
m68k                        m5272c3_defconfig
arm                  randconfig-c002-20211128
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20211129
i386                 randconfig-a002-20211129
i386                 randconfig-a006-20211129
i386                 randconfig-a005-20211129
i386                 randconfig-a004-20211129
i386                 randconfig-a003-20211129
x86_64               randconfig-a011-20211128
x86_64               randconfig-a012-20211128
x86_64               randconfig-a013-20211128
x86_64               randconfig-a015-20211128
x86_64               randconfig-a014-20211128
x86_64               randconfig-a016-20211128
i386                 randconfig-a015-20211128
i386                 randconfig-a016-20211128
i386                 randconfig-a013-20211128
i386                 randconfig-a012-20211128
i386                 randconfig-a014-20211128
i386                 randconfig-a011-20211128
arc                  randconfig-r043-20211128
s390                 randconfig-r044-20211128
riscv                randconfig-r042-20211128
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
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20211128
i386                 randconfig-c001-20211128
riscv                randconfig-c006-20211128
arm                  randconfig-c002-20211128
powerpc              randconfig-c003-20211128
x86_64               randconfig-c007-20211128
mips                 randconfig-c004-20211128
x86_64               randconfig-a001-20211128
x86_64               randconfig-a006-20211128
x86_64               randconfig-a003-20211128
x86_64               randconfig-a005-20211128
x86_64               randconfig-a004-20211128
x86_64               randconfig-a002-20211128
i386                 randconfig-a001-20211128
i386                 randconfig-a002-20211128
i386                 randconfig-a006-20211128
i386                 randconfig-a005-20211128
i386                 randconfig-a004-20211128
i386                 randconfig-a003-20211128
i386                 randconfig-a015-20211129
i386                 randconfig-a016-20211129
i386                 randconfig-a013-20211129
i386                 randconfig-a012-20211129
i386                 randconfig-a014-20211129
i386                 randconfig-a011-20211129
hexagon              randconfig-r045-20211129
hexagon              randconfig-r041-20211129
s390                 randconfig-r044-20211129
riscv                randconfig-r042-20211129

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB81A3EDEB6
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Aug 2021 22:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhHPUiT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Aug 2021 16:38:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:62341 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231594AbhHPUiS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Aug 2021 16:38:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="196202164"
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="196202164"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 13:37:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="510016410"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 16 Aug 2021 13:37:42 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mFjMb-000QwL-CJ; Mon, 16 Aug 2021 20:37:41 +0000
Date:   Tue, 17 Aug 2021 04:37:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 5f773519639041faed4132f5943d7895f9078a4c
Message-ID: <611acc77.eDXEKnvcqR8oz41b%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
branch HEAD: 5f773519639041faed4132f5943d7895f9078a4c  ice: Fix perout start time rounding

elapsed time: 4023m

configs tested: 207
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210814
i386                 randconfig-c001-20210816
powerpc                     mpc5200_defconfig
m68k                          hp300_defconfig
sh                        edosk7760_defconfig
powerpc                     asp8347_defconfig
arm                     am200epdkit_defconfig
m68k                          atari_defconfig
powerpc                     taishan_defconfig
arm                       versatile_defconfig
mips                         tb0226_defconfig
sh                          rsk7201_defconfig
openrisc                  or1klitex_defconfig
m68k                        m5407c3_defconfig
powerpc                    klondike_defconfig
mips                     loongson1c_defconfig
arm                          ep93xx_defconfig
arm                          iop32x_defconfig
powerpc                      ep88xc_defconfig
sh                   secureedge5410_defconfig
arm                        vexpress_defconfig
xtensa                          iss_defconfig
powerpc                   motionpro_defconfig
sh                          rsk7203_defconfig
powerpc                         wii_defconfig
powerpc                     skiroot_defconfig
powerpc64                        alldefconfig
arm                     davinci_all_defconfig
mips                        workpad_defconfig
arm                       omap2plus_defconfig
powerpc                     pq2fads_defconfig
mips                  maltasmvp_eva_defconfig
h8300                            alldefconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                 mpc834x_mds_defconfig
sh                        sh7757lcr_defconfig
xtensa                  nommu_kc705_defconfig
arm                      jornada720_defconfig
powerpc                         ps3_defconfig
powerpc                  mpc866_ads_defconfig
arm                         lpc18xx_defconfig
arm                         lubbock_defconfig
um                           x86_64_defconfig
powerpc                 mpc832x_mds_defconfig
mips                       lemote2f_defconfig
powerpc                   bluestone_defconfig
powerpc                     ep8248e_defconfig
parisc                generic-32bit_defconfig
arm                        neponset_defconfig
arm                          simpad_defconfig
powerpc                     tqm5200_defconfig
powerpc                      walnut_defconfig
mips                      bmips_stb_defconfig
sh                           se7619_defconfig
arm                         orion5x_defconfig
powerpc64                           defconfig
arc                              alldefconfig
mips                          ath79_defconfig
xtensa                           allyesconfig
arm                       imx_v4_v5_defconfig
powerpc                     rainier_defconfig
sh                            shmin_defconfig
h8300                               defconfig
sh                          rsk7269_defconfig
ia64                          tiger_defconfig
arm                             rpc_defconfig
powerpc                      ppc40x_defconfig
sh                           se7750_defconfig
powerpc                    socrates_defconfig
riscv                             allnoconfig
powerpc                     ksi8560_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                       maple_defconfig
mips                           rs90_defconfig
s390                       zfcpdump_defconfig
powerpc                    mvme5100_defconfig
powerpc                     sbc8548_defconfig
arm                        mini2440_defconfig
h8300                       h8s-sim_defconfig
arm                       aspeed_g4_defconfig
sh                  sh7785lcr_32bit_defconfig
xtensa                         virt_defconfig
ia64                        generic_defconfig
sh                        dreamcast_defconfig
arm                         nhk8815_defconfig
m68k                       bvme6000_defconfig
powerpc                   currituck_defconfig
sh                                  defconfig
arm                           corgi_defconfig
arm                           omap1_defconfig
sh                           sh2007_defconfig
powerpc                      ppc44x_defconfig
mips                         tb0287_defconfig
arm                           viper_defconfig
arm                          collie_defconfig
mips                         bigsur_defconfig
mips                     cu1830-neo_defconfig
powerpc                 canyonlands_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     kilauea_defconfig
arm                            zeus_defconfig
i386                             alldefconfig
powerpc                      pcm030_defconfig
openrisc                            defconfig
arm                           tegra_defconfig
arm                         s3c2410_defconfig
sh                   sh7724_generic_defconfig
sh                          sdk7780_defconfig
sh                         apsh4a3a_defconfig
x86_64                            allnoconfig
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
x86_64               randconfig-a004-20210814
x86_64               randconfig-a006-20210814
x86_64               randconfig-a003-20210814
x86_64               randconfig-a001-20210814
x86_64               randconfig-a005-20210814
x86_64               randconfig-a002-20210814
i386                 randconfig-a004-20210816
i386                 randconfig-a003-20210816
i386                 randconfig-a002-20210816
i386                 randconfig-a001-20210816
i386                 randconfig-a006-20210816
i386                 randconfig-a005-20210816
i386                 randconfig-a004-20210814
i386                 randconfig-a002-20210814
i386                 randconfig-a001-20210814
i386                 randconfig-a003-20210814
i386                 randconfig-a006-20210814
i386                 randconfig-a005-20210814
i386                 randconfig-a011-20210814
i386                 randconfig-a015-20210814
i386                 randconfig-a013-20210814
i386                 randconfig-a014-20210814
i386                 randconfig-a016-20210814
i386                 randconfig-a012-20210814
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210814
i386                 randconfig-c001-20210816
x86_64               randconfig-a013-20210814
x86_64               randconfig-a011-20210814
x86_64               randconfig-a016-20210814
x86_64               randconfig-a012-20210814
x86_64               randconfig-a014-20210814
x86_64               randconfig-a015-20210814
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

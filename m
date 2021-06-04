Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8595A39B0D7
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jun 2021 05:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhFDDZc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Jun 2021 23:25:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:8027 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhFDDZc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Jun 2021 23:25:32 -0400
IronPort-SDR: mvMLMtvYF+jyRWMp8GqK9RQTyDIPiA+sGMZBlcMAd9VTvLgOXsR5lDzmmKhDT1muF6bUrm02Nc
 Swv4RIt3H7pA==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="204238794"
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; 
   d="scan'208";a="204238794"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 20:23:46 -0700
IronPort-SDR: HvJHFhDfwSAewaGaEuoKJhRjdMCmND/zb7i3P3N1HROHcnYDgK/18WQL+ORMF63iORfUIWl3ts
 dZ8v+enQLftQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; 
   d="scan'208";a="550936590"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jun 2021 20:23:43 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lp0Qx-0006dE-AE; Fri, 04 Jun 2021 03:23:43 +0000
Date:   Fri, 04 Jun 2021 11:22:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 080f9c10c773df39ccebe8dc414179d9179005a9
Message-ID: <60b99c82.9jx7xT0DOmav3URJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: 080f9c10c773df39ccebe8dc414179d9179005a9  ipw2x00: Minor documentation update

elapsed time: 1046m

configs tested: 196
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                           ip27_defconfig
powerpc                      pasemi_defconfig
m68k                       m5249evb_defconfig
arm                         lpc32xx_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      obs600_defconfig
mips                           jazz_defconfig
xtensa                    smp_lx200_defconfig
arm                          collie_defconfig
sh                         ap325rxa_defconfig
sh                         apsh4a3a_defconfig
arc                         haps_hs_defconfig
arm                         mv78xx0_defconfig
sh                         ecovec24_defconfig
arc                                 defconfig
powerpc                    amigaone_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                   sh7770_generic_defconfig
m68k                       m5275evb_defconfig
powerpc                 mpc836x_mds_defconfig
m68k                        m5407c3_defconfig
m68k                        mvme16x_defconfig
arc                    vdk_hs38_smp_defconfig
um                                  defconfig
powerpc                      katmai_defconfig
mips                         mpc30x_defconfig
powerpc                      acadia_defconfig
powerpc64                        alldefconfig
arc                     nsimosci_hs_defconfig
m68k                             alldefconfig
arm                         lpc18xx_defconfig
arc                      axs103_smp_defconfig
sh                        dreamcast_defconfig
sh                          r7780mp_defconfig
arm                           h3600_defconfig
arm                            mps2_defconfig
arc                          axs103_defconfig
arm                         s3c6400_defconfig
sparc                       sparc32_defconfig
powerpc                     tqm8540_defconfig
sh                               alldefconfig
powerpc                     sbc8548_defconfig
arm                       netwinder_defconfig
mips                           rs90_defconfig
m68k                         amcore_defconfig
arm                        cerfcube_defconfig
powerpc                 canyonlands_defconfig
nios2                         3c120_defconfig
powerpc                      pcm030_defconfig
powerpc                   lite5200b_defconfig
arm                           u8500_defconfig
powerpc                 mpc8272_ads_defconfig
mips                            ar7_defconfig
powerpc                        cell_defconfig
mips                        bcm63xx_defconfig
powerpc                      walnut_defconfig
mips                      pic32mzda_defconfig
mips                malta_qemu_32r6_defconfig
arm                        neponset_defconfig
powerpc                      tqm8xx_defconfig
sh                          urquell_defconfig
powerpc                      cm5200_defconfig
arm                  colibri_pxa270_defconfig
sh                            hp6xx_defconfig
um                            kunit_defconfig
m68k                            q40_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     skiroot_defconfig
sh                   rts7751r2dplus_defconfig
mips                           mtx1_defconfig
sh                           se7712_defconfig
powerpc                     rainier_defconfig
arm                         orion5x_defconfig
arm                         axm55xx_defconfig
sh                             espt_defconfig
powerpc                     mpc5200_defconfig
powerpc                 mpc834x_itx_defconfig
arm                           stm32_defconfig
powerpc                 mpc85xx_cds_defconfig
riscv                    nommu_virt_defconfig
mips                  cavium_octeon_defconfig
powerpc                  storcenter_defconfig
arm                         palmz72_defconfig
mips                          rb532_defconfig
powerpc                    sam440ep_defconfig
arm                         s5pv210_defconfig
sh                          lboxre2_defconfig
arm                           h5000_defconfig
arm                           tegra_defconfig
sh                              ul2_defconfig
mips                         tb0219_defconfig
mips                     loongson2k_defconfig
arc                              alldefconfig
mips                      pistachio_defconfig
sh                        sh7757lcr_defconfig
ia64                          tiger_defconfig
arm                         lubbock_defconfig
powerpc                     mpc512x_defconfig
mips                       lemote2f_defconfig
arm                         shannon_defconfig
powerpc                     tqm8541_defconfig
sh                        sh7785lcr_defconfig
mips                       bmips_be_defconfig
arm                          simpad_defconfig
powerpc                      bamboo_defconfig
powerpc                       ppc64_defconfig
arc                        nsimosci_defconfig
arm                    vt8500_v6_v7_defconfig
arm                          moxart_defconfig
sh                        edosk7705_defconfig
xtensa                  nommu_kc705_defconfig
arm                       mainstone_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                           se7721_defconfig
powerpc                         ps3_defconfig
sh                           se7206_defconfig
powerpc                    gamecube_defconfig
mips                      maltasmvp_defconfig
m68k                        stmark2_defconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
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
i386                 randconfig-a003-20210603
i386                 randconfig-a006-20210603
i386                 randconfig-a004-20210603
i386                 randconfig-a001-20210603
i386                 randconfig-a002-20210603
i386                 randconfig-a005-20210603
x86_64               randconfig-a015-20210603
x86_64               randconfig-a011-20210603
x86_64               randconfig-a012-20210603
x86_64               randconfig-a014-20210603
x86_64               randconfig-a016-20210603
x86_64               randconfig-a013-20210603
i386                 randconfig-a015-20210603
i386                 randconfig-a013-20210603
i386                 randconfig-a011-20210603
i386                 randconfig-a016-20210603
i386                 randconfig-a014-20210603
i386                 randconfig-a012-20210603
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210603
x86_64               randconfig-b001-20210604
x86_64               randconfig-a002-20210603
x86_64               randconfig-a004-20210603
x86_64               randconfig-a003-20210603
x86_64               randconfig-a006-20210603
x86_64               randconfig-a005-20210603
x86_64               randconfig-a001-20210603

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

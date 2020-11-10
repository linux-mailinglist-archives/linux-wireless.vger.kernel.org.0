Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F242AE1ED
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 22:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbgKJVks (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 16:40:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:64175 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731657AbgKJVjc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 16:39:32 -0500
IronPort-SDR: g80d9TjN1dg2cH7qQ8x5/TSs5nyHHVgvN8NwsunzR6oawOl9BFcq/Ctg3FdKPDHLKqHNtfMAaA
 JWkgqdR0Zj5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="167469955"
X-IronPort-AV: E=Sophos;i="5.77,467,1596524400"; 
   d="scan'208";a="167469955"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 13:39:30 -0800
IronPort-SDR: JsmywJGJB9skr0rVLoNhoxruBC7wSU6F9CySl+SzEOD/rI6VhxJ+XKdLvQwh9I3f3ch7HohL20
 CPKeBjPq6ecg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,467,1596524400"; 
   d="scan'208";a="365670215"
Received: from lkp-server02.sh.intel.com (HELO c6c5fbb3488a) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Nov 2020 13:39:29 -0800
Received: from kbuild by c6c5fbb3488a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kcbMO-0000SN-O1; Tue, 10 Nov 2020 21:39:28 +0000
Date:   Wed, 11 Nov 2020 05:38:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 989ef49bdf100cc772b3a8737089df36b1ab1e30
Message-ID: <5fab0854.BaFizqsLGRr62NfB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git  master
branch HEAD: 989ef49bdf100cc772b3a8737089df36b1ab1e30  mptcp: provide rmem[0] limit

elapsed time: 1176m

configs tested: 202
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                        fsp2_defconfig
powerpc                      bamboo_defconfig
arm                         lpc32xx_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                           tegra_defconfig
arm                        multi_v7_defconfig
m68k                       m5208evb_defconfig
arm                           sama5_defconfig
arm                            lart_defconfig
mips                           jazz_defconfig
sh                          r7785rp_defconfig
mips                       rbtx49xx_defconfig
arm                       aspeed_g4_defconfig
sh                   sh7724_generic_defconfig
mips                malta_qemu_32r6_defconfig
sh                          lboxre2_defconfig
arm                         cm_x300_defconfig
arm                            mps2_defconfig
sh                        sh7757lcr_defconfig
c6x                        evmc6474_defconfig
mips                         tb0287_defconfig
m68k                             alldefconfig
powerpc                      arches_defconfig
powerpc                     rainier_defconfig
mips                       lemote2f_defconfig
sh                           se7750_defconfig
mips                           gcw0_defconfig
sh                          polaris_defconfig
powerpc                 mpc832x_mds_defconfig
csky                             alldefconfig
sh                     sh7710voipgw_defconfig
arm                         shannon_defconfig
powerpc                  mpc866_ads_defconfig
mips                         bigsur_defconfig
sh                           se7705_defconfig
c6x                                 defconfig
powerpc                     kilauea_defconfig
arm                        mvebu_v5_defconfig
arm                             rpc_defconfig
arm                        realview_defconfig
arc                        nsim_700_defconfig
sh                          rsk7201_defconfig
powerpc                      mgcoge_defconfig
x86_64                           alldefconfig
mips                        qi_lb60_defconfig
m68k                       m5275evb_defconfig
h8300                               defconfig
powerpc                   motionpro_defconfig
arm                          moxart_defconfig
powerpc                          g5_defconfig
mips                           ip22_defconfig
arm                      jornada720_defconfig
arm                            zeus_defconfig
arc                 nsimosci_hs_smp_defconfig
sparc64                             defconfig
arm                          badge4_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
powerpc                    socrates_defconfig
xtensa                           alldefconfig
arm                             ezx_defconfig
mips                         tb0226_defconfig
h8300                    h8300h-sim_defconfig
arm                        neponset_defconfig
powerpc                     mpc512x_defconfig
arm                       omap2plus_defconfig
mips                  maltasmvp_eva_defconfig
arm                        vexpress_defconfig
m68k                                defconfig
powerpc                       maple_defconfig
sh                               alldefconfig
sh                ecovec24-romimage_defconfig
m68k                         amcore_defconfig
powerpc                      katmai_defconfig
sh                   sh7770_generic_defconfig
arc                          axs101_defconfig
arm                         at91_dt_defconfig
arm                           u8500_defconfig
m68k                            q40_defconfig
sh                        edosk7760_defconfig
xtensa                       common_defconfig
mips                           ip28_defconfig
powerpc                   bluestone_defconfig
powerpc64                           defconfig
arm                          simpad_defconfig
mips                        bcm63xx_defconfig
mips                         rt305x_defconfig
nios2                         3c120_defconfig
arm                        keystone_defconfig
powerpc                    gamecube_defconfig
sh                           se7343_defconfig
mips                           ip32_defconfig
arm                           corgi_defconfig
mips                     loongson1b_defconfig
arm                   milbeaut_m10v_defconfig
sh                      rts7751r2d1_defconfig
powerpc                     ep8248e_defconfig
powerpc                     asp8347_defconfig
mips                        nlm_xlr_defconfig
arm                        multi_v5_defconfig
powerpc                     stx_gp3_defconfig
powerpc                    amigaone_defconfig
powerpc                    klondike_defconfig
mips                            ar7_defconfig
mips                   sb1250_swarm_defconfig
arm                        cerfcube_defconfig
arm                          exynos_defconfig
sh                        dreamcast_defconfig
openrisc                    or1ksim_defconfig
powerpc                 mpc836x_mds_defconfig
sparc                               defconfig
arm                       versatile_defconfig
arm                  colibri_pxa270_defconfig
microblaze                          defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      ppc44x_defconfig
sh                          rsk7203_defconfig
arm                       cns3420vb_defconfig
arm                           omap1_defconfig
c6x                        evmc6472_defconfig
arm                          ixp4xx_defconfig
m68k                       bvme6000_defconfig
arm                       spear13xx_defconfig
sh                          urquell_defconfig
powerpc                     sequoia_defconfig
powerpc                     tqm8548_defconfig
sh                            hp6xx_defconfig
m68k                       m5475evb_defconfig
m68k                          atari_defconfig
arm                            hisi_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
i386                                defconfig
sparc                            allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20201110
x86_64               randconfig-a005-20201110
x86_64               randconfig-a004-20201110
x86_64               randconfig-a002-20201110
x86_64               randconfig-a006-20201110
x86_64               randconfig-a001-20201110
i386                 randconfig-a006-20201110
i386                 randconfig-a005-20201110
i386                 randconfig-a002-20201110
i386                 randconfig-a001-20201110
i386                 randconfig-a003-20201110
i386                 randconfig-a004-20201110
i386                 randconfig-a012-20201110
i386                 randconfig-a014-20201110
i386                 randconfig-a016-20201110
i386                 randconfig-a011-20201110
i386                 randconfig-a015-20201110
i386                 randconfig-a013-20201110
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
x86_64               randconfig-a015-20201110
x86_64               randconfig-a011-20201110
x86_64               randconfig-a014-20201110
x86_64               randconfig-a013-20201110
x86_64               randconfig-a016-20201110
x86_64               randconfig-a012-20201110

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

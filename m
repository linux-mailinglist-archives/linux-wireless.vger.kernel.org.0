Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A643E5E12
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Aug 2021 16:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbhHJOfX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Aug 2021 10:35:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:13183 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240697AbhHJOfW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Aug 2021 10:35:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="236925618"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="236925618"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 07:34:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="506162694"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 10 Aug 2021 07:34:54 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mDSqE-000Ke8-1y; Tue, 10 Aug 2021 14:34:54 +0000
Date:   Tue, 10 Aug 2021 22:34:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 d249ff28b1d8478419caf347c4836361a47b0c5b
Message-ID: <61128e5b.7tMuwDNyBW9FE2UD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: d249ff28b1d8478419caf347c4836361a47b0c5b  intersil: remove obsolete prism54 wireless driver

elapsed time: 6062m

configs tested: 302
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210804
i386                 randconfig-c001-20210805
i386                 randconfig-c001-20210807
h8300                       h8s-sim_defconfig
arm                       mainstone_defconfig
arm                            pleb_defconfig
powerpc                 mpc832x_mds_defconfig
sh                            titan_defconfig
powerpc                           allnoconfig
arm                       aspeed_g4_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                      mgcoge_defconfig
nios2                         10m50_defconfig
powerpc                      walnut_defconfig
arm                            xcep_defconfig
mips                        nlm_xlp_defconfig
sh                           se7721_defconfig
sparc                       sparc64_defconfig
sh                            migor_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                              alldefconfig
powerpc                 mpc832x_rdb_defconfig
nios2                            allyesconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                     ep8248e_defconfig
mips                        qi_lb60_defconfig
arm                          exynos_defconfig
mips                           ip27_defconfig
arm                      tct_hammer_defconfig
powerpc                         wii_defconfig
openrisc                    or1ksim_defconfig
arm                         nhk8815_defconfig
mips                malta_qemu_32r6_defconfig
sparc                            alldefconfig
riscv                             allnoconfig
powerpc                 mpc8272_ads_defconfig
powerpc                      obs600_defconfig
m68k                         amcore_defconfig
powerpc                      ppc64e_defconfig
powerpc                   microwatt_defconfig
ia64                             allmodconfig
arc                                 defconfig
mips                     loongson1b_defconfig
arm                           sama5_defconfig
sh                     sh7710voipgw_defconfig
arc                    vdk_hs38_smp_defconfig
arc                        nsim_700_defconfig
arm                          imote2_defconfig
h8300                     edosk2674_defconfig
sh                          r7785rp_defconfig
powerpc                     ksi8560_defconfig
sh                        edosk7705_defconfig
xtensa                           allyesconfig
arm                          moxart_defconfig
mips                           jazz_defconfig
powerpc                      arches_defconfig
microblaze                          defconfig
arm                         socfpga_defconfig
parisc                              defconfig
arm                       aspeed_g5_defconfig
arm                            dove_defconfig
xtensa                           alldefconfig
m68k                       m5475evb_defconfig
powerpc                      ppc44x_defconfig
arm                       imx_v4_v5_defconfig
arm                         axm55xx_defconfig
powerpc                     tqm5200_defconfig
sh                        sh7763rdp_defconfig
h8300                    h8300h-sim_defconfig
arm                         lpc18xx_defconfig
powerpc                     taishan_defconfig
arm                        keystone_defconfig
x86_64                            allnoconfig
sh                          rsk7264_defconfig
sh                   rts7751r2dplus_defconfig
mips                           xway_defconfig
mips                    maltaup_xpa_defconfig
arm                         lpc32xx_defconfig
sh                              ul2_defconfig
mips                      maltasmvp_defconfig
riscv                            alldefconfig
mips                        jmr3927_defconfig
m68k                       bvme6000_defconfig
arm                       imx_v6_v7_defconfig
ia64                        generic_defconfig
mips                        bcm47xx_defconfig
powerpc                    klondike_defconfig
i386                                defconfig
sh                           se7343_defconfig
sh                 kfr2r09-romimage_defconfig
arm                           h3600_defconfig
arm                           omap1_defconfig
arm                       multi_v4t_defconfig
arm                          pxa168_defconfig
mips                         tb0287_defconfig
arm64                            alldefconfig
arc                            hsdk_defconfig
powerpc                    sam440ep_defconfig
powerpc                       ebony_defconfig
sh                   secureedge5410_defconfig
m68k                        m5307c3_defconfig
powerpc                        fsp2_defconfig
arm                      footbridge_defconfig
arm                           spitz_defconfig
powerpc                     stx_gp3_defconfig
mips                           ip28_defconfig
sh                           se7722_defconfig
sh                               j2_defconfig
s390                                defconfig
powerpc                     tqm8555_defconfig
powerpc                      tqm8xx_defconfig
mips                           gcw0_defconfig
powerpc                     pq2fads_defconfig
mips                        omega2p_defconfig
arm                          collie_defconfig
powerpc                     tqm8541_defconfig
sh                          rsk7203_defconfig
xtensa                       common_defconfig
arm                          gemini_defconfig
mips                       bmips_be_defconfig
parisc                           allyesconfig
mips                     loongson2k_defconfig
mips                      fuloong2e_defconfig
powerpc                       maple_defconfig
mips                     cu1000-neo_defconfig
powerpc                     asp8347_defconfig
s390                             alldefconfig
arm                       cns3420vb_defconfig
powerpc                 canyonlands_defconfig
powerpc                      ep88xc_defconfig
powerpc64                           defconfig
m68k                        stmark2_defconfig
sh                          rsk7201_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                        edosk7760_defconfig
arm                           tegra_defconfig
sh                           se7724_defconfig
powerpc                      ppc40x_defconfig
powerpc                        cell_defconfig
m68k                                defconfig
csky                                defconfig
arm                     am200epdkit_defconfig
powerpc                          allmodconfig
arm                      jornada720_defconfig
powerpc                 linkstation_defconfig
mips                             allyesconfig
powerpc                     rainier_defconfig
um                                  defconfig
sh                     magicpanelr2_defconfig
powerpc                  mpc885_ads_defconfig
mips                          rb532_defconfig
arm                       spear13xx_defconfig
sh                          urquell_defconfig
mips                     loongson1c_defconfig
powerpc                       holly_defconfig
xtensa                         virt_defconfig
powerpc                   lite5200b_defconfig
mips                          ath25_defconfig
sh                           sh2007_defconfig
arm                           viper_defconfig
powerpc                          allyesconfig
arm                          pcm027_defconfig
xtensa                  audio_kc705_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allmodconfig
x86_64               randconfig-a002-20210805
x86_64               randconfig-a006-20210805
x86_64               randconfig-a004-20210805
x86_64               randconfig-a003-20210805
x86_64               randconfig-a001-20210805
x86_64               randconfig-a005-20210805
i386                 randconfig-a004-20210808
i386                 randconfig-a005-20210808
i386                 randconfig-a006-20210808
i386                 randconfig-a002-20210808
i386                 randconfig-a001-20210808
i386                 randconfig-a003-20210808
i386                 randconfig-a005-20210804
i386                 randconfig-a004-20210804
i386                 randconfig-a002-20210804
i386                 randconfig-a006-20210804
i386                 randconfig-a003-20210804
i386                 randconfig-a001-20210804
i386                 randconfig-a005-20210805
i386                 randconfig-a004-20210805
i386                 randconfig-a002-20210805
i386                 randconfig-a006-20210805
i386                 randconfig-a003-20210805
i386                 randconfig-a001-20210805
i386                 randconfig-a005-20210806
i386                 randconfig-a004-20210806
i386                 randconfig-a002-20210806
i386                 randconfig-a006-20210806
i386                 randconfig-a003-20210806
i386                 randconfig-a001-20210806
x86_64               randconfig-a012-20210804
x86_64               randconfig-a016-20210804
x86_64               randconfig-a011-20210804
x86_64               randconfig-a013-20210804
x86_64               randconfig-a014-20210804
x86_64               randconfig-a015-20210804
x86_64               randconfig-a016-20210808
x86_64               randconfig-a012-20210808
x86_64               randconfig-a013-20210808
x86_64               randconfig-a011-20210808
x86_64               randconfig-a014-20210808
x86_64               randconfig-a015-20210808
i386                 randconfig-a012-20210808
i386                 randconfig-a015-20210808
i386                 randconfig-a011-20210808
i386                 randconfig-a013-20210808
i386                 randconfig-a014-20210808
i386                 randconfig-a016-20210808
i386                 randconfig-a012-20210806
i386                 randconfig-a011-20210806
i386                 randconfig-a015-20210806
i386                 randconfig-a013-20210806
i386                 randconfig-a014-20210806
i386                 randconfig-a016-20210806
i386                 randconfig-a012-20210807
i386                 randconfig-a011-20210807
i386                 randconfig-a015-20210807
i386                 randconfig-a013-20210807
i386                 randconfig-a014-20210807
i386                 randconfig-a016-20210807
i386                 randconfig-a012-20210805
i386                 randconfig-a011-20210805
i386                 randconfig-a015-20210805
i386                 randconfig-a013-20210805
i386                 randconfig-a014-20210805
i386                 randconfig-a016-20210805
i386                 randconfig-a012-20210804
i386                 randconfig-a011-20210804
i386                 randconfig-a015-20210804
i386                 randconfig-a013-20210804
i386                 randconfig-a014-20210804
i386                 randconfig-a016-20210804
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210804
x86_64               randconfig-c001-20210808
x86_64               randconfig-c001-20210805
x86_64               randconfig-c001-20210809
x86_64               randconfig-c001-20210807
x86_64               randconfig-c001-20210806
x86_64               randconfig-a002-20210804
x86_64               randconfig-a006-20210804
x86_64               randconfig-a004-20210804
x86_64               randconfig-a003-20210804
x86_64               randconfig-a001-20210804
x86_64               randconfig-a005-20210804
x86_64               randconfig-a002-20210808
x86_64               randconfig-a004-20210808
x86_64               randconfig-a006-20210808
x86_64               randconfig-a003-20210808
x86_64               randconfig-a001-20210808
x86_64               randconfig-a005-20210808
x86_64               randconfig-a016-20210809
x86_64               randconfig-a012-20210809
x86_64               randconfig-a013-20210809
x86_64               randconfig-a011-20210809
x86_64               randconfig-a014-20210809
x86_64               randconfig-a015-20210809
x86_64               randconfig-a012-20210805
x86_64               randconfig-a016-20210805
x86_64               randconfig-a011-20210805
x86_64               randconfig-a013-20210805
x86_64               randconfig-a014-20210805
x86_64               randconfig-a015-20210805

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

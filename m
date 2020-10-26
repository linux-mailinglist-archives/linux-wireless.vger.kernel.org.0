Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735AA29995B
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Oct 2020 23:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392226AbgJZWKy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Oct 2020 18:10:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:2082 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392164AbgJZWKx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Oct 2020 18:10:53 -0400
IronPort-SDR: 1e9d5MkJMDgr39geUoG/2RJgPcREYI5NlwvB/o+3nJmdX7bibCX1OMcwPM3PGNInxe2WeEWNKw
 WhWU933TYMHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="185725794"
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="185725794"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 15:10:53 -0700
IronPort-SDR: O+w139QRkQTKPWxuQpoVcAKrADLJJB1BgawgtcIzB3gbNrba8yjwVwayrqg/JqjQjENFupBelA
 QgR4uyibZxzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="318012826"
Received: from lkp-server01.sh.intel.com (HELO ca9e3ad0a302) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Oct 2020 15:10:51 -0700
Received: from kbuild by ca9e3ad0a302 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kXAhW-0000B1-Bq; Mon, 26 Oct 2020 22:10:50 +0000
Date:   Tue, 27 Oct 2020 06:10:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 435ccfa894e35e3d4a1799e6ac030e48a7b69ef5
Message-ID: <5f974951.fEeO9vJcAGNqHLCA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git  master
branch HEAD: 435ccfa894e35e3d4a1799e6ac030e48a7b69ef5  tcp: Prevent low rmem stalls with SO_RCVLOWAT.

elapsed time: 4004m

configs tested: 297
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                            zeus_defconfig
arm                         ebsa110_defconfig
arm                        shmobile_defconfig
sparc                            allyesconfig
powerpc                     sequoia_defconfig
h8300                       h8s-sim_defconfig
arm                             pxa_defconfig
arm                           h3600_defconfig
arc                         haps_hs_defconfig
mips                        nlm_xlr_defconfig
arm                          moxart_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                        fsp2_defconfig
arm                     davinci_all_defconfig
powerpc                       maple_defconfig
arm                           omap1_defconfig
powerpc                       holly_defconfig
m68k                        mvme147_defconfig
powerpc                     mpc83xx_defconfig
h8300                     edosk2674_defconfig
sh                         ap325rxa_defconfig
parisc                              defconfig
arc                          axs103_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                          g5_defconfig
arm                         s5pv210_defconfig
powerpc                     tqm8548_defconfig
arm                         orion5x_defconfig
mips                         tb0287_defconfig
arm                              zx_defconfig
mips                           rs90_defconfig
arm                        keystone_defconfig
mips                           gcw0_defconfig
arm                          ixp4xx_defconfig
mips                         cobalt_defconfig
sh                           se7705_defconfig
arm                        spear6xx_defconfig
mips                          malta_defconfig
alpha                               defconfig
arm                         mv78xx0_defconfig
m68k                          atari_defconfig
arm                           stm32_defconfig
alpha                            allyesconfig
arm                            dove_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                        bcm63xx_defconfig
powerpc                     tqm8541_defconfig
mips                    maltaup_xpa_defconfig
powerpc                       eiger_defconfig
mips                          ath25_defconfig
powerpc                     tqm8560_defconfig
sh                   secureedge5410_defconfig
mips                       rbtx49xx_defconfig
sh                     sh7710voipgw_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         hackkit_defconfig
c6x                        evmc6457_defconfig
powerpc               mpc834x_itxgp_defconfig
ia64                        generic_defconfig
sh                           se7751_defconfig
powerpc                      obs600_defconfig
m68k                          sun3x_defconfig
arm                      integrator_defconfig
sh                          r7785rp_defconfig
sh                              ul2_defconfig
s390                       zfcpdump_defconfig
mips                malta_kvm_guest_defconfig
m68k                       m5249evb_defconfig
sh                           se7619_defconfig
sh                            hp6xx_defconfig
mips                        workpad_defconfig
m68k                         amcore_defconfig
arm                          badge4_defconfig
powerpc                     stx_gp3_defconfig
ia64                                defconfig
powerpc                 mpc836x_rdk_defconfig
mips                malta_qemu_32r6_defconfig
sh                          rsk7264_defconfig
riscv                            allyesconfig
powerpc                     sbc8548_defconfig
arm                          exynos_defconfig
m68k                        mvme16x_defconfig
arm                             rpc_defconfig
arc                           tb10x_defconfig
arm                         palmz72_defconfig
arm                         assabet_defconfig
mips                         db1xxx_defconfig
mips                       bmips_be_defconfig
h8300                    h8300h-sim_defconfig
powerpc                      pmac32_defconfig
nios2                         3c120_defconfig
arm                           tegra_defconfig
arm                          lpd270_defconfig
nios2                         10m50_defconfig
mips                     decstation_defconfig
arm                       aspeed_g5_defconfig
arm                        realview_defconfig
mips                          ath79_defconfig
xtensa                         virt_defconfig
powerpc                 linkstation_defconfig
mips                      bmips_stb_defconfig
parisc                generic-32bit_defconfig
arm                          simpad_defconfig
arm                  colibri_pxa300_defconfig
sparc64                             defconfig
mips                         tb0226_defconfig
powerpc                     tqm8540_defconfig
arm                          collie_defconfig
arc                                 defconfig
sh                   sh7724_generic_defconfig
sh                          kfr2r09_defconfig
arm                       multi_v4t_defconfig
arm                              alldefconfig
arm                         shannon_defconfig
nds32                               defconfig
arm                         s3c6400_defconfig
sh                            shmin_defconfig
m68k                         apollo_defconfig
sh                             shx3_defconfig
powerpc                      makalu_defconfig
mips                           ip28_defconfig
c6x                        evmc6678_defconfig
m68k                       m5275evb_defconfig
sh                             espt_defconfig
arm                          iop32x_defconfig
xtensa                              defconfig
arm                        multi_v7_defconfig
xtensa                  nommu_kc705_defconfig
arc                          axs101_defconfig
c6x                                 defconfig
sh                               j2_defconfig
mips                            gpr_defconfig
sh                            migor_defconfig
arm                       omap2plus_defconfig
arm                          pxa910_defconfig
arm                         socfpga_defconfig
sh                        sh7763rdp_defconfig
arm                        mini2440_defconfig
arm                           spitz_defconfig
m68k                          multi_defconfig
arm                      jornada720_defconfig
m68k                        m5407c3_defconfig
powerpc                     pseries_defconfig
m68k                        m5272c3_defconfig
x86_64                           allyesconfig
powerpc                      walnut_defconfig
c6x                        evmc6472_defconfig
mips                        nlm_xlp_defconfig
arc                        nsimosci_defconfig
sh                           se7780_defconfig
m68k                        m5307c3_defconfig
powerpc64                        alldefconfig
arm                          imote2_defconfig
xtensa                generic_kc705_defconfig
sh                          polaris_defconfig
powerpc                      ep88xc_defconfig
sh                          rsk7269_defconfig
m68k                       bvme6000_defconfig
mips                      pistachio_defconfig
arm                            lart_defconfig
m68k                             allmodconfig
powerpc                 mpc834x_mds_defconfig
um                            kunit_defconfig
sh                          r7780mp_defconfig
riscv                            alldefconfig
xtensa                          iss_defconfig
mips                           ip22_defconfig
sh                        edosk7705_defconfig
arm                         cm_x300_defconfig
powerpc                     rainier_defconfig
arm                         lpc18xx_defconfig
mips                          rm200_defconfig
sparc                       sparc64_defconfig
sh                   sh7770_generic_defconfig
sparc                       sparc32_defconfig
sh                             sh03_defconfig
powerpc                      ppc6xx_defconfig
sparc64                          alldefconfig
arm                        magician_defconfig
arm                             ezx_defconfig
mips                      fuloong2e_defconfig
powerpc                       ebony_defconfig
mips                        qi_lb60_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                           allyesconfig
powerpc                      ppc40x_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
h8300                            allyesconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20201024
i386                 randconfig-a003-20201024
i386                 randconfig-a005-20201024
i386                 randconfig-a001-20201024
i386                 randconfig-a006-20201024
i386                 randconfig-a004-20201024
i386                 randconfig-a002-20201026
i386                 randconfig-a003-20201026
i386                 randconfig-a005-20201026
i386                 randconfig-a001-20201026
i386                 randconfig-a006-20201026
i386                 randconfig-a004-20201026
i386                 randconfig-a002-20201023
i386                 randconfig-a005-20201023
i386                 randconfig-a003-20201023
i386                 randconfig-a001-20201023
i386                 randconfig-a006-20201023
i386                 randconfig-a004-20201023
x86_64               randconfig-a011-20201024
x86_64               randconfig-a013-20201024
x86_64               randconfig-a016-20201024
x86_64               randconfig-a015-20201024
x86_64               randconfig-a012-20201024
x86_64               randconfig-a014-20201024
x86_64               randconfig-a011-20201026
x86_64               randconfig-a013-20201026
x86_64               randconfig-a016-20201026
x86_64               randconfig-a015-20201026
x86_64               randconfig-a012-20201026
x86_64               randconfig-a014-20201026
i386                 randconfig-a016-20201026
i386                 randconfig-a015-20201026
i386                 randconfig-a014-20201026
i386                 randconfig-a012-20201026
i386                 randconfig-a013-20201026
i386                 randconfig-a011-20201026
i386                 randconfig-a016-20201022
i386                 randconfig-a014-20201022
i386                 randconfig-a015-20201022
i386                 randconfig-a012-20201022
i386                 randconfig-a013-20201022
i386                 randconfig-a011-20201022
i386                 randconfig-a016-20201024
i386                 randconfig-a015-20201024
i386                 randconfig-a014-20201024
i386                 randconfig-a013-20201024
i386                 randconfig-a012-20201024
i386                 randconfig-a011-20201024
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20201026
x86_64               randconfig-a003-20201026
x86_64               randconfig-a002-20201026
x86_64               randconfig-a006-20201026
x86_64               randconfig-a004-20201026
x86_64               randconfig-a005-20201026
x86_64               randconfig-a001-20201022
x86_64               randconfig-a002-20201022
x86_64               randconfig-a003-20201022
x86_64               randconfig-a006-20201022
x86_64               randconfig-a004-20201022
x86_64               randconfig-a005-20201022
x86_64               randconfig-a001-20201024
x86_64               randconfig-a003-20201024
x86_64               randconfig-a002-20201024
x86_64               randconfig-a006-20201024
x86_64               randconfig-a005-20201024
x86_64               randconfig-a004-20201024
x86_64               randconfig-a011-20201023
x86_64               randconfig-a013-20201023
x86_64               randconfig-a016-20201023
x86_64               randconfig-a015-20201023
x86_64               randconfig-a012-20201023
x86_64               randconfig-a014-20201023

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F3D2A3817
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Nov 2020 01:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgKCA5J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 19:57:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:26364 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbgKCA5J (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 19:57:09 -0500
IronPort-SDR: Nfn9Tf/j4ym8Iyhn77CIT/R3gmzwOcoptm7zVTt6X82l02VvWsfkc5zYjXJvYWQYx6CkaNs2EP
 LBtsZqZDF6eQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="165474208"
X-IronPort-AV: E=Sophos;i="5.77,446,1596524400"; 
   d="scan'208";a="165474208"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 16:57:08 -0800
IronPort-SDR: 2F6u/tvsg4M+Xq0H3LJu/lxrmtsb5O6UiQTPpKa4St0CPupQjPb0dwRsOvxZEyl4XCJLwF5w09
 byi4EwEbINQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,446,1596524400"; 
   d="scan'208";a="320252574"
Received: from lkp-server02.sh.intel.com (HELO 9353403cd79d) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Nov 2020 16:57:07 -0800
Received: from kbuild by 9353403cd79d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kZkdG-0000G8-OZ; Tue, 03 Nov 2020 00:57:06 +0000
Date:   Tue, 03 Nov 2020 08:56:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 c2f46814521113f6699a74e0a0424cbc5b305479
Message-ID: <5fa0aadb.MySTQUYsBd0OtuFq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git  master
branch HEAD: c2f46814521113f6699a74e0a0424cbc5b305479  mac80211: don't require VHT elements for HE on 2.4 GHz

elapsed time: 724m

configs tested: 170
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                              allmodconfig
c6x                        evmc6457_defconfig
arm                       imx_v6_v7_defconfig
powerpc                      cm5200_defconfig
arm                        magician_defconfig
powerpc                     skiroot_defconfig
sh                        sh7757lcr_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                    amigaone_defconfig
arm                        spear6xx_defconfig
arm                            mmp2_defconfig
ia64                        generic_defconfig
mips                    maltaup_xpa_defconfig
sh                          rsk7269_defconfig
arm                      tct_hammer_defconfig
arm                            xcep_defconfig
sh                   rts7751r2dplus_defconfig
mips                      maltasmvp_defconfig
m68k                             alldefconfig
sh                           se7724_defconfig
arm                            lart_defconfig
sh                           se7750_defconfig
arm                         at91_dt_defconfig
arm                              zx_defconfig
sh                           se7343_defconfig
sh                            hp6xx_defconfig
powerpc                      makalu_defconfig
sh                          polaris_defconfig
m68k                       bvme6000_defconfig
arm                         lpc32xx_defconfig
ia64                            zx1_defconfig
powerpc                       maple_defconfig
mips                           ip28_defconfig
arm                         lpc18xx_defconfig
c6x                         dsk6455_defconfig
powerpc                     kilauea_defconfig
arc                          axs101_defconfig
arc                        vdk_hs38_defconfig
mips                             allyesconfig
arm                           omap1_defconfig
m68k                        mvme16x_defconfig
mips                        bcm47xx_defconfig
mips                            gpr_defconfig
alpha                               defconfig
powerpc                 mpc837x_mds_defconfig
ia64                             allyesconfig
m68k                       m5208evb_defconfig
powerpc                      obs600_defconfig
powerpc                     asp8347_defconfig
mips                         tb0226_defconfig
mips                          ath25_defconfig
powerpc                     mpc5200_defconfig
arm                        cerfcube_defconfig
h8300                    h8300h-sim_defconfig
m68k                        stmark2_defconfig
sh                          rsk7201_defconfig
mips                   sb1250_swarm_defconfig
arm                     davinci_all_defconfig
mips                     decstation_defconfig
powerpc                 mpc8315_rdb_defconfig
arc                     haps_hs_smp_defconfig
arm                         vf610m4_defconfig
arm                         mv78xx0_defconfig
powerpc                      ppc40x_defconfig
sh                          sdk7780_defconfig
powerpc                       eiger_defconfig
m68k                          multi_defconfig
arm                         socfpga_defconfig
arm                          badge4_defconfig
arm                           sunxi_defconfig
mips                      maltaaprp_defconfig
xtensa                generic_kc705_defconfig
sh                   sh7770_generic_defconfig
csky                                defconfig
nds32                            alldefconfig
riscv                    nommu_k210_defconfig
sh                         ecovec24_defconfig
riscv                          rv32_defconfig
mips                malta_kvm_guest_defconfig
mips                        jmr3927_defconfig
powerpc                   currituck_defconfig
sh                         microdev_defconfig
powerpc                     rainier_defconfig
arm                      footbridge_defconfig
powerpc                      katmai_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                    gamecube_defconfig
powerpc                          allmodconfig
sh                           se7206_defconfig
microblaze                      mmu_defconfig
powerpc                     tqm5200_defconfig
powerpc                   lite5200b_defconfig
m68k                        mvme147_defconfig
c6x                                 defconfig
sh                     sh7710voipgw_defconfig
mips                           ip27_defconfig
xtensa                    smp_lx200_defconfig
m68k                           sun3_defconfig
powerpc                        cell_defconfig
arm                          pxa3xx_defconfig
mips                      fuloong2e_defconfig
arm                       cns3420vb_defconfig
arm                  colibri_pxa270_defconfig
m68k                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201102
i386                 randconfig-a006-20201102
i386                 randconfig-a005-20201102
i386                 randconfig-a001-20201102
i386                 randconfig-a002-20201102
i386                 randconfig-a003-20201102
x86_64               randconfig-a012-20201102
x86_64               randconfig-a015-20201102
x86_64               randconfig-a011-20201102
x86_64               randconfig-a013-20201102
x86_64               randconfig-a014-20201102
x86_64               randconfig-a016-20201102
i386                 randconfig-a013-20201102
i386                 randconfig-a014-20201102
i386                 randconfig-a016-20201102
i386                 randconfig-a011-20201102
i386                 randconfig-a012-20201102
i386                 randconfig-a015-20201102
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
x86_64               randconfig-a004-20201102
x86_64               randconfig-a005-20201102
x86_64               randconfig-a003-20201102
x86_64               randconfig-a002-20201102
x86_64               randconfig-a006-20201102
x86_64               randconfig-a001-20201102

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

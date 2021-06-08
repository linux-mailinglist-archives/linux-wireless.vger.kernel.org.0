Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1683A07FC
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jun 2021 01:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFHXtR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Jun 2021 19:49:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:30707 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230434AbhFHXtO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Jun 2021 19:49:14 -0400
IronPort-SDR: hUbK44dUwpM/TA9D6Epj4mrlGT4p+JRQaXe2wbZDfgfxzqvMJhRMEjQgx7dYmx1wLpBu5V7kJB
 tLb4XwxwtzXw==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="185343844"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="185343844"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 16:47:20 -0700
IronPort-SDR: 9GwljcIlLID5BNZND/nLNVdo/5mnpApNTYBqmMCBZoPbfT2kAvCQegxOhKnc28xUqNPG9iUr/I
 GAQFQDAEx8mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="635238743"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jun 2021 16:47:19 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lqlRG-0009Gw-Ei; Tue, 08 Jun 2021 23:47:18 +0000
Date:   Wed, 09 Jun 2021 07:46:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 d5befb224edbe53056c2c18999d630dafb4a08b9
Message-ID: <60c0014e.raSA4BZvuqJzQsJV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
branch HEAD: d5befb224edbe53056c2c18999d630dafb4a08b9  mac80211: fix deadlock in AP/VLAN handling

elapsed time: 728m

configs tested: 206
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
mips                         rt305x_defconfig
mips                      malta_kvm_defconfig
powerpc                     asp8347_defconfig
arm                           spitz_defconfig
sparc                       sparc32_defconfig
nios2                            allyesconfig
nios2                            alldefconfig
sh                          kfr2r09_defconfig
powerpc                    socrates_defconfig
mips                         tb0226_defconfig
mips                           ip32_defconfig
h8300                       h8s-sim_defconfig
arm                   milbeaut_m10v_defconfig
xtensa                           alldefconfig
mips                          ath79_defconfig
sh                  sh7785lcr_32bit_defconfig
xtensa                           allyesconfig
sh                           se7722_defconfig
sh                           se7724_defconfig
arc                          axs103_defconfig
nios2                         3c120_defconfig
ia64                                defconfig
arc                              alldefconfig
xtensa                       common_defconfig
xtensa                  nommu_kc705_defconfig
arm                    vt8500_v6_v7_defconfig
mips                     loongson2k_defconfig
powerpc                     taishan_defconfig
xtensa                          iss_defconfig
powerpc                     pseries_defconfig
parisc                generic-32bit_defconfig
h8300                    h8300h-sim_defconfig
mips                      loongson3_defconfig
ia64                      gensparse_defconfig
sh                         microdev_defconfig
sh                             espt_defconfig
powerpc                 mpc837x_rdb_defconfig
h8300                            allyesconfig
powerpc                      ep88xc_defconfig
m68k                          atari_defconfig
powerpc                      cm5200_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                       eiger_defconfig
powerpc                     tqm8560_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                      pic32mzda_defconfig
sh                          sdk7780_defconfig
mips                      fuloong2e_defconfig
xtensa                  audio_kc705_defconfig
arm                         lpc32xx_defconfig
sh                           se7343_defconfig
arm                      integrator_defconfig
arm                         lpc18xx_defconfig
arm                       imx_v6_v7_defconfig
arm                        realview_defconfig
xtensa                  cadence_csp_defconfig
arm                         cm_x300_defconfig
arm                         bcm2835_defconfig
mips                            ar7_defconfig
arm64                            alldefconfig
arm                           tegra_defconfig
nds32                            alldefconfig
mips                         tb0219_defconfig
powerpc                 mpc832x_rdb_defconfig
nios2                         10m50_defconfig
arm                          ixp4xx_defconfig
sh                           se7206_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 linkstation_defconfig
sh                          sdk7786_defconfig
i386                             allyesconfig
ia64                        generic_defconfig
powerpc                        warp_defconfig
powerpc                   currituck_defconfig
mips                  cavium_octeon_defconfig
arm                             mxs_defconfig
mips                       rbtx49xx_defconfig
mips                             allmodconfig
arm                       aspeed_g4_defconfig
mips                           ip27_defconfig
powerpc                      ppc6xx_defconfig
arm                         s5pv210_defconfig
arc                        vdk_hs38_defconfig
powerpc                      walnut_defconfig
arm                       aspeed_g5_defconfig
arm                             rpc_defconfig
mips                    maltaup_xpa_defconfig
powerpc                    gamecube_defconfig
um                           x86_64_defconfig
arm                          pxa3xx_defconfig
sh                   sh7724_generic_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                        magician_defconfig
m68k                            q40_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                         mv78xx0_defconfig
sh                           se7619_defconfig
arm                           corgi_defconfig
arm                  colibri_pxa270_defconfig
xtensa                         virt_defconfig
arm                       netwinder_defconfig
um                             i386_defconfig
powerpc                     tqm5200_defconfig
sh                   secureedge5410_defconfig
powerpc                      bamboo_defconfig
powerpc                  mpc866_ads_defconfig
mips                        workpad_defconfig
powerpc                     mpc83xx_defconfig
arm                      jornada720_defconfig
nds32                             allnoconfig
arc                           tb10x_defconfig
microblaze                          defconfig
powerpc                     kilauea_defconfig
arc                      axs103_smp_defconfig
arm                         nhk8815_defconfig
parisc                              defconfig
sh                        edosk7760_defconfig
sh                   sh7770_generic_defconfig
arm                     am200epdkit_defconfig
powerpc                      pmac32_defconfig
s390                             allyesconfig
arm                         s3c6400_defconfig
powerpc                      arches_defconfig
arm                           omap1_defconfig
openrisc                 simple_smp_defconfig
mips                      bmips_stb_defconfig
um                               alldefconfig
arm                          pxa168_defconfig
arm                        spear6xx_defconfig
arm                            pleb_defconfig
powerpc                 mpc832x_mds_defconfig
sh                           se7721_defconfig
h8300                               defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210608
x86_64               randconfig-a002-20210608
x86_64               randconfig-a003-20210608
x86_64               randconfig-a006-20210608
x86_64               randconfig-a005-20210608
x86_64               randconfig-a001-20210608
i386                 randconfig-a003-20210608
i386                 randconfig-a006-20210608
i386                 randconfig-a004-20210608
i386                 randconfig-a001-20210608
i386                 randconfig-a005-20210608
i386                 randconfig-a002-20210608
i386                 randconfig-a015-20210608
i386                 randconfig-a013-20210608
i386                 randconfig-a016-20210608
i386                 randconfig-a011-20210608
i386                 randconfig-a012-20210608
i386                 randconfig-a014-20210608
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210607
x86_64               randconfig-a004-20210607
x86_64               randconfig-a003-20210607
x86_64               randconfig-a006-20210607
x86_64               randconfig-a005-20210607
x86_64               randconfig-a001-20210607
x86_64               randconfig-a015-20210608
x86_64               randconfig-a012-20210608
x86_64               randconfig-a014-20210608
x86_64               randconfig-a011-20210608
x86_64               randconfig-a016-20210608
x86_64               randconfig-a013-20210608

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

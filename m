Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A9443FEF0
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Oct 2021 17:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhJ2PEd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Oct 2021 11:04:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:33693 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229888AbhJ2PEb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Oct 2021 11:04:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="217865052"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="217865052"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 08:02:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="487601700"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 29 Oct 2021 08:02:00 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mgTOJ-0000PR-CG; Fri, 29 Oct 2021 15:01:59 +0000
Date:   Fri, 29 Oct 2021 23:01:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [jberg-mac80211-next:master] BUILD SUCCESS
 62bf703f44239869b55165fc5bbed3f38e869aae
Message-ID: <617c0cac.y5YomHEjQ53D/+nI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
branch HEAD: 62bf703f44239869b55165fc5bbed3f38e869aae  cfg80211: move offchan_cac_event to a dedicated work

elapsed time: 2859m

configs tested: 218
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211028
i386                 randconfig-c001-20211027
h8300                       h8s-sim_defconfig
powerpc                   motionpro_defconfig
arc                    vdk_hs38_smp_defconfig
mips                         rt305x_defconfig
arm                   milbeaut_m10v_defconfig
arm                          exynos_defconfig
sh                           sh2007_defconfig
powerpc                  iss476-smp_defconfig
arm                            zeus_defconfig
powerpc                     pq2fads_defconfig
arm                        mvebu_v5_defconfig
arm                    vt8500_v6_v7_defconfig
mips                           xway_defconfig
parisc                generic-64bit_defconfig
powerpc                     pseries_defconfig
arm                          ixp4xx_defconfig
arm                        trizeps4_defconfig
nios2                         3c120_defconfig
arc                         haps_hs_defconfig
m68k                       m5249evb_defconfig
arc                     nsimosci_hs_defconfig
sh                     magicpanelr2_defconfig
sh                          lboxre2_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                      malta_kvm_defconfig
m68k                        mvme16x_defconfig
sh                             shx3_defconfig
sh                  sh7785lcr_32bit_defconfig
s390                       zfcpdump_defconfig
sh                          r7785rp_defconfig
arm                       netwinder_defconfig
h8300                               defconfig
arm                           sunxi_defconfig
xtensa                         virt_defconfig
ia64                          tiger_defconfig
arc                            hsdk_defconfig
arm                         lubbock_defconfig
arm                         socfpga_defconfig
arm                            pleb_defconfig
openrisc                    or1ksim_defconfig
mips                           ip27_defconfig
powerpc                 mpc8560_ads_defconfig
arm                     am200epdkit_defconfig
powerpc                        icon_defconfig
sh                           se7780_defconfig
powerpc                      pasemi_defconfig
arc                     haps_hs_smp_defconfig
riscv                            alldefconfig
arm                           sama7_defconfig
powerpc                    sam440ep_defconfig
powerpc                      mgcoge_defconfig
sh                           se7751_defconfig
powerpc                     mpc512x_defconfig
sh                           se7705_defconfig
mips                      bmips_stb_defconfig
arm                           u8500_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     redwood_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                     rainier_defconfig
arm                             rpc_defconfig
powerpc                      ppc6xx_defconfig
arm                              alldefconfig
arm                         at91_dt_defconfig
mips                  maltasmvp_eva_defconfig
m68k                          amiga_defconfig
powerpc                 mpc8315_rdb_defconfig
m68k                          multi_defconfig
ia64                        generic_defconfig
powerpc                    gamecube_defconfig
arm                            dove_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                     tqm5200_defconfig
arm                           stm32_defconfig
arm                           tegra_defconfig
m68k                        stmark2_defconfig
arm                     davinci_all_defconfig
arm                       aspeed_g5_defconfig
arm                           omap1_defconfig
arm                          lpd270_defconfig
powerpc                     akebono_defconfig
powerpc                      tqm8xx_defconfig
openrisc                            defconfig
powerpc                     skiroot_defconfig
mips                       lemote2f_defconfig
powerpc                 mpc832x_mds_defconfig
mips                          malta_defconfig
xtensa                          iss_defconfig
arm                          imote2_defconfig
mips                         tb0219_defconfig
arm                          ep93xx_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                      fuloong2e_defconfig
mips                        omega2p_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                  randconfig-c002-20211028
arm                  randconfig-c002-20211027
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                                defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20211028
x86_64               randconfig-a004-20211028
x86_64               randconfig-a005-20211028
x86_64               randconfig-a001-20211028
x86_64               randconfig-a006-20211028
x86_64               randconfig-a003-20211028
i386                 randconfig-a004-20211028
i386                 randconfig-a003-20211028
i386                 randconfig-a002-20211028
i386                 randconfig-a006-20211028
i386                 randconfig-a001-20211028
i386                 randconfig-a005-20211028
x86_64               randconfig-a013-20211027
x86_64               randconfig-a015-20211027
x86_64               randconfig-a011-20211027
x86_64               randconfig-a014-20211027
x86_64               randconfig-a016-20211027
x86_64               randconfig-a012-20211027
i386                 randconfig-a012-20211029
i386                 randconfig-a013-20211029
i386                 randconfig-a011-20211029
i386                 randconfig-a015-20211029
i386                 randconfig-a016-20211029
i386                 randconfig-a014-20211029
i386                 randconfig-a012-20211027
i386                 randconfig-a013-20211027
i386                 randconfig-a011-20211027
i386                 randconfig-a016-20211027
i386                 randconfig-a015-20211027
i386                 randconfig-a014-20211027
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
arm                  randconfig-c002-20211028
powerpc              randconfig-c003-20211028
riscv                randconfig-c006-20211028
x86_64               randconfig-c007-20211028
mips                 randconfig-c004-20211028
s390                 randconfig-c005-20211028
i386                 randconfig-c001-20211028
riscv                randconfig-c006-20211027
powerpc              randconfig-c003-20211027
arm                  randconfig-c002-20211027
mips                 randconfig-c004-20211027
x86_64               randconfig-c007-20211027
i386                 randconfig-c001-20211027
s390                 randconfig-c005-20211027
i386                 randconfig-a003-20211027
i386                 randconfig-a004-20211027
i386                 randconfig-a002-20211027
i386                 randconfig-a005-20211027
i386                 randconfig-a001-20211027
i386                 randconfig-a006-20211027
x86_64               randconfig-a015-20211028
x86_64               randconfig-a013-20211028
x86_64               randconfig-a011-20211028
x86_64               randconfig-a014-20211028
x86_64               randconfig-a012-20211028
x86_64               randconfig-a016-20211028
i386                 randconfig-a012-20211028
i386                 randconfig-a013-20211028
i386                 randconfig-a011-20211028
i386                 randconfig-a015-20211028
i386                 randconfig-a016-20211028
i386                 randconfig-a014-20211028
hexagon              randconfig-r045-20211028
riscv                randconfig-r042-20211028
s390                 randconfig-r044-20211028
hexagon              randconfig-r041-20211028
hexagon              randconfig-r045-20211029
hexagon              randconfig-r041-20211029
hexagon              randconfig-r045-20211027
hexagon              randconfig-r041-20211027

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

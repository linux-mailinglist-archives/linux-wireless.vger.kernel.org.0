Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CE03D488C
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Jul 2021 18:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhGXPeB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Jul 2021 11:34:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:43496 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhGXPeB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Jul 2021 11:34:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10055"; a="191622585"
X-IronPort-AV: E=Sophos;i="5.84,266,1620716400"; 
   d="scan'208";a="191622585"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2021 09:14:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,266,1620716400"; 
   d="scan'208";a="496907689"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2021 09:14:31 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m7KII-0003ZX-Lj; Sat, 24 Jul 2021 16:14:30 +0000
Date:   Sun, 25 Jul 2021 00:14:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 f9a5c358c8d26fed0cc45f2afc64633d4ba21dff
Message-ID: <60fc3c5c.+ugSF194m4PxNQWf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
branch HEAD: f9a5c358c8d26fed0cc45f2afc64633d4ba21dff  cfg80211: Fix possible memory leak in function cfg80211_bss_update

elapsed time: 1838m

configs tested: 155
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210723
i386                 randconfig-c001-20210724
powerpc                      tqm8xx_defconfig
powerpc                      obs600_defconfig
openrisc                            defconfig
arm                          pxa910_defconfig
powerpc                        icon_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                      pasemi_defconfig
mips                      pic32mzda_defconfig
mips                      pistachio_defconfig
powerpc                      ppc44x_defconfig
powerpc                     redwood_defconfig
mips                      bmips_stb_defconfig
arc                           tb10x_defconfig
powerpc                     akebono_defconfig
sh                          sdk7780_defconfig
mips                        bcm47xx_defconfig
powerpc                           allnoconfig
powerpc                   motionpro_defconfig
sh                             sh03_defconfig
sh                           se7712_defconfig
s390                             alldefconfig
arm                     davinci_all_defconfig
mips                        workpad_defconfig
powerpc                        fsp2_defconfig
arm                         vf610m4_defconfig
arm                         axm55xx_defconfig
mips                     loongson2k_defconfig
powerpc                 mpc8560_ads_defconfig
arm                            xcep_defconfig
ia64                            zx1_defconfig
openrisc                  or1klitex_defconfig
sh                          r7785rp_defconfig
h8300                            alldefconfig
powerpc                 mpc85xx_cds_defconfig
m68k                        m5407c3_defconfig
sh                          sdk7786_defconfig
csky                                defconfig
mips                      loongson3_defconfig
mips                        nlm_xlp_defconfig
sh                      rts7751r2d1_defconfig
sh                   sh7770_generic_defconfig
sh                            shmin_defconfig
sh                            migor_defconfig
h8300                       h8s-sim_defconfig
sh                           se7722_defconfig
powerpc                   bluestone_defconfig
parisc                generic-64bit_defconfig
arm                     am200epdkit_defconfig
mips                      maltasmvp_defconfig
sh                             espt_defconfig
powerpc                     tqm8555_defconfig
alpha                               defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                 canyonlands_defconfig
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
alpha                            allyesconfig
xtensa                           allyesconfig
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
i386                 randconfig-a005-20210723
i386                 randconfig-a003-20210723
i386                 randconfig-a004-20210723
i386                 randconfig-a002-20210723
i386                 randconfig-a001-20210723
i386                 randconfig-a006-20210723
i386                 randconfig-a005-20210724
i386                 randconfig-a003-20210724
i386                 randconfig-a004-20210724
i386                 randconfig-a002-20210724
i386                 randconfig-a001-20210724
i386                 randconfig-a006-20210724
i386                 randconfig-a005-20210722
i386                 randconfig-a003-20210722
i386                 randconfig-a004-20210722
i386                 randconfig-a002-20210722
i386                 randconfig-a001-20210722
i386                 randconfig-a006-20210722
x86_64               randconfig-a011-20210723
x86_64               randconfig-a016-20210723
x86_64               randconfig-a013-20210723
x86_64               randconfig-a014-20210723
x86_64               randconfig-a012-20210723
x86_64               randconfig-a015-20210723
i386                 randconfig-a016-20210723
i386                 randconfig-a013-20210723
i386                 randconfig-a012-20210723
i386                 randconfig-a011-20210723
i386                 randconfig-a014-20210723
i386                 randconfig-a015-20210723
i386                 randconfig-a016-20210724
i386                 randconfig-a013-20210724
i386                 randconfig-a012-20210724
i386                 randconfig-a014-20210724
i386                 randconfig-a011-20210724
i386                 randconfig-a015-20210724
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
x86_64               randconfig-c001-20210723
x86_64               randconfig-b001-20210723
x86_64               randconfig-a003-20210723
x86_64               randconfig-a006-20210723
x86_64               randconfig-a001-20210723
x86_64               randconfig-a005-20210723
x86_64               randconfig-a004-20210723
x86_64               randconfig-a002-20210723
x86_64               randconfig-a011-20210724
x86_64               randconfig-a016-20210724
x86_64               randconfig-a013-20210724
x86_64               randconfig-a014-20210724
x86_64               randconfig-a012-20210724
x86_64               randconfig-a015-20210724

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

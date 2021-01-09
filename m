Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF0F2EFEA2
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Jan 2021 09:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbhAIIbm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 9 Jan 2021 03:31:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:25582 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbhAIIbm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 9 Jan 2021 03:31:42 -0500
IronPort-SDR: uoFtIfYYDklVv7WKTqKqiUozZgy8M4qn9iwA776Dk3p0R5qieneoXoQ0XObaKbTEtqPvB78139
 F+IuuYEII6fA==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="262469692"
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="262469692"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2021 00:31:01 -0800
IronPort-SDR: uhmiLen5A3R2MnAsfs47BC+hq1rfylq6dnIu0sF64s3QNAW8j4Np0Pu2P2qudWfPcz0mTHKfKr
 EeMJvDvwRQJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="380405469"
Received: from lkp-server01.sh.intel.com (HELO 412602b27703) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Jan 2021 00:31:00 -0800
Received: from kbuild by 412602b27703 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ky9eF-0000yb-E7; Sat, 09 Jan 2021 08:30:59 +0000
Date:   Sat, 09 Jan 2021 16:30:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 51d62f2f2c501a93d9a6a46f43731f984e227764
Message-ID: <5ff969a2.32Vv8J6vsCThXJ4V%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git  master
branch HEAD: 51d62f2f2c501a93d9a6a46f43731f984e227764  cfg80211: Save the regulatory domain with a lock

elapsed time: 735m

configs tested: 151
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
openrisc                            defconfig
powerpc                      arches_defconfig
mips                        qi_lb60_defconfig
powerpc                     sbc8548_defconfig
openrisc                 simple_smp_defconfig
sh                           se7780_defconfig
powerpc                      mgcoge_defconfig
mips                      malta_kvm_defconfig
m68k                        mvme16x_defconfig
powerpc                         wii_defconfig
riscv                          rv32_defconfig
mips                           ip28_defconfig
riscv                            alldefconfig
mips                        jmr3927_defconfig
arm                           spitz_defconfig
arm                        magician_defconfig
sh                            migor_defconfig
arm                         socfpga_defconfig
powerpc                       ebony_defconfig
mips                         bigsur_defconfig
arm                        realview_defconfig
m68k                        m5307c3_defconfig
mips                            gpr_defconfig
powerpc                     tqm8540_defconfig
powerpc                  iss476-smp_defconfig
arm                           efm32_defconfig
powerpc                     redwood_defconfig
h8300                               defconfig
m68k                        stmark2_defconfig
xtensa                generic_kc705_defconfig
mips                  decstation_64_defconfig
sh                        sh7785lcr_defconfig
riscv                            allmodconfig
powerpc                    sam440ep_defconfig
mips                         tb0219_defconfig
mips                      bmips_stb_defconfig
powerpc                      ppc6xx_defconfig
mips                        workpad_defconfig
mips                        omega2p_defconfig
sh                            titan_defconfig
powerpc                      ppc64e_defconfig
sh                        dreamcast_defconfig
arm                         lpc18xx_defconfig
arm                        mvebu_v7_defconfig
microblaze                          defconfig
arm                        oxnas_v6_defconfig
m68k                                defconfig
m68k                         apollo_defconfig
powerpc64                           defconfig
arm                       cns3420vb_defconfig
m68k                        mvme147_defconfig
sh                            shmin_defconfig
arm                          pxa3xx_defconfig
riscv                    nommu_virt_defconfig
sh                           se7619_defconfig
mips                           ip22_defconfig
powerpc                  mpc885_ads_defconfig
mips                malta_kvm_guest_defconfig
powerpc                       ppc64_defconfig
powerpc                     tqm8560_defconfig
mips                         cobalt_defconfig
ia64                                defconfig
powerpc                     pseries_defconfig
arm                         lpc32xx_defconfig
powerpc                     kilauea_defconfig
m68k                             allyesconfig
arm                       aspeed_g5_defconfig
m68k                       m5249evb_defconfig
mips                      maltaaprp_defconfig
arc                          axs103_defconfig
arm                     eseries_pxa_defconfig
sh                          r7780mp_defconfig
powerpc                      acadia_defconfig
riscv                            allyesconfig
arc                          axs101_defconfig
mips                           gcw0_defconfig
mips                      pic32mzda_defconfig
parisc                generic-32bit_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                      pistachio_defconfig
powerpc                     akebono_defconfig
sh                          rsk7269_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210108
x86_64               randconfig-a006-20210108
x86_64               randconfig-a001-20210108
x86_64               randconfig-a002-20210108
x86_64               randconfig-a003-20210108
x86_64               randconfig-a005-20210108
i386                 randconfig-a005-20210108
i386                 randconfig-a002-20210108
i386                 randconfig-a001-20210108
i386                 randconfig-a003-20210108
i386                 randconfig-a006-20210108
i386                 randconfig-a004-20210108
i386                 randconfig-a016-20210108
i386                 randconfig-a011-20210108
i386                 randconfig-a014-20210108
i386                 randconfig-a015-20210108
i386                 randconfig-a013-20210108
i386                 randconfig-a012-20210108
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210108
x86_64               randconfig-a011-20210108
x86_64               randconfig-a012-20210108
x86_64               randconfig-a016-20210108
x86_64               randconfig-a014-20210108
x86_64               randconfig-a015-20210108

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

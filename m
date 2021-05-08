Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9523770AD
	for <lists+linux-wireless@lfdr.de>; Sat,  8 May 2021 10:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhEHIdl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 May 2021 04:33:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:58478 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhEHIdk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 May 2021 04:33:40 -0400
IronPort-SDR: RYx7SnJdMgbugMF8P4zqVLy5gvqyt7rFlacFPCbt0mfhaVDVYcC5KtyRELCROeX0v/fjDAGGSL
 FQQakDUSSMMQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="219802544"
X-IronPort-AV: E=Sophos;i="5.82,283,1613462400"; 
   d="scan'208";a="219802544"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2021 01:32:38 -0700
IronPort-SDR: PCBfxF53AttWkL+8IxLc2vGDtjLzxdkKfhZmshinN5WiHwK3uf3TwCJa9pSA1uOH4SACyTaYj9
 yAt6OcbAx32A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,283,1613462400"; 
   d="scan'208";a="429290926"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 May 2021 01:32:36 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lfIO4-000Bau-8r; Sat, 08 May 2021 08:32:36 +0000
Date:   Sat, 08 May 2021 16:31:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 a6f8ee58a8e35f7e4380a5efce312e2a5bc27497
Message-ID: <60964c71.haVZ/xYzDDariSOJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
branch HEAD: a6f8ee58a8e35f7e4380a5efce312e2a5bc27497  tcp: Specify cmsgbuf is user pointer for receive zerocopy.

elapsed time: 1793m

configs tested: 158
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
arc                          axs101_defconfig
arm                        mvebu_v5_defconfig
sh                   sh7770_generic_defconfig
m68k                        m5272c3_defconfig
sh                          lboxre2_defconfig
arm                           stm32_defconfig
mips                    maltaup_xpa_defconfig
sh                   rts7751r2dplus_defconfig
mips                           ip22_defconfig
arc                          axs103_defconfig
m68k                                defconfig
arm                            zeus_defconfig
openrisc                  or1klitex_defconfig
arm                        spear6xx_defconfig
powerpc                     ep8248e_defconfig
arm                         orion5x_defconfig
arm                        multi_v7_defconfig
um                               allmodconfig
powerpc                      pcm030_defconfig
sh                ecovec24-romimage_defconfig
arc                           tb10x_defconfig
arm                    vt8500_v6_v7_defconfig
xtensa                generic_kc705_defconfig
mips                      pic32mzda_defconfig
sh                             shx3_defconfig
arm                          collie_defconfig
arm                         nhk8815_defconfig
mips                           gcw0_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                      mgcoge_defconfig
mips                           mtx1_defconfig
m68k                            mac_defconfig
sh                          rsk7203_defconfig
nds32                               defconfig
arm                            qcom_defconfig
arm                          pxa168_defconfig
sh                      rts7751r2d1_defconfig
arm                         hackkit_defconfig
arm                        shmobile_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                           jazz_defconfig
arc                              allyesconfig
m68k                       m5475evb_defconfig
mips                         bigsur_defconfig
arm                       netwinder_defconfig
m68k                           sun3_defconfig
mips                     cu1000-neo_defconfig
arm                   milbeaut_m10v_defconfig
arm                            mps2_defconfig
riscv                               defconfig
powerpc                    ge_imp3a_defconfig
mips                       bmips_be_defconfig
arc                              alldefconfig
arc                        nsimosci_defconfig
m68k                         amcore_defconfig
powerpc                       holly_defconfig
powerpc                      ppc6xx_defconfig
arm                         palmz72_defconfig
arm                          badge4_defconfig
powerpc                      chrp32_defconfig
sh                           se7712_defconfig
sparc                       sparc32_defconfig
arm                         s3c2410_defconfig
mips                        nlm_xlp_defconfig
riscv                    nommu_k210_defconfig
sh                           se7751_defconfig
arc                            hsdk_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                           sama5_defconfig
powerpc                     tqm8548_defconfig
arm                          imote2_defconfig
powerpc                  mpc866_ads_defconfig
sh                          rsk7269_defconfig
powerpc                      bamboo_defconfig
powerpc                     taishan_defconfig
powerpc                      pasemi_defconfig
um                             i386_defconfig
mips                         mpc30x_defconfig
sh                     magicpanelr2_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20210507
x86_64               randconfig-a003-20210507
x86_64               randconfig-a005-20210507
x86_64               randconfig-a002-20210507
x86_64               randconfig-a006-20210507
x86_64               randconfig-a004-20210507
i386                 randconfig-a003-20210507
i386                 randconfig-a006-20210507
i386                 randconfig-a001-20210507
i386                 randconfig-a005-20210507
i386                 randconfig-a004-20210507
i386                 randconfig-a002-20210507
i386                 randconfig-a003-20210506
i386                 randconfig-a006-20210506
i386                 randconfig-a001-20210506
i386                 randconfig-a005-20210506
i386                 randconfig-a004-20210506
i386                 randconfig-a002-20210506
i386                 randconfig-a015-20210507
i386                 randconfig-a013-20210507
i386                 randconfig-a016-20210507
i386                 randconfig-a014-20210507
i386                 randconfig-a012-20210507
i386                 randconfig-a011-20210507
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210507
x86_64               randconfig-a015-20210507
x86_64               randconfig-a012-20210507
x86_64               randconfig-a013-20210507
x86_64               randconfig-a011-20210507
x86_64               randconfig-a016-20210507

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F36D46111E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 10:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242737AbhK2JeW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 04:34:22 -0500
Received: from mga17.intel.com ([192.55.52.151]:25772 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244665AbhK2JcV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 04:32:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="216629179"
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="216629179"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 01:29:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="499259896"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 29 Nov 2021 01:29:02 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrcy5-000Blu-UP; Mon, 29 Nov 2021 09:29:01 +0000
Date:   Mon, 29 Nov 2021 17:28:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [jberg-mac80211-next:master] BUILD SUCCESS
 75c5bd68b699bbcb6d25879644d62de4da14ab92
Message-ID: <61a49d56.meUTSAV3wkgDG8E9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
branch HEAD: 75c5bd68b699bbcb6d25879644d62de4da14ab92  ieee80211: change HE nominal packet padding value defines

elapsed time: 723m

configs tested: 182
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211128
nios2                            alldefconfig
arm                        shmobile_defconfig
mips                      fuloong2e_defconfig
arc                            hsdk_defconfig
powerpc                    ge_imp3a_defconfig
mips                         bigsur_defconfig
riscv                    nommu_virt_defconfig
mips                        bcm47xx_defconfig
powerpc                   bluestone_defconfig
powerpc                   lite5200b_defconfig
powerpc                        warp_defconfig
sh                          rsk7269_defconfig
sh                          sdk7780_defconfig
sh                 kfr2r09-romimage_defconfig
arm                         mv78xx0_defconfig
mips                          ath79_defconfig
arm                              alldefconfig
powerpc                     pq2fads_defconfig
sh                   sh7724_generic_defconfig
arm                           omap1_defconfig
riscv                          rv32_defconfig
arm                        mini2440_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                        spear3xx_defconfig
arc                          axs103_defconfig
sh                           se7619_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                        icon_defconfig
sh                          landisk_defconfig
m68k                       m5249evb_defconfig
arm                           sama7_defconfig
arm                            dove_defconfig
m68k                                defconfig
sparc                               defconfig
mips                          rm200_defconfig
arm                        magician_defconfig
arm                          exynos_defconfig
ia64                            zx1_defconfig
mips                      malta_kvm_defconfig
mips                            ar7_defconfig
mips                        omega2p_defconfig
mips                       lemote2f_defconfig
powerpc                  iss476-smp_defconfig
arc                        vdk_hs38_defconfig
arm                            lart_defconfig
mips                             allyesconfig
mips                         mpc30x_defconfig
m68k                             alldefconfig
mips                        maltaup_defconfig
arm                            xcep_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         s3c6400_defconfig
arm                             mxs_defconfig
sh                          r7785rp_defconfig
powerpc                         wii_defconfig
xtensa                  nommu_kc705_defconfig
sh                           se7722_defconfig
arc                                 defconfig
parisc                           allyesconfig
powerpc                     redwood_defconfig
powerpc                    socrates_defconfig
powerpc                 linkstation_defconfig
arm                     am200epdkit_defconfig
powerpc                     ksi8560_defconfig
s390                          debug_defconfig
openrisc                  or1klitex_defconfig
arc                     haps_hs_smp_defconfig
parisc                generic-64bit_defconfig
m68k                       bvme6000_defconfig
x86_64                              defconfig
m68k                        m5307c3_defconfig
arm                           h3600_defconfig
mips                     loongson1c_defconfig
mips                      maltaaprp_defconfig
arm                       omap2plus_defconfig
arm                          iop32x_defconfig
mips                          rb532_defconfig
mips                  cavium_octeon_defconfig
powerpc                   microwatt_defconfig
arm                         axm55xx_defconfig
arm                         socfpga_defconfig
ia64                          tiger_defconfig
powerpc64                        alldefconfig
arm                         cm_x300_defconfig
powerpc                     ep8248e_defconfig
arm                         orion5x_defconfig
arm                  randconfig-c002-20211128
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20211129
i386                 randconfig-a002-20211129
i386                 randconfig-a006-20211129
i386                 randconfig-a005-20211129
i386                 randconfig-a004-20211129
i386                 randconfig-a003-20211129
x86_64               randconfig-a011-20211128
x86_64               randconfig-a014-20211128
x86_64               randconfig-a012-20211128
x86_64               randconfig-a016-20211128
x86_64               randconfig-a013-20211128
x86_64               randconfig-a015-20211128
i386                 randconfig-a013-20211128
i386                 randconfig-a012-20211128
i386                 randconfig-a011-20211128
i386                 randconfig-a015-20211128
i386                 randconfig-a016-20211128
i386                 randconfig-a014-20211128
arc                  randconfig-r043-20211128
s390                 randconfig-r044-20211128
riscv                randconfig-r042-20211128
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20211128
i386                 randconfig-c001-20211128
riscv                randconfig-c006-20211128
arm                  randconfig-c002-20211128
powerpc              randconfig-c003-20211128
x86_64               randconfig-c007-20211128
mips                 randconfig-c004-20211128
x86_64               randconfig-a001-20211128
x86_64               randconfig-a006-20211128
x86_64               randconfig-a003-20211128
x86_64               randconfig-a005-20211128
x86_64               randconfig-a004-20211128
x86_64               randconfig-a002-20211128
i386                 randconfig-a001-20211128
i386                 randconfig-a002-20211128
i386                 randconfig-a006-20211128
i386                 randconfig-a005-20211128
i386                 randconfig-a004-20211128
i386                 randconfig-a003-20211128
i386                 randconfig-a015-20211129
i386                 randconfig-a016-20211129
i386                 randconfig-a013-20211129
i386                 randconfig-a012-20211129
i386                 randconfig-a014-20211129
i386                 randconfig-a011-20211129
hexagon              randconfig-r045-20211129
hexagon              randconfig-r041-20211129
s390                 randconfig-r044-20211129
riscv                randconfig-r042-20211129

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

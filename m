Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70576319C1C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 10:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhBLJrq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Feb 2021 04:47:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:8662 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230263AbhBLJrc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Feb 2021 04:47:32 -0500
IronPort-SDR: NoxZoOfnfiAS12cpJ0ujSMtLJYQIt7pVUbsLQ+Hs1vTV/g/RPF8m3KnCzTs6MvVIr7vCJL6gBn
 TYLvNOZCt2Hw==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="169515621"
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="169515621"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 01:46:50 -0800
IronPort-SDR: /pPupc1J2GLw6/I2jaLpG6CEAPf6cjNSpfvCCOOyNUFUWtOuwxuCjAt2uIADOBTKeFC67Kvv80
 Xn1P2eMawxuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="422383239"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Feb 2021 01:46:49 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lAV2G-0004Yl-MM; Fri, 12 Feb 2021 09:46:48 +0000
Date:   Fri, 12 Feb 2021 17:46:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 16ad7b4b4f4a9d6a6452778c913205cb1591218e
Message-ID: <60264e6e.I5g4P7F8IkxGwE5k%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: 16ad7b4b4f4a9d6a6452778c913205cb1591218e  Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

elapsed time: 724m

configs tested: 133
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                    nommu_k210_defconfig
alpha                            alldefconfig
arc                     haps_hs_smp_defconfig
sh                               j2_defconfig
powerpc                      ppc64e_defconfig
arm                       netwinder_defconfig
arm                  colibri_pxa300_defconfig
powerpc                    ge_imp3a_defconfig
m68k                          atari_defconfig
mips                      bmips_stb_defconfig
powerpc                     stx_gp3_defconfig
arm                           sunxi_defconfig
arm                          prima2_defconfig
sh                ecovec24-romimage_defconfig
arm                          pcm027_defconfig
arm                        neponset_defconfig
sh                           se7780_defconfig
mips                     cu1830-neo_defconfig
mips                         tb0219_defconfig
sh                          rsk7264_defconfig
arm                            u300_defconfig
openrisc                            defconfig
arm                      tct_hammer_defconfig
arm                       aspeed_g5_defconfig
arm                         vf610m4_defconfig
arm                          lpd270_defconfig
arm                           corgi_defconfig
um                             i386_defconfig
arm                             rpc_defconfig
s390                          debug_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                       holly_defconfig
powerpc                     kmeter1_defconfig
powerpc                    amigaone_defconfig
mips                        omega2p_defconfig
arm                         s5pv210_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                           ip28_defconfig
sh                                  defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                      pmac32_defconfig
arm                         shannon_defconfig
powerpc                      chrp32_defconfig
arc                        vdk_hs38_defconfig
sparc                       sparc32_defconfig
mips                            e55_defconfig
mips                malta_kvm_guest_defconfig
arm                           spitz_defconfig
ia64                      gensparse_defconfig
arm                              alldefconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
x86_64               randconfig-a006-20210209
x86_64               randconfig-a001-20210209
x86_64               randconfig-a005-20210209
x86_64               randconfig-a004-20210209
x86_64               randconfig-a002-20210209
x86_64               randconfig-a003-20210209
i386                 randconfig-a001-20210209
i386                 randconfig-a005-20210209
i386                 randconfig-a003-20210209
i386                 randconfig-a002-20210209
i386                 randconfig-a006-20210209
i386                 randconfig-a004-20210209
x86_64               randconfig-a003-20210210
x86_64               randconfig-a002-20210210
x86_64               randconfig-a001-20210210
x86_64               randconfig-a004-20210210
x86_64               randconfig-a005-20210210
x86_64               randconfig-a006-20210210
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210209
x86_64               randconfig-a014-20210209
x86_64               randconfig-a015-20210209
x86_64               randconfig-a012-20210209
x86_64               randconfig-a016-20210209
x86_64               randconfig-a011-20210209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

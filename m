Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F55277801
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Sep 2020 19:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgIXRsI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Sep 2020 13:48:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:14459 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgIXRsH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Sep 2020 13:48:07 -0400
IronPort-SDR: fmRS+Osi1Bz3LcIQ2XLhnR1w2YbXu06UMUKwZ1kGiRYbHlroXLcWdNqHmFeMDhj3Ky1LzEsdvn
 v0B4u5DsUNlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="148939656"
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="148939656"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 10:48:07 -0700
IronPort-SDR: UWw9VXrN3tetWqF5/1qvSJbuEHYIjApjj8mpyFawVTEUvNTC036NyjWq9xehJwgV0lRsZqwR2q
 9UwBn76R22zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="347918916"
Received: from lkp-server01.sh.intel.com (HELO d1a6b931d9c6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Sep 2020 10:48:06 -0700
Received: from kbuild by d1a6b931d9c6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kLVLh-00004W-6A; Thu, 24 Sep 2020 17:48:05 +0000
Date:   Fri, 25 Sep 2020 01:47:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:pending] BUILD SUCCESS
 6167cb6dba6067d056ff7d204cbfe17d79a56f8a
Message-ID: <5f6cdba1.gW95gzpUgcQU/b2a%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  pending
branch HEAD: 6167cb6dba6067d056ff7d204cbfe17d79a56f8a  Merge tag 'mt76-for-kvalo-2020-09-23' of https://github.com/nbd168/wireless into pending

elapsed time: 722m

configs tested: 153
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                    sam440ep_defconfig
sh                      rts7751r2d1_defconfig
powerpc                    klondike_defconfig
arm                       imx_v6_v7_defconfig
sh                        sh7757lcr_defconfig
arm                         ebsa110_defconfig
sh                          rsk7264_defconfig
powerpc                 mpc8313_rdb_defconfig
ia64                          tiger_defconfig
sh                           se7206_defconfig
powerpc                     asp8347_defconfig
s390                             alldefconfig
c6x                        evmc6472_defconfig
microblaze                      mmu_defconfig
sh                          rsk7201_defconfig
i386                             alldefconfig
arm                        mini2440_defconfig
mips                         tb0226_defconfig
m68k                           sun3_defconfig
microblaze                          defconfig
s390                                defconfig
powerpc                      tqm8xx_defconfig
powerpc                    ge_imp3a_defconfig
mips                          rm200_defconfig
i386                                defconfig
arm                          lpd270_defconfig
arm                     davinci_all_defconfig
m68k                       m5275evb_defconfig
powerpc                     tqm8548_defconfig
arm                         nhk8815_defconfig
powerpc                     ep8248e_defconfig
sh                   secureedge5410_defconfig
powerpc                      ppc6xx_defconfig
sh                           se7619_defconfig
ia64                             allyesconfig
arm                        neponset_defconfig
powerpc                      makalu_defconfig
arm                            qcom_defconfig
sh                          r7780mp_defconfig
powerpc                       ebony_defconfig
xtensa                    smp_lx200_defconfig
m68k                        m5272c3_defconfig
arm                       aspeed_g4_defconfig
arm                         axm55xx_defconfig
m68k                            q40_defconfig
sh                           se7712_defconfig
arm                           corgi_defconfig
mips                 pnx8335_stb225_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      cm5200_defconfig
arm                           h5000_defconfig
m68k                        mvme147_defconfig
powerpc                     tqm8560_defconfig
powerpc                     kmeter1_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                        cell_defconfig
arm                        trizeps4_defconfig
mips                      maltaaprp_defconfig
sh                          rsk7203_defconfig
mips                           xway_defconfig
arm                            mmp2_defconfig
mips                       rbtx49xx_defconfig
mips                          ath79_defconfig
riscv                             allnoconfig
c6x                              allyesconfig
sh                          polaris_defconfig
sh                ecovec24-romimage_defconfig
csky                                defconfig
sh                          lboxre2_defconfig
arm                    vt8500_v6_v7_defconfig
sh                         microdev_defconfig
mips                            gpr_defconfig
arm                      integrator_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200924
i386                 randconfig-a006-20200924
i386                 randconfig-a003-20200924
i386                 randconfig-a004-20200924
i386                 randconfig-a005-20200924
i386                 randconfig-a001-20200924
i386                 randconfig-a002-20200923
i386                 randconfig-a006-20200923
i386                 randconfig-a003-20200923
i386                 randconfig-a004-20200923
i386                 randconfig-a005-20200923
i386                 randconfig-a001-20200923
x86_64               randconfig-a011-20200923
x86_64               randconfig-a013-20200923
x86_64               randconfig-a014-20200923
x86_64               randconfig-a015-20200923
x86_64               randconfig-a012-20200923
x86_64               randconfig-a016-20200923
i386                 randconfig-a012-20200923
i386                 randconfig-a014-20200923
i386                 randconfig-a016-20200923
i386                 randconfig-a013-20200923
i386                 randconfig-a011-20200923
i386                 randconfig-a015-20200923
i386                 randconfig-a012-20200924
i386                 randconfig-a014-20200924
i386                 randconfig-a016-20200924
i386                 randconfig-a013-20200924
i386                 randconfig-a011-20200924
i386                 randconfig-a015-20200924
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20200923
x86_64               randconfig-a005-20200923
x86_64               randconfig-a003-20200923
x86_64               randconfig-a004-20200923
x86_64               randconfig-a002-20200923
x86_64               randconfig-a001-20200923

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

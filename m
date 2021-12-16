Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DE2476A13
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 07:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhLPF7n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Dec 2021 00:59:43 -0500
Received: from mga02.intel.com ([134.134.136.20]:30219 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231777AbhLPF7m (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Dec 2021 00:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639634382; x=1671170382;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=F6uaKVsQxwcIoAmbKLgFr4zgPTXF5hIXj+IVTUF4XjU=;
  b=ch7uFjjegqznd9y0MAmfsckJHHfHOmT5KV+v3a1jC1zOh4fKiQzLfDmT
   pKHPgrknNHnwJt2yV/PVPvSX+DNMlLXUWnZNKBIbOSHqJhqDHP8jO+uDi
   6nOtnz1kV3UaRBn5ZwIcYktSoFwVheUeZow4Feut8zrPCDlsk4AZPBSw/
   pgDx0BgqLnXjo/MDraTMi97jlB74gKrSE49EUZtjBaWNsEfkIUHAeEiB0
   kRZ8u4914JzB2IBlsczU24SI8PrUU/cYpZjRQT4CNGO17iZs/I5zesboQ
   QGRot4QGLnSM3WxDm0J35mSJ75k/AIsjs+jliBzs4Wclnv09NQ5gj4Ol3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="226694064"
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="226694064"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 21:59:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="520157206"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 15 Dec 2021 21:59:40 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxjnn-0002oW-I1; Thu, 16 Dec 2021 05:59:39 +0000
Date:   Thu, 16 Dec 2021 13:58:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [kvalo-wireless-drivers-next:master] BUILD SUCCESS
 4d375c2e51d5b3227683e3a9a198a2f003959c76
Message-ID: <61bad59c.yrlXHhtewCYwFrms%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: 4d375c2e51d5b3227683e3a9a198a2f003959c76  rsi: fix array out of bound

elapsed time: 727m

configs tested: 147
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm                              allyesconfig
mips                 randconfig-c004-20211214
i386                 randconfig-c001-20211214
m68k                          hp300_defconfig
arm                        clps711x_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     tqm8540_defconfig
sh                          rsk7203_defconfig
arm                          moxart_defconfig
arm                      footbridge_defconfig
mips                            gpr_defconfig
sh                     magicpanelr2_defconfig
arm                         s3c6400_defconfig
arm                           stm32_defconfig
powerpc                       ppc64_defconfig
powerpc                 mpc837x_mds_defconfig
arm                          lpd270_defconfig
m68k                        mvme16x_defconfig
arm                            hisi_defconfig
powerpc                mpc7448_hpc2_defconfig
arc                          axs103_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                   sh7770_generic_defconfig
arm                         palmz72_defconfig
mips                          rb532_defconfig
arm                          exynos_defconfig
sh                         apsh4a3a_defconfig
arm                        mvebu_v5_defconfig
um                                  defconfig
sh                                  defconfig
sh                        edosk7760_defconfig
mips                          ath79_defconfig
arc                        vdk_hs38_defconfig
powerpc                      pcm030_defconfig
sh                             espt_defconfig
mips                 decstation_r4k_defconfig
sparc                               defconfig
powerpc                      katmai_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                           ci20_defconfig
arm                              alldefconfig
powerpc                      tqm8xx_defconfig
arm                          gemini_defconfig
mips                         tb0226_defconfig
sh                              ul2_defconfig
arm                            zeus_defconfig
nios2                         10m50_defconfig
powerpc                      arches_defconfig
xtensa                              defconfig
m68k                        stmark2_defconfig
powerpc                 mpc836x_rdk_defconfig
m68k                        m5407c3_defconfig
powerpc                          g5_defconfig
mips                     loongson1c_defconfig
sh                   rts7751r2dplus_defconfig
mips                         tb0287_defconfig
powerpc                     powernv_defconfig
arc                      axs103_smp_defconfig
arm                         orion5x_defconfig
sh                        edosk7705_defconfig
sh                          lboxre2_defconfig
arm                  randconfig-c002-20211214
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
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211214
x86_64               randconfig-a005-20211214
x86_64               randconfig-a001-20211214
x86_64               randconfig-a002-20211214
x86_64               randconfig-a003-20211214
x86_64               randconfig-a004-20211214
i386                 randconfig-a001-20211214
i386                 randconfig-a002-20211214
i386                 randconfig-a005-20211214
i386                 randconfig-a003-20211214
i386                 randconfig-a006-20211214
i386                 randconfig-a004-20211214
x86_64               randconfig-a006-20211216
x86_64               randconfig-a005-20211216
x86_64               randconfig-a001-20211216
x86_64               randconfig-a002-20211216
x86_64               randconfig-a003-20211216
x86_64               randconfig-a004-20211216
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
arm                  randconfig-c002-20211215
x86_64               randconfig-c007-20211215
riscv                randconfig-c006-20211215
mips                 randconfig-c004-20211215
i386                 randconfig-c001-20211215
s390                 randconfig-c005-20211215
powerpc              randconfig-c003-20211215
hexagon              randconfig-r045-20211214
s390                 randconfig-r044-20211214
riscv                randconfig-r042-20211214
hexagon              randconfig-r041-20211214
hexagon              randconfig-r045-20211216
s390                 randconfig-r044-20211216
riscv                randconfig-r042-20211216
hexagon              randconfig-r041-20211216

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

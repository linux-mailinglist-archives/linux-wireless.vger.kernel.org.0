Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B972808B3
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 22:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733183AbgJAUoT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 16:44:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:24580 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733266AbgJAUoL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 16:44:11 -0400
IronPort-SDR: dfrWQu4I90zZD6YcSjDH9z/oZsOQ76E/5URAu+Ttvirnifnh90YCBgKAOLJh+6uAc/qPE/p986
 e8Bs/sfEPQ3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="162909483"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="162909483"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:44:09 -0700
IronPort-SDR: brv7iu+IuLq3I/EKR3RT17E/sQn4vMkliYG6cc6GpGPhywK4RyH31q4JQaXtl1ycYTW9bLz2jf
 GcDymKAZ+srA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="294569369"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 01 Oct 2020 13:44:07 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kO5Qt-0000k9-Ci; Thu, 01 Oct 2020 20:44:07 +0000
Date:   Fri, 02 Oct 2020 04:43:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:pending] BUILD SUCCESS
 e32f6df7bbb8344f3ca8bb5545a443dd32ba2e1d
Message-ID: <5f763f76.unYEFEu2Ne5G3FRu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  pending
branch HEAD: e32f6df7bbb8344f3ca8bb5545a443dd32ba2e1d  Merge tag 'iwlwifi-next-for-kalle-2020-09-30' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next into pending

elapsed time: 724m

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
arm                         shannon_defconfig
arm                  colibri_pxa300_defconfig
mips                          ath25_defconfig
sh                        edosk7705_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                 linkstation_defconfig
c6x                         dsk6455_defconfig
powerpc64                        alldefconfig
mips                         tb0287_defconfig
arm                       cns3420vb_defconfig
arm                        realview_defconfig
csky                                defconfig
arm                         assabet_defconfig
mips                       rbtx49xx_defconfig
m68k                          hp300_defconfig
arm                          gemini_defconfig
arc                      axs103_smp_defconfig
csky                             alldefconfig
sh                            shmin_defconfig
powerpc                        cell_defconfig
c6x                        evmc6457_defconfig
powerpc                     asp8347_defconfig
arm                         mv78xx0_defconfig
arm                           tegra_defconfig
sh                           se7619_defconfig
mips                        bcm63xx_defconfig
nds32                            alldefconfig
nios2                         10m50_defconfig
powerpc                     rainier_defconfig
xtensa                       common_defconfig
sh                           sh2007_defconfig
powerpc                  iss476-smp_defconfig
mips                  cavium_octeon_defconfig
arm                             mxs_defconfig
mips                             allyesconfig
microblaze                          defconfig
sh                                  defconfig
parisc                              defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                     tqm8540_defconfig
xtensa                  cadence_csp_defconfig
sh                          lboxre2_defconfig
arm                         bcm2835_defconfig
powerpc                      mgcoge_defconfig
powerpc                  storcenter_defconfig
microblaze                      mmu_defconfig
m68k                             allyesconfig
s390                       zfcpdump_defconfig
powerpc                       ppc64_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     taishan_defconfig
arm                           spitz_defconfig
h8300                               defconfig
arm                           efm32_defconfig
arm                   milbeaut_m10v_defconfig
h8300                            alldefconfig
arm                           viper_defconfig
powerpc                      chrp32_defconfig
arm                           stm32_defconfig
mips                      loongson3_defconfig
powerpc                      makalu_defconfig
x86_64                              defconfig
arm                       imx_v6_v7_defconfig
arc                    vdk_hs38_smp_defconfig
mips                        bcm47xx_defconfig
m68k                         apollo_defconfig
arm                              zx_defconfig
sh                           se7343_defconfig
arm                            dove_defconfig
mips                        nlm_xlr_defconfig
mips                        jmr3927_defconfig
powerpc                      katmai_defconfig
powerpc                           allnoconfig
nios2                               defconfig
riscv                            alldefconfig
arm                         palmz72_defconfig
xtensa                  audio_kc705_defconfig
powerpc                     ksi8560_defconfig
sh                        sh7785lcr_defconfig
sh                          rsk7203_defconfig
sh                   sh7724_generic_defconfig
sh                             espt_defconfig
arm                          iop32x_defconfig
powerpc                 mpc837x_rdb_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a003-20200930
i386                 randconfig-a002-20200930
i386                 randconfig-a006-20200930
i386                 randconfig-a005-20200930
i386                 randconfig-a004-20200930
i386                 randconfig-a001-20200930
x86_64               randconfig-a015-20200930
x86_64               randconfig-a013-20200930
x86_64               randconfig-a012-20200930
x86_64               randconfig-a016-20200930
x86_64               randconfig-a014-20200930
x86_64               randconfig-a011-20200930
i386                 randconfig-a011-20200930
i386                 randconfig-a015-20200930
i386                 randconfig-a012-20200930
i386                 randconfig-a014-20200930
i386                 randconfig-a016-20200930
i386                 randconfig-a013-20200930
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20200930
x86_64               randconfig-a005-20200930
x86_64               randconfig-a003-20200930
x86_64               randconfig-a004-20200930
x86_64               randconfig-a002-20200930
x86_64               randconfig-a006-20200930

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

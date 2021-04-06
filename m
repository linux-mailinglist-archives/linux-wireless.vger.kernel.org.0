Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECFF355ED2
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Apr 2021 00:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbhDFWbh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Apr 2021 18:31:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:25089 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbhDFWbh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Apr 2021 18:31:37 -0400
IronPort-SDR: ZYBBWGAEJTb4O6vDUcYZLkGcR3jFH7yzC5bVJokJQX+/D0165xcNKtYyPPuKssbEhDtMNZcVS5
 tAnAqqmsBYsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="254505171"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="254505171"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 15:31:25 -0700
IronPort-SDR: Da9QGXuBA1TugupxeAN1S89gC0yqp4WqR5ULMauvzLzPEl/nPFdC9uGshWhfzk8wc0UC/QR/3f
 iOiSJCGa7rkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="381083508"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Apr 2021 15:31:24 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lTuEF-000CQa-U3; Tue, 06 Apr 2021 22:31:23 +0000
Date:   Wed, 07 Apr 2021 06:30:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:pending] BUILD SUCCESS
 a0398c302f9eb5519e5c5e1567b9077c7785d67f
Message-ID: <606ce110.7CWbhWyQvJ7fMlZ9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git pending
branch HEAD: a0398c302f9eb5519e5c5e1567b9077c7785d67f  Merge tag 'mt76-for-kvalo-2021-03-15' of https://github.com/nbd168/wireless into pending

elapsed time: 728m

configs tested: 122
configs skipped: 2

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
m68k                            q40_defconfig
powerpc                    mvme5100_defconfig
mips                          ath25_defconfig
powerpc                     tqm8540_defconfig
sh                           se7619_defconfig
sh                        sh7785lcr_defconfig
sh                               alldefconfig
arm                          pcm027_defconfig
m68k                           sun3_defconfig
arm                         shannon_defconfig
powerpc                     tqm5200_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     tqm8541_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          sdk7780_defconfig
sh                        edosk7760_defconfig
h8300                            alldefconfig
mips                        bcm47xx_defconfig
mips                           ip32_defconfig
arm                          pxa168_defconfig
arm                         lpc18xx_defconfig
mips                  maltasmvp_eva_defconfig
mips                           mtx1_defconfig
powerpc                mpc7448_hpc2_defconfig
s390                       zfcpdump_defconfig
sh                         microdev_defconfig
mips                        qi_lb60_defconfig
arm                        vexpress_defconfig
um                               alldefconfig
arc                        nsimosci_defconfig
arm                       aspeed_g5_defconfig
sparc                            alldefconfig
ia64                      gensparse_defconfig
arm                           viper_defconfig
mips                 decstation_r4k_defconfig
powerpc                      tqm8xx_defconfig
arm                       aspeed_g4_defconfig
m68k                         apollo_defconfig
sparc                       sparc32_defconfig
arm                     davinci_all_defconfig
arc                        vdk_hs38_defconfig
sh                          rsk7203_defconfig
sh                          sdk7786_defconfig
sparc                       sparc64_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210406
i386                 randconfig-a003-20210406
i386                 randconfig-a001-20210406
i386                 randconfig-a004-20210406
i386                 randconfig-a005-20210406
i386                 randconfig-a002-20210406
i386                 randconfig-a014-20210406
i386                 randconfig-a016-20210406
i386                 randconfig-a011-20210406
i386                 randconfig-a012-20210406
i386                 randconfig-a015-20210406
i386                 randconfig-a013-20210406
x86_64               randconfig-a004-20210406
x86_64               randconfig-a003-20210406
x86_64               randconfig-a005-20210406
x86_64               randconfig-a001-20210406
x86_64               randconfig-a002-20210406
x86_64               randconfig-a006-20210406
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210406
x86_64               randconfig-a015-20210406
x86_64               randconfig-a013-20210406
x86_64               randconfig-a011-20210406
x86_64               randconfig-a012-20210406
x86_64               randconfig-a016-20210406

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

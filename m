Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996203A9068
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jun 2021 06:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhFPEYK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Jun 2021 00:24:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:59461 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhFPEYJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Jun 2021 00:24:09 -0400
IronPort-SDR: sxkQe14sfLcxzULXBDvpWggkGNR3xFXWpxR8/oB2eIhw2PsKDlnoZ+jwIXrlIbhDKrM1LMj4Az
 n3/IBATab1Gg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="205930049"
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="205930049"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 21:22:04 -0700
IronPort-SDR: 7C1zd4zTQ8W2U3x59A0qi1A6ZeeSIlDvnKQoutxDoQ5rtvRxIo6Xf6kvcxix66cL5fcAbj/0Ha
 /mZm0CLCZOzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="553911197"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Jun 2021 21:22:02 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ltN3y-0000qF-A9; Wed, 16 Jun 2021 04:22:02 +0000
Date:   Wed, 16 Jun 2021 12:21:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:pending] BUILD SUCCESS
 c1919b71933727220507aac1b019302d58a9d97d
Message-ID: <60c97c5a.DFY0pzREDJSzKnn+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git pending
branch HEAD: c1919b71933727220507aac1b019302d58a9d97d  Merge tag 'mt76-for-kvalo-2021-06-10' of https://github.com/nbd168/wireless into pending

elapsed time: 720m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      chrp32_defconfig
xtensa                    smp_lx200_defconfig
mips                          ath79_defconfig
powerpc                  iss476-smp_defconfig
powerpc                          g5_defconfig
arm                            hisi_defconfig
xtensa                          iss_defconfig
powerpc                     kmeter1_defconfig
powerpc                      ep88xc_defconfig
arm64                            alldefconfig
arc                    vdk_hs38_smp_defconfig
m68k                         amcore_defconfig
microblaze                      mmu_defconfig
sh                           se7751_defconfig
x86_64                           alldefconfig
mips                       bmips_be_defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210615
i386                 randconfig-a006-20210615
i386                 randconfig-a004-20210615
i386                 randconfig-a001-20210615
i386                 randconfig-a005-20210615
i386                 randconfig-a003-20210615
i386                 randconfig-a015-20210615
i386                 randconfig-a013-20210615
i386                 randconfig-a016-20210615
i386                 randconfig-a012-20210615
i386                 randconfig-a014-20210615
i386                 randconfig-a011-20210615
x86_64               randconfig-a001-20210615
x86_64               randconfig-a004-20210615
x86_64               randconfig-a002-20210615
x86_64               randconfig-a003-20210615
x86_64               randconfig-a006-20210615
x86_64               randconfig-a005-20210615
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210615
x86_64               randconfig-a015-20210615
x86_64               randconfig-a011-20210615
x86_64               randconfig-a012-20210615
x86_64               randconfig-a014-20210615
x86_64               randconfig-a016-20210615
x86_64               randconfig-a013-20210615

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

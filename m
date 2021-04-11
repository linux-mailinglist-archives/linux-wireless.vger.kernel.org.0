Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1192E35B713
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 23:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhDKVsE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 17:48:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:61996 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231405AbhDKVsE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 17:48:04 -0400
IronPort-SDR: 6f/XDEXXXGAVaersf4Hlf0PuMV5tPhpBmeKF95h6DyJQbjII0gAymqwdLfGjFBe4nczxqwifNn
 chMPhXYQgcHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="194102771"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="194102771"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 14:47:47 -0700
IronPort-SDR: fBszKqItA8zmvhsn8x8k84XPlkiSl/C8BT7WAn1HLKxNYmqXoGZtLGoSXKA/ttVBek3uJgZRkh
 vPoO0gSjQv+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="398143548"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 11 Apr 2021 14:47:46 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lVhvl-000J7k-EQ; Sun, 11 Apr 2021 21:47:45 +0000
Date:   Mon, 12 Apr 2021 05:47:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:pending] BUILD SUCCESS
 d876da976e5b015b0ea3f997f18517341fa3cd12
Message-ID: <60736e7d.KkGnrkcNr+RrF0Xo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git pending
branch HEAD: d876da976e5b015b0ea3f997f18517341fa3cd12  Merge tag 'mt76-for-kvalo-2021-03-18' of https://github.com/nbd168/wireless into pending

elapsed time: 724m

configs tested: 100
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
powerpc                    amigaone_defconfig
sh                          r7785rp_defconfig
um                             i386_defconfig
xtensa                  nommu_kc705_defconfig
sh                           se7705_defconfig
mips                     loongson1b_defconfig
sh                        sh7763rdp_defconfig
sh                           se7712_defconfig
mips                     loongson1c_defconfig
mips                            e55_defconfig
powerpc                      pasemi_defconfig
powerpc                 mpc8540_ads_defconfig
arm                        spear6xx_defconfig
sh                                  defconfig
sh                          landisk_defconfig
h8300                    h8300h-sim_defconfig
mips                  decstation_64_defconfig
sparc                               defconfig
sh                            titan_defconfig
alpha                               defconfig
arm                         cm_x300_defconfig
sh                        edosk7760_defconfig
sparc                       sparc64_defconfig
sh                           se7343_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210411
i386                 randconfig-a001-20210411
i386                 randconfig-a006-20210411
i386                 randconfig-a005-20210411
i386                 randconfig-a004-20210411
i386                 randconfig-a002-20210411
i386                 randconfig-a015-20210411
i386                 randconfig-a014-20210411
i386                 randconfig-a013-20210411
i386                 randconfig-a012-20210411
i386                 randconfig-a016-20210411
i386                 randconfig-a011-20210411
x86_64               randconfig-a003-20210411
x86_64               randconfig-a002-20210411
x86_64               randconfig-a001-20210411
x86_64               randconfig-a005-20210411
x86_64               randconfig-a006-20210411
x86_64               randconfig-a004-20210411
riscv                    nommu_k210_defconfig
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
x86_64               randconfig-a014-20210411
x86_64               randconfig-a015-20210411
x86_64               randconfig-a011-20210411
x86_64               randconfig-a013-20210411
x86_64               randconfig-a012-20210411
x86_64               randconfig-a016-20210411

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

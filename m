Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743243633D1
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 07:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhDRFWN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 01:22:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:64652 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbhDRFWM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 01:22:12 -0400
IronPort-SDR: m/6dJBq5PknBI4yuWscxETWzBJ+fHQ8+Zm7yTbE67LYzT05V/mT2rcHWk6gWfykLuKgVqscQMw
 +hmWHFdjdSjQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9957"; a="194758629"
X-IronPort-AV: E=Sophos;i="5.82,231,1613462400"; 
   d="scan'208";a="194758629"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2021 22:21:45 -0700
IronPort-SDR: cFAlJq0FgfRBXPt61a4m0zdKzrprIDerLRFuNPTjvdu2SBLyK7Y8P3Eox99fCc+8qC94DJmpZw
 Zt79CD7QUc9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,231,1613462400"; 
   d="scan'208";a="383415520"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 17 Apr 2021 22:21:43 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lXzsM-00019L-Rv; Sun, 18 Apr 2021 05:21:42 +0000
Date:   Sun, 18 Apr 2021 13:21:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:pending] BUILD SUCCESS
 ef2c0c3ce050ced96206de8c1e43359a44d1090b
Message-ID: <607bc1c2.++bK7QmW2Uo6u6OV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git pending
branch HEAD: ef2c0c3ce050ced96206de8c1e43359a44d1090b  Merge tag 'mt76-for-kvalo-2021-04-17' of https://github.com/nbd168/wireless into pending

elapsed time: 723m

configs tested: 108
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                             allyesconfig
h8300                            allyesconfig
arm                        clps711x_defconfig
sparc                       sparc32_defconfig
arm                       multi_v4t_defconfig
m68k                                defconfig
arm                        realview_defconfig
xtensa                              defconfig
ia64                      gensparse_defconfig
sh                        sh7757lcr_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                      obs600_defconfig
mips                           xway_defconfig
mips                        qi_lb60_defconfig
arm                       netwinder_defconfig
m68k                        mvme147_defconfig
mips                           ci20_defconfig
arm                         s5pv210_defconfig
mips                       bmips_be_defconfig
powerpc                     stx_gp3_defconfig
arm                      integrator_defconfig
arm                          lpd270_defconfig
m68k                          multi_defconfig
arm                    vt8500_v6_v7_defconfig
arm                       aspeed_g4_defconfig
h8300                     edosk2674_defconfig
openrisc                            defconfig
sh                          sdk7786_defconfig
mips                         bigsur_defconfig
powerpc                      ppc6xx_defconfig
sh                              ul2_defconfig
arm                       spear13xx_defconfig
arm                          collie_defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210418
i386                 randconfig-a001-20210418
i386                 randconfig-a006-20210418
i386                 randconfig-a005-20210418
i386                 randconfig-a004-20210418
i386                 randconfig-a002-20210418
x86_64               randconfig-a014-20210418
x86_64               randconfig-a015-20210418
x86_64               randconfig-a013-20210418
x86_64               randconfig-a011-20210418
x86_64               randconfig-a012-20210418
x86_64               randconfig-a016-20210418
i386                 randconfig-a015-20210418
i386                 randconfig-a013-20210418
i386                 randconfig-a014-20210418
i386                 randconfig-a016-20210418
i386                 randconfig-a012-20210418
i386                 randconfig-a011-20210418
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210418
x86_64               randconfig-a001-20210418
x86_64               randconfig-a005-20210418
x86_64               randconfig-a002-20210418
x86_64               randconfig-a006-20210418
x86_64               randconfig-a004-20210418

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A3F3633FA
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 08:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbhDRGM1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 02:12:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:9135 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235958AbhDRGMX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 02:12:23 -0400
IronPort-SDR: 0e4iTazG6SpxeMgNDHvgVb+h5S88MMzQ/q9SKCgT7/MTVnbrFRL1gL/bgbvsx/d8z251oSVdcY
 EFgiqiUuHWsQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9957"; a="193079258"
X-IronPort-AV: E=Sophos;i="5.82,231,1613462400"; 
   d="scan'208";a="193079258"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2021 23:11:45 -0700
IronPort-SDR: tg0RDIl5MZOCEVhuSjHtN7uetWVvPMt8R5hK4VY39UjZOyhFkx9Mr66w9RRYbNopxB7rPOSs/P
 fjoXGfMlGXtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,231,1613462400"; 
   d="scan'208";a="426111012"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 17 Apr 2021 23:11:44 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lY0el-00019q-EF; Sun, 18 Apr 2021 06:11:43 +0000
Date:   Sun, 18 Apr 2021 14:11:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 7909a590eba6d021f104958857cbc4f0089daceb
Message-ID: <607bcd77.KZMGUWdMhznh5vSw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: 7909a590eba6d021f104958857cbc4f0089daceb  airo: work around stack usage warning

elapsed time: 724m

configs tested: 102
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
arm                        realview_defconfig
arm                       multi_v4t_defconfig
xtensa                              defconfig
ia64                      gensparse_defconfig
sh                        sh7757lcr_defconfig
powerpc                 mpc836x_mds_defconfig
arm                         s5pv210_defconfig
mips                       bmips_be_defconfig
powerpc                     stx_gp3_defconfig
arm                      integrator_defconfig
arm                          lpd270_defconfig
m68k                          multi_defconfig
i386                             alldefconfig
nios2                         10m50_defconfig
sh                            titan_defconfig
mips                     loongson1c_defconfig
powerpc                     pseries_defconfig
mips                         mpc30x_defconfig
arm                        clps711x_defconfig
mips                         bigsur_defconfig
powerpc                      ppc6xx_defconfig
sh                              ul2_defconfig
arm                       spear13xx_defconfig
arm                          collie_defconfig
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
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a003-20210418
x86_64               randconfig-a001-20210418
x86_64               randconfig-a005-20210418
x86_64               randconfig-a002-20210418
x86_64               randconfig-a006-20210418
x86_64               randconfig-a004-20210418

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

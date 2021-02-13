Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DB831AAFA
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Feb 2021 12:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhBMLQ4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Feb 2021 06:16:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:31591 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhBMLQy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Feb 2021 06:16:54 -0500
IronPort-SDR: NDgQ8oxjTN9o6tU9VfGjaSB9Iv51XGKCC3jBeXJSm0IWEjo/K+2+cWi3+RZCXNcWTNN4YKUP/z
 Rx0TVgCrJd6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="244007192"
X-IronPort-AV: E=Sophos;i="5.81,176,1610438400"; 
   d="scan'208";a="244007192"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2021 03:16:13 -0800
IronPort-SDR: 0vI5EkArZ4nuNsDfpM9qB9P7HxQ+z9LYfkUdPvekUDTx0DZGLH6a3zI2qFTx6LHJWAhweakHza
 EXzf0wmi0YUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,176,1610438400"; 
   d="scan'208";a="587779351"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Feb 2021 03:16:12 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lAsuJ-0005MC-Kg; Sat, 13 Feb 2021 11:16:11 +0000
Date:   Sat, 13 Feb 2021 19:15:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 9d083348e938eb0330639ad08dcfe493a59a8a40
Message-ID: <6027b4c0.dAylGVEliRM/pclE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: 9d083348e938eb0330639ad08dcfe493a59a8a40  rtw88: 8822c: update RF_B (2/2) parameter tables to v60

elapsed time: 726m

configs tested: 116
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                          moxart_defconfig
arm                        spear6xx_defconfig
openrisc                 simple_smp_defconfig
sh                      rts7751r2d1_defconfig
m68k                            q40_defconfig
arm                            lart_defconfig
arm                            pleb_defconfig
arm                   milbeaut_m10v_defconfig
h8300                            alldefconfig
powerpc                     akebono_defconfig
sh                           se7206_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                          pcm027_defconfig
xtensa                    smp_lx200_defconfig
sh                     sh7710voipgw_defconfig
mips                           jazz_defconfig
arm                       netwinder_defconfig
arm                        magician_defconfig
arc                              alldefconfig
mips                        nlm_xlp_defconfig
arm                          pxa3xx_defconfig
sh                         ap325rxa_defconfig
powerpc                       eiger_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc64e_defconfig
mips                           ci20_defconfig
powerpc                     mpc5200_defconfig
arm                        clps711x_defconfig
arc                        nsim_700_defconfig
powerpc                      pmac32_defconfig
powerpc                        icon_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210209
i386                 randconfig-a005-20210209
i386                 randconfig-a003-20210209
i386                 randconfig-a002-20210209
i386                 randconfig-a006-20210209
i386                 randconfig-a004-20210209
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
i386                 randconfig-a016-20210211
i386                 randconfig-a014-20210211
i386                 randconfig-a012-20210211
i386                 randconfig-a013-20210211
i386                 randconfig-a011-20210211
i386                 randconfig-a015-20210211
x86_64               randconfig-a006-20210209
x86_64               randconfig-a001-20210209
x86_64               randconfig-a005-20210209
x86_64               randconfig-a004-20210209
x86_64               randconfig-a002-20210209
x86_64               randconfig-a003-20210209
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

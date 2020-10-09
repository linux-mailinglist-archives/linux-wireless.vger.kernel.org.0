Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0145328810B
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Oct 2020 06:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgJIEOR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Oct 2020 00:14:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:47295 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgJIEOR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Oct 2020 00:14:17 -0400
IronPort-SDR: sPHXOo9qJcJIKwXChzAXg86BOdNXpA99yOMcKXo2sLCVT9Qw0UGBMBOn7IxNCWLEe2ePiD8Puk
 B3VKRArCp2bA==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="250134823"
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="250134823"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 21:14:16 -0700
IronPort-SDR: uEWl0EP78TRV5ZxP0Ba8d9+64jpEFMF6DjYn9cGYQZeDcDXsDnY8MwqSmdaT65KqSwiCb496QO
 GWI0gAZWqq+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="462050680"
Received: from lkp-server02.sh.intel.com (HELO 80eb06af76cf) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Oct 2020 21:14:14 -0700
Received: from kbuild by 80eb06af76cf with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kQjnK-0000AS-5n; Fri, 09 Oct 2020 04:14:14 +0000
Date:   Fri, 09 Oct 2020 12:13:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:pending] BUILD SUCCESS
 13b3c64910dbebb8d20a41bc03ea1d4e03876903
Message-ID: <5f7fe362.+dgiu7dELerJgHbd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  pending
branch HEAD: 13b3c64910dbebb8d20a41bc03ea1d4e03876903  iwlwifi: bump FW API to 59 for AX devices

elapsed time: 720m

configs tested: 139
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                  colibri_pxa300_defconfig
m68k                       m5475evb_defconfig
mips                      fuloong2e_defconfig
arm                          exynos_defconfig
powerpc                  mpc885_ads_defconfig
mips                      bmips_stb_defconfig
arm                      footbridge_defconfig
powerpc                         ps3_defconfig
sh                 kfr2r09-romimage_defconfig
arm                           h3600_defconfig
powerpc                     mpc512x_defconfig
sh                          landisk_defconfig
mips                     decstation_defconfig
powerpc                     pseries_defconfig
arm                       netwinder_defconfig
arm                          ep93xx_defconfig
m68k                        m5307c3_defconfig
m68k                       m5275evb_defconfig
riscv                             allnoconfig
powerpc                     ppa8548_defconfig
openrisc                    or1ksim_defconfig
sh                          rsk7201_defconfig
mips                      malta_kvm_defconfig
sh                           se7721_defconfig
powerpc                      chrp32_defconfig
arm                         lpc18xx_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                      pic32mzda_defconfig
arm                         s5pv210_defconfig
x86_64                              defconfig
arm                             mxs_defconfig
powerpc                      ppc6xx_defconfig
riscv                               defconfig
arm                    vt8500_v6_v7_defconfig
mips                        qi_lb60_defconfig
c6x                        evmc6472_defconfig
sh                     sh7710voipgw_defconfig
m68k                          multi_defconfig
mips                         tb0219_defconfig
sh                          urquell_defconfig
ia64                        generic_defconfig
arm                         bcm2835_defconfig
sh                             espt_defconfig
mips                      loongson3_defconfig
h8300                     edosk2674_defconfig
arm                     eseries_pxa_defconfig
m68k                          amiga_defconfig
mips                           xway_defconfig
sh                              ul2_defconfig
sh                          lboxre2_defconfig
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
x86_64               randconfig-a004-20201008
x86_64               randconfig-a003-20201008
x86_64               randconfig-a005-20201008
x86_64               randconfig-a001-20201008
x86_64               randconfig-a002-20201008
x86_64               randconfig-a006-20201008
i386                 randconfig-a006-20201008
i386                 randconfig-a005-20201008
i386                 randconfig-a001-20201008
i386                 randconfig-a004-20201008
i386                 randconfig-a002-20201008
i386                 randconfig-a003-20201008
x86_64               randconfig-a012-20201009
x86_64               randconfig-a015-20201009
x86_64               randconfig-a013-20201009
x86_64               randconfig-a014-20201009
x86_64               randconfig-a011-20201009
x86_64               randconfig-a016-20201009
i386                 randconfig-a015-20201009
i386                 randconfig-a013-20201009
i386                 randconfig-a014-20201009
i386                 randconfig-a016-20201009
i386                 randconfig-a011-20201009
i386                 randconfig-a012-20201009
i386                 randconfig-a015-20201008
i386                 randconfig-a013-20201008
i386                 randconfig-a014-20201008
i386                 randconfig-a016-20201008
i386                 randconfig-a011-20201008
i386                 randconfig-a012-20201008
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20201008
x86_64               randconfig-a015-20201008
x86_64               randconfig-a013-20201008
x86_64               randconfig-a014-20201008
x86_64               randconfig-a011-20201008
x86_64               randconfig-a016-20201008
x86_64               randconfig-a004-20201009
x86_64               randconfig-a003-20201009
x86_64               randconfig-a005-20201009
x86_64               randconfig-a001-20201009
x86_64               randconfig-a002-20201009
x86_64               randconfig-a006-20201009

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7265309399
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Jan 2021 10:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhA3JnY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Jan 2021 04:43:24 -0500
Received: from mga01.intel.com ([192.55.52.88]:45287 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhA3Jhl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Jan 2021 04:37:41 -0500
IronPort-SDR: J6uNHDAQBVx5syfekeP42G7T/go2cduJ/AogSTMdrJxR4cl0HuqbS6mXLEXijmUnPm7/bPE3bp
 ME+qNnW4ZlxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="199369138"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="199369138"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 22:59:54 -0800
IronPort-SDR: ZP8SxT7lidCvnBWP0NxefSByK/0Nm/DqeeNTa0h0DvNuEN9en0CVLQ/weJz5nyHP9+pZENvYvW
 fuGNmmR+5Z3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="431325917"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 29 Jan 2021 22:59:53 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l5kEa-0004M6-Gd; Sat, 30 Jan 2021 06:59:52 +0000
Date:   Sat, 30 Jan 2021 14:59:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:pending] BUILD SUCCESS
 20fe1e68f89ee43e97038c312c18b2fd82ce1041
Message-ID: <601503ce.ZZoJXqEyjVvIX03z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git pending
branch HEAD: 20fe1e68f89ee43e97038c312c18b2fd82ce1041  Merge tag 'mt76-for-kvalo-2021-01-29' of https://github.com/nbd168/wireless into pending

elapsed time: 724m

configs tested: 105
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       imx_v4_v5_defconfig
riscv                             allnoconfig
m68k                           sun3_defconfig
riscv                            allmodconfig
arm                  colibri_pxa300_defconfig
x86_64                           allyesconfig
powerpc                 mpc8315_rdb_defconfig
mips                         rt305x_defconfig
sh                          kfr2r09_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                             rpc_defconfig
arm                      jornada720_defconfig
arc                          axs101_defconfig
powerpc                 mpc8540_ads_defconfig
sh                               j2_defconfig
arm                          ep93xx_defconfig
sh                        dreamcast_defconfig
sh                          rsk7203_defconfig
arm                      tct_hammer_defconfig
powerpc                    mvme5100_defconfig
sh                           se7712_defconfig
c6x                        evmc6474_defconfig
arm                         shannon_defconfig
mips                      pistachio_defconfig
arm                        multi_v5_defconfig
mips                          ath79_defconfig
sh                           se7721_defconfig
xtensa                         virt_defconfig
powerpc                    amigaone_defconfig
mips                      pic32mzda_defconfig
powerpc                     asp8347_defconfig
sh                   sh7770_generic_defconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210130
i386                 randconfig-a003-20210130
i386                 randconfig-a002-20210130
i386                 randconfig-a001-20210130
i386                 randconfig-a004-20210130
i386                 randconfig-a006-20210130
i386                 randconfig-a013-20210130
i386                 randconfig-a011-20210130
i386                 randconfig-a015-20210130
i386                 randconfig-a012-20210130
i386                 randconfig-a014-20210130
i386                 randconfig-a016-20210130
x86_64               randconfig-a004-20210130
x86_64               randconfig-a002-20210130
x86_64               randconfig-a001-20210130
x86_64               randconfig-a005-20210130
x86_64               randconfig-a006-20210130
x86_64               randconfig-a003-20210130
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20210129
x86_64               randconfig-a015-20210129
x86_64               randconfig-a016-20210129
x86_64               randconfig-a011-20210129
x86_64               randconfig-a013-20210129
x86_64               randconfig-a014-20210129

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

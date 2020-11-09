Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B008E2AC1DC
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 18:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbgKIRJk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 12:09:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:53333 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731177AbgKIRJj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 12:09:39 -0500
IronPort-SDR: eYK/5Fsgq3r5C6KBrZzxBsRc5bEkpWaUaHTO5k29rCljwg7itxg3YUY6/vEqC3f7BLsSJ4H3ex
 sld++lTBPW/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="167249969"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="167249969"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 09:09:38 -0800
IronPort-SDR: 3VF4R8+6VNOaVedM4BHjcDjv5p7aQUKI/cuwYOyp6YVjJRHIRh9bZ1o1O3bFrDoddpzWa7NRbx
 cgf8CDDDyM7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="365135638"
Received: from lkp-server01.sh.intel.com (HELO d0be80f1a028) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Nov 2020 09:09:37 -0800
Received: from kbuild by d0be80f1a028 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kcAfg-0000JN-L7; Mon, 09 Nov 2020 17:09:36 +0000
Date:   Tue, 10 Nov 2020 01:09:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 9db946284e07bb27309dd546b7fee528664ba82a
Message-ID: <5fa977cf.lnxvqsM8IcAyNZnb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  master
branch HEAD: 9db946284e07bb27309dd546b7fee528664ba82a  brcmfmac: Fix memory leak for unpaired brcmf_{alloc/free}

elapsed time: 952m

configs tested: 125
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                        nsim_700_defconfig
powerpc                       holly_defconfig
xtensa                  audio_kc705_defconfig
sh                           se7343_defconfig
arm                  colibri_pxa270_defconfig
x86_64                           allyesconfig
openrisc                 simple_smp_defconfig
xtensa                  cadence_csp_defconfig
mips                      maltaaprp_defconfig
powerpc                    sam440ep_defconfig
powerpc                     pseries_defconfig
m68k                         amcore_defconfig
arm                         s5pv210_defconfig
arm                         palmz72_defconfig
arm                        mvebu_v7_defconfig
mips                      pistachio_defconfig
mips                        bcm63xx_defconfig
arm                         shannon_defconfig
arm                              zx_defconfig
sparc                            alldefconfig
mips                  cavium_octeon_defconfig
m68k                             alldefconfig
nios2                         10m50_defconfig
powerpc                     tqm8548_defconfig
c6x                        evmc6474_defconfig
sh                          rsk7201_defconfig
nios2                         3c120_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                          badge4_defconfig
arm                       multi_v4t_defconfig
h8300                               defconfig
arm                          collie_defconfig
arc                                 defconfig
mips                      fuloong2e_defconfig
sh                         microdev_defconfig
arm                            mmp2_defconfig
sh                        sh7757lcr_defconfig
arm                       omap2plus_defconfig
mips                           ip27_defconfig
powerpc                 mpc8560_ads_defconfig
mips                        qi_lb60_defconfig
powerpc                 mpc836x_mds_defconfig
m68k                        m5307c3_defconfig
arm                             rpc_defconfig
m68k                        m5272c3_defconfig
c6x                              alldefconfig
powerpc                      pmac32_defconfig
arm                          imote2_defconfig
arc                        vdk_hs38_defconfig
arm                          pcm027_defconfig
arm                        realview_defconfig
mips                          rb532_defconfig
mips                        nlm_xlr_defconfig
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
x86_64               randconfig-a004-20201109
x86_64               randconfig-a002-20201109
x86_64               randconfig-a003-20201109
x86_64               randconfig-a005-20201109
x86_64               randconfig-a006-20201109
x86_64               randconfig-a001-20201109
i386                 randconfig-a004-20201109
i386                 randconfig-a006-20201109
i386                 randconfig-a005-20201109
i386                 randconfig-a001-20201109
i386                 randconfig-a003-20201109
i386                 randconfig-a002-20201109
i386                 randconfig-a014-20201109
i386                 randconfig-a015-20201109
i386                 randconfig-a013-20201109
i386                 randconfig-a016-20201109
i386                 randconfig-a011-20201109
i386                 randconfig-a012-20201109
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20201109
x86_64               randconfig-a015-20201109
x86_64               randconfig-a013-20201109
x86_64               randconfig-a011-20201109
x86_64               randconfig-a014-20201109
x86_64               randconfig-a016-20201109

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

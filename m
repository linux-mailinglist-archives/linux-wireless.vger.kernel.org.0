Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C635845FCDC
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Nov 2021 06:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbhK0F2y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Nov 2021 00:28:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:31722 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239548AbhK0F0x (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Nov 2021 00:26:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="321974586"
X-IronPort-AV: E=Sophos;i="5.87,268,1631602800"; 
   d="scan'208";a="321974586"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 21:23:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,268,1631602800"; 
   d="scan'208";a="457880360"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 26 Nov 2021 21:23:38 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqqBV-00096R-55; Sat, 27 Nov 2021 05:23:37 +0000
Date:   Sat, 27 Nov 2021 13:23:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [kvalo-wireless-drivers-next:master] BUILD SUCCESS
 d1e69b5492d1826356e516685977b41d60dbee26
Message-ID: <61a1c0bc.1fZfDcUbunDPkuoX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: d1e69b5492d1826356e516685977b41d60dbee26  wilc1000: remove '-Wunused-but-set-variable' warning in chip_wakeup()

elapsed time: 722m

configs tested: 156
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211126
powerpc              randconfig-c003-20211126
mips                 randconfig-c004-20211126
arm                            zeus_defconfig
arm                  colibri_pxa300_defconfig
arm                         lpc32xx_defconfig
ia64                             allyesconfig
powerpc                   bluestone_defconfig
powerpc                     pq2fads_defconfig
xtensa                    xip_kc705_defconfig
powerpc                 canyonlands_defconfig
sh                              ul2_defconfig
s390                       zfcpdump_defconfig
arm                       omap2plus_defconfig
powerpc                    adder875_defconfig
arm                            dove_defconfig
m68k                        m5272c3_defconfig
arm                        spear3xx_defconfig
i386                             alldefconfig
powerpc                 mpc8272_ads_defconfig
parisc                generic-32bit_defconfig
powerpc                     akebono_defconfig
powerpc                     mpc83xx_defconfig
sh                        edosk7760_defconfig
powerpc                 mpc8560_ads_defconfig
m68k                          sun3x_defconfig
arm                          ep93xx_defconfig
arm                          simpad_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                     tqm8540_defconfig
sh                           se7705_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                          g5_defconfig
arm                        mvebu_v5_defconfig
arm                            hisi_defconfig
sh                           se7750_defconfig
arm                         hackkit_defconfig
sh                             sh03_defconfig
powerpc                     ep8248e_defconfig
sh                            titan_defconfig
arm                            xcep_defconfig
powerpc                    sam440ep_defconfig
sh                           se7724_defconfig
powerpc                       eiger_defconfig
xtensa                              defconfig
arm                        neponset_defconfig
sh                               j2_defconfig
arm64                            alldefconfig
powerpc                     rainier_defconfig
xtensa                  audio_kc705_defconfig
powerpc                     mpc5200_defconfig
sh                           se7722_defconfig
sh                          sdk7780_defconfig
arm                          pcm027_defconfig
powerpc                    gamecube_defconfig
arm                          moxart_defconfig
powerpc                 mpc832x_rdb_defconfig
sparc                       sparc64_defconfig
powerpc                  iss476-smp_defconfig
sh                          kfr2r09_defconfig
m68k                         apollo_defconfig
m68k                        m5407c3_defconfig
arm                            pleb_defconfig
xtensa                    smp_lx200_defconfig
sh                         microdev_defconfig
sh                        apsh4ad0a_defconfig
sh                 kfr2r09-romimage_defconfig
arm                     eseries_pxa_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                           sh2007_defconfig
arm                  randconfig-c002-20211126
ia64                             allmodconfig
ia64                                defconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a014-20211126
x86_64               randconfig-a011-20211126
x86_64               randconfig-a012-20211126
x86_64               randconfig-a016-20211126
x86_64               randconfig-a013-20211126
x86_64               randconfig-a015-20211126
i386                 randconfig-a016-20211126
i386                 randconfig-a015-20211126
i386                 randconfig-a012-20211126
i386                 randconfig-a013-20211126
i386                 randconfig-a014-20211126
i386                 randconfig-a011-20211126
arc                  randconfig-r043-20211126
s390                 randconfig-r044-20211126
riscv                randconfig-r042-20211126
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20211126
i386                 randconfig-c001-20211126
powerpc              randconfig-c003-20211126
riscv                randconfig-c006-20211126
arm                  randconfig-c002-20211126
x86_64               randconfig-c007-20211126
mips                 randconfig-c004-20211126
x86_64               randconfig-a001-20211126
x86_64               randconfig-a003-20211126
x86_64               randconfig-a006-20211126
x86_64               randconfig-a004-20211126
x86_64               randconfig-a005-20211126
x86_64               randconfig-a002-20211126
i386                 randconfig-a002-20211126
i386                 randconfig-a001-20211126
i386                 randconfig-a005-20211126
i386                 randconfig-a006-20211126
i386                 randconfig-a004-20211126
i386                 randconfig-a003-20211126
hexagon              randconfig-r045-20211126
hexagon              randconfig-r041-20211126

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

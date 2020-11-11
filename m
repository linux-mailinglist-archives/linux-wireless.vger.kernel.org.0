Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5C82AEABF
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 09:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgKKICp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 03:02:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:6356 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgKKICp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 03:02:45 -0500
IronPort-SDR: EH1irqoCIbD3VHTMVeGucpU7x9HOy1EFsmNZSB9J47RIWtbRMPvI7DIc/zfcG+pN6x4RUfSVnP
 c8gwQAqVCAXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="169327881"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="169327881"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 00:02:40 -0800
IronPort-SDR: zGI/qq0aNlD50qvlvFPlWqD6Rzmx5aWbaddE4IgeRcjkrhWkRuZ4jk6MtFC3b7SHONoIHbXO3N
 IlhCajyfchlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="356538115"
Received: from lkp-server02.sh.intel.com (HELO 5b2c7e53fe46) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 11 Nov 2020 00:02:39 -0800
Received: from kbuild by 5b2c7e53fe46 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kcl5S-00000t-MU; Wed, 11 Nov 2020 08:02:38 +0000
Date:   Wed, 11 Nov 2020 16:02:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 1ccaa898868d1971a6480d7d55668de522f5847f
Message-ID: <5fab9a7a.2Htk5odhhoSgLHKm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  master
branch HEAD: 1ccaa898868d1971a6480d7d55668de522f5847f  rtw88: coex: simplify the setting and condition about WLAN TX limitation

elapsed time: 777m

configs tested: 137
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sparc                               defconfig
arm                             mxs_defconfig
arm                      pxa255-idp_defconfig
mips                           ip32_defconfig
openrisc                 simple_smp_defconfig
arm                    vt8500_v6_v7_defconfig
arm                          pxa3xx_defconfig
arm                           corgi_defconfig
arm                            mmp2_defconfig
ia64                      gensparse_defconfig
ia64                             alldefconfig
powerpc                    sam440ep_defconfig
nios2                         10m50_defconfig
arm                          exynos_defconfig
xtensa                          iss_defconfig
powerpc                     skiroot_defconfig
sh                           se7751_defconfig
powerpc                     tqm5200_defconfig
xtensa                              defconfig
arm                        trizeps4_defconfig
xtensa                    xip_kc705_defconfig
arm                            hisi_defconfig
arm                          badge4_defconfig
sh                           se7780_defconfig
powerpc                     tqm8541_defconfig
arm                          pcm027_defconfig
riscv                    nommu_virt_defconfig
sh                        dreamcast_defconfig
sh                     sh7710voipgw_defconfig
mips                           ip28_defconfig
h8300                     edosk2674_defconfig
arm                        mini2440_defconfig
arc                          axs101_defconfig
mips                           jazz_defconfig
arm                            pleb_defconfig
mips                  cavium_octeon_defconfig
mips                     decstation_defconfig
powerpc                       ppc64_defconfig
nds32                             allnoconfig
sh                          r7780mp_defconfig
powerpc                       ebony_defconfig
alpha                               defconfig
arm                          lpd270_defconfig
powerpc                     ppa8548_defconfig
m68k                            q40_defconfig
arc                      axs103_smp_defconfig
parisc                              defconfig
x86_64                           alldefconfig
arm                   milbeaut_m10v_defconfig
arm                         nhk8815_defconfig
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
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20201110
x86_64               randconfig-a005-20201110
x86_64               randconfig-a004-20201110
x86_64               randconfig-a002-20201110
x86_64               randconfig-a006-20201110
x86_64               randconfig-a001-20201110
i386                 randconfig-a006-20201110
i386                 randconfig-a005-20201110
i386                 randconfig-a002-20201110
i386                 randconfig-a001-20201110
i386                 randconfig-a003-20201110
i386                 randconfig-a004-20201110
i386                 randconfig-a006-20201111
i386                 randconfig-a005-20201111
i386                 randconfig-a002-20201111
i386                 randconfig-a001-20201111
i386                 randconfig-a003-20201111
i386                 randconfig-a004-20201111
x86_64               randconfig-a015-20201111
x86_64               randconfig-a011-20201111
x86_64               randconfig-a014-20201111
x86_64               randconfig-a013-20201111
x86_64               randconfig-a016-20201111
x86_64               randconfig-a012-20201111
i386                 randconfig-a012-20201111
i386                 randconfig-a014-20201111
i386                 randconfig-a016-20201111
i386                 randconfig-a011-20201111
i386                 randconfig-a015-20201111
i386                 randconfig-a013-20201111
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201111
x86_64               randconfig-a005-20201111
x86_64               randconfig-a004-20201111
x86_64               randconfig-a002-20201111
x86_64               randconfig-a006-20201111
x86_64               randconfig-a001-20201111
x86_64               randconfig-a015-20201110
x86_64               randconfig-a011-20201110
x86_64               randconfig-a014-20201110
x86_64               randconfig-a013-20201110
x86_64               randconfig-a016-20201110
x86_64               randconfig-a012-20201110

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

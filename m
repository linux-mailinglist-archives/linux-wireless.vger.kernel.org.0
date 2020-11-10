Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEC42AE188
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 22:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgKJVVd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 16:21:33 -0500
Received: from mga05.intel.com ([192.55.52.43]:53943 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgKJVVd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 16:21:33 -0500
IronPort-SDR: 2X9k5IFJVsYt9s05KiVGmksYB2XRc2OgCCsj15QyUSXROgWv38uE3mA5Wi2IleBC/O4KoYWwTG
 83gWR77ydsiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="254761480"
X-IronPort-AV: E=Sophos;i="5.77,467,1596524400"; 
   d="scan'208";a="254761480"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 13:21:28 -0800
IronPort-SDR: X7pMjjSUHEFibc1WryXahwOn4FZyyrgFIF4czUv8Te+CbY40fbSpLB00ynT8Gub+Pvo1w/ztpe
 wlagstGEVQ9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,467,1596524400"; 
   d="scan'208";a="327834723"
Received: from lkp-server02.sh.intel.com (HELO c6c5fbb3488a) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Nov 2020 13:21:27 -0800
Received: from kbuild by c6c5fbb3488a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kcb4w-0000Rw-EE; Tue, 10 Nov 2020 21:21:26 +0000
Date:   Wed, 11 Nov 2020 05:20:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:master] BUILD SUCCESS
 526fa517d2871976c997db5575d2cde7c54c14bb
Message-ID: <5fab0432.qstwmg0tcJGt5K2Q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git  master
branch HEAD: 526fa517d2871976c997db5575d2cde7c54c14bb  nl80211: fix kernel-doc warning in the new SAE attribute

elapsed time: 739m

configs tested: 122
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       aspeed_g4_defconfig
sh                   sh7724_generic_defconfig
mips                malta_qemu_32r6_defconfig
sh                          lboxre2_defconfig
powerpc                   motionpro_defconfig
sh                           se7750_defconfig
arm                          moxart_defconfig
powerpc                          g5_defconfig
mips                           ip22_defconfig
arm                      jornada720_defconfig
powerpc                    socrates_defconfig
c6x                                 defconfig
xtensa                           alldefconfig
arm                             ezx_defconfig
mips                         tb0226_defconfig
h8300                    h8300h-sim_defconfig
arm                        neponset_defconfig
powerpc                     mpc512x_defconfig
arm                       omap2plus_defconfig
arm                           corgi_defconfig
mips                     loongson1b_defconfig
arm                   milbeaut_m10v_defconfig
mips                           ip32_defconfig
sh                      rts7751r2d1_defconfig
powerpc                     ep8248e_defconfig
powerpc                     asp8347_defconfig
mips                        nlm_xlr_defconfig
arm                        multi_v5_defconfig
powerpc                     stx_gp3_defconfig
sparc                               defconfig
arm                       versatile_defconfig
arm                  colibri_pxa270_defconfig
microblaze                          defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      ppc44x_defconfig
sh                          rsk7203_defconfig
arm                       cns3420vb_defconfig
arm                           omap1_defconfig
c6x                        evmc6472_defconfig
arm                          ixp4xx_defconfig
sh                          r7785rp_defconfig
m68k                       bvme6000_defconfig
arm                       spear13xx_defconfig
arm                         shannon_defconfig
m68k                       m5475evb_defconfig
m68k                          atari_defconfig
arm                             rpc_defconfig
m68k                         amcore_defconfig
arm                            hisi_defconfig
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
x86_64               randconfig-a001-20201110
i386                 randconfig-a006-20201110
i386                 randconfig-a005-20201110
i386                 randconfig-a002-20201110
i386                 randconfig-a001-20201110
i386                 randconfig-a003-20201110
i386                 randconfig-a004-20201110
x86_64               randconfig-a006-20201110
i386                 randconfig-a012-20201110
i386                 randconfig-a014-20201110
i386                 randconfig-a016-20201110
i386                 randconfig-a011-20201110
i386                 randconfig-a015-20201110
i386                 randconfig-a013-20201110
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20201110
x86_64               randconfig-a011-20201110
x86_64               randconfig-a014-20201110
x86_64               randconfig-a013-20201110
x86_64               randconfig-a016-20201110
x86_64               randconfig-a012-20201110

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

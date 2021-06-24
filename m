Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECEB3B2A8F
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 10:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhFXIpX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 04:45:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:7048 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhFXIpX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 04:45:23 -0400
IronPort-SDR: gvqanc8QTykskAmJvGbccQoaLxhLuVCjNNxE4PD2JPAIjcpjQ4JY5Q+UG7O0lQwFXWAF/J36/B
 I/3JvvnaP79g==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="205601333"
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="205601333"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 01:43:04 -0700
IronPort-SDR: JjUJQZKvsMscSsZFe5VYHAOSBbtnlo1aWs9ttLlVLeupDXP44UbiZ/S6BVQXb9bj1RdKg4nQj7
 6JW5hbDMRBOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="491051010"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jun 2021 01:43:03 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lwKww-0006Qk-IH; Thu, 24 Jun 2021 08:43:02 +0000
Date:   Thu, 24 Jun 2021 16:42:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 559c664751e54f5ddebd91ef640f7d346132ee44
Message-ID: <60d44564.eseefQySnWSTLi4k%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: 559c664751e54f5ddebd91ef640f7d346132ee44  Merge tag 'iwlwifi-next-for-kalle-2021-06-22' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

elapsed time: 880m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                           mtx1_defconfig
powerpc                      arches_defconfig
mips                            gpr_defconfig
m68k                        m5272c3_defconfig
microblaze                      mmu_defconfig
nds32                               defconfig
m68k                          atari_defconfig
sh                   secureedge5410_defconfig
arm                              alldefconfig
sh                          rsk7203_defconfig
sh                        edosk7760_defconfig
um                             i386_defconfig
arm                         lpc32xx_defconfig
arm                          lpd270_defconfig
arm                             pxa_defconfig
arm                           corgi_defconfig
sparc                            alldefconfig
arm                      pxa255-idp_defconfig
arm                             ezx_defconfig
mips                          ath25_defconfig
sh                         microdev_defconfig
parisc                generic-32bit_defconfig
powerpc                    gamecube_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7722_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     ep8248e_defconfig
arm                         lubbock_defconfig
mips                           ip22_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                       maple_defconfig
arm                       aspeed_g5_defconfig
arm                          ep93xx_defconfig
m68k                       m5249evb_defconfig
mips                        omega2p_defconfig
arm                        magician_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210623
x86_64               randconfig-a001-20210623
x86_64               randconfig-a005-20210623
x86_64               randconfig-a003-20210623
x86_64               randconfig-a004-20210623
x86_64               randconfig-a006-20210623
i386                 randconfig-a001-20210622
i386                 randconfig-a002-20210622
i386                 randconfig-a003-20210622
i386                 randconfig-a006-20210622
i386                 randconfig-a005-20210622
i386                 randconfig-a004-20210622
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
i386                 randconfig-a011-20210622
i386                 randconfig-a014-20210622
i386                 randconfig-a013-20210622
i386                 randconfig-a015-20210622
i386                 randconfig-a012-20210622
i386                 randconfig-a016-20210622
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210623
x86_64               randconfig-b001-20210622
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

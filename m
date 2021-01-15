Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D042F72A9
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 07:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbhAOGAI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 01:00:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:32496 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbhAOGAH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 01:00:07 -0500
IronPort-SDR: laENljNXzRTd9AeadIh2M8BEoXoUcjFN4ykUyrHXZdxf6cJzcB3yG7IznXTGpmqjRprXc+md6v
 ciMJKT1aEiYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="166172641"
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="166172641"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 21:59:25 -0800
IronPort-SDR: mD5LVoP1mkgUaTNiLA83G9Q9nI41nOaNqwrnMAt1akWiKQSRoUt/lkJMvqiYmXHecRWyYovC1Y
 ++H1U5dngP7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="352720077"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Jan 2021 21:59:23 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0I8p-0000DC-5n; Fri, 15 Jan 2021 05:59:23 +0000
Date:   Fri, 15 Jan 2021 13:58:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 07ceefa3012f43512e93931980bd3bdf5af96344
Message-ID: <60012f05.34/j5id0KiI8LjF9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: 07ceefa3012f43512e93931980bd3bdf5af96344  wlcore: Downgrade exceeded max RX BA sessions to debug

elapsed time: 720m

configs tested: 111
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
arc                      axs103_smp_defconfig
sh                          r7785rp_defconfig
m68k                        m5272c3_defconfig
arm                        oxnas_v6_defconfig
sh                                  defconfig
powerpc                    socrates_defconfig
arm                           spitz_defconfig
sh                            migor_defconfig
arm                           sunxi_defconfig
powerpc                      tqm8xx_defconfig
xtensa                    smp_lx200_defconfig
arm                         vf610m4_defconfig
mips                          rb532_defconfig
sh                             shx3_defconfig
powerpc                 mpc837x_mds_defconfig
i386                             alldefconfig
powerpc                     redwood_defconfig
arm                            lart_defconfig
arm                            pleb_defconfig
sh                     sh7710voipgw_defconfig
sh                     magicpanelr2_defconfig
mips                malta_kvm_guest_defconfig
c6x                         dsk6455_defconfig
arm                             ezx_defconfig
arm                      integrator_defconfig
powerpc                   lite5200b_defconfig
arc                            hsdk_defconfig
riscv                    nommu_virt_defconfig
mips                      maltaaprp_defconfig
arm                          imote2_defconfig
powerpc                    mvme5100_defconfig
sh                           se7712_defconfig
powerpc                     taishan_defconfig
mips                             allmodconfig
m68k                           sun3_defconfig
m68k                        stmark2_defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210114
i386                 randconfig-a005-20210114
i386                 randconfig-a006-20210114
i386                 randconfig-a001-20210114
i386                 randconfig-a003-20210114
i386                 randconfig-a004-20210114
x86_64               randconfig-a015-20210114
x86_64               randconfig-a012-20210114
x86_64               randconfig-a013-20210114
x86_64               randconfig-a016-20210114
x86_64               randconfig-a014-20210114
x86_64               randconfig-a011-20210114
i386                 randconfig-a012-20210114
i386                 randconfig-a011-20210114
i386                 randconfig-a016-20210114
i386                 randconfig-a015-20210114
i386                 randconfig-a013-20210114
i386                 randconfig-a014-20210114
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210114
x86_64               randconfig-a006-20210114
x86_64               randconfig-a001-20210114
x86_64               randconfig-a003-20210114
x86_64               randconfig-a005-20210114
x86_64               randconfig-a002-20210114

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

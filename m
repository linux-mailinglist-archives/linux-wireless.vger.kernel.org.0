Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAEE302FC9
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jan 2021 00:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbhAYXHK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jan 2021 18:07:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:50112 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732516AbhAYXGg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 18:06:36 -0500
IronPort-SDR: KtGR0sChCPZi0bBkx5QnDoTBIiLe1xSmoQjIdJcfH3xLxJRiKajLSRqFYOzudtbXO6elrlVF1s
 yv1bm7w+DvKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="179038775"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="179038775"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 15:05:52 -0800
IronPort-SDR: wqwG7VxhakS+MnmIM2C0R7EWeiPS6QU9TLe32COz6pn3pr4vtLBt2jvKyB6zcU4FFmvrXE7Qk+
 NpazmsbPb1og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="368886079"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 25 Jan 2021 15:05:51 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l4Ave-0000R8-RY; Mon, 25 Jan 2021 23:05:50 +0000
Date:   Tue, 26 Jan 2021 07:05:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:master] BUILD SUCCESS
 60b0a50cebf2fc42a7a0c453a4a762f950b81e13
Message-ID: <600f4ea7.t8zag5LUWCP+u4x4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
branch HEAD: 60b0a50cebf2fc42a7a0c453a4a762f950b81e13  cfg80211: avoid holding the RTNL when calling the driver

elapsed time: 733m

configs tested: 96
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sparc                               defconfig
arm                       aspeed_g5_defconfig
riscv                            alldefconfig
arm                          imote2_defconfig
powerpc                 mpc832x_mds_defconfig
arm                          pcm027_defconfig
mips                        qi_lb60_defconfig
mips                  decstation_64_defconfig
mips                         tb0287_defconfig
sh                      rts7751r2d1_defconfig
mips                         tb0219_defconfig
mips                           ip27_defconfig
m68k                         apollo_defconfig
arc                        nsimosci_defconfig
nios2                            allyesconfig
sh                               j2_defconfig
sh                   sh7770_generic_defconfig
sh                         ecovec24_defconfig
um                           x86_64_defconfig
sh                           se7712_defconfig
sparc                       sparc32_defconfig
arm                          ixp4xx_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210125
x86_64               randconfig-a002-20210125
x86_64               randconfig-a001-20210125
x86_64               randconfig-a005-20210125
x86_64               randconfig-a006-20210125
x86_64               randconfig-a004-20210125
i386                 randconfig-a001-20210125
i386                 randconfig-a002-20210125
i386                 randconfig-a004-20210125
i386                 randconfig-a006-20210125
i386                 randconfig-a005-20210125
i386                 randconfig-a003-20210125
i386                 randconfig-a013-20210125
i386                 randconfig-a011-20210125
i386                 randconfig-a012-20210125
i386                 randconfig-a015-20210125
i386                 randconfig-a014-20210125
i386                 randconfig-a016-20210125
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
x86_64               randconfig-a012-20210125
x86_64               randconfig-a016-20210125
x86_64               randconfig-a015-20210125
x86_64               randconfig-a011-20210125
x86_64               randconfig-a013-20210125
x86_64               randconfig-a014-20210125

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EADD3638FB
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Apr 2021 03:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbhDSBHY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 21:07:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:58895 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233117AbhDSBHY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 21:07:24 -0400
IronPort-SDR: af4OPANitOKCxWP+DhP6DnCxgbzRBdfadFUkmAkk5AG8fc3NtmY181u7B/YBK1SeUVnw31JszP
 fFL8m2envYWQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="174741167"
X-IronPort-AV: E=Sophos;i="5.82,232,1613462400"; 
   d="scan'208";a="174741167"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2021 18:06:55 -0700
IronPort-SDR: 4o/hUlVuygSQaZv0Fy3ojo/IiqwYZMz+7t55mJW0MHmSqM7qgRr++sGDAMkccosE5HGYQNx4K2
 xh1LYuISQokQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,232,1613462400"; 
   d="scan'208";a="613241256"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 18 Apr 2021 18:06:54 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lYINJ-0001T6-Ri; Mon, 19 Apr 2021 01:06:53 +0000
Date:   Mon, 19 Apr 2021 09:06:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 fb8517f4fade44fa5e42e29ca4d6e4a7ed50b512
Message-ID: <607cd782.ngcov6zh3J6dZHzh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: fb8517f4fade44fa5e42e29ca4d6e4a7ed50b512  rtw88: 8822c: add CFO tracking

elapsed time: 724m

configs tested: 99
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
arm                         cm_x300_defconfig
powerpc                    ge_imp3a_defconfig
m68k                          amiga_defconfig
openrisc                            defconfig
sh                          sdk7786_defconfig
mips                       lemote2f_defconfig
mips                         bigsur_defconfig
powerpc                    klondike_defconfig
ia64                        generic_defconfig
sparc64                             defconfig
powerpc                      pmac32_defconfig
mips                          rm200_defconfig
arc                            hsdk_defconfig
m68k                        m5272c3_defconfig
xtensa                              defconfig
powerpc                     stx_gp3_defconfig
sh                           se7750_defconfig
sh                         microdev_defconfig
powerpc                 mpc832x_mds_defconfig
xtensa                  audio_kc705_defconfig
powerpc                 mpc85xx_cds_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210418
i386                 randconfig-a001-20210418
i386                 randconfig-a006-20210418
i386                 randconfig-a005-20210418
i386                 randconfig-a004-20210418
i386                 randconfig-a002-20210418
x86_64               randconfig-a014-20210418
x86_64               randconfig-a015-20210418
x86_64               randconfig-a013-20210418
x86_64               randconfig-a011-20210418
x86_64               randconfig-a012-20210418
x86_64               randconfig-a016-20210418
i386                 randconfig-a015-20210418
i386                 randconfig-a013-20210418
i386                 randconfig-a014-20210418
i386                 randconfig-a016-20210418
i386                 randconfig-a012-20210418
i386                 randconfig-a011-20210418
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210418
x86_64               randconfig-a001-20210418
x86_64               randconfig-a005-20210418
x86_64               randconfig-a002-20210418
x86_64               randconfig-a006-20210418
x86_64               randconfig-a004-20210418

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

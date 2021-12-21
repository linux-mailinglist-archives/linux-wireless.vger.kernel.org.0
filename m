Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7C047BFB0
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 13:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhLUM07 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Dec 2021 07:26:59 -0500
Received: from mga14.intel.com ([192.55.52.115]:43884 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbhLUM06 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Dec 2021 07:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640089618; x=1671625618;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Gp2R5l9urbw7cBEBxsOVgC4Yn0kXlzUbM69Iprin41Q=;
  b=XGDbAQuiPV9G3XFIFepYc1z/fQ74zNw4jLnXQ+p2OktA/5rsPBX8da6x
   64wSNZBxb+48HYK7NyDdxTMXywI0vH6bVCM5pVljZJ8169gF2NtrZthog
   LRHlH5qLa1sDKHkgkTkO4EvVuOVHs5vD0CoyeIQPHft6iSRluC34cXL1K
   6vxY/5v0+oT8T607XOchO8/TfbKIfClpBnPqLihveWQQ9nvUv16fv4miC
   Se5cGaDj/SjK0JszoOkvPbTUvHQXSC/gV2y8u+W9ZVQNI4Kdjx5oN+JhK
   Q+rQ7y4EolDjKmQvY4LIft6kmWWyZ0xjnYN96oZFT4LIZcaN9xNtjSxzU
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="240607126"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="240607126"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 04:26:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="467774183"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 21 Dec 2021 04:26:56 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzeEK-00095d-9y; Tue, 21 Dec 2021 12:26:56 +0000
Date:   Tue, 21 Dec 2021 20:26:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [kvalo-wireless-drivers-next:master] BUILD SUCCESS
 8b144dedb928e4e2f433a328d58f44c3c098d63e
Message-ID: <61c1c7e8.og72N70DGz5R9RBv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: 8b144dedb928e4e2f433a328d58f44c3c098d63e  rtlwifi: rtl8192cu: Fix WARNING when calling local_irq_restore() with interrupts enabled

elapsed time: 912m

configs tested: 101
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
arc                     haps_hs_smp_defconfig
sh                ecovec24-romimage_defconfig
ia64                        generic_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                      rts7751r2d1_defconfig
mips                           ip27_defconfig
csky                             alldefconfig
powerpc                       eiger_defconfig
arm                           tegra_defconfig
arm                           omap1_defconfig
openrisc                  or1klitex_defconfig
powerpc                     tqm5200_defconfig
arm64                            alldefconfig
arm                            pleb_defconfig
arm                            xcep_defconfig
sh                           se7722_defconfig
mips                            ar7_defconfig
arm                  randconfig-c002-20211220
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
sparc                            allyesconfig
i386                   debian-10.3-kselftests
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                 randconfig-a002-20211220
i386                 randconfig-a003-20211220
i386                 randconfig-a001-20211220
i386                 randconfig-a005-20211220
i386                 randconfig-a006-20211220
i386                 randconfig-a004-20211220
x86_64               randconfig-a001-20211220
x86_64               randconfig-a003-20211220
x86_64               randconfig-a004-20211220
x86_64               randconfig-a002-20211220
x86_64               randconfig-a005-20211220
x86_64               randconfig-a006-20211220
arc                  randconfig-r043-20211220
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-a013-20211220
x86_64               randconfig-a015-20211220
x86_64               randconfig-a014-20211220
x86_64               randconfig-a012-20211220
x86_64               randconfig-a011-20211220
x86_64               randconfig-a016-20211220
i386                 randconfig-a012-20211220
i386                 randconfig-a011-20211220
i386                 randconfig-a014-20211220
i386                 randconfig-a016-20211220
i386                 randconfig-a015-20211220
i386                 randconfig-a013-20211220
hexagon              randconfig-r041-20211220
hexagon              randconfig-r045-20211220
riscv                randconfig-r042-20211220
s390                 randconfig-r044-20211220

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

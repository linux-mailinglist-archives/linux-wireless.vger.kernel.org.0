Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B078A47CF8B
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 10:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbhLVJtl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 04:49:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:20921 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232246AbhLVJtl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 04:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640166581; x=1671702581;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=sVhwY6EjhmMGaJPZRAMu4mZ1NEUBEbHRaCBNMu74B7E=;
  b=js0n4fs8AWeEmazb+kC/MbkB28oDVbBXq4/QugjpJ37XnLfiR6Do1rdT
   a/vKoc12pq+2XcjczuBlIIksWCQdsM7RT5hXhaubAP57Ih1Ss2k1+nVLo
   gtEEt9cWHKFvUXrXF7eg8beDi0YxTqYkK+sln35IfRo/qXjKUY5qVtYLt
   bQABuUiYoVsye11ZOSA4Hu69oDYGQqY0RcUe8AYlPwJaZCFyvOn4TJ5Sm
   tooh5IXUgNxOEbiWWLFou42NCioxKDaxjA2yUfoGT7SbCB010zIYq0luF
   vwRaEo3zWqGtiRiNjy2UlfHx4z0HnT/JFI4J3ycAztp2+W+hW50RZcAuL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240393289"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240393289"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 01:49:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="684970928"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Dec 2021 01:49:39 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzyFe-0000KP-Si; Wed, 22 Dec 2021 09:49:38 +0000
Date:   Wed, 22 Dec 2021 17:49:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [kvalo-wireless-drivers-next:pending] BUILD SUCCESS
 d5cc49a4d7db42e7a8ca2e2f6fae6af334d5abb6
Message-ID: <61c2f499.HvhznlWjAZ2ZZ1pD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git pending
branch HEAD: d5cc49a4d7db42e7a8ca2e2f6fae6af334d5abb6  Merge tag 'iwlwifi-next-for-kalle-2021-12-21-v2' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next into pending

elapsed time: 1224m

configs tested: 99
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
i386                             alldefconfig
arm                      footbridge_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                           se7705_defconfig
arm                  colibri_pxa270_defconfig
arc                     nsimosci_hs_defconfig
powerpc                    mvme5100_defconfig
riscv                               defconfig
arm                           u8500_defconfig
arm                        mvebu_v7_defconfig
ia64                             alldefconfig
arm                  randconfig-c002-20211220
arm                  randconfig-c002-20211222
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
parisc                              defconfig
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                 randconfig-a002-20211220
i386                 randconfig-a003-20211220
i386                 randconfig-a001-20211220
i386                 randconfig-a004-20211220
i386                 randconfig-a005-20211220
i386                 randconfig-a006-20211220
arc                  randconfig-r043-20211220
x86_64               randconfig-a001-20211220
x86_64               randconfig-a003-20211220
x86_64               randconfig-a002-20211220
x86_64               randconfig-a004-20211220
x86_64               randconfig-a006-20211220
x86_64               randconfig-a005-20211220
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
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
i386                 randconfig-a013-20211220
i386                 randconfig-a014-20211220
i386                 randconfig-a016-20211220
i386                 randconfig-a015-20211220
hexagon              randconfig-r041-20211220
hexagon              randconfig-r045-20211220
s390                 randconfig-r044-20211220
riscv                randconfig-r042-20211220
hexagon              randconfig-r041-20211222
hexagon              randconfig-r045-20211222
riscv                randconfig-r042-20211222
s390                 randconfig-r044-20211222

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

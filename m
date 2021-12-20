Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAAF47A546
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 08:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbhLTHKB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 02:10:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:53237 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234362AbhLTHKA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 02:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639984200; x=1671520200;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1rgl6X24aQy5QZE4dK7ls5S/Ob8Q3MZCd0bGBcM3cJM=;
  b=L83Nhz2IDks75rbadjK63d1755YjucFwE12BdgaCm0dq3SSe4HSQDAfO
   U3IfaZ8UGX/npHJ3CRVEJDS8LT2PGuNJJaAH812HvLVZofga4Agcx7w6U
   kkwuW8Z923uQthe4SRr+trWQeLUKGv5v/TjR296OTLzc96FqjiX84/M7V
   GOUYoI9K04b/IHvy7NowoudfSvgHyl6f0WDrhL08K1rhsvAJcEBU27yd+
   0yxt95PZXA0sG5XJqpRdzKIE+7W3sdK49O33D35wKpE7JbwrlM+L7sdlV
   WnrLfN5ArE6E2zNJyOcpQZrSV59zEUV/70VPlC9pR/EswCfVUwTRcACTA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="240334610"
X-IronPort-AV: E=Sophos;i="5.88,219,1635231600"; 
   d="scan'208";a="240334610"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2021 23:09:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,219,1635231600"; 
   d="scan'208";a="520689167"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 19 Dec 2021 23:09:58 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzCo1-0007ZX-FH; Mon, 20 Dec 2021 07:09:57 +0000
Date:   Mon, 20 Dec 2021 15:09:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [kvalo-wireless-drivers-next:pending] BUILD SUCCESS
 d2cd8e2aac4b8213e72f113206fdb464dcbea1c1
Message-ID: <61c02c0c.dU6KNz67IN62jQPj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git pending
branch HEAD: d2cd8e2aac4b8213e72f113206fdb464dcbea1c1  Merge tag 'mt76-for-kvalo-2021-12-18' of https://github.com/nbd168/wireless into pending

elapsed time: 725m

configs tested: 127
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc834x_itx_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                    adder875_defconfig
m68k                       m5249evb_defconfig
powerpc                     sequoia_defconfig
arm                           viper_defconfig
m68k                       m5208evb_defconfig
mips                         bigsur_defconfig
arm                        magician_defconfig
powerpc                mpc7448_hpc2_defconfig
m68k                        m5272c3_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                      ep88xc_defconfig
powerpc                 xes_mpc85xx_defconfig
um                             i386_defconfig
arm                          iop32x_defconfig
arm                         s3c2410_defconfig
xtensa                              defconfig
mips                         tb0287_defconfig
mips                           gcw0_defconfig
powerpc                 mpc8540_ads_defconfig
openrisc                            defconfig
m68k                       bvme6000_defconfig
sparc                       sparc32_defconfig
m68k                          hp300_defconfig
powerpc                    amigaone_defconfig
csky                                defconfig
powerpc                  mpc885_ads_defconfig
arm                          pxa3xx_defconfig
arm                           stm32_defconfig
sh                        apsh4ad0a_defconfig
i386                             allyesconfig
m68k                          atari_defconfig
powerpc                     taishan_defconfig
mips                            e55_defconfig
m68k                        m5307c3_defconfig
sh                         apsh4a3a_defconfig
arm                       cns3420vb_defconfig
powerpc                         wii_defconfig
powerpc                 canyonlands_defconfig
mips                           ci20_defconfig
nios2                         10m50_defconfig
mips                            ar7_defconfig
powerpc                        cell_defconfig
openrisc                 simple_smp_defconfig
arm                  randconfig-c002-20211220
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20211220
i386                 randconfig-a003-20211220
i386                 randconfig-a005-20211220
i386                 randconfig-a001-20211220
i386                 randconfig-a006-20211220
i386                 randconfig-a004-20211220
i386                 randconfig-a013-20211219
i386                 randconfig-a011-20211219
i386                 randconfig-a015-20211219
i386                 randconfig-a014-20211219
i386                 randconfig-a012-20211219
i386                 randconfig-a016-20211219
x86_64               randconfig-a001-20211220
x86_64               randconfig-a003-20211220
x86_64               randconfig-a004-20211220
x86_64               randconfig-a002-20211220
x86_64               randconfig-a005-20211220
x86_64               randconfig-a006-20211220
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20211220
x86_64               randconfig-a015-20211220
x86_64               randconfig-a014-20211220
x86_64               randconfig-a012-20211220
x86_64               randconfig-a011-20211220
x86_64               randconfig-a016-20211220
i386                 randconfig-a011-20211220
i386                 randconfig-a014-20211220
i386                 randconfig-a016-20211220
i386                 randconfig-a015-20211220
hexagon              randconfig-r045-20211219
hexagon              randconfig-r041-20211219

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

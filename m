Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA203B3A9D
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Jun 2021 03:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhFYBsp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 21:48:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:53375 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232917AbhFYBsp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 21:48:45 -0400
IronPort-SDR: h+ZZ0vfAy6s6Smp5CORA/HvwhWToK2nOXIa4W3yMdOBhT6QQPrpRPImvmXqZVQoDVkVTcYoTRQ
 6yqy8X7wttsQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="205763572"
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="205763572"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 18:46:25 -0700
IronPort-SDR: o8LrisJjBVlUHkhQW4cO/p1+1WSF5XgXAocnHHsI4HB1W3KqhMeaa+8URa4j6Eb4K6+PNfKolU
 y2U0C3F8IXkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="557542590"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jun 2021 18:46:24 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lwavH-0006qT-Db; Fri, 25 Jun 2021 01:46:23 +0000
Date:   Fri, 25 Jun 2021 09:45:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:pending] BUILD SUCCESS
 e7e9148d36139037fe3274810548811dfa6077e6
Message-ID: <60d53536.PAae0jpr9JA0xfpy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git pending
branch HEAD: e7e9148d36139037fe3274810548811dfa6077e6  iwlwifi: mvm: add vendor commands needed for iwlmei

elapsed time: 1175m

configs tested: 133
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
openrisc                            defconfig
arm                        mvebu_v5_defconfig
xtensa                          iss_defconfig
parisc                           allyesconfig
mips                        vocore2_defconfig
nds32                               defconfig
mips                           mtx1_defconfig
powerpc                      arches_defconfig
mips                            gpr_defconfig
m68k                        m5272c3_defconfig
microblaze                      mmu_defconfig
m68k                          atari_defconfig
sh                   secureedge5410_defconfig
arm                              alldefconfig
arm                         axm55xx_defconfig
nios2                         10m50_defconfig
powerpc                       holly_defconfig
powerpc                      makalu_defconfig
arc                        nsimosci_defconfig
powerpc                     akebono_defconfig
xtensa                generic_kc705_defconfig
riscv                             allnoconfig
openrisc                    or1ksim_defconfig
ia64                             allmodconfig
mips                       capcella_defconfig
arm                        mini2440_defconfig
arm                            hisi_defconfig
arm                        neponset_defconfig
mips                        bcm63xx_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     pseries_defconfig
mips                        jmr3927_defconfig
arm                      footbridge_defconfig
powerpc                      ppc40x_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                         microdev_defconfig
parisc                generic-32bit_defconfig
powerpc                    gamecube_defconfig
powerpc                      pasemi_defconfig
arc                      axs103_smp_defconfig
x86_64                              defconfig
microblaze                          defconfig
mips                      maltasmvp_defconfig
arm                        clps711x_defconfig
sh                           se7343_defconfig
powerpc                 mpc834x_mds_defconfig
arm                           sunxi_defconfig
s390                          debug_defconfig
powerpc                       ebony_defconfig
m68k                       m5249evb_defconfig
mips                        omega2p_defconfig
arm                        magician_defconfig
x86_64                            allnoconfig
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
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210622
i386                 randconfig-a002-20210622
i386                 randconfig-a003-20210622
i386                 randconfig-a006-20210622
i386                 randconfig-a005-20210622
i386                 randconfig-a004-20210622
x86_64               randconfig-a012-20210624
x86_64               randconfig-a016-20210624
x86_64               randconfig-a015-20210624
x86_64               randconfig-a014-20210624
x86_64               randconfig-a013-20210624
x86_64               randconfig-a011-20210624
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
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210624
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

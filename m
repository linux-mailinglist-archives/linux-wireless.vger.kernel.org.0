Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1730739B41D
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jun 2021 09:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhFDHk6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Jun 2021 03:40:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:56123 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229962AbhFDHk6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Jun 2021 03:40:58 -0400
IronPort-SDR: XUPqqJW0Zxe170bx9uwPHGSyJPOslqp1vdPMp8hpL4MhMQXlGi2ELW0XPjnVt2HGBITbW/WB4M
 kbM1Z2/AWlMw==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="201223621"
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; 
   d="scan'208";a="201223621"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 00:39:12 -0700
IronPort-SDR: Rd62ihGq4feGjSrIS8kqZpWkOoABaSjcWyCR7yuIw+qAFtxsOwtiIA0QlXyOkwGvWTvC0B6+CK
 KGzoPj0l0XUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; 
   d="scan'208";a="618179264"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Jun 2021 00:39:11 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lp4QA-0006mm-Ez; Fri, 04 Jun 2021 07:39:10 +0000
Date:   Fri, 04 Jun 2021 15:38:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 bddc0c411a45d3718ac535a070f349be8eca8d48
Message-ID: <60b9d866.heEt8N0yo5csS1tr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
branch HEAD: bddc0c411a45d3718ac535a070f349be8eca8d48  mac80211: Fix NULL ptr deref for injected rate info

elapsed time: 4958m

configs tested: 139
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                             allmodconfig
sh                          rsk7203_defconfig
powerpc                    adder875_defconfig
m68k                        m5307c3_defconfig
h8300                               defconfig
arm                          collie_defconfig
nds32                            alldefconfig
mips                           ip27_defconfig
arc                      axs103_smp_defconfig
sparc                       sparc64_defconfig
arm                         assabet_defconfig
powerpc                        cell_defconfig
arm                          pcm027_defconfig
arm                         s5pv210_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         cm_x300_defconfig
powerpc                     redwood_defconfig
powerpc                 mpc8272_ads_defconfig
sh                          r7780mp_defconfig
arm                         nhk8815_defconfig
m68k                            q40_defconfig
m68k                        mvme16x_defconfig
mips                            gpr_defconfig
mips                   sb1250_swarm_defconfig
nios2                               defconfig
arc                        vdk_hs38_defconfig
arm                          moxart_defconfig
um                           x86_64_defconfig
mips                       capcella_defconfig
s390                          debug_defconfig
sh                          rsk7269_defconfig
powerpc                       ppc64_defconfig
powerpc                      walnut_defconfig
arm                        spear6xx_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                     tqm8555_defconfig
mips                         mpc30x_defconfig
powerpc                 mpc836x_mds_defconfig
sh                          sdk7786_defconfig
mips                          malta_defconfig
mips                           rs90_defconfig
ia64                            zx1_defconfig
xtensa                         virt_defconfig
mips                     loongson2k_defconfig
powerpc                          g5_defconfig
i386                                defconfig
x86_64                            allnoconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210531
x86_64               randconfig-a003-20210531
x86_64               randconfig-a005-20210531
x86_64               randconfig-a004-20210531
x86_64               randconfig-a002-20210531
x86_64               randconfig-a001-20210531
i386                 randconfig-a002-20210531
i386                 randconfig-a001-20210531
i386                 randconfig-a005-20210531
i386                 randconfig-a006-20210531
i386                 randconfig-a004-20210531
i386                 randconfig-a003-20210531
i386                 randconfig-a003-20210601
i386                 randconfig-a006-20210601
i386                 randconfig-a004-20210601
i386                 randconfig-a001-20210601
i386                 randconfig-a002-20210601
i386                 randconfig-a005-20210601
x86_64               randconfig-a015-20210601
x86_64               randconfig-a011-20210601
x86_64               randconfig-a012-20210601
x86_64               randconfig-a014-20210601
x86_64               randconfig-a016-20210601
x86_64               randconfig-a013-20210601
i386                 randconfig-a015-20210601
i386                 randconfig-a013-20210601
i386                 randconfig-a011-20210601
i386                 randconfig-a016-20210601
i386                 randconfig-a014-20210601
i386                 randconfig-a012-20210601
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210531
x86_64               randconfig-a002-20210601
x86_64               randconfig-a004-20210601
x86_64               randconfig-a003-20210601
x86_64               randconfig-a006-20210601
x86_64               randconfig-a005-20210601
x86_64               randconfig-a001-20210601
x86_64               randconfig-a014-20210531
x86_64               randconfig-a012-20210531
x86_64               randconfig-a013-20210531
x86_64               randconfig-a016-20210531
x86_64               randconfig-a015-20210531
x86_64               randconfig-a011-20210531

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

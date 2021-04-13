Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D5335E5D6
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 20:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242578AbhDMSEQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 14:04:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:10030 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344210AbhDMSEM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 14:04:12 -0400
IronPort-SDR: 1/Qge8sV5RbYXlHc64Cz01P82JEqoSURfGBu27pV68yYC5yx3by9UMi1BVn5saeupapSrAvWAK
 0o7pmLW6+hPg==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="194582545"
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="194582545"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 11:02:24 -0700
IronPort-SDR: rs78gE6kLUW9oWkoOjpy7qNgTV/+X/zFmWvwIff24q9IGTc2W6CAjTY9gdDpSZ/CgJZ3tjMTuS
 5TOcMLp3tWrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="452068436"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 Apr 2021 11:02:21 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lWNMj-0001Bk-0H; Tue, 13 Apr 2021 18:02:21 +0000
Date:   Wed, 14 Apr 2021 02:01:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:pending] BUILD SUCCESS
 2e968e5426d088facf247a8fff76a941f226384b
Message-ID: <6075dc77.9LJVe7gtsSmS8iuZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git pending
branch HEAD: 2e968e5426d088facf247a8fff76a941f226384b  Merge tag 'mt76-for-kvalo-2021-04-12' of https://github.com/nbd168/wireless into pending

elapsed time: 721m

configs tested: 131
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
riscv                            allmodconfig
riscv                            allyesconfig
i386                             allyesconfig
sh                         microdev_defconfig
sh                             espt_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                           ip32_defconfig
arm                        oxnas_v6_defconfig
h8300                       h8s-sim_defconfig
mips                       bmips_be_defconfig
powerpc                 canyonlands_defconfig
mips                  decstation_64_defconfig
arm                              alldefconfig
sh                          rsk7269_defconfig
arm                       cns3420vb_defconfig
ia64                          tiger_defconfig
arc                        nsim_700_defconfig
openrisc                 simple_smp_defconfig
m68k                          hp300_defconfig
powerpc                  storcenter_defconfig
sh                            shmin_defconfig
mips                            gpr_defconfig
ia64                             alldefconfig
powerpc                 mpc832x_rdb_defconfig
arm                           h3600_defconfig
powerpc                   lite5200b_defconfig
arm                       netwinder_defconfig
arm                           corgi_defconfig
arm                        magician_defconfig
um                                  defconfig
arm                            zeus_defconfig
openrisc                         alldefconfig
m68k                          atari_defconfig
powerpc                    gamecube_defconfig
powerpc                     mpc5200_defconfig
h8300                     edosk2674_defconfig
powerpc                      bamboo_defconfig
xtensa                  nommu_kc705_defconfig
sh                           se7780_defconfig
arm                         hackkit_defconfig
m68k                       m5208evb_defconfig
arm                            xcep_defconfig
arm                             ezx_defconfig
arm                            qcom_defconfig
mips                        omega2p_defconfig
mips                         mpc30x_defconfig
mips                          ath79_defconfig
um                               allmodconfig
arm                        clps711x_defconfig
xtensa                generic_kc705_defconfig
arm                      footbridge_defconfig
sparc64                          alldefconfig
arm                      jornada720_defconfig
sh                          landisk_defconfig
x86_64                           alldefconfig
sh                           sh2007_defconfig
openrisc                    or1ksim_defconfig
m68k                          multi_defconfig
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
x86_64               randconfig-a003-20210413
x86_64               randconfig-a002-20210413
x86_64               randconfig-a001-20210413
x86_64               randconfig-a005-20210413
x86_64               randconfig-a006-20210413
x86_64               randconfig-a004-20210413
i386                 randconfig-a003-20210413
i386                 randconfig-a001-20210413
i386                 randconfig-a006-20210413
i386                 randconfig-a005-20210413
i386                 randconfig-a004-20210413
i386                 randconfig-a002-20210413
i386                 randconfig-a015-20210413
i386                 randconfig-a014-20210413
i386                 randconfig-a013-20210413
i386                 randconfig-a012-20210413
i386                 randconfig-a016-20210413
i386                 randconfig-a011-20210413
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                                allnoconfig
um                               allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210413
x86_64               randconfig-a015-20210413
x86_64               randconfig-a011-20210413
x86_64               randconfig-a013-20210413
x86_64               randconfig-a012-20210413
x86_64               randconfig-a016-20210413

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

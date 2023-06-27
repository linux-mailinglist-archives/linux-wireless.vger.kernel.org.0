Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D03373F02A
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jun 2023 03:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjF0BMo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Jun 2023 21:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjF0BMn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Jun 2023 21:12:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA43F173B
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jun 2023 18:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687828358; x=1719364358;
  h=date:from:to:cc:subject:message-id;
  bh=cr3u9h4MH46J4SkA+YoHbfKIJzcAf4yPXTZRfyFHxxQ=;
  b=Duzp1WnSOc3+EZP0bM39l8KRHWiDC21JAnI3f6+/DqWXja5aFiuijP7Z
   vAU4JH7Uen+e+q35ewVyq8m5kXiYRVQWJ+ZLFHX482Wk/P+TxEpepaKAg
   HAG5W843zauNL1IoqvpNhpWIYBIM7k5kmAwuLhnxSoT+PpUg3kf6xYNLj
   A59WEC/dUD0fz8SvkoGIXLHoN4EsocKQFOZTsoLukNBXJ9IVpR53cu5D0
   D/0GCAE/lg4RURJQA0JWtfFngEECH7GmYwhj91LL4a53FzEU5HZxOFhkz
   baixvrU0Sro4W7EFsCMjWXjdCFmT5eMd/WXc+WljBYm940h/3SX1RG5th
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="346197055"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="346197055"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 18:12:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="716352527"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="716352527"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 26 Jun 2023 18:12:35 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDxFy-000BC0-2T;
        Tue, 27 Jun 2023 01:12:34 +0000
Date:   Tue, 27 Jun 2023 09:12:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 31b5a547622b3782388eb676081da1eefe5b98d2
Message-ID: <202306270912.hm5NaR71-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 31b5a547622b3782388eb676081da1eefe5b98d2  wifi: ieee80211: fix erroneous NSTR bitmap size checks

elapsed time: 6082m

configs tested: 187
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r025-20230622   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230622   gcc  
arc                  randconfig-r011-20230621   gcc  
arc                  randconfig-r014-20230621   gcc  
arc                  randconfig-r014-20230622   gcc  
arc                  randconfig-r043-20230621   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                          collie_defconfig   clang
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                  randconfig-r015-20230621   gcc  
arm                  randconfig-r046-20230621   gcc  
arm                        shmobile_defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
arm                           spitz_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230622   gcc  
arm64                randconfig-r013-20230621   clang
arm64                randconfig-r022-20230622   gcc  
arm64                randconfig-r036-20230622   clang
csky                             alldefconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r016-20230622   gcc  
csky                 randconfig-r022-20230622   gcc  
csky                 randconfig-r024-20230622   gcc  
csky                 randconfig-r025-20230622   gcc  
hexagon                          alldefconfig   clang
hexagon              randconfig-r041-20230621   clang
hexagon              randconfig-r045-20230621   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230622   clang
i386         buildonly-randconfig-r005-20230622   clang
i386         buildonly-randconfig-r006-20230622   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230622   clang
i386                 randconfig-i002-20230622   clang
i386                 randconfig-i003-20230622   clang
i386                 randconfig-i004-20230622   clang
i386                 randconfig-i005-20230622   clang
i386                 randconfig-i006-20230622   clang
i386                 randconfig-i011-20230622   gcc  
i386                 randconfig-i012-20230622   gcc  
i386                 randconfig-i013-20230622   gcc  
i386                 randconfig-i014-20230622   gcc  
i386                 randconfig-i015-20230622   gcc  
i386                 randconfig-i016-20230622   gcc  
i386                 randconfig-r003-20230622   clang
i386                 randconfig-r023-20230622   gcc  
i386                 randconfig-r032-20230622   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230621   gcc  
loongarch            randconfig-r005-20230621   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                 randconfig-r021-20230622   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r002-20230622   gcc  
microblaze           randconfig-r015-20230622   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                         bigsur_defconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                     cu1000-neo_defconfig   clang
mips                     decstation_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                 randconfig-r012-20230621   gcc  
mips                 randconfig-r024-20230622   clang
nios2                         10m50_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230621   gcc  
nios2                randconfig-r023-20230622   gcc  
nios2                randconfig-r031-20230622   gcc  
openrisc             randconfig-r026-20230622   gcc  
openrisc             randconfig-r031-20230622   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r011-20230622   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                        fsp2_defconfig   clang
powerpc                     kilauea_defconfig   clang
powerpc                      makalu_defconfig   gcc  
powerpc                     mpc512x_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                      obs600_defconfig   clang
powerpc                       ppc64_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                      tqm8xx_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230622   clang
riscv                randconfig-r026-20230622   gcc  
riscv                randconfig-r034-20230622   clang
riscv                randconfig-r042-20230621   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230621   gcc  
s390                 randconfig-r021-20230622   gcc  
s390                 randconfig-r033-20230622   clang
s390                 randconfig-r035-20230622   clang
s390                 randconfig-r044-20230621   clang
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                         microdev_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r004-20230622   gcc  
sh                          rsk7203_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230622   gcc  
sparc                randconfig-r036-20230622   gcc  
sparc                       sparc32_defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r034-20230622   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230622   clang
x86_64       buildonly-randconfig-r002-20230622   clang
x86_64       buildonly-randconfig-r003-20230622   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r002-20230621   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                              defconfig   gcc  
xtensa               randconfig-r004-20230621   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

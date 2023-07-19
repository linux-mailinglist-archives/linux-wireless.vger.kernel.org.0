Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A0D759D28
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jul 2023 20:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjGSSUb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jul 2023 14:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGSSUa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jul 2023 14:20:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9E61FC8;
        Wed, 19 Jul 2023 11:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689790827; x=1721326827;
  h=date:from:to:cc:subject:message-id;
  bh=B3io9gKG46+1pdvWfRsh5YGmc/FQHBrucuNmIgsXnwg=;
  b=gvRc/J1GL84E1sHDLQZD2yO5pT+/GT1fIs7/cU58kKcoYqiPglmdzS9+
   IPFcy8DgntenT8oBTzpIL3Z0To3JK46iU2s9WQiwrky2XOrAtvK/28WLS
   SiOjFbu39cUMHUizo7221PFCQnwxjaSHLmlVuLLgX1jFO8fzGqU4snuP4
   ae9sfQlMDvS+Hta2ytS0STPv+hZjN8TsnfjnjeSYRWjYGC7LEItyefEGW
   z1wecLuXA1UDzC2r3hsogMn4hpEgQjvAxL9qmkuB5TzvhXAW0kGyWSS//
   b6/HPr3kl3IKhXei2DHCF6NSkm0mJF9J13LgOxBzvG4aN55wqn0roJ0dy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="365421536"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="365421536"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 11:20:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="753788149"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="753788149"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 19 Jul 2023 11:20:25 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMBmi-0005Ml-1e;
        Wed, 19 Jul 2023 18:20:24 +0000
Date:   Thu, 20 Jul 2023 02:19:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        linux-serial@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [linux-next:master] BUILD SUCCESS WITH WARNING
 352ce39a8bbaec0405793682be59fae120fc6b05
Message-ID: <202307200227.IYOW22gm-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 352ce39a8bbaec0405793682be59fae120fc6b05  Add linux-next specific files for 20230719

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202306260401.qZlYQpV2-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/mfd/max77541.c:176:18: warning: cast to smaller integer type 'enum max7754x_ids' from 'const void *' [-Wvoid-pointer-to-enum-cast]

Unverified Warning (likely false positive, please contact us if interested):

drivers/tty/serial/fsl_lpuart.c:1314 lpuart_timer_func() error: uninitialized symbol 'flags'.
mm/khugepaged.c:2137 collapse_file() warn: variable dereferenced before check 'cc' (see line 1787)
net/wireless/scan.c:373 cfg80211_gen_new_ie() warn: potential spectre issue 'sub->data' [r]
net/wireless/scan.c:397 cfg80211_gen_new_ie() warn: possible spectre second half.  'ext_id'

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-m021-20230717
|   |-- net-wireless-scan.c-cfg80211_gen_new_ie()-warn:possible-spectre-second-half.-ext_id
|   `-- net-wireless-scan.c-cfg80211_gen_new_ie()-warn:potential-spectre-issue-sub-data-r
|-- nios2-randconfig-m031-20230717
|   `-- drivers-tty-serial-fsl_lpuart.c-lpuart_timer_func()-error:uninitialized-symbol-flags-.
`-- x86_64-randconfig-m001-20230717
    `-- mm-khugepaged.c-collapse_file()-warn:variable-dereferenced-before-check-cc-(see-line-)
clang_recent_errors
|-- powerpc-allmodconfig
|   `-- clang:error:unsupported-option-fsanitize-thread-for-target-powerpc-unknown-linux-gnu
|-- powerpc-randconfig-r025-20230718
|   `-- clang:error:unsupported-option-fsanitize-thread-for-target-powerpc-unknown-linux-gnu
|-- s390-randconfig-r044-20230718
|   `-- drivers-mfd-max77541.c:warning:cast-to-smaller-integer-type-enum-max7754x_ids-from-const-void
|-- x86_64-randconfig-x002-20230718
|   `-- drivers-mfd-max77541.c:warning:cast-to-smaller-integer-type-enum-max7754x_ids-from-const-void
|-- x86_64-randconfig-x003-20230718
|   `-- drivers-mfd-max77541.c:warning:cast-to-smaller-integer-type-enum-max7754x_ids-from-const-void
|-- x86_64-randconfig-x004-20230718
|   `-- drivers-mfd-max77541.c:warning:cast-to-smaller-integer-type-enum-max7754x_ids-from-const-void
|-- x86_64-randconfig-x005-20230718
|   `-- drivers-mfd-max77541.c:warning:cast-to-smaller-integer-type-enum-max7754x_ids-from-const-void
`-- x86_64-randconfig-x006-20230718
    `-- drivers-mfd-max77541.c:warning:cast-to-smaller-integer-type-enum-max7754x_ids-from-const-void

elapsed time: 772m

configs tested: 124
configs skipped: 6

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230718   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          ixp4xx_defconfig   clang
arm                        mvebu_v5_defconfig   clang
arm                  randconfig-r015-20230718   gcc  
arm                  randconfig-r034-20230718   clang
arm                  randconfig-r036-20230718   clang
arm                  randconfig-r046-20230718   gcc  
arm                        spear6xx_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230718   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r031-20230718   clang
hexagon              randconfig-r041-20230718   clang
hexagon              randconfig-r045-20230718   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230718   gcc  
i386         buildonly-randconfig-r005-20230718   gcc  
i386         buildonly-randconfig-r006-20230718   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230718   gcc  
i386                 randconfig-i002-20230718   gcc  
i386                 randconfig-i003-20230718   gcc  
i386                 randconfig-i004-20230718   gcc  
i386                 randconfig-i005-20230718   gcc  
i386                 randconfig-i006-20230718   gcc  
i386                 randconfig-i011-20230718   clang
i386                 randconfig-i012-20230718   clang
i386                 randconfig-i013-20230718   clang
i386                 randconfig-i014-20230718   clang
i386                 randconfig-i015-20230718   clang
i386                 randconfig-i016-20230718   clang
i386                 randconfig-r013-20230718   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                          multi_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                     cu1000-neo_defconfig   clang
mips                           jazz_defconfig   gcc  
mips                        maltaup_defconfig   clang
mips                 randconfig-r023-20230718   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230718   gcc  
nios2                randconfig-r005-20230718   gcc  
nios2                randconfig-r035-20230718   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r022-20230718   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                        icon_defconfig   clang
powerpc                      mgcoge_defconfig   gcc  
powerpc              randconfig-r025-20230718   clang
powerpc                     skiroot_defconfig   clang
powerpc                     tqm8540_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230718   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230718   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r012-20230718   gcc  
sh                           se7724_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230718   gcc  
sparc                randconfig-r004-20230718   gcc  
sparc                randconfig-r024-20230718   gcc  
sparc                       sparc32_defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r011-20230718   gcc  
um                   randconfig-r026-20230718   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230718   gcc  
x86_64       buildonly-randconfig-r002-20230718   gcc  
x86_64       buildonly-randconfig-r003-20230718   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230718   clang
x86_64               randconfig-x002-20230718   clang
x86_64               randconfig-x003-20230718   clang
x86_64               randconfig-x004-20230718   clang
x86_64               randconfig-x005-20230718   clang
x86_64               randconfig-x006-20230718   clang
x86_64               randconfig-x011-20230718   gcc  
x86_64               randconfig-x012-20230718   gcc  
x86_64               randconfig-x013-20230718   gcc  
x86_64               randconfig-x014-20230718   gcc  
x86_64               randconfig-x015-20230718   gcc  
x86_64               randconfig-x016-20230718   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                              defconfig   gcc  
xtensa               randconfig-r006-20230718   gcc  
xtensa               randconfig-r033-20230718   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

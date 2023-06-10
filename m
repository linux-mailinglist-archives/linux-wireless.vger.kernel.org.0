Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C075772AC23
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jun 2023 16:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjFJOJ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Jun 2023 10:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFJOJ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Jun 2023 10:09:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53393A97
        for <linux-wireless@vger.kernel.org>; Sat, 10 Jun 2023 07:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686406196; x=1717942196;
  h=date:from:to:cc:subject:message-id;
  bh=0R04ratuq0xMPBEil7GAaojAFrprYifh81DFX8pB12g=;
  b=SeZ3Uto22SnRpDvjdmIVK8alvZN89v17XNUOUs+5pgjOdpUdTL3zNmK3
   NSbxGqT+o1jQkTWhgn54CyJW/EqfDi8Ug7wWy+XaVrynb+IjzyEG/WkHi
   BxfcP2LSejZtu8+BOAv5N4GNIljEK8ZhBqt1AiT794bpkaehWEpKketpj
   B5s+SFxmIp8zBx0jc6jCJoRblzz2xH6QpRf/iaRYSni7dW430JALaAYYn
   q92xDXOYq9oNIzDjaYfME6txi/YNEcUYYK99XJT04OezkubsDDp/LKdy6
   bF0fzBEjrpEihR0hQdoxAvyErnkaLiqzqFmEJt3rN71/ex8F4X2WQ3drq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="386143944"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="386143944"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 07:09:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="713835383"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="713835383"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jun 2023 07:09:40 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7zHf-000A87-2R;
        Sat, 10 Jun 2023 14:09:39 +0000
Date:   Sat, 10 Jun 2023 22:09:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 7b3b9ac899b54f53f7c9fc07e1c562f56b2187fa
Message-ID: <202306102222.YVUJy5aV-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 7b3b9ac899b54f53f7c9fc07e1c562f56b2187fa  wifi: mac80211: Use active_links instead of valid_links in Tx

elapsed time: 1280m

configs tested: 126
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230608   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230608   gcc  
alpha                randconfig-r023-20230608   gcc  
alpha                randconfig-r033-20230608   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                  randconfig-r012-20230608   gcc  
arc                  randconfig-r015-20230608   gcc  
arc                  randconfig-r025-20230608   gcc  
arc                  randconfig-r043-20230608   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          ep93xx_defconfig   clang
arm                          moxart_defconfig   clang
arm                       netwinder_defconfig   clang
arm                  randconfig-r011-20230610   clang
arm                  randconfig-r025-20230608   gcc  
arm                  randconfig-r046-20230608   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230608   gcc  
arm64        buildonly-randconfig-r004-20230608   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r022-20230608   clang
arm64                randconfig-r034-20230608   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230608   gcc  
csky                 randconfig-r034-20230608   gcc  
hexagon      buildonly-randconfig-r006-20230608   clang
hexagon              randconfig-r016-20230608   clang
hexagon              randconfig-r041-20230608   clang
hexagon              randconfig-r045-20230608   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r005-20230608   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i051-20230608   gcc  
i386                 randconfig-i052-20230608   gcc  
i386                 randconfig-i053-20230608   gcc  
i386                 randconfig-i054-20230608   gcc  
i386                 randconfig-i055-20230608   gcc  
i386                 randconfig-i056-20230608   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k         buildonly-randconfig-r004-20230610   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                 randconfig-r013-20230608   gcc  
m68k                 randconfig-r024-20230608   gcc  
m68k                 randconfig-r031-20230608   gcc  
m68k                 randconfig-r033-20230608   gcc  
microblaze           randconfig-r014-20230610   gcc  
microblaze           randconfig-r024-20230608   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips         buildonly-randconfig-r002-20230608   clang
mips                 randconfig-r022-20230608   gcc  
nios2        buildonly-randconfig-r006-20230610   gcc  
nios2                               defconfig   gcc  
openrisc     buildonly-randconfig-r005-20230610   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230610   gcc  
parisc               randconfig-r023-20230608   gcc  
parisc               randconfig-r032-20230608   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230610   gcc  
powerpc                      katmai_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc              randconfig-r021-20230608   clang
powerpc                      tqm8xx_defconfig   gcc  
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv        buildonly-randconfig-r003-20230610   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r013-20230610   gcc  
riscv                randconfig-r036-20230608   gcc  
riscv                randconfig-r042-20230608   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r026-20230608   clang
s390                 randconfig-r044-20230608   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r026-20230608   gcc  
sh                   randconfig-r035-20230608   gcc  
sh                   randconfig-r036-20230608   gcc  
sh                          rsk7201_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc        buildonly-randconfig-r002-20230610   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230608   gcc  
sparc                randconfig-r016-20230610   gcc  
sparc64              randconfig-r015-20230610   gcc  
sparc64              randconfig-r032-20230608   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r031-20230608   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

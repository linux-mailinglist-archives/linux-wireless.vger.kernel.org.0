Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFE76DEA11
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 06:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjDLD76 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 23:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLD74 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 23:59:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D27E40FB
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 20:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681271995; x=1712807995;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JoTVwrmSr8I8e1Iq7VXkzz+7zvXfVdab0D9eX++G77k=;
  b=VOTo+9nebw0czAAa0Zn4GUik014E5RojsvGzK+dA0vKHizlgFb3cnDm/
   s4YPm70f+PJC0HRMa7YUEoTd2UPjWYQjnWIILUnHmOZpZKcqMhcMG9rYq
   api010fKqu9opjeiCdB6l0F10MiIdZ0XnP17BGtUVfagDlIPUCPEMfcVI
   JGiJJDcgUtKgHxfi2DAkQtvcA68LTdL25SE+r8+pqL5r8R++hZpNueFil
   roTeHzJrI/8PuJ3oe7OxMYjb+f+Aofg3C2rzSgjm2Wqz5AHBACUtz5SzX
   LZcVQ424c16LLf174CJAtQwXjkJcv3l54KzoWd1FKdL5UyqFXYRK+7wc8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="341283234"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="341283234"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 20:59:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="934968435"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="934968435"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 Apr 2023 20:59:53 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmReC-000XFD-23;
        Wed, 12 Apr 2023 03:59:52 +0000
Date:   Wed, 12 Apr 2023 11:59:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:main] BUILD SUCCESS
 e3e0ca32cf478e78c579b02cd9c1657d93c97add
Message-ID: <64362c9a.3uOUsWxr/fnb/ZPQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: e3e0ca32cf478e78c579b02cd9c1657d93c97add  wifi: mac80211: set EHT support flag in AP mode

elapsed time: 723m

configs tested: 175
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230409   gcc  
alpha        buildonly-randconfig-r006-20230410   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230409   gcc  
alpha                randconfig-r013-20230410   gcc  
alpha                randconfig-r022-20230412   gcc  
alpha                randconfig-r025-20230410   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230409   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r012-20230409   gcc  
arc                  randconfig-r015-20230409   gcc  
arc                  randconfig-r031-20230410   gcc  
arc                  randconfig-r043-20230409   gcc  
arc                  randconfig-r043-20230410   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230410   clang
arm          buildonly-randconfig-r005-20230409   clang
arm                                 defconfig   gcc  
arm                  randconfig-r012-20230410   clang
arm                  randconfig-r014-20230409   clang
arm                  randconfig-r016-20230409   clang
arm                  randconfig-r033-20230412   gcc  
arm                  randconfig-r046-20230409   clang
arm                  randconfig-r046-20230410   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230410   clang
csky                                defconfig   gcc  
csky                 randconfig-r003-20230411   gcc  
csky                 randconfig-r031-20230409   gcc  
hexagon              randconfig-r001-20230411   clang
hexagon              randconfig-r005-20230410   clang
hexagon              randconfig-r024-20230412   clang
hexagon              randconfig-r041-20230409   clang
hexagon              randconfig-r041-20230410   clang
hexagon              randconfig-r045-20230409   clang
hexagon              randconfig-r045-20230410   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230410   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230410   clang
i386                 randconfig-a002-20230410   clang
i386                 randconfig-a003-20230410   clang
i386                 randconfig-a004-20230410   clang
i386                 randconfig-a005-20230410   clang
i386                 randconfig-a006-20230410   clang
i386                 randconfig-a011-20230410   gcc  
i386                 randconfig-a012-20230410   gcc  
i386                 randconfig-a013-20230410   gcc  
i386                 randconfig-a014-20230410   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                 randconfig-a016-20230410   gcc  
i386                 randconfig-r015-20230410   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230410   gcc  
ia64         buildonly-randconfig-r002-20230409   gcc  
ia64         buildonly-randconfig-r005-20230409   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230410   gcc  
ia64                 randconfig-r005-20230411   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230411   gcc  
loongarch            randconfig-r022-20230409   gcc  
loongarch            randconfig-r026-20230410   gcc  
loongarch            randconfig-r034-20230410   gcc  
loongarch            randconfig-r035-20230409   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230409   gcc  
m68k                 randconfig-r034-20230412   gcc  
microblaze   buildonly-randconfig-r004-20230410   gcc  
microblaze           randconfig-r036-20230410   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230409   gcc  
mips         buildonly-randconfig-r002-20230410   gcc  
mips         buildonly-randconfig-r006-20230409   gcc  
mips                 randconfig-r032-20230412   gcc  
mips                 randconfig-r034-20230409   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230411   gcc  
openrisc             randconfig-r012-20230410   gcc  
openrisc             randconfig-r021-20230412   gcc  
openrisc             randconfig-r022-20230410   gcc  
parisc       buildonly-randconfig-r003-20230409   gcc  
parisc       buildonly-randconfig-r003-20230410   gcc  
parisc       buildonly-randconfig-r004-20230409   gcc  
parisc       buildonly-randconfig-r004-20230410   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r013-20230409   gcc  
parisc               randconfig-r014-20230409   gcc  
parisc               randconfig-r023-20230410   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230410   gcc  
powerpc              randconfig-r006-20230409   clang
powerpc              randconfig-r016-20230409   gcc  
powerpc              randconfig-r016-20230410   gcc  
powerpc              randconfig-r036-20230412   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230409   gcc  
riscv        buildonly-randconfig-r002-20230410   gcc  
riscv        buildonly-randconfig-r005-20230410   gcc  
riscv        buildonly-randconfig-r006-20230409   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230409   clang
riscv                randconfig-r003-20230410   clang
riscv                randconfig-r004-20230409   clang
riscv                randconfig-r014-20230410   gcc  
riscv                randconfig-r021-20230409   gcc  
riscv                randconfig-r026-20230409   gcc  
riscv                randconfig-r031-20230412   clang
riscv                randconfig-r035-20230410   clang
riscv                randconfig-r035-20230412   clang
riscv                randconfig-r042-20230409   gcc  
riscv                randconfig-r042-20230410   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r013-20230409   gcc  
s390                 randconfig-r015-20230409   gcc  
s390                 randconfig-r044-20230409   gcc  
s390                 randconfig-r044-20230410   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r004-20230410   gcc  
sh                   randconfig-r011-20230409   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230409   gcc  
sparc                randconfig-r015-20230410   gcc  
sparc64              randconfig-r011-20230410   gcc  
sparc64              randconfig-r021-20230410   gcc  
sparc64              randconfig-r032-20230409   gcc  
sparc64              randconfig-r033-20230409   gcc  
sparc64              randconfig-r036-20230409   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230410   clang
x86_64               randconfig-a002-20230410   clang
x86_64               randconfig-a003-20230410   clang
x86_64               randconfig-a004-20230410   clang
x86_64               randconfig-a005-20230410   clang
x86_64               randconfig-a006-20230410   clang
x86_64               randconfig-a011-20230410   gcc  
x86_64                        randconfig-a011   gcc  
x86_64               randconfig-a012-20230410   gcc  
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230410   gcc  
x86_64                        randconfig-a013   gcc  
x86_64               randconfig-a014-20230410   gcc  
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230410   gcc  
x86_64                        randconfig-a015   gcc  
x86_64               randconfig-a016-20230410   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-r006-20230410   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230409   gcc  
xtensa               randconfig-r004-20230411   gcc  
xtensa               randconfig-r005-20230409   gcc  
xtensa               randconfig-r014-20230410   gcc  
xtensa               randconfig-r024-20230410   gcc  
xtensa               randconfig-r033-20230410   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

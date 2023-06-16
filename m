Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7833E733CC5
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jun 2023 01:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjFPXSD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 19:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjFPXSC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 19:18:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0D33A9E
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 16:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686957481; x=1718493481;
  h=date:from:to:cc:subject:message-id;
  bh=XgYY1uNSKyH3+wzlwmVjuGqeXjMfNA97+VLT3uB1VIA=;
  b=G1ZEMQ/o8jf6OhGgNlO2J6OPpQUIqb8678loyqipsw9OiLT5/Cu/vbNh
   PCdnXQhZ2jPSgCEU3FYX1iLDT5ctn6ZUmb+8ClERiJ6YSBmgBgRKKpm6a
   ywszG2br0/XCWIKhmJv4c737bEE4kkv2JCVO0uXmnMlLd0IjNA/VONSPr
   p6DeyxT3XJTl5Fi3AGVKB8r807K4AYx4vDtbP+1NGD40aZVQ6FC7oj48L
   6g2kphCe2jO1kq23m3s9pRepmcAgYvzelDiH3jdbh4GFKqQTcaglEbaxA
   uR6DMzhJNqEjR+t2YbQKYzR/lLiQRXUixJ6RZcyMeeQq0ooVRllm6w3Q5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="358207983"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="358207983"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 16:18:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="825920236"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="825920236"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jun 2023 16:17:59 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qAIha-0001uF-2I;
        Fri, 16 Jun 2023 23:17:58 +0000
Date:   Sat, 17 Jun 2023 07:17:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 707a13c7e488785170a5e7f2467f2823824651e2
Message-ID: <202306170738.50riGD1T-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 707a13c7e488785170a5e7f2467f2823824651e2  wifi: ray_cs: fix stringop-truncation GCC warning

elapsed time: 767m

configs tested: 131
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230616   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230615   gcc  
arc                  randconfig-r025-20230616   gcc  
arc                  randconfig-r033-20230616   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r004-20230615   clang
arm                  randconfig-r012-20230616   clang
arm                  randconfig-r034-20230616   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230616   clang
arm64                randconfig-r033-20230616   clang
csky         buildonly-randconfig-r001-20230616   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230615   gcc  
csky                 randconfig-r005-20230615   gcc  
csky                 randconfig-r026-20230616   gcc  
csky                 randconfig-r031-20230616   gcc  
hexagon              randconfig-r026-20230616   clang
hexagon              randconfig-r035-20230616   clang
hexagon              randconfig-r036-20230616   clang
hexagon              randconfig-r045-20230616   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230616   clang
i386         buildonly-randconfig-r005-20230616   clang
i386         buildonly-randconfig-r006-20230616   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230616   clang
i386                 randconfig-i002-20230616   clang
i386                 randconfig-i003-20230616   clang
i386                 randconfig-i004-20230616   clang
i386                 randconfig-i005-20230616   clang
i386                 randconfig-i006-20230616   clang
i386                 randconfig-i011-20230616   gcc  
i386                 randconfig-i012-20230616   gcc  
i386                 randconfig-i013-20230616   gcc  
i386                 randconfig-i014-20230616   gcc  
i386                 randconfig-i015-20230616   gcc  
i386                 randconfig-i016-20230616   gcc  
i386                 randconfig-r022-20230616   gcc  
i386                 randconfig-r024-20230616   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r012-20230616   gcc  
loongarch            randconfig-r014-20230616   gcc  
loongarch            randconfig-r015-20230616   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r036-20230616   gcc  
microblaze           randconfig-r006-20230616   gcc  
microblaze           randconfig-r014-20230616   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r006-20230616   gcc  
mips                 randconfig-r016-20230616   clang
mips                 randconfig-r024-20230616   clang
nios2                               defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230616   gcc  
parisc               randconfig-r016-20230616   gcc  
parisc               randconfig-r023-20230616   gcc  
parisc               randconfig-r025-20230616   gcc  
parisc               randconfig-r031-20230616   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r004-20230616   clang
powerpc              randconfig-r034-20230616   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv        buildonly-randconfig-r004-20230616   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230615   gcc  
riscv                randconfig-r042-20230616   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230616   clang
s390                 randconfig-r011-20230616   gcc  
s390                 randconfig-r013-20230616   gcc  
s390                 randconfig-r021-20230616   gcc  
s390                 randconfig-r044-20230616   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r002-20230616   gcc  
sh                   randconfig-r005-20230616   gcc  
sh                   randconfig-r021-20230616   gcc  
sh                   randconfig-r035-20230616   gcc  
sparc                            allyesconfig   gcc  
sparc        buildonly-randconfig-r005-20230616   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r022-20230616   gcc  
sparc64              randconfig-r003-20230616   gcc  
sparc64              randconfig-r023-20230616   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r005-20230616   gcc  
um                   randconfig-r015-20230616   clang
um                   randconfig-r032-20230616   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230616   clang
x86_64       buildonly-randconfig-r002-20230616   clang
x86_64       buildonly-randconfig-r003-20230616   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230616   clang
x86_64               randconfig-a002-20230616   clang
x86_64               randconfig-a003-20230616   clang
x86_64               randconfig-a004-20230616   clang
x86_64               randconfig-a005-20230616   clang
x86_64               randconfig-a006-20230616   clang
x86_64               randconfig-a011-20230616   gcc  
x86_64               randconfig-a012-20230616   gcc  
x86_64               randconfig-a013-20230616   gcc  
x86_64               randconfig-a014-20230616   gcc  
x86_64               randconfig-a015-20230616   gcc  
x86_64               randconfig-a016-20230616   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

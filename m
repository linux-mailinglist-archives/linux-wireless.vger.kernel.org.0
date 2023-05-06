Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381376F8DE2
	for <lists+linux-wireless@lfdr.de>; Sat,  6 May 2023 04:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjEFCQi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 May 2023 22:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjEFCQh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 May 2023 22:16:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F775BB0
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 19:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683339396; x=1714875396;
  h=date:from:to:cc:subject:message-id;
  bh=v/Ty7kHz58UrxCpk49nwgf0A3OMSe7oQN8Js8gTbKT4=;
  b=XMjc1lkRBrCMlP48hcFXLoWtPyHyEhM7BAAeDfVG3UCDWQaix42u0orS
   fj6YoCxpcLqRXAfMrfj7PuwjKoM8Fgk00sn7Oy9QB9aVvhpByPn7TSTQr
   A3I96MWSApteuNkt48totta/YuaEccz1BkKnv2nHEJuueZpvS4bWGLfyR
   yRDFLP5DPZci+B6ldb80SkUSfo7wOrAjSz35iIrbFV7HoKtu0iKHy5fKn
   FfkDF+0udH5MQV1MnkCrMmSOQ9VC3MU49WQejL2KWurDqdogZG/KoVOKe
   DnDcEeWrmdHi1RgIT26sWkG5RmLJhyuyurHzy2pLlAiUqGpBE11ubGbEy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="435655027"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="435655027"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 19:16:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="691891268"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="691891268"
Received: from lkp-server01.sh.intel.com (HELO fe5d646e317d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 05 May 2023 19:16:34 -0700
Received: from kbuild by fe5d646e317d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pv7TO-00013p-0E;
        Sat, 06 May 2023 02:16:34 +0000
Date:   Sat, 06 May 2023 10:16:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 f3dc7bb037d813ab7da84f488dd485f0fce66347
Message-ID: <20230506021607.bImkN%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: f3dc7bb037d813ab7da84f488dd485f0fce66347  wifi: mt7601u: delete dead code checking debugfs returns

elapsed time: 812m

configs tested: 168
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230430   gcc  
alpha        buildonly-randconfig-r005-20230505   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230501   gcc  
alpha                randconfig-r003-20230505   gcc  
alpha                randconfig-r023-20230430   gcc  
alpha                randconfig-r031-20230501   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230430   gcc  
arc          buildonly-randconfig-r002-20230502   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r022-20230430   gcc  
arc                  randconfig-r024-20230502   gcc  
arc                  randconfig-r036-20230430   gcc  
arc                  randconfig-r043-20230430   gcc  
arc                  randconfig-r043-20230501   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r002-20230505   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r002-20230430   clang
arm                  randconfig-r002-20230501   clang
arm                  randconfig-r046-20230430   gcc  
arm                  randconfig-r046-20230501   gcc  
arm                         s3c6400_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r006-20230505   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230501   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230502   gcc  
csky                 randconfig-r021-20230430   gcc  
hexagon              randconfig-r001-20230430   clang
hexagon              randconfig-r005-20230502   clang
hexagon              randconfig-r006-20230501   clang
hexagon              randconfig-r016-20230430   clang
hexagon              randconfig-r024-20230501   clang
hexagon              randconfig-r041-20230430   clang
hexagon              randconfig-r041-20230501   clang
hexagon              randconfig-r045-20230430   clang
hexagon              randconfig-r045-20230501   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r003-20230501   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230501   gcc  
i386                 randconfig-a002-20230501   gcc  
i386                 randconfig-a003-20230501   gcc  
i386                 randconfig-a004-20230501   gcc  
i386                 randconfig-a005-20230501   gcc  
i386                 randconfig-a006-20230501   gcc  
i386                 randconfig-a011-20230501   clang
i386                 randconfig-a012-20230501   clang
i386                 randconfig-a013-20230501   clang
i386                 randconfig-a014-20230501   clang
i386                 randconfig-a015-20230501   clang
i386                 randconfig-a016-20230501   clang
i386                 randconfig-r013-20230501   clang
i386                 randconfig-r016-20230501   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230502   gcc  
ia64         buildonly-randconfig-r004-20230502   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r011-20230430   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230505   gcc  
loongarch    buildonly-randconfig-r005-20230501   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r012-20230501   gcc  
loongarch            randconfig-r012-20230502   gcc  
loongarch            randconfig-r021-20230502   gcc  
loongarch            randconfig-r022-20230501   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230501   gcc  
m68k         buildonly-randconfig-r006-20230501   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230430   gcc  
m68k                 randconfig-r011-20230501   gcc  
m68k                 randconfig-r014-20230430   gcc  
m68k                 randconfig-r025-20230502   gcc  
m68k                 randconfig-r026-20230501   gcc  
m68k                 randconfig-r033-20230430   gcc  
microblaze           randconfig-r013-20230430   gcc  
microblaze           randconfig-r025-20230430   gcc  
microblaze           randconfig-r025-20230501   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r003-20230502   gcc  
mips                     loongson1c_defconfig   clang
mips                 randconfig-r004-20230502   gcc  
mips                 randconfig-r012-20230430   gcc  
nios2                            allyesconfig   gcc  
nios2        buildonly-randconfig-r004-20230501   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230505   gcc  
nios2                randconfig-r015-20230502   gcc  
nios2                randconfig-r023-20230501   gcc  
openrisc     buildonly-randconfig-r004-20230430   gcc  
openrisc             randconfig-r022-20230502   gcc  
openrisc             randconfig-r026-20230502   gcc  
parisc       buildonly-randconfig-r006-20230502   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230502   gcc  
parisc               randconfig-r005-20230430   gcc  
parisc               randconfig-r026-20230430   gcc  
parisc               randconfig-r034-20230430   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 mpc836x_rdk_defconfig   clang
powerpc              randconfig-r031-20230430   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r021-20230501   clang
riscv                randconfig-r032-20230501   gcc  
riscv                randconfig-r042-20230430   clang
riscv                randconfig-r042-20230501   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r011-20230502   gcc  
s390                 randconfig-r014-20230502   gcc  
s390                 randconfig-r035-20230430   gcc  
s390                 randconfig-r044-20230430   clang
s390                 randconfig-r044-20230501   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230505   gcc  
sh                   randconfig-r004-20230430   gcc  
sh                   randconfig-r005-20230505   gcc  
sh                   randconfig-r014-20230501   gcc  
sh                   randconfig-r015-20230501   gcc  
sh                   randconfig-r033-20230501   gcc  
sparc        buildonly-randconfig-r004-20230505   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230430   gcc  
sparc                randconfig-r003-20230502   gcc  
sparc                randconfig-r013-20230502   gcc  
sparc64              randconfig-r005-20230501   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230501   gcc  
x86_64               randconfig-a002-20230501   gcc  
x86_64               randconfig-a003-20230501   gcc  
x86_64               randconfig-a004-20230501   gcc  
x86_64               randconfig-a005-20230501   gcc  
x86_64               randconfig-a006-20230501   gcc  
x86_64               randconfig-a011-20230501   clang
x86_64               randconfig-a012-20230501   clang
x86_64               randconfig-a013-20230501   clang
x86_64               randconfig-a014-20230501   clang
x86_64               randconfig-a015-20230501   clang
x86_64               randconfig-a016-20230501   clang
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230430   gcc  
xtensa       buildonly-randconfig-r006-20230430   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa               randconfig-r015-20230430   gcc  
xtensa               randconfig-r035-20230501   gcc  
xtensa               randconfig-r036-20230501   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

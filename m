Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82566C8940
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Mar 2023 00:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCXX3m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Mar 2023 19:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCXX3l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Mar 2023 19:29:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD76E1705
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 16:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679700580; x=1711236580;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=EexPhkhiAPO1ZcjIcIobslQu79vhZBoac9/myjsi2Ig=;
  b=VeHR7reF0R/wKN2S8utBU2H1OXGtk39I8zpU5idW1oF6ZuMVqH2q1+Sc
   ehW2FCQd/OrsmYFXZS0DXc3T9p4QewV4YopZq6Ci14nC7Glw8QITaN6Qy
   +LGAqw2EcnnzNZ8yQXXXskmkih2M1e16kp3um8GKUFV84aysZFHJq46Rw
   waLhkAgxPVIBtN+4OJ3d6mDAUBVZABivo4TbWZan6+6V/DIRPNjZIAd6L
   3zoXDtoueoZu/N+h9M6yfNBK6hGBEMga4e5i5rvhFqQsq7Jybc2c/780m
   36LrfwsGDpKiWlPM36KIjSqq6/TD91lugpM8e1igVVHPTKu9Cxj/BZeOB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="337413852"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="337413852"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 16:29:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="857047441"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="857047441"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Mar 2023 16:29:38 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfqqn-000Fl5-2e;
        Fri, 24 Mar 2023 23:29:37 +0000
Date:   Sat, 25 Mar 2023 07:28:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:main] BUILD SUCCESS
 2af3b2a631b194a43551ce119cb71559d8f6b54b
Message-ID: <641e3230.s5RHjezAZBstz+RZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 2af3b2a631b194a43551ce119cb71559d8f6b54b  mac80211_hwsim: add PMSR report support via virtio

elapsed time: 727m

configs tested: 215
configs skipped: 18

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230322   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r016-20230322   gcc  
alpha                randconfig-r026-20230322   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                  randconfig-r013-20230323   gcc  
arc                  randconfig-r036-20230322   gcc  
arc                  randconfig-r043-20230322   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r003-20230324   clang
arm          buildonly-randconfig-r006-20230324   clang
arm                                 defconfig   gcc  
arm                          moxart_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                  randconfig-r014-20230322   clang
arm                  randconfig-r025-20230322   clang
arm                  randconfig-r032-20230322   gcc  
arm                  randconfig-r035-20230322   gcc  
arm                  randconfig-r046-20230322   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230324   clang
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230322   clang
arm64                randconfig-r004-20230322   clang
arm64                randconfig-r005-20230322   clang
arm64                randconfig-r011-20230322   gcc  
arm64                randconfig-r013-20230322   gcc  
arm64                randconfig-r022-20230322   gcc  
csky         buildonly-randconfig-r002-20230324   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230322   gcc  
csky                 randconfig-r012-20230322   gcc  
csky                 randconfig-r016-20230322   gcc  
csky                 randconfig-r022-20230324   gcc  
csky                 randconfig-r024-20230322   gcc  
csky                 randconfig-r026-20230322   gcc  
csky                 randconfig-r034-20230322   gcc  
hexagon                          alldefconfig   clang
hexagon      buildonly-randconfig-r006-20230323   clang
hexagon              randconfig-r006-20230322   clang
hexagon              randconfig-r031-20230322   clang
hexagon              randconfig-r033-20230324   clang
hexagon              randconfig-r041-20230322   clang
hexagon              randconfig-r045-20230322   clang
i386                             allyesconfig   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230322   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230322   gcc  
ia64                 randconfig-r004-20230322   gcc  
ia64                 randconfig-r011-20230322   gcc  
ia64                 randconfig-r012-20230322   gcc  
ia64                 randconfig-r013-20230322   gcc  
ia64                 randconfig-r014-20230323   gcc  
ia64                 randconfig-r015-20230322   gcc  
ia64                 randconfig-r016-20230322   gcc  
ia64                 randconfig-r033-20230322   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230322   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r014-20230322   gcc  
loongarch            randconfig-r021-20230322   gcc  
loongarch            randconfig-r024-20230322   gcc  
loongarch            randconfig-r026-20230324   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230322   gcc  
m68k         buildonly-randconfig-r006-20230322   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230322   gcc  
m68k                 randconfig-r015-20230322   gcc  
m68k                 randconfig-r016-20230322   gcc  
m68k                 randconfig-r023-20230322   gcc  
m68k                 randconfig-r034-20230322   gcc  
microblaze           randconfig-r015-20230322   gcc  
microblaze           randconfig-r024-20230324   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230322   gcc  
mips         buildonly-randconfig-r004-20230322   gcc  
mips                 randconfig-r034-20230322   gcc  
mips                 randconfig-r035-20230322   gcc  
mips                 randconfig-r036-20230322   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230322   gcc  
nios2                randconfig-r016-20230322   gcc  
nios2                randconfig-r033-20230322   gcc  
nios2                randconfig-r035-20230322   gcc  
openrisc     buildonly-randconfig-r001-20230324   gcc  
openrisc     buildonly-randconfig-r005-20230324   gcc  
openrisc             randconfig-r011-20230323   gcc  
openrisc             randconfig-r012-20230322   gcc  
openrisc             randconfig-r015-20230322   gcc  
openrisc             randconfig-r023-20230322   gcc  
openrisc             randconfig-r025-20230322   gcc  
openrisc             randconfig-r026-20230322   gcc  
openrisc             randconfig-r031-20230322   gcc  
openrisc             randconfig-r032-20230322   gcc  
openrisc             randconfig-r036-20230322   gcc  
openrisc                       virt_defconfig   gcc  
parisc       buildonly-randconfig-r005-20230322   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230322   gcc  
parisc               randconfig-r011-20230322   gcc  
parisc               randconfig-r012-20230323   gcc  
parisc               randconfig-r013-20230322   gcc  
parisc               randconfig-r015-20230322   gcc  
parisc               randconfig-r016-20230322   gcc  
parisc               randconfig-r031-20230322   gcc  
parisc               randconfig-r034-20230322   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230322   gcc  
powerpc      buildonly-randconfig-r005-20230322   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                 mpc837x_mds_defconfig   gcc  
powerpc              randconfig-r013-20230322   gcc  
powerpc              randconfig-r021-20230322   gcc  
powerpc              randconfig-r025-20230322   gcc  
powerpc              randconfig-r035-20230322   clang
powerpc                     taishan_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                randconfig-r001-20230322   clang
riscv                randconfig-r006-20230322   clang
riscv                randconfig-r021-20230322   gcc  
riscv                randconfig-r024-20230322   gcc  
riscv                randconfig-r034-20230324   clang
riscv                randconfig-r042-20230322   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230323   clang
s390                                defconfig   gcc  
s390                 randconfig-r012-20230322   gcc  
s390                 randconfig-r014-20230322   gcc  
s390                 randconfig-r022-20230322   gcc  
s390                 randconfig-r023-20230322   gcc  
s390                 randconfig-r035-20230322   clang
s390                 randconfig-r044-20230322   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230322   gcc  
sh                          r7780mp_defconfig   gcc  
sh                   randconfig-r005-20230322   gcc  
sh                   randconfig-r016-20230322   gcc  
sh                   randconfig-r022-20230322   gcc  
sh                   randconfig-r026-20230322   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230322   gcc  
sparc                randconfig-r011-20230322   gcc  
sparc                randconfig-r015-20230322   gcc  
sparc                randconfig-r023-20230322   gcc  
sparc64      buildonly-randconfig-r001-20230322   gcc  
sparc64      buildonly-randconfig-r006-20230322   gcc  
sparc64              randconfig-r016-20230323   gcc  
sparc64              randconfig-r032-20230322   gcc  
sparc64              randconfig-r033-20230322   gcc  
sparc64              randconfig-r036-20230322   gcc  
um                               alldefconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa       buildonly-randconfig-r004-20230322   gcc  
xtensa               randconfig-r013-20230322   gcc  
xtensa               randconfig-r022-20230322   gcc  
xtensa               randconfig-r031-20230322   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

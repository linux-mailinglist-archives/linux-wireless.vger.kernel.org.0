Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765CF63717D
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 05:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiKXE07 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 23:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiKXE05 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 23:26:57 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35992C8CB9
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 20:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669264017; x=1700800017;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KFg1SnHHIGANoLyO9ie5lMMQnDV2fYKj3llJsgTrX1M=;
  b=jv1zKkVAqc0S4iDKRE01cjO46U1Ldksi/C4jjsBN6aNNDKxldygyKdAC
   exTktMlILbAP7QrmIroOmwU9oOvz+TwBalzFqIkwgFNbgXqdxRYR4FcF+
   mE/00Z/GhIe8lFMU1Cp6EQ+kw41la07+V6TlPh4cnw2Nd4CVO1cZE9b1Y
   MWOEC25sZcmNRfyFhHHBifvSASlXMr8mwrVq/9AhBRVOKYXPHKT6UGWW+
   oxmYN++2AlB98xPpGYDDFBpmAwFVRzQDQ8gsza84I/2oB+rOjVVEqfYUg
   e5XVXeuqdgAoWixl73Bu7Tz58mY0qly12PBvejH/giR7TY9NYzk1puM3i
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="376357366"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="376357366"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 20:26:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="673103167"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="673103167"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2022 20:26:55 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oy3p8-0003VZ-2C;
        Thu, 24 Nov 2022 04:26:54 +0000
Date:   Thu, 24 Nov 2022 12:26:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:pending] BUILD SUCCESS
 c959453853cd967602cbcff0e10bd7071532ab98
Message-ID: <637ef279.PLQLBnwANIw19Lw8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git pending
branch HEAD: c959453853cd967602cbcff0e10bd7071532ab98  wifi: wilc1000: validate number of channels

elapsed time: 726m

configs tested: 88
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                          allmodconfig
mips                             allyesconfig
s390                                defconfig
powerpc                           allnoconfig
s390                             allmodconfig
sh                               allmodconfig
s390                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                            allnoconfig
i386                             allyesconfig
i386                                defconfig
x86_64               randconfig-a011-20221121
x86_64               randconfig-a014-20221121
x86_64               randconfig-a012-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a016-20221121
x86_64               randconfig-a015-20221121
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
sparc                             allnoconfig
sh                            hp6xx_defconfig
sh                         ecovec24_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm                            hisi_defconfig
csky                                defconfig
mips                     loongson1b_defconfig
arm                        clps711x_defconfig
xtensa                  audio_kc705_defconfig
mips                           gcw0_defconfig
xtensa                generic_kc705_defconfig
arm                      jornada720_defconfig
s390                 randconfig-r044-20221121
riscv                randconfig-r042-20221121
arc                  randconfig-r043-20221120
arc                  randconfig-r043-20221121
arc                        nsim_700_defconfig
sh                           se7722_defconfig
arc                     haps_hs_smp_defconfig
openrisc                       virt_defconfig
powerpc                    klondike_defconfig
arm                           viper_defconfig
m68k                          hp300_defconfig
riscv                               defconfig
microblaze                          defconfig
sh                           se7780_defconfig
i386                 randconfig-a014-20221121
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a016-20221121
i386                 randconfig-a012-20221121
i386                 randconfig-a015-20221121
i386                          randconfig-c001
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
x86_64               randconfig-a002-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a006-20221121
x86_64               randconfig-a005-20221121
x86_64               randconfig-a003-20221121
x86_64                        randconfig-k001
i386                 randconfig-a001-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a006-20221121
i386                 randconfig-a004-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121
mips                      malta_kvm_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3006950CD22
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Apr 2022 21:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiDWTFn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Apr 2022 15:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiDWTFm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Apr 2022 15:05:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2EF1C6C83
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 12:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650740564; x=1682276564;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rzfDe75rsZUXw0HIEFqm2U+MygSDtPIMdqEnZAJb2hk=;
  b=c1wolt13wHFxp9A0wyoSRsCXR1N18V90FnWZKz9aQI7vygcuyG+AbvwA
   v2t7+erziM0eCCp1kacDbZ7J4AB6FAbssKlUvj97WErNGDItbV2JtrKmg
   Bns8imNLvZIvuPe/Ps1otAIRUk/GkIT9AvV8NmEw+XelZw1clsCp9IAWq
   hfs1CEsiqVSqK8jJ6iRe90xkkZHo9Y2zM4gZZkdrbIkl6C8FIPz6GKcIL
   P3Qee5E+2nAlo8Vh0F5IrjTbt+SpwoLIyIPiGP6hLoS/TA1pOnJGbC24d
   70skZYB049qgVikKLLp9pbDGQVBctNy46ukRgPPIhz9N6YyYGstSnbbpL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="245510942"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="245510942"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 12:02:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="512025548"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Apr 2022 12:02:42 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niL1l-0000Mr-Mt;
        Sat, 23 Apr 2022 19:02:41 +0000
Date:   Sun, 24 Apr 2022 03:02:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:main] BUILD SUCCESS
 4dd4e6f659850f2df20b9612593f5a0f040549e1
Message-ID: <62644d3a.bnDCgtR0loNOE0xv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git main
branch HEAD: 4dd4e6f659850f2df20b9612593f5a0f040549e1  MAINTAINERS: update iwlwifi driver maintainer

elapsed time: 734m

configs tested: 125
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                ecovec24-romimage_defconfig
xtensa                    smp_lx200_defconfig
arc                        nsimosci_defconfig
h8300                       h8s-sim_defconfig
sh                     sh7710voipgw_defconfig
arc                      axs103_smp_defconfig
sh                        edosk7705_defconfig
powerpc                       ppc64_defconfig
powerpc                        cell_defconfig
powerpc                    sam440ep_defconfig
openrisc                 simple_smp_defconfig
sh                               alldefconfig
sparc                               defconfig
powerpc                      ppc40x_defconfig
sh                        edosk7760_defconfig
arc                          axs103_defconfig
m68k                        m5407c3_defconfig
m68k                          atari_defconfig
sh                          rsk7203_defconfig
mips                     decstation_defconfig
ia64                         bigsur_defconfig
powerpc                      pasemi_defconfig
sh                        apsh4ad0a_defconfig
sh                           se7705_defconfig
sh                   sh7724_generic_defconfig
sh                          r7780mp_defconfig
powerpc                      chrp32_defconfig
sh                         ecovec24_defconfig
riscv                            allyesconfig
m68k                       m5475evb_defconfig
powerpc                   currituck_defconfig
powerpc                 canyonlands_defconfig
powerpc                       holly_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220422
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
riscv                randconfig-c006-20220422
mips                 randconfig-c004-20220422
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220422
powerpc              randconfig-c003-20220422
mips                          ath25_defconfig
powerpc                     tqm8540_defconfig
arm                         orion5x_defconfig
mips                     cu1830-neo_defconfig
riscv                    nommu_virt_defconfig
powerpc                      walnut_defconfig
mips                         tb0219_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220422
riscv                randconfig-r042-20220422
hexagon              randconfig-r045-20220422

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF5375BAFF
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jul 2023 01:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjGTXG3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jul 2023 19:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTXG2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jul 2023 19:06:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C305319A1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 16:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689894386; x=1721430386;
  h=date:from:to:cc:subject:message-id;
  bh=SKJBSZRZ27mVdCpxvgtGrwXaoq65UXkWd/W7NWtPIlE=;
  b=XFeYh8modhDeIOjXbYqiyEJVAErzeqDm68tOGhx/i3Ud3GbZjAir7AWB
   YW9jV/gPENcKFFXo4FF+Of/SlV24ic7KGZfUGlYi6PeIHdUURRxDxhurP
   jbz0rp+0ArHjxQpcVufTXUFN89Me3Suy21WBissHJg4hsyxtLK5JV1Gwt
   m3WfbHnr/k0Zqeu8ENcHEWafVWIJJCXC7r99GHY38cRtvbw6Qn/Q+I/xQ
   uvvZxjTki+tfgTkPNObyvxaZRxQ+WJ3d0d2uKHqZtWvxbCwwLcRyEDG0+
   6lth/+VbUgLpoGUKB+9F2pPL7N3QL+h8y/UyLGLFs6qJfRjwUJDpVj77H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="370484519"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="370484519"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 16:06:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="724598034"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="724598034"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 20 Jul 2023 16:06:24 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMcj1-0006bi-2u;
        Thu, 20 Jul 2023 23:06:23 +0000
Date:   Fri, 21 Jul 2023 07:03:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 ac528649f7c63bc233cc0d33cff11f767cc666e3
Message-ID: <202307210735.Cy52F7dS-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: ac528649f7c63bc233cc0d33cff11f767cc666e3  Merge branch 'net-support-stp-on-bridge-in-non-root-netns'

elapsed time: 796m

configs tested: 189
configs skipped: 17

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r014-20230720   gcc  
alpha                randconfig-r021-20230720   gcc  
alpha                randconfig-r022-20230720   gcc  
alpha                randconfig-r024-20230720   gcc  
alpha                randconfig-r033-20230720   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                  randconfig-r006-20230720   gcc  
arc                  randconfig-r011-20230720   gcc  
arc                  randconfig-r012-20230720   gcc  
arc                  randconfig-r032-20230720   gcc  
arc                  randconfig-r035-20230720   gcc  
arc                  randconfig-r043-20230720   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                  randconfig-r014-20230720   gcc  
arm                  randconfig-r033-20230720   clang
arm                  randconfig-r035-20230720   clang
arm                  randconfig-r046-20230720   gcc  
arm                         s3c6400_defconfig   gcc  
arm                        vexpress_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230720   gcc  
arm64                randconfig-r013-20230720   clang
arm64                randconfig-r022-20230720   clang
arm64                randconfig-r023-20230720   clang
arm64                randconfig-r026-20230720   clang
arm64                randconfig-r032-20230720   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230720   gcc  
csky                 randconfig-r015-20230720   gcc  
csky                 randconfig-r016-20230720   gcc  
csky                 randconfig-r021-20230720   gcc  
csky                 randconfig-r034-20230720   gcc  
hexagon              randconfig-r022-20230720   clang
hexagon              randconfig-r024-20230720   clang
hexagon              randconfig-r036-20230720   clang
hexagon              randconfig-r041-20230720   clang
hexagon              randconfig-r045-20230720   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230720   gcc  
i386         buildonly-randconfig-r005-20230720   gcc  
i386         buildonly-randconfig-r006-20230720   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230720   gcc  
i386                 randconfig-i002-20230720   gcc  
i386                 randconfig-i003-20230720   gcc  
i386                 randconfig-i004-20230720   gcc  
i386                 randconfig-i005-20230720   gcc  
i386                 randconfig-i006-20230720   gcc  
i386                 randconfig-i011-20230720   clang
i386                 randconfig-i012-20230720   clang
i386                 randconfig-i013-20230720   clang
i386                 randconfig-i014-20230720   clang
i386                 randconfig-i015-20230720   clang
i386                 randconfig-i016-20230720   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r014-20230720   gcc  
loongarch            randconfig-r015-20230720   gcc  
loongarch            randconfig-r032-20230720   gcc  
loongarch            randconfig-r034-20230720   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                 randconfig-r006-20230720   gcc  
m68k                 randconfig-r012-20230720   gcc  
m68k                 randconfig-r015-20230720   gcc  
m68k                 randconfig-r023-20230720   gcc  
m68k                 randconfig-r025-20230720   gcc  
microblaze                      mmu_defconfig   gcc  
microblaze           randconfig-r001-20230720   gcc  
microblaze           randconfig-r005-20230720   gcc  
microblaze           randconfig-r011-20230720   gcc  
microblaze           randconfig-r016-20230720   gcc  
microblaze           randconfig-r023-20230720   gcc  
microblaze           randconfig-r033-20230720   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   clang
mips                            gpr_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                        omega2p_defconfig   clang
mips                        qi_lb60_defconfig   clang
mips                 randconfig-r004-20230720   clang
mips                 randconfig-r012-20230720   gcc  
mips                 randconfig-r013-20230720   gcc  
mips                 randconfig-r016-20230720   gcc  
mips                 randconfig-r026-20230720   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230720   gcc  
nios2                randconfig-r003-20230720   gcc  
nios2                randconfig-r012-20230720   gcc  
nios2                randconfig-r026-20230720   gcc  
openrisc             randconfig-r002-20230720   gcc  
openrisc             randconfig-r022-20230720   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230720   gcc  
parisc               randconfig-r004-20230720   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      katmai_defconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                     ksi8560_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc              randconfig-r001-20230720   gcc  
powerpc              randconfig-r014-20230720   clang
powerpc              randconfig-r015-20230720   clang
powerpc              randconfig-r024-20230720   clang
powerpc              randconfig-r026-20230720   clang
powerpc              randconfig-r031-20230720   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230720   gcc  
riscv                randconfig-r042-20230720   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230720   gcc  
s390                 randconfig-r013-20230720   clang
s390                 randconfig-r024-20230720   clang
s390                 randconfig-r031-20230720   gcc  
s390                 randconfig-r044-20230720   clang
sh                               allmodconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                   randconfig-r001-20230720   gcc  
sh                   randconfig-r006-20230720   gcc  
sh                   randconfig-r025-20230720   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230720   gcc  
sparc64              randconfig-r013-20230720   gcc  
sparc64              randconfig-r033-20230720   gcc  
sparc64              randconfig-r036-20230720   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r004-20230720   clang
um                   randconfig-r031-20230720   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230720   gcc  
x86_64       buildonly-randconfig-r002-20230720   gcc  
x86_64       buildonly-randconfig-r003-20230720   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r005-20230720   gcc  
x86_64               randconfig-r011-20230720   clang
x86_64               randconfig-r016-20230720   clang
x86_64               randconfig-r032-20230720   gcc  
x86_64               randconfig-x001-20230720   clang
x86_64               randconfig-x002-20230720   clang
x86_64               randconfig-x003-20230720   clang
x86_64               randconfig-x004-20230720   clang
x86_64               randconfig-x005-20230720   clang
x86_64               randconfig-x006-20230720   clang
x86_64               randconfig-x011-20230720   gcc  
x86_64               randconfig-x012-20230720   gcc  
x86_64               randconfig-x013-20230720   gcc  
x86_64               randconfig-x014-20230720   gcc  
x86_64               randconfig-x015-20230720   gcc  
x86_64               randconfig-x016-20230720   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r011-20230720   gcc  
xtensa               randconfig-r025-20230720   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

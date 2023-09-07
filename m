Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C97E797D4B
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Sep 2023 22:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjIGUQK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 16:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjIGUQF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 16:16:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E4E1BCD
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 13:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694117733; x=1725653733;
  h=date:from:to:cc:subject:message-id;
  bh=S/+b5XITt1GgyCgDliVFxJP/blk49PTkYFFD5GCDyVs=;
  b=X2oRH5IUc6dMLwZc0mzgjuVSwd7PO9gL+P1mwuFE2iAlF7ao95wTkoTH
   goT9mszc18HMUnu5OZTrUUMksJaIcTNXOJAXRhXXM20syIR98bpSuplI9
   hDHactqnY1OAeHDIUwpJl8/Y4yLQ5yK/d2zJrcYMMG5EwqMgmW/vT78wM
   IBMEw4q2VxAILR/7FxiaUs/OxREWcMCGL/Scpimj1Gy2RKiM96bt2hDw0
   Xfn4JUYAGJK9ylqH1qfzmNoy1jqE6XjZa58dRbiNQ1b7o/GPijOnhOe8s
   NFAISEVBR3/qLAtAEMSWuIXwtmYgUd9qAqafZuJ1+H3y9/Fy+Z3PDaX38
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="377375254"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="377375254"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 13:15:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="777213919"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="777213919"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Sep 2023 13:15:31 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qeLPV-0001YN-0t;
        Thu, 07 Sep 2023 20:15:29 +0000
Date:   Fri, 08 Sep 2023 04:14:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 e0b5127fa134fe0284d58877b6b3133939c8b3ce
Message-ID: <202309080458.YmIcOQ3r-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: e0b5127fa134fe0284d58877b6b3133939c8b3ce  ssb: Fix division by zero issue in ssb_calc_clock_rate

elapsed time: 720m

configs tested: 253
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230907   gcc  
alpha                randconfig-r033-20230907   gcc  
alpha                randconfig-r033-20230908   gcc  
alpha                randconfig-r034-20230908   gcc  
alpha                randconfig-r035-20230907   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230907   gcc  
arc                  randconfig-r001-20230908   gcc  
arc                  randconfig-r012-20230908   gcc  
arm                              alldefconfig   clang
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   gcc  
arm                          ep93xx_defconfig   clang
arm                      jornada720_defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                        mvebu_v7_defconfig   gcc  
arm                        neponset_defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20230907   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230908   gcc  
arm64                randconfig-r003-20230908   gcc  
arm64                randconfig-r013-20230907   gcc  
arm64                randconfig-r026-20230908   clang
csky                             alldefconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230907   gcc  
csky                 randconfig-r035-20230907   gcc  
hexagon               randconfig-001-20230907   clang
hexagon               randconfig-002-20230907   clang
hexagon              randconfig-r023-20230907   clang
hexagon              randconfig-r036-20230907   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230907   clang
i386         buildonly-randconfig-001-20230908   gcc  
i386         buildonly-randconfig-002-20230907   clang
i386         buildonly-randconfig-002-20230908   gcc  
i386         buildonly-randconfig-003-20230907   clang
i386         buildonly-randconfig-003-20230908   gcc  
i386         buildonly-randconfig-004-20230907   clang
i386         buildonly-randconfig-004-20230908   gcc  
i386         buildonly-randconfig-005-20230907   clang
i386         buildonly-randconfig-005-20230908   gcc  
i386         buildonly-randconfig-006-20230907   clang
i386         buildonly-randconfig-006-20230908   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230907   clang
i386                  randconfig-001-20230908   gcc  
i386                  randconfig-002-20230907   clang
i386                  randconfig-002-20230908   gcc  
i386                  randconfig-003-20230907   clang
i386                  randconfig-003-20230908   gcc  
i386                  randconfig-004-20230907   clang
i386                  randconfig-004-20230908   gcc  
i386                  randconfig-005-20230907   clang
i386                  randconfig-005-20230908   gcc  
i386                  randconfig-006-20230907   clang
i386                  randconfig-006-20230908   gcc  
i386                  randconfig-011-20230907   gcc  
i386                  randconfig-012-20230907   gcc  
i386                  randconfig-013-20230907   gcc  
i386                  randconfig-014-20230907   gcc  
i386                  randconfig-015-20230907   gcc  
i386                  randconfig-016-20230907   gcc  
i386                 randconfig-r005-20230907   clang
i386                 randconfig-r005-20230908   gcc  
i386                 randconfig-r006-20230907   clang
i386                 randconfig-r023-20230908   clang
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230907   gcc  
loongarch             randconfig-001-20230908   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                 randconfig-r001-20230907   gcc  
m68k                 randconfig-r013-20230908   gcc  
m68k                 randconfig-r033-20230907   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips                           jazz_defconfig   gcc  
mips                     loongson1c_defconfig   clang
mips                malta_qemu_32r6_defconfig   clang
mips                 randconfig-r015-20230907   clang
mips                 randconfig-r032-20230907   gcc  
mips                           xway_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r021-20230907   gcc  
openrisc             randconfig-r026-20230907   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r031-20230908   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                        fsp2_defconfig   clang
powerpc                    ge_imp3a_defconfig   clang
powerpc                      katmai_defconfig   clang
powerpc                     ksi8560_defconfig   clang
powerpc                 mpc832x_rdb_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc                     powernv_defconfig   clang
powerpc                     ppa8548_defconfig   clang
powerpc              randconfig-r006-20230908   gcc  
powerpc              randconfig-r024-20230907   gcc  
powerpc                        warp_defconfig   gcc  
powerpc64            randconfig-r022-20230907   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230907   clang
riscv                randconfig-r031-20230907   clang
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230907   gcc  
s390                 randconfig-r024-20230908   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r036-20230908   gcc  
sh                          rsk7269_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230908   gcc  
sparc                randconfig-r014-20230907   gcc  
sparc                randconfig-r025-20230907   gcc  
sparc                randconfig-r032-20230907   gcc  
sparc                randconfig-r032-20230908   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r004-20230907   gcc  
sparc64              randconfig-r034-20230907   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r012-20230907   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230907   clang
x86_64       buildonly-randconfig-001-20230908   gcc  
x86_64       buildonly-randconfig-002-20230907   clang
x86_64       buildonly-randconfig-002-20230908   gcc  
x86_64       buildonly-randconfig-003-20230907   clang
x86_64       buildonly-randconfig-003-20230908   gcc  
x86_64       buildonly-randconfig-004-20230907   clang
x86_64       buildonly-randconfig-004-20230908   gcc  
x86_64       buildonly-randconfig-005-20230907   clang
x86_64       buildonly-randconfig-005-20230908   gcc  
x86_64       buildonly-randconfig-006-20230907   clang
x86_64       buildonly-randconfig-006-20230908   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20230907   gcc  
x86_64                randconfig-002-20230907   gcc  
x86_64                randconfig-003-20230907   gcc  
x86_64                randconfig-004-20230907   gcc  
x86_64                randconfig-005-20230907   gcc  
x86_64                randconfig-006-20230907   gcc  
x86_64                randconfig-011-20230907   clang
x86_64                randconfig-011-20230908   gcc  
x86_64                randconfig-012-20230907   clang
x86_64                randconfig-012-20230908   gcc  
x86_64                randconfig-013-20230907   clang
x86_64                randconfig-013-20230908   gcc  
x86_64                randconfig-014-20230907   clang
x86_64                randconfig-014-20230908   gcc  
x86_64                randconfig-015-20230907   clang
x86_64                randconfig-015-20230908   gcc  
x86_64                randconfig-016-20230907   clang
x86_64                randconfig-016-20230908   gcc  
x86_64                randconfig-071-20230907   clang
x86_64                randconfig-072-20230907   clang
x86_64                randconfig-073-20230907   clang
x86_64                randconfig-074-20230907   clang
x86_64                randconfig-075-20230907   clang
x86_64                randconfig-076-20230907   clang
x86_64               randconfig-r016-20230907   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa               randconfig-r002-20230907   gcc  
xtensa               randconfig-r034-20230907   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

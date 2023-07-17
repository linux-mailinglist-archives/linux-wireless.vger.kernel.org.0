Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4126756941
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jul 2023 18:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjGQQeF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jul 2023 12:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjGQQeE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jul 2023 12:34:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D20E4F;
        Mon, 17 Jul 2023 09:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689611643; x=1721147643;
  h=date:from:to:cc:subject:message-id;
  bh=AfEwFCjpbJBXCqKqIsD7F+4bRn66pB86cNt06Bq8h34=;
  b=BxmPe4031Zz/dtVXN/N3DgTJzMLUpMUuCtN1HXYoo1c3wCzTWSpnfGr8
   VQYljG9OCQYw5ZE52c68EWPCGGr/kQ/35VAfieafqYu7s8d0l3rlZ5kjX
   N8CyKgesE3T/W5SQzBMXnik6ydP07+2EJoO0CxkiaeCIkBeAnLkIdlyef
   VW9SjbZAkrhjV3jT6cL1wADLebvzy8x0Vt/t9eST/I0QKWVwmbOPpM/C+
   8FL20dROTuKAl5IYri+9yCWDvfvl8y/6IazA/bdhgBEB+VVWEQeFsoUIK
   Ilhbyy3ufz80s78lIO17z1r/hAvVFE8rL/bpbvbGv576CadatPWEQ3S45
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="346280843"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="346280843"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 09:34:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="866790419"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2023 09:34:02 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qLRAf-0009hi-0x;
        Mon, 17 Jul 2023 16:34:01 +0000
Date:   Tue, 18 Jul 2023 00:33:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        linux-cxl@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [linux-next:master] BUILD SUCCESS WITH WARNING
 2205be537aeb1ca2ace998e2fefaa2be04e393e4
Message-ID: <202307180010.dg0yWiVQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 2205be537aeb1ca2ace998e2fefaa2be04e393e4  Add linux-next specific files for 20230717

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202307171416.dMlpHle6-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/cxl/acpi.c:300:4: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]

Unverified Warning (likely false positive, please contact us if interested):

mm/khugepaged.c:2137 collapse_file() warn: variable dereferenced before check 'cc' (see line 1787)
net/wireless/scan.c:373 cfg80211_gen_new_ie() warn: potential spectre issue 'sub->data' [r]
net/wireless/scan.c:397 cfg80211_gen_new_ie() warn: possible spectre second half.  'ext_id'

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-m021-20230717
|   |-- net-wireless-scan.c-cfg80211_gen_new_ie()-warn:possible-spectre-second-half.-ext_id
|   `-- net-wireless-scan.c-cfg80211_gen_new_ie()-warn:potential-spectre-issue-sub-data-r
`-- x86_64-randconfig-m001-20230717
    `-- mm-khugepaged.c-collapse_file()-warn:variable-dereferenced-before-check-cc-(see-line-)
clang_recent_errors
`-- i386-randconfig-i004-20230717
    `-- drivers-cxl-acpi.c:warning:format-specifies-type-unsigned-long-long-but-the-argument-has-type-resource_size_t-(aka-unsigned-int-)

elapsed time: 731m

configs tested: 132
configs skipped: 4

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                  randconfig-r043-20230717   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         mv78xx0_defconfig   clang
arm                        mvebu_v7_defconfig   gcc  
arm                          pxa168_defconfig   clang
arm                          pxa3xx_defconfig   gcc  
arm                  randconfig-r046-20230717   clang
arm                        realview_defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
arm                        vexpress_defconfig   clang
arm                         vf610m4_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r034-20230717   clang
csky                                defconfig   gcc  
csky                 randconfig-r021-20230717   gcc  
hexagon              randconfig-r016-20230717   clang
hexagon              randconfig-r041-20230717   clang
hexagon              randconfig-r045-20230717   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230717   clang
i386         buildonly-randconfig-r005-20230717   clang
i386         buildonly-randconfig-r006-20230717   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230717   clang
i386                 randconfig-i002-20230717   clang
i386                 randconfig-i003-20230717   clang
i386                 randconfig-i004-20230717   clang
i386                 randconfig-i005-20230717   clang
i386                 randconfig-i006-20230717   clang
i386                 randconfig-i011-20230717   gcc  
i386                 randconfig-i012-20230717   gcc  
i386                 randconfig-i013-20230717   gcc  
i386                 randconfig-i014-20230717   gcc  
i386                 randconfig-i015-20230717   gcc  
i386                 randconfig-i016-20230717   gcc  
i386                 randconfig-r004-20230717   clang
i386                 randconfig-r011-20230717   gcc  
i386                 randconfig-r035-20230717   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r013-20230717   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                            gpr_defconfig   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r012-20230717   gcc  
openrisc             randconfig-r024-20230717   gcc  
openrisc             randconfig-r032-20230717   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r014-20230717   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                    mvme5100_defconfig   clang
powerpc                      ppc44x_defconfig   clang
powerpc                    sam440ep_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r015-20230717   gcc  
riscv                randconfig-r033-20230717   clang
riscv                randconfig-r042-20230717   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r025-20230717   gcc  
s390                 randconfig-r044-20230717   gcc  
sh                               allmodconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r002-20230717   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r036-20230717   gcc  
sparc64              randconfig-r006-20230717   gcc  
sparc64              randconfig-r023-20230717   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r026-20230717   clang
um                   randconfig-r031-20230717   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230717   clang
x86_64       buildonly-randconfig-r002-20230717   clang
x86_64       buildonly-randconfig-r003-20230717   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230717   gcc  
x86_64               randconfig-x002-20230717   gcc  
x86_64               randconfig-x003-20230717   gcc  
x86_64               randconfig-x004-20230717   gcc  
x86_64               randconfig-x005-20230717   gcc  
x86_64               randconfig-x006-20230717   gcc  
x86_64               randconfig-x011-20230717   clang
x86_64               randconfig-x012-20230717   clang
x86_64               randconfig-x013-20230717   clang
x86_64               randconfig-x014-20230717   clang
x86_64               randconfig-x015-20230717   clang
x86_64               randconfig-x016-20230717   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                       common_defconfig   gcc  
xtensa                              defconfig   gcc  
xtensa               randconfig-r001-20230717   gcc  
xtensa               randconfig-r022-20230717   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

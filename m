Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F03D715DBD
	for <lists+linux-wireless@lfdr.de>; Tue, 30 May 2023 13:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjE3Lqe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 May 2023 07:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjE3LqZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 May 2023 07:46:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40805F3
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 04:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685447153; x=1716983153;
  h=date:from:to:cc:subject:message-id;
  bh=3TxlyonMwGjPT9HQeZTRE58ivem01DJ0+DEE1+c3rMA=;
  b=jCfuekYOjvFCG5h6SPgQxpdodeka6bUzKi3He7DcfRS4ZygIVsUTgHFf
   aucnUPflSxg/bMRBrq7pZs7hVrzHcg+EE76q6qMZS3rjEq3dY3gYKeQg5
   ULyjm6lio/6R4M/x9Qt/qigz0WntC/oGng1jtzEhwxcJmXK2H1+fWCUzv
   MvhVgKchLOBpaaK7rlOvqrGwNR+CzceREUGKSNOFp9WiGn6nNi6WQz3lh
   AdMtOz1c7cyysuiawLRdMGFIVG53H+n/tj4NPSkGfGHziRVXtTK3jWA5M
   BJqIGrqAc1+gNoAAlU/6wM2sLNNIRwDilAEj1l1uo9HqzwaQ5jXCxMiho
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420649549"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="420649549"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 04:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="830722476"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="830722476"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 May 2023 04:43:52 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q3xlX-00008x-1o;
        Tue, 30 May 2023 11:43:51 +0000
Date:   Tue, 30 May 2023 19:43:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 1f1784a59caf3eefd127908a1a3cf224017ff9c7
Message-ID: <20230530114318.TP1TI%lkp@intel.com>
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
branch HEAD: 1f1784a59caf3eefd127908a1a3cf224017ff9c7  wifi: rtw88: usb: silence log flooding error message

elapsed time: 4508m

configs tested: 340
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230526   gcc  
arc                              alldefconfig   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc          buildonly-randconfig-r003-20230526   gcc  
arc          buildonly-randconfig-r005-20230526   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                  randconfig-r025-20230526   gcc  
arc                  randconfig-r043-20230526   gcc  
arc                           tb10x_defconfig   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                         at91_dt_defconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                        multi_v5_defconfig   clang
arm                         nhk8815_defconfig   gcc  
arm                  randconfig-r013-20230526   gcc  
arm                  randconfig-r046-20230526   gcc  
arm                             rpc_defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r023-20230526   clang
csky                                defconfig   gcc  
csky                 randconfig-r014-20230526   gcc  
csky                 randconfig-r024-20230526   gcc  
csky                 randconfig-r032-20230526   gcc  
hexagon              randconfig-r001-20230527   clang
hexagon              randconfig-r041-20230526   clang
hexagon              randconfig-r045-20230526   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r001-20230526   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230526   gcc  
i386                 randconfig-i001-20230528   gcc  
i386                 randconfig-i002-20230526   gcc  
i386                 randconfig-i002-20230528   gcc  
i386                 randconfig-i003-20230526   gcc  
i386                 randconfig-i003-20230528   gcc  
i386                 randconfig-i004-20230526   gcc  
i386                 randconfig-i004-20230528   gcc  
i386                 randconfig-i005-20230526   gcc  
i386                 randconfig-i005-20230528   gcc  
i386                 randconfig-i006-20230526   gcc  
i386                 randconfig-i006-20230528   gcc  
i386                 randconfig-i011-20230526   clang
i386                 randconfig-i011-20230528   clang
i386                 randconfig-i012-20230526   clang
i386                 randconfig-i012-20230528   clang
i386                 randconfig-i013-20230526   clang
i386                 randconfig-i013-20230528   clang
i386                 randconfig-i014-20230526   clang
i386                 randconfig-i014-20230528   clang
i386                 randconfig-i015-20230526   clang
i386                 randconfig-i015-20230528   clang
i386                 randconfig-i016-20230526   clang
i386                 randconfig-i016-20230528   clang
i386                 randconfig-i051-20230526   gcc  
i386                 randconfig-i051-20230528   gcc  
i386                 randconfig-i052-20230526   gcc  
i386                 randconfig-i052-20230528   gcc  
i386                 randconfig-i053-20230526   gcc  
i386                 randconfig-i053-20230528   gcc  
i386                 randconfig-i054-20230526   gcc  
i386                 randconfig-i054-20230528   gcc  
i386                 randconfig-i055-20230526   gcc  
i386                 randconfig-i055-20230528   gcc  
i386                 randconfig-i056-20230526   gcc  
i386                 randconfig-i056-20230528   gcc  
i386                 randconfig-i061-20230526   gcc  
i386                 randconfig-i061-20230528   gcc  
i386                 randconfig-i062-20230526   gcc  
i386                 randconfig-i062-20230528   gcc  
i386                 randconfig-i063-20230526   gcc  
i386                 randconfig-i063-20230528   gcc  
i386                 randconfig-i064-20230526   gcc  
i386                 randconfig-i064-20230528   gcc  
i386                 randconfig-i065-20230526   gcc  
i386                 randconfig-i065-20230528   gcc  
i386                 randconfig-i066-20230526   gcc  
i386                 randconfig-i066-20230528   gcc  
i386                 randconfig-i071-20230526   clang
i386                 randconfig-i071-20230528   clang
i386                 randconfig-i072-20230526   clang
i386                 randconfig-i072-20230528   clang
i386                 randconfig-i073-20230526   clang
i386                 randconfig-i073-20230528   clang
i386                 randconfig-i074-20230526   clang
i386                 randconfig-i074-20230528   clang
i386                 randconfig-i075-20230526   clang
i386                 randconfig-i075-20230528   clang
i386                 randconfig-i076-20230526   clang
i386                 randconfig-i076-20230528   clang
i386                 randconfig-i081-20230526   clang
i386                 randconfig-i081-20230527   gcc  
i386                 randconfig-i081-20230528   clang
i386                 randconfig-i082-20230526   clang
i386                 randconfig-i082-20230527   gcc  
i386                 randconfig-i082-20230528   clang
i386                 randconfig-i083-20230526   clang
i386                 randconfig-i083-20230527   gcc  
i386                 randconfig-i083-20230528   clang
i386                 randconfig-i084-20230526   clang
i386                 randconfig-i084-20230527   gcc  
i386                 randconfig-i084-20230528   clang
i386                 randconfig-i085-20230526   clang
i386                 randconfig-i085-20230527   gcc  
i386                 randconfig-i085-20230528   clang
i386                 randconfig-i086-20230526   clang
i386                 randconfig-i086-20230527   gcc  
i386                 randconfig-i086-20230528   clang
i386                 randconfig-i091-20230526   gcc  
i386                 randconfig-i091-20230528   gcc  
i386                 randconfig-i092-20230526   gcc  
i386                 randconfig-i092-20230528   gcc  
i386                 randconfig-i093-20230526   gcc  
i386                 randconfig-i093-20230528   gcc  
i386                 randconfig-i094-20230526   gcc  
i386                 randconfig-i094-20230528   gcc  
i386                 randconfig-i095-20230526   gcc  
i386                 randconfig-i095-20230528   gcc  
i386                 randconfig-i096-20230526   gcc  
i386                 randconfig-i096-20230528   gcc  
i386                 randconfig-r003-20230527   clang
i386                 randconfig-r004-20230527   clang
ia64                            zx1_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230526   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230526   gcc  
loongarch            randconfig-r004-20230526   gcc  
loongarch            randconfig-r016-20230526   gcc  
loongarch            randconfig-r032-20230527   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k         buildonly-randconfig-r004-20230526   gcc  
m68k         buildonly-randconfig-r006-20230526   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                 randconfig-r005-20230526   gcc  
m68k                 randconfig-r006-20230527   gcc  
m68k                 randconfig-r013-20230526   gcc  
m68k                 randconfig-r025-20230527   gcc  
microblaze                      mmu_defconfig   gcc  
microblaze           randconfig-r022-20230526   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips         buildonly-randconfig-r006-20230526   clang
mips                            gpr_defconfig   gcc  
mips                           ip27_defconfig   clang
mips                  maltasmvp_eva_defconfig   gcc  
mips                      pic32mzda_defconfig   clang
mips                   sb1250_swarm_defconfig   clang
mips                        vocore2_defconfig   gcc  
nios2                               defconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r012-20230526   gcc  
openrisc             randconfig-r031-20230527   gcc  
openrisc             randconfig-r033-20230527   gcc  
openrisc                 simple_smp_defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r036-20230526   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc      buildonly-randconfig-r002-20230526   clang
powerpc                        cell_defconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                     kilauea_defconfig   clang
powerpc                      mgcoge_defconfig   gcc  
powerpc                     mpc512x_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                 mpc8540_ads_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc              randconfig-r005-20230527   clang
powerpc              randconfig-r011-20230526   clang
powerpc              randconfig-r021-20230526   clang
powerpc                     sequoia_defconfig   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r015-20230526   clang
riscv                randconfig-r016-20230526   clang
riscv                randconfig-r042-20230526   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r024-20230527   gcc  
s390                 randconfig-r034-20230526   gcc  
s390                 randconfig-r044-20230526   clang
s390                       zfcpdump_defconfig   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r015-20230526   gcc  
sh                          sdk7780_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc        buildonly-randconfig-r004-20230526   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230527   gcc  
sparc                randconfig-r031-20230526   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r026-20230526   gcc  
sparc64              randconfig-r033-20230526   gcc  
um                               alldefconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230526   gcc  
x86_64               randconfig-a002-20230526   gcc  
x86_64               randconfig-a003-20230526   gcc  
x86_64               randconfig-a004-20230526   gcc  
x86_64               randconfig-a005-20230526   gcc  
x86_64               randconfig-a006-20230526   gcc  
x86_64               randconfig-a011-20230526   clang
x86_64               randconfig-a011-20230528   clang
x86_64               randconfig-a012-20230526   clang
x86_64               randconfig-a012-20230528   clang
x86_64               randconfig-a013-20230526   clang
x86_64               randconfig-a013-20230528   clang
x86_64               randconfig-a014-20230526   clang
x86_64               randconfig-a014-20230528   clang
x86_64               randconfig-a015-20230526   clang
x86_64               randconfig-a015-20230528   clang
x86_64               randconfig-a016-20230526   clang
x86_64               randconfig-a016-20230528   clang
x86_64               randconfig-k001-20230528   clang
x86_64               randconfig-x051-20230526   clang
x86_64               randconfig-x051-20230528   clang
x86_64               randconfig-x052-20230526   clang
x86_64               randconfig-x052-20230528   clang
x86_64               randconfig-x053-20230526   clang
x86_64               randconfig-x053-20230528   clang
x86_64               randconfig-x054-20230526   clang
x86_64               randconfig-x054-20230528   clang
x86_64               randconfig-x055-20230526   clang
x86_64               randconfig-x055-20230528   clang
x86_64               randconfig-x056-20230526   clang
x86_64               randconfig-x056-20230528   clang
x86_64               randconfig-x061-20230526   clang
x86_64               randconfig-x062-20230526   clang
x86_64               randconfig-x063-20230526   clang
x86_64               randconfig-x064-20230526   clang
x86_64               randconfig-x065-20230526   clang
x86_64               randconfig-x066-20230526   clang
x86_64               randconfig-x071-20230526   gcc  
x86_64               randconfig-x071-20230527   clang
x86_64               randconfig-x071-20230528   gcc  
x86_64               randconfig-x072-20230526   gcc  
x86_64               randconfig-x072-20230527   clang
x86_64               randconfig-x072-20230528   gcc  
x86_64               randconfig-x073-20230526   gcc  
x86_64               randconfig-x073-20230527   clang
x86_64               randconfig-x073-20230528   gcc  
x86_64               randconfig-x074-20230526   gcc  
x86_64               randconfig-x074-20230527   clang
x86_64               randconfig-x074-20230528   gcc  
x86_64               randconfig-x075-20230526   gcc  
x86_64               randconfig-x075-20230527   clang
x86_64               randconfig-x075-20230528   gcc  
x86_64               randconfig-x076-20230526   gcc  
x86_64               randconfig-x076-20230527   clang
x86_64               randconfig-x076-20230528   gcc  
x86_64               randconfig-x081-20230526   gcc  
x86_64               randconfig-x081-20230528   gcc  
x86_64               randconfig-x082-20230526   gcc  
x86_64               randconfig-x082-20230528   gcc  
x86_64               randconfig-x083-20230526   gcc  
x86_64               randconfig-x083-20230528   gcc  
x86_64               randconfig-x084-20230526   gcc  
x86_64               randconfig-x084-20230528   gcc  
x86_64               randconfig-x085-20230526   gcc  
x86_64               randconfig-x085-20230528   gcc  
x86_64               randconfig-x086-20230526   gcc  
x86_64               randconfig-x086-20230528   gcc  
x86_64               randconfig-x091-20230526   clang
x86_64               randconfig-x091-20230528   clang
x86_64               randconfig-x092-20230526   clang
x86_64               randconfig-x092-20230528   clang
x86_64               randconfig-x093-20230526   clang
x86_64               randconfig-x093-20230528   clang
x86_64               randconfig-x094-20230526   clang
x86_64               randconfig-x094-20230528   clang
x86_64               randconfig-x095-20230526   clang
x86_64               randconfig-x095-20230528   clang
x86_64               randconfig-x096-20230526   clang
x86_64               randconfig-x096-20230528   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa               randconfig-r003-20230526   gcc  
xtensa               randconfig-r011-20230526   gcc  
xtensa               randconfig-r023-20230527   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

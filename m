Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3F34F6D0D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 23:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbiDFVkX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 17:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238665AbiDFVjH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 17:39:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F385E62D9
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 14:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649279747; x=1680815747;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lPzMXHwdGgakrrzr6BofZAPv5nZRqiyH2gcTLcU15/I=;
  b=TEiod+F76ix4C1JDI2hyZSE2sIjGQbbiqJp2x9LY0CmsiHxQ13FLOIt1
   DRwFNX2NZBhdIYZwW6RgJ+DBSgGiNmLux8oC0y83Ku8QEAEOdEdalpEP1
   if8bOwMteBBY/g+Vpeqgk5aInw90b/kdTzLetacCFYgHfdkK5sQyaNIBd
   Zy7ZHrfqqRC9j0aqHsLT1yYwxm2aUKb2gOuf1Qe3jWe+kf7J/OjurNe8N
   bU10w2zF2XjAox3CQc88MwM382JhjcY9CBRJW5U8j8gIusEyg3C+N8OMW
   U5TAEsijVmE2kouq9ryMbzuU6r9N+rLM1F6PHwrD+Orri1ZXuJa7X5I/c
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="260852082"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="260852082"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 14:15:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="722676226"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2022 14:15:44 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncD0C-0004lf-4e;
        Wed, 06 Apr 2022 21:15:44 +0000
Date:   Thu, 07 Apr 2022 05:15:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:wfx-move-out-of-staging] BUILD REGRESSION
 4a5fb1bbcdf1cccae1f6b9c0277b3796b2a468ef
Message-ID: <624e02dd.Tuqne4v0krtNoj1Y%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git wfx-move-out-of-staging
branch HEAD: 4a5fb1bbcdf1cccae1f6b9c0277b3796b2a468ef  wfx: get out from the staging area

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/net/wireless/silabs/wfx/data_tx.c:516:1: internal compiler error: in extract_insn, at recog.c:2770

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- h8300-allyesconfig
    `-- drivers-net-wireless-silabs-wfx-data_tx.c:internal-compiler-error:in-extract_insn-at-recog.c

elapsed time: 820m

configs tested: 134
configs skipped: 3

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                        multi_v7_defconfig
arm                        keystone_defconfig
powerpc                     sequoia_defconfig
sh                          sdk7780_defconfig
s390                             allyesconfig
h8300                    h8300h-sim_defconfig
m68k                          atari_defconfig
arm                           stm32_defconfig
powerpc                     stx_gp3_defconfig
parisc                              defconfig
powerpc                      cm5200_defconfig
ia64                          tiger_defconfig
m68k                        mvme147_defconfig
sh                        dreamcast_defconfig
arc                         haps_hs_defconfig
sh                     sh7710voipgw_defconfig
sh                        sh7757lcr_defconfig
arm                          badge4_defconfig
powerpc                      arches_defconfig
arm                           tegra_defconfig
sh                             shx3_defconfig
xtensa                generic_kc705_defconfig
arm                         s3c6400_defconfig
sh                          landisk_defconfig
arm                             rpc_defconfig
powerpc                        warp_defconfig
ia64                         bigsur_defconfig
mips                       capcella_defconfig
sh                          rsk7201_defconfig
sh                          lboxre2_defconfig
ia64                             alldefconfig
powerpc                mpc7448_hpc2_defconfig
arm                            qcom_defconfig
sh                        sh7785lcr_defconfig
m68k                        stmark2_defconfig
m68k                            mac_defconfig
arc                          axs101_defconfig
mips                         db1xxx_defconfig
x86_64                           alldefconfig
powerpc                 mpc834x_mds_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220406
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
parisc64                            defconfig
parisc                           allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                               defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220406
s390                 randconfig-r044-20220406
riscv                randconfig-r042-20220406
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
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
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220406
riscv                randconfig-c006-20220406
mips                 randconfig-c004-20220406
arm                  randconfig-c002-20220406
arm                       netwinder_defconfig
arm                      tct_hammer_defconfig
powerpc                      katmai_defconfig
arm                           spitz_defconfig
powerpc                     powernv_defconfig
powerpc                     ksi8560_defconfig
arm                          collie_defconfig
arm                        mvebu_v5_defconfig
powerpc                      ppc64e_defconfig
arm                         socfpga_defconfig
mips                           rs90_defconfig
powerpc                 mpc832x_mds_defconfig
arm                       spear13xx_defconfig
arm                         palmz72_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

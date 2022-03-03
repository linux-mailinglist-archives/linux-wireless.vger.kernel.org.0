Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15F54CBF9F
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Mar 2022 15:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiCCOMp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Mar 2022 09:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiCCOMo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Mar 2022 09:12:44 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054B518CC1B
        for <linux-wireless@vger.kernel.org>; Thu,  3 Mar 2022 06:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646316718; x=1677852718;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RkTczbfPDkcu3u/spifhwSJStIQriGmOmkFCA7sS9tw=;
  b=GvUHxT2uk8F014j7Yk4B+lC35nb32G7Tm7et0JJbtJbaqj2HNjQqeWSl
   e8XRlH7w7Z4wov9JsKGQ05ikG45gJZ+LyWREmrATwhskrRo4wAtxcnAOj
   80Q6Wc1qcbEZTCg5gWawXoC3/23wFqa79rX6YF9E3nUw8TpIDMw3xVUAt
   Tc00fEtU1tASkThjvmvtdEUj3b3b5LB8LTrNqyRL489JFT1KMFgcVmbOM
   Uk6g8yDEJkAA1fVrm/kaYDNO4p8yupApH5oXLb+t0XgFtRDpgheAedXJX
   wm67gFZjCjKgBlTxGyrJ0QXHRz67Djy+NfISIm49oiB359KqLx1nKZ84D
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="340115487"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="340115487"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 06:11:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="511441572"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Mar 2022 06:11:55 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPmBO-0000bT-V0; Thu, 03 Mar 2022 14:11:54 +0000
Date:   Thu, 03 Mar 2022 22:11:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless:main] BUILD SUCCESS
 e6e91ec966db5af4f059cfbac1af06560404b317
Message-ID: <6220cc7e.OTUWo6+ENRAISKoY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git main
branch HEAD: e6e91ec966db5af4f059cfbac1af06560404b317  iwlwifi: mvm: return value for request_ownership

elapsed time: 933m

configs tested: 121
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
sparc64                             defconfig
arm                           sunxi_defconfig
sh                        edosk7705_defconfig
xtensa                           allyesconfig
arc                    vdk_hs38_smp_defconfig
arm                         lubbock_defconfig
h8300                     edosk2674_defconfig
powerpc                    amigaone_defconfig
mips                            ar7_defconfig
m68k                          sun3x_defconfig
arm                            mps2_defconfig
nios2                         10m50_defconfig
arc                        nsim_700_defconfig
arm                        cerfcube_defconfig
arc                            hsdk_defconfig
arm                         assabet_defconfig
nios2                               defconfig
riscv             nommu_k210_sdcard_defconfig
mips                 decstation_r4k_defconfig
arm                           h3600_defconfig
arm                           sama5_defconfig
sparc                            alldefconfig
mips                            gpr_defconfig
m68k                            q40_defconfig
i386                                defconfig
h8300                               defconfig
sh                           se7705_defconfig
um                             i386_defconfig
powerpc                       holly_defconfig
powerpc                        warp_defconfig
openrisc                  or1klitex_defconfig
sh                  sh7785lcr_32bit_defconfig
csky                                defconfig
riscv                               defconfig
arm                      jornada720_defconfig
m68k                       m5475evb_defconfig
m68k                       bvme6000_defconfig
mips                           ci20_defconfig
arm                  randconfig-c002-20220302
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
alpha                            allyesconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arc                  randconfig-r043-20220302
riscv                randconfig-r042-20220302
s390                 randconfig-r044-20220302
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220302
riscv                randconfig-c006-20220302
i386                          randconfig-c001
arm                  randconfig-c002-20220302
mips                 randconfig-c004-20220302
mips                     loongson2k_defconfig
powerpc                       ebony_defconfig
mips                            e55_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220303
riscv                randconfig-r042-20220303
hexagon              randconfig-r041-20220303

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974CC53594B
	for <lists+linux-wireless@lfdr.de>; Fri, 27 May 2022 08:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241485AbiE0G0a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 May 2022 02:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245268AbiE0G0W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 May 2022 02:26:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5DC30576
        for <linux-wireless@vger.kernel.org>; Thu, 26 May 2022 23:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653632781; x=1685168781;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=SzBJifWQj69V7cywAmXJZoShv/CAUiQrZnrgn9VsyjY=;
  b=lPxNgjCdMaepqxWurCoQWNRRcj1PdU0cou2F/PRBfKGAmExCpKjoqo57
   sSD5xDFVOomAzDJDJobBJr09Rf3x3sw3HNpNGv44VmxRU1bV6wsAALLnV
   Xvv6ZPW662+yKXBDwyR3UKNlMxRhR9klZe6XQHL2Avpe2Qvo2Rer+ymzL
   12ZZSlkoIm4gwa8ypoBgcAJ8HOuPI6C18dKef45KLizgMH6Cys83fvKqZ
   u4y24kTimC82opEm3Z+BkU82eyACDvGbRpa8hh5o461ZtwCc3k3R8teVl
   fnJRU/8HJJN4X+0Gtl06xzLkyJs5+Pl+NTbEg5tgEoJO67owmUUtFunJq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274399550"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="274399550"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 23:26:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="902386529"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 May 2022 23:26:17 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuTQP-0004UF-53;
        Fri, 27 May 2022 06:26:17 +0000
Date:   Fri, 27 May 2022 14:25:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:mld] BUILD SUCCESS
 b6e7b27291114ab18ec80d360abae7ee849550b4
Message-ID: <62906edf.DEiY9ZbF5dNYFf1P%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld
branch HEAD: b6e7b27291114ab18ec80d360abae7ee849550b4  mac80211: split bss_info_changed method

elapsed time: 724m

configs tested: 122
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
powerpc                      pcm030_defconfig
mips                         db1xxx_defconfig
sh                          polaris_defconfig
arm                         assabet_defconfig
arm                            mps2_defconfig
arm                           imxrt_defconfig
parisc                           alldefconfig
parisc64                            defconfig
arm                         vf610m4_defconfig
sh                            titan_defconfig
sh                           sh2007_defconfig
openrisc                         alldefconfig
sh                           se7712_defconfig
powerpc                      ep88xc_defconfig
arc                           tb10x_defconfig
powerpc                         ps3_defconfig
sh                          sdk7786_defconfig
mips                  maltasmvp_eva_defconfig
microblaze                      mmu_defconfig
arc                        nsimosci_defconfig
sh                             espt_defconfig
arm                     eseries_pxa_defconfig
sparc                       sparc64_defconfig
sh                        apsh4ad0a_defconfig
sh                           se7343_defconfig
m68k                        m5407c3_defconfig
powerpc                     ep8248e_defconfig
arc                            hsdk_defconfig
arm                  randconfig-c002-20220524
x86_64                        randconfig-c001
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20220524
s390                 randconfig-r044-20220524
riscv                randconfig-r042-20220524
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                      walnut_defconfig
mips                       rbtx49xx_defconfig
mips                           ip28_defconfig
mips                      pic32mzda_defconfig
powerpc                       ebony_defconfig
mips                         tb0287_defconfig
powerpc                      obs600_defconfig
arm                     am200epdkit_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220524
hexagon              randconfig-r041-20220524

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

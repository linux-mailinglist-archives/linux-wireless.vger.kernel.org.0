Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8941750D607
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Apr 2022 01:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239938AbiDXXrS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Apr 2022 19:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiDXXrR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Apr 2022 19:47:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032B4CFE6B
        for <linux-wireless@vger.kernel.org>; Sun, 24 Apr 2022 16:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650843855; x=1682379855;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=t5dcWEgyzptqqaQStuKsmdPoTFvOecNVwWFf81fXkVA=;
  b=Ya9QdpIkAuuNg1UQRRQhYZJKgEs3NJtmjFBkrtxsYpHzPT1TNr05eb0d
   Qu3x84NNErhuIhrFWIni5oVFP5x56OzjUq3hkO3NyQKGEeX5MJDI/CUpE
   yDrpxbMWO/H18wIZV8qw5enRQCzwv6PRtLOlvH/ECDLN5ookMN+mXI2l3
   Vx6i457oBfqIo5s2Sdlz9HnMnUAjm53iGRiSfbMZQSuChjCPBBK4GKk/d
   ZSAtvnpcUXUE63oaYmxuDWYdDtAnPB3qqL9Fi0+kGP4SH5Tt+tQWkUugf
   h19BgssqeE5LusxuIbiw84c1zS52HwLsUlMSM14q1+hSvyw/2zm623c4g
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="245025053"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="245025053"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 16:44:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="675870142"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Apr 2022 16:44:10 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nilth-0001xp-Jc;
        Sun, 24 Apr 2022 23:44:09 +0000
Date:   Mon, 25 Apr 2022 07:43:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 2fb822f82a59db899ba7b3a615cb0ddbc8c04f0f
Message-ID: <6265e0b4.WpCyvVdyS0+WfL7r%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 2fb822f82a59db899ba7b3a615cb0ddbc8c04f0f  rtw89: 8852c: add chip_ops related to BTC

elapsed time: 723m

configs tested: 137
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
mips                 randconfig-c004-20220424
sh                          r7785rp_defconfig
mips                  decstation_64_defconfig
powerpc                      tqm8xx_defconfig
arm                      jornada720_defconfig
arc                    vdk_hs38_smp_defconfig
m68k                         apollo_defconfig
arm                          simpad_defconfig
sh                        apsh4ad0a_defconfig
nios2                            allyesconfig
sh                            migor_defconfig
arc                      axs103_smp_defconfig
arm                     eseries_pxa_defconfig
sh                           sh2007_defconfig
um                             i386_defconfig
arc                     nsimosci_hs_defconfig
m68k                       m5275evb_defconfig
powerpc                         wii_defconfig
powerpc                      bamboo_defconfig
m68k                        mvme147_defconfig
arm                          exynos_defconfig
x86_64                           alldefconfig
mips                          rb532_defconfig
arm                           sunxi_defconfig
sh                            hp6xx_defconfig
nios2                               defconfig
xtensa                       common_defconfig
arm                            lart_defconfig
arm                            zeus_defconfig
arm                       aspeed_g5_defconfig
sh                           se7780_defconfig
powerpc                     pq2fads_defconfig
arm                          pxa3xx_defconfig
arm                           imxrt_defconfig
parisc64                            defconfig
sh                      rts7751r2d1_defconfig
m68k                        m5407c3_defconfig
riscv                               defconfig
arm                        realview_defconfig
mips                       capcella_defconfig
arm                      footbridge_defconfig
mips                         bigsur_defconfig
sh                         ap325rxa_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220424
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                               defconfig
sparc                            allyesconfig
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
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220424
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func

clang tested configs:
riscv                randconfig-c006-20220424
mips                 randconfig-c004-20220424
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220424
powerpc              randconfig-c003-20220424
arm                        neponset_defconfig
mips                          rm200_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                   milbeaut_m10v_defconfig
arm                         hackkit_defconfig
mips                       rbtx49xx_defconfig
arm                              alldefconfig
powerpc                        fsp2_defconfig
arm                       mainstone_defconfig
arm                          moxart_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220424
hexagon              randconfig-r045-20220424
riscv                randconfig-r042-20220424
s390                 randconfig-r044-20220424

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

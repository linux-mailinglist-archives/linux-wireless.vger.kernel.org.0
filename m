Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EB4520F45
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 09:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbiEJICa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 04:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbiEJICW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 04:02:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4929246431
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 00:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652169498; x=1683705498;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8Akod3KxF0NBNEh3nTnIUoUdL5r2ifhX82GGqMsAEVM=;
  b=P5f3gs5/9GcaPADm2cyi561baIup7Ux3eHt8xjvgX8C9Pm4Brn6H0Dag
   AQA56bIKfbzhWyfWH8yiZ2c3XRhcGIe1ykuALIZ6YmfY0n26EJohiBGVb
   +Uq1rBAYhfyQDkOj3ri4XW/l/UhLlqK/HczygkH6apKDwlLMkLXkg0cq0
   VC8HwSBjm4w8rp/acevcv258DFcorl/t6bWbSJyPT74xCtIdcamfNsCb8
   lMj2BiqFijXzgIukoc4Pp8tHSqIydsKz9Aawa70wdtWGBEQpUyWj8djNN
   Ekze0ufaBbykj+z30bQ4+gswKw9izJ5Vt9Bj6B87dU3aW21UrfISJBzVJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="249199410"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="249199410"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 00:58:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="635811934"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 10 May 2022 00:58:17 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noKl6-000HWZ-Nr;
        Tue, 10 May 2022 07:58:16 +0000
Date:   Tue, 10 May 2022 15:57:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 f63bc788727c591a3a6186327882048a75bb2bef
Message-ID: <627a1ae7.5g+Hm5q0CX0l3iWO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: f63bc788727c591a3a6186327882048a75bb2bef  bcma: gpio: Switch to use fwnode instead of of_node

elapsed time: 1047m

configs tested: 135
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
i386                 randconfig-c001-20220509
parisc                           alldefconfig
sh                          urquell_defconfig
arm                         lubbock_defconfig
sh                          sdk7780_defconfig
sh                           se7712_defconfig
arm                        clps711x_defconfig
arc                              alldefconfig
sh                          landisk_defconfig
arm                       omap2plus_defconfig
arm                         axm55xx_defconfig
mips                    maltaup_xpa_defconfig
mips                             allmodconfig
powerpc                    klondike_defconfig
arm                        realview_defconfig
arc                          axs103_defconfig
sh                             sh03_defconfig
sh                           sh2007_defconfig
arm                      integrator_defconfig
xtensa                           allyesconfig
arm                          badge4_defconfig
powerpc                     taishan_defconfig
arm                      jornada720_defconfig
sh                           se7724_defconfig
m68k                        m5272c3_defconfig
sh                           se7780_defconfig
mips                         cobalt_defconfig
sh                        edosk7705_defconfig
powerpc                      ppc40x_defconfig
arm                            qcom_defconfig
mips                        vocore2_defconfig
arc                     nsimosci_hs_defconfig
sh                         apsh4a3a_defconfig
arm                           corgi_defconfig
mips                 decstation_r4k_defconfig
s390                       zfcpdump_defconfig
arm                            hisi_defconfig
powerpc                      makalu_defconfig
sh                             espt_defconfig
um                                  defconfig
arm                       aspeed_g5_defconfig
sh                         ecovec24_defconfig
x86_64               randconfig-c001-20220509
arm                  randconfig-c002-20220509
ia64                                defconfig
ia64                             allmodconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
parisc                              defconfig
parisc64                            defconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a015-20220509
x86_64               randconfig-a012-20220509
x86_64               randconfig-a016-20220509
x86_64               randconfig-a013-20220509
x86_64               randconfig-a011-20220509
x86_64               randconfig-a014-20220509
i386                 randconfig-a011-20220509
i386                 randconfig-a013-20220509
i386                 randconfig-a016-20220509
i386                 randconfig-a015-20220509
i386                 randconfig-a014-20220509
i386                 randconfig-a012-20220509
arc                  randconfig-r043-20220509
s390                 randconfig-r044-20220509
riscv                randconfig-r042-20220509
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20220509
i386                 randconfig-c001-20220509
powerpc              randconfig-c003-20220509
riscv                randconfig-c006-20220509
arm                  randconfig-c002-20220509
mips                 randconfig-c004-20220509
mips                          ath79_defconfig
powerpc                      ppc64e_defconfig
mips                        workpad_defconfig
arm                          pcm027_defconfig
arm                          collie_defconfig
mips                     loongson1c_defconfig
mips                     cu1830-neo_defconfig
x86_64               randconfig-a006-20220509
x86_64               randconfig-a002-20220509
x86_64               randconfig-a001-20220509
x86_64               randconfig-a004-20220509
x86_64               randconfig-a005-20220509
x86_64               randconfig-a003-20220509
i386                 randconfig-a004-20220509
i386                 randconfig-a006-20220509
i386                 randconfig-a002-20220509
i386                 randconfig-a003-20220509
i386                 randconfig-a001-20220509
i386                 randconfig-a005-20220509

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

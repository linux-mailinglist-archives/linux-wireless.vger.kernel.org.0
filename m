Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145275A75DD
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Aug 2022 07:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiHaFoB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Aug 2022 01:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiHaFn7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Aug 2022 01:43:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F70BA171
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 22:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661924638; x=1693460638;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=r67wDz/SHWvSvqqSn3kUb3HqyWo8BG+LFwJagjL2lTg=;
  b=dLx6wlExdflU+tyXk/iItm/jDNXg85KoTpeQnW0ps132Pm4rnjvF4M/h
   BNz05MdtGCkUZIOn9O0jVCr2icxRcCR8YkOAOhSyOt74nvMYyJNrprFSr
   l2oE4u8R33dz5WH/lYzaeDnibgh2qc1zeew3udFOR+X0bgjNFcjvQLhFV
   TMrQ0EezR/4CeWTfV+5DDxWrzFKJugTXHNgOTRbaJjIn89ODQZlczV6RX
   Fj+qhG3f7r0nJsHSh2KEGhCkK6AfU5MyDNq1k/PMs5xqndbcnvvL0tD1A
   A0QvHQBqpspt9ZW99KZCZwtqgQkWO6xMLi8SKLfGKHrnC4I3o0TRrCooA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="278393632"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="278393632"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 22:43:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="562924131"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2022 22:43:56 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTGW4-00012j-0w;
        Wed, 31 Aug 2022 05:43:56 +0000
Date:   Wed, 31 Aug 2022 13:43:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 6d0ef7241553f3553a0a2764c69b07892705924c
Message-ID: <630ef507.YfKG4cWqcigi37Ma%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 6d0ef7241553f3553a0a2764c69b07892705924c  wifi: iwlegacy: 4965: corrected fix for potential off-by-one overflow in il4965_rs_fill_link_cmd()

elapsed time: 731m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220830
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
sh                               allmodconfig
i386                          randconfig-a005
m68k                             allyesconfig
x86_64                              defconfig
alpha                            allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a013
arc                              allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a011
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a015
x86_64                           rhel-8.3-syz
m68k                             allmodconfig
x86_64                           allyesconfig
i386                          randconfig-a012
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
i386                          randconfig-a014
i386                          randconfig-a016
i386                                defconfig
arm                                 defconfig
ia64                             allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sparc                               defconfig
mips                      loongson3_defconfig
m68k                       m5475evb_defconfig
xtensa                  nommu_kc705_defconfig
mips                       bmips_be_defconfig
sh                             sh03_defconfig
sh                              ul2_defconfig
xtensa                           alldefconfig
m68k                          sun3x_defconfig
sh                             espt_defconfig
arm                       imx_v6_v7_defconfig
mips                           jazz_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     asp8347_defconfig
sh                           se7619_defconfig
sh                         apsh4a3a_defconfig
arm64                            alldefconfig
loongarch                           defconfig
loongarch                         allnoconfig
mips                        bcm47xx_defconfig
powerpc                       eiger_defconfig
arc                 nsimosci_hs_smp_defconfig
sparc                             allnoconfig
sh                           se7721_defconfig
sh                        edosk7760_defconfig
m68k                            mac_defconfig
xtensa                  cadence_csp_defconfig
x86_64                           alldefconfig
arm                         nhk8815_defconfig
arc                        vdk_hs38_defconfig
arm                           u8500_defconfig
arm                           tegra_defconfig
arm                          badge4_defconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc8540_ads_defconfig
xtensa                    smp_lx200_defconfig
arm                          lpd270_defconfig
openrisc                         alldefconfig
i386                          randconfig-c001
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arc                        nsim_700_defconfig
microblaze                      mmu_defconfig
arm                        realview_defconfig
ia64                      gensparse_defconfig

clang tested configs:
riscv                randconfig-r042-20220830
s390                 randconfig-r044-20220830
hexagon              randconfig-r045-20220830
hexagon              randconfig-r041-20220830
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-k001
arm                      tct_hammer_defconfig
powerpc                      ppc64e_defconfig
arm                             mxs_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

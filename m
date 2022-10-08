Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E28C5F821A
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Oct 2022 03:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJHBqW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Oct 2022 21:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJHBqV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Oct 2022 21:46:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFA3688A5
        for <linux-wireless@vger.kernel.org>; Fri,  7 Oct 2022 18:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665193580; x=1696729580;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=y6srmGomOF6BVn1QCE0HA+0P0D/afFz6jH/cqwXEGqA=;
  b=URLto2KLwbu0uYLG6LQ9bR4/5RX5HWZ7kMT4Q87bvJss6wx0aNr/at96
   tv5oHTj/TPxlVW32WIBfc09WsARK2j52azzYrDg80R/NdKYLTPab5vYdH
   S8hH2whBG990a4cClU+yklfc3OoOpRrPowWUE6x/S0vlju0uDKw8N5ysK
   oWf278Xfm0QjF/6jK6l4ue3eCo766fThtWEHYIWpJItlTl/qZ2lQ/Tu2C
   rPthM9tKhoeuLIHBIbSxFjS5iLG5F/HyTz1bh0RJWu+xfVKaOuaQVTcL4
   PfR5HiF0ZAxiKaFfyW1nKsCUmt1W9lHhye9c5f4KMWZoaD3UG4rBHvwPA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="284250764"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="284250764"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 18:46:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="688114212"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="688114212"
Received: from lkp-server01.sh.intel.com (HELO 3c15167049b7) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Oct 2022 18:46:18 -0700
Received: from kbuild by 3c15167049b7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ogyuv-0001jN-2n;
        Sat, 08 Oct 2022 01:46:17 +0000
Date:   Sat, 08 Oct 2022 09:45:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless:for-next] BUILD SUCCESS
 10d5ea5a436da8d60cdb5845f454d595accdbce0
Message-ID: <6340d634.3QUVH3Jv69Sm6LgI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 10d5ea5a436da8d60cdb5845f454d595accdbce0  wifi: nl80211: Split memcpy() of struct nl80211_wowlan_tcp_data_token flexible array

elapsed time: 722m

configs tested: 135
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
i386                                defconfig
powerpc                          allmodconfig
alpha                               defconfig
mips                             allyesconfig
powerpc                           allnoconfig
s390                             allmodconfig
s390                                defconfig
x86_64                              defconfig
um                           x86_64_defconfig
um                             i386_defconfig
s390                             allyesconfig
x86_64                               rhel-8.3
sh                               allmodconfig
i386                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
arm                                 defconfig
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
alpha                            allyesconfig
x86_64                        randconfig-a013
arc                              allyesconfig
x86_64                        randconfig-a011
arm64                            allyesconfig
x86_64                        randconfig-a015
arm                              allyesconfig
arm                        clps711x_defconfig
arm                      integrator_defconfig
powerpc                     sequoia_defconfig
m68k                             allyesconfig
i386                 randconfig-a011-20221003
i386                 randconfig-a016-20221003
i386                 randconfig-a012-20221003
i386                 randconfig-a014-20221003
i386                 randconfig-a015-20221003
i386                 randconfig-a013-20221003
ia64                             allmodconfig
riscv                randconfig-r042-20221007
riscv                randconfig-r042-20221003
arc                  randconfig-r043-20221003
arc                  randconfig-r043-20221002
arc                  randconfig-r043-20221007
s390                 randconfig-r044-20221003
s390                 randconfig-r044-20221007
x86_64               randconfig-a011-20221003
x86_64               randconfig-a016-20221003
x86_64               randconfig-a014-20221003
x86_64               randconfig-a013-20221003
x86_64               randconfig-a012-20221003
x86_64               randconfig-a015-20221003
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                          randconfig-c001
powerpc                     ep8248e_defconfig
sh                  sh7785lcr_32bit_defconfig
sparc64                          alldefconfig
sh                        dreamcast_defconfig
s390                          debug_defconfig
powerpc                     asp8347_defconfig
nios2                            alldefconfig
um                               alldefconfig
sh                          kfr2r09_defconfig
sh                           se7751_defconfig
mips                         db1xxx_defconfig
arm                       imx_v6_v7_defconfig
powerpc                         wii_defconfig
powerpc                     taishan_defconfig
sh                          landisk_defconfig
powerpc                    klondike_defconfig
arm                        oxnas_v6_defconfig
powerpc                        warp_defconfig
arm                           viper_defconfig
arm                  randconfig-c002-20221002
x86_64                        randconfig-c001
arm                        realview_defconfig
sh                          polaris_defconfig
sh                     magicpanelr2_defconfig
powerpc                       maple_defconfig
arm                           sunxi_defconfig
sparc                       sparc64_defconfig
parisc                generic-64bit_defconfig
arm                             ezx_defconfig
m68k                          multi_defconfig
riscv                randconfig-r042-20221005
arc                  randconfig-r043-20221005
s390                 randconfig-r044-20221005
arc                        nsim_700_defconfig
powerpc                    sam440ep_defconfig
sh                          rsk7269_defconfig
parisc                           alldefconfig
sh                        sh7757lcr_defconfig
arm                           imxrt_defconfig
arm                            zeus_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
mips                 randconfig-c004-20221002
arm                             pxa_defconfig
arc                        vdk_hs38_defconfig
powerpc                     redwood_defconfig
nios2                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
x86_64               randconfig-a006-20221003
x86_64               randconfig-a005-20221003
x86_64               randconfig-a002-20221003
x86_64               randconfig-a001-20221003
x86_64               randconfig-a003-20221003
x86_64                        randconfig-a012
x86_64               randconfig-a004-20221003
x86_64                        randconfig-a014
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
x86_64                        randconfig-a016
i386                 randconfig-a001-20221003
i386                 randconfig-a004-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a006-20221003
powerpc                        fsp2_defconfig
powerpc                     tqm8560_defconfig
arm                          pxa168_defconfig
x86_64                        randconfig-k001
powerpc                 mpc832x_mds_defconfig
mips                          ath25_defconfig
arm                        mvebu_v5_defconfig
s390                             alldefconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

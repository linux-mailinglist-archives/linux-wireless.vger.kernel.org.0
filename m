Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D0F4FD9A4
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Apr 2022 12:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353173AbiDLJ41 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Apr 2022 05:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352396AbiDLIkP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Apr 2022 04:40:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1084F24976
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 01:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649750798; x=1681286798;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4ygQx8gDHsorwWGPcLNOYvL7O+tXSp51Fk2WHcrDRSQ=;
  b=OQV+DqyHCnv0eGn59OXdWQy9jFe/3WQfKCmoQ2CdC4S1Ny4jslc9du3o
   Y/DGcgA8qv2kOIPbroHC5M5lGHY4FzukffLI2zyxFlCb/P+C+c7D/rEtV
   PCqA+Hju47YiDOFzbM0lg7y4wMX1VojTPzzM1zQk0bT1eUZC+UYN2dLQP
   YxRphlUgSEGwyI6IL9OpsFKZzq0U8HG03ZijQWAqd0+fXwDEvcG0WuDHN
   vF1NM+hzosjvanDPPiaSfGxGOgPZV86snE+tRTeXoKr2BZi2XP/zYxSQj
   NO/IueuJMJjLWAr42B9oQoLeQMy+swIIkKKclM0UcNXYBDG4OKuRZz/h1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261154897"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="261154897"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 01:06:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="644611655"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Apr 2022 01:06:36 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neBXn-0002eX-M5;
        Tue, 12 Apr 2022 08:06:35 +0000
Date:   Tue, 12 Apr 2022 16:06:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:main] BUILD SUCCESS
 046d2e7c50e3087a32a85fd384c21f896dbccf83
Message-ID: <625532ea.kNjEM3tlXT8i+kT9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 046d2e7c50e3087a32a85fd384c21f896dbccf83  mac80211: prepare sta handling for MLO support

Unverified Warning (likely false positive, please contact us if interested):

net/mac80211/status.c:980 __ieee80211_tx_status() warn: potential spectre issue 'sta->deflink.status_stats.msdu_failed' [w]
net/mac80211/status.c:982 __ieee80211_tx_status() warn: potential spectre issue 'sta->deflink.status_stats.msdu_retries' [w]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-m021-20220411
|   |-- net-mac80211-status.c-__ieee80211_tx_status()-warn:potential-spectre-issue-sta-deflink.status_stats.msdu_failed-w
|   `-- net-mac80211-status.c-__ieee80211_tx_status()-warn:potential-spectre-issue-sta-deflink.status_stats.msdu_retries-w
`-- x86_64-randconfig-m001-20220411
    |-- net-mac80211-status.c-__ieee80211_tx_status()-warn:potential-spectre-issue-sta-deflink.status_stats.msdu_failed-w
    `-- net-mac80211-status.c-__ieee80211_tx_status()-warn:potential-spectre-issue-sta-deflink.status_stats.msdu_retries-w

elapsed time: 975m

configs tested: 116
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220411
arm                     eseries_pxa_defconfig
powerpc                      mgcoge_defconfig
mips                  decstation_64_defconfig
sh                 kfr2r09-romimage_defconfig
arm                       imx_v6_v7_defconfig
arm                          pxa3xx_defconfig
m68k                       m5475evb_defconfig
xtensa                          iss_defconfig
powerpc                      ppc40x_defconfig
arc                           tb10x_defconfig
xtensa                  cadence_csp_defconfig
sh                          rsk7203_defconfig
mips                         cobalt_defconfig
nios2                            alldefconfig
sh                               j2_defconfig
m68k                       m5249evb_defconfig
powerpc                     stx_gp3_defconfig
openrisc                         alldefconfig
arm                      jornada720_defconfig
arm                  randconfig-c002-20220411
x86_64               randconfig-c001-20220411
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
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
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a016-20220411
x86_64               randconfig-a012-20220411
x86_64               randconfig-a013-20220411
x86_64               randconfig-a014-20220411
x86_64               randconfig-a015-20220411
x86_64               randconfig-a011-20220411
i386                 randconfig-a015-20220411
i386                 randconfig-a011-20220411
i386                 randconfig-a016-20220411
i386                 randconfig-a012-20220411
i386                 randconfig-a013-20220411
i386                 randconfig-a014-20220411
riscv                randconfig-r042-20220411
arc                  randconfig-r043-20220411
s390                 randconfig-r044-20220411
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
powerpc              randconfig-c003-20220411
arm                  randconfig-c002-20220411
riscv                randconfig-c006-20220411
x86_64               randconfig-c007-20220411
mips                 randconfig-c004-20220411
i386                 randconfig-c001-20220411
powerpc                 mpc832x_mds_defconfig
arm                        multi_v5_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     mpc512x_defconfig
hexagon                             defconfig
powerpc                     ppa8548_defconfig
x86_64                           allyesconfig
powerpc                 mpc837x_rdb_defconfig
i386                 randconfig-a004-20220411
i386                 randconfig-a001-20220411
i386                 randconfig-a003-20220411
i386                 randconfig-a005-20220411
i386                 randconfig-a006-20220411
i386                 randconfig-a002-20220411
x86_64               randconfig-a003-20220411
x86_64               randconfig-a004-20220411
x86_64               randconfig-a006-20220411
x86_64               randconfig-a001-20220411
x86_64               randconfig-a002-20220411
x86_64               randconfig-a005-20220411
hexagon              randconfig-r041-20220411
hexagon              randconfig-r045-20220411

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

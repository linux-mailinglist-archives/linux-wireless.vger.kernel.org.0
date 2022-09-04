Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9809A5AC254
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Sep 2022 06:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiIDEXg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Sep 2022 00:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiIDEXe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Sep 2022 00:23:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8224D814
        for <linux-wireless@vger.kernel.org>; Sat,  3 Sep 2022 21:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662265413; x=1693801413;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xrrIp60k0yEadpwLwEy4O2igijr1HZ+qzcDh+jPO+ho=;
  b=md2ecZuwXhAfUD6bk8jEl6SJNC0R0XpZZSGBmq5aoAdfIP8NRlM08l3W
   zP/LpUcf/BNCktQyPXRO8ElyBtIOJN18gZy63mjF/W5V8ZeEQshWQqtAZ
   q4QfC8r8HYujh+COoJ6JORLFMp1kEM33l2unRdedoZwYyNIKaN8WchE6r
   fI4YDyPdj8MIVMR50NoQZpnDM6YHLKPLSMuycqQl7Z00L3XHI1bUkxwMw
   mvWjQ1nw5NLTSscYm5J2SsxPE3obLbfkZE6JBuob7ZSELpipQl+5vh5Fg
   ZBFYXtpZN2OcJSwvdRNoWAFykt566r5qDfOjVWgd45E0Vn3QI/ijXJa3N
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="360164406"
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="360164406"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 21:23:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="613433498"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 03 Sep 2022 21:23:31 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUhAQ-0002YN-2H;
        Sun, 04 Sep 2022 04:23:30 +0000
Date:   Sun, 04 Sep 2022 12:23:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:mld-wip] BUILD SUCCESS
 f7be5f6a2174bc94d0230d7aeb42fc08da18956f
Message-ID: <63142835.HWAIxFSTaNPABNEb%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld-wip
branch HEAD: f7be5f6a2174bc94d0230d7aeb42fc08da18956f  wifi: mac80211_hwsim: always activate all links

elapsed time: 725m

configs tested: 88
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
x86_64                              defconfig
i386                          randconfig-a001
i386                          randconfig-a003
arm                                 defconfig
i386                          randconfig-a014
arc                               allnoconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                        randconfig-a015
i386                          randconfig-a012
x86_64                               rhel-8.3
i386                          randconfig-a016
i386                          randconfig-a005
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
x86_64                        randconfig-a013
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a011
m68k                             allmodconfig
arc                              allyesconfig
arm64                            allyesconfig
arc                  randconfig-r043-20220904
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a006
powerpc                           allnoconfig
powerpc                          allmodconfig
arm                              allyesconfig
s390                 randconfig-r044-20220904
sh                               allmodconfig
mips                             allyesconfig
m68k                           sun3_defconfig
riscv                randconfig-r042-20220904
arc                            hsdk_defconfig
x86_64                        randconfig-a002
i386                             allyesconfig
powerpc                 mpc837x_rdb_defconfig
ia64                             allmodconfig
arm                           u8500_defconfig
m68k                       m5475evb_defconfig
mips                      fuloong2e_defconfig
sparc64                          alldefconfig
sh                           se7722_defconfig
x86_64                        randconfig-a004
arm                         assabet_defconfig
m68k                          atari_defconfig
mips                         bigsur_defconfig
arc                  randconfig-r043-20220902
arm                           tegra_defconfig
mips                  decstation_64_defconfig
arm                          gemini_defconfig
arc                  randconfig-r043-20220903
riscv                randconfig-r042-20220902
s390                 randconfig-r044-20220902
i386                          randconfig-c001

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a002
i386                          randconfig-a015
i386                          randconfig-a004
i386                          randconfig-a011
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a012
hexagon              randconfig-r045-20220904
hexagon              randconfig-r041-20220904
x86_64                        randconfig-a001
powerpc                 xes_mpc85xx_defconfig
arm                   milbeaut_m10v_defconfig
x86_64                        randconfig-a003
riscv                randconfig-r042-20220903
hexagon              randconfig-r045-20220902
powerpc                 mpc8315_rdb_defconfig
mips                          rm200_defconfig
arm                           sama7_defconfig
arm                          moxart_defconfig
hexagon              randconfig-r045-20220903
hexagon              randconfig-r041-20220903
hexagon              randconfig-r041-20220902
s390                 randconfig-r044-20220903

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774D5670F26
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 01:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjARAxT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 19:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjARAvX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 19:51:23 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8393EFEA
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 16:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674002416; x=1705538416;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xDR6m/pSBNKiRdVaK1S6j9zPiM9EWa2l44L82WIHpkc=;
  b=Tvpj5Y8kE+8J8nAeSzofEhUOpiU0F4OErvyXGHTPQTC7SyFXrF7Fse9F
   4CHJo6rRVS/pSxSDYjCdJtTGHU3b1Fmy1Ryyo8B76xXamz/4v2P1fav1b
   QSfVldQGP2mZTpugrsEmtd7+8ZUUE2jr22c7epaB8WwfG1oofFi3SBqt6
   RFRZyjNlhSqyiZaXn7YpznLG1OuN5dt7RKXnmvIA+mGhr/9Wtn6MX/YFF
   gV2Yc+1M3yqVQs/ERkLQT67Yj4VAnBvEABL3yQ1gBr7RQXt86aL8jnvM6
   ng8rGmHMT/mxIvQ4hLE3QjzLHPRbu6TyaGy8TTrtRleAPEJ3Fs2oJcx58
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="387210720"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="387210720"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 16:39:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="833355975"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="833355975"
Received: from lkp-server02.sh.intel.com (HELO f57cd993bc73) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Jan 2023 16:39:27 -0800
Received: from kbuild by f57cd993bc73 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pHwUB-0001VE-0H;
        Wed, 18 Jan 2023 00:39:27 +0000
Date:   Wed, 18 Jan 2023 08:38:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:pending] BUILD SUCCESS
 d0e99511834b6828c960e978d9a8cb6e5731250d
Message-ID: <63c73f9b.eb0M0AkhXTpQqW1C%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: d0e99511834b6828c960e978d9a8cb6e5731250d  Merge wireless into wireless-next

elapsed time: 723m

configs tested: 116
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
x86_64                            allnoconfig
x86_64                              defconfig
arm                                 defconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arc                                 defconfig
alpha                            allyesconfig
s390                             allmodconfig
alpha                               defconfig
m68k                             allyesconfig
x86_64                           allyesconfig
s390                                defconfig
sh                               allmodconfig
riscv                randconfig-r042-20230116
m68k                             allmodconfig
x86_64                           rhel-8.3-bpf
arm64                            allyesconfig
s390                             allyesconfig
arm                              allyesconfig
x86_64                           rhel-8.3-syz
arc                              allyesconfig
ia64                             allmodconfig
arc                  randconfig-r043-20230116
x86_64               randconfig-a011-20230116
x86_64                         rhel-8.3-kunit
i386                             allyesconfig
x86_64               randconfig-a013-20230116
mips                             allyesconfig
x86_64               randconfig-a012-20230116
x86_64                           rhel-8.3-kvm
powerpc                          allmodconfig
i386                 randconfig-a014-20230116
arm                  randconfig-r046-20230117
x86_64               randconfig-a015-20230116
i386                 randconfig-a013-20230116
arc                  randconfig-r043-20230117
i386                 randconfig-a012-20230116
x86_64               randconfig-a014-20230116
s390                 randconfig-r044-20230116
x86_64               randconfig-a016-20230116
i386                 randconfig-a015-20230116
i386                 randconfig-a011-20230116
i386                 randconfig-a016-20230116
arc                  randconfig-r043-20230115
arm                  randconfig-r046-20230115
i386                 randconfig-c001-20230116
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                randconfig-r042-20230118
s390                 randconfig-r044-20230118
arc                  randconfig-r043-20230118
xtensa                  cadence_csp_defconfig
sh                             shx3_defconfig
sh                          kfr2r09_defconfig
sh                     magicpanelr2_defconfig
m68k                            q40_defconfig
ia64                      gensparse_defconfig
mips                  decstation_64_defconfig
m68k                          multi_defconfig
powerpc                    sam440ep_defconfig
sh                         ap325rxa_defconfig
riscv                            allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a001-20230116
x86_64               randconfig-a003-20230116
x86_64               randconfig-a004-20230116
x86_64               randconfig-a002-20230116
x86_64               randconfig-a005-20230116
x86_64               randconfig-a006-20230116
hexagon              randconfig-r041-20230116
hexagon              randconfig-r045-20230117
s390                 randconfig-r044-20230117
hexagon              randconfig-r041-20230117
i386                 randconfig-a002-20230116
arm                  randconfig-r046-20230116
i386                 randconfig-a004-20230116
hexagon              randconfig-r045-20230116
i386                 randconfig-a003-20230116
i386                 randconfig-a005-20230116
i386                 randconfig-a001-20230116
riscv                randconfig-r042-20230117
i386                 randconfig-a006-20230116
x86_64                        randconfig-k001
arm                          sp7021_defconfig
powerpc                     ppa8548_defconfig
powerpc                        fsp2_defconfig
mips                           rs90_defconfig
powerpc                 mpc836x_rdk_defconfig
hexagon              randconfig-r045-20230115
hexagon              randconfig-r041-20230115
riscv                randconfig-r042-20230115
s390                 randconfig-r044-20230115
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
powerpc                      acadia_defconfig
arm                        magician_defconfig
riscv                             allnoconfig
arm                         hackkit_defconfig
mips                          malta_defconfig
mips                        qi_lb60_defconfig
powerpc                     tqm8560_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                     kmeter1_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

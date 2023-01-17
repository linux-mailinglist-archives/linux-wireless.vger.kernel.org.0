Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BAF66D73A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 08:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjAQHve (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 02:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjAQHvX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 02:51:23 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726AD10E9
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 23:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673941882; x=1705477882;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=iTRG6Tm/wXyUuK4jiOrzfLxI0umAFBgHrWE198nKxQQ=;
  b=fAOi1l+DzpSCWuIMsmANrPmSh/aez8EG9Uo4ou4Vnnoki9zfgJJmN3ii
   fyjb871Aq6+cBNlbfFVotv2MtG896d615QipBMqbMZDQwX5tEceFL0Vj/
   oluvyJ9Bnyg47cmOYD6DKSmbdENJpzV0uEI97W+FGRvf2hVN+Ewh6TQRQ
   lwlftxrWF3VP4D+JJg1ONPkEK2ky2TVWYD04wh6b+gKduR5zHu5bRJimb
   GhmEy7gQK08VvKKTEdcEQgXbmwpuMo/RUW32NWD/8ywIQgJtlDQFMC3Z4
   m/c7zdycHaWjbO2Px6JW4nfN/yUJh2iziHu90Wf9v2bP3jJFg3Qqo5ctO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="324687074"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="324687074"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 23:51:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="988036626"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="988036626"
Received: from lkp-server02.sh.intel.com (HELO f57cd993bc73) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jan 2023 23:51:19 -0800
Received: from kbuild by f57cd993bc73 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pHgkZ-00014R-0G;
        Tue, 17 Jan 2023 07:51:19 +0000
Date:   Tue, 17 Jan 2023 15:50:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 de7d0ff301fccc75281d7d8eb98c4a47faacf32d
Message-ID: <63c65355.esqWyXUAC/ViXcnf%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: de7d0ff301fccc75281d7d8eb98c4a47faacf32d  wifi: rtl8xxxu: Dump the efuse only for untested devices

elapsed time: 721m

configs tested: 76
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
arc                                 defconfig
s390                             allmodconfig
i386                 randconfig-a014-20230116
alpha                               defconfig
i386                 randconfig-a013-20230116
i386                 randconfig-a012-20230116
i386                 randconfig-a011-20230116
s390                                defconfig
m68k                             allmodconfig
sh                               allmodconfig
i386                 randconfig-a015-20230116
arc                              allyesconfig
i386                                defconfig
i386                 randconfig-a016-20230116
alpha                            allyesconfig
s390                             allyesconfig
arm                                 defconfig
m68k                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
i386                             allyesconfig
arc                  randconfig-r043-20230115
riscv                randconfig-r042-20230116
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20230116
arm                  randconfig-r046-20230115
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
arm64                            allyesconfig
s390                 randconfig-r044-20230116
arm                              allyesconfig
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arm                  randconfig-r046-20230117
arc                  randconfig-r043-20230117
x86_64               randconfig-a011-20230116
x86_64               randconfig-a016-20230116
x86_64               randconfig-a014-20230116
x86_64               randconfig-a013-20230116
x86_64               randconfig-a015-20230116
x86_64               randconfig-a012-20230116

clang tested configs:
hexagon              randconfig-r041-20230116
hexagon              randconfig-r045-20230115
riscv                randconfig-r042-20230115
x86_64                          rhel-8.3-rust
arm                  randconfig-r046-20230116
s390                 randconfig-r044-20230115
hexagon              randconfig-r045-20230116
hexagon              randconfig-r041-20230115
i386                 randconfig-a002-20230116
i386                 randconfig-a004-20230116
i386                 randconfig-a003-20230116
i386                 randconfig-a006-20230116
i386                 randconfig-a005-20230116
i386                 randconfig-a001-20230116
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a001-20230116
x86_64               randconfig-a005-20230116
x86_64               randconfig-a003-20230116
x86_64               randconfig-a004-20230116
x86_64               randconfig-a002-20230116
x86_64               randconfig-a006-20230116

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

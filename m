Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA11063BB29
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 09:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiK2ICJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 03:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiK2ICB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 03:02:01 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAA91F2FB
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 00:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669708920; x=1701244920;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kgdL2DBERAgb8vvH9bctu6RI2UVX4CdhLjLoa7Ts/lw=;
  b=ce7Iig7J9P7+ueMSqKpf1rVBr8S2Z0WYitnXEHiaPKmMcXSAyoBe4UWP
   p2DT0t6ZqW0hhtWP5kT/pMO0iDkzKKhkrScVPLI3Ez5w4S86w/tC5YmD0
   sb9URmD5sPQL/F2nqIUOGVSMpTU/LmmH9l/7vLsaZYdo8/s0qdUVkkD3J
   C2hKaAW6OcTTncKkA7ykWhlvCFZAIpfLsBzTEvRVBJD3lOsvWH+b6LU9R
   9DgGkHWXPo2ALJ1mjN/2fmDyi1FBQ9oS9WMICIQbHvlRFT7h9BNQpavhH
   HBQjRNt9qwOWLKRZeRhShD2scnLlQW1x8sivNiV4sEHKlADB5PiPaT1as
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="377194074"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="377194074"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 00:01:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="712283208"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="712283208"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Nov 2022 00:01:58 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ozvYz-0008n9-1P;
        Tue, 29 Nov 2022 08:01:57 +0000
Date:   Tue, 29 Nov 2022 16:01:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 eceb024ee3eed1bacb5c32a4847269f2685e2ea4
Message-ID: <6385bc4d.fGygq3SPpcP200kI%lkp@intel.com>
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
branch HEAD: eceb024ee3eed1bacb5c32a4847269f2685e2ea4  Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

elapsed time: 945m

configs tested: 64
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
arc                  randconfig-r043-20221128
um                             i386_defconfig
s390                             allmodconfig
um                           x86_64_defconfig
s390                                defconfig
powerpc                           allnoconfig
s390                             allyesconfig
x86_64                           rhel-8.3-syz
m68k                             allmodconfig
x86_64                           rhel-8.3-kvm
alpha                            allyesconfig
x86_64                         rhel-8.3-kunit
arc                              allyesconfig
m68k                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
ia64                             allmodconfig
sh                               allmodconfig
x86_64                              defconfig
i386                 randconfig-a003-20221128
i386                                defconfig
i386                 randconfig-a001-20221128
i386                 randconfig-a006-20221128
mips                             allyesconfig
i386                 randconfig-a004-20221128
i386                 randconfig-a002-20221128
powerpc                          allmodconfig
i386                 randconfig-a005-20221128
x86_64                               rhel-8.3
x86_64                        randconfig-a013
x86_64                           allyesconfig
x86_64                        randconfig-a011
x86_64               randconfig-a003-20221128
x86_64               randconfig-a004-20221128
x86_64               randconfig-a002-20221128
x86_64               randconfig-a005-20221128
x86_64               randconfig-a001-20221128
x86_64               randconfig-a006-20221128
x86_64                        randconfig-a015
i386                             allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r041-20221128
hexagon              randconfig-r045-20221128
riscv                randconfig-r042-20221128
s390                 randconfig-r044-20221128
i386                 randconfig-a012-20221128
i386                 randconfig-a014-20221128
i386                 randconfig-a015-20221128
x86_64               randconfig-a013-20221128
i386                 randconfig-a016-20221128
i386                 randconfig-a011-20221128
x86_64               randconfig-a012-20221128
i386                 randconfig-a013-20221128
x86_64               randconfig-a014-20221128
x86_64                        randconfig-a012
x86_64               randconfig-a011-20221128
x86_64                        randconfig-a014
x86_64               randconfig-a016-20221128
x86_64                        randconfig-a016
x86_64               randconfig-a015-20221128

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

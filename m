Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E345A5E13
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 10:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiH3I3B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Aug 2022 04:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiH3I3A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Aug 2022 04:29:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57857A5985
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 01:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661848139; x=1693384139;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=g5KQcZd+MFfdcgTTsZ5Hgbwvt1jT6Arg6BMfDIOThD0=;
  b=LsD1PN6G7a0NirX37N13K1IhkS99Kc2qqoqM7XXHZy765UthXMH/VDQy
   urlVE7bYCotEBdexU13xuuV/eeSH9eatR+of3lwQcLnKXc8LZ9+2gDKs6
   dDpJkfvrbw1J46tbpeYuPCIl9X+mSj89FIn5ikyZ82ZiXCsuDlhNzLBQc
   G+XPATlJSOf8mxTWhGk+h32zRg3+5zxS0HPcpWA6G00koza3b70xvXcCJ
   Lkb59xx+y15zDVdpJ6wFlLCeuYX9UfBiVxDP+gX93n2+LXA4eHWKMOW6R
   l+67KU2x/82Z/0CiehwFgSpASVANwsNnQkauhdF0uv5sibWxbw+KerzQ+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="282089077"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="282089077"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 01:28:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="562557303"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2022 01:28:57 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSwcC-00005s-2J;
        Tue, 30 Aug 2022 08:28:56 +0000
Date:   Tue, 30 Aug 2022 16:28:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:mld] BUILD SUCCESS
 cad84367c825e34358ba29676dc808f48b49f50a
Message-ID: <630dca21.wbW/ZikjbXE4Ux4u%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld
branch HEAD: cad84367c825e34358ba29676dc808f48b49f50a  wifi: mac80211_hwsim: remove multicast workaround

elapsed time: 730m

configs tested: 85
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                 randconfig-a001-20220829
i386                 randconfig-a003-20220829
arc                              allyesconfig
i386                 randconfig-a002-20220829
alpha                            allyesconfig
x86_64               randconfig-a003-20220829
i386                 randconfig-a005-20220829
arc                  randconfig-r043-20220829
i386                 randconfig-a006-20220829
x86_64               randconfig-a004-20220829
x86_64               randconfig-a005-20220829
i386                 randconfig-a004-20220829
x86_64               randconfig-a002-20220829
m68k                             allyesconfig
x86_64               randconfig-a006-20220829
m68k                             allmodconfig
x86_64               randconfig-a001-20220829
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
sh                            migor_defconfig
sh                      rts7751r2d1_defconfig
xtensa                           alldefconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
microblaze                          defconfig
powerpc                 mpc8540_ads_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
ia64                             allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig

clang tested configs:
hexagon              randconfig-r041-20220829
x86_64               randconfig-a011-20220829
riscv                randconfig-r042-20220829
s390                 randconfig-r044-20220829
hexagon              randconfig-r045-20220829
x86_64               randconfig-a014-20220829
x86_64               randconfig-a016-20220829
x86_64               randconfig-a015-20220829
x86_64               randconfig-a012-20220829
x86_64               randconfig-a013-20220829
i386                 randconfig-a011-20220829
i386                 randconfig-a014-20220829
i386                 randconfig-a013-20220829
i386                 randconfig-a012-20220829
i386                 randconfig-a015-20220829
i386                 randconfig-a016-20220829
powerpc                        fsp2_defconfig
arm                         shannon_defconfig
s390                             alldefconfig
mips                           ip28_defconfig
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
s390                 randconfig-r044-20220830
hexagon              randconfig-r045-20220830
hexagon              randconfig-r041-20220830
riscv                randconfig-r042-20220830
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

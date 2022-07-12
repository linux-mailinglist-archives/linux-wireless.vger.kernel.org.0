Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF8C57116C
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jul 2022 06:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiGLE07 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Jul 2022 00:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiGLE07 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Jul 2022 00:26:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870351209D
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jul 2022 21:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657600018; x=1689136018;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=SggBeQ3wybSidtYIC9e9tCy+UR63tf4dBPU3gQZHUAw=;
  b=A/mkY2JArVWNK5R7xD7oJpFpzN+JcyWKJtvHI872Hx5F0JwepTrHaHhr
   14d/GQKrq2+ioukg/jlVEkQ9wMaGQOF6fr4EfrOdmKODWSErC6l7YhMWB
   0RFpNWHYpfHGNFo8fuL9B8KmTUikB8jxqc+OJCYih3DVico6d3oQ1j4NB
   MapzqnLh++nQo4iZ3jHj3c34Y7WM4oxLFyJT9ls9Uu7llrN6sxWuR8Qpn
   FePCsGUJd8RfOy3sD47KECJnHH/Nj1RZQ5OoO0hDJrB99E8FzYtUf2nxg
   nVrG5LVv107xVBaQ/ASUn5osDnBRbxWXT0RvA5foC+ovITxz99k2YLOGS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="371143036"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="371143036"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 21:26:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="570039316"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Jul 2022 21:26:56 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oB7U8-0001fz-8p;
        Tue, 12 Jul 2022 04:26:56 +0000
Date:   Tue, 12 Jul 2022 12:26:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:main] BUILD SUCCESS WITH WARNING
 58b6259d820d63c2adf1c7541b54cce5a2ae6073
Message-ID: <62ccf7f8.uR3XslqEw65Ok74u%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 58b6259d820d63c2adf1c7541b54cce5a2ae6073  wifi: mac80211_hwsim: add back erroneously removed cast

Warning reports:

https://lore.kernel.org/linux-wireless/202207111835.B5zUbIhZ-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/net/wireless/mac80211_hwsim.c:1431:37: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-allyesconfig
|   `-- drivers-net-wireless-mac80211_hwsim.c:warning:cast-to-pointer-from-integer-of-different-size
|-- m68k-allyesconfig
|   `-- drivers-net-wireless-mac80211_hwsim.c:warning:cast-to-pointer-from-integer-of-different-size
`-- sh-allmodconfig
    `-- drivers-net-wireless-mac80211_hwsim.c:warning:cast-to-pointer-from-integer-of-different-size

elapsed time: 950m

configs tested: 49
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
sh                               allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220710
s390                 randconfig-r044-20220710
riscv                randconfig-r042-20220710
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220710
hexagon              randconfig-r045-20220710

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

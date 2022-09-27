Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCA15ED057
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 00:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiI0WiA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Sep 2022 18:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiI0Wh7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Sep 2022 18:37:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D40B1BA0
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 15:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664318278; x=1695854278;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XmZk+tiXNkcHkDyOLmTjo9h+xv9BS+SOES5yxWMj1ug=;
  b=Ed6WCtUlHVWK5WGc78xsJDeM2sB5iviF47DCx4ZVxWp5UDiEO54RJRyj
   wHEE2W1eOiFY7y6abf8qE6c169rFyKWZkIsc3JJvHyN1qMwokK2NvL4Wp
   b0lhnu10G/Kt4tCnTI4Gg/WBxnizS0NYI4ORwz30FRV9g2gWI6S5QJi4U
   wjOZlcPqKu5Rfdn+yHw7iw1WYB0AiPbTuii0gmODkGMZbkHF9bnAdGinF
   wO5nVyOzJqcPYqNx0kd+4zV2EmOdB1bj6FyMFkv4BMaHW3aBroNQLoQ6C
   sruObmMKi2W115HD4+86O+1LNQcIx8j3lVkAlssm2BORFxTF0PznQMdG/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="281819484"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="281819484"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 15:37:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="654892065"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="654892065"
Received: from lkp-server02.sh.intel.com (HELO dfa2c9fcd321) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 27 Sep 2022 15:37:56 -0700
Received: from kbuild by dfa2c9fcd321 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1odJD9-0001eu-2J;
        Tue, 27 Sep 2022 22:37:55 +0000
Date:   Wed, 28 Sep 2022 06:36:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless:for-next] BUILD SUCCESS
 6546646a7fb0d7fe1caef947889497c16aaecc8c
Message-ID: <63337b08.JkEcNhtfiqzO/c8o%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 6546646a7fb0d7fe1caef947889497c16aaecc8c  wifi: mac80211: mlme: Fix double unlock on assoc success handling

elapsed time: 741m

configs tested: 69
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
sh                               allmodconfig
arc                                 defconfig
powerpc                          allmodconfig
alpha                               defconfig
mips                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
s390                             allmodconfig
s390                                defconfig
i386                 randconfig-a001-20220926
x86_64                          rhel-8.3-func
m68k                             allmodconfig
i386                 randconfig-a002-20220926
arc                              allyesconfig
i386                 randconfig-a003-20220926
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
alpha                            allyesconfig
s390                             allyesconfig
i386                 randconfig-a004-20220926
m68k                             allyesconfig
i386                 randconfig-a005-20220926
i386                 randconfig-a006-20220926
arc                  randconfig-r043-20220926
x86_64                               rhel-8.3
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                           allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a005
x86_64                        randconfig-a006
arm                                 defconfig
arc                  randconfig-r043-20220925
x86_64                        randconfig-a013
i386                                defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arm64                            allyesconfig
arm                              allyesconfig
riscv                randconfig-r042-20220925
s390                 randconfig-r044-20220925
i386                             allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220926
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926
i386                 randconfig-a016-20220926
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a006
hexagon              randconfig-r041-20220925
i386                 randconfig-a012-20220926
i386                 randconfig-a013-20220926
x86_64                        randconfig-a012
i386                 randconfig-a011-20220926
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                 randconfig-a014-20220926
i386                 randconfig-a015-20220926
hexagon              randconfig-r045-20220925

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

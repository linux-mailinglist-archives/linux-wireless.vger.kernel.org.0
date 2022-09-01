Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF645A8EC7
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Sep 2022 08:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbiIAGwz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Sep 2022 02:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiIAGwy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Sep 2022 02:52:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F50DEB5A
        for <linux-wireless@vger.kernel.org>; Wed, 31 Aug 2022 23:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662015174; x=1693551174;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=SHJktcnaOIbisM5xKT/dXAZihZCV8RAS1LacF+hTz00=;
  b=mAmbMH/DstEgiIijJCy2kfgvfOJIoxI+1e9oSmBxTnuJIO7/R47fDsxt
   qK022uOUbkc74uTZ2jAhB6Trfd7JQzmsqCg6MKi7/sx9KvApdooMRM3nv
   2/kujizyfqTLCmcckHKDRK62aqnEYMH49W5f9HdwOOvFmx6BGq0yCAG+U
   IzaG2Ixa8Z69DvpZItV5uHwYR+4L3+ZjOCOLUY5OBui2r1cVCcwQNNMvQ
   IhrbDVjFdYmnmcm1ygr60ErwoyTaGaAeP46HPKY369dPOnLIm/xW4tHmo
   WuSjgAe0sZmek0u535jQbN1omRfe3dg61fNVD2cExZUTs3IeYZil+RgUh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="293211329"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="293211329"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 23:52:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="940731305"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 31 Aug 2022 23:52:52 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTe4K-0001FA-0K;
        Thu, 01 Sep 2022 06:52:52 +0000
Date:   Thu, 01 Sep 2022 14:52:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:mld] BUILD SUCCESS
 c927e5e70e33e3d4be21b59a5938d17a93c2d3cb
Message-ID: <631056b3.0QuxB6dQwxC4GLD4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld
branch HEAD: c927e5e70e33e3d4be21b59a5938d17a93c2d3cb  wifi: mac80211_hwsim: warn on invalid link address

elapsed time: 806m

configs tested: 41
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220831
riscv                randconfig-r042-20220831
s390                 randconfig-r044-20220831
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
i386                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
arm                                 defconfig
ia64                             allmodconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r045-20220831
hexagon              randconfig-r041-20220831
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

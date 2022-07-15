Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67B35769BF
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Jul 2022 00:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiGOWQA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jul 2022 18:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiGOWPl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jul 2022 18:15:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168F7115C
        for <linux-wireless@vger.kernel.org>; Fri, 15 Jul 2022 15:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657923228; x=1689459228;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=oWYF1RusdAjd2VSXysP9zk3Sdq9blcO5xJbr3DEcxKM=;
  b=RgmQfQ3OtH9mrcab2jq4cGpDi7AGiQZVhRt3XNrOz7hbjRHMTKTzpbqZ
   ai4LRr8VXInbjAVxyrEIi5rSewE9TwQM9+6XkeqCeTZIEMSyFFO3U/Hp0
   42//1xUvC+e+969dioUX0n/lxYQVMMtNlPu4IJ1aDhTvQItbhCZ6CENPN
   6/HfznMmVtXY6ocuRFdcOasg1M5Fqq/DHOc0dPS1SlK21pzysIfoGwdsz
   WxX7nNe8zy6Wdj5RbvY6toVo+uoEv0QDWMWdDj6g9igEr6DUwBnn17dV0
   qo+tkf8FIKheb+rbUUSKdzJxlLnqcGq+9jPsQ3Icnvr3CDBD50DuPwY5i
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="268931076"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="268931076"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 15:13:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="923676679"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jul 2022 15:13:46 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCTZB-0000nc-TP;
        Fri, 15 Jul 2022 22:13:45 +0000
Date:   Sat, 16 Jul 2022 06:12:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:mld] BUILD SUCCESS
 cbee535ba539e8e13ca2c15c8624545e5214f599
Message-ID: <62d1e663.iZ6FzsyeMCh0r/+E%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld
branch HEAD: cbee535ba539e8e13ca2c15c8624545e5214f599  wifi: mac80211: support MLO authentication/association with one link

elapsed time: 726m

configs tested: 52
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a006
arc                  randconfig-r043-20220715
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r045-20220715
hexagon              randconfig-r041-20220715
s390                 randconfig-r044-20220715
riscv                randconfig-r042-20220715

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

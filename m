Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1705BD79F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 00:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiISWuO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 18:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiISWuM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 18:50:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1482C108
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 15:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663627811; x=1695163811;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uIToWLgGPtgu+c6O2rU0OpOyE/ufGNv/63ntvW25A2o=;
  b=hfBwcQUBxWYzh32lTA1Aq6R2BRY/P7C+jMcHi2uZ8sdn2+OR1lP6WeO4
   SRLPQj7gf2BsFCCCcwJ4UlFJTHbhnig4g907Nod9tu4H3Dbjjx/T+zhSu
   eyBk/UPWO3X8zDLylpAnpP5HStb+2U7tv3vARj4kmAaaDU4gpg1myEr8N
   g9Ubz8H/dJTZ4VUWlkHfTXuTW1a4u5HxYXH+wsvYuo6O0jzWKBsleucPd
   2jNR2M/7Z3+M7+l1jW8xOraKrlRyOXmmaH1ACG5QJweq3Xg74cESE2nJ9
   /WsTi/BYLrpoA7XDP3EtmcEPqOB0KeYPDnV+plk0tPn9HaXgQEOpBorJN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="279269715"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="279269715"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 15:50:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="569836831"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Sep 2022 15:50:09 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaPab-0002HC-0o;
        Mon, 19 Sep 2022 22:50:09 +0000
Date:   Tue, 20 Sep 2022 06:49:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 4c3140f4cea66b06e4a982e0c2f7b7d113040b26
Message-ID: <6328f1fe.wE40c51DVOrakKTP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 4c3140f4cea66b06e4a982e0c2f7b7d113040b26  wifi: rtw89: uninitialized variable on error in rtw89_early_fw_feature_recognize()

elapsed time: 726m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                           x86_64_defconfig
um                             i386_defconfig
s390                                defconfig
x86_64                              defconfig
s390                             allmodconfig
x86_64               randconfig-a015-20220919
x86_64               randconfig-a014-20220919
x86_64               randconfig-a012-20220919
i386                                defconfig
s390                             allyesconfig
sh                               allmodconfig
arc                  randconfig-r043-20220919
x86_64               randconfig-a016-20220919
x86_64               randconfig-a011-20220919
s390                 randconfig-r044-20220919
x86_64               randconfig-a013-20220919
x86_64                               rhel-8.3
riscv                randconfig-r042-20220919
powerpc                           allnoconfig
x86_64                           rhel-8.3-kvm
i386                 randconfig-a013-20220919
mips                             allyesconfig
x86_64                           allyesconfig
powerpc                          allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
m68k                             allmodconfig
x86_64                          rhel-8.3-func
i386                             allyesconfig
i386                 randconfig-a012-20220919
x86_64                         rhel-8.3-kunit
arm                                 defconfig
i386                 randconfig-a014-20220919
arc                              allyesconfig
i386                 randconfig-a011-20220919
i386                 randconfig-a016-20220919
alpha                            allyesconfig
i386                 randconfig-a015-20220919
m68k                             allyesconfig
ia64                             allmodconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
hexagon              randconfig-r041-20220919
hexagon              randconfig-r045-20220919
i386                 randconfig-a001-20220919
x86_64               randconfig-a003-20220919
i386                 randconfig-a002-20220919
i386                 randconfig-a003-20220919
x86_64               randconfig-a001-20220919
i386                 randconfig-a004-20220919
i386                 randconfig-a005-20220919
x86_64               randconfig-a002-20220919
i386                 randconfig-a006-20220919
x86_64               randconfig-a004-20220919
x86_64               randconfig-a006-20220919
x86_64               randconfig-a005-20220919

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

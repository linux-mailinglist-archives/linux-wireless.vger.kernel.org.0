Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F091F5ECC31
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 20:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiI0Sfz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Sep 2022 14:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiI0Sfx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Sep 2022 14:35:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAD218B4BE
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 11:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664303752; x=1695839752;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nESJKA7upE+gJjkSiGuLXcDD3g5CMfCTCF/Km4L3qfE=;
  b=mQ1EJJJQTw4Gvbpu2bGbtsIoEyQ3DmHDDgLsDCpo5uQd3qqSDqIjOIKw
   ALVtfaGE/66w29J2EleuZe3eZ+bS/15VWk7AGPZTvzll9dmDtRY9UDNNa
   e36VULMDo74PLSwE6FDGRoJL27c5XjQpFdUzykeQnfNcqe7ZBoWdvHv/S
   7dnFPxIXIs+G60geqi03SIlqdlkza68jLjnUz3vIMEeF7KvfFdWPP+FvJ
   GCvte7O0oUYO1lKzVi8ojmJbKabHejIDIGTCesBhJFe/27m6zDMoJrcUj
   45eQ2B0fwjB0eE9tCVGjS7kA7Iwu1gLO5CTKSv0mr2sjRjw3NzmNrli0T
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="302878074"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="302878074"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 11:35:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="621623661"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="621623661"
Received: from lkp-server02.sh.intel.com (HELO dfa2c9fcd321) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 27 Sep 2022 11:35:50 -0700
Received: from kbuild by dfa2c9fcd321 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1odFQr-0001Sk-2V;
        Tue, 27 Sep 2022 18:35:49 +0000
Date:   Wed, 28 Sep 2022 02:35:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 6cf5e9066dd3332cf4c77ea95a116f70e7f9acf7
Message-ID: <63334277.H54keBTCRSz2cP+t%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 6cf5e9066dd3332cf4c77ea95a116f70e7f9acf7  Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

elapsed time: 723m

configs tested: 75
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
alpha                               defconfig
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
arc                                 defconfig
sh                               allmodconfig
m68k                             allyesconfig
s390                 randconfig-r044-20220925
x86_64                              defconfig
s390                             allmodconfig
x86_64                               rhel-8.3
arm                                 defconfig
s390                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
arc                  randconfig-r043-20220925
x86_64                        randconfig-a015
x86_64                           allyesconfig
x86_64                        randconfig-a013
riscv                randconfig-r042-20220925
x86_64                        randconfig-a011
arc                  randconfig-r043-20220926
i386                                defconfig
x86_64               randconfig-a001-20220926
i386                 randconfig-a001-20220926
i386                 randconfig-a002-20220926
i386                          randconfig-a005
i386                 randconfig-a003-20220926
s390                             allyesconfig
i386                 randconfig-a004-20220926
powerpc                          allmodconfig
x86_64               randconfig-a003-20220926
i386                 randconfig-a005-20220926
x86_64               randconfig-a006-20220926
x86_64               randconfig-a002-20220926
alpha                            allyesconfig
i386                 randconfig-a006-20220926
mips                             allyesconfig
x86_64               randconfig-a004-20220926
x86_64               randconfig-a005-20220926
arc                              allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
m68k                             allmodconfig
i386                             allyesconfig
ia64                             allmodconfig

clang tested configs:
s390                 randconfig-r044-20220926
i386                 randconfig-a011-20220926
i386                          randconfig-a002
x86_64                        randconfig-a014
hexagon              randconfig-r045-20220925
i386                 randconfig-a013-20220926
hexagon              randconfig-r041-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a015-20220926
hexagon              randconfig-r045-20220926
i386                 randconfig-a014-20220926
hexagon              randconfig-r041-20220925
i386                 randconfig-a016-20220926
x86_64                        randconfig-a012
riscv                randconfig-r042-20220926
x86_64                        randconfig-a016
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a014-20220926
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a012-20220926
x86_64               randconfig-a016-20220926
x86_64               randconfig-a015-20220926

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3F95A75DE
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Aug 2022 07:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiHaFoB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Aug 2022 01:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiHaFn7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Aug 2022 01:43:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB2ABA174
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 22:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661924638; x=1693460638;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UjkBKH7/DGB90BtSIHLrOQJ8HoJm8zQN7tXVZTkmOpw=;
  b=IvuMiEN78ddo2F05cf7J8uZqB4LDEHttdSdxbGqMjYjryke7o43axIFL
   JthndUq96SqfV/htYBoWN4t2oRG+ZFw0IWfkuC9I5uLwHuHtYstysslDC
   kKNeaYo3ezWZm7rQroEVhHK3j7eIbjCw1GwthIoM8o19zwe3MrkMi1l3O
   thzkSzJF1nYLsPjssFQI7z8pPn9NNOSBzPpClvNZDWJbRwibOiORQokeV
   nevHk0gJDRkaSixjFzGVVnBP8ezOERQ5XliXcgLAxEZePOrXlbxEek0KX
   lss3ilKQWcgX+lmImPQl/y+6CcHxmNCv4bBmgWqvdu/p11y8Kt02dBGsF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="321515954"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="321515954"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 22:43:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="641716495"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 30 Aug 2022 22:43:56 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTGW4-00012h-0s;
        Wed, 31 Aug 2022 05:43:56 +0000
Date:   Wed, 31 Aug 2022 13:43:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 8d40a13bc35da6c68f3beb44d7d4b21ea247366d
Message-ID: <630ef4fe.b78hp0X1Ro1lWi7J%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 8d40a13bc35da6c68f3beb44d7d4b21ea247366d  Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

elapsed time: 731m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                  randconfig-r043-20220830
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
m68k                             allyesconfig
sh                               allmodconfig
m68k                             allmodconfig
i386                          randconfig-a001
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                                defconfig
x86_64                              defconfig
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a014
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a013
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                           rhel-8.3-kvm
i386                             allyesconfig
arm                                 defconfig
ia64                             allmodconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r045-20220830
hexagon              randconfig-r041-20220830
riscv                randconfig-r042-20220830
s390                 randconfig-r044-20220830
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

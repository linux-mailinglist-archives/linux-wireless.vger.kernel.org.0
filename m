Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11ED868F984
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Feb 2023 22:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjBHVNW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Feb 2023 16:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjBHVNS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Feb 2023 16:13:18 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27C12E810
        for <linux-wireless@vger.kernel.org>; Wed,  8 Feb 2023 13:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675890796; x=1707426796;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pOEuDpWlgzZ/WX8nclWYujrV3SbmQpdROd4nAlGhKX8=;
  b=Et9TsZgRRNeSltSeueljxJgziiN91/1PMCUgA2OZzS8/yTHW7Q0fDJp1
   6ziiL8CQsne4X9rp+z94trZsJCD1Et5eGT/5ixGeTAXP3mNTiB84mbX1x
   NCVvqs1MqN17K12Cix9uC7IxmX4Q1S21ThC99tZqNRQ1d937i52QUEuIz
   EaIDKgE+47VXxE0cB1yDeKTtIW9CxEeZpqiPiPd1Km+N4vhoTOGim9+Rn
   iUxcCXZF1V0QtIYIO+TfWTDsofHn7j4FAM0A6c5yIoeq7FQluYt3P1OU9
   39AGbuHjnsV9kmsp6o/Kn2qIpf/x/1TYYU2z3ZHwiZmqdoNObGfIceF7K
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="357326757"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="357326757"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 13:13:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776201973"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="776201973"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 Feb 2023 13:13:15 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPrkg-0004ec-1T;
        Wed, 08 Feb 2023 21:13:14 +0000
Date:   Thu, 09 Feb 2023 05:12:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:pending] BUILD SUCCESS
 c8888b8cb5006166897dc21bbe9b1aac2f633718
Message-ID: <63e41055.SMKlM/FaDsnhmPs2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: c8888b8cb5006166897dc21bbe9b1aac2f633718  Merge tag 'mt76-for-kvalo-2023-02-03' of https://github.com/nbd168/wireless into pending

elapsed time: 725m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
alpha                               defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
um                             i386_defconfig
x86_64                           rhel-8.3-bpf
sh                               allmodconfig
x86_64               randconfig-a013-20230206
i386                                defconfig
s390                                defconfig
x86_64               randconfig-a011-20230206
x86_64                           rhel-8.3-syz
x86_64               randconfig-a012-20230206
x86_64                         rhel-8.3-kunit
s390                             allmodconfig
x86_64               randconfig-a014-20230206
x86_64               randconfig-a015-20230206
x86_64                           rhel-8.3-kvm
mips                             allyesconfig
m68k                             allyesconfig
powerpc                          allmodconfig
x86_64                              defconfig
m68k                             allmodconfig
x86_64                           allyesconfig
x86_64               randconfig-a016-20230206
arc                              allyesconfig
x86_64                        randconfig-a002
x86_64                               rhel-8.3
i386                 randconfig-a011-20230206
ia64                             allmodconfig
alpha                            allyesconfig
s390                             allyesconfig
x86_64                        randconfig-a006
i386                 randconfig-a014-20230206
i386                 randconfig-a012-20230206
x86_64                        randconfig-a004
i386                 randconfig-a016-20230206
i386                 randconfig-a013-20230206
i386                 randconfig-a015-20230206
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arc                  randconfig-r043-20230205
arm                  randconfig-r046-20230205
arc                  randconfig-r043-20230206
riscv                randconfig-r042-20230206
s390                 randconfig-r044-20230206
i386                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
i386                 randconfig-a002-20230206
i386                 randconfig-a003-20230206
i386                 randconfig-a001-20230206
x86_64                        randconfig-a001
i386                 randconfig-a006-20230206
hexagon              randconfig-r041-20230205
i386                 randconfig-a005-20230206
x86_64                        randconfig-a003
riscv                randconfig-r042-20230205
i386                 randconfig-a004-20230206
x86_64                        randconfig-a005
hexagon              randconfig-r045-20230206
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230206
arm                  randconfig-r046-20230206
hexagon              randconfig-r045-20230205
s390                 randconfig-r044-20230205

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

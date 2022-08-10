Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F1958F27F
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Aug 2022 20:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiHJSoG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Aug 2022 14:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiHJSoF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Aug 2022 14:44:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74463321
        for <linux-wireless@vger.kernel.org>; Wed, 10 Aug 2022 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660157044; x=1691693044;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zcln0WiQAxFNfztCUwLjKn4J0OrQmv2afjh33wPVzpk=;
  b=nYTUShnARB9X2sbyd1KyV6Tc68MwlV2wFTt5ccPhRtVJnK3xDX375pVu
   oFJg/pzfrlCrQqxa1jaf+F/UdzPJX2kr0M8kibkH7kV+6ZaQfRftJ7T02
   LO36TYrFlSI4qJBcVaU1hX4TASvv1Sn26LnYeCheieQ9jKmiByULNL2aU
   UsMlEA5i2O8+WWkQznOYa/VEn31m0gT1e7XRBwbccoh2GsOBWbJ1qExV+
   HEvOtd4Au5OePKaGv084C202RHIH7skquMX8u1gr+fHbhyNysDLTZ0QoE
   Z5g3RPp+xxVHz8CYIWqOyEl/7sERAM4KabjY7Hl+QkUBg/D/RzbWjjIhE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="291954776"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="291954776"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 11:44:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="555837847"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Aug 2022 11:44:02 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLqgU-0000bz-0J;
        Wed, 10 Aug 2022 18:44:02 +0000
Date:   Thu, 11 Aug 2022 02:43:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 7dad3e39fde1eef97bc1a0b92e5d0f3500c9ed56
Message-ID: <62f3fc5c.EsvDTRk/1AEf53vw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 7dad3e39fde1eef97bc1a0b92e5d0f3500c9ed56  wifi: rtw88: prohibit enter IPS during HW scan

elapsed time: 718m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
i386                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
m68k                             allyesconfig
x86_64                              defconfig
x86_64                        randconfig-a013
x86_64                               rhel-8.3
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                           allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
i386                          randconfig-a014
x86_64                        randconfig-a006
i386                          randconfig-a012
i386                          randconfig-a016
arm                                 defconfig
arc                  randconfig-r043-20220810
arm                              allyesconfig
riscv                randconfig-r042-20220810
arm64                            allyesconfig
s390                 randconfig-r044-20220810
i386                          randconfig-a001
i386                          randconfig-a003
ia64                             allmodconfig
i386                          randconfig-a005
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a001
i386                          randconfig-a013
x86_64                        randconfig-a003
i386                          randconfig-a011
x86_64                        randconfig-a005
i386                          randconfig-a015
hexagon              randconfig-r041-20220810
hexagon              randconfig-r045-20220810
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

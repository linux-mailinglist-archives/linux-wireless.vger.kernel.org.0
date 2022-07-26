Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE71580AB4
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jul 2022 07:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiGZFRq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jul 2022 01:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiGZFRo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Jul 2022 01:17:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A237222B4
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jul 2022 22:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658812664; x=1690348664;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3n+0zOfkYQ3f3Gb08kboN3ct7rT1VnhV+NwoR0R0r2s=;
  b=J3uI4tPWzmVgvJ/rvYNI6yg0/sVEspxDLB+Ax+6662SMi0SGTkmE/ZiL
   +3/rzSqR5lMJtVeIOA8KEixb+TO+2HYsaD+u1sbEVZpCFkcppht/h6I4z
   XIFfUzz+4y2hlTvwZ78q6u5H4CgBAaeNrFcO9b9epxRTn0mnMK8/+eMM+
   +W2bteDnHn+CaN5jH5UUFT9daNJminmjIC32q+0hbdFeqafdHWOCMT43N
   HZZE119tpS21jTFgeEZfoD1VBpTdHNimhhHxjYYAD7+BzOX7UB8sSJUY8
   OcrzR+OfbvvsC6fLEdJKpVitHJZRqps4plrV+KGoWrEwTVQ7tfhgsp/lB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="349562366"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="349562366"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 22:17:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="550261758"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Jul 2022 22:17:42 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGCwv-00065M-29;
        Tue, 26 Jul 2022 05:17:41 +0000
Date:   Tue, 26 Jul 2022 13:17:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 9fab4cc8c3450df15c9bcaedd0d3c954211a7a54
Message-ID: <62df78da.ctOgI+TrhpWP+0nU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 9fab4cc8c3450df15c9bcaedd0d3c954211a7a54  Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

elapsed time: 723m

configs tested: 57
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
mips                             allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
i386                                defconfig
i386                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a016
i386                          randconfig-a012
arc                  randconfig-r043-20220724
s390                 randconfig-r044-20220724
riscv                randconfig-r042-20220724
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a013
hexagon              randconfig-r041-20220724
hexagon              randconfig-r045-20220724

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

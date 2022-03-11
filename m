Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682F54D571C
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Mar 2022 02:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345245AbiCKBFQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 20:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241697AbiCKBFM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 20:05:12 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E07CCD5F1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 17:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646960651; x=1678496651;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eAw8SIZTqG6+yEwU1nNsZsM74jWkHsDdJ5BLqJNZAC4=;
  b=dqM+7nHHV/L3jQu2l+ywAxPvm0gZM4Ziid3oUpHTl1cAP5iaVC4BZlrT
   UBvD9waD/+k41ZgdhQgbEUv2kV1gcLOrwHZC67cBF90+uVoxIP9mNYum6
   rU3lkkmNIsEk7liecMsSdYo/pMklZ/4Fk4mnOSbsR5suWfm06TTi4SQQe
   YwtkF5gFJtBYSMovQj5T8t0OrQ7sBo2y7JgHHb3s7MVgopNVZ3j0Og7V5
   CKjcfBxwW1ukoryKEuDgjqDerMR9o5qxPBbw9ysz1Jc7ZUAott/lmrBqf
   bOXl2WOgMSNXDrjCxLG6FBWeQ2369NPxoGFFEJ10pWLTpI8PzQ3UH+eEz
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255194648"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="255194648"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 17:02:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="514274170"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Mar 2022 17:02:10 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSTfW-0005bO-6v; Fri, 11 Mar 2022 01:02:10 +0000
Date:   Fri, 11 Mar 2022 09:01:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:pending] BUILD SUCCESS
 fe56b16e432f94aeb519a12108efd9e158483f12
Message-ID: <622a9f7e.cInUFuZgOYZvFxiI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: fe56b16e432f94aeb519a12108efd9e158483f12  Merge tag 'iwlwifi-next-for-kalle-2022-03-10' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next into pending

elapsed time: 723m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
sh                             sh03_defconfig
powerpc                     ep8248e_defconfig
mips                  maltasmvp_eva_defconfig
xtensa                          iss_defconfig
arm                      jornada720_defconfig
arm                             rpc_defconfig
sh                          sdk7780_defconfig
openrisc                  or1klitex_defconfig
arm                         vf610m4_defconfig
mips                       capcella_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                          lpd270_defconfig
sh                           se7206_defconfig
mips                         db1xxx_defconfig
sh                               allmodconfig
h8300                    h8300h-sim_defconfig
arm                         s3c6400_defconfig
arm                        keystone_defconfig
powerpc                     tqm8548_defconfig
sh                            shmin_defconfig
ia64                                defconfig
arm                  randconfig-c002-20220310
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                  randconfig-r043-20220310
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
powerpc                     tqm8540_defconfig
mips                       lemote2f_defconfig
x86_64                           allyesconfig
powerpc                      pmac32_defconfig
mips                           rs90_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220310
hexagon              randconfig-r045-20220310
s390                 randconfig-r044-20220310
riscv                randconfig-r042-20220310
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

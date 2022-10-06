Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23EA5F60ED
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Oct 2022 08:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJFGQ5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Oct 2022 02:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiJFGQz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Oct 2022 02:16:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162B752E5F
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 23:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665037015; x=1696573015;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zIj0nDrLeO0ho3awfmCMNCXV0n7ptzUvbJ2LRupjnLg=;
  b=TmdGxGCyyuCiFi/JWfwInxC7zbqvLRgkVtNsphvAdl0pldcolornrz+z
   gddyyXYjJBxt/sVCsQxcDKGtH53iKG7Ryyupe/Z2RiOIV5KDN/756jLPv
   bDIRqYSUqB35f4S+zFRhd4lc5PPajZeXfNY5rF62azaD1MYNcny+fMcVU
   rX0m2vOf40mJ8mCeXSB/0knNEOVZHZnTG6oOCUL+bEx9BCn0az+8lG7CH
   +2OEWDrQE+SuWrtcwBd/QS3itUZH3hNORA88Zj8Vr9DLqu9OJUT6r3QL1
   wagRJooNPZySkSMOSKdzHjX6JKHi4hL44ztqe9iChyA2P62dBCv31XwBd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="389646219"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="389646219"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 23:16:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="953490982"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="953490982"
Received: from lkp-server01.sh.intel.com (HELO d4f44333118a) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 Oct 2022 23:16:53 -0700
Received: from kbuild by d4f44333118a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ogKBg-00021Y-25;
        Thu, 06 Oct 2022 06:16:52 +0000
Date:   Thu, 06 Oct 2022 14:16:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:mld] BUILD SUCCESS
 5be9cc94f50d844e006f947dda9f178080eadd6a
Message-ID: <633e72c9.UGcJ4q9Em93oocPK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld
branch HEAD: 5be9cc94f50d844e006f947dda9f178080eadd6a  wifi: mac80211: fix ifdef symbol name

elapsed time: 727m

configs tested: 104
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
x86_64                          rhel-8.3-func
s390                             allmodconfig
x86_64                    rhel-8.3-kselftests
s390                                defconfig
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
mips                             allyesconfig
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
x86_64                               rhel-8.3
alpha                            allyesconfig
s390                             allyesconfig
arc                              allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
powerpc                          allmodconfig
x86_64                           allyesconfig
i386                                defconfig
i386                 randconfig-a014-20221003
arm                                 defconfig
i386                 randconfig-a011-20221003
i386                 randconfig-a012-20221003
i386                 randconfig-a013-20221003
i386                 randconfig-a015-20221003
i386                 randconfig-a016-20221003
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
x86_64               randconfig-a011-20221003
x86_64               randconfig-a014-20221003
x86_64               randconfig-a012-20221003
x86_64               randconfig-a013-20221003
x86_64               randconfig-a016-20221003
x86_64               randconfig-a015-20221003
ia64                             allmodconfig
riscv                randconfig-r042-20221003
arc                  randconfig-r043-20221003
arc                  randconfig-r043-20221002
s390                 randconfig-r044-20221003
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                          randconfig-c001
arc                        nsim_700_defconfig
sh                          r7780mp_defconfig
xtensa                              defconfig
powerpc                     taishan_defconfig
powerpc                       eiger_defconfig
loongarch                        alldefconfig
powerpc                 mpc85xx_cds_defconfig
parisc                generic-64bit_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arc                           tb10x_defconfig
um                               alldefconfig
mips                         bigsur_defconfig
m68k                             allmodconfig
arm                  randconfig-c002-20221002
x86_64                        randconfig-c001
m68k                          atari_defconfig
sh                      rts7751r2d1_defconfig
mips                           xway_defconfig
powerpc                    klondike_defconfig
powerpc                         wii_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                       omap2plus_defconfig
arm                     eseries_pxa_defconfig
mips                         cobalt_defconfig
openrisc                            defconfig
nios2                            alldefconfig

clang tested configs:
i386                 randconfig-a004-20221003
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a006-20221003
x86_64               randconfig-a003-20221003
x86_64               randconfig-a005-20221003
hexagon              randconfig-r041-20221003
riscv                randconfig-r042-20221002
x86_64               randconfig-a002-20221003
x86_64               randconfig-a001-20221003
hexagon              randconfig-r041-20221002
x86_64               randconfig-a004-20221003
x86_64               randconfig-a006-20221003
s390                 randconfig-r044-20221002
hexagon              randconfig-r045-20221002
powerpc                    mvme5100_defconfig
powerpc                     ppa8548_defconfig
hexagon              randconfig-r045-20221003
arm                          sp7021_defconfig
arm                        magician_defconfig
x86_64                        randconfig-k001
i386                             allyesconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

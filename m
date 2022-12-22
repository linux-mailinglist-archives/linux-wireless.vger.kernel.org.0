Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45AB653C5B
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Dec 2022 08:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiLVHBL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Dec 2022 02:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiLVHBK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Dec 2022 02:01:10 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E143C21259
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 23:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671692469; x=1703228469;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Rj/W/FA828kuV+Un2VOf1WSqjEHnhCEUVbCiecO0Byw=;
  b=OQmi4qE3xJG7GwXaxdGv3sEz0AIW3exdLmadvrNTkp4hxQabEKfWAilW
   zpSS53oUc8gE3H0wBTX5M/DwTQTcJMuUQPTUZJ51ybJRwkpNVNjW95vcM
   W4P6/qz0QmUP0eXMOcz970yOrRgV/rI3fKC9hvr4YEMnuyflzyfaADZXh
   o1ZVakTLZJFZwSDiJ+4fVcA0M7CYyQOzJaejMSwh+U2wy//fkX4PvhuHP
   5JQOHO+U9NKA3VrfK0hJ/covRniyuXrqz0VdpYkkXHrlQw7k4+MokPJSX
   Wd6H59fD3OjkZTbv6OAJPAG2EtX7tdjEZhUECxrQcqQXB+N7ntb13c+fp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="384411112"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="384411112"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 23:01:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="980477879"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="980477879"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Dec 2022 23:01:07 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p8FZi-000BL6-1G;
        Thu, 22 Dec 2022 07:01:06 +0000
Date:   Thu, 22 Dec 2022 15:00:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 c6015bf3ff1ffb3caa27eb913797438a0fc634a0
Message-ID: <63a40083.p+mb1+CAMiJUxknc%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: c6015bf3ff1ffb3caa27eb913797438a0fc634a0  wifi: rtl8xxxu: fixing transmisison failure for rtl8192eu

elapsed time: 723m

configs tested: 102
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
um                           x86_64_defconfig
um                             i386_defconfig
s390                             allyesconfig
ia64                             allmodconfig
x86_64                            allnoconfig
i386                 randconfig-a001-20221219
i386                 randconfig-a003-20221219
i386                 randconfig-a002-20221219
i386                 randconfig-a004-20221219
i386                 randconfig-a005-20221219
i386                 randconfig-a006-20221219
i386                             allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-bpf
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-syz
arc                              allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64               randconfig-a006-20221219
x86_64               randconfig-a002-20221219
x86_64               randconfig-a005-20221219
x86_64               randconfig-a003-20221219
x86_64               randconfig-a001-20221219
x86_64               randconfig-a004-20221219
powerpc                  iss476-smp_defconfig
sh                           sh2007_defconfig
powerpc                 linkstation_defconfig
m68k                        m5307c3_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arm                             pxa_defconfig
sh                            shmin_defconfig
arc                    vdk_hs38_smp_defconfig
arm                             ezx_defconfig
parisc64                            defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
s390                 randconfig-r044-20221218
arm                  randconfig-r046-20221219
arc                  randconfig-r043-20221218
arc                  randconfig-r043-20221219
riscv                randconfig-r042-20221218
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
i386                          randconfig-c001
m68k                         apollo_defconfig
arm                           viper_defconfig
sparc                               defconfig
sh                          sdk7786_defconfig
nios2                         3c120_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                        multi_v7_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                       eiger_defconfig
xtensa                              defconfig
m68k                                defconfig
m68k                            mac_defconfig

clang tested configs:
x86_64                        randconfig-k001
i386                 randconfig-a013-20221219
i386                 randconfig-a014-20221219
i386                 randconfig-a015-20221219
i386                 randconfig-a011-20221219
i386                 randconfig-a016-20221219
i386                 randconfig-a012-20221219
powerpc                 mpc832x_rdb_defconfig
mips                        maltaup_defconfig
powerpc                     ksi8560_defconfig
x86_64               randconfig-a015-20221219
x86_64               randconfig-a013-20221219
x86_64               randconfig-a012-20221219
x86_64               randconfig-a016-20221219
x86_64               randconfig-a014-20221219
x86_64               randconfig-a011-20221219
x86_64                          rhel-8.3-rust
x86_64               randconfig-k001-20221219
s390                 randconfig-r044-20221221
riscv                randconfig-r042-20221221
hexagon              randconfig-r045-20221221
hexagon              randconfig-r041-20221221

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

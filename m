Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCECF5B649F
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Sep 2022 02:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiIMAnl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Sep 2022 20:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIMAnk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Sep 2022 20:43:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73CE5007E
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 17:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663029819; x=1694565819;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0iVMdILEFLjPV8GdCF1vrOXrDe6ZlR5gIHm7ALqKrK4=;
  b=hahPNVfn3WX64ArOYAuGAGe08WfU5T497indHt0QdT+bVTZvMxIcSh0H
   R9h6t/wY+NMMljxCc9q82mnhDON1wWNhd8pYlRmNjsTIuzjDppMQ0Dh9p
   81PpOLHSKsqQObvq1RDIU7EvoVfC9KziFLuDAOqcEYNtzuf3NpPujYATg
   Vmw8StfkSKUlPRvxbW9uLxLGea2r4VzLawqLOOSQON45BjP6/SoBSAzZm
   JwOD+GoRVZsPAvOuWCZ6S0+CSPhvkbu4An4LIci/t74VkHm3jq5nCh78+
   T1wkV2X/53WWgG0gUg3UarYpickTQ1fvB9MsSi6/KomssRFqSJ5sE+zXi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="359730402"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="359730402"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 17:43:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="758590470"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Sep 2022 17:43:38 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXu1Z-00032B-1H;
        Tue, 13 Sep 2022 00:43:37 +0000
Date:   Tue, 13 Sep 2022 08:42:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 781b80f452fcc1cfc16ee41f12556626a9ced049
Message-ID: <631fd20d.aP1GsdOqsH4KKnj8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 781b80f452fcc1cfc16ee41f12556626a9ced049  wifi: mt76: fix 5 GHz connection regression on mt76x0/mt76x2

elapsed time: 727m

configs tested: 88
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
m68k                             allyesconfig
powerpc                           allnoconfig
x86_64                              defconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
sh                               allmodconfig
x86_64                          rhel-8.3-func
i386                 randconfig-a001-20220912
mips                             allyesconfig
arc                  randconfig-r043-20220912
i386                 randconfig-a002-20220912
x86_64                         rhel-8.3-kunit
powerpc                          allmodconfig
i386                 randconfig-a004-20220912
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a003-20220912
i386                 randconfig-a005-20220912
arc                  randconfig-r043-20220911
x86_64                           rhel-8.3-syz
i386                 randconfig-a006-20220912
alpha                            allyesconfig
x86_64                               rhel-8.3
s390                 randconfig-r044-20220911
m68k                             allmodconfig
arc                              allyesconfig
riscv                randconfig-r042-20220911
arm                                 defconfig
i386                             allyesconfig
x86_64                           allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
x86_64               randconfig-a001-20220912
x86_64               randconfig-a006-20220912
x86_64               randconfig-a004-20220912
x86_64               randconfig-a002-20220912
x86_64               randconfig-a003-20220912
x86_64               randconfig-a005-20220912
ia64                             allmodconfig
sparc                             allnoconfig
ia64                             alldefconfig
sh                          kfr2r09_defconfig
m68k                         amcore_defconfig
csky                                defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                   secureedge5410_defconfig
arm                         s3c6400_defconfig
powerpc                      pasemi_defconfig
i386                          randconfig-c001
loongarch                           defconfig
loongarch                         allnoconfig
arm                             rpc_defconfig
sh                           se7343_defconfig
sh                            hp6xx_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                             shx3_defconfig
powerpc                 linkstation_defconfig
sh                      rts7751r2d1_defconfig
arm                          pxa910_defconfig
arm                            qcom_defconfig

clang tested configs:
riscv                randconfig-r042-20220912
i386                 randconfig-a013-20220912
i386                 randconfig-a011-20220912
i386                 randconfig-a012-20220912
hexagon              randconfig-r041-20220912
i386                 randconfig-a014-20220912
hexagon              randconfig-r045-20220911
hexagon              randconfig-r045-20220912
i386                 randconfig-a015-20220912
hexagon              randconfig-r041-20220911
i386                 randconfig-a016-20220912
s390                 randconfig-r044-20220912
x86_64               randconfig-a016-20220912
x86_64               randconfig-a012-20220912
x86_64               randconfig-a013-20220912
x86_64               randconfig-a014-20220912
x86_64               randconfig-a011-20220912
x86_64               randconfig-a015-20220912
x86_64                        randconfig-k001
arm                         s3c2410_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

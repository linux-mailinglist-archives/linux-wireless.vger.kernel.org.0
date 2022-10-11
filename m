Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B675FAD1C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 08:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiJKG5C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 02:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiJKG44 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 02:56:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BC38285A
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 23:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665471414; x=1697007414;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+wWFM9DODROtfENDFLI6egNzdiNsN+kxDCFOeK/u+C0=;
  b=HsLt7UcgPJxkJH/t+GXygkhg5xO7ebDP45ZgJo5DwisAMYkUrlqNKRM3
   1aS2PJkdxuLVX6mTbwJOYNwwSpBwERKzQQNdnloFL/e/6VFz9ietmxy/W
   SMo0awbeYmNnYAtWsDK2JGgyxrFaggWAJMsfLeeWQyPPOFOX+u8LiELi5
   FgsS5qgez6VXsoef+/AwWJoGGpXFSC89J0pEF5T8NxyrFeI5bJQ07JN1A
   LEWZJDi750JrAy8HL6YyH0ajc4j5wBLmXX+rE3Jyeglqwt40wEqbYN69f
   Xxkh0cXbWWO/rCcTA5t0iLrLM62gVApy6984fgi3S4ts1dfr3A/RhOKPM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="330900996"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="330900996"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 23:56:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="604028602"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="604028602"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 10 Oct 2022 23:56:53 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oi9C8-0002ah-1G;
        Tue, 11 Oct 2022 06:56:52 +0000
Date:   Tue, 11 Oct 2022 14:55:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:main] BUILD SUCCESS
 53d0ce0c56d9330f137936b8850d4a5f2f70907d
Message-ID: <6345137f.A2ny9TVbNABzf7a2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 53d0ce0c56d9330f137936b8850d4a5f2f70907d  wifi: realtek: remove duplicated wake_tx_queue

elapsed time: 728m

configs tested: 95
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
s390                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
powerpc                           allnoconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a011-20221010
x86_64                               rhel-8.3
i386                                defconfig
x86_64               randconfig-a014-20221010
x86_64               randconfig-a015-20221010
i386                 randconfig-a012-20221010
arc                  randconfig-r043-20221010
i386                 randconfig-a011-20221010
x86_64               randconfig-a012-20221010
m68k                             allyesconfig
riscv                randconfig-r042-20221010
sh                               allmodconfig
alpha                            allyesconfig
x86_64               randconfig-a013-20221010
mips                             allyesconfig
m68k                             allmodconfig
s390                 randconfig-r044-20221010
i386                 randconfig-a013-20221010
x86_64               randconfig-a016-20221010
i386                 randconfig-a015-20221010
powerpc                          allmodconfig
arc                              allyesconfig
i386                 randconfig-a014-20221010
arm                                 defconfig
i386                 randconfig-a016-20221010
x86_64                           allyesconfig
arm                              allyesconfig
i386                             allyesconfig
arm64                            allyesconfig
i386                 randconfig-c001-20221010
m68k                        m5407c3_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                     pq2fads_defconfig
powerpc                   currituck_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
ia64                             allmodconfig
sh                           se7206_defconfig
sh                        edosk7760_defconfig
arm                      integrator_defconfig
sh                           se7750_defconfig
sh                             shx3_defconfig
mips                      maltasmvp_defconfig
ia64                          tiger_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                     asp8347_defconfig
m68k                        stmark2_defconfig
arm                        trizeps4_defconfig
arm                           stm32_defconfig
arm                            pleb_defconfig
arm                         s3c6400_defconfig
arm                         lubbock_defconfig
m68k                        m5272c3_defconfig
x86_64               randconfig-k001-20221010
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                      mgcoge_defconfig
parisc64                            defconfig

clang tested configs:
i386                 randconfig-a003-20221010
i386                 randconfig-a004-20221010
i386                 randconfig-a002-20221010
hexagon              randconfig-r045-20221010
i386                 randconfig-a005-20221010
i386                 randconfig-a001-20221010
hexagon              randconfig-r041-20221010
i386                 randconfig-a006-20221010
x86_64               randconfig-a004-20221010
x86_64               randconfig-a002-20221010
x86_64               randconfig-a001-20221010
x86_64               randconfig-a003-20221010
x86_64               randconfig-a006-20221010
x86_64               randconfig-a005-20221010
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

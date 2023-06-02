Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9198471FA32
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 08:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjFBGiV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 02:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjFBGiU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 02:38:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D099128
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 23:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685687899; x=1717223899;
  h=date:from:to:cc:subject:message-id;
  bh=YB9C2k4T9M7yXde9eQHzsQ+7S0BnjsoIWSpT+L5nwMM=;
  b=JxeHyKqHhqY4uNFixdj4EYpHNvt7QphfYOr4Agn9g+CDxgKfaTJKWXh2
   HzhZ2SqFy29vATr7AKzQpGtDhv/D05eKUf3XZZl82VcdkaF9Tz1Hle6Ue
   972aQzMQKxTNj0riWYi9lJnSpQ0hy45vGjsD3hszb/ZpsbsSECzCdz8A0
   vtZUPw/Jp177BBOpELWs6VWvovl5dVSE2gIzxgG/hDjER6EmO1nNieSsM
   sSMR3m+Lmza8N6s9S/RClZWGSPwseIzrJD/SY7fWg8UjFDWOz1TkLaoQa
   uT/YqrhqnwNEbEU7UEHm9BlUq1j0Y6UErtYP+8mXWB0VvEb/NFmbN/0Wj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="340417380"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="340417380"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 23:38:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="777525272"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="777525272"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 01 Jun 2023 23:38:15 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4yQR-0000Ba-0t;
        Fri, 02 Jun 2023 06:38:15 +0000
Date:   Fri, 02 Jun 2023 14:37:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 ead449023d3acb1424886d7b8cc672ed69bdd27e
Message-ID: <20230602063759.SfmSn%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: ead449023d3acb1424886d7b8cc672ed69bdd27e  wifi: mt76: mt7996: fix possible NULL pointer dereference in mt7996_mac_write_txwi()

elapsed time: 723m

configs tested: 117
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r004-20230602   gcc  
alpha        buildonly-randconfig-r005-20230531   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r024-20230531   gcc  
alpha                randconfig-r025-20230531   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230531   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230602   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230602   clang
arm                  randconfig-r026-20230531   gcc  
arm                  randconfig-r046-20230531   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230602   clang
csky         buildonly-randconfig-r002-20230531   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230602   gcc  
hexagon              randconfig-r032-20230531   clang
hexagon              randconfig-r041-20230531   clang
hexagon              randconfig-r045-20230531   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r001-20230531   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230531   gcc  
i386                 randconfig-i002-20230531   gcc  
i386                 randconfig-i003-20230531   gcc  
i386                 randconfig-i004-20230531   gcc  
i386                 randconfig-i005-20230531   gcc  
i386                 randconfig-i006-20230531   gcc  
i386                 randconfig-i051-20230602   gcc  
i386                 randconfig-i052-20230602   gcc  
i386                 randconfig-i053-20230602   gcc  
i386                 randconfig-i054-20230602   gcc  
i386                 randconfig-i055-20230602   gcc  
i386                 randconfig-i056-20230602   gcc  
i386                 randconfig-i061-20230531   gcc  
i386                 randconfig-i062-20230531   gcc  
i386                 randconfig-i063-20230531   gcc  
i386                 randconfig-i064-20230531   gcc  
i386                 randconfig-i065-20230531   gcc  
i386                 randconfig-i066-20230531   gcc  
i386                 randconfig-r004-20230602   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230602   gcc  
loongarch            randconfig-r021-20230531   gcc  
loongarch            randconfig-r036-20230531   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r004-20230531   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r015-20230531   gcc  
m68k                 randconfig-r034-20230531   gcc  
microblaze           randconfig-r014-20230531   gcc  
microblaze           randconfig-r022-20230531   gcc  
microblaze           randconfig-r024-20230531   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230602   clang
mips                 randconfig-r012-20230602   gcc  
mips                 randconfig-r022-20230531   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230602   gcc  
openrisc             randconfig-r002-20230602   gcc  
openrisc             randconfig-r011-20230531   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r032-20230531   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r023-20230531   clang
riscv                randconfig-r031-20230531   gcc  
riscv                randconfig-r042-20230531   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r033-20230531   gcc  
s390                 randconfig-r044-20230531   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r002-20230602   gcc  
sh                   randconfig-r004-20230602   gcc  
sh                   randconfig-r034-20230531   gcc  
sh                   randconfig-r035-20230531   gcc  
sparc        buildonly-randconfig-r003-20230602   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230602   gcc  
sparc                randconfig-r006-20230602   gcc  
sparc                randconfig-r011-20230602   gcc  
sparc64              randconfig-r015-20230602   gcc  
sparc64              randconfig-r033-20230531   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r003-20230531   gcc  
x86_64       buildonly-randconfig-r006-20230602   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230531   gcc  
x86_64               randconfig-a002-20230531   gcc  
x86_64               randconfig-a003-20230531   gcc  
x86_64               randconfig-a004-20230531   gcc  
x86_64               randconfig-a005-20230531   gcc  
x86_64               randconfig-a006-20230531   gcc  
x86_64               randconfig-r001-20230602   gcc  
x86_64               randconfig-r031-20230531   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r016-20230531   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13806D1B58
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 11:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjCaJHf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 05:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjCaJHJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 05:07:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948921EFD6
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 02:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680253609; x=1711789609;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+ZmTWCBvOLEMN3y2EwBeoNfjavvclKBrbwNTE/VYaJc=;
  b=TLKpMuX+DDzJphRg4zeDLebYweFcAmzMfvUBRfWMjtEfWMJiXm7cJcBh
   FlTuiw8xwqUuPkIPFwt7oHyZ2mUMDqZDOiYo8531xzyGySP3qgMN7DF2c
   176hEq+YPZuEbksM5z5d3xvr5LQILN6hOKX6aRlOzwm9HaP9A3o1bAgUR
   +2j/RIVYOV7t7isAEFo+AZGHnxEHGMj5gCY6dFhmAC8SwAfOAW6IO+cJx
   inf8DBw3dKodSPg7HuEp96qpu1UEd2BO3MC9uy4csRcufvOS1JwLvWIaD
   /YX2s3z0+mOqDy64fMIHn1F8+lJD6QMBlN7rIxVrlclm9kjqGaYw3YmWF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="427683184"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="427683184"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 02:05:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="715385339"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="715385339"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 31 Mar 2023 02:05:30 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piAhN-000Ld8-28;
        Fri, 31 Mar 2023 09:05:29 +0000
Date:   Fri, 31 Mar 2023 17:05:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:main] BUILD SUCCESS
 aa2aa818cd1198cfa2498116d57cd9f13fea80e4
Message-ID: <6426a245.xFhIC1ng708M37zd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: aa2aa818cd1198cfa2498116d57cd9f13fea80e4  wifi: clean up erroneously introduced file

elapsed time: 726m

configs tested: 110
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r036-20230329   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230329   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r015-20230329   gcc  
arc                  randconfig-r033-20230329   gcc  
arc                  randconfig-r043-20230329   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r006-20230329   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r001-20230329   clang
arm                  randconfig-r003-20230329   clang
arm                  randconfig-r024-20230329   gcc  
arm                  randconfig-r034-20230329   clang
arm                  randconfig-r035-20230329   clang
arm                  randconfig-r046-20230329   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230329   clang
csky                                defconfig   gcc  
csky                 randconfig-r015-20230329   gcc  
csky                 randconfig-r026-20230329   gcc  
csky                 randconfig-r034-20230329   gcc  
hexagon              randconfig-r016-20230329   clang
hexagon              randconfig-r041-20230329   clang
hexagon              randconfig-r045-20230329   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r003-20230329   gcc  
ia64         buildonly-randconfig-r005-20230329   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r005-20230329   gcc  
ia64                 randconfig-r033-20230329   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230330   gcc  
loongarch            randconfig-r005-20230330   gcc  
loongarch            randconfig-r006-20230329   gcc  
loongarch            randconfig-r023-20230329   gcc  
loongarch            randconfig-r025-20230329   gcc  
loongarch            randconfig-r026-20230329   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230330   gcc  
m68k                 randconfig-r004-20230329   gcc  
microblaze           randconfig-r024-20230329   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r036-20230329   clang
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230330   gcc  
nios2                randconfig-r031-20230329   gcc  
openrisc     buildonly-randconfig-r001-20230329   gcc  
openrisc             randconfig-r006-20230330   gcc  
parisc       buildonly-randconfig-r005-20230329   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230330   gcc  
parisc               randconfig-r006-20230329   gcc  
parisc               randconfig-r021-20230329   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r011-20230329   clang
powerpc              randconfig-r032-20230329   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230329   clang
riscv                randconfig-r021-20230329   clang
riscv                randconfig-r022-20230329   clang
riscv                randconfig-r032-20230329   gcc  
riscv                randconfig-r035-20230329   gcc  
riscv                randconfig-r042-20230329   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230329   gcc  
s390                 randconfig-r012-20230329   clang
s390                 randconfig-r023-20230329   clang
s390                 randconfig-r044-20230329   clang
sh                               allmodconfig   gcc  
sparc        buildonly-randconfig-r003-20230329   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230329   gcc  
sparc                randconfig-r016-20230329   gcc  
sparc64      buildonly-randconfig-r004-20230329   gcc  
sparc64              randconfig-r002-20230329   gcc  
sparc64              randconfig-r014-20230329   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230329   gcc  
xtensa               randconfig-r014-20230329   gcc  
xtensa               randconfig-r025-20230329   gcc  
xtensa               randconfig-r031-20230329   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

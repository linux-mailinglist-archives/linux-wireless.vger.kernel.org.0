Return-Path: <linux-wireless+bounces-713-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A99580F595
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 19:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73E01F21696
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 18:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5384922076;
	Tue, 12 Dec 2023 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tl3oyNlR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033D4DB
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 10:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702406149; x=1733942149;
  h=date:from:to:cc:subject:message-id;
  bh=0OY2EA1uQwr7f4HBkNVBcTEG2Cz4L8IbctPmsir9FW0=;
  b=Tl3oyNlROqI7BVML7FqRCEc8O9XWPXvAih63rH5ApwH5PbHzUzuUHoMv
   mp4eSSV56AehCe7MotFJSbqQk7n6pBGX30919ucGVxDbI8NSmssShKKFe
   OhY+6QLQ7NKX7ydtj7e2zwObalKkBTzAufh98kRWqYg3kyEUEhHOQugaF
   cLXGE1YFQmCqP4u25nvUAbUTVlrOvfdrrTl3i5EI7rFZd+qlLzBSbD8OP
   gfvxft5HMi1x7qoejFQ4bSn0+lBuNbDeqUzAuGndLM6RFv0/5iFucm8LC
   abadndSF7kXZ/cPKPBzBue1GaP4CVL3+5/LG6poTjUBL1IvVR2uJ3Zo6n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="459169619"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="459169619"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 10:35:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="844005373"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="844005373"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2023 10:35:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rD7bc-000JYn-2M;
	Tue, 12 Dec 2023 18:35:44 +0000
Date: Wed, 13 Dec 2023 02:34:53 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:pending] BUILD SUCCESS
 197e1b5a15b1a5544d063155d7fea2fe847ed56d
Message-ID: <202312130250.asQdExs1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: 197e1b5a15b1a5544d063155d7fea2fe847ed56d  Merge tag 'mt76-for-kvalo-2023-12-06' of https://github.com/nbd168/wireless into pending

elapsed time: 1473m

configs tested: 194
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20231212   gcc  
arc                   randconfig-002-20231212   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                         orion5x_defconfig   clang
arm                   randconfig-001-20231212   gcc  
arm                   randconfig-002-20231212   gcc  
arm                   randconfig-003-20231212   gcc  
arm                   randconfig-004-20231212   gcc  
arm                        realview_defconfig   gcc  
arm                           sama7_defconfig   clang
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231212   gcc  
arm64                 randconfig-002-20231212   gcc  
arm64                 randconfig-003-20231212   gcc  
arm64                 randconfig-004-20231212   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231212   gcc  
csky                  randconfig-002-20231212   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231212   clang
hexagon               randconfig-002-20231212   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231212   gcc  
i386         buildonly-randconfig-002-20231212   gcc  
i386         buildonly-randconfig-003-20231212   gcc  
i386         buildonly-randconfig-004-20231212   gcc  
i386         buildonly-randconfig-005-20231212   gcc  
i386         buildonly-randconfig-006-20231212   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231212   gcc  
i386                  randconfig-002-20231212   gcc  
i386                  randconfig-003-20231212   gcc  
i386                  randconfig-004-20231212   gcc  
i386                  randconfig-005-20231212   gcc  
i386                  randconfig-006-20231212   gcc  
i386                  randconfig-011-20231212   clang
i386                  randconfig-012-20231212   clang
i386                  randconfig-013-20231212   clang
i386                  randconfig-014-20231212   clang
i386                  randconfig-015-20231212   clang
i386                  randconfig-016-20231212   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231212   gcc  
loongarch             randconfig-002-20231212   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                         rt305x_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231212   gcc  
nios2                 randconfig-002-20231212   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231212   gcc  
parisc                randconfig-002-20231212   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    gamecube_defconfig   clang
powerpc                 linkstation_defconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   clang
powerpc                    mvme5100_defconfig   clang
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20231212   gcc  
powerpc               randconfig-002-20231212   gcc  
powerpc               randconfig-003-20231212   gcc  
powerpc64             randconfig-001-20231212   gcc  
powerpc64             randconfig-002-20231212   gcc  
powerpc64             randconfig-003-20231212   gcc  
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231212   gcc  
riscv                 randconfig-002-20231212   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231212   clang
s390                  randconfig-002-20231212   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                    randconfig-001-20231212   gcc  
sh                    randconfig-002-20231212   gcc  
sh                          rsk7269_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231212   gcc  
sparc64               randconfig-002-20231212   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231212   gcc  
um                    randconfig-002-20231212   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231212   gcc  
x86_64       buildonly-randconfig-002-20231212   gcc  
x86_64       buildonly-randconfig-003-20231212   gcc  
x86_64       buildonly-randconfig-004-20231212   gcc  
x86_64       buildonly-randconfig-005-20231212   gcc  
x86_64       buildonly-randconfig-006-20231212   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231212   clang
x86_64                randconfig-002-20231212   clang
x86_64                randconfig-003-20231212   clang
x86_64                randconfig-004-20231212   clang
x86_64                randconfig-005-20231212   clang
x86_64                randconfig-006-20231212   clang
x86_64                randconfig-011-20231212   gcc  
x86_64                randconfig-012-20231212   gcc  
x86_64                randconfig-013-20231212   gcc  
x86_64                randconfig-014-20231212   gcc  
x86_64                randconfig-015-20231212   gcc  
x86_64                randconfig-016-20231212   gcc  
x86_64                randconfig-071-20231212   gcc  
x86_64                randconfig-072-20231212   gcc  
x86_64                randconfig-073-20231212   gcc  
x86_64                randconfig-074-20231212   gcc  
x86_64                randconfig-075-20231212   gcc  
x86_64                randconfig-076-20231212   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20231212   gcc  
xtensa                randconfig-002-20231212   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


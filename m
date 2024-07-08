Return-Path: <linux-wireless+bounces-10085-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 550C392AC6E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 01:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA83E1F21D8B
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 23:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D476B15217A;
	Mon,  8 Jul 2024 23:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fLRMHD6W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169F814F9D9
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jul 2024 23:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720480297; cv=none; b=Kd9UsdHbQCf31hotdN5Q9/uj7q2asCD70eb96djKL4ojdJAygUo7porMD8S4cSeG3Ns4xlg1GlYARc+Q+c90ZCQx4emrJOOsoIS1YeOA7bkwgKBvnegD/0xZ7viriFS5Qn0pEKwnqEg/RhobtM7rsKqFWsz5RGBr1RKjRFDo6h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720480297; c=relaxed/simple;
	bh=Q0ZtHRZm1/jSoSAoO6GVBRLnMzPreLH7+GKCT5XGfzk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jCxAkc9i1jytsnxXOvm4ihluiJmdE1DO/sHrrZx4Vs0tVFU6EQqiJtNRmUOc6jblTCV+fqYv7BqPcGoA3Dp5VO4nzsE7/w7o71DHTpx0PxYaWwDzWrrNOO70jq2T0pCohC9lArLceCQaF8Lq+vAsHIaot3g1kYpuKJd0iosN/ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fLRMHD6W; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720480296; x=1752016296;
  h=date:from:to:cc:subject:message-id;
  bh=Q0ZtHRZm1/jSoSAoO6GVBRLnMzPreLH7+GKCT5XGfzk=;
  b=fLRMHD6WXxcvQBWEzheH7vry0Xveq+owP0wLNDHM5Y23B1RoXPV2j9rV
   ygTyW1XH4t1T6DZTPcrk7nl1Irqbytm/GQ2rDHnMODS9JG83ioerzEeqJ
   BRI6obSC+8to5PGimXKeFr9mxn81ghfpEDsdQmw18x7lf9zpZ9d3vJIUH
   gWbVx/8zFc5pjlZTvvJLNa2Jt1LQKd+YFITQVWfanVULSaNf8+7ODjkEL
   02fFsNRMxG1633725L2vKgb4twWikbemtWCfICH8Mr21/uzrKxqBMsBDE
   mqetwzJEMGwLhN7Pc3ZDwkEsW88CTJtAF6LT/pg+dvnVE8mebRrBeOi8b
   Q==;
X-CSE-ConnectionGUID: FJqdURgWToW0FokaXBg+6g==
X-CSE-MsgGUID: PVj7YXssTB2Qm5S2O/uFAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17343947"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="17343947"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 16:11:35 -0700
X-CSE-ConnectionGUID: gfj34AQ8QtKEq+iPK9W+ug==
X-CSE-MsgGUID: oWGm9f2MSkybKbGJuiSgcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="52459484"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 08 Jul 2024 16:11:34 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQxW7-000W7I-2P;
	Mon, 08 Jul 2024 23:11:31 +0000
Date: Tue, 09 Jul 2024 07:10:47 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:pending] BUILD SUCCESS
 58c590423297c93b9f7964379c556c2db9a2277a
Message-ID: <202407090745.n6DQGVT7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: 58c590423297c93b9f7964379c556c2db9a2277a  Merge tag 'mt76-for-kvalo-2024-07-08' of https://github.com/nbd168/wireless into pending

elapsed time: 724m

configs tested: 126
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240708   gcc-13.2.0
arc                   randconfig-002-20240708   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                              allyesconfig   gcc-13.2.0
arm                         mv78xx0_defconfig   clang-19
arm                   randconfig-001-20240708   gcc-13.2.0
arm                   randconfig-002-20240708   gcc-13.2.0
arm                   randconfig-003-20240708   clang-16
arm                   randconfig-004-20240708   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                 randconfig-001-20240708   gcc-13.2.0
arm64                 randconfig-002-20240708   clang-19
arm64                 randconfig-003-20240708   gcc-13.2.0
arm64                 randconfig-004-20240708   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                  randconfig-001-20240708   gcc-13.2.0
csky                  randconfig-002-20240708   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon               randconfig-001-20240708   clang-19
hexagon               randconfig-002-20240708   clang-19
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240708   clang-18
i386         buildonly-randconfig-002-20240708   gcc-13
i386         buildonly-randconfig-003-20240708   clang-18
i386         buildonly-randconfig-004-20240708   clang-18
i386         buildonly-randconfig-005-20240708   clang-18
i386         buildonly-randconfig-006-20240708   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240708   clang-18
i386                  randconfig-002-20240708   clang-18
i386                  randconfig-003-20240708   gcc-13
i386                  randconfig-004-20240708   clang-18
i386                  randconfig-005-20240708   clang-18
i386                  randconfig-006-20240708   clang-18
i386                  randconfig-011-20240708   gcc-13
i386                  randconfig-012-20240708   gcc-9
i386                  randconfig-013-20240708   gcc-13
i386                  randconfig-014-20240708   clang-18
i386                  randconfig-015-20240708   clang-18
i386                  randconfig-016-20240708   clang-18
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch             randconfig-001-20240708   gcc-13.2.0
loongarch             randconfig-002-20240708   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                       m5208evb_defconfig   gcc-13.2.0
m68k                          multi_defconfig   gcc-13.2.0
m68k                        mvme16x_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                       bmips_be_defconfig   gcc-13.2.0
mips                           ci20_defconfig   clang-19
mips                           ip32_defconfig   clang-19
nios2                         10m50_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                 randconfig-001-20240708   gcc-13.2.0
nios2                 randconfig-002-20240708   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240708   gcc-13.2.0
parisc                randconfig-002-20240708   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc               randconfig-001-20240708   gcc-13.2.0
powerpc               randconfig-002-20240708   clang-19
powerpc               randconfig-003-20240708   gcc-13.2.0
powerpc64             randconfig-001-20240708   gcc-13.2.0
powerpc64             randconfig-002-20240708   gcc-13.2.0
powerpc64             randconfig-003-20240708   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240708   gcc-13.2.0
riscv                 randconfig-002-20240708   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240708   clang-19
s390                  randconfig-002-20240708   clang-19
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240708   gcc-13.2.0
sh                    randconfig-002-20240708   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240708   gcc-13.2.0
sparc64               randconfig-002-20240708   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240708   gcc-13
um                    randconfig-002-20240708   gcc-10
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-002-20240708   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


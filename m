Return-Path: <linux-wireless+bounces-19853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FC9A546F8
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0127C1632D3
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 09:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA0020AF69;
	Thu,  6 Mar 2025 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RaYnV8HZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA7C20ADD6
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255023; cv=none; b=WQA553fR2p3qU5BL+Vt52A9ipj7kFaeaX3AJQRaj/yKRlhiWJ+Knp1OoGnOba5dFY1JefkiVQWuXYBr9/RMzMA1Da3hNb2igbQTavPPoh6aaHBvybYC6JYDeBhDfwDN7w8ifnlyxYE9bDgH0kr2aJdT8x+7+k6oNOgX3C+H+y1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255023; c=relaxed/simple;
	bh=REPl9doMRWDhQ8daNcEmrNoVS+i6GN0RPVI7sqF1WLE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LD4hBlfkrML0NGqdtg5YN92mNVWcxPJrfuqq7+vdEf2dG3za8jF9EcvK9Pn+PT6a7LGOLo2L8kq9izlwdHnGe94PDmujAUGm3DBJv7PZ8Gt780/3sc84xyHzGGjBdkrnNS0TKHAaA/m+RPa7eQfcA397cz9SXc0uqMDtVwMJhcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RaYnV8HZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741255022; x=1772791022;
  h=date:from:to:cc:subject:message-id;
  bh=REPl9doMRWDhQ8daNcEmrNoVS+i6GN0RPVI7sqF1WLE=;
  b=RaYnV8HZvZJzLfbIdIeTLUyglcYylGPXzUq5FVQXAu/NpBQYaRUqqj+x
   WB6OVfVqliSwRdLvg9+SVjnQtr+4ZZ59TE5j9B1ZsTfbOO0hShDVkjkZG
   6hl60eZiQULjhN2ZcUz5TVSDyOTWksDYl44F7s9LNKcoGMKWTKZjnXPVx
   IkkcOBmLOMuU+XmExiJibVA+g4OqcKdhSPTW4950W7+i1eeGy6pn28roF
   9RZ+BxwSDbF32sRWJfnzOrPXz9ct/VJcsOjreM1S9cFpqX6MLD/Y4TL1v
   mrkYRXJQzWce7ZXB7TrnBr1WjGZnADTktB0vWKmiMF9d6YXpVyhj8tAYD
   A==;
X-CSE-ConnectionGUID: iEyw63Q5Tbe5+EpmRhr6sA==
X-CSE-MsgGUID: a8RfO3EzRzGSEvy1DaDdQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42170368"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="42170368"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 01:57:01 -0800
X-CSE-ConnectionGUID: 0e2GwTFGSs6Q414e7Rfncg==
X-CSE-MsgGUID: 0K61O4svQ7e2/5Yxrb2sjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="142201632"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 06 Mar 2025 01:57:00 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tq7yL-000Msl-2S;
	Thu, 06 Mar 2025 09:56:57 +0000
Date: Thu, 06 Mar 2025 17:56:27 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:iwlmld] BUILD SUCCESS
 d1e879ec600f9b3bdd253167533959facfefb17b
Message-ID: <202503061721.SAD24UUb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git iwlmld
branch HEAD: d1e879ec600f9b3bdd253167533959facfefb17b  wifi: iwlwifi: add iwlmld sub-driver

elapsed time: 1468m

configs tested: 235
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                     haps_hs_smp_defconfig    clang-21
arc                   randconfig-001-20250305    gcc-13.2.0
arc                   randconfig-001-20250306    gcc-14.2.0
arc                   randconfig-002-20250305    gcc-13.2.0
arc                   randconfig-002-20250306    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                         at91_dt_defconfig    clang-21
arm                                 defconfig    gcc-14.2.0
arm                   randconfig-001-20250305    gcc-14.2.0
arm                   randconfig-001-20250306    gcc-14.2.0
arm                   randconfig-002-20250305    clang-19
arm                   randconfig-002-20250306    gcc-14.2.0
arm                   randconfig-003-20250305    gcc-14.2.0
arm                   randconfig-003-20250306    gcc-14.2.0
arm                   randconfig-004-20250305    gcc-14.2.0
arm                   randconfig-004-20250306    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250305    clang-15
arm64                 randconfig-001-20250306    gcc-14.2.0
arm64                 randconfig-002-20250305    gcc-14.2.0
arm64                 randconfig-002-20250306    gcc-14.2.0
arm64                 randconfig-003-20250305    clang-21
arm64                 randconfig-003-20250306    gcc-14.2.0
arm64                 randconfig-004-20250305    gcc-14.2.0
arm64                 randconfig-004-20250306    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250305    gcc-14.2.0
csky                  randconfig-001-20250306    gcc-14.2.0
csky                  randconfig-002-20250305    gcc-14.2.0
csky                  randconfig-002-20250306    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250305    clang-21
hexagon               randconfig-001-20250306    gcc-14.2.0
hexagon               randconfig-002-20250305    clang-18
hexagon               randconfig-002-20250306    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250305    clang-19
i386        buildonly-randconfig-001-20250306    gcc-12
i386        buildonly-randconfig-002-20250305    clang-19
i386        buildonly-randconfig-002-20250306    gcc-12
i386        buildonly-randconfig-003-20250305    clang-19
i386        buildonly-randconfig-003-20250306    gcc-12
i386        buildonly-randconfig-004-20250305    clang-19
i386        buildonly-randconfig-004-20250306    gcc-12
i386        buildonly-randconfig-005-20250305    clang-19
i386        buildonly-randconfig-005-20250306    gcc-12
i386        buildonly-randconfig-006-20250305    gcc-12
i386        buildonly-randconfig-006-20250306    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250306    clang-19
i386                  randconfig-002-20250306    clang-19
i386                  randconfig-003-20250306    clang-19
i386                  randconfig-004-20250306    clang-19
i386                  randconfig-005-20250306    clang-19
i386                  randconfig-006-20250306    clang-19
i386                  randconfig-007-20250306    clang-19
i386                  randconfig-011-20250306    gcc-12
i386                  randconfig-012-20250306    gcc-12
i386                  randconfig-013-20250306    gcc-12
i386                  randconfig-014-20250306    gcc-12
i386                  randconfig-015-20250306    gcc-12
i386                  randconfig-016-20250306    gcc-12
i386                  randconfig-017-20250306    gcc-12
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250305    gcc-14.2.0
loongarch             randconfig-001-20250306    gcc-14.2.0
loongarch             randconfig-002-20250305    gcc-14.2.0
loongarch             randconfig-002-20250306    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          rb532_defconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250305    gcc-14.2.0
nios2                 randconfig-001-20250306    gcc-14.2.0
nios2                 randconfig-002-20250305    gcc-14.2.0
nios2                 randconfig-002-20250306    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                       virt_defconfig    clang-21
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250305    gcc-14.2.0
parisc                randconfig-001-20250306    gcc-14.2.0
parisc                randconfig-002-20250305    gcc-14.2.0
parisc                randconfig-002-20250306    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      chrp32_defconfig    gcc-14.2.0
powerpc                     ep8248e_defconfig    clang-21
powerpc                        fsp2_defconfig    gcc-14.2.0
powerpc                 mpc8315_rdb_defconfig    gcc-14.2.0
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250305    clang-17
powerpc               randconfig-001-20250306    gcc-14.2.0
powerpc               randconfig-002-20250305    gcc-14.2.0
powerpc               randconfig-002-20250306    gcc-14.2.0
powerpc               randconfig-003-20250305    gcc-14.2.0
powerpc               randconfig-003-20250306    gcc-14.2.0
powerpc                    socrates_defconfig    clang-21
powerpc64             randconfig-001-20250305    clang-19
powerpc64             randconfig-001-20250306    gcc-14.2.0
powerpc64             randconfig-002-20250305    clang-17
powerpc64             randconfig-002-20250306    gcc-14.2.0
powerpc64             randconfig-003-20250305    clang-19
powerpc64             randconfig-003-20250306    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250305    clang-19
riscv                 randconfig-001-20250306    gcc-14.2.0
riscv                 randconfig-002-20250305    gcc-14.2.0
riscv                 randconfig-002-20250306    gcc-14.2.0
s390                             alldefconfig    clang-21
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250305    gcc-14.2.0
s390                  randconfig-001-20250306    gcc-14.2.0
s390                  randconfig-002-20250305    gcc-14.2.0
s390                  randconfig-002-20250306    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250305    gcc-14.2.0
sh                    randconfig-001-20250306    gcc-14.2.0
sh                    randconfig-002-20250305    gcc-14.2.0
sh                    randconfig-002-20250306    gcc-14.2.0
sh                   sh7724_generic_defconfig    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250305    gcc-14.2.0
sparc                 randconfig-001-20250306    gcc-14.2.0
sparc                 randconfig-002-20250305    gcc-14.2.0
sparc                 randconfig-002-20250306    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250305    gcc-14.2.0
sparc64               randconfig-001-20250306    gcc-14.2.0
sparc64               randconfig-002-20250305    gcc-14.2.0
sparc64               randconfig-002-20250306    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250305    clang-19
um                    randconfig-001-20250306    gcc-14.2.0
um                    randconfig-002-20250305    gcc-12
um                    randconfig-002-20250306    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250305    clang-19
x86_64      buildonly-randconfig-001-20250306    clang-19
x86_64      buildonly-randconfig-002-20250305    gcc-12
x86_64      buildonly-randconfig-002-20250306    clang-19
x86_64      buildonly-randconfig-003-20250305    clang-19
x86_64      buildonly-randconfig-003-20250306    clang-19
x86_64      buildonly-randconfig-004-20250305    gcc-12
x86_64      buildonly-randconfig-004-20250306    clang-19
x86_64      buildonly-randconfig-005-20250305    clang-19
x86_64      buildonly-randconfig-005-20250306    clang-19
x86_64      buildonly-randconfig-006-20250305    clang-19
x86_64      buildonly-randconfig-006-20250306    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250306    clang-19
x86_64                randconfig-002-20250306    clang-19
x86_64                randconfig-003-20250306    clang-19
x86_64                randconfig-004-20250306    clang-19
x86_64                randconfig-005-20250306    clang-19
x86_64                randconfig-006-20250306    clang-19
x86_64                randconfig-007-20250306    clang-19
x86_64                randconfig-008-20250306    clang-19
x86_64                randconfig-071-20250306    clang-19
x86_64                randconfig-072-20250306    clang-19
x86_64                randconfig-073-20250306    clang-19
x86_64                randconfig-074-20250306    clang-19
x86_64                randconfig-075-20250306    clang-19
x86_64                randconfig-076-20250306    clang-19
x86_64                randconfig-077-20250306    clang-19
x86_64                randconfig-078-20250306    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250305    gcc-14.2.0
xtensa                randconfig-001-20250306    gcc-14.2.0
xtensa                randconfig-002-20250305    gcc-14.2.0
xtensa                randconfig-002-20250306    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


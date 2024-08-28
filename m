Return-Path: <linux-wireless+bounces-12115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0AD961F07
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 08:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5908AB21557
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 06:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA4F1BC3F;
	Wed, 28 Aug 2024 06:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFTXnWiO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B0713DB9F
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 06:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825143; cv=none; b=R9aHjZgq9XQds0ovgMz8lxylr/Rqujw1GZJ5yRjiyBQSFzjC24lvRURyY4OvEMTUi30Ed0wHT7bdQ0Bu4+zAwdSOQBw6a1pT7C64xJMda9jc/3gh0hBlVMJokwryoGB90NrVoYHeIicdOJl11d9q0qJ3gvo/blcDzjZQhL02id8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825143; c=relaxed/simple;
	bh=XUTxTY66b3VSNYgxd1S6Q+W9jhvnvSBxFeIIsJrFung=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MbUzhIf2QfSFL0D09aJ68vZnwGrfX6oHEWRykQIgweRmTkIT0uKjcC+IVzSRRORj6+kNFFevCNqsFKt4CLqrdQCIk8XXU70fmNtaL5ypV3K+PlMwImnrDXhRjR1z0KEUCjHUFKRQuDdpgJ8dYYw27JY4PGSw2h9ZXxkWAJoo+T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFTXnWiO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724825142; x=1756361142;
  h=date:from:to:cc:subject:message-id;
  bh=XUTxTY66b3VSNYgxd1S6Q+W9jhvnvSBxFeIIsJrFung=;
  b=FFTXnWiON3H9E4kqDn0oxbRtbb6VryJ1K7Y3lEePFYVSFvSpVYJuQA9D
   jMTvD0zVNw79DixBCyKYOwn0o+p2xpeqYMVwnjBp8iHngByj6A+2XBnzS
   KvblNNmH2Oj3UmfPvZee9yvsKXRpDs8AqZWltOpFA5dR3vGWEh45YkFxH
   +lh73mGtB4JxtDSA/WhQTGBRNwvDBSz8AqWvTpYU/wyPP7bT2GKC1vyan
   jzozU6j71qo239pwAq6+0EKo60VxoYLYQvaO3hRck1gCl0ydgpvKWLjfI
   GVW3wgr4G3cVvhbwIK6ogM2LVrpOUQYQDtObWTRWbJYMYW0V8Su6fiULj
   Q==;
X-CSE-ConnectionGUID: kBEM5OzIR/KqFiVhNagEBg==
X-CSE-MsgGUID: Kug3x5Z1QF+BdMGxx34+kA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="45854112"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="45854112"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 23:05:41 -0700
X-CSE-ConnectionGUID: FX/BlcUYSaCNiZvhAb1sHA==
X-CSE-MsgGUID: j78L/KkQThSB9Ccw75Tm1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="67265722"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 27 Aug 2024 23:05:40 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjBoI-000KXD-0Y;
	Wed, 28 Aug 2024 06:05:38 +0000
Date: Wed, 28 Aug 2024 14:04:52 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 d07e1f5c745058d1805e7d8042b9a326b120cb6e
Message-ID: <202408281450.L65dZWnS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: d07e1f5c745058d1805e7d8042b9a326b120cb6e  wifi: mac80211: use kmemdup_array instead of kmemdup for multiple allocation

elapsed time: 1213m

configs tested: 143
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240828   gcc-13.2.0
arc                   randconfig-002-20240828   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240828   gcc-14.1.0
arm                   randconfig-002-20240828   clang-20
arm                   randconfig-003-20240828   gcc-14.1.0
arm                   randconfig-004-20240828   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240828   clang-17
arm64                 randconfig-002-20240828   clang-20
arm64                 randconfig-003-20240828   clang-15
arm64                 randconfig-004-20240828   clang-15
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240828   gcc-14.1.0
csky                  randconfig-002-20240828   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240828   clang-20
hexagon               randconfig-002-20240828   clang-16
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240828   gcc-12
i386         buildonly-randconfig-002-20240828   clang-18
i386         buildonly-randconfig-003-20240828   clang-18
i386         buildonly-randconfig-004-20240828   gcc-12
i386         buildonly-randconfig-005-20240828   gcc-12
i386         buildonly-randconfig-006-20240828   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240828   clang-18
i386                  randconfig-002-20240828   gcc-12
i386                  randconfig-003-20240828   clang-18
i386                  randconfig-004-20240828   clang-18
i386                  randconfig-005-20240828   clang-18
i386                  randconfig-006-20240828   gcc-12
i386                  randconfig-011-20240828   gcc-12
i386                  randconfig-012-20240828   gcc-12
i386                  randconfig-013-20240828   clang-18
i386                  randconfig-014-20240828   gcc-11
i386                  randconfig-015-20240828   gcc-12
i386                  randconfig-016-20240828   gcc-11
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240828   gcc-14.1.0
loongarch             randconfig-002-20240828   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240828   gcc-14.1.0
nios2                 randconfig-002-20240828   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240828   gcc-14.1.0
parisc                randconfig-002-20240828   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc               randconfig-001-20240828   clang-20
powerpc               randconfig-002-20240828   clang-20
powerpc               randconfig-003-20240828   gcc-14.1.0
powerpc64             randconfig-001-20240828   gcc-14.1.0
powerpc64             randconfig-002-20240828   gcc-14.1.0
powerpc64             randconfig-003-20240828   clang-20
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240828   gcc-14.1.0
riscv                 randconfig-002-20240828   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240828   gcc-14.1.0
s390                  randconfig-002-20240828   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240828   gcc-14.1.0
sh                    randconfig-002-20240828   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240828   gcc-14.1.0
sparc64               randconfig-002-20240828   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240828   clang-15
um                    randconfig-002-20240828   clang-20
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240828   clang-18
x86_64       buildonly-randconfig-002-20240828   clang-18
x86_64       buildonly-randconfig-003-20240828   gcc-12
x86_64       buildonly-randconfig-004-20240828   clang-18
x86_64       buildonly-randconfig-005-20240828   gcc-11
x86_64       buildonly-randconfig-006-20240828   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240828   gcc-12
x86_64                randconfig-002-20240828   clang-18
x86_64                randconfig-003-20240828   gcc-12
x86_64                randconfig-004-20240828   clang-18
x86_64                randconfig-005-20240828   clang-18
x86_64                randconfig-006-20240828   gcc-12
x86_64                randconfig-011-20240828   clang-18
x86_64                randconfig-012-20240828   clang-18
x86_64                randconfig-013-20240828   clang-18
x86_64                randconfig-014-20240828   clang-18
x86_64                randconfig-015-20240828   gcc-12
x86_64                randconfig-016-20240828   gcc-12
x86_64                randconfig-071-20240828   gcc-12
x86_64                randconfig-072-20240828   gcc-12
x86_64                randconfig-073-20240828   gcc-12
x86_64                randconfig-074-20240828   gcc-12
x86_64                randconfig-075-20240828   gcc-12
x86_64                randconfig-076-20240828   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240828   gcc-14.1.0
xtensa                randconfig-002-20240828   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


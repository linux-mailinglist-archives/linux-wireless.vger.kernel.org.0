Return-Path: <linux-wireless+bounces-14231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621399A4A14
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2024 01:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABA40B216AF
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 23:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5D5189F58;
	Fri, 18 Oct 2024 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlsVKAZW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D509F18E758
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729294212; cv=none; b=tzBZE9LyeB+kYKgPaUoDtTSM+ytwgM/H5IlxCLHmHDWR6zYndacCGi8+T/oJACpKOzY7B6G9ba2RusNO8lgrnZcuGSr/W50227MY/wSFp2E28fl5ko5z/wc0OjBB84wNTkXJ8fyRIbi/BTMXjJqqZtEoZCFWB676ID5dsjUIqpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729294212; c=relaxed/simple;
	bh=69cn4VL0TwIWIUYxxqh5SEuOA5IFjv84GYnyFOB4mIk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dBB72x4AK1yM/tYXTKgZ93UbvnxcGzXm0R1QHAC5QvOuZGsayZiydMwn40OXpO5N1yDB/xohxJKbl5JoBkuQS37KjbAFLjdwCBMjDYdqsIMwTcUi1Fpoe6n7MDGO7bDCJ6vFTIs1sW8t/urRpHy/fca0AXTm6ClahOCBfWBSnJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BlsVKAZW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729294209; x=1760830209;
  h=date:from:to:cc:subject:message-id;
  bh=69cn4VL0TwIWIUYxxqh5SEuOA5IFjv84GYnyFOB4mIk=;
  b=BlsVKAZWL8VwDQDXZxYwHFwSVOMQf51nZ7NcM0TqF0CZ1T8A6xyYNdId
   wit76v/wogToEtjOHoZKNh93g1Oa+9IqecQNnlNcwyaKCQF7ZfpPrzrZE
   LS2LoP+pDIVAbNfJS+ZrUEkJzO0GLxeAUwcj+sS9y/CLgjGR9vOZk+XsN
   G0Oe6r6gDm+EsAxnWm+99D2CmRgTolxue6PvcPpGMK8HJyMY6Cjvl1ahQ
   jiBujany8aODv1TBprw1fnYDYYURmmPZXflVu8UF9mKi7dYAqWE8/8PxM
   ZhmsS01lgU1z6Jy4/3cMEFYCzGw9H6dj/aBt9JpqnXxQmvztReqT9VO8n
   Q==;
X-CSE-ConnectionGUID: I9brdqM0RWq0DG75nPw9uA==
X-CSE-MsgGUID: SZ39HcWhTFCPYw/GskC1Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="54251922"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="54251922"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 16:30:09 -0700
X-CSE-ConnectionGUID: F8px++sJS5GhLKMWMpmJ6Q==
X-CSE-MsgGUID: PMfjDj5xSn2Rd4aJ40hvpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="79342966"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 18 Oct 2024 16:30:08 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1wQ1-000OPZ-2r;
	Fri, 18 Oct 2024 23:30:05 +0000
Date: Sat, 19 Oct 2024 07:29:13 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 1f3de77752a7bf0d1beb44603f048eb46948b9fe
Message-ID: <202410190706.kACDo4iy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 1f3de77752a7bf0d1beb44603f048eb46948b9fe  Merge tag 'rtw-next-2024-10-10' of https://github.com/pkshih/rtw

elapsed time: 1802m

configs tested: 98
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241018    gcc-11
i386        buildonly-randconfig-002-20241018    gcc-11
i386        buildonly-randconfig-003-20241018    gcc-11
i386        buildonly-randconfig-004-20241018    gcc-11
i386        buildonly-randconfig-005-20241018    gcc-11
i386        buildonly-randconfig-006-20241018    gcc-11
i386                                defconfig    clang-18
i386                  randconfig-001-20241018    gcc-11
i386                  randconfig-002-20241018    gcc-11
i386                  randconfig-003-20241018    gcc-11
i386                  randconfig-004-20241018    gcc-11
i386                  randconfig-005-20241018    gcc-11
i386                  randconfig-006-20241018    gcc-11
i386                  randconfig-011-20241018    gcc-11
i386                  randconfig-012-20241018    gcc-11
i386                  randconfig-013-20241018    gcc-11
i386                  randconfig-014-20241018    gcc-11
i386                  randconfig-015-20241018    gcc-11
i386                  randconfig-016-20241018    gcc-11
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-wireless+bounces-28325-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77386C11E96
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 23:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C5019A0191
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 22:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416A132D7DB;
	Mon, 27 Oct 2025 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lefg3ypv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9135432C958
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 22:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761605625; cv=none; b=hn+Lzyp1AGB/6Bnb+YmZZdArvq3l5dEftY91jorR36+iU3xqjf/TDKLzzkUUyxvC5bS6SIQ2BXqAA8dxA8b1mZW9wulYFBP0o9XuU86Fy4jRHZgaAxc+3gS37UCYyav7DKUBAvkG8AncO/0AnEWS0WrzTZlLT+yqmuf+q/9tcTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761605625; c=relaxed/simple;
	bh=gsgPO5/cNof6QPTpHSrBSyHvS5IM16PJ/aVQYeLOXqI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cTeHB8Eice/v01wt5m9BX3PtnOPpiuUkOysso+uXQCmNuvx4pzu7zvmpoGttgKMVkj7CCIDd4Myb7Hz34RDilGRF8wjjpMGtVWopXcqzOtkE+iIN0Zc/R/ubBn01pVJQf6IeAEjECACcXq3NIWSB7obHWhetI50be2Fp4jevD+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lefg3ypv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761605623; x=1793141623;
  h=date:from:to:cc:subject:message-id;
  bh=gsgPO5/cNof6QPTpHSrBSyHvS5IM16PJ/aVQYeLOXqI=;
  b=lefg3ypvOVRVK/1rvQTwy8d28Dpr76qhZWBBMmrJm0iEQmcLZLklGk2q
   q8VKRJKhQs2AeJpaaqEFVegSGXOwQahzuYO5vSeFuPoMxcXg9u9JQv+V5
   B0sCyMHc2fSs259j1sunyvggwM2VOq+EZSyHpSJhlK/WhRQRyGBoxywAD
   bm92nr4zmOhb0AtFlg704+fNNwSVeQa0IBwfUxpGUyi4FzmXWJIhAxNER
   5FJQa5mMCqyoNF0evFgrrdRoo6N0WpBJRKpWMkOEUTxnxDLB8jgzmORBz
   OVhfFVwO7byUW5Mh2w3tJkl90tdKbfOc1PC3o6ZoGLC200NMusU7uXkfK
   g==;
X-CSE-ConnectionGUID: Yoi+vDsHSZCGblgHSnG3MA==
X-CSE-MsgGUID: EexRGk8HQSKdgf2amjYtPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62903374"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="62903374"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 15:53:43 -0700
X-CSE-ConnectionGUID: FcDS2J5+ToOFbKPNqJ1oew==
X-CSE-MsgGUID: HBS1VYDSTXC0YZ4/lD5h/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="185081231"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 27 Oct 2025 15:53:42 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDW5r-000IYW-1T;
	Mon, 27 Oct 2025 22:53:39 +0000
Date: Tue, 28 Oct 2025 06:53:14 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 88de08348af8ce15dc563e0ebb5553eddd821c06
Message-ID: <202510280609.0f8M8arv-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 88de08348af8ce15dc563e0ebb5553eddd821c06  wifi: cfg80211: Add parameters to radio-specific debugfs directories

elapsed time: 734m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20251027    gcc-8.5.0
arc                   randconfig-002-20251027    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20251027    clang-22
arm                   randconfig-002-20251027    clang-22
arm                   randconfig-003-20251027    gcc-8.5.0
arm                   randconfig-004-20251027    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251027    clang-22
arm64                 randconfig-002-20251027    gcc-12.5.0
arm64                 randconfig-003-20251027    gcc-9.5.0
arm64                 randconfig-004-20251027    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251027    gcc-14.3.0
csky                  randconfig-002-20251027    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251027    clang-22
hexagon               randconfig-002-20251027    clang-17
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251027    gcc-13
i386        buildonly-randconfig-002-20251027    clang-20
i386        buildonly-randconfig-003-20251027    clang-20
i386        buildonly-randconfig-004-20251027    gcc-14
i386        buildonly-randconfig-005-20251027    clang-20
i386        buildonly-randconfig-006-20251027    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251027    gcc-15.1.0
loongarch             randconfig-002-20251027    gcc-13.4.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251027    gcc-8.5.0
nios2                 randconfig-002-20251027    gcc-8.5.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251027    gcc-8.5.0
parisc                randconfig-002-20251027    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20251027    clang-22
powerpc               randconfig-002-20251027    clang-22
powerpc               randconfig-003-20251027    gcc-8.5.0
powerpc64             randconfig-001-20251027    gcc-8.5.0
powerpc64             randconfig-002-20251027    gcc-10.5.0
powerpc64             randconfig-003-20251027    gcc-10.5.0
riscv                            allmodconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20251027    gcc-13.4.0
riscv                 randconfig-002-20251027    clang-22
s390                             allmodconfig    clang-18
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251027    clang-22
s390                  randconfig-002-20251027    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20251027    gcc-12.5.0
sh                    randconfig-002-20251027    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251027    gcc-12.5.0
sparc                 randconfig-002-20251027    gcc-8.5.0
sparc64               randconfig-001-20251027    gcc-14.3.0
sparc64               randconfig-002-20251027    gcc-15.1.0
um                               allmodconfig    clang-19
um                               allyesconfig    gcc-14
um                    randconfig-001-20251027    clang-22
um                    randconfig-002-20251027    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251027    gcc-14
x86_64      buildonly-randconfig-002-20251027    gcc-14
x86_64      buildonly-randconfig-003-20251027    gcc-14
x86_64      buildonly-randconfig-004-20251027    gcc-14
x86_64      buildonly-randconfig-005-20251027    gcc-14
x86_64      buildonly-randconfig-006-20251027    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251027    gcc-12.5.0
xtensa                randconfig-002-20251027    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


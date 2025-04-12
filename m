Return-Path: <linux-wireless+bounces-21471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD765A86DE6
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 17:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D031F8A7F6C
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Apr 2025 15:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C2B1FA85A;
	Sat, 12 Apr 2025 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A74AuDUE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36121F7904
	for <linux-wireless@vger.kernel.org>; Sat, 12 Apr 2025 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744470572; cv=none; b=S9EKjGJ91nsamxCuClyXIPHRtRC9dZDUpuCDGLU9XJn4G1bggwNKGnPlPtrTa7BBWFvHLFCr7Ad1K3aNYOXp+fnXJEcXbczsBHN+ztUGPJWoXa7wLL97UOhf0Dh22e0Vy+fR+w0Wy3YdZnWTMJmHa/JoftfdHcLqIWq7XVeE4i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744470572; c=relaxed/simple;
	bh=ipY0OiqZbt/Q5tvYPYtV35ZpWEQx5PX4yfLFt591odQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lDp2MoVXi0+7+7KiUR+8kUT6tCGDUgkPUwgyZ/xNobclr1p3BzUWA6dZwvx3Yab+QJN+vFfwiL2208qwtzVroTB0bif+BnLW03e12mRdY5AaDtQfJmZRV3RqkDha1Llas3htOW1Hv81zMCQFWOn8OMit0VZgSYFJBPDwzFxA+8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A74AuDUE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744470571; x=1776006571;
  h=date:from:to:cc:subject:message-id;
  bh=ipY0OiqZbt/Q5tvYPYtV35ZpWEQx5PX4yfLFt591odQ=;
  b=A74AuDUEVBhG3T4QijrFoNR3LOTY2JiStUP50YJM+rK42dsvrPoBdFR/
   ZMCx/21/318oAkG/bUV+ugaLLaSJzhT53eCXIYWQEdE4dhprLunsW7u4w
   UyOhfHq1wPwU3XS+HXm8fANoxdKAOb8KUZotWQ/QujVXISwMvkiTZwsRE
   bziHLA86JL8u+bgviiMiV4QfZeNn1J3YFrx3N4Xmcudcu155c/ygfMwBG
   XxqfemJmaDjqFWKhDA6zIvrwzY6lIVmOt5Ym/LwtUhM96tQu3zdWaXWFj
   HjWAKqwZmTb+5bS9ShaEKQsFg7WRDJayOXwklBmaoo8ul0bW/ZZNXpptj
   g==;
X-CSE-ConnectionGUID: X6ns3fPsSfyTV7a5IFjNNw==
X-CSE-MsgGUID: wl5pSudXTDqh+URebWUahw==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="45709156"
X-IronPort-AV: E=Sophos;i="6.15,208,1739865600"; 
   d="scan'208";a="45709156"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2025 08:09:28 -0700
X-CSE-ConnectionGUID: 0F2YJO6pSnaQfYa8r0xuLg==
X-CSE-MsgGUID: C5/4fDO8QWig9qJDDzadTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,208,1739865600"; 
   d="scan'208";a="130281436"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 12 Apr 2025 08:09:27 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u3cU0-000BsK-23;
	Sat, 12 Apr 2025 15:09:24 +0000
Date: Sat, 12 Apr 2025 23:09:04 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 0937cb5f345c79d702b4d0d744e2a2529b551cb2
Message-ID: <202504122357.37fiNBJI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 0937cb5f345c79d702b4d0d744e2a2529b551cb2  Revert "wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()"

elapsed time: 1446m

configs tested: 99
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250412    gcc-14.2.0
arc                   randconfig-002-20250412    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250412    clang-21
arm                   randconfig-002-20250412    gcc-7.5.0
arm                   randconfig-003-20250412    clang-21
arm                   randconfig-004-20250412    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250412    clang-21
arm64                 randconfig-002-20250412    clang-21
arm64                 randconfig-003-20250412    gcc-8.5.0
arm64                 randconfig-004-20250412    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250412    gcc-14.2.0
csky                  randconfig-002-20250412    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250412    clang-21
hexagon               randconfig-002-20250412    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250412    clang-20
i386        buildonly-randconfig-002-20250412    clang-20
i386        buildonly-randconfig-003-20250412    clang-20
i386        buildonly-randconfig-004-20250412    clang-20
i386        buildonly-randconfig-005-20250412    clang-20
i386        buildonly-randconfig-006-20250412    gcc-11
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20250412    gcc-14.2.0
loongarch             randconfig-002-20250412    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250412    gcc-8.5.0
nios2                 randconfig-002-20250412    gcc-10.5.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250412    gcc-7.5.0
parisc                randconfig-002-20250412    gcc-9.3.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250412    clang-18
powerpc               randconfig-002-20250412    clang-21
powerpc               randconfig-003-20250412    clang-18
powerpc64             randconfig-001-20250412    clang-21
powerpc64             randconfig-002-20250412    clang-21
powerpc64             randconfig-003-20250412    clang-21
riscv                            allmodconfig    clang-21
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250412    clang-20
riscv                 randconfig-002-20250412    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250412    clang-18
s390                  randconfig-002-20250412    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250412    gcc-14.2.0
sh                    randconfig-002-20250412    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250412    gcc-10.3.0
sparc                 randconfig-002-20250412    gcc-13.3.0
sparc64               randconfig-001-20250412    gcc-13.3.0
sparc64               randconfig-002-20250412    gcc-5.5.0
um                               allmodconfig    clang-19
um                               allyesconfig    gcc-12
um                    randconfig-001-20250412    gcc-12
um                    randconfig-002-20250412    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250412    gcc-12
x86_64      buildonly-randconfig-002-20250412    clang-20
x86_64      buildonly-randconfig-003-20250412    gcc-11
x86_64      buildonly-randconfig-004-20250412    clang-20
x86_64      buildonly-randconfig-005-20250412    clang-20
x86_64      buildonly-randconfig-006-20250412    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250412    gcc-14.2.0
xtensa                randconfig-002-20250412    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


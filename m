Return-Path: <linux-wireless+bounces-16387-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A90DB9F14F9
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 19:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE80168F76
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 18:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C5C188A3A;
	Fri, 13 Dec 2024 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRS+G7bS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AF71DA5F
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734114763; cv=none; b=GxmHJCqLG0OlvtcUEUazZO6FhDPhmS9ai+aGIQatq2sGExBVQFYpxDzTVEICQqY2E3eEWEyHlMTRpLiUBMrhy8KgoEfk454jMk0EfixlvatlHmH+YvkC5W8fU9H6kRCcfFrblPOVf261rJM6+AfEyIFakhyaxJ8wHQ2HF421PK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734114763; c=relaxed/simple;
	bh=XAXE2rDnLA6i3H4BDrdp31A7bXioTsOSTdK2WR4L+u0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oCBonKlkvf28hhvaRS0HA4/0XTJiMDFt0bDSc1UhpcZRnCmsBLtpWn/61pidLDPzOqFnb/DBNl1nbugk101fw9HmsGRe5osHqGLdSOkE0XALy3jQ2GFStlF/ETmUhiRNqfowMRw/wxAQWRl+u2Gc7LRxwBkWqW6MXJ5PL/Nfxio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRS+G7bS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734114761; x=1765650761;
  h=date:from:to:cc:subject:message-id;
  bh=XAXE2rDnLA6i3H4BDrdp31A7bXioTsOSTdK2WR4L+u0=;
  b=HRS+G7bSjv5eZ39FXLOlkql3b9DDzaIAXDoxO4/4B29SksKeRTV8gAqZ
   hV+ECGooeypQuEmBYGq55dzdeqZyDSmJWuZ979jkCjZk6VNIVk2ba+cO6
   mD4HiygSibDq8zzQByQcHyjt4ETWEcGOvkAafQ6Mah4Gy9PqgF6SC2NIn
   L72weP5MZ6MfIusNmLnKpl+ajTc+NTi5lO4LedrmSyV5h+C18on9zP/0N
   LUsphsFZ8Jw+epX/WQRpXB5wNwGHiJm8xGMDHVdKm0/hXF4kzTMmcZ+Jh
   Cqt04EJZ5CFA+xud9qT+Vra1MX3IAKU/7EMpeLkAutElyOMLvk2PKG5MC
   w==;
X-CSE-ConnectionGUID: nDGjmEZ7RMOpFDHJiDYyzg==
X-CSE-MsgGUID: ho/IHzjTQy6dmFzIqwROUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="33875388"
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="33875388"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 10:32:41 -0800
X-CSE-ConnectionGUID: yAcHRxycT+ivjUrpKr3jYA==
X-CSE-MsgGUID: qDZpgeq6Tcu02LU+A3tyTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="96490754"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 13 Dec 2024 10:32:40 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMASr-000CJY-1w;
	Fri, 13 Dec 2024 18:32:37 +0000
Date: Sat, 14 Dec 2024 02:32:32 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:pending] BUILD SUCCESS
 1e8041bf4d8e51c50d217e36f2cd78b2f131a6a3
Message-ID: <202412140226.oEj7b4sG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: 1e8041bf4d8e51c50d217e36f2cd78b2f131a6a3  Merge tag 'rtw-next-2024-12-12' of https://github.com/pkshih/rtw into pending

elapsed time: 1452m

configs tested: 80
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
arc                             alldefconfig    gcc-13.2.0
arc                              allnoconfig    gcc-13.2.0
arc                    nsimosci_hs_defconfig    gcc-13.2.0
arc                nsimosci_hs_smp_defconfig    gcc-13.2.0
arc                  randconfig-001-20241213    gcc-13.2.0
arc                  randconfig-002-20241213    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                  randconfig-001-20241213    clang-16
arm                  randconfig-002-20241213    clang-18
arm                  randconfig-003-20241213    gcc-14.2.0
arm                  randconfig-004-20241213    clang-18
arm                       shmobile_defconfig    gcc-14.2.0
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-001-20241213    gcc-14.2.0
arm64                randconfig-002-20241213    gcc-14.2.0
arm64                randconfig-003-20241213    clang-18
arm64                randconfig-004-20241213    gcc-14.2.0
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20241213    gcc-14.2.0
csky                 randconfig-002-20241213    gcc-14.2.0
hexagon                          allnoconfig    clang-20
hexagon              randconfig-001-20241213    clang-20
hexagon              randconfig-002-20241213    clang-20
i386       buildonly-randconfig-001-20241213    clang-19
i386       buildonly-randconfig-002-20241213    gcc-12
i386       buildonly-randconfig-003-20241213    gcc-12
i386       buildonly-randconfig-004-20241213    clang-19
i386       buildonly-randconfig-005-20241213    gcc-12
i386       buildonly-randconfig-006-20241213    gcc-12
loongarch                        allnoconfig    gcc-14.2.0
loongarch            randconfig-001-20241213    gcc-14.2.0
loongarch            randconfig-002-20241213    gcc-14.2.0
m68k                         amiga_defconfig    gcc-14.2.0
m68k                      m5208evb_defconfig    gcc-14.2.0
m68k                      m5275evb_defconfig    gcc-14.2.0
nios2                randconfig-001-20241213    gcc-14.2.0
nios2                randconfig-002-20241213    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20241213    gcc-14.2.0
parisc               randconfig-002-20241213    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc                    kmeter1_defconfig    gcc-14.2.0
powerpc              randconfig-001-20241213    gcc-14.2.0
powerpc              randconfig-002-20241213    clang-20
powerpc              randconfig-003-20241213    gcc-14.2.0
powerpc                   sam440ep_defconfig    gcc-14.2.0
powerpc64            randconfig-001-20241213    gcc-14.2.0
powerpc64            randconfig-002-20241213    gcc-14.2.0
powerpc64            randconfig-003-20241213    gcc-14.2.0
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20241213    gcc-14.2.0
riscv                randconfig-002-20241213    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-20
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20241213    gcc-14.2.0
s390                 randconfig-002-20241213    clang-19
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                         kfr2r09_defconfig    gcc-14.2.0
sh                   randconfig-001-20241213    gcc-14.2.0
sh                   randconfig-002-20241213    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20241213    gcc-14.2.0
sparc                randconfig-002-20241213    gcc-14.2.0
sparc64              randconfig-001-20241213    gcc-14.2.0
sparc64              randconfig-002-20241213    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20241213    gcc-12
um                   randconfig-002-20241213    clang-16
x86_64     buildonly-randconfig-001-20241213    gcc-12
x86_64     buildonly-randconfig-002-20241213    gcc-12
x86_64     buildonly-randconfig-003-20241213    gcc-12
x86_64     buildonly-randconfig-004-20241213    gcc-12
x86_64     buildonly-randconfig-005-20241213    gcc-12
x86_64     buildonly-randconfig-006-20241213    clang-19
xtensa               randconfig-001-20241213    gcc-14.2.0
xtensa               randconfig-002-20241213    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


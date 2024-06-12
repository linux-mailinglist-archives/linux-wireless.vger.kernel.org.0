Return-Path: <linux-wireless+bounces-8836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9684D904CF1
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 09:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05061C243CA
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 07:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878933EA66;
	Wed, 12 Jun 2024 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtvIS5Nu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B995B3D388
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718178128; cv=none; b=cCgqaeSGRalecO9ZkPKw/pN4n9Cb5z8xoPMgZxit19r8ad3ngdyNqDURSSloBVdosB1ghk7YuMSWnnBzytZfV4vA10Go96LBudIsu3QwulPTqaIOKiCdUx86aOq+UuPbzbV3OifAQ1cREV+4QvSeW3MljLlqdT3nv/nxGmFPp7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718178128; c=relaxed/simple;
	bh=eLylLwawMmTVeKL9GZh4S2r+IXtC70JDu18IVaKjpdA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MzR69P4XQ1R165tyKD7D2DYL14Bip0lgMJtgQVvOKQ19rKNoZN6cs2YFm+XOHqKzCm8AP2Qq+NylS6rLR0/T7ePf2/X+BPAstiGuEEw86SDsXCmM4izjBvPkIjeW9fogESpBcMpPYQEeypapGnqI1+6g9ycIDYEbwGOdkJqY/s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtvIS5Nu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718178127; x=1749714127;
  h=date:from:to:cc:subject:message-id;
  bh=eLylLwawMmTVeKL9GZh4S2r+IXtC70JDu18IVaKjpdA=;
  b=mtvIS5NuQwMfLPLF9LpkyPcb91Ckg/MbGQlJNpftNaBZNK5i81MoV0BK
   jvMKSp/pDGKnw0kEwNzNptJb5hyOBGFSY1Hmt5JlWyBRtx1ffd8iwzUa6
   BPUPL836tNZYNta+gl7dezz+wd9omfoe2up6cMBD2DTgla+cXR/r/EDQv
   1JzHB9978RfxqDlbslcnv1F2QRo44MlBdAsmmUoEzIdWq/yhl1Akje5wW
   JKnF5lK+nh+jd3uKkuDn9CEdjMmR3IuhU9cdoC39TyWGzi9TtUSuRDNTj
   ktblwOoXwMci7kbcT/X/uVLm7uW8MmyTAg+JsOjpcRzPGbBU+fBq1e6B5
   g==;
X-CSE-ConnectionGUID: L8urXjDJTVOa8/24LKmPhg==
X-CSE-MsgGUID: /LsO884kSpWPg9xk58VUbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="15052341"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="15052341"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 00:41:38 -0700
X-CSE-ConnectionGUID: ZmuBiyUtSamSyZiaKwGXKA==
X-CSE-MsgGUID: AZDjW2QES32laiOfa4DRrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="40334838"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 12 Jun 2024 00:41:37 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sHIbv-0001KT-0O;
	Wed, 12 Jun 2024 07:41:35 +0000
Date: Wed, 12 Jun 2024 15:40:40 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 bb678f01804ccaa861b012b2b9426d69673d8a84
Message-ID: <202406121537.snZMIacX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: bb678f01804ccaa861b012b2b9426d69673d8a84  Merge branch 'intel-wired-lan-driver-updates-2024-06-03'

elapsed time: 1625m

configs tested: 117
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240612   gcc-13.2.0
arc                   randconfig-002-20240612   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                                 defconfig   clang-14
arm                   randconfig-001-20240612   gcc-13.2.0
arm                   randconfig-002-20240612   gcc-13.2.0
arm                   randconfig-003-20240612   clang-19
arm                   randconfig-004-20240612   clang-14
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240612   gcc-13.2.0
arm64                 randconfig-002-20240612   gcc-13.2.0
arm64                 randconfig-003-20240612   gcc-13.2.0
arm64                 randconfig-004-20240612   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240612   gcc-13.2.0
csky                  randconfig-002-20240612   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240612   clang-19
hexagon               randconfig-002-20240612   clang-19
i386         buildonly-randconfig-001-20240612   gcc-13
i386         buildonly-randconfig-002-20240612   gcc-8
i386         buildonly-randconfig-003-20240612   gcc-13
i386         buildonly-randconfig-004-20240612   clang-18
i386         buildonly-randconfig-005-20240612   gcc-13
i386         buildonly-randconfig-006-20240612   clang-18
i386                  randconfig-001-20240612   gcc-8
i386                  randconfig-002-20240612   clang-18
i386                  randconfig-003-20240612   clang-18
i386                  randconfig-004-20240612   clang-18
i386                  randconfig-005-20240612   gcc-13
i386                  randconfig-006-20240612   clang-18
i386                  randconfig-011-20240612   clang-18
i386                  randconfig-012-20240612   clang-18
i386                  randconfig-013-20240612   clang-18
i386                  randconfig-014-20240612   gcc-7
i386                  randconfig-015-20240612   gcc-13
i386                  randconfig-016-20240612   gcc-7
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240612   gcc-13.2.0
loongarch             randconfig-002-20240612   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                             allyesconfig   gcc-13.2.0
nios2                            allmodconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                            allyesconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240612   gcc-13.2.0
nios2                 randconfig-002-20240612   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240612   gcc-13.2.0
parisc                randconfig-002-20240612   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240612   gcc-13.2.0
powerpc               randconfig-002-20240612   gcc-13.2.0
powerpc               randconfig-003-20240612   clang-19
powerpc64             randconfig-001-20240612   gcc-13.2.0
powerpc64             randconfig-002-20240612   gcc-13.2.0
powerpc64             randconfig-003-20240612   clang-14
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240612   gcc-13.2.0
riscv                 randconfig-002-20240612   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   clang-19
s390                  randconfig-001-20240612   clang-19
s390                  randconfig-002-20240612   clang-19
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240612   gcc-13.2.0
sh                    randconfig-002-20240612   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                          allmodconfig   gcc-13.2.0
sparc64                          allyesconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240612   gcc-13.2.0
sparc64               randconfig-002-20240612   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240612   gcc-13
um                    randconfig-002-20240612   clang-16
um                           x86_64_defconfig   clang-15
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240612   gcc-13.2.0
xtensa                randconfig-002-20240612   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


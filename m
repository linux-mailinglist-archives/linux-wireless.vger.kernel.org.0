Return-Path: <linux-wireless+bounces-19544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2C9A4841F
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 17:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E6567A88F9
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 16:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8351DE2CB;
	Thu, 27 Feb 2025 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTluFcMp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881E81DE2D5
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671962; cv=none; b=NAJV3xDMDyTputE1C558EajMIZhCZgY8gIBE86Y2JXuQbAt0tIyDKVioEuQBRbjVnnarZ+VlpEKjXNXJBCXhQYb1MiGE5aklkvrlYHQgWQdvBhkUH8dI7hyL85E8ugLkqtllFa6dDHj6gJm1Tmgb/xBm3U93s9RwhIZna8Gu0QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671962; c=relaxed/simple;
	bh=Bdl1/nRmc+iqr9CkQeHi76LvKPex3Nrm2QsUXgKjMdU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XRQwvmMY4d2X1IroIp+5LXnAB8VxCS9Uv9OLWykRFu51dMHxeiyjRTw7BEjMKCk9Yu0uUnqRXdnCNdxqjHmHzEe28wcJjn9DxkD+4Y90Oof6JqTaLOxQ3v30Bw6Ugg+AMDrkTJ68rLFfYuG5pLyUWkTRZjJd31VmdLlXzyUq+N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTluFcMp; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740671961; x=1772207961;
  h=date:from:to:cc:subject:message-id;
  bh=Bdl1/nRmc+iqr9CkQeHi76LvKPex3Nrm2QsUXgKjMdU=;
  b=bTluFcMpEtWxPewhGJI4YbJgLJYj5nGMI1P22zee/7l2IykHUvSP1FFg
   FuR2p19yElWVVrIWTxbO1+Wypq+5qaMoGmVxD2/HlvkhB8pKrf7UVeyyR
   IPh+z04vyHFY0aADDC6C3PbOEvyON2QdOpXpEfqQuruQtluDYyMRxIy7/
   I6HCylGIJLKB72cYDlP23QbmqJslnxpcuXevEe4CXZ/KLXdrKV5NEdAIh
   R331o/SGEtCIYqcd5/qRo3W8YeTiaEIgCUswueN/YEdMuCEF3qD2IO9Ba
   YqjuCI2E4340UKvzVl9/xQgiF8cNHDde2rB/Sel4NS+zmJBT2dNS3YXfl
   Q==;
X-CSE-ConnectionGUID: QdNpp5KCTLe9bysZwVIAMA==
X-CSE-MsgGUID: c1Bu0aInRTO2K1v2UWRVgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45484340"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="45484340"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 07:59:20 -0800
X-CSE-ConnectionGUID: FrswmbefT/aPRP4BAKsnuA==
X-CSE-MsgGUID: GVaZcHmoRVCrtdOueoKyWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="116834233"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 27 Feb 2025 07:59:19 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tngI8-000DdK-0Z;
	Thu, 27 Feb 2025 15:59:16 +0000
Date: Thu, 27 Feb 2025 23:59:00 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 8c3170628a9ce24a59647bd24f897e666af919b8
Message-ID: <202502272354.n8zk4lO1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 8c3170628a9ce24a59647bd24f897e666af919b8  wifi: brcmfmac: keep power during suspend if board requires it

elapsed time: 1460m

configs tested: 170
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              alldefconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250227    gcc-13.2.0
arc                   randconfig-002-20250227    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                          pxa3xx_defconfig    gcc-14.2.0
arm                   randconfig-001-20250227    gcc-14.2.0
arm                   randconfig-002-20250227    clang-17
arm                   randconfig-003-20250227    gcc-14.2.0
arm                   randconfig-004-20250227    clang-21
arm                         socfpga_defconfig    gcc-14.2.0
arm                        spear6xx_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250227    gcc-14.2.0
arm64                 randconfig-002-20250227    clang-19
arm64                 randconfig-003-20250227    gcc-14.2.0
arm64                 randconfig-004-20250227    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250227    gcc-14.2.0
csky                  randconfig-002-20250227    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250227    clang-14
hexagon               randconfig-001-20250227    gcc-14.2.0
hexagon               randconfig-002-20250227    clang-16
hexagon               randconfig-002-20250227    gcc-14.2.0
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250227    gcc-12
i386        buildonly-randconfig-002-20250227    gcc-11
i386        buildonly-randconfig-002-20250227    gcc-12
i386        buildonly-randconfig-003-20250227    clang-19
i386        buildonly-randconfig-003-20250227    gcc-12
i386        buildonly-randconfig-004-20250227    gcc-12
i386        buildonly-randconfig-005-20250227    gcc-11
i386        buildonly-randconfig-005-20250227    gcc-12
i386        buildonly-randconfig-006-20250227    clang-19
i386        buildonly-randconfig-006-20250227    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250227    clang-19
i386                  randconfig-002-20250227    clang-19
i386                  randconfig-003-20250227    clang-19
i386                  randconfig-004-20250227    clang-19
i386                  randconfig-005-20250227    clang-19
i386                  randconfig-006-20250227    clang-19
i386                  randconfig-007-20250227    clang-19
i386                  randconfig-011-20250227    gcc-12
i386                  randconfig-012-20250227    gcc-12
i386                  randconfig-013-20250227    gcc-12
i386                  randconfig-014-20250227    gcc-12
i386                  randconfig-015-20250227    gcc-12
i386                  randconfig-016-20250227    gcc-12
i386                  randconfig-017-20250227    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250227    gcc-14.2.0
loongarch             randconfig-002-20250227    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    gcc-14.2.0
mips                          eyeq5_defconfig    gcc-14.2.0
mips                       rbtx49xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250227    gcc-14.2.0
nios2                 randconfig-002-20250227    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-15
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250227    gcc-14.2.0
parisc                randconfig-002-20250227    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                      bamboo_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250227    clang-19
powerpc               randconfig-001-20250227    gcc-14.2.0
powerpc               randconfig-002-20250227    gcc-14.2.0
powerpc               randconfig-003-20250227    clang-19
powerpc               randconfig-003-20250227    gcc-14.2.0
powerpc64             randconfig-001-20250227    clang-17
powerpc64             randconfig-001-20250227    gcc-14.2.0
powerpc64             randconfig-002-20250227    clang-21
powerpc64             randconfig-002-20250227    gcc-14.2.0
powerpc64             randconfig-003-20250227    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250227    gcc-14.2.0
riscv                 randconfig-002-20250227    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250227    clang-18
s390                  randconfig-001-20250227    gcc-14.2.0
s390                  randconfig-002-20250227    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250227    gcc-14.2.0
sh                    randconfig-002-20250227    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250227    gcc-14.2.0
sparc                 randconfig-002-20250227    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250227    gcc-14.2.0
sparc64               randconfig-002-20250227    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250227    clang-17
um                    randconfig-001-20250227    gcc-14.2.0
um                    randconfig-002-20250227    gcc-12
um                    randconfig-002-20250227    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250227    clang-19
x86_64      buildonly-randconfig-002-20250227    clang-19
x86_64      buildonly-randconfig-003-20250227    clang-19
x86_64      buildonly-randconfig-003-20250227    gcc-12
x86_64      buildonly-randconfig-004-20250227    clang-19
x86_64      buildonly-randconfig-004-20250227    gcc-12
x86_64      buildonly-randconfig-005-20250227    clang-19
x86_64      buildonly-randconfig-006-20250227    clang-19
x86_64      buildonly-randconfig-006-20250227    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250227    gcc-12
x86_64                randconfig-002-20250227    gcc-12
x86_64                randconfig-003-20250227    gcc-12
x86_64                randconfig-004-20250227    gcc-12
x86_64                randconfig-005-20250227    gcc-12
x86_64                randconfig-006-20250227    gcc-12
x86_64                randconfig-007-20250227    gcc-12
x86_64                randconfig-008-20250227    gcc-12
x86_64                randconfig-071-20250227    gcc-12
x86_64                randconfig-072-20250227    gcc-12
x86_64                randconfig-073-20250227    gcc-12
x86_64                randconfig-074-20250227    gcc-12
x86_64                randconfig-075-20250227    gcc-12
x86_64                randconfig-076-20250227    gcc-12
x86_64                randconfig-077-20250227    gcc-12
x86_64                randconfig-078-20250227    gcc-12
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                          iss_defconfig    gcc-14.2.0
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250227    gcc-14.2.0
xtensa                randconfig-002-20250227    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


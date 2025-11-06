Return-Path: <linux-wireless+bounces-28669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC6EC3C30D
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 16:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DEAF4E1ADD
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B985A22069A;
	Thu,  6 Nov 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VlG0Libc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AED121D3F8
	for <linux-wireless@vger.kernel.org>; Thu,  6 Nov 2025 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444518; cv=none; b=tR94Zxv366TyGum7vnG3GlpFUsPoqz5nAIr/xzDFvdvgVBnfDo3dqLXWbUa5ISbzfEnfl0+Mt0f2VVxD5OObtzQK+Y2pDFFs0iBq6FozkItw7iAJYCY7KhiHGIXTVxUPMcF8+ViMA35RJGENy/BejmehxL37Vt898KpDRTNMeAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444518; c=relaxed/simple;
	bh=/IhF7OEpJg+2zPvGRbHz4L2XCEEFhLDw9dbzN1mCzqE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SWo/vqvDV4jCCnLCoiepXOI/A/USnd7bXXeuxQaiJ6p4TWM2gxweg2MGgvo9SCgqueeFhp5XjrIr91K06hJuOJAYJCvuXY8Au0dnJBULsPXQ3L06UpIalxFp9znqSWtHuYFond7T9aB26tI3HcstARi04gkWAH/MuvTBTdwFRyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VlG0Libc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762444517; x=1793980517;
  h=date:from:to:cc:subject:message-id;
  bh=/IhF7OEpJg+2zPvGRbHz4L2XCEEFhLDw9dbzN1mCzqE=;
  b=VlG0LibcQElKzYMCGfxWNKHzu7lZBwE64eM999zEzUplkPI4ojgjy0P1
   BZZAqGGCDwPrJq43yBZ/mQf3cN8q+c3EyD7/UdyLosD6NKCkNL/3gOKlk
   nTekW6T3hq781m5UoaUejVF/dTaC27MnRdXvyefNvjvq7vAAwkM3MGeJ0
   XharvE3SEPzx2QWj0UJAc/heLorhSuwFmo2W6quLwEOL3FyfSBWQAVJW/
   WSE9DuDBMZF67SUyodNOZCMuMSpHUsvqkkZeidTgKSCguETU4sIBQ6gGe
   OXl4HbvplCxG2aGvVZw3TGOLL59yByakWQS4aAsixeyeYtqhhO8VgOe2C
   Q==;
X-CSE-ConnectionGUID: lINngrqZSDa1NW+kUp8HKg==
X-CSE-MsgGUID: wsy1fnnPTkKr5AoQIrYW8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="90054656"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="90054656"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 07:55:17 -0800
X-CSE-ConnectionGUID: //pgj9U4SKqSLrRgfGzjOA==
X-CSE-MsgGUID: 3u+TnGUyTa+x5hLkaF3rDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="192147130"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 06 Nov 2025 07:55:16 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vH2KP-000U6Q-0O;
	Thu, 06 Nov 2025 15:55:13 +0000
Date: Thu, 06 Nov 2025 23:54:28 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 2f6adeaf92c4ea4adf5a91b87497ba13bb057996
Message-ID: <202511062323.s9gq5BLG-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 2f6adeaf92c4ea4adf5a91b87497ba13bb057996  Merge tag 'ath-next-20251103' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath into wireless-next

elapsed time: 1452m

configs tested: 105
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                            hsdk_defconfig    gcc-15.1.0
arc                   randconfig-001-20251106    gcc-12.5.0
arc                   randconfig-002-20251106    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                   milbeaut_m10v_defconfig    clang-19
arm                       omap2plus_defconfig    gcc-15.1.0
arm                   randconfig-001-20251106    gcc-11.5.0
arm                   randconfig-002-20251106    clang-22
arm                   randconfig-003-20251106    gcc-10.5.0
arm                   randconfig-004-20251106    gcc-8.5.0
arm                        vexpress_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251106    gcc-11.5.0
arm64                 randconfig-002-20251106    clang-19
arm64                 randconfig-003-20251106    gcc-14.3.0
arm64                 randconfig-004-20251106    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251106    gcc-12.5.0
csky                  randconfig-002-20251106    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251106    clang-19
hexagon               randconfig-002-20251106    clang-20
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251106    clang-20
i386        buildonly-randconfig-002-20251106    clang-20
i386        buildonly-randconfig-003-20251106    gcc-14
i386        buildonly-randconfig-004-20251106    clang-20
i386        buildonly-randconfig-005-20251106    gcc-14
i386        buildonly-randconfig-006-20251106    gcc-14
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251106    gcc-15.1.0
loongarch             randconfig-002-20251106    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                       m5249evb_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip28_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251106    gcc-9.5.0
nios2                 randconfig-002-20251106    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20251106    gcc-10.5.0
parisc                randconfig-002-20251106    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                     asp8347_defconfig    clang-22
powerpc                  mpc885_ads_defconfig    clang-22
powerpc               randconfig-001-20251106    gcc-14.3.0
powerpc               randconfig-002-20251106    clang-22
powerpc                     taishan_defconfig    clang-17
powerpc64             randconfig-001-20251106    gcc-8.5.0
powerpc64             randconfig-002-20251106    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251106    clang-22
riscv                 randconfig-002-20251106    gcc-12.5.0
s390                              allnoconfig    clang-22
s390                  randconfig-001-20251106    gcc-8.5.0
s390                  randconfig-002-20251106    gcc-14.3.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251106    gcc-11.5.0
sh                    randconfig-002-20251106    gcc-13.4.0
sh                      rts7751r2d1_defconfig    gcc-15.1.0
sh                           se7712_defconfig    gcc-15.1.0
sh                            shmin_defconfig    gcc-15.1.0
sh                             shx3_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251106    gcc-15.1.0
sparc                 randconfig-002-20251106    gcc-15.1.0
sparc                       sparc64_defconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251106    gcc-13.4.0
sparc64               randconfig-002-20251106    clang-20
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251106    gcc-14
um                    randconfig-002-20251106    clang-22
um                           x86_64_defconfig    clang-22
x86_64                           alldefconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251106    gcc-12
x86_64      buildonly-randconfig-002-20251106    gcc-14
x86_64      buildonly-randconfig-003-20251106    gcc-14
x86_64      buildonly-randconfig-004-20251106    gcc-14
x86_64      buildonly-randconfig-005-20251106    clang-20
x86_64      buildonly-randconfig-006-20251106    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251106    clang-20
x86_64                randconfig-012-20251106    clang-20
x86_64                randconfig-013-20251106    clang-20
x86_64                randconfig-014-20251106    gcc-14
x86_64                randconfig-015-20251106    gcc-14
x86_64                randconfig-016-20251106    gcc-12
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251106    gcc-9.5.0
xtensa                randconfig-002-20251106    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


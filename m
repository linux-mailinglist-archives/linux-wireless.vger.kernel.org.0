Return-Path: <linux-wireless+bounces-30182-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9378ECEA4AC
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 18:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D55B30028AA
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 17:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14388222597;
	Tue, 30 Dec 2025 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QHUw/oLp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B2F215075
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767115113; cv=none; b=P+EOtgHNbxly/VW+9leetSFHjXgs1ELjeRYXtfRPoAI1k2WVp5iy0jGw01K83mq2rsQwW6OzkRbJ3HeRsRP65vOmwVphE7iyKhqoLfEc5Phog4bAOmYkCh4ZIAGXImg0U6/RleDoNZd5btMPbCqQQpffwc5XX7QaCy1TTD2HBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767115113; c=relaxed/simple;
	bh=tt4Wi+VrHdPYjLJA6/KAfQ8os0QddW59mdCCstbUgak=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UdCAjD1nxTdoKYwi2O1jcYE7FioZLZc2krWQxnF/en0UtEDHmhYdn+odHJmPieuxMYjrO1w6BqOS7GFi3aR05foj6q60MCuGXwJSP6sn+t2RJHjwztcXuSLSUiYd6otjG3QTTRL9nWclC9VDH3n1N5UzgUDUKJHki3UyZ9490Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QHUw/oLp; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767115111; x=1798651111;
  h=date:from:to:cc:subject:message-id;
  bh=tt4Wi+VrHdPYjLJA6/KAfQ8os0QddW59mdCCstbUgak=;
  b=QHUw/oLpZmyDeFvKfvaffLGtT8XOUiZvCcJ3Z6J7hwToMW96/GUzmCy0
   +NekhtEirbfNgLcuEOH73cMI8spXyA2EatFP9OmDh7L92pKL37Nop1xi/
   Stxh2z9G4kBXDs9c2DyKr7QWauffKu1mUPO0v2yWjdFuKdn9A8L+m1H3s
   0Y4rPm9nPdj/DJ5vnXUNzUKwOTckeA2F5g8xizf28dznL+R6uzYG3GQhv
   tKm2q0YBW5f5VfoRVGyXkuYOHclxqWE+j0/0cgAjev36MTDjnUP3JSldY
   wSIg7FKN+K6/X1gDPyqKEOMYEROYJXWX7nAsORmqD5U2rv7maoq/IftZL
   Q==;
X-CSE-ConnectionGUID: SuRgbl+oTwq7IppYkuO5Xg==
X-CSE-MsgGUID: aaixnYLFT2Wjkkn1fjvoRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11657"; a="72554483"
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="72554483"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 09:17:43 -0800
X-CSE-ConnectionGUID: WQ/2eylgRQmpLiTj0lIt+g==
X-CSE-MsgGUID: ooFuHJUyQ+2XJ3XPpxml2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,189,1763452800"; 
   d="scan'208";a="202205811"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 Dec 2025 09:17:42 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vadLn-000000000Z7-48Xm;
	Tue, 30 Dec 2025 17:17:39 +0000
Date: Wed, 31 Dec 2025 01:17:30 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 a6694b7e39b34757c045c4dc499fb2b8a635bce0
Message-ID: <202512310125.rdi5IAeH-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: a6694b7e39b34757c045c4dc499fb2b8a635bce0  Merge tag 'wireless-2025-12-17' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

elapsed time: 1494m

configs tested: 167
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                          axs101_defconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251230    gcc-12.5.0
arc                   randconfig-002-20251230    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20251230    gcc-8.5.0
arm                   randconfig-002-20251230    gcc-8.5.0
arm                   randconfig-003-20251230    gcc-10.5.0
arm                   randconfig-004-20251230    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251230    gcc-15.1.0
arm64                 randconfig-002-20251230    gcc-14.3.0
arm64                 randconfig-003-20251230    clang-22
arm64                 randconfig-004-20251230    clang-20
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251230    gcc-15.1.0
csky                  randconfig-002-20251230    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251230    clang-22
hexagon               randconfig-002-20251230    clang-18
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251230    gcc-14
i386        buildonly-randconfig-002-20251230    clang-20
i386        buildonly-randconfig-003-20251230    clang-20
i386        buildonly-randconfig-004-20251230    clang-20
i386        buildonly-randconfig-005-20251230    clang-20
i386        buildonly-randconfig-006-20251230    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251230    gcc-14
i386                  randconfig-002-20251230    clang-20
i386                  randconfig-003-20251230    clang-20
i386                  randconfig-004-20251230    clang-20
i386                  randconfig-005-20251230    clang-20
i386                  randconfig-006-20251230    clang-20
i386                  randconfig-007-20251230    clang-20
i386                  randconfig-011-20251230    gcc-14
i386                  randconfig-012-20251230    gcc-14
i386                  randconfig-013-20251230    clang-20
i386                  randconfig-014-20251230    gcc-12
i386                  randconfig-015-20251230    gcc-14
i386                  randconfig-016-20251230    gcc-14
i386                  randconfig-017-20251230    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251230    gcc-15.1.0
loongarch             randconfig-002-20251230    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                           sun3_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251230    gcc-8.5.0
nios2                 randconfig-002-20251230    gcc-9.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251230    gcc-15.1.0
parisc                randconfig-002-20251230    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251230    gcc-10.5.0
powerpc               randconfig-002-20251230    gcc-12.5.0
powerpc                     redwood_defconfig    clang-22
powerpc                     tqm8555_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251230    gcc-14.3.0
powerpc64             randconfig-002-20251230    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251230    gcc-15.1.0
riscv                 randconfig-002-20251230    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251230    gcc-14.3.0
s390                  randconfig-002-20251230    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251230    gcc-13.4.0
sh                    randconfig-002-20251230    gcc-12.5.0
sh                      rts7751r2d1_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251230    gcc-8.5.0
sparc                 randconfig-002-20251230    gcc-11.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251230    clang-22
sparc64               randconfig-002-20251230    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251230    gcc-13
um                    randconfig-002-20251230    clang-18
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251230    gcc-14
x86_64      buildonly-randconfig-002-20251230    gcc-14
x86_64      buildonly-randconfig-003-20251230    clang-20
x86_64      buildonly-randconfig-004-20251230    clang-20
x86_64      buildonly-randconfig-005-20251230    clang-20
x86_64      buildonly-randconfig-006-20251230    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251230    gcc-14
x86_64                randconfig-002-20251230    clang-20
x86_64                randconfig-003-20251230    clang-20
x86_64                randconfig-004-20251230    clang-20
x86_64                randconfig-005-20251230    clang-20
x86_64                randconfig-006-20251230    gcc-14
x86_64                randconfig-011-20251230    gcc-14
x86_64                randconfig-012-20251230    gcc-14
x86_64                randconfig-013-20251230    gcc-14
x86_64                randconfig-014-20251230    clang-20
x86_64                randconfig-015-20251230    clang-20
x86_64                randconfig-016-20251230    clang-20
x86_64                randconfig-071-20251230    clang-20
x86_64                randconfig-072-20251230    clang-20
x86_64                randconfig-073-20251230    gcc-14
x86_64                randconfig-074-20251230    clang-20
x86_64                randconfig-075-20251230    clang-20
x86_64                randconfig-076-20251230    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20251230    gcc-8.5.0
xtensa                randconfig-002-20251230    gcc-8.5.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


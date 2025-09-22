Return-Path: <linux-wireless+bounces-27586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE48B9328F
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 22:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A001905F12
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 20:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF842F0C46;
	Mon, 22 Sep 2025 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXgthJxR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05071494DB
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 20:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758571402; cv=none; b=CoYtV5n+vSMComvsQS38s5/PTnC4/MOGt4DnuUacHBFFTjCElUiVe44gbVG0vQABA7nbTvraEo3CNuT2kF66UbZ3da3/QgMgL+oTkFb5pXZWHxuZIOtLPdSP5LfhEDtEbqNePvJofiHenHW5fCCKXqXlknKKP6jKZJBBByflhxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758571402; c=relaxed/simple;
	bh=LMSg9l+Xzjk7RBNhoCNlmgcaDgLjWCInZlhBjIaRxPs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=egw4E77w6fXb1ud3pK6ndIFm+yXqy1JOgCvilr7sV5e7Dw2OSHT48JgOa0JznZ52q2HRdMTuqXtSRGZfSwoyX/Dp4NjV0FAIX7UDPSWSIFhhQVBy9BSv8afUIrDqmzZ98AZuj391Tu2s5Zgk7+2lMp4qA5dOdEcicnPgyCDKJgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXgthJxR; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758571401; x=1790107401;
  h=date:from:to:cc:subject:message-id;
  bh=LMSg9l+Xzjk7RBNhoCNlmgcaDgLjWCInZlhBjIaRxPs=;
  b=DXgthJxRICXMvP7ECbAhjBnGPVJDnIhd30GpzMSNuMonL8d3GzM3rQ2z
   Dxm55A+WoJReuF9zEEtQk9EWbQPIDVUnq97jJ7JXxb9AeFcQPWw+e3aaj
   AeRePdHeeCGbGyBegMQjCw2USwPFnA9tXrBDOZPKXiczeX07CWNxyE0Mw
   bxNGArZJ4q4UeKKwZFtOkb5lFpIzuFUxzsq+sLtkz7v2ZpQPG2FlxQlHo
   keq3AsICdR/wEGyYnEygsusmOq70guGoNlwocxteS9YFNfGdg+H98wPf2
   hmdvLm3LzJYryyZ8ZHX84mrOn6nUdsgBqaJ2MrRUpGZ9s3+Q/lr2UanMB
   Q==;
X-CSE-ConnectionGUID: TGOQdStXSKi+fmAy4ukVhA==
X-CSE-MsgGUID: HTd9GKAyQcSnAmqbiYB4yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="64665004"
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="64665004"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 13:03:20 -0700
X-CSE-ConnectionGUID: UUpTR+xgRY20NBnRUgv9iQ==
X-CSE-MsgGUID: BghtutVzQ0u1h4aOwZj9Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="200275613"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 22 Sep 2025 13:03:18 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0mkm-0002S5-2Y;
	Mon, 22 Sep 2025 20:03:16 +0000
Date: Tue, 23 Sep 2025 04:02:51 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 16444ae3f7af91aedfaabcada3f58e0d4aefc53a
Message-ID: <202509230439.urMqyR6O-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 16444ae3f7af91aedfaabcada3f58e0d4aefc53a  Merge tag 'rtw-next-2025-09-22' of https://github.com/pkshih/rtw

elapsed time: 726m

configs tested: 127
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250922    gcc-8.5.0
arc                   randconfig-002-20250922    gcc-9.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                       imx_v6_v7_defconfig    clang-16
arm                   randconfig-001-20250922    clang-22
arm                   randconfig-002-20250922    gcc-12.5.0
arm                   randconfig-003-20250922    clang-17
arm                   randconfig-004-20250922    gcc-8.5.0
arm                    vt8500_v6_v7_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250922    gcc-8.5.0
arm64                 randconfig-002-20250922    gcc-15.1.0
arm64                 randconfig-003-20250922    clang-22
arm64                 randconfig-004-20250922    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250922    gcc-15.1.0
csky                  randconfig-002-20250922    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250922    clang-20
hexagon               randconfig-002-20250922    clang-19
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250922    clang-20
i386        buildonly-randconfig-002-20250922    gcc-14
i386        buildonly-randconfig-003-20250922    gcc-14
i386        buildonly-randconfig-004-20250922    gcc-14
i386        buildonly-randconfig-005-20250922    clang-20
i386        buildonly-randconfig-006-20250922    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250922    clang-22
loongarch             randconfig-002-20250922    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           jazz_defconfig    clang-17
mips                   sb1250_swarm_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250922    gcc-11.5.0
nios2                 randconfig-002-20250922    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                    or1ksim_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250922    gcc-8.5.0
parisc                randconfig-002-20250922    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250922    clang-22
powerpc               randconfig-002-20250922    gcc-12.5.0
powerpc               randconfig-003-20250922    clang-17
powerpc64             randconfig-001-20250922    gcc-12.5.0
powerpc64             randconfig-002-20250922    clang-20
powerpc64             randconfig-003-20250922    clang-17
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250922    clang-22
riscv                 randconfig-002-20250922    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250922    gcc-8.5.0
s390                  randconfig-002-20250922    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                 kfr2r09-romimage_defconfig    gcc-15.1.0
sh                    randconfig-001-20250922    gcc-15.1.0
sh                    randconfig-002-20250922    gcc-11.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250922    gcc-15.1.0
sparc                 randconfig-002-20250922    gcc-14.3.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250922    gcc-12.5.0
sparc64               randconfig-002-20250922    gcc-14.3.0
um                               alldefconfig    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250922    gcc-14
um                    randconfig-002-20250922    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250922    clang-20
x86_64      buildonly-randconfig-002-20250922    gcc-13
x86_64      buildonly-randconfig-003-20250922    gcc-13
x86_64      buildonly-randconfig-004-20250922    clang-20
x86_64      buildonly-randconfig-005-20250922    clang-20
x86_64      buildonly-randconfig-006-20250922    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250922    gcc-9.5.0
xtensa                randconfig-002-20250922    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


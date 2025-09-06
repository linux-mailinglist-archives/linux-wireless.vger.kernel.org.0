Return-Path: <linux-wireless+bounces-27045-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC88B47615
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Sep 2025 20:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E970C3AC803
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Sep 2025 18:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0482036FA;
	Sat,  6 Sep 2025 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e406+lbV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C66EEBB
	for <linux-wireless@vger.kernel.org>; Sat,  6 Sep 2025 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757183416; cv=none; b=LCaxBgCfm0gjRISqG9VYf5XaVSVJOL3lrNMouoMdeFsWjC9XamUJ7i0xMyTVHd0Dv5a9MtdxEf/1BC2xawdi3tStVxt+LrCNgzz6hCs3OiSttOX5GNiv8+tiQn3eM1ptalueJ0U3PdMBT0Da26RpS9yhd93q+WpNDuqX/JQUNeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757183416; c=relaxed/simple;
	bh=8e8lB1Z9fUFRPA8lkEG2JyqSmoO5MXL3MDzqyPHIBVk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bZqRe5AhlUjr69ieYWLX3G1SGSDgq1+TCA24Hvtio0QUhpPekQ7btLwOJKi0T5XDpwEsheMiWEWzyITHNqly02h1fF57KegfEzEH3SMkCSB7X3AI30QX3bRnvZzmQvGAPmeWbJrQ6tkx2qQV1Ns2ipwrdrfA4w8Vaq1P5BIbosY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e406+lbV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757183415; x=1788719415;
  h=date:from:to:cc:subject:message-id;
  bh=8e8lB1Z9fUFRPA8lkEG2JyqSmoO5MXL3MDzqyPHIBVk=;
  b=e406+lbV3zjhvPkouoPx+J8PWeQGiI5i6S67ilgzww6B2+GiNsCXFAb8
   Qi7koMoqIy4R5SM6rpJywnkHaH5XFBDo7PicKks1aDI0AELUjsxUqJvDY
   y8qjibjxgnDE7VGJbIimskW2CL2mTOMv4OHB24K6TZ04rbBe8VW5bOE65
   IKzR5EUv9jXhK9PUheOWp/TmDKKp/x79P2ewuEiw2wMjC2DI676ceSrqk
   ll251vdGboaDNlDssN8ld/NoEDEyTrUWkAz6uKd+haIzQegn7zl2o4Udk
   aui2CrD2MkwOFFSJ5OhagfbSWbkdlvDs3e2phQk1ITIi6DmzuNqGkCVdv
   Q==;
X-CSE-ConnectionGUID: eTAW19ZHSTWNOPRiNvRQRA==
X-CSE-MsgGUID: Seg6gHy1QgyeIYrlAogfqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59425643"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59425643"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 11:30:14 -0700
X-CSE-ConnectionGUID: wDn8Q48xSkmvkyEyBQ6i/A==
X-CSE-MsgGUID: abV1GFLXTzCKS1yttmSFBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="203369267"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 06 Sep 2025 11:30:13 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuxfu-0001jk-32;
	Sat, 06 Sep 2025 18:30:10 +0000
Date: Sun, 07 Sep 2025 02:30:08 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 e3ac93e9d916ebae0711a42f524429dad89c4887
Message-ID: <202509070202.6PP9IgWK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: e3ac93e9d916ebae0711a42f524429dad89c4887  wifi: mwifiex: fix double free in mwifiex_send_rgpower_table()

elapsed time: 2016m

configs tested: 97
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250905    gcc-11.5.0
arc                   randconfig-002-20250905    gcc-13.4.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20250905    clang-22
arm                   randconfig-002-20250905    clang-22
arm                   randconfig-003-20250905    clang-16
arm                   randconfig-004-20250905    gcc-14.3.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250905    clang-22
arm64                 randconfig-002-20250905    clang-17
arm64                 randconfig-003-20250905    clang-17
arm64                 randconfig-004-20250905    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250905    gcc-15.1.0
csky                  randconfig-002-20250905    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250905    clang-22
hexagon               randconfig-002-20250905    clang-22
i386                             allmodconfig    gcc-13
i386                              allnoconfig    gcc-13
i386                             allyesconfig    gcc-13
i386        buildonly-randconfig-001-20250905    clang-20
i386        buildonly-randconfig-002-20250905    clang-20
i386        buildonly-randconfig-003-20250905    clang-20
i386        buildonly-randconfig-004-20250905    gcc-13
i386        buildonly-randconfig-005-20250905    clang-20
i386        buildonly-randconfig-006-20250905    clang-20
i386                                defconfig    clang-20
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250905    clang-18
loongarch             randconfig-002-20250905    clang-18
m68k                              allnoconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250905    gcc-10.5.0
nios2                 randconfig-002-20250905    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250905    gcc-15.1.0
parisc                randconfig-002-20250905    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250905    gcc-8.5.0
powerpc               randconfig-002-20250905    clang-22
powerpc               randconfig-003-20250905    gcc-8.5.0
powerpc64             randconfig-001-20250905    clang-22
powerpc64             randconfig-002-20250905    clang-22
powerpc64             randconfig-003-20250905    gcc-14.3.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250905    gcc-14.3.0
riscv                 randconfig-002-20250905    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250905    gcc-9.5.0
s390                  randconfig-002-20250905    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250905    gcc-15.1.0
sh                    randconfig-002-20250905    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250905    gcc-8.5.0
sparc                 randconfig-002-20250905    gcc-15.1.0
sparc64               randconfig-001-20250905    gcc-8.5.0
sparc64               randconfig-002-20250905    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-13
um                    randconfig-001-20250905    clang-22
um                    randconfig-002-20250905    gcc-13
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250905    clang-20
x86_64      buildonly-randconfig-002-20250905    clang-20
x86_64      buildonly-randconfig-003-20250905    gcc-13
x86_64      buildonly-randconfig-004-20250905    clang-20
x86_64      buildonly-randconfig-005-20250905    clang-20
x86_64      buildonly-randconfig-006-20250905    gcc-13
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250905    gcc-8.5.0
xtensa                randconfig-002-20250905    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


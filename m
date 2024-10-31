Return-Path: <linux-wireless+bounces-14772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C55E09B7810
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 10:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36822B23CEE
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 09:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C78914D2BD;
	Thu, 31 Oct 2024 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="InkpoY/2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AE1881E
	for <linux-wireless@vger.kernel.org>; Thu, 31 Oct 2024 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368572; cv=none; b=baYL1g/a6g7T2N257/UUWfGzpTyUZiUGk4udM0Mw0PyMteAvLNEqxoEMfuDNc5n3leK7pCFewKMTUPpbE5c7qNzcaKHcXgnryGV7gRZaRq98YL7GBxn5ySUZOQBG/NwGA2Q8RWJ+EwrVR0GDt0qgQE7SIs0xyqTyYIFJNrH4hwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368572; c=relaxed/simple;
	bh=OysHOjbu4mCC1FJySJ5SqGX6ZoxBWOtcM5r3Z6/mCDo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rG1YjZc/rfNjO6MN5xjxLXvVD40RVsW2U6n2EtUbqiFt9zl70e+jvoWQtDXS9p0w8sa2Ybj5CgpxwH95Fj4C+QC9qWngNdCFLsF2b9axev/uO5/bcREu8n4yRSkUupC8djqpWrqSqN15BobWyTxqjv3TgHpvitGOJzVRvh98ENg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=InkpoY/2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730368569; x=1761904569;
  h=date:from:to:cc:subject:message-id;
  bh=OysHOjbu4mCC1FJySJ5SqGX6ZoxBWOtcM5r3Z6/mCDo=;
  b=InkpoY/2wYVKH1Bstou7W4KhogRRX+jBjEGY5OJObUgXNgYnFgWq47yb
   dUxVHLAJrkPA5jgT89iTEikeBF+YP/FxOx7H+9iLpI2cTZ/1PnfsubPD2
   22ILw2qEZAxGyli35uWr6kUi5J/qCvcy8nwNa3MqsKor1HNRK5QbllANv
   RCPXWj+RYld1jbLNpS/IzdijYNuttBEQmbub5TGemcCBct2Ga5xwDb0Nc
   Ddmd4dP46wViYxI02kGsLrSdKQ98Uq/Ph5iPrVvjezgPOteCB8QjdY9Gb
   86CWpaAuGyt34YCuD8v2m7IaMKu6Do8IyWwvKaRod214BcBDgCgt3fV3l
   g==;
X-CSE-ConnectionGUID: +IY28BsASJ6y0qodbqVZhw==
X-CSE-MsgGUID: YVfNuQTLTKGblcU03SIw6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40645569"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40645569"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 02:56:09 -0700
X-CSE-ConnectionGUID: Z7kxLNtYRJegL0cH+/9sag==
X-CSE-MsgGUID: OVcNC5EXSVSVgjUdwCiQ9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="83384579"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 31 Oct 2024 02:56:07 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6RuP-000fwu-13;
	Thu, 31 Oct 2024 09:56:05 +0000
Date: Thu, 31 Oct 2024 17:55:11 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 c05c62850a8f035a267151dd86ea3daf887e28b8
Message-ID: <202410311756.h5g6b7Ig-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: c05c62850a8f035a267151dd86ea3daf887e28b8  Merge tag 'wireless-2024-10-29' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

elapsed time: 1890m

configs tested: 128
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                            allyesconfig    gcc-13.3.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241031    gcc-13.2.0
arc                   randconfig-002-20241031    gcc-13.2.0
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                   randconfig-001-20241031    clang-17
arm                   randconfig-002-20241031    clang-20
arm                   randconfig-003-20241031    gcc-14.1.0
arm                   randconfig-004-20241031    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20241031    clang-20
arm64                 randconfig-002-20241031    clang-20
arm64                 randconfig-003-20241031    clang-15
arm64                 randconfig-004-20241031    clang-17
csky                              allnoconfig    gcc-14.1.0
csky                  randconfig-001-20241031    gcc-14.1.0
csky                  randconfig-002-20241031    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241031    clang-14
hexagon               randconfig-002-20241031    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241031    gcc-12
i386        buildonly-randconfig-002-20241031    clang-19
i386        buildonly-randconfig-003-20241031    gcc-12
i386        buildonly-randconfig-004-20241031    gcc-12
i386        buildonly-randconfig-005-20241031    clang-19
i386        buildonly-randconfig-006-20241031    gcc-11
i386                                defconfig    clang-19
i386                  randconfig-001-20241031    gcc-12
i386                  randconfig-002-20241031    clang-19
i386                  randconfig-003-20241031    gcc-11
i386                  randconfig-004-20241031    clang-19
i386                  randconfig-005-20241031    gcc-12
i386                  randconfig-006-20241031    clang-19
i386                  randconfig-011-20241031    clang-19
i386                  randconfig-012-20241031    clang-19
i386                  randconfig-013-20241031    clang-19
i386                  randconfig-014-20241031    gcc-11
i386                  randconfig-015-20241031    clang-19
i386                  randconfig-016-20241031    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20241031    gcc-14.1.0
loongarch             randconfig-002-20241031    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20241031    gcc-14.1.0
nios2                 randconfig-002-20241031    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                randconfig-001-20241031    gcc-14.1.0
parisc                randconfig-002-20241031    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc               randconfig-001-20241031    gcc-14.1.0
powerpc               randconfig-002-20241031    gcc-14.1.0
powerpc               randconfig-003-20241031    clang-20
powerpc64             randconfig-001-20241031    clang-15
powerpc64             randconfig-002-20241031    gcc-14.1.0
powerpc64             randconfig-003-20241031    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20241031    clang-20
riscv                 randconfig-002-20241031    clang-20
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                  randconfig-001-20241031    gcc-14.1.0
s390                  randconfig-002-20241031    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                    randconfig-001-20241031    gcc-14.1.0
sh                    randconfig-002-20241031    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64               randconfig-001-20241031    gcc-14.1.0
sparc64               randconfig-002-20241031    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
um                    randconfig-001-20241031    clang-20
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241031    clang-19
x86_64      buildonly-randconfig-002-20241031    clang-19
x86_64      buildonly-randconfig-003-20241031    clang-19
x86_64      buildonly-randconfig-004-20241031    gcc-12
x86_64      buildonly-randconfig-005-20241031    gcc-12
x86_64      buildonly-randconfig-006-20241031    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241031    gcc-12
x86_64                randconfig-002-20241031    gcc-12
x86_64                randconfig-003-20241031    clang-19
x86_64                randconfig-004-20241031    clang-19
x86_64                randconfig-005-20241031    clang-19
x86_64                randconfig-006-20241031    clang-19
x86_64                randconfig-011-20241031    clang-19
x86_64                randconfig-012-20241031    gcc-12
x86_64                randconfig-013-20241031    clang-19
x86_64                randconfig-014-20241031    gcc-12
x86_64                randconfig-015-20241031    gcc-12
x86_64                randconfig-016-20241031    clang-19
x86_64                randconfig-071-20241031    gcc-12
x86_64                randconfig-072-20241031    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


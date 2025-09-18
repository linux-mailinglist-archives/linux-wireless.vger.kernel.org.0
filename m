Return-Path: <linux-wireless+bounces-26999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02679B43690
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 11:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 528FB7A1164
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 09:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D752D6E78;
	Thu,  4 Sep 2025 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A7RjIyQS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59DE20110B
	for <linux-wireless@vger.kernel.org>; Thu,  4 Sep 2025 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976714; cv=none; b=WSciF++BhvD7GRQv9/Y09fWKzrqzPzzVJ1KZ6+ENvDtBf6i16iqpE5SoYPyDn0DYRlIcsZpPL418znbcljgp11OKnYXjHxk5Azrsii+xKSRAdmGXhdS1XozydxmqWS8pkUNh+S964/EEBE6ZaPEAHDTTmLete4CjyUGdsKjhr5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976714; c=relaxed/simple;
	bh=eCdbdo2JWZlRiSaVeOMwEaTBsX/saxP0lPjSZNNsh0k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OkmcFQGQMArgTaG6mQ1q6mh6OTOifwJEQbtlP7X5GkRmBcWtsr2hIde1yBlr0rj/Ae83E/jjhmbWoM+5NpCPSqv/Zvl/NUzbB2KvYi2d2O2aGBM+ebXw2g52dpre9lZ/gPml7mJ49nAD0z/5lyHf+EIovMvJ7gwOfEtqkRKGa3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A7RjIyQS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756976713; x=1788512713;
  h=date:from:to:cc:subject:message-id;
  bh=eCdbdo2JWZlRiSaVeOMwEaTBsX/saxP0lPjSZNNsh0k=;
  b=A7RjIyQSH7o4WNUeNPTq3sXegfEjEqXzjXCRpzbmpFqGui/ciQFpeGQ/
   a/IYPh3hHKnVJukzT96T7oBn1JLjjtJQipxpCFsSebW+SAUbaVajD/JFL
   f3++SoI7bDV/iLP7jIeVOqwf3UM/2wzPVXXvyof8p0rV0kWjJAUhkAh44
   bKFJcbXoKrutr+zamd3PHperX8mRm7+iS1lkhCFAN+uVCy7CtiYcZbcLk
   IoeN7IWfEh1x2b/LWJIV56U1kq8ca1bq/gAx3BTZ9tH7gPUd3sQ3Ntts0
   lbLY9PQq5YisXFUhTNshuVzxoTjTZ++GYx1SHr27fxg9RtE94QV+P24K0
   g==;
X-CSE-ConnectionGUID: ioFf2tbTQ1aeNJwcIfQGDg==
X-CSE-MsgGUID: VJRtLRP8Q+SBlwg8cZbUfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59164691"
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="59164691"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 02:05:12 -0700
X-CSE-ConnectionGUID: qKlVrgRSRMm5a/cFxF2X2Q==
X-CSE-MsgGUID: ZgoZppb1Som9VNT9n1ilfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="176184544"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 04 Sep 2025 02:05:10 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uu5u0-00050i-1C;
	Thu, 04 Sep 2025 09:05:08 +0000
Date: Thu, 04 Sep 2025 17:04:11 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 27893dd6341b929f87d45fc4d65c5778179319dd
Message-ID: <202509041705.IahAjxij-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 27893dd6341b929f87d45fc4d65c5778179319dd  Merge tag 'ath-current-20250902' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

elapsed time: 1458m

configs tested: 159
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250903    gcc-15.1.0
arc                   randconfig-001-20250904    gcc-9.5.0
arc                   randconfig-002-20250903    gcc-8.5.0
arc                   randconfig-002-20250904    gcc-11.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250903    clang-22
arm                   randconfig-001-20250904    gcc-10.5.0
arm                   randconfig-002-20250903    clang-16
arm                   randconfig-002-20250904    gcc-13.4.0
arm                   randconfig-003-20250903    clang-22
arm                   randconfig-003-20250904    gcc-8.5.0
arm                   randconfig-004-20250903    clang-22
arm                   randconfig-004-20250904    gcc-13.4.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250903    gcc-8.5.0
arm64                 randconfig-001-20250904    gcc-8.5.0
arm64                 randconfig-002-20250903    gcc-11.5.0
arm64                 randconfig-002-20250904    gcc-8.5.0
arm64                 randconfig-003-20250903    clang-22
arm64                 randconfig-003-20250904    clang-22
arm64                 randconfig-004-20250903    clang-22
arm64                 randconfig-004-20250904    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250903    gcc-9.5.0
csky                  randconfig-001-20250904    gcc-15.1.0
csky                  randconfig-002-20250903    gcc-15.1.0
csky                  randconfig-002-20250904    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250903    clang-22
hexagon               randconfig-001-20250904    clang-22
hexagon               randconfig-002-20250903    clang-18
hexagon               randconfig-002-20250904    clang-20
i386                             allmodconfig    gcc-13
i386                              allnoconfig    gcc-13
i386                             allyesconfig    gcc-13
i386        buildonly-randconfig-001-20250903    gcc-13
i386        buildonly-randconfig-001-20250904    clang-20
i386        buildonly-randconfig-002-20250903    gcc-13
i386        buildonly-randconfig-002-20250904    gcc-12
i386        buildonly-randconfig-003-20250903    clang-20
i386        buildonly-randconfig-003-20250904    gcc-13
i386        buildonly-randconfig-004-20250903    clang-20
i386        buildonly-randconfig-004-20250904    gcc-13
i386        buildonly-randconfig-005-20250903    clang-20
i386        buildonly-randconfig-005-20250904    clang-20
i386        buildonly-randconfig-006-20250903    clang-20
i386        buildonly-randconfig-006-20250904    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250903    gcc-15.1.0
loongarch             randconfig-001-20250904    gcc-15.1.0
loongarch             randconfig-002-20250903    clang-22
loongarch             randconfig-002-20250904    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20250903    gcc-10.5.0
nios2                 randconfig-001-20250904    gcc-11.5.0
nios2                 randconfig-002-20250903    gcc-10.5.0
nios2                 randconfig-002-20250904    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                randconfig-001-20250903    gcc-13.4.0
parisc                randconfig-001-20250904    gcc-8.5.0
parisc                randconfig-002-20250903    gcc-15.1.0
parisc                randconfig-002-20250904    gcc-11.5.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250903    gcc-8.5.0
powerpc               randconfig-001-20250904    clang-19
powerpc               randconfig-002-20250903    gcc-8.5.0
powerpc               randconfig-002-20250904    gcc-13.4.0
powerpc               randconfig-003-20250903    gcc-14.3.0
powerpc               randconfig-003-20250904    clang-22
powerpc64             randconfig-001-20250903    clang-22
powerpc64             randconfig-001-20250904    gcc-15.1.0
powerpc64             randconfig-002-20250903    clang-22
powerpc64             randconfig-002-20250904    clang-22
powerpc64             randconfig-003-20250903    clang-22
powerpc64             randconfig-003-20250904    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250903    gcc-8.5.0
riscv                 randconfig-001-20250904    gcc-8.5.0
riscv                 randconfig-002-20250903    gcc-9.5.0
riscv                 randconfig-002-20250904    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250903    gcc-8.5.0
s390                  randconfig-001-20250904    gcc-10.5.0
s390                  randconfig-002-20250903    clang-22
s390                  randconfig-002-20250904    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250903    gcc-12.5.0
sh                    randconfig-001-20250904    gcc-12.5.0
sh                    randconfig-002-20250903    gcc-10.5.0
sh                    randconfig-002-20250904    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250903    gcc-11.5.0
sparc                 randconfig-001-20250904    gcc-11.5.0
sparc                 randconfig-002-20250903    gcc-15.1.0
sparc                 randconfig-002-20250904    gcc-15.1.0
sparc64               randconfig-001-20250903    gcc-8.5.0
sparc64               randconfig-001-20250904    gcc-12.5.0
sparc64               randconfig-002-20250903    gcc-11.5.0
sparc64               randconfig-002-20250904    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-13
um                    randconfig-001-20250903    gcc-13
um                    randconfig-001-20250904    gcc-13
um                    randconfig-002-20250903    clang-18
um                    randconfig-002-20250904    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250903    clang-20
x86_64      buildonly-randconfig-001-20250904    gcc-12
x86_64      buildonly-randconfig-002-20250903    clang-20
x86_64      buildonly-randconfig-002-20250904    clang-20
x86_64      buildonly-randconfig-003-20250903    clang-20
x86_64      buildonly-randconfig-003-20250904    gcc-13
x86_64      buildonly-randconfig-004-20250903    gcc-13
x86_64      buildonly-randconfig-004-20250904    gcc-13
x86_64      buildonly-randconfig-005-20250903    clang-20
x86_64      buildonly-randconfig-005-20250904    gcc-13
x86_64      buildonly-randconfig-006-20250903    gcc-13
x86_64      buildonly-randconfig-006-20250904    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250903    gcc-11.5.0
xtensa                randconfig-001-20250904    gcc-10.5.0
xtensa                randconfig-002-20250903    gcc-14.3.0
xtensa                randconfig-002-20250904    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


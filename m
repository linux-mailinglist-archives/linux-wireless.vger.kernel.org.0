Return-Path: <linux-wireless+bounces-10554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7231C93DD05
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 04:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942881C2184D
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 02:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B36015BB;
	Sat, 27 Jul 2024 02:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ce8orNGI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D191FA1
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2024 02:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722046456; cv=none; b=RzSGoovoOZpIN0fkWZOnRtKbDCet9Oyiu1U7uW/ZQZCyDHjl4QPxtvt4CiVqnjGz1/vxqWzWAGHYzoFWhCSbdYqtRGfXKlh8rZO2CPeLB86fFzi0s6JcuzBFVRegh3zTLW1HKsY2rrzNxxHW4Wl7aTlpMnudsOpjnCrbHy9cEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722046456; c=relaxed/simple;
	bh=QoJEGKyCWe7ut8qvK7M4paWzMfSL0lyx18nSRpGe0TY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ufZWarErdddZW04LAE0dpUajF6YYd0cn8iAKNrCvcnmYDkaBYn1tjVEJiXGGK3TnhjsGiEZ2UKabSZL2IXXEFB1Q8oYAY6MXcxzNNd4w16msUoBZycOY3541dLLqmHz8bNOXfau/SquGrTcIogvOauzMLiFN3GPjIJqrO26ypEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ce8orNGI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722046454; x=1753582454;
  h=date:from:to:cc:subject:message-id;
  bh=QoJEGKyCWe7ut8qvK7M4paWzMfSL0lyx18nSRpGe0TY=;
  b=ce8orNGIAupHJivNo5iphJszfBcMwY4fu4uJ6J9hpxWm4r1jKtMbR89i
   nqyqG7LeeYPEq/svo/F8+RtO9/yUIe69iXPyblVmnJl+2gi3SGrjXiORG
   JH2WtC5WcxaOATpfFCp70MUjTBBVtMXPbcLswrWrrHOIhcOnH9QPLG/+K
   yezd21ttpDltNxZkeZuBM3pHwLUrXmle3kFGaQ3YRiusGo0oNnaO7RDZ+
   W6TtfDA7HI+zVDucaKgLKhF7O9ltI74LRFRiTXgBZR7anLUM5p0EMejE/
   lP6+KWI9bqkKdBnYq7na4cYCTxZSfmpsmrvl2N/q74ercrfjuSWrr/0wT
   Q==;
X-CSE-ConnectionGUID: B8IyVSXERhqopUPHYBbPIQ==
X-CSE-MsgGUID: Jb8bR2j/Q7aiAGZrfGJQfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11145"; a="20010968"
X-IronPort-AV: E=Sophos;i="6.09,240,1716274800"; 
   d="scan'208";a="20010968"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 19:14:14 -0700
X-CSE-ConnectionGUID: Zw8IgAh7RaqSKgEnFOgw5w==
X-CSE-MsgGUID: 1pwkup7fRqOBOl2m7Fxkbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,240,1716274800"; 
   d="scan'208";a="53110169"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 26 Jul 2024 19:14:12 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXWwk-000pZ0-0h;
	Sat, 27 Jul 2024 02:14:10 +0000
Date: Sat, 27 Jul 2024 10:13:18 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 a47f3320bb4ba6714abe8dddb36399367b491358
Message-ID: <202407271015.uqh4gjUf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: a47f3320bb4ba6714abe8dddb36399367b491358  wifi: ath12k: fix soft lockup on suspend

elapsed time: 830m

configs tested: 209
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     nsimosci_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240727   gcc-13.2.0
arc                   randconfig-002-20240727   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                            mmp2_defconfig   gcc-13.2.0
arm                          pxa910_defconfig   gcc-13.2.0
arm                   randconfig-001-20240727   gcc-14.1.0
arm                   randconfig-002-20240727   gcc-14.1.0
arm                   randconfig-003-20240727   clang-17
arm                   randconfig-004-20240727   gcc-14.1.0
arm                        vexpress_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240727   clang-20
arm64                 randconfig-002-20240727   gcc-14.1.0
arm64                 randconfig-003-20240727   gcc-14.1.0
arm64                 randconfig-004-20240727   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240727   gcc-14.1.0
csky                  randconfig-002-20240727   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240727   clang-20
hexagon               randconfig-002-20240727   clang-20
i386                             allmodconfig   gcc-13
i386                              allnoconfig   gcc-13
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240726   gcc-13
i386         buildonly-randconfig-001-20240727   gcc-13
i386         buildonly-randconfig-002-20240726   clang-18
i386         buildonly-randconfig-002-20240727   gcc-13
i386         buildonly-randconfig-003-20240726   gcc-13
i386         buildonly-randconfig-003-20240727   gcc-13
i386         buildonly-randconfig-004-20240726   clang-18
i386         buildonly-randconfig-004-20240727   gcc-13
i386         buildonly-randconfig-005-20240726   gcc-7
i386         buildonly-randconfig-005-20240727   gcc-13
i386         buildonly-randconfig-006-20240726   clang-18
i386         buildonly-randconfig-006-20240727   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240726   gcc-13
i386                  randconfig-001-20240727   gcc-13
i386                  randconfig-002-20240726   gcc-13
i386                  randconfig-002-20240727   gcc-13
i386                  randconfig-003-20240726   clang-18
i386                  randconfig-003-20240727   gcc-13
i386                  randconfig-004-20240726   gcc-13
i386                  randconfig-004-20240727   gcc-13
i386                  randconfig-005-20240726   clang-18
i386                  randconfig-005-20240727   gcc-13
i386                  randconfig-006-20240726   clang-18
i386                  randconfig-006-20240727   gcc-13
i386                  randconfig-011-20240726   gcc-13
i386                  randconfig-011-20240727   gcc-13
i386                  randconfig-012-20240726   gcc-8
i386                  randconfig-012-20240727   gcc-13
i386                  randconfig-013-20240726   gcc-10
i386                  randconfig-013-20240727   gcc-13
i386                  randconfig-014-20240726   gcc-13
i386                  randconfig-014-20240727   gcc-13
i386                  randconfig-015-20240726   clang-18
i386                  randconfig-015-20240727   gcc-13
i386                  randconfig-016-20240726   gcc-13
i386                  randconfig-016-20240727   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240727   gcc-14.1.0
loongarch             randconfig-002-20240727   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                            q40_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                       bmips_be_defconfig   gcc-13.2.0
mips                           ci20_defconfig   gcc-13.2.0
mips                           ip28_defconfig   gcc-13.2.0
mips                     loongson1c_defconfig   gcc-13.2.0
mips                           xway_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240727   gcc-14.1.0
nios2                 randconfig-002-20240727   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240727   gcc-14.1.0
parisc                randconfig-002-20240727   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                       ebony_defconfig   gcc-13.2.0
powerpc                        icon_defconfig   gcc-13.2.0
powerpc                  mpc866_ads_defconfig   gcc-13.2.0
powerpc               randconfig-003-20240727   clang-20
powerpc64             randconfig-003-20240727   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240727   gcc-14.1.0
riscv                 randconfig-002-20240727   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240727   gcc-14.1.0
s390                  randconfig-002-20240727   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240727   gcc-14.1.0
sh                    randconfig-002-20240727   gcc-14.1.0
sh                          rsk7264_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240727   gcc-14.1.0
sparc64               randconfig-002-20240727   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240727   gcc-13
um                    randconfig-002-20240727   gcc-13
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240726   gcc-13
x86_64       buildonly-randconfig-001-20240727   gcc-8
x86_64       buildonly-randconfig-002-20240726   gcc-13
x86_64       buildonly-randconfig-002-20240727   gcc-8
x86_64       buildonly-randconfig-003-20240726   clang-18
x86_64       buildonly-randconfig-003-20240727   gcc-8
x86_64       buildonly-randconfig-004-20240726   gcc-9
x86_64       buildonly-randconfig-004-20240727   gcc-8
x86_64       buildonly-randconfig-005-20240726   gcc-13
x86_64       buildonly-randconfig-005-20240727   gcc-8
x86_64       buildonly-randconfig-006-20240726   gcc-11
x86_64       buildonly-randconfig-006-20240727   gcc-8
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240726   gcc-13
x86_64                randconfig-001-20240727   gcc-8
x86_64                randconfig-002-20240726   gcc-8
x86_64                randconfig-002-20240727   gcc-8
x86_64                randconfig-003-20240726   gcc-13
x86_64                randconfig-003-20240727   gcc-8
x86_64                randconfig-004-20240726   gcc-13
x86_64                randconfig-004-20240727   gcc-8
x86_64                randconfig-005-20240726   gcc-13
x86_64                randconfig-005-20240727   gcc-8
x86_64                randconfig-006-20240726   gcc-10
x86_64                randconfig-006-20240727   gcc-8
x86_64                randconfig-011-20240726   gcc-11
x86_64                randconfig-011-20240727   gcc-8
x86_64                randconfig-012-20240726   clang-18
x86_64                randconfig-012-20240727   gcc-8
x86_64                randconfig-013-20240726   gcc-13
x86_64                randconfig-013-20240727   gcc-8
x86_64                randconfig-014-20240726   clang-18
x86_64                randconfig-014-20240727   gcc-8
x86_64                randconfig-015-20240726   gcc-11
x86_64                randconfig-015-20240727   gcc-8
x86_64                randconfig-016-20240726   clang-18
x86_64                randconfig-016-20240727   gcc-8
x86_64                randconfig-071-20240726   clang-18
x86_64                randconfig-071-20240727   gcc-8
x86_64                randconfig-072-20240726   clang-18
x86_64                randconfig-072-20240727   gcc-8
x86_64                randconfig-073-20240726   gcc-13
x86_64                randconfig-073-20240727   gcc-8
x86_64                randconfig-074-20240726   clang-18
x86_64                randconfig-074-20240727   gcc-8
x86_64                randconfig-075-20240726   gcc-7
x86_64                randconfig-075-20240727   gcc-8
x86_64                randconfig-076-20240726   gcc-11
x86_64                randconfig-076-20240727   gcc-8
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240727   gcc-14.1.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


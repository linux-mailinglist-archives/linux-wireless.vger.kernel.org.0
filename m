Return-Path: <linux-wireless+bounces-12873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF7F9797A3
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Sep 2024 17:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB92E28258F
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Sep 2024 15:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E904E1C7B7D;
	Sun, 15 Sep 2024 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mviL7XJT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D9D1C7B76
	for <linux-wireless@vger.kernel.org>; Sun, 15 Sep 2024 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726415273; cv=none; b=QXb6ZwHxv8zXCnrgsLysJZH/Kib8Nl3s/dREhAe+KBOyW4ofOz0XO8Rn1pvOgZ4lcB4vtKu0Ihf23FDf1c30Nvr91KGZen0jC3BUMsJDSea7B+t6E5MP879Kc11lCh3tx8vbz0FVG5XcutOSgpEV7utmjmvMExIHIqCByIQMUSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726415273; c=relaxed/simple;
	bh=kbgbPsz2jaJ8ZukTTiXPB4tr4DKpcuSnDfzgd+f2eTg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RGy7tOXnXJoztABtX9fq19+UXjER7hvu8UI8513G+4BLbJ7YswVVVcFeAUbZCy2zScek1mbhLf3fS3D3RB+H5cfCIcK32lZbw2YdXUq/MyW69bzAQ4hqhejvxxYkJ11J/d0Gbiblj1S+s07lnEHiD2jIWp/xxti3ughRKDOJWYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mviL7XJT; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726415272; x=1757951272;
  h=date:from:to:cc:subject:message-id;
  bh=kbgbPsz2jaJ8ZukTTiXPB4tr4DKpcuSnDfzgd+f2eTg=;
  b=mviL7XJThXBZgLnyZ0rwWi/9rZs0Ut6VuIweAvERXl+0ehFJos8vF4iX
   LML4796dNYb2XCBHrj7/iH0Vd1c+3w10iaG7rPutwBc2wrmSi5cAOHIxs
   LEQxQKFlCk3QSAPkm8WDqqFgvLpKmHaccdfcxhvjsZjjQWIs9Hs0qSnFe
   k3KtNOH2dv9Hsa/tIKnHGEYqtzagHoASk4BW2EMRtqeTf8hTMCy4724gt
   vUXcGSJmn2k+ff0JULIcNbUbv5MjA5fVdJ71A/aZTxNOiWzqB15YLc7l2
   AQbRR3eSO+VIM8cc604PlN/EGmneDYpy90lnxbdXss9a89nUogfqqyHHj
   w==;
X-CSE-ConnectionGUID: RgbSpnu6Rgu9Sjy/XLtmkA==
X-CSE-MsgGUID: WAJLi3KUSvOe7/tSGYhTSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="28172766"
X-IronPort-AV: E=Sophos;i="6.10,231,1719903600"; 
   d="scan'208";a="28172766"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2024 08:47:51 -0700
X-CSE-ConnectionGUID: HM7BePQOQt6o5iZTTrMcuw==
X-CSE-MsgGUID: 880AGBLnQYmzoLgMZuNWfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,231,1719903600"; 
   d="scan'208";a="69418233"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 15 Sep 2024 08:47:49 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sprTW-0008mw-2d;
	Sun, 15 Sep 2024 15:47:46 +0000
Date: Sun, 15 Sep 2024 23:47:10 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 34c44eb31de9cb7202ff070900463d6c706392c4
Message-ID: <202409152305.11ovBA67-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 34c44eb31de9cb7202ff070900463d6c706392c4  Merge branch 'net-ibm-emac-modernize-a-bit'

elapsed time: 2087m

configs tested: 105
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                            allyesconfig    gcc-13.3.0
alpha                               defconfig    gcc-13.3.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                      axs103_smp_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20240915    gcc-13.2.0
arc                   randconfig-002-20240915    gcc-13.2.0
arc                    vdk_hs38_smp_defconfig    gcc-13.2.0
arm                              allmodconfig    gcc-14.1.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.1.0
arm                          ixp4xx_defconfig    gcc-14.1.0
arm                   randconfig-001-20240915    gcc-14.1.0
arm                   randconfig-002-20240915    clang-17
arm                   randconfig-003-20240915    clang-20
arm                   randconfig-004-20240915    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20240915    clang-20
arm64                 randconfig-002-20240915    gcc-14.1.0
arm64                 randconfig-003-20240915    clang-20
arm64                 randconfig-004-20240915    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                  randconfig-001-20240915    gcc-14.1.0
csky                  randconfig-002-20240915    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20240915    clang-20
hexagon               randconfig-002-20240915    clang-16
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240915    gcc-12
i386        buildonly-randconfig-002-20240915    clang-18
i386        buildonly-randconfig-003-20240915    clang-18
i386        buildonly-randconfig-004-20240915    gcc-12
i386        buildonly-randconfig-005-20240915    clang-18
i386        buildonly-randconfig-006-20240915    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20240915    clang-18
i386                  randconfig-002-20240915    clang-18
i386                  randconfig-003-20240915    clang-18
i386                  randconfig-004-20240915    clang-18
i386                  randconfig-005-20240915    clang-18
i386                  randconfig-006-20240915    clang-18
i386                  randconfig-011-20240915    clang-18
i386                  randconfig-012-20240915    gcc-12
i386                  randconfig-013-20240915    gcc-12
i386                  randconfig-014-20240915    clang-18
i386                  randconfig-015-20240915    gcc-12
i386                  randconfig-016-20240915    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20240915    gcc-14.1.0
loongarch             randconfig-002-20240915    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20240915    gcc-14.1.0
nios2                 randconfig-002-20240915    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                              defconfig    gcc-14.1.0
parisc                randconfig-001-20240915    gcc-14.1.0
parisc                randconfig-002-20240915    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    clang-20
powerpc               randconfig-001-20240915    gcc-14.1.0
powerpc               randconfig-002-20240915    gcc-14.1.0
powerpc               randconfig-003-20240915    gcc-14.1.0
powerpc64             randconfig-001-20240915    clang-20
powerpc64             randconfig-002-20240915    clang-20
powerpc64             randconfig-003-20240915    gcc-14.1.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                               defconfig    clang-20
riscv                 randconfig-001-20240915    clang-15
riscv                 randconfig-002-20240915    clang-20
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                  randconfig-001-20240915    clang-20
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-14.1.0
sh                    randconfig-001-20240915    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


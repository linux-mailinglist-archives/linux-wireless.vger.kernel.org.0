Return-Path: <linux-wireless+bounces-24621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D55AEBD81
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 18:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F36E168142
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 16:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15D52E54D5;
	Fri, 27 Jun 2025 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xq5YwjMZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CE22EA727
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751042006; cv=none; b=t3VCc6b2PkEzf1aSJxW0oxzx68KrtmOlCBnKNFr6jJBSdZ+uaejqxa//9WX4JKQLlq58qrI1HflEJD64/YlucYsq39Dd673KBidQ62DURoCFLQ3nUjb/Kld0d3NGXMde6kBh6W5HzMjyL3fBbmFlEs3/UE8QqGlUUEar4nNyzis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751042006; c=relaxed/simple;
	bh=RBz9TnD9zD0oVxUQLTUy0FbPgYOTYKN2SnFjblljTSo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SpT9CvneN61mbJTJXnfQZeBFJy0/hFdYMzd9dneqoB7ny3w98nRJQX8sMbpdIepfa7nN2f8n8p4s7QTUqoMxQOp+6gJKfOl9y2JBHXtoBeIBt+y4mrFCALtVBuWawbG11DCNlD42nwqPljYYPu9FJ4ovjhZLCpTpuK9B8eyzVk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xq5YwjMZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751042006; x=1782578006;
  h=date:from:to:cc:subject:message-id;
  bh=RBz9TnD9zD0oVxUQLTUy0FbPgYOTYKN2SnFjblljTSo=;
  b=Xq5YwjMZWfr2FQzvTVOOcOxdFz9AP9UoLQZn8yiDg6LBFcO/YEHL2mw9
   uuuJCkufbxA0Gi2RpGr0362hOIPpy1bTFTuVFIQ9jp6amFTWH/zoVEyEd
   bAY08i/okNFl1Yw41xS7/PO7MhqOPxsx3JDx7G23tQX6vVR+iXNZfMreJ
   HR926hE5pJXrWCdBwtU4MjTMgOoPgn8rRHfknz0zW72L0yug68/3NaB4h
   0NG7qk7RWa4ezD1hlSbn4xFpGPzsV9mHSeoq/Qzo4e1jTzBMPJKGKa9Mk
   OEO3U0FGQmYp8aoL/Q5q+kkFqYr+XWvDQ8ZPJE02woxpQVgKz7FNAqume
   Q==;
X-CSE-ConnectionGUID: NpXHA2flTROFnHeWU1W/bA==
X-CSE-MsgGUID: PtMyUdGBTu+d+64UWW91lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="64416686"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="64416686"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 09:33:25 -0700
X-CSE-ConnectionGUID: qvYq44D6RziRKjq/Dqkl7Q==
X-CSE-MsgGUID: Ytbv3KVoQ3q3HOOpLrHhjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="153333856"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 27 Jun 2025 09:33:22 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVC0u-000WNM-1t;
	Fri, 27 Jun 2025 16:33:20 +0000
Date: Sat, 28 Jun 2025 00:32:34 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 28aa52b6189f1cc409f96910c63fa1b99370b99e
Message-ID: <202506280024.PaMgwRrE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 28aa52b6189f1cc409f96910c63fa1b99370b99e  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

elapsed time: 1307m

configs tested: 192
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250627    gcc-10.5.0
arc                   randconfig-001-20250627    gcc-8.5.0
arc                   randconfig-002-20250627    gcc-10.5.0
arc                   randconfig-002-20250627    gcc-12.4.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250627    gcc-10.5.0
arm                   randconfig-001-20250627    gcc-15.1.0
arm                   randconfig-002-20250627    gcc-10.5.0
arm                   randconfig-003-20250627    clang-21
arm                   randconfig-003-20250627    gcc-10.5.0
arm                   randconfig-004-20250627    gcc-10.5.0
arm                   randconfig-004-20250627    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250627    clang-17
arm64                 randconfig-001-20250627    gcc-10.5.0
arm64                 randconfig-002-20250627    gcc-10.5.0
arm64                 randconfig-003-20250627    gcc-10.5.0
arm64                 randconfig-003-20250627    gcc-12.3.0
arm64                 randconfig-004-20250627    clang-19
arm64                 randconfig-004-20250627    gcc-10.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250627    clang-21
csky                  randconfig-001-20250627    gcc-15.1.0
csky                  randconfig-002-20250627    clang-21
csky                  randconfig-002-20250627    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250627    clang-21
hexagon               randconfig-002-20250627    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250627    gcc-12
i386        buildonly-randconfig-002-20250627    gcc-12
i386        buildonly-randconfig-003-20250627    gcc-12
i386        buildonly-randconfig-004-20250627    gcc-12
i386        buildonly-randconfig-005-20250627    clang-20
i386        buildonly-randconfig-005-20250627    gcc-12
i386        buildonly-randconfig-006-20250627    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-011-20250627    gcc-12
i386                  randconfig-012-20250627    gcc-12
i386                  randconfig-013-20250627    gcc-12
i386                  randconfig-014-20250627    gcc-12
i386                  randconfig-015-20250627    gcc-12
i386                  randconfig-016-20250627    gcc-12
i386                  randconfig-017-20250627    gcc-12
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250627    clang-21
loongarch             randconfig-001-20250627    gcc-15.1.0
loongarch             randconfig-002-20250627    clang-21
loongarch             randconfig-002-20250627    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         amcore_defconfig    clang-21
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250627    clang-21
nios2                 randconfig-001-20250627    gcc-8.5.0
nios2                 randconfig-002-20250627    clang-21
nios2                 randconfig-002-20250627    gcc-8.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                randconfig-001-20250627    clang-21
parisc                randconfig-001-20250627    gcc-9.3.0
parisc                randconfig-002-20250627    clang-21
parisc                randconfig-002-20250627    gcc-8.5.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                    amigaone_defconfig    clang-21
powerpc                        fsp2_defconfig    clang-21
powerpc               mpc834x_itxgp_defconfig    clang-21
powerpc               randconfig-001-20250627    clang-21
powerpc               randconfig-001-20250627    gcc-15.1.0
powerpc               randconfig-002-20250627    clang-21
powerpc               randconfig-003-20250627    clang-21
powerpc               randconfig-003-20250627    gcc-15.1.0
powerpc                     taishan_defconfig    clang-21
powerpc64             randconfig-001-20250627    clang-21
powerpc64             randconfig-001-20250627    gcc-12.4.0
powerpc64             randconfig-002-20250627    clang-21
powerpc64             randconfig-002-20250627    gcc-10.5.0
powerpc64             randconfig-003-20250627    clang-21
powerpc64             randconfig-003-20250627    gcc-8.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250627    gcc-11.5.0
riscv                 randconfig-001-20250627    gcc-8.5.0
riscv                 randconfig-002-20250627    gcc-11.5.0
riscv                 randconfig-002-20250627    gcc-13.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250627    clang-21
s390                  randconfig-001-20250627    gcc-11.5.0
s390                  randconfig-002-20250627    clang-21
s390                  randconfig-002-20250627    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250627    gcc-11.5.0
sh                    randconfig-001-20250627    gcc-9.3.0
sh                    randconfig-002-20250627    gcc-11.5.0
sh                    randconfig-002-20250627    gcc-15.1.0
sh                          sdk7786_defconfig    clang-21
sh                           se7343_defconfig    clang-21
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250627    gcc-11.5.0
sparc                 randconfig-002-20250627    gcc-11.5.0
sparc                 randconfig-002-20250627    gcc-8.5.0
sparc64                          alldefconfig    clang-21
sparc64               randconfig-001-20250627    gcc-11.5.0
sparc64               randconfig-002-20250627    gcc-11.5.0
sparc64               randconfig-002-20250627    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                    randconfig-001-20250627    gcc-11.5.0
um                    randconfig-001-20250627    gcc-12
um                    randconfig-002-20250627    gcc-11.5.0
um                    randconfig-002-20250627    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250627    clang-20
x86_64      buildonly-randconfig-002-20250627    clang-20
x86_64      buildonly-randconfig-003-20250627    clang-20
x86_64      buildonly-randconfig-004-20250627    clang-20
x86_64      buildonly-randconfig-005-20250627    clang-20
x86_64      buildonly-randconfig-005-20250627    gcc-12
x86_64      buildonly-randconfig-006-20250627    clang-20
x86_64      buildonly-randconfig-006-20250627    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250627    clang-20
x86_64                randconfig-002-20250627    clang-20
x86_64                randconfig-003-20250627    clang-20
x86_64                randconfig-004-20250627    clang-20
x86_64                randconfig-005-20250627    clang-20
x86_64                randconfig-006-20250627    clang-20
x86_64                randconfig-007-20250627    clang-20
x86_64                randconfig-008-20250627    clang-20
x86_64                randconfig-071-20250627    gcc-12
x86_64                randconfig-072-20250627    gcc-12
x86_64                randconfig-073-20250627    gcc-12
x86_64                randconfig-074-20250627    gcc-12
x86_64                randconfig-075-20250627    gcc-12
x86_64                randconfig-076-20250627    gcc-12
x86_64                randconfig-077-20250627    gcc-12
x86_64                randconfig-078-20250627    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250627    gcc-11.5.0
xtensa                randconfig-001-20250627    gcc-13.3.0
xtensa                randconfig-002-20250627    gcc-10.5.0
xtensa                randconfig-002-20250627    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


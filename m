Return-Path: <linux-wireless+bounces-8972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD8F90710D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 14:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683F11C247F3
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 12:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C84428FF;
	Thu, 13 Jun 2024 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZDvHpm9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BF12F5A
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281986; cv=none; b=jVf3EXPn59IzsaISySCofpLTDXx1pM9CwDtZP/UUNN15ri0Jm7D9sJQzsJD+BarVBXr1XDDl+/Tf6WnbaYeBpz2gu3uUT83/oJCICzlw+LnZXWk1NDUAKGpOdVtoxf2YnAt4JKiQewzfy4zkt7rW7gMTG/x23haRqg6ewT9TRok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281986; c=relaxed/simple;
	bh=Y2H6zYNTlwW4ui1zwox4FSiGzQDy3cGU1grMKwM+ivQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=g4y3h3rNJVe0iMDyMolq+vgJCVf4TK342cOE8kq3LdhBsxuUMhoxgxiDWtB2x5Km+5I87YF0RnMh9fTb4pkZMPoB4sGKK1Ipc3F0HAs5tHWZ/9cn0nQMKF7WoUMdl41BXZLVS34LpMqMKqo92yF4xROQjo9qncln1WRMavomf6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZDvHpm9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718281985; x=1749817985;
  h=date:from:to:cc:subject:message-id;
  bh=Y2H6zYNTlwW4ui1zwox4FSiGzQDy3cGU1grMKwM+ivQ=;
  b=nZDvHpm94TM1HBTP7GP/QJ2iZ/OzfJeaNqphD/jE0TPqmCNl6Mn3Yoxm
   wG+y9ffpo0on0puyIXCjzGIXZp4XSmrZvAKOq4Wk9LnBB47N5qXdRoOos
   65QxK6T+yLR1RAZD/vrF2ThBJWTUYsosiZH2Aa4WJB3O+OH7sw3Y5tf15
   +eFwmWTyV4v8ajVolDBDRciZfzPu0WvrQZCWwJs53R2f3MQiftZSNgbeK
   /Ux0IpFVmvb9V83bR7zf6GAHR6yiPm0FLpwHCRmVGHBX2Y8GTg1MLDFRw
   gfpLryn9YP82Rzyyq2jwMMQWZk/ygv+Mt7dvDyuPmkRx3QxVKzu8CiLtF
   Q==;
X-CSE-ConnectionGUID: WYZEchLIRCS+wqiL9mybIQ==
X-CSE-MsgGUID: veBeNc/nQHu8SDGIiMXsxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="18920319"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="18920319"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 05:33:05 -0700
X-CSE-ConnectionGUID: ub/7wRU6TNOuam+6KTnWSw==
X-CSE-MsgGUID: GVnFYR/PQxeig0ZZNHTZ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="45037177"
Received: from lkp-server01.sh.intel.com (HELO 0b1fe898bbad) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 13 Jun 2024 05:33:04 -0700
Received: from kbuild by 0b1fe898bbad with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sHjdV-00004I-0h;
	Thu, 13 Jun 2024 12:33:01 +0000
Date: Thu, 13 Jun 2024 20:32:56 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 7d09e17c0415fe6d946044c7e70bce31cda952ec
Message-ID: <202406132053.zaTEj1lR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 7d09e17c0415fe6d946044c7e70bce31cda952ec  wifi: mac80211: Recalc offload when monitor stop

elapsed time: 1521m

configs tested: 102
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240613   gcc-13.2.0
arc                   randconfig-002-20240613   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                                 defconfig   clang-14
arm                   randconfig-001-20240613   gcc-13.2.0
arm                   randconfig-002-20240613   clang-17
arm                   randconfig-003-20240613   clang-19
arm                   randconfig-004-20240613   clang-19
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240613   gcc-13.2.0
arm64                 randconfig-002-20240613   clang-19
arm64                 randconfig-003-20240613   clang-19
arm64                 randconfig-004-20240613   clang-19
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240613   gcc-13.2.0
csky                  randconfig-002-20240613   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240613   clang-19
hexagon               randconfig-002-20240613   clang-15
i386         buildonly-randconfig-001-20240613   gcc-9
i386         buildonly-randconfig-002-20240613   clang-18
i386         buildonly-randconfig-003-20240613   clang-18
i386         buildonly-randconfig-004-20240613   clang-18
i386         buildonly-randconfig-005-20240613   gcc-7
i386         buildonly-randconfig-006-20240613   clang-18
i386                  randconfig-001-20240613   gcc-7
i386                  randconfig-002-20240613   gcc-11
i386                  randconfig-003-20240613   gcc-13
i386                  randconfig-004-20240613   clang-18
i386                  randconfig-005-20240613   gcc-13
i386                  randconfig-006-20240613   gcc-13
i386                  randconfig-011-20240613   gcc-13
i386                  randconfig-012-20240613   clang-18
i386                  randconfig-013-20240613   clang-18
i386                  randconfig-014-20240613   gcc-12
i386                  randconfig-015-20240613   gcc-8
i386                  randconfig-016-20240613   gcc-13
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240613   gcc-13.2.0
loongarch             randconfig-002-20240613   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240613   gcc-13.2.0
nios2                 randconfig-002-20240613   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240613   gcc-13.2.0
parisc                randconfig-002-20240613   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240613   clang-19
powerpc               randconfig-002-20240613   clang-19
powerpc               randconfig-003-20240613   clang-19
powerpc64             randconfig-001-20240613   clang-19
powerpc64             randconfig-002-20240613   clang-19
powerpc64             randconfig-003-20240613   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
riscv                 randconfig-001-20240613   clang-19
riscv                 randconfig-002-20240613   clang-19
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
s390                  randconfig-001-20240613   gcc-13.2.0
s390                  randconfig-002-20240613   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                    randconfig-001-20240613   gcc-13.2.0
sh                    randconfig-002-20240613   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240613   gcc-13.2.0
sparc64               randconfig-002-20240613   gcc-13.2.0
um                               allmodconfig   clang-19
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                    randconfig-001-20240613   gcc-9
um                    randconfig-002-20240613   gcc-9
um                           x86_64_defconfig   clang-15
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240613   gcc-13.2.0
xtensa                randconfig-002-20240613   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


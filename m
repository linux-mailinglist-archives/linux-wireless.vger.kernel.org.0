Return-Path: <linux-wireless+bounces-12765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 872E5973904
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 15:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0DC91C20F5E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 13:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBD117E8F7;
	Tue, 10 Sep 2024 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXc7jfRX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5C7757EB
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725976064; cv=none; b=FwHPdecao8/b5DAjmCNdrUgzwUXqfi15Gr9yL1WVEwYzkU+x3xj+Ec9Yg51ql0AQSLuK9gi6AzEWBFv79AS47Sapy/Ukuq17pA/LdaRaYyKfU+6T3SRh/R/srasRH+EbnD2WOx034+3nFIYhNWXmyUA+8FZbmLhKBSZzPi6lDoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725976064; c=relaxed/simple;
	bh=xWkDJduY1g7dS0muncLnbxN7aaf9an18C3fX815GvLY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DqU/mlVbGSk9AKV4WpqwWhvrevUwjO6TubtvwRQRz0cjMD9OggPvScw575157dLeAwb38A0d5UbqqlCjB1WVS6EnZxnwU6/yjbCZS+nKYqZb/nLAwXWCsYQxAe+1eIezcZz9jAZ314Z0VyruEYYBLQ7ijtxy63E/eFFN+iLKROw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXc7jfRX; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725976063; x=1757512063;
  h=date:from:to:cc:subject:message-id;
  bh=xWkDJduY1g7dS0muncLnbxN7aaf9an18C3fX815GvLY=;
  b=PXc7jfRXP/4URZJVNOV33I1iIPpZiYuQeIakqSIqEXQsCMN9spaltsWA
   q8StAmTjkHaKZuJSn/5bykgOtjzBRoNkqkvd7Szv16dzNmlyvEv1AQHfc
   rQOsrjpKybfF4NmVkRUAwnepu5nVeca7jH8J/TXNc0GEH0f78sSmMPr87
   79F4dqOgxKvNodvwrDYI0rp/XXhunuXD32vres1vzQzYYW/5d7HWSJDx0
   wTE2aM305Y6lLjCfQqI/IrpS3FCOXeWWZnctSPIxr7+kJ9VMNvVkd6CnB
   WV0zgrmffaYzeNKjzRHlq3V7VgOT+pxhtzbBDHLmN5sjCHY1gRZL/BUV1
   Q==;
X-CSE-ConnectionGUID: l2+Cv7+rQOKgcxklv0lwxQ==
X-CSE-MsgGUID: 9c8zv9LcQi+j7uy3uJMh/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="27642361"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="27642361"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 06:47:42 -0700
X-CSE-ConnectionGUID: vhIAtRhrQb2/fkNxHqaIig==
X-CSE-MsgGUID: jwGm1SPcRRe9B22qyNfW0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="71626613"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 10 Sep 2024 06:47:41 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1so1DX-00029R-0A;
	Tue, 10 Sep 2024 13:47:39 +0000
Date: Tue, 10 Sep 2024 21:47:33 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:pending] BUILD SUCCESS
 dc287f7be96d8dcf1a4e282bdba53bdedaca0a75
Message-ID: <202409102130.4LtzYMS7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: dc287f7be96d8dcf1a4e282bdba53bdedaca0a75  Merge tag 'mt76-for-kvalo-2024-09-06' of https://github.com/nbd168/wireless into pending

elapsed time: 1456m

configs tested: 154
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-14.1.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   gcc-14.1.0
arm                         at91_dt_defconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                      integrator_defconfig   clang-20
arm                      jornada720_defconfig   clang-20
arm                           sama7_defconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240910   gcc-12
i386         buildonly-randconfig-002-20240910   gcc-12
i386         buildonly-randconfig-003-20240910   gcc-12
i386         buildonly-randconfig-004-20240910   clang-18
i386         buildonly-randconfig-005-20240910   clang-18
i386         buildonly-randconfig-006-20240910   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240910   gcc-12
i386                  randconfig-002-20240910   gcc-12
i386                  randconfig-003-20240910   gcc-12
i386                  randconfig-004-20240910   gcc-12
i386                  randconfig-005-20240910   gcc-12
i386                  randconfig-006-20240910   clang-18
i386                  randconfig-011-20240910   gcc-12
i386                  randconfig-012-20240910   clang-18
i386                  randconfig-013-20240910   clang-18
i386                  randconfig-014-20240910   gcc-12
i386                  randconfig-015-20240910   gcc-12
i386                  randconfig-016-20240910   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          amiga_defconfig   clang-20
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                     loongson2k_defconfig   clang-20
mips                      pic32mzda_defconfig   clang-20
mips                       rbtx49xx_defconfig   clang-20
mips                           xway_defconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      bamboo_defconfig   clang-20
powerpc                       eiger_defconfig   clang-20
powerpc                  iss476-smp_defconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
s390                             allmodconfig   clang-20
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                       zfcpdump_defconfig   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                        sh7785lcr_defconfig   clang-20
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                                allnoconfig   clang-17
um                                allnoconfig   clang-20
um                               allyesconfig   gcc-12
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240910   gcc-12
x86_64       buildonly-randconfig-002-20240910   gcc-12
x86_64       buildonly-randconfig-003-20240910   clang-18
x86_64       buildonly-randconfig-003-20240910   gcc-12
x86_64       buildonly-randconfig-004-20240910   gcc-12
x86_64       buildonly-randconfig-005-20240910   gcc-11
x86_64       buildonly-randconfig-005-20240910   gcc-12
x86_64       buildonly-randconfig-006-20240910   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240910   gcc-12
x86_64                randconfig-002-20240910   gcc-12
x86_64                randconfig-003-20240910   gcc-12
x86_64                randconfig-004-20240910   gcc-12
x86_64                randconfig-005-20240910   clang-18
x86_64                randconfig-005-20240910   gcc-12
x86_64                randconfig-006-20240910   clang-18
x86_64                randconfig-006-20240910   gcc-12
x86_64                randconfig-011-20240910   gcc-12
x86_64                randconfig-012-20240910   clang-18
x86_64                randconfig-012-20240910   gcc-12
x86_64                randconfig-013-20240910   clang-18
x86_64                randconfig-013-20240910   gcc-12
x86_64                randconfig-014-20240910   clang-18
x86_64                randconfig-014-20240910   gcc-12
x86_64                randconfig-015-20240910   gcc-12
x86_64                randconfig-016-20240910   clang-18
x86_64                randconfig-016-20240910   gcc-12
x86_64                randconfig-071-20240910   clang-18
x86_64                randconfig-071-20240910   gcc-12
x86_64                randconfig-072-20240910   gcc-12
x86_64                randconfig-073-20240910   clang-18
x86_64                randconfig-073-20240910   gcc-12
x86_64                randconfig-074-20240910   clang-18
x86_64                randconfig-074-20240910   gcc-12
x86_64                randconfig-075-20240910   clang-18
x86_64                randconfig-075-20240910   gcc-12
x86_64                randconfig-076-20240910   clang-18
x86_64                randconfig-076-20240910   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


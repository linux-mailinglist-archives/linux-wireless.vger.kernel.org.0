Return-Path: <linux-wireless+bounces-24511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006F2AE93FC
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 04:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480DF4A3A6E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 02:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CB71BD9D3;
	Thu, 26 Jun 2025 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kMqGikXS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A6B54BC6
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750904399; cv=none; b=mODeyNWtqawh+/W8bFN64auQ5CtAi6Qk7FVHl05lyHQEwyHyONFjdCB+Czul3xZAD1qZQUB42GzJ/wf6U2rhaYWOhsl9bc/Kf7LcbIX28Rzb7bnHQIDAsEXRGCvTzE7BEnlwQc82oyTVQBloobHF5fm3wLCmMpDIOUlbTT9LqSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750904399; c=relaxed/simple;
	bh=b0sFGfdGRhZXxAlTXwlenPYsInEn9URUbMTgs/dwCaw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WTIqp/N3Xiwf6snzv+d5HWvPOEODwwSd1+FEwwTNTXlkLnIaSLYSdILvebgNNMy+KRm6Y8rg9qo2daBv8w3+q5kmm+JTy5lPFQ++efZfjcTtaxincf3I9KSsxPUCmoWzaIFdi9AmrPpch8USSmN+AwbWEIvXLTp/w8WGPaHHPdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kMqGikXS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750904398; x=1782440398;
  h=date:from:to:cc:subject:message-id;
  bh=b0sFGfdGRhZXxAlTXwlenPYsInEn9URUbMTgs/dwCaw=;
  b=kMqGikXSCYgrd1YrK++fUI0n9V1nuh+mB/izBrA2mRS5vO17rqhdK5OQ
   7sFSW4Fd2JflVcuIGyE+XasLCgz8cnv/oahlwpPeC9+mMlcQB0VZCrFfQ
   viwaK9Lvo/4FOO0yy03DMPWbh+L/wCKRILArIfc8JFtdvwK1sp9nD+vLT
   Rc5NGx1NO8L0aat9/FqEz+S5NJCLlX/VswfwAcJtAaHSEXJEfJ5NAXqvH
   yYSwJ2cub8vFBjG0MYGC71bunwkjI0XZvE5F5wMRzgBbUu9H0vvHYdgnm
   zNl2xkVQpSVxs1UcCKFa4DyU68v8Y5s37DAty58L5sYmVhq0cbkWVLgwe
   Q==;
X-CSE-ConnectionGUID: y3KDwfKrQjK2oiQh3TqTow==
X-CSE-MsgGUID: QXsG/5D/QcCixskrBPCb7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="40806973"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="40806973"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 19:19:58 -0700
X-CSE-ConnectionGUID: SQj5ChbmQcm8Dx66si3KSQ==
X-CSE-MsgGUID: 2cl7GemPQxqC+CcsKJkGhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="152878237"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 25 Jun 2025 19:19:57 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUcDR-000Tcg-36;
	Thu, 26 Jun 2025 02:19:53 +0000
Date: Thu, 26 Jun 2025 10:19:36 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 c73ebc0dbb6ed968cb58d04d82ede3b5fb95e8bf
Message-ID: <202506261026.GfB80nfs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: c73ebc0dbb6ed968cb58d04d82ede3b5fb95e8bf  Merge tag 'iwlwifi-next-2025-06-25' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

elapsed time: 983m

configs tested: 104
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                   randconfig-001-20250625    gcc-11.5.0
arc                   randconfig-001-20250626    clang-20
arc                   randconfig-002-20250625    gcc-12.4.0
arc                   randconfig-002-20250626    clang-20
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                   randconfig-001-20250625    clang-21
arm                   randconfig-001-20250626    clang-20
arm                   randconfig-002-20250625    gcc-11.5.0
arm                   randconfig-002-20250626    clang-20
arm                   randconfig-003-20250625    gcc-13.3.0
arm                   randconfig-003-20250626    clang-20
arm                   randconfig-004-20250625    gcc-15.1.0
arm                   randconfig-004-20250626    clang-20
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250625    gcc-11.5.0
arm64                 randconfig-001-20250626    clang-20
arm64                 randconfig-002-20250625    clang-20
arm64                 randconfig-002-20250626    clang-20
arm64                 randconfig-003-20250625    gcc-12.3.0
arm64                 randconfig-003-20250626    clang-20
arm64                 randconfig-004-20250625    clang-20
arm64                 randconfig-004-20250626    clang-20
csky                              allnoconfig    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250625    clang-20
i386        buildonly-randconfig-002-20250625    gcc-12
i386        buildonly-randconfig-003-20250625    gcc-12
i386        buildonly-randconfig-004-20250625    gcc-12
i386        buildonly-randconfig-005-20250625    clang-20
i386        buildonly-randconfig-006-20250625    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250625    gcc-12
x86_64      buildonly-randconfig-001-20250626    clang-20
x86_64      buildonly-randconfig-002-20250625    clang-20
x86_64      buildonly-randconfig-002-20250626    clang-20
x86_64      buildonly-randconfig-003-20250625    clang-20
x86_64      buildonly-randconfig-003-20250626    clang-20
x86_64      buildonly-randconfig-004-20250625    clang-20
x86_64      buildonly-randconfig-004-20250626    clang-20
x86_64      buildonly-randconfig-005-20250625    clang-20
x86_64      buildonly-randconfig-005-20250626    clang-20
x86_64      buildonly-randconfig-006-20250625    clang-20
x86_64      buildonly-randconfig-006-20250626    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


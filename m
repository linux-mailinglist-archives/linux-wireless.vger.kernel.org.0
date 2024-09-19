Return-Path: <linux-wireless+bounces-12997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA3597C342
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 06:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39572283762
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 04:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC7E11711;
	Thu, 19 Sep 2024 04:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+oOhjVp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFA61400A
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 04:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726718776; cv=none; b=C9pv3/Sb5Im42VEeND9sQMZRnYHwthDFpZeU/yZtoiLUEiNbasHFFx0lVGQ0NeQ7hH7rvjVm3tmkY1EVJ4awYxc5XviePm8Iz6eU84Bn0jgplDh0TFe+guxiPmmM4arOv5qR/y8wYXQUEJBUPMzZQc8ZS3mYKH274IlEJRQnT20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726718776; c=relaxed/simple;
	bh=4s++m0ok9L9NZijAArmN0XcAagofDXAm3L+QMWAUZr8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IV3+cJRi4lt9LCAdA7hy5f5y0uII1vgo0klemwGKwalw3WFP+RXGO0BhsJKBsEg3QXjkXK7LnDRpkjrVq5FLRWmvpyGupUaSfbGembgW4LCf6Rtx1sgmDTiTU8aNmX8uGMeFxFB/1R2XAHUIqT4BgwW0+/8koEl6P67YICsZJks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+oOhjVp; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726718774; x=1758254774;
  h=date:from:to:cc:subject:message-id;
  bh=4s++m0ok9L9NZijAArmN0XcAagofDXAm3L+QMWAUZr8=;
  b=O+oOhjVpXRbdiGEww+88P8xD4TcqQAucT9bosjjtCHPiMTFIovzrBTWk
   I16qp6iXwVYMN8focnTV9yODsQjaXCHP9djDnj6+S1VkkP8UOl+M7FGTQ
   8p8x2oeIMUjMGpcrM4CzmwXQS6YbX9KMq50E+EuZkiGwab6b/Xo5iQXr7
   sv17WtoAil/GSanzlWCuZ0KAv3NUzqytKznBgncy5yFwEeLOOx+m43RfC
   Av6dNnjDzt4Y9CDiCtCtjoJfqNRjrTxVYNqcZOunmuQ/tEYq1t8y4cEDQ
   kG8Kk8+IyPEy4iUU3wRvlST+1vYhheq5fT5Sco6VcArZMzbcyhKiNiJEp
   A==;
X-CSE-ConnectionGUID: iBHnh2MMQtu2JzPsGq/9rg==
X-CSE-MsgGUID: 2DxZfmmDSLWF9bI9lFbCcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="29401428"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; 
   d="scan'208";a="29401428"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 21:06:10 -0700
X-CSE-ConnectionGUID: jOcGHS1IS/C3+rmD+nouzg==
X-CSE-MsgGUID: jJNMcfmMSluyUNQTsIq8Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; 
   d="scan'208";a="100504072"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 18 Sep 2024 21:06:10 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sr8Qg-000CsQ-2z;
	Thu, 19 Sep 2024 04:06:06 +0000
Date: Thu, 19 Sep 2024 12:05:39 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8
Message-ID: <202409191234.2AfqpSes-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8  wifi: wl1251: Use IRQF_NO_AUTOEN flag in request_irq()

elapsed time: 734m

configs tested: 139
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                      axs103_smp_defconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.1.0
arc                 nsimosci_hs_smp_defconfig    gcc-13.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                      footbridge_defconfig    gcc-13.2.0
arm                           sama5_defconfig    gcc-13.2.0
arm                       versatile_defconfig    gcc-13.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20240919    clang-18
i386        buildonly-randconfig-002-20240919    clang-18
i386        buildonly-randconfig-003-20240919    clang-18
i386        buildonly-randconfig-004-20240919    clang-18
i386        buildonly-randconfig-005-20240919    clang-18
i386        buildonly-randconfig-006-20240919    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20240919    clang-18
i386                  randconfig-002-20240919    clang-18
i386                  randconfig-003-20240919    clang-18
i386                  randconfig-004-20240919    clang-18
i386                  randconfig-005-20240919    clang-18
i386                  randconfig-006-20240919    clang-18
i386                  randconfig-011-20240919    clang-18
i386                  randconfig-012-20240919    clang-18
i386                  randconfig-013-20240919    clang-18
i386                  randconfig-014-20240919    clang-18
i386                  randconfig-015-20240919    clang-18
i386                  randconfig-016-20240919    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          multi_defconfig    gcc-13.2.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          ath25_defconfig    gcc-13.2.0
mips                  decstation_64_defconfig    gcc-13.2.0
mips                           ip32_defconfig    gcc-13.2.0
mips                malta_qemu_32r6_defconfig    gcc-13.2.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           alldefconfig    gcc-13.2.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                     asp8347_defconfig    gcc-13.2.0
powerpc                       eiger_defconfig    gcc-13.2.0
powerpc                          g5_defconfig    gcc-13.2.0
powerpc                     tqm8541_defconfig    gcc-13.2.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240919    clang-18
x86_64      buildonly-randconfig-002-20240919    clang-18
x86_64      buildonly-randconfig-003-20240919    clang-18
x86_64      buildonly-randconfig-004-20240919    clang-18
x86_64      buildonly-randconfig-005-20240919    clang-18
x86_64      buildonly-randconfig-006-20240919    clang-18
x86_64                              defconfig    clang-18
x86_64                randconfig-001-20240919    clang-18
x86_64                randconfig-002-20240919    clang-18
x86_64                randconfig-003-20240919    clang-18
x86_64                randconfig-004-20240919    clang-18
x86_64                randconfig-005-20240919    clang-18
x86_64                randconfig-006-20240919    clang-18
x86_64                randconfig-011-20240919    clang-18
x86_64                randconfig-012-20240919    clang-18
x86_64                randconfig-013-20240919    clang-18
x86_64                randconfig-014-20240919    clang-18
x86_64                randconfig-015-20240919    clang-18
x86_64                randconfig-016-20240919    clang-18
x86_64                randconfig-071-20240919    clang-18
x86_64                randconfig-072-20240919    clang-18
x86_64                randconfig-073-20240919    clang-18
x86_64                randconfig-074-20240919    clang-18
x86_64                randconfig-075-20240919    clang-18
x86_64                randconfig-076-20240919    clang-18
x86_64                           rhel-8.3-bpf    clang-18
x86_64                           rhel-8.3-bpf    gcc-12
x86_64                         rhel-8.3-kunit    clang-18
x86_64                         rhel-8.3-kunit    gcc-12
x86_64                           rhel-8.3-ltp    clang-18
x86_64                           rhel-8.3-ltp    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  cadence_csp_defconfig    gcc-13.2.0
xtensa                         virt_defconfig    gcc-13.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


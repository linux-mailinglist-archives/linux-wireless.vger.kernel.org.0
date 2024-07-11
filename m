Return-Path: <linux-wireless+bounces-10185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F5492E42A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 12:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D00FB257A5
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 10:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4926155CBA;
	Thu, 11 Jul 2024 10:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XSdtbSmV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB625CDE9
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 10:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692383; cv=none; b=gEBKkUoOZpdae9ovk6D3c9Ce3pzLbEQHjlxIQgAIWaQRpRJHHxnYAv/Q8CfVJJiAiPBY2j6BLq06PkC99ifU0HyRmO+PYG+tITXVFX6mieDjATQVoX0R57MPVWNsaK9VqtC+Y0lLgDREBwsWON3hB6LRYScUwZj46U63neFKIhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692383; c=relaxed/simple;
	bh=PIXnlAGS3NRQD3F46bqQ0tHuC6/hvANZZDW2gmSKODo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EbdWFXTbUmk3yF/LUo90aeTO6kubZBUpGjC0l2anYHmZjSivto5EcAkB5NfT0wA0fXn1ZnDiX+xLRIxDFy+2v8KvyzfvsSxFYFsP+jmBE1+NxHIUMIR+tCtWGiw8klyKf6SMpvmdoE/o/i7BQwWKzvjF5LkLakXZ/5fj2HqLuAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XSdtbSmV; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720692381; x=1752228381;
  h=date:from:to:cc:subject:message-id;
  bh=PIXnlAGS3NRQD3F46bqQ0tHuC6/hvANZZDW2gmSKODo=;
  b=XSdtbSmVBPoQvB4BtHtntRTR8TwJ8B+0opybxiySoJ/Z6P6H1bLTkiMA
   py4lbZptd1lFUZAuujjGpHdIgeGZ+t+pZ8ue7mv2NNIpa0Az7LCQ0BaUA
   L53YqLV15rbpNQ76ZMn/j+9I6hEgVxABRZXH2JvS0I5bHJZB76RpZNa9g
   PYwkmHlkLiyMk90HUenOXKBI4TpZDlshNy3Sc5TH3sLYC27PAUmtWC1U3
   MGcg7tMf0EN87Lk3MzJoBscMcfNHF4I6noOK4oJ1ywYWic1Lmz9SLH5gQ
   1+h8BXz4UOcb0lCPlobKpkunboKvTUmE7JhZdvuTEtDmqqFNvV2tSKK38
   A==;
X-CSE-ConnectionGUID: OF2mGY+3RHq46H1iryyWHw==
X-CSE-MsgGUID: L5wbpI8LTfamQ/uQ1DloHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18197547"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="18197547"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 03:06:19 -0700
X-CSE-ConnectionGUID: cGsGX12ySCmFirrnZT78Cw==
X-CSE-MsgGUID: GUDTWp8RSQimLjT0yYQ3Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="48587339"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 Jul 2024 03:06:18 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRqgq-000Z7s-1n;
	Thu, 11 Jul 2024 10:06:16 +0000
Date: Thu, 11 Jul 2024 18:06:01 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 dabcfd5e116800496eb9bec2ba7c015ca2043aa0
Message-ID: <202407111859.oRM3ldke-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: dabcfd5e116800496eb9bec2ba7c015ca2043aa0  Merge tag 'mt76-for-kvalo-2024-07-08' of https://github.com/nbd168/wireless

elapsed time: 1267m

configs tested: 198
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240711   gcc-13.2.0
arc                   randconfig-002-20240711   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                       aspeed_g4_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                   milbeaut_m10v_defconfig   gcc-13.2.0
arm                            mps2_defconfig   clang-19
arm                            qcom_defconfig   clang-19
arm                   randconfig-001-20240711   gcc-13.2.0
arm                   randconfig-002-20240711   gcc-13.2.0
arm                   randconfig-003-20240711   gcc-13.2.0
arm                   randconfig-004-20240711   gcc-13.2.0
arm                          sp7021_defconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   clang-19
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240711   gcc-13.2.0
arm64                 randconfig-002-20240711   gcc-13.2.0
arm64                 randconfig-003-20240711   gcc-13.2.0
arm64                 randconfig-004-20240711   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240711   gcc-13.2.0
csky                  randconfig-002-20240711   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240711   gcc-13
i386         buildonly-randconfig-002-20240711   gcc-10
i386         buildonly-randconfig-002-20240711   gcc-13
i386         buildonly-randconfig-003-20240711   gcc-13
i386         buildonly-randconfig-004-20240711   gcc-13
i386         buildonly-randconfig-004-20240711   gcc-8
i386         buildonly-randconfig-005-20240711   gcc-10
i386         buildonly-randconfig-005-20240711   gcc-13
i386         buildonly-randconfig-006-20240711   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240711   gcc-13
i386                  randconfig-002-20240711   gcc-10
i386                  randconfig-002-20240711   gcc-13
i386                  randconfig-003-20240711   gcc-13
i386                  randconfig-003-20240711   gcc-8
i386                  randconfig-004-20240711   gcc-13
i386                  randconfig-005-20240711   clang-18
i386                  randconfig-005-20240711   gcc-13
i386                  randconfig-006-20240711   gcc-13
i386                  randconfig-011-20240711   gcc-13
i386                  randconfig-011-20240711   gcc-9
i386                  randconfig-012-20240711   clang-18
i386                  randconfig-012-20240711   gcc-13
i386                  randconfig-013-20240711   gcc-13
i386                  randconfig-014-20240711   clang-18
i386                  randconfig-014-20240711   gcc-13
i386                  randconfig-015-20240711   clang-18
i386                  randconfig-015-20240711   gcc-13
i386                  randconfig-016-20240711   gcc-13
i386                  randconfig-016-20240711   gcc-9
loongarch                        allmodconfig   gcc-13.3.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240711   gcc-13.2.0
loongarch             randconfig-002-20240711   gcc-13.2.0
m68k                             allmodconfig   gcc-13.3.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.3.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5249evb_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.3.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.3.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                         db1xxx_defconfig   clang-19
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240711   gcc-13.2.0
nios2                 randconfig-002-20240711   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.3.0
openrisc                         allyesconfig   gcc-13.3.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.3.0
parisc                            allnoconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.3.0
parisc                           allyesconfig   gcc-13.3.0
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240711   gcc-13.2.0
parisc                randconfig-002-20240711   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.3.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.3.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-13.3.0
powerpc                      chrp32_defconfig   gcc-13.2.0
powerpc                       ebony_defconfig   clang-19
powerpc                  mpc866_ads_defconfig   gcc-13.2.0
powerpc                      pcm030_defconfig   gcc-13.2.0
powerpc                         ps3_defconfig   clang-19
powerpc               randconfig-001-20240711   gcc-13.2.0
powerpc               randconfig-002-20240711   gcc-13.2.0
powerpc               randconfig-003-20240711   gcc-13.2.0
powerpc                     redwood_defconfig   gcc-13.2.0
powerpc                  storcenter_defconfig   gcc-13.2.0
powerpc                     stx_gp3_defconfig   clang-19
powerpc                         wii_defconfig   clang-19
powerpc64             randconfig-001-20240711   gcc-13.2.0
powerpc64             randconfig-002-20240711   gcc-13.2.0
powerpc64             randconfig-003-20240711   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-13.3.0
riscv                             allnoconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.3.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-13.3.0
riscv                               defconfig   gcc-13.2.0
riscv             nommu_k210_sdcard_defconfig   gcc-13.2.0
riscv                 randconfig-001-20240711   gcc-13.2.0
riscv                 randconfig-002-20240711   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240711   gcc-13.2.0
s390                  randconfig-002-20240711   gcc-13.2.0
sh                               allmodconfig   gcc-13.3.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.3.0
sh                                  defconfig   gcc-13.2.0
sh                          polaris_defconfig   gcc-13.2.0
sh                    randconfig-001-20240711   gcc-13.2.0
sh                    randconfig-002-20240711   gcc-13.2.0
sh                           se7751_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.3.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240711   gcc-13.2.0
sparc64               randconfig-002-20240711   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240711   gcc-13.2.0
um                    randconfig-002-20240711   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240711   clang-18
x86_64       buildonly-randconfig-002-20240711   clang-18
x86_64       buildonly-randconfig-003-20240711   clang-18
x86_64       buildonly-randconfig-004-20240711   clang-18
x86_64       buildonly-randconfig-005-20240711   clang-18
x86_64       buildonly-randconfig-006-20240711   clang-18
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240711   clang-18
x86_64                randconfig-002-20240711   clang-18
x86_64                randconfig-003-20240711   clang-18
x86_64                randconfig-004-20240711   clang-18
x86_64                randconfig-005-20240711   clang-18
x86_64                randconfig-006-20240711   clang-18
x86_64                randconfig-011-20240711   clang-18
x86_64                randconfig-012-20240711   clang-18
x86_64                randconfig-013-20240711   clang-18
x86_64                randconfig-014-20240711   clang-18
x86_64                randconfig-015-20240711   clang-18
x86_64                randconfig-016-20240711   clang-18
x86_64                randconfig-071-20240711   clang-18
x86_64                randconfig-072-20240711   clang-18
x86_64                randconfig-073-20240711   clang-18
x86_64                randconfig-074-20240711   clang-18
x86_64                randconfig-075-20240711   clang-18
x86_64                randconfig-076-20240711   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  cadence_csp_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240711   gcc-13.2.0
xtensa                randconfig-002-20240711   gcc-13.2.0
xtensa                    smp_lx200_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


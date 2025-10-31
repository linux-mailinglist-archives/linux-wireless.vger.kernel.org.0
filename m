Return-Path: <linux-wireless+bounces-28436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B33D5C23D9B
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 09:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B88A04F01BC
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 08:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265B02620E5;
	Fri, 31 Oct 2025 08:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iSCa6zNN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA5026A1AB
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899591; cv=none; b=MV+6SLlX6xjbBExKU9xt/6PkWehrF+YQ9dRzKf9rYRMvvLjI0h8rQwysglijGRxcseUwInUERJipr2xO89fiOi4HLyDCQ5/W8rnGvbpGUM39EMcgeRhHGslup5aeopIF6Q3V7DTrq8/pMe60p0Qrfa9CmTGbeRq4DVfxrXrUuuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899591; c=relaxed/simple;
	bh=0TbHSnBm3yRTfEZ2DFpTK6bQrp7VDzBo5nseKnUdUq0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kDZsoKxqP5IiiHcbhaayrtxzfxdGLF2kIsmSRVyvpeBe/72j1wLAxbekftuuNtvKJrk/u+mm01EDTg/KkovaivpHcQaNHW9//h/KQH7EWxcGz1tP2v9M9JQrpbtLbDC3F8QMKvSGiH+Nkj1fAqCzXK9ZR9QiO337APlBBwQ0e6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iSCa6zNN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761899589; x=1793435589;
  h=date:from:to:cc:subject:message-id;
  bh=0TbHSnBm3yRTfEZ2DFpTK6bQrp7VDzBo5nseKnUdUq0=;
  b=iSCa6zNNNz5R2OqwXKdhtwwPapMV3NfQmqdLe0ImrTal2OMBzT0NG1ON
   3EhqQVKV2oJ/yAF2CpNeLOqsVa6LZK8xVBVkDnh1RTYmsuPB1QN7wRUT9
   O58Qwq1S37RUoD+gQvMUxFbwRAEKf5/J/K3iwpfL5AG9wafKXnSF76Ui3
   CMQ1RmjNANshItGiQdPOKvua3lBkGXgp82WGhVTFQIo2Hh5cfYeGy7D4t
   xKCo+bTLgjYEJwZrapMrJnEleDmV/J76vxXEITVW2daQ8wg6iaHt46t8t
   GoniqkQ5SRHXCzGA8vj5wr1jHTGTPgh9aoJBMtUBGPWsSICAdyKq/Rq17
   A==;
X-CSE-ConnectionGUID: 38VT/mRVQtexiO122WiqwQ==
X-CSE-MsgGUID: 6KYYi7DGQRifJXgp9Tcfyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64204060"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="64204060"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:33:09 -0700
X-CSE-ConnectionGUID: DNua1WgmTlC2i03wCPY4gQ==
X-CSE-MsgGUID: T3FZHm7TTKuCp8myrH061w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="186635919"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 31 Oct 2025 01:33:07 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEkZF-000MuE-1L;
	Fri, 31 Oct 2025 08:33:05 +0000
Date: Fri, 31 Oct 2025 16:32:25 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 508dfc1f2ccdc480893332aaeb5e8d076769f7c3
Message-ID: <202510311619.NJY1nIwx-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 508dfc1f2ccdc480893332aaeb5e8d076769f7c3  wifi: mac80211: Allow HT Action frame processing on 6 GHz when HE is supported

elapsed time: 1452m

configs tested: 120
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                          axs101_defconfig    gcc-15.1.0
arc                   randconfig-001-20251030    gcc-11.5.0
arc                   randconfig-002-20251030    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                           imxrt_defconfig    clang-22
arm                      jornada720_defconfig    clang-22
arm                   randconfig-001-20251030    gcc-10.5.0
arm                   randconfig-002-20251030    clang-19
arm                   randconfig-003-20251030    clang-22
arm                   randconfig-004-20251030    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251031    gcc-8.5.0
arm64                 randconfig-002-20251031    clang-22
arm64                 randconfig-003-20251031    gcc-10.5.0
arm64                 randconfig-004-20251031    gcc-14.3.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251031    gcc-9.5.0
csky                  randconfig-002-20251031    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251030    clang-22
hexagon               randconfig-002-20251030    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251031    gcc-14
i386        buildonly-randconfig-002-20251031    gcc-14
i386        buildonly-randconfig-003-20251031    clang-20
i386        buildonly-randconfig-004-20251031    gcc-14
i386        buildonly-randconfig-005-20251031    clang-20
i386        buildonly-randconfig-006-20251031    gcc-14
i386                  randconfig-001-20251031    gcc-14
i386                  randconfig-002-20251031    gcc-14
i386                  randconfig-003-20251031    gcc-14
i386                  randconfig-004-20251031    gcc-14
i386                  randconfig-005-20251031    gcc-14
i386                  randconfig-006-20251031    gcc-12
i386                  randconfig-007-20251031    clang-20
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251030    clang-22
loongarch             randconfig-002-20251030    clang-22
m68k                              allnoconfig    gcc-15.1.0
m68k                       m5208evb_defconfig    gcc-15.1.0
m68k                        m5407c3_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm47xx_defconfig    clang-18
mips                          eyeq5_defconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    gcc-11.5.0
nios2                 randconfig-001-20251030    gcc-8.5.0
nios2                 randconfig-002-20251030    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                  or1klitex_defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20251030    gcc-8.5.0
parisc                randconfig-002-20251030    gcc-8.5.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                   lite5200b_defconfig    clang-22
powerpc                     mpc5200_defconfig    clang-22
powerpc               randconfig-001-20251030    clang-22
powerpc               randconfig-002-20251030    clang-22
powerpc64             randconfig-001-20251030    gcc-8.5.0
powerpc64             randconfig-002-20251030    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251030    gcc-13.4.0
riscv                 randconfig-002-20251030    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251030    clang-17
s390                  randconfig-002-20251030    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20251030    gcc-15.1.0
sh                    randconfig-002-20251030    gcc-15.1.0
sh                           se7705_defconfig    gcc-15.1.0
sh                           se7750_defconfig    gcc-15.1.0
sh                             shx3_defconfig    gcc-15.1.0
sh                            titan_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    gcc-15.1.0
sparc                 randconfig-001-20251031    gcc-8.5.0
sparc                 randconfig-002-20251031    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64               randconfig-001-20251031    gcc-8.5.0
sparc64               randconfig-002-20251031    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20251031    gcc-14
um                    randconfig-002-20251031    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251031    clang-20
x86_64      buildonly-randconfig-002-20251031    gcc-14
x86_64      buildonly-randconfig-003-20251031    clang-20
x86_64      buildonly-randconfig-004-20251031    gcc-14
x86_64      buildonly-randconfig-005-20251031    gcc-14
x86_64      buildonly-randconfig-006-20251031    gcc-14
x86_64                randconfig-011-20251031    gcc-14
x86_64                randconfig-012-20251031    clang-20
x86_64                randconfig-013-20251031    gcc-14
x86_64                randconfig-014-20251031    gcc-14
x86_64                randconfig-015-20251031    gcc-14
x86_64                randconfig-016-20251031    clang-20
x86_64                randconfig-071-20251031    gcc-14
x86_64                randconfig-072-20251031    clang-20
x86_64                randconfig-073-20251031    gcc-14
x86_64                randconfig-074-20251031    clang-20
x86_64                randconfig-075-20251031    gcc-14
x86_64                randconfig-076-20251031    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251031    gcc-13.4.0
xtensa                randconfig-002-20251031    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


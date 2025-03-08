Return-Path: <linux-wireless+bounces-20023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4CAA57972
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 10:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325161890F55
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 09:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BE413EFE3;
	Sat,  8 Mar 2025 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lu5GRdwy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FB3C2FA
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741425730; cv=none; b=gJ+An9BkmXvDlCqs7iyoLnJ2JW5GlUhHSxLafqJUqxpUVlYLD3QwH/hQwP1Wq4YY49CUBjMtc9s40HhaXE/qqM4xbz3CE7s9uYXb/VlBPvfJs4sYaPsC0xkpqy7Tv2hJve19wNiZhUPzzx9v0eTVQLVX/Da2sRozwyyO3srXrAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741425730; c=relaxed/simple;
	bh=AsrTXfFyPjWM2+5f1ejq4Bw0vaVKLYI1fBs3ag+fG3Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KUZNSRPU5TBJv6bL6p8ZapbaY8Pm0DMtFbtfhhEvi/HR4IrQlYdMbzQ+3YHR9ZcH0BInkgYsdnK0ueJMu06ddBIDPThtQmAml3lS3DodE732UFMRtQcoJj5gsgqOcfPt6S02dBN/5AsigZvbY4wNbYhbHmPC9iqPNDuzfEUJeyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lu5GRdwy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741425729; x=1772961729;
  h=date:from:to:cc:subject:message-id;
  bh=AsrTXfFyPjWM2+5f1ejq4Bw0vaVKLYI1fBs3ag+fG3Q=;
  b=lu5GRdwyQ8MasqG/0uZDFOjRAAh+M7nZFP643WWir/dXheE6QWKAkEHE
   y48y1P4LS2dCFvORuZE4MQlwfZdxUiEp4ixF4aizeAszbua9qgJlfkbfW
   0txpHpnsa9Cajn9w3j/sjmgRbq3+bTbhB0+urMn+5++EzDeCtAmPbTYW5
   sUSWXHfTFt019cdq6QPyFMrMnfZTY0tL92nPN4QgYSf/UKZo64DiND5PB
   nCSwy7Qfu1TANeFoR9qgSttD1AbiHuRmZ3dsKpk3pOd5GclhCsbJ3MtKK
   lmIWwjoq5iPEHgnHcemcy7oZKlkN3pHagxxEsY8944qSLtupJ0+l5c6eY
   A==;
X-CSE-ConnectionGUID: SM4EI+7TRKC+w7KRjNulwA==
X-CSE-MsgGUID: Gnr9Tl+FSi+ArZBgiv5Kuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="46255778"
X-IronPort-AV: E=Sophos;i="6.14,231,1736841600"; 
   d="scan'208";a="46255778"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 01:22:08 -0800
X-CSE-ConnectionGUID: ohgqwaecQZybhMPU6IehUw==
X-CSE-MsgGUID: MuAmNBM3TlidwtA+g6EhIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150483989"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 08 Mar 2025 01:22:07 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqqNg-0001kS-2G;
	Sat, 08 Mar 2025 09:22:04 +0000
Date: Sat, 08 Mar 2025 17:21:30 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD REGRESSION
 fc56639937ce95a73c9876e39f8d18d1a8dd6a95
Message-ID: <202503081723.78KqkGLS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: fc56639937ce95a73c9876e39f8d18d1a8dd6a95  wifi: wfx: allow to enable WoWLAN using NL80211

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202503080456.h4DC9aDg-lkp@intel.com

    drivers/net/wireless/intel/iwlwifi/mld/hcmd.h:13:35: error: 'struct <anonymous>' has no member named 'in_d3'
    drivers/net/wireless/intel/iwlwifi/mld/mld.h:299:23: error: 'struct <anonymous>' has no member named 'in_d3'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   |-- drivers-net-wireless-intel-iwlwifi-mld-hcmd.h:error:struct-anonymous-has-no-member-named-in_d3
|   `-- drivers-net-wireless-intel-iwlwifi-mld-mld.h:error:struct-anonymous-has-no-member-named-in_d3
|-- arc-allmodconfig
|   |-- drivers-net-wireless-intel-iwlwifi-mld-hcmd.h:error:struct-anonymous-has-no-member-named-in_d3
|   `-- drivers-net-wireless-intel-iwlwifi-mld-mld.h:error:struct-anonymous-has-no-member-named-in_d3
|-- arc-allyesconfig
|   |-- drivers-net-wireless-intel-iwlwifi-mld-hcmd.h:error:struct-anonymous-has-no-member-named-in_d3
|   `-- drivers-net-wireless-intel-iwlwifi-mld-mld.h:error:struct-anonymous-has-no-member-named-in_d3
|-- openrisc-allyesconfig
|   |-- drivers-net-wireless-intel-iwlwifi-mld-hcmd.h:error:struct-anonymous-has-no-member-named-in_d3
|   `-- drivers-net-wireless-intel-iwlwifi-mld-mld.h:error:struct-anonymous-has-no-member-named-in_d3
|-- parisc-allmodconfig
|   |-- drivers-net-wireless-intel-iwlwifi-mld-hcmd.h:error:struct-anonymous-has-no-member-named-in_d3
|   `-- drivers-net-wireless-intel-iwlwifi-mld-mld.h:error:struct-anonymous-has-no-member-named-in_d3
`-- parisc-allyesconfig
    |-- drivers-net-wireless-intel-iwlwifi-mld-hcmd.h:error:struct-anonymous-has-no-member-named-in_d3
    `-- drivers-net-wireless-intel-iwlwifi-mld-mld.h:error:struct-anonymous-has-no-member-named-in_d3

elapsed time: 1443m

configs tested: 138
configs skipped: 2

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                         haps_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20250307    gcc-13.2.0
arc                   randconfig-002-20250307    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-14.2.0
arm                        keystone_defconfig    gcc-14.2.0
arm                             pxa_defconfig    gcc-14.2.0
arm                   randconfig-001-20250307    clang-21
arm                   randconfig-002-20250307    gcc-14.2.0
arm                   randconfig-003-20250307    clang-19
arm                   randconfig-004-20250307    clang-21
arm                         s5pv210_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250307    gcc-14.2.0
arm64                 randconfig-002-20250307    clang-15
arm64                 randconfig-003-20250307    gcc-14.2.0
arm64                 randconfig-004-20250307    clang-15
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250307    gcc-14.2.0
csky                  randconfig-002-20250307    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250307    clang-21
hexagon               randconfig-002-20250307    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250307    clang-19
i386        buildonly-randconfig-002-20250307    clang-19
i386        buildonly-randconfig-003-20250307    gcc-11
i386        buildonly-randconfig-004-20250307    clang-19
i386        buildonly-randconfig-005-20250307    gcc-12
i386        buildonly-randconfig-006-20250307    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250307    gcc-14.2.0
loongarch             randconfig-002-20250307    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                            mac_defconfig    gcc-14.2.0
microblaze                       alldefconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-21
mips                         bigsur_defconfig    gcc-14.2.0
mips                     loongson1b_defconfig    clang-21
mips                           mtx1_defconfig    clang-21
mips                          rb532_defconfig    clang-17
nios2                         3c120_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250307    gcc-14.2.0
nios2                 randconfig-002-20250307    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250307    gcc-14.2.0
parisc                randconfig-002-20250307    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                   motionpro_defconfig    clang-17
powerpc                 mpc832x_rdb_defconfig    gcc-14.2.0
powerpc                     mpc83xx_defconfig    clang-21
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250307    gcc-14.2.0
powerpc               randconfig-002-20250307    clang-21
powerpc               randconfig-003-20250307    clang-19
powerpc64             randconfig-001-20250307    clang-21
powerpc64             randconfig-002-20250307    gcc-14.2.0
powerpc64             randconfig-003-20250307    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv             nommu_k210_sdcard_defconfig    gcc-14.2.0
riscv                 randconfig-001-20250307    gcc-14.2.0
riscv                 randconfig-002-20250307    clang-19
s390                             alldefconfig    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250307    gcc-14.2.0
s390                  randconfig-002-20250307    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250307    gcc-14.2.0
sh                    randconfig-002-20250307    gcc-14.2.0
sh                          rsk7201_defconfig    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250307    gcc-14.2.0
sparc                 randconfig-002-20250307    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250307    gcc-14.2.0
sparc64               randconfig-002-20250307    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250307    clang-17
um                    randconfig-002-20250307    clang-21
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250307    clang-19
x86_64      buildonly-randconfig-002-20250307    gcc-12
x86_64      buildonly-randconfig-003-20250307    clang-19
x86_64      buildonly-randconfig-004-20250307    clang-19
x86_64      buildonly-randconfig-005-20250307    clang-19
x86_64      buildonly-randconfig-006-20250307    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250307    gcc-14.2.0
xtensa                randconfig-002-20250307    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


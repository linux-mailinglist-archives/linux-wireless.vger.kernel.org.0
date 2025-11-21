Return-Path: <linux-wireless+bounces-29243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AAAC7A85E
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 16:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807DE3A2AEC
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 15:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5D3352923;
	Fri, 21 Nov 2025 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9ZJSl8y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42EC351FD1
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763738281; cv=none; b=I6mBXywxXfxNV2o7Y8kQB2fXs7I7IjOWTxvGuc/AcfJOYchreN8YRkt3ZiIkWuF7TJ1pKxhqNSdPuztKjhOt72EVqRXJZ73QHYWMyMOAzIOKpGDdlf1IsBR7RKUxB29NRt9ZkNvehhC133BBbP0rjzhTN2eUxhHTuwdfVM6aO8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763738281; c=relaxed/simple;
	bh=086sNeQT3GswPhN/zyzOuuJeaoWTT7MyOcIz2SJf1Ks=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pnESJiTvMG8IcgZds8iylVixuIC4pmtsOELQpANo1TxuLNQ8KNQs0G9SyA7IJQGJUzlf/V6h2rr50jOZ2Kd1kF6irxRPNZaZqEwOlzX6kufTX49+wVwayuq3tKgBpTPtJXOo9zVbXQ1oZVkzc38CD6CtmRNLQ6H7gCZNiouoyD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G9ZJSl8y; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763738279; x=1795274279;
  h=date:from:to:cc:subject:message-id;
  bh=086sNeQT3GswPhN/zyzOuuJeaoWTT7MyOcIz2SJf1Ks=;
  b=G9ZJSl8y3S1VUlzfwoIKxIN4xzyBQ4iTT6WV1zw0Wtwx72+M53YGXCE1
   DjZBDP40FpwP0mGXxRjZqZ/JdLpufAGfMkrk8K7Gcek65/6g50HCOinRW
   03MbgTCT9lgXN3cNvApMdvKElWQWvSDk3WXrrhjnTKUFQ95Njo1S38kDH
   LLlMxubHyTrc6LXwZ/azJuzv5O0KzdiKDoiFJyqNJOU20xvmDyJ9ANxKS
   BXz3j2yMtc2dHcaW4pIkIHc9+QxSaURwTdNnZCzox7S3/pxpDOULxeyP4
   Ht4nn8HzUp+f1IEixtbMJOXHWHZsWGHw7exwX0eJDjPl0Nscb3YbGw01B
   A==;
X-CSE-ConnectionGUID: poKnH/8+S1aRG2g4Ns8arA==
X-CSE-MsgGUID: MgJb9fjYSpKRcmrmtu/BXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="88485603"
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="88485603"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 07:17:58 -0800
X-CSE-ConnectionGUID: 6AT4Cr2zTkqDN3sO1yt+gg==
X-CSE-MsgGUID: kqk71A4MQPGQU4Cm6ASE7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="196178007"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 21 Nov 2025 07:17:56 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMStW-0006Vd-0T;
	Fri, 21 Nov 2025 15:17:54 +0000
Date: Fri, 21 Nov 2025 23:17:05 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 b688a9447be360d09c0982234fcd703ac7dd8c15
Message-ID: <202511212300.fasLPKrb-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: b688a9447be360d09c0982234fcd703ac7dd8c15  wifi: mac80211: refactor CMAC packet handlers

elapsed time: 1497m

configs tested: 109
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                            hsdk_defconfig    gcc-15.1.0
arc                   randconfig-001-20251121    gcc-8.5.0
arc                   randconfig-002-20251121    gcc-13.4.0
arm                               allnoconfig    clang-22
arm                      jornada720_defconfig    clang-22
arm                   randconfig-001-20251121    gcc-10.5.0
arm                   randconfig-002-20251121    gcc-11.5.0
arm                   randconfig-003-20251121    clang-22
arm                   randconfig-004-20251121    gcc-10.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251121    gcc-8.5.0
arm64                 randconfig-002-20251121    clang-22
arm64                 randconfig-003-20251121    gcc-8.5.0
arm64                 randconfig-004-20251121    gcc-10.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251121    gcc-14.3.0
csky                  randconfig-002-20251121    gcc-11.5.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251121    clang-22
hexagon               randconfig-002-20251121    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251121    gcc-14
i386        buildonly-randconfig-002-20251121    gcc-14
i386        buildonly-randconfig-003-20251121    clang-20
i386        buildonly-randconfig-004-20251121    clang-20
i386        buildonly-randconfig-005-20251121    clang-20
i386        buildonly-randconfig-006-20251121    clang-20
i386                  randconfig-001-20251121    gcc-14
i386                  randconfig-002-20251121    clang-20
i386                  randconfig-003-20251121    gcc-14
i386                  randconfig-004-20251121    clang-20
i386                  randconfig-005-20251121    clang-20
i386                  randconfig-006-20251121    gcc-14
i386                  randconfig-007-20251121    gcc-14
i386                  randconfig-011-20251121    clang-20
i386                  randconfig-012-20251121    clang-20
i386                  randconfig-013-20251121    clang-20
i386                  randconfig-014-20251121    clang-20
i386                  randconfig-015-20251121    clang-20
i386                  randconfig-016-20251121    gcc-14
i386                  randconfig-017-20251121    gcc-14
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251121    gcc-15.1.0
loongarch             randconfig-002-20251121    clang-22
m68k                              allnoconfig    gcc-15.1.0
m68k                        stmark2_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20251121    gcc-11.5.0
nios2                 randconfig-002-20251121    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                       virt_defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251121    gcc-12.5.0
parisc                randconfig-002-20251121    gcc-12.5.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      arches_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251121    clang-18
powerpc               randconfig-002-20251121    gcc-11.5.0
powerpc64             randconfig-001-20251121    gcc-8.5.0
powerpc64             randconfig-002-20251121    clang-20
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251121    gcc-14.3.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251121    gcc-13.4.0
s390                  randconfig-002-20251121    clang-19
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                 kfr2r09-romimage_defconfig    gcc-15.1.0
sh                    randconfig-001-20251121    gcc-10.5.0
sh                    randconfig-002-20251121    gcc-11.5.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251121    gcc-13.4.0
sparc                 randconfig-002-20251121    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251121    clang-22
sparc64               randconfig-002-20251121    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251121    clang-22
um                    randconfig-002-20251121    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251121    gcc-14
x86_64      buildonly-randconfig-002-20251121    gcc-14
x86_64      buildonly-randconfig-003-20251121    gcc-14
x86_64      buildonly-randconfig-004-20251121    clang-20
x86_64      buildonly-randconfig-005-20251121    gcc-14
x86_64      buildonly-randconfig-006-20251121    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251121    clang-20
x86_64                randconfig-012-20251121    gcc-14
x86_64                randconfig-013-20251121    gcc-14
x86_64                randconfig-014-20251121    gcc-14
x86_64                randconfig-015-20251121    gcc-14
x86_64                randconfig-016-20251121    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251121    gcc-11.5.0
xtensa                randconfig-002-20251121    gcc-8.5.0
xtensa                         virt_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


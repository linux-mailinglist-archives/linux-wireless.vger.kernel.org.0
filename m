Return-Path: <linux-wireless+bounces-15240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD629C6A20
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 08:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BAB21F2351A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 07:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E524189916;
	Wed, 13 Nov 2024 07:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TX7n+R+t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C4A1885AF
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731483761; cv=none; b=jL7oMPOA9JFJP1P0a1BxOqqakEusy9cJoaMfAiT1wV7AB8HP+IAytssHXfT6tCX5ucPsv6qOhsDzWR4ZkAlZHCcEP5NdDKAdWzeqrHJRFywibvNs0TvimBSzzeo92pVkcEcgiQR9gcYw9aKjG3fGqVw30yl9DEPZ4SI/gQ2/qsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731483761; c=relaxed/simple;
	bh=aeALpnpbvZjat5IA1Zlm0XH4uAYtlSCMWnqZRlKGE5g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Z4JRLzrz1vncvMbUrwOZ0cupGxxrS72GmXM3JLF7NN69FM/0KqMp/VMNHb4aWx88ebmjL26HQ2GVIDMzrtrjySNY/FdVENzG7aQr8Yi1N6cBGVjh0dZkMbZX4HiJP3y3G1jvwGmkG8SYi/HUV7ckWX4zvR81qBLEic5W9zK8RxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TX7n+R+t; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731483760; x=1763019760;
  h=date:from:to:cc:subject:message-id;
  bh=aeALpnpbvZjat5IA1Zlm0XH4uAYtlSCMWnqZRlKGE5g=;
  b=TX7n+R+tn3gRLQFrJVw5WNsrBhlFuOHf605Px3XdZt632mO9UmS21CAO
   9sK+9QJSBzbq9jAvqQxJPQlWxzohA0qJtetVbXh8laTASIYB2B0oz5JJy
   V0MR4R6eTBleKanT3nd2j07RXMqAouJ7v4LAuKr3nXC+Wy8sWNDML8cD7
   o5/+wIyqPtJk9fhBZFUXgeGwg7XiAFyxXdaTP7FOI6wQ+EAnfpJAdWWon
   joBt+nGU3EvFoFVWOOomrT2ll+gqykhU2d0XkYsmdd0okDuwkO4MFZfT+
   Xu0ADKKXqtYjsoyJAa2g5RFrBljfw/ew+s+nzx2Hxp/qX2dOoC6KC2HSD
   A==;
X-CSE-ConnectionGUID: zlDAZ3dbSIivIImNczruGA==
X-CSE-MsgGUID: 5Xk955iVRhmN54W7crNpMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="41975256"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="41975256"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 23:42:37 -0800
X-CSE-ConnectionGUID: L0y1QUW4Q4mZabUnzRUoXg==
X-CSE-MsgGUID: uSigEJYwRpSNanYb3va5bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="88210217"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 12 Nov 2024 23:42:36 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tB81J-00006r-20;
	Wed, 13 Nov 2024 07:42:33 +0000
Date: Wed, 13 Nov 2024 15:42:15 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 11597043d74809daf5d14256b96d6781749b3f82
Message-ID: <202411131510.5fAS29e5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 11597043d74809daf5d14256b96d6781749b3f82  Revert "wifi: iwlegacy: do not skip frames with bad FCS"

elapsed time: 733m

configs tested: 93
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241113    gcc-13.2.0
arc                   randconfig-002-20241113    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20241113    clang-20
arm                   randconfig-002-20241113    clang-20
arm                   randconfig-003-20241113    clang-20
arm                   randconfig-004-20241113    clang-20
arm64                            allmodconfig    clang-20
arm64                 randconfig-001-20241113    clang-20
arm64                 randconfig-002-20241113    gcc-14.2.0
arm64                 randconfig-003-20241113    gcc-14.2.0
arm64                 randconfig-004-20241113    gcc-14.2.0
csky                  randconfig-001-20241113    gcc-14.2.0
csky                  randconfig-002-20241113    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241113    clang-14
hexagon               randconfig-002-20241113    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241113    clang-19
i386        buildonly-randconfig-002-20241113    clang-19
i386        buildonly-randconfig-003-20241113    clang-19
i386        buildonly-randconfig-004-20241113    gcc-12
i386        buildonly-randconfig-005-20241113    gcc-12
i386        buildonly-randconfig-006-20241113    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241113    gcc-12
i386                  randconfig-002-20241113    gcc-12
i386                  randconfig-003-20241113    clang-19
i386                  randconfig-004-20241113    clang-19
i386                  randconfig-005-20241113    gcc-12
i386                  randconfig-006-20241113    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20241113    gcc-14.2.0
loongarch             randconfig-002-20241113    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
nios2                 randconfig-001-20241113    gcc-14.2.0
nios2                 randconfig-002-20241113    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20241113    gcc-14.2.0
parisc                randconfig-002-20241113    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc               randconfig-001-20241113    clang-20
powerpc               randconfig-002-20241113    clang-20
powerpc               randconfig-003-20241113    clang-15
powerpc64             randconfig-001-20241113    gcc-14.2.0
powerpc64             randconfig-002-20241113    clang-20
powerpc64             randconfig-003-20241113    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20241113    gcc-14.2.0
riscv                 randconfig-002-20241113    clang-20
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241113    gcc-14.2.0
s390                  randconfig-002-20241113    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20241113    gcc-14.2.0
sh                    randconfig-002-20241113    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64               randconfig-001-20241113    gcc-14.2.0
sparc64               randconfig-002-20241113    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
um                    randconfig-001-20241113    gcc-12
um                    randconfig-002-20241113    clang-20
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                               rhel-8.3    gcc-12
x86_64                    rhel-8.3-kselftests    gcc-12
xtensa                randconfig-001-20241113    gcc-14.2.0
xtensa                randconfig-002-20241113    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


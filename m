Return-Path: <linux-wireless+bounces-32278-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JihMRNfoWmksQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32278-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 10:08:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 488DF1B4EC7
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 10:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 327243005774
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 09:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42C6361DCB;
	Fri, 27 Feb 2026 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h73mXN/L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C8C236453
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772183202; cv=none; b=uDEK/4AoTybMf9E4bY3X9PzQPimbPUNjtxW6PMoa5pAhXeBTq0dyvT4KXB2/lQnPghEomc9AM8KbAelJtOc/qWQjLyJv4cCvJX7CMBl8MSO5GlLz4Hwz3bLw+jzO8S3PD8iYhcty+FehjfjIYlx3o0OhcW4leeRwr6Elr86dwiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772183202; c=relaxed/simple;
	bh=E8XxVC08iH96fHFFRpva0mjXgJ3Pnq9RYb1+RXAZJJA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QDi41d+AKa1E9oDdYEQ9P0/wltGuDfFFMe5/mbgmHpmZ75nCINPv9tlCfnQ/ILQB6aksgSVshal6XrS833YxCLKGqVd8ak3rH7aripAZG7fMPNCNX+2dPSVSrDclBrCoEL6jyWGLCj1MxtwcObnIEdQB0rjmf8Ll/wEbEnmd8Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h73mXN/L; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772183200; x=1803719200;
  h=date:from:to:cc:subject:message-id;
  bh=E8XxVC08iH96fHFFRpva0mjXgJ3Pnq9RYb1+RXAZJJA=;
  b=h73mXN/LcpoyvfWeqHPA8D4+GfxwzG21jkH+jv5sp5enosfoRbPd6o+l
   5G+rKydUQmlqq8/BEjR87gJI2x2ayVgHKix016ezBuIS2L4ALEJnKw5ky
   65ihWNTmI7Ds24q17+2sTDyshF1RYAatYlqDhgc4qvh1gd7tTQmgqmXiU
   f7iB95/RBv3V1BuOZMTQ1d+4eAkSw9Qgnc/HHOsWLk46y0FpPsXWcqyYS
   Hsxmf1+ZQFIWRYCYUSOpDDsdZOeaXdHEIMFdJz9AmuhBSDEuIgV8xwTfD
   Sloxt8r0G1Qo8yesvcMXoyMhZP3rrY/2uLM0pgzgqlc6sZTGeuA564Fzm
   A==;
X-CSE-ConnectionGUID: YgiWmIWRR9i8cDaTnFp/XQ==
X-CSE-MsgGUID: EVMb5/SdTi+Du8WNKYCuhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="77102048"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="77102048"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 01:06:39 -0800
X-CSE-ConnectionGUID: Zni2iGBjRoiCVq0YMU7xNQ==
X-CSE-MsgGUID: avpYon6tSC2WeYmkrKPL1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="221350540"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 27 Feb 2026 01:06:39 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvtnK-00000000AOb-3vv3;
	Fri, 27 Feb 2026 09:06:16 +0000
Date: Fri, 27 Feb 2026 17:04:16 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 0314e382cf02983eb3c33ac537ad9701e7858bc9
Message-ID: <202602271707.Y8GS2Kob-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32278-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 488DF1B4EC7
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 0314e382cf02983eb3c33ac537ad9701e7858bc9  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

elapsed time: 844m

configs tested: 279
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.2.0
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                     nsimosci_hs_defconfig    gcc-15.2.0
arc                   randconfig-001-20260227    gcc-8.5.0
arc                   randconfig-002-20260227    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                      jornada720_defconfig    clang-23
arm                        neponset_defconfig    gcc-15.2.0
arm                   randconfig-001-20260227    gcc-14.3.0
arm                   randconfig-001-20260227    gcc-8.5.0
arm                   randconfig-002-20260227    clang-23
arm                   randconfig-002-20260227    gcc-8.5.0
arm                   randconfig-003-20260227    gcc-15.2.0
arm                   randconfig-003-20260227    gcc-8.5.0
arm                   randconfig-004-20260227    clang-23
arm                   randconfig-004-20260227    gcc-8.5.0
arm                           sama7_defconfig    gcc-15.2.0
arm                         socfpga_defconfig    gcc-15.2.0
arm                         wpcm450_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260227    clang-23
arm64                 randconfig-002-20260227    clang-23
arm64                 randconfig-002-20260227    gcc-15.2.0
arm64                 randconfig-003-20260227    clang-23
arm64                 randconfig-004-20260227    clang-23
arm64                 randconfig-004-20260227    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    clang-23
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260227    clang-23
csky                  randconfig-001-20260227    gcc-15.2.0
csky                  randconfig-002-20260227    clang-23
csky                  randconfig-002-20260227    gcc-10.5.0
hexagon                          alldefconfig    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260227    clang-23
hexagon               randconfig-002-20260227    clang-23
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260227    clang-20
i386        buildonly-randconfig-002-20260227    clang-20
i386        buildonly-randconfig-003-20260227    clang-20
i386        buildonly-randconfig-004-20260227    clang-20
i386        buildonly-randconfig-005-20260227    clang-20
i386        buildonly-randconfig-006-20260227    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260227    clang-20
i386                  randconfig-002-20260227    clang-20
i386                  randconfig-003-20260227    clang-20
i386                  randconfig-003-20260227    gcc-14
i386                  randconfig-004-20260227    clang-20
i386                  randconfig-004-20260227    gcc-14
i386                  randconfig-005-20260227    clang-20
i386                  randconfig-005-20260227    gcc-12
i386                  randconfig-006-20260227    clang-20
i386                  randconfig-006-20260227    gcc-14
i386                  randconfig-007-20260227    clang-20
i386                  randconfig-011-20260227    gcc-14
i386                  randconfig-012-20260227    gcc-14
i386                  randconfig-013-20260227    gcc-14
i386                  randconfig-014-20260227    gcc-14
i386                  randconfig-015-20260227    gcc-14
i386                  randconfig-016-20260227    gcc-14
i386                  randconfig-017-20260227    gcc-14
loongarch                        alldefconfig    clang-23
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260227    clang-23
loongarch             randconfig-001-20260227    gcc-15.2.0
loongarch             randconfig-002-20260227    clang-20
loongarch             randconfig-002-20260227    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                          amiga_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                          hp300_defconfig    gcc-15.2.0
m68k                        m5272c3_defconfig    gcc-15.2.0
m68k                       m5275evb_defconfig    gcc-15.2.0
m68k                           sun3_defconfig    clang-23
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                       bmips_be_defconfig    clang-23
mips                           jazz_defconfig    gcc-15.2.0
mips                    maltaup_xpa_defconfig    gcc-15.2.0
mips                   sb1250_swarm_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260227    clang-23
nios2                 randconfig-001-20260227    gcc-11.5.0
nios2                 randconfig-002-20260227    clang-23
nios2                 randconfig-002-20260227    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                   de0_nano_defconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                    or1ksim_defconfig    gcc-15.2.0
openrisc                 simple_smp_defconfig    clang-23
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260227    clang-17
parisc                randconfig-001-20260227    gcc-8.5.0
parisc                randconfig-002-20260227    clang-17
parisc64                            defconfig    clang-19
powerpc                    adder875_defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                 canyonlands_defconfig    gcc-15.2.0
powerpc                       holly_defconfig    clang-23
powerpc                        icon_defconfig    gcc-15.2.0
powerpc                  iss476-smp_defconfig    gcc-15.2.0
powerpc                     kmeter1_defconfig    gcc-15.2.0
powerpc                   motionpro_defconfig    gcc-15.2.0
powerpc                 mpc834x_itx_defconfig    gcc-15.2.0
powerpc                  mpc866_ads_defconfig    gcc-15.2.0
powerpc                      pasemi_defconfig    gcc-15.2.0
powerpc                     rainier_defconfig    clang-23
powerpc               randconfig-001-20260227    clang-17
powerpc               randconfig-002-20260227    clang-17
powerpc                    socrates_defconfig    clang-23
powerpc                     stx_gp3_defconfig    gcc-15.2.0
powerpc                     taishan_defconfig    gcc-15.2.0
powerpc                     tqm5200_defconfig    gcc-15.2.0
powerpc                     tqm8555_defconfig    clang-23
powerpc64             randconfig-001-20260227    clang-17
powerpc64             randconfig-002-20260227    clang-17
powerpc64             randconfig-002-20260227    gcc-14.3.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260227    gcc-12.5.0
riscv                 randconfig-002-20260227    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260227    gcc-12.5.0
s390                  randconfig-002-20260227    gcc-12.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                          kfr2r09_defconfig    gcc-15.2.0
sh                          r7780mp_defconfig    gcc-15.2.0
sh                    randconfig-001-20260227    gcc-12.5.0
sh                    randconfig-002-20260227    gcc-12.5.0
sh                          rsk7203_defconfig    gcc-15.2.0
sh                           se7343_defconfig    clang-23
sh                           se7705_defconfig    clang-23
sh                           se7750_defconfig    gcc-15.2.0
sh                   secureedge5410_defconfig    gcc-15.2.0
sh                           sh2007_defconfig    clang-23
sh                     sh7710voipgw_defconfig    clang-23
sh                   sh7724_generic_defconfig    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260227    clang-23
sparc                 randconfig-002-20260227    clang-23
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260227    clang-23
sparc64               randconfig-002-20260227    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260227    clang-23
um                    randconfig-002-20260227    clang-23
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260227    gcc-14
x86_64      buildonly-randconfig-002-20260227    gcc-14
x86_64      buildonly-randconfig-003-20260227    gcc-14
x86_64      buildonly-randconfig-004-20260227    gcc-14
x86_64      buildonly-randconfig-005-20260227    gcc-14
x86_64      buildonly-randconfig-006-20260227    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260227    clang-20
x86_64                randconfig-001-20260227    gcc-13
x86_64                randconfig-002-20260227    clang-20
x86_64                randconfig-002-20260227    gcc-13
x86_64                randconfig-003-20260227    gcc-13
x86_64                randconfig-003-20260227    gcc-14
x86_64                randconfig-004-20260227    gcc-13
x86_64                randconfig-005-20260227    gcc-13
x86_64                randconfig-005-20260227    gcc-14
x86_64                randconfig-006-20260227    gcc-13
x86_64                randconfig-006-20260227    gcc-14
x86_64                randconfig-011-20260227    gcc-14
x86_64                randconfig-012-20260227    gcc-14
x86_64                randconfig-013-20260227    clang-20
x86_64                randconfig-013-20260227    gcc-14
x86_64                randconfig-014-20260227    clang-20
x86_64                randconfig-014-20260227    gcc-14
x86_64                randconfig-015-20260227    clang-20
x86_64                randconfig-015-20260227    gcc-14
x86_64                randconfig-016-20260227    gcc-14
x86_64                randconfig-071-20260227    gcc-14
x86_64                randconfig-072-20260227    gcc-14
x86_64                randconfig-073-20260227    gcc-14
x86_64                randconfig-074-20260227    gcc-14
x86_64                randconfig-075-20260227    gcc-14
x86_64                randconfig-076-20260227    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                  audio_kc705_defconfig    gcc-15.2.0
xtensa                  cadence_csp_defconfig    gcc-15.2.0
xtensa                generic_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260227    clang-23
xtensa                randconfig-002-20260227    clang-23

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-wireless+bounces-34099-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBJ8CPXqxmloQAUAu9opvQ
	(envelope-from <linux-wireless+bounces-34099-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 21:39:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8CC34B1C1
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 21:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86C5830DE5FC
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 20:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955A12C032E;
	Fri, 27 Mar 2026 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jxl6DGr8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2309430DD1E
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 20:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642694; cv=none; b=XtE77/qZXFI2VWDaLg9YDXNpqNULm3TcUVgpiDoeR/R3HFkR+1tuJ2rwFjuTS3xNosdTlC7lbTsXLWF6R1R9OiWLeGVWFYnXLqfWEJ/Yura9Ak9wRuQ0kPkkTGI54PP/e0Hi9MpjZv1kk/YDoA8LLKK9EDMCK0xMyc4BH0w4MUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642694; c=relaxed/simple;
	bh=Bkhomt0SFNzvjOOLTmqbOXBrxNPGkk6wh0IaP8nVNhA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QxNYUK7x/VcSXeMNrDlMs2ZezPU6uCRmbBmIzXoZIqOZaF8gZ3GoOZTVs4XgJAnrLpmi69M++bOVH4Du6USlNYXuAqDy8eUjcFXuVCpgtpAZHP7OUxzkDnQA5Q7O2+KNKBR8FP1Mtz1E3P1RTCiWLe0mClQZhJ9Yk8NiHpA8Eq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jxl6DGr8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774642693; x=1806178693;
  h=date:from:to:cc:subject:message-id;
  bh=Bkhomt0SFNzvjOOLTmqbOXBrxNPGkk6wh0IaP8nVNhA=;
  b=Jxl6DGr8BzjoAd9q0sGvKuCJfmQ1Yyyh89gISd9o/1dgXWsEPnplb8pH
   OZHPdxRTgq8jBwHXQ+1PQiksFU25qZwQTgDlok1debAQakqv6e3qh0pB1
   mm4gCX0Ofcsg5Heojoi8CVzYSvGHOPctl+Emh9QXEBQyvKR7KpMrbOvbs
   M9ZFQiZL2tZzii0QGDZIFduf/Um8Uwna2IdCmhsN/92LRKLYTDgQj8S/V
   VHiZIXmAKCRcvej3zl1ThdJ/3v32yyAeD8Vgz4yMvSKT2MwPkltIbVYeq
   u5f8RQdAij9pFU5wx2r+Z6Qikuwzh79GbCBl5d81fCyjU0vFRFsfQv2JD
   A==;
X-CSE-ConnectionGUID: FwP2srxvQl+hgRnkgoUu7Q==
X-CSE-MsgGUID: b/2euHgrSs2F1sRRO9T3NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="101183011"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="101183011"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:18:13 -0700
X-CSE-ConnectionGUID: 71P/oCedS2WSBpjMQFoTIQ==
X-CSE-MsgGUID: CKBqNPCnRZyeayPeX2Xbdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="222542522"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2026 13:18:11 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6DdA-00000000AhF-2uL7;
	Fri, 27 Mar 2026 20:18:08 +0000
Date: Sat, 28 Mar 2026 04:17:20 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 45dbf8fcea4dcf28cabcf4a1778e908feadf4c90
Message-ID: <202603280411.NKJBPRse-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34099-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF8CC34B1C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 45dbf8fcea4dcf28cabcf4a1778e908feadf4c90  Merge tag 'wireless-2026-03-26' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

elapsed time: 1154m

configs tested: 229
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260327    gcc-8.5.0
arc                   randconfig-001-20260328    gcc-15.2.0
arc                   randconfig-002-20260327    gcc-8.5.0
arc                   randconfig-002-20260328    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260327    gcc-8.5.0
arm                   randconfig-001-20260328    gcc-15.2.0
arm                   randconfig-002-20260327    gcc-8.5.0
arm                   randconfig-002-20260328    gcc-15.2.0
arm                   randconfig-003-20260327    gcc-8.5.0
arm                   randconfig-003-20260328    gcc-15.2.0
arm                   randconfig-004-20260327    gcc-8.5.0
arm                   randconfig-004-20260328    gcc-15.2.0
arm                           tegra_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260327    clang-23
arm64                 randconfig-001-20260328    gcc-14.3.0
arm64                 randconfig-002-20260327    clang-23
arm64                 randconfig-002-20260328    gcc-14.3.0
arm64                 randconfig-003-20260327    clang-23
arm64                 randconfig-003-20260328    gcc-14.3.0
arm64                 randconfig-004-20260327    clang-23
arm64                 randconfig-004-20260328    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260327    clang-23
csky                  randconfig-001-20260328    gcc-14.3.0
csky                  randconfig-002-20260327    clang-23
csky                  randconfig-002-20260328    gcc-14.3.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260327    gcc-8.5.0
hexagon               randconfig-001-20260328    gcc-11.5.0
hexagon               randconfig-002-20260327    gcc-8.5.0
hexagon               randconfig-002-20260328    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260327    clang-20
i386        buildonly-randconfig-001-20260328    clang-20
i386        buildonly-randconfig-002-20260327    clang-20
i386        buildonly-randconfig-002-20260328    clang-20
i386        buildonly-randconfig-003-20260327    clang-20
i386        buildonly-randconfig-003-20260328    clang-20
i386        buildonly-randconfig-004-20260327    clang-20
i386        buildonly-randconfig-004-20260328    clang-20
i386        buildonly-randconfig-005-20260327    clang-20
i386        buildonly-randconfig-005-20260328    clang-20
i386        buildonly-randconfig-006-20260327    clang-20
i386        buildonly-randconfig-006-20260328    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260327    clang-20
i386                  randconfig-002-20260327    clang-20
i386                  randconfig-003-20260327    clang-20
i386                  randconfig-004-20260327    clang-20
i386                  randconfig-005-20260327    clang-20
i386                  randconfig-006-20260327    clang-20
i386                  randconfig-007-20260327    clang-20
i386                  randconfig-011-20260327    gcc-14
i386                  randconfig-012-20260327    gcc-14
i386                  randconfig-013-20260327    gcc-14
i386                  randconfig-014-20260327    gcc-14
i386                  randconfig-015-20260327    gcc-14
i386                  randconfig-016-20260327    gcc-14
i386                  randconfig-017-20260327    gcc-14
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260327    gcc-8.5.0
loongarch             randconfig-001-20260328    gcc-11.5.0
loongarch             randconfig-002-20260327    gcc-8.5.0
loongarch             randconfig-002-20260328    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           ci20_defconfig    clang-23
mips                     cu1000-neo_defconfig    gcc-15.2.0
mips                  decstation_64_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260327    gcc-8.5.0
nios2                 randconfig-001-20260328    gcc-11.5.0
nios2                 randconfig-002-20260327    gcc-8.5.0
nios2                 randconfig-002-20260328    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260327    clang-18
parisc                randconfig-001-20260328    gcc-10.5.0
parisc                randconfig-002-20260327    clang-18
parisc                randconfig-002-20260328    gcc-10.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                 mpc837x_rdb_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260327    clang-18
powerpc               randconfig-001-20260328    gcc-10.5.0
powerpc               randconfig-002-20260327    clang-18
powerpc               randconfig-002-20260328    gcc-10.5.0
powerpc64             randconfig-001-20260327    clang-18
powerpc64             randconfig-001-20260328    gcc-10.5.0
powerpc64             randconfig-002-20260327    clang-18
powerpc64             randconfig-002-20260328    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260327    gcc-12.5.0
riscv                 randconfig-001-20260328    clang-23
riscv                 randconfig-002-20260327    gcc-12.5.0
riscv                 randconfig-002-20260328    clang-23
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260327    gcc-12.5.0
s390                  randconfig-001-20260328    clang-23
s390                  randconfig-002-20260327    gcc-12.5.0
s390                  randconfig-002-20260328    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260327    gcc-12.5.0
sh                    randconfig-001-20260328    clang-23
sh                    randconfig-002-20260327    gcc-12.5.0
sh                    randconfig-002-20260328    clang-23
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260327    gcc-14
sparc                 randconfig-001-20260328    gcc-14
sparc                 randconfig-002-20260327    gcc-14
sparc                 randconfig-002-20260328    gcc-14
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260327    gcc-14
sparc64               randconfig-001-20260328    gcc-14
sparc64               randconfig-002-20260327    gcc-14
sparc64               randconfig-002-20260328    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260327    gcc-14
um                    randconfig-001-20260328    gcc-14
um                    randconfig-002-20260327    gcc-14
um                    randconfig-002-20260328    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260327    clang-20
x86_64      buildonly-randconfig-001-20260328    clang-20
x86_64      buildonly-randconfig-002-20260327    clang-20
x86_64      buildonly-randconfig-002-20260328    clang-20
x86_64      buildonly-randconfig-003-20260327    clang-20
x86_64      buildonly-randconfig-003-20260328    clang-20
x86_64      buildonly-randconfig-004-20260327    clang-20
x86_64      buildonly-randconfig-004-20260328    clang-20
x86_64      buildonly-randconfig-005-20260327    clang-20
x86_64      buildonly-randconfig-005-20260328    clang-20
x86_64      buildonly-randconfig-006-20260327    clang-20
x86_64      buildonly-randconfig-006-20260328    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260327    gcc-14
x86_64                randconfig-002-20260327    gcc-14
x86_64                randconfig-003-20260327    gcc-14
x86_64                randconfig-004-20260327    gcc-14
x86_64                randconfig-005-20260327    gcc-14
x86_64                randconfig-006-20260327    gcc-14
x86_64                randconfig-011-20260327    gcc-14
x86_64                randconfig-012-20260327    gcc-14
x86_64                randconfig-013-20260327    gcc-14
x86_64                randconfig-014-20260327    gcc-14
x86_64                randconfig-015-20260327    gcc-14
x86_64                randconfig-016-20260327    gcc-14
x86_64                randconfig-071-20260327    gcc-13
x86_64                randconfig-072-20260327    gcc-13
x86_64                randconfig-073-20260327    gcc-13
x86_64                randconfig-074-20260327    gcc-13
x86_64                randconfig-075-20260327    gcc-13
x86_64                randconfig-076-20260327    gcc-13
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260327    gcc-14
xtensa                randconfig-001-20260328    gcc-14
xtensa                randconfig-002-20260327    gcc-14
xtensa                randconfig-002-20260328    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


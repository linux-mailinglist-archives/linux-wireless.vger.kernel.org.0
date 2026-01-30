Return-Path: <linux-wireless+bounces-31349-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCtvFPwyfGlzLQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31349-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 05:26:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC0BB7159
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 05:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E493B30094E8
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 04:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BEF2E7F29;
	Fri, 30 Jan 2026 04:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+baujif"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FAE1607A4
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 04:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769747193; cv=none; b=Lp4A38HsyrHFgPh46p/ncX0K3NbGTEOlUDPCKxju3fcUwj47JnYeMncAvROMsRDln8IZsYGOgDCyGw2J87vrQeGkl40SZ1IjBC91okZ9+9qOkfvwxcm95zDVKqqFHIsElrLuwbmhrAd3F8dMhsrIdKyVsNbPO6x2ob8Xm4pNnnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769747193; c=relaxed/simple;
	bh=RkioHkwkFgYE9HN4frOZC4ryNjc+hvUzwpVzxvhJir0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qLkg4k/+ir2dJlg4cvqxShUtS3dNvMVbuy07/4O5aaOgSWTJp5iJi9NFBFbOOTiX7ps14JN2Df7Z8I8Kf4XhT5NF4M/tjpkepzdIpDm7pzwVouCMAPqknYI+w4gG76bK4BMOgy03ApqJxemQNV8bSuMFHaWd6oWVUA1+VhwxBMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+baujif; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769747191; x=1801283191;
  h=date:from:to:cc:subject:message-id;
  bh=RkioHkwkFgYE9HN4frOZC4ryNjc+hvUzwpVzxvhJir0=;
  b=c+baujif9lYIFM8L2dcHTb7I/DCDNwkilkTpPJR2hulNuGToS1vB9EWg
   EnUpImEFpsx1K0la2VB5CEOY2urx3s0Ltfc25QFO7Ja5QMYE4G0ap11Gu
   3hR8OAvGxTAQorajWP71ulj3NdHnjmGP8YX0gvbNtuYxzDfLi/P7YLmyD
   13UpkOPaXfidcHkQW9KKjMU21+tj5MEFhpo0GTJF+LPV8OxZbQo88NmYl
   pl/SDyMBLxKGlYEj3MFhMhLJNKNSlTARU6bdiNOlwmcY9wGfcW0Xe0IfR
   5jzmWh4TnhKBOoLUeVJ0zY5WYBqQZTPLLAd9ailZpV47QuUhNHA6VvrKj
   Q==;
X-CSE-ConnectionGUID: OMX61UfATDS06qc+SAd2Rw==
X-CSE-MsgGUID: TM/pOnztQeOr6LL/xZ/3rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="73596409"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="73596409"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 20:26:31 -0800
X-CSE-ConnectionGUID: YnzC8iD3RBmQD7ObfHS3xA==
X-CSE-MsgGUID: qmralhuaRZWG2LnozMCuww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="208005436"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 29 Jan 2026 20:26:30 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlg5S-00000000cAf-3y4a;
	Fri, 30 Jan 2026 04:26:26 +0000
Date: Fri, 30 Jan 2026 12:26:10 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 0858206732250d24bb43b0e95beb50dffcbae665
Message-ID: <202601301204.2Z4iPcyu-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31349-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACC0BB7159
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 0858206732250d24bb43b0e95beb50dffcbae665  Merge tag 'wireless-2026-01-29' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

elapsed time: 935m

configs tested: 212
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260130    clang-17
arc                   randconfig-002-20260130    clang-17
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                      jornada720_defconfig    clang-22
arm                          moxart_defconfig    clang-22
arm                   randconfig-001-20260130    clang-17
arm                   randconfig-002-20260130    clang-17
arm                   randconfig-003-20260130    clang-17
arm                   randconfig-004-20260130    clang-17
arm                           stm32_defconfig    clang-22
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260130    gcc-8.5.0
arm64                 randconfig-002-20260130    gcc-8.5.0
arm64                 randconfig-003-20260130    gcc-8.5.0
arm64                 randconfig-004-20260130    clang-22
arm64                 randconfig-004-20260130    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260130    gcc-15.2.0
csky                  randconfig-001-20260130    gcc-8.5.0
csky                  randconfig-002-20260130    gcc-15.2.0
csky                  randconfig-002-20260130    gcc-8.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260129    clang-22
hexagon               randconfig-001-20260130    gcc-11.5.0
hexagon               randconfig-002-20260129    clang-22
hexagon               randconfig-002-20260130    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260129    clang-20
i386        buildonly-randconfig-001-20260130    clang-20
i386        buildonly-randconfig-002-20260129    clang-20
i386        buildonly-randconfig-002-20260130    clang-20
i386        buildonly-randconfig-003-20260129    clang-20
i386        buildonly-randconfig-003-20260130    clang-20
i386        buildonly-randconfig-004-20260129    clang-20
i386        buildonly-randconfig-004-20260130    clang-20
i386        buildonly-randconfig-005-20260129    clang-20
i386        buildonly-randconfig-005-20260130    clang-20
i386        buildonly-randconfig-006-20260129    clang-20
i386        buildonly-randconfig-006-20260130    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260130    clang-20
i386                  randconfig-001-20260130    gcc-14
i386                  randconfig-002-20260130    clang-20
i386                  randconfig-002-20260130    gcc-14
i386                  randconfig-003-20260130    clang-20
i386                  randconfig-003-20260130    gcc-14
i386                  randconfig-004-20260130    clang-20
i386                  randconfig-004-20260130    gcc-14
i386                  randconfig-005-20260130    gcc-14
i386                  randconfig-006-20260130    clang-20
i386                  randconfig-006-20260130    gcc-14
i386                  randconfig-007-20260130    gcc-14
i386                  randconfig-011-20260130    clang-20
i386                  randconfig-012-20260130    clang-20
i386                  randconfig-013-20260130    clang-20
i386                  randconfig-014-20260130    clang-20
i386                  randconfig-015-20260130    clang-20
i386                  randconfig-016-20260130    clang-20
i386                  randconfig-017-20260130    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260129    clang-22
loongarch             randconfig-001-20260130    gcc-11.5.0
loongarch             randconfig-002-20260129    clang-22
loongarch             randconfig-002-20260130    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           jazz_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260129    clang-22
nios2                 randconfig-001-20260130    gcc-11.5.0
nios2                 randconfig-002-20260129    clang-22
nios2                 randconfig-002-20260130    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260130    gcc-8.5.0
parisc                randconfig-002-20260130    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                     ksi8560_defconfig    clang-22
powerpc               randconfig-001-20260130    gcc-8.5.0
powerpc               randconfig-002-20260130    gcc-8.5.0
powerpc                 xes_mpc85xx_defconfig    clang-22
powerpc64             randconfig-001-20260130    gcc-8.5.0
powerpc64             randconfig-002-20260130    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260130    clang-22
riscv                 randconfig-002-20260130    clang-22
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260130    clang-22
s390                  randconfig-002-20260130    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260130    clang-22
sh                    randconfig-002-20260130    clang-22
sh                          rsk7269_defconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260130    clang-22
sparc                 randconfig-002-20260130    clang-22
sparc                       sparc32_defconfig    clang-22
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260130    clang-22
sparc64               randconfig-002-20260130    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260130    clang-22
um                    randconfig-002-20260130    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260130    clang-20
x86_64      buildonly-randconfig-002-20260130    clang-20
x86_64      buildonly-randconfig-002-20260130    gcc-14
x86_64      buildonly-randconfig-003-20260130    clang-20
x86_64      buildonly-randconfig-004-20260130    clang-20
x86_64      buildonly-randconfig-005-20260130    clang-20
x86_64      buildonly-randconfig-006-20260130    clang-20
x86_64      buildonly-randconfig-006-20260130    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260130    clang-20
x86_64                randconfig-002-20260130    clang-20
x86_64                randconfig-003-20260130    clang-20
x86_64                randconfig-004-20260130    clang-20
x86_64                randconfig-005-20260130    clang-20
x86_64                randconfig-006-20260130    clang-20
x86_64                randconfig-011-20260130    clang-20
x86_64                randconfig-012-20260130    clang-20
x86_64                randconfig-013-20260130    clang-20
x86_64                randconfig-014-20260130    clang-20
x86_64                randconfig-014-20260130    gcc-14
x86_64                randconfig-015-20260130    clang-20
x86_64                randconfig-016-20260130    clang-20
x86_64                randconfig-016-20260130    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20260130    clang-22
xtensa                randconfig-002-20260130    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


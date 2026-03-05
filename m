Return-Path: <linux-wireless+bounces-32517-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJonAx5rqWnH7AAAu9opvQ
	(envelope-from <linux-wireless+bounces-32517-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 12:38:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AD1210ACB
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 12:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2DF1301319B
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 11:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAABD38F659;
	Thu,  5 Mar 2026 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcq+U40J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5755C3783A8
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710678; cv=none; b=s9vwtBFBaocAZs/fuqsGUGOSox879GwvYeeaMhEF/jVpwX15R3YovTCwez/4U+g9qXxoFzWLr6/nTXOvq8nDRh+Flcif6xM2Rwnvf/gnsoWWLWzo2OzCJOKOTdxPPhCYAfPnloYJXanHoEe5S8LXvLntwZUl567V38I+5GOfDBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710678; c=relaxed/simple;
	bh=ky3MC2/vCqmvYOWLe3X5O+ZAAJPdHYeVEVqVKilmN+s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Lm/cuUEJLcvKbWcQz38HonEWyStsyaa7V3gPn2BzaaxUJ/P76uKVkbhQLRpfgf4j265/lraCW8QF2Rmt3NLJbREkEcbf9G8L2imc+cKrsHKpgCHLGKYkKDcRtnI6JMJALe0vpwNxTzp7BT9ILm5SHatjVJ1hKu6Ne0qyDHjTMtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcq+U40J; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772710674; x=1804246674;
  h=date:from:to:cc:subject:message-id;
  bh=ky3MC2/vCqmvYOWLe3X5O+ZAAJPdHYeVEVqVKilmN+s=;
  b=dcq+U40J/axOD3lQ1e5CspGZSfLUBifqcUXHCM9arfvYwlOAu7vlSsBO
   qQGvfOTSsAkqpyNyFsU3/fGr2tRWl0skDpa4h2w7zQ4R9cmlE8jNrtqRH
   0HCVsxyrLFC2kaDEvquIi/ZhQ2RkPT2IrYInvF/2Dz0ZX454Ga9T/PHFD
   /9X9KZbBPht0dIIUs73N6h0SGPpgAJhh8tLTSvMs34Ag+E8V3giI+00ap
   oonD4M9hDHBPNbBaLFaOBkZVSTX1aK5/sQT5JiuYn0yAAycZ+ZK8DlHog
   HOmN3Hf4QRt6n8XdBm7K0w43iWTrw3sa4c/HfSTCT7Alkk6ry3/fEUbGi
   A==;
X-CSE-ConnectionGUID: XVlAPOGtTUuGJrL6Dw+c9A==
X-CSE-MsgGUID: ekSoVqhdSlGY2Z6PfpXPEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73494012"
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="73494012"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 03:37:53 -0800
X-CSE-ConnectionGUID: 1KHFcxUZT42bWOXpSWvEcQ==
X-CSE-MsgGUID: UchNgjJEQrKRg1ucLwKMyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="215900969"
Received: from lkp-server01.sh.intel.com (HELO cadc4577a874) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 05 Mar 2026 03:37:50 -0800
Received: from kbuild by cadc4577a874 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vy71Y-000000000Xe-2KTP;
	Thu, 05 Mar 2026 11:37:48 +0000
Date: Thu, 05 Mar 2026 19:37:28 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 44d93cf1abb6a85d65c3b4b027c82d44263de6a5
Message-ID: <202603051920.U0ywMhSW-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 00AD1210ACB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32517-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 44d93cf1abb6a85d65c3b4b027c82d44263de6a5  wifi: UHR: define DPS/DBE/P-EDCA elements and fix size parsing

elapsed time: 1453m

configs tested: 166
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260305    clang-19
arc                   randconfig-002-20260305    clang-19
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                   randconfig-001-20260305    clang-19
arm                   randconfig-002-20260305    clang-19
arm                   randconfig-003-20260305    clang-19
arm                   randconfig-004-20260305    clang-19
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260305    gcc-8.5.0
arm64                 randconfig-002-20260305    gcc-8.5.0
arm64                 randconfig-003-20260305    gcc-8.5.0
arm64                 randconfig-004-20260305    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260305    gcc-8.5.0
csky                  randconfig-002-20260305    gcc-8.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260305    clang-20
i386        buildonly-randconfig-002-20260305    clang-20
i386        buildonly-randconfig-003-20260305    clang-20
i386        buildonly-randconfig-004-20260305    clang-20
i386        buildonly-randconfig-005-20260305    clang-20
i386        buildonly-randconfig-006-20260305    clang-20
i386                  randconfig-001-20260305    gcc-14
i386                  randconfig-002-20260305    gcc-14
i386                  randconfig-003-20260305    gcc-14
i386                  randconfig-004-20260305    gcc-14
i386                  randconfig-005-20260305    gcc-14
i386                  randconfig-006-20260305    gcc-14
i386                  randconfig-007-20260305    gcc-14
i386                  randconfig-011-20260305    clang-20
i386                  randconfig-012-20260305    clang-20
i386                  randconfig-013-20260305    clang-20
i386                  randconfig-014-20260305    clang-20
i386                  randconfig-015-20260305    clang-20
i386                  randconfig-016-20260305    clang-20
i386                  randconfig-017-20260305    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                        mvme16x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260305    gcc-9.5.0
parisc                randconfig-002-20260305    gcc-9.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260305    gcc-9.5.0
powerpc               randconfig-002-20260305    gcc-9.5.0
powerpc64             randconfig-001-20260305    gcc-9.5.0
powerpc64             randconfig-002-20260305    gcc-9.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260305    clang-23
riscv                 randconfig-002-20260305    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260305    clang-23
s390                  randconfig-002-20260305    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260305    clang-23
sh                    randconfig-002-20260305    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260305    clang-20
x86_64      buildonly-randconfig-002-20260305    clang-20
x86_64      buildonly-randconfig-003-20260305    clang-20
x86_64      buildonly-randconfig-004-20260305    clang-20
x86_64      buildonly-randconfig-005-20260305    clang-20
x86_64      buildonly-randconfig-006-20260305    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260305    clang-20
x86_64                randconfig-002-20260305    clang-20
x86_64                randconfig-003-20260305    clang-20
x86_64                randconfig-004-20260305    clang-20
x86_64                randconfig-005-20260305    clang-20
x86_64                randconfig-006-20260305    clang-20
x86_64                randconfig-011-20260305    clang-20
x86_64                randconfig-012-20260305    clang-20
x86_64                randconfig-013-20260305    clang-20
x86_64                randconfig-014-20260305    clang-20
x86_64                randconfig-015-20260305    clang-20
x86_64                randconfig-016-20260305    clang-20
x86_64                randconfig-071-20260305    gcc-14
x86_64                randconfig-072-20260305    gcc-14
x86_64                randconfig-073-20260305    gcc-14
x86_64                randconfig-074-20260305    gcc-14
x86_64                randconfig-075-20260305    gcc-14
x86_64                randconfig-076-20260305    gcc-14
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

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


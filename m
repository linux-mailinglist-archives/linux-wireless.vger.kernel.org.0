Return-Path: <linux-wireless+bounces-37641-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1WquDc3XKWrpeAMAu9opvQ
	(envelope-from <linux-wireless+bounces-37641-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 23:31:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FCB66D182
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 23:31:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=M9vlxyo3;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37641-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37641-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAD40313B767
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 21:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABC03A6B8E;
	Wed, 10 Jun 2026 21:29:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1091F3BADB1
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 21:29:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126999; cv=none; b=P3qyL0dIPlUn2LTS2p0jOkYP3kAWWxeNLwE5+D30Gvw1LMugpceT7yDVv1p5kH23ldyC5Ytc5+bV8I+S1iYBPt5fo4OAtAnn++ZLs4XmZ3+vsUM4pZfCJZFkBdmaugEa9DeTJ3gMS8PWiEaUr8yL5p3Isccn3KSd8o8Ng80GFy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126999; c=relaxed/simple;
	bh=e8JiE0S7gHaDIkZ8zZoGsozy6gOPLMce6ucV85Tf2e8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Kd/WIRthMz07PFTn41lNkZRdBnL/fYdZcEiYaGEk6C5YaQIZa1TkukW/EnOOt691xWzR/iB1k2GB8Dvq61P7+4Dwal4jb2t9qQ+XZ66u7ZoP4frLGsA+BvnHsGyx0ZEFb5ZvE5ktDsL1gIfROnwym0y3rPNsxLKgT2VbHfNpEzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9vlxyo3; arc=none smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781126997; x=1812662997;
  h=date:from:to:cc:subject:message-id;
  bh=e8JiE0S7gHaDIkZ8zZoGsozy6gOPLMce6ucV85Tf2e8=;
  b=M9vlxyo3cTzdsINo937OsX50Z7Nl2U2pLOjYqcqip+GdLvmzgSa+iHUM
   6D42IvQDD5PuBbGb5B6Kf6mB0G+4Uo2S7CIyD725YblD/hlqovh3ZKVy1
   5h4/Y3QZR/15ly9x4cR2P5jJhe8a05L1t1gesgY7OQqKQSqRwaFvFzZQa
   cj0kUhONiBGgwkPQ7MRDIkptPfo9r2wQdQN4uv8hKyklT6IOMsd52X6TZ
   bPA1KgHKJhnhbbbRK1ZvqdYDnhIjwStiWiT3saNqR4Y2IFZzWlWwfaZFT
   RESJlSrRMIToswLv8UcLu0YMufqe6YNquRFiJwN+5ZhYMWBo0XDNpJ7Fv
   w==;
X-CSE-ConnectionGUID: 0cbDm/x1QRyPPJDSRsZ/aQ==
X-CSE-MsgGUID: 1RiXT42lRI+efs5VKg7yyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="107372038"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="107372038"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 14:29:56 -0700
X-CSE-ConnectionGUID: 5ucC3SLwR56fgvhvivDOaA==
X-CSE-MsgGUID: TXJm0tu4RziaUZVUNrHXQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="245416430"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 10 Jun 2026 14:29:55 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXQUh-00000000Lve-3ktQ;
	Wed, 10 Jun 2026 21:29:51 +0000
Date: Thu, 11 Jun 2026 05:29:05 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 21352612198c83a8441482abbf3bd45e4f128dd0
Message-ID: <202606110556.glw7HM2X-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37641-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes.berg@intel.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0FCB66D182

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 21352612198c83a8441482abbf3bd45e4f128dd0  b43: add RF power offset for N-PHY r8 + radio 2057 r8

elapsed time: 760m

configs tested: 293
configs skipped: 106

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260610    gcc-8.5.0
arc                   randconfig-001-20260611    gcc-14.3.0
arc                   randconfig-002-20260610    gcc-8.5.0
arc                   randconfig-002-20260611    gcc-14.3.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    gcc-16.1.0
arm                        mvebu_v7_defconfig    clang-23
arm                   randconfig-001-20260610    clang-23
arm                   randconfig-001-20260610    gcc-8.5.0
arm                   randconfig-001-20260611    gcc-14.3.0
arm                   randconfig-002-20260610    clang-20
arm                   randconfig-002-20260610    gcc-8.5.0
arm                   randconfig-002-20260611    gcc-14.3.0
arm                   randconfig-003-20260610    clang-23
arm                   randconfig-003-20260610    gcc-8.5.0
arm                   randconfig-003-20260611    gcc-14.3.0
arm                   randconfig-004-20260610    clang-23
arm                   randconfig-004-20260610    gcc-8.5.0
arm                   randconfig-004-20260611    gcc-14.3.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260610    gcc-11.5.0
arm64                 randconfig-001-20260611    gcc-10.5.0
arm64                 randconfig-001-20260611    gcc-14.3.0
arm64                 randconfig-002-20260610    gcc-11.5.0
arm64                 randconfig-002-20260611    clang-23
arm64                 randconfig-002-20260611    gcc-14.3.0
arm64                 randconfig-003-20260610    gcc-11.5.0
arm64                 randconfig-003-20260611    gcc-10.5.0
arm64                 randconfig-003-20260611    gcc-14.3.0
arm64                 randconfig-004-20260610    gcc-11.5.0
arm64                 randconfig-004-20260611    clang-22
arm64                 randconfig-004-20260611    gcc-14.3.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260610    gcc-11.5.0
csky                  randconfig-001-20260611    gcc-14.3.0
csky                  randconfig-002-20260610    gcc-11.5.0
csky                  randconfig-002-20260611    gcc-14.3.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260611    clang-17
hexagon               randconfig-002-20260611    clang-17
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260610    gcc-14
i386        buildonly-randconfig-002-20260610    gcc-14
i386        buildonly-randconfig-003-20260610    gcc-14
i386        buildonly-randconfig-004-20260610    gcc-14
i386        buildonly-randconfig-005-20260610    gcc-14
i386        buildonly-randconfig-006-20260610    clang-22
i386        buildonly-randconfig-006-20260610    gcc-14
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260610    gcc-14
i386                  randconfig-001-20260611    gcc-14
i386                  randconfig-002-20260610    gcc-14
i386                  randconfig-002-20260611    gcc-14
i386                  randconfig-003-20260610    clang-22
i386                  randconfig-003-20260610    gcc-14
i386                  randconfig-003-20260611    gcc-14
i386                  randconfig-004-20260610    gcc-14
i386                  randconfig-004-20260611    gcc-14
i386                  randconfig-005-20260610    clang-22
i386                  randconfig-005-20260610    gcc-14
i386                  randconfig-005-20260611    gcc-14
i386                  randconfig-006-20260610    gcc-14
i386                  randconfig-006-20260611    gcc-14
i386                  randconfig-007-20260610    gcc-14
i386                  randconfig-007-20260611    gcc-14
i386                  randconfig-011-20260610    clang-22
i386                  randconfig-011-20260610    gcc-14
i386                  randconfig-011-20260611    gcc-14
i386                  randconfig-012-20260610    clang-22
i386                  randconfig-012-20260610    gcc-14
i386                  randconfig-012-20260611    gcc-14
i386                  randconfig-013-20260610    clang-22
i386                  randconfig-013-20260610    gcc-14
i386                  randconfig-013-20260611    gcc-14
i386                  randconfig-014-20260610    clang-22
i386                  randconfig-014-20260610    gcc-14
i386                  randconfig-014-20260611    gcc-14
i386                  randconfig-015-20260610    clang-22
i386                  randconfig-015-20260610    gcc-14
i386                  randconfig-015-20260611    gcc-14
i386                  randconfig-016-20260610    clang-22
i386                  randconfig-016-20260610    gcc-14
i386                  randconfig-016-20260611    gcc-14
i386                  randconfig-017-20260610    gcc-14
i386                  randconfig-017-20260611    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260611    clang-17
loongarch             randconfig-002-20260611    clang-17
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                         apollo_defconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                        m5272c3_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260611    clang-17
nios2                 randconfig-002-20260611    clang-17
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
openrisc                 simple_smp_defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260611    gcc-13.4.0
parisc                randconfig-002-20260611    gcc-13.4.0
parisc64                            defconfig    clang-23
powerpc                     akebono_defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260611    gcc-13.4.0
powerpc               randconfig-002-20260611    gcc-13.4.0
powerpc64             randconfig-001-20260611    gcc-13.4.0
powerpc64             randconfig-002-20260611    gcc-13.4.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                 randconfig-001-20260610    gcc-16.1.0
riscv                 randconfig-001-20260611    gcc-12.5.0
riscv                 randconfig-002-20260610    gcc-16.1.0
riscv                 randconfig-002-20260611    gcc-12.5.0
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260610    gcc-16.1.0
s390                  randconfig-001-20260611    gcc-12.5.0
s390                  randconfig-002-20260610    gcc-16.1.0
s390                  randconfig-002-20260611    gcc-12.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260610    gcc-16.1.0
sh                    randconfig-001-20260611    gcc-12.5.0
sh                    randconfig-002-20260610    gcc-16.1.0
sh                    randconfig-002-20260611    gcc-12.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260610    gcc-14.3.0
sparc                 randconfig-001-20260611    gcc-15.2.0
sparc                 randconfig-002-20260610    gcc-14.3.0
sparc                 randconfig-002-20260611    gcc-15.2.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260610    gcc-14.3.0
sparc64               randconfig-001-20260611    gcc-15.2.0
sparc64               randconfig-002-20260610    gcc-14.3.0
sparc64               randconfig-002-20260611    gcc-15.2.0
um                               allmodconfig    clang-17
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260610    gcc-14.3.0
um                    randconfig-001-20260611    gcc-15.2.0
um                    randconfig-002-20260610    gcc-14.3.0
um                    randconfig-002-20260611    gcc-15.2.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260610    clang-22
x86_64      buildonly-randconfig-001-20260610    gcc-14
x86_64      buildonly-randconfig-001-20260611    gcc-14
x86_64      buildonly-randconfig-002-20260610    gcc-14
x86_64      buildonly-randconfig-002-20260611    gcc-14
x86_64      buildonly-randconfig-003-20260610    clang-22
x86_64      buildonly-randconfig-003-20260610    gcc-14
x86_64      buildonly-randconfig-003-20260611    gcc-14
x86_64      buildonly-randconfig-004-20260610    clang-22
x86_64      buildonly-randconfig-004-20260610    gcc-14
x86_64      buildonly-randconfig-004-20260611    gcc-14
x86_64      buildonly-randconfig-005-20260610    gcc-14
x86_64      buildonly-randconfig-005-20260611    gcc-14
x86_64      buildonly-randconfig-006-20260610    gcc-14
x86_64      buildonly-randconfig-006-20260611    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260610    clang-22
x86_64                randconfig-001-20260610    gcc-13
x86_64                randconfig-001-20260611    gcc-14
x86_64                randconfig-002-20260610    clang-22
x86_64                randconfig-002-20260610    gcc-13
x86_64                randconfig-002-20260611    gcc-14
x86_64                randconfig-003-20260610    gcc-13
x86_64                randconfig-003-20260611    gcc-14
x86_64                randconfig-004-20260610    clang-22
x86_64                randconfig-004-20260610    gcc-13
x86_64                randconfig-004-20260611    gcc-14
x86_64                randconfig-005-20260610    clang-22
x86_64                randconfig-005-20260610    gcc-13
x86_64                randconfig-005-20260611    gcc-14
x86_64                randconfig-006-20260610    gcc-13
x86_64                randconfig-006-20260611    gcc-14
x86_64                randconfig-011-20260610    gcc-12
x86_64                randconfig-011-20260610    gcc-14
x86_64                randconfig-011-20260611    gcc-14
x86_64                randconfig-012-20260610    gcc-12
x86_64                randconfig-012-20260610    gcc-14
x86_64                randconfig-012-20260611    gcc-14
x86_64                randconfig-013-20260610    gcc-14
x86_64                randconfig-013-20260611    gcc-14
x86_64                randconfig-014-20260610    gcc-12
x86_64                randconfig-014-20260610    gcc-14
x86_64                randconfig-014-20260611    gcc-14
x86_64                randconfig-015-20260610    gcc-14
x86_64                randconfig-015-20260611    gcc-14
x86_64                randconfig-016-20260610    gcc-14
x86_64                randconfig-016-20260611    gcc-14
x86_64                randconfig-071-20260610    gcc-14
x86_64                randconfig-071-20260611    clang-22
x86_64                randconfig-072-20260610    gcc-14
x86_64                randconfig-072-20260611    clang-22
x86_64                randconfig-073-20260610    gcc-14
x86_64                randconfig-073-20260611    clang-22
x86_64                randconfig-074-20260610    gcc-14
x86_64                randconfig-074-20260611    clang-22
x86_64                randconfig-075-20260610    gcc-14
x86_64                randconfig-075-20260611    clang-22
x86_64                randconfig-076-20260610    gcc-14
x86_64                randconfig-076-20260611    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260610    gcc-14.3.0
xtensa                randconfig-001-20260611    gcc-15.2.0
xtensa                randconfig-002-20260610    gcc-14.3.0
xtensa                randconfig-002-20260611    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


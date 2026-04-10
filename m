Return-Path: <linux-wireless+bounces-34630-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAWPEpo82WkHnwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34630-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 20:08:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A88F33DB552
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 20:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A87873033088
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 18:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CB13E3DA0;
	Fri, 10 Apr 2026 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FmOLqv4b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032BF54652
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775844437; cv=none; b=mhhPMYMS+3iiDbhRxDHifR5kOrJBxQBap4XmkOOssHGlqCsampuFpTZlAzFNDZ10yKHgkuZUa2FdjIl7LtqFvhNIIUHzIDmrFRuucefOMWGow907W9kv2IOGCdFR44/E68eKhLOr0W6ghmJi7daCgDMsYFKgbVkAHZhgnu/VIPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775844437; c=relaxed/simple;
	bh=r/xoEaSpdaglUtMJZy4rRY6bOyQpl3k+f+Wu3giLPSY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ub6DuFVuBkcCqCSx8NO6O9ZZFfoVyh/C/6dfV7as7DVkQ2IGZZBnbZtEr/nNp2CwNtBtTDvXwkUZExwT030fPltuFRmsolwT5hvzi7uJlFYL56AtqeOTRrXn3ghw0J+x72UF1orot/6AEQ0jpCI3DwBa9xUivFSeHAQC7tAe7/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FmOLqv4b; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775844436; x=1807380436;
  h=date:from:to:cc:subject:message-id;
  bh=r/xoEaSpdaglUtMJZy4rRY6bOyQpl3k+f+Wu3giLPSY=;
  b=FmOLqv4b1C8BRzK1nmegdcEeXoLtTtfbXZEVTMit13Cfmu8kI8J6nPIn
   IHYwj8ztehomU9Az0W/OGYCw/kgc8NAuxlkjrOt9nJu7ZJ2bWFHoUW3aW
   6pDWDENtteN9bE9SK51G0ZmkvPpdkCKU257rEg3UN89aRjTJ09dCFokuV
   IHmexW2sFbq9udPJwmNeijP+ZXKTQ3rccsimSuhZuHUhWB48uByAf+Ft2
   3KdiQ6R0i6BbCcWGQYx0aqBkp7/S2Mr42bkuNbXw5NyzvzTmRKxPyuq8R
   lu5Y6f49zntTH8lICY5ST956ZC260/jOflw+nRVnl7903lXQnp/cLEpdk
   w==;
X-CSE-ConnectionGUID: NfeLO0jaSEahrQ1jvlDPCQ==
X-CSE-MsgGUID: FO5VdWwbQS2i/hO9EJuPVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="87158794"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="87158794"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 11:07:13 -0700
X-CSE-ConnectionGUID: M+esJcPFSsaaFC+488ahFg==
X-CSE-MsgGUID: w/nWaJwdRn+Osrrl4UWu8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="228295127"
Received: from lkp-server01.sh.intel.com (HELO 6449335cace3) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 10 Apr 2026 11:07:12 -0700
Received: from kbuild by 6449335cace3 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wBGG5-000000004B8-0PTP;
	Fri, 10 Apr 2026 18:07:09 +0000
Date: Sat, 11 Apr 2026 02:06:34 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 d65b175cfac64ee65506eea7fa573d291a9694ca
Message-ID: <202604110228.OxKluBeH-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34630-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: A88F33DB552
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: d65b175cfac64ee65506eea7fa573d291a9694ca  Merge tag 'wireless-2026-04-08' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

elapsed time: 730m

configs tested: 162
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
arc                   randconfig-001-20260410    gcc-8.5.0
arc                   randconfig-002-20260410    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260410    gcc-8.5.0
arm                   randconfig-002-20260410    gcc-8.5.0
arm                   randconfig-003-20260410    gcc-8.5.0
arm                   randconfig-004-20260410    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260410    gcc-10.5.0
arm64                 randconfig-002-20260410    gcc-10.5.0
arm64                 randconfig-003-20260410    gcc-10.5.0
arm64                 randconfig-004-20260410    gcc-10.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260410    gcc-10.5.0
csky                  randconfig-002-20260410    gcc-10.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260410    gcc-15.2.0
hexagon               randconfig-002-20260410    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260410    clang-20
i386        buildonly-randconfig-002-20260410    clang-20
i386        buildonly-randconfig-003-20260410    clang-20
i386        buildonly-randconfig-004-20260410    clang-20
i386        buildonly-randconfig-005-20260410    clang-20
i386        buildonly-randconfig-006-20260410    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260410    gcc-14
i386                  randconfig-002-20260410    gcc-14
i386                  randconfig-003-20260410    gcc-14
i386                  randconfig-004-20260410    gcc-14
i386                  randconfig-005-20260410    gcc-14
i386                  randconfig-006-20260410    gcc-14
i386                  randconfig-007-20260410    gcc-14
i386                  randconfig-011-20260410    clang-20
i386                  randconfig-012-20260410    clang-20
i386                  randconfig-013-20260410    clang-20
i386                  randconfig-014-20260410    clang-20
i386                  randconfig-015-20260410    clang-20
i386                  randconfig-016-20260410    clang-20
i386                  randconfig-017-20260410    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260410    gcc-15.2.0
loongarch             randconfig-002-20260410    gcc-15.2.0
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
mips                        vocore2_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260410    gcc-15.2.0
nios2                 randconfig-002-20260410    gcc-15.2.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260410    gcc-14.3.0
parisc                randconfig-002-20260410    gcc-14.3.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc               randconfig-001-20260410    gcc-14.3.0
powerpc               randconfig-002-20260410    gcc-14.3.0
powerpc64             randconfig-001-20260410    gcc-14.3.0
powerpc64             randconfig-002-20260410    gcc-14.3.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260410    clang-23
sparc                 randconfig-002-20260410    clang-23
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260410    clang-23
sparc64               randconfig-002-20260410    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260410    clang-23
um                    randconfig-002-20260410    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260410    clang-20
x86_64      buildonly-randconfig-002-20260410    clang-20
x86_64      buildonly-randconfig-003-20260410    clang-20
x86_64      buildonly-randconfig-004-20260410    clang-20
x86_64      buildonly-randconfig-005-20260410    clang-20
x86_64      buildonly-randconfig-006-20260410    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260410    clang-20
x86_64                randconfig-002-20260410    clang-20
x86_64                randconfig-003-20260410    clang-20
x86_64                randconfig-004-20260410    clang-20
x86_64                randconfig-005-20260410    clang-20
x86_64                randconfig-006-20260410    clang-20
x86_64                randconfig-011-20260410    gcc-14
x86_64                randconfig-012-20260410    gcc-14
x86_64                randconfig-013-20260410    gcc-14
x86_64                randconfig-014-20260410    gcc-14
x86_64                randconfig-015-20260410    gcc-14
x86_64                randconfig-016-20260410    gcc-14
x86_64                randconfig-071-20260410    clang-20
x86_64                randconfig-072-20260410    clang-20
x86_64                randconfig-073-20260410    clang-20
x86_64                randconfig-074-20260410    clang-20
x86_64                randconfig-075-20260410    clang-20
x86_64                randconfig-076-20260410    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260410    clang-23
xtensa                randconfig-002-20260410    clang-23

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-wireless+bounces-32457-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMhUA7/7p2mlnAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32457-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 10:30:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BFC1FD95D
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 10:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D95C2303839D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 09:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ABD3988E0;
	Wed,  4 Mar 2026 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTbdpUXT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF2C3537D3
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772616635; cv=none; b=OtVFNyvPNMIrZMCCvelEaUgN9HdpELxctYh/PX/oR9ra5X8DBoxS+NOFTddpPfc4NBUHRKLXjteL4hVIj4moxlUusbCJhkcRjdU+jANDhpqCT16Bt0jjRwNwl3TvIqHro9/bu4cCAQZE88J8Y5bYIUC2Btihi3B/thcIT+Bt03g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772616635; c=relaxed/simple;
	bh=XZ0Pwy9Z1AsqtFjsQbXmBHjFmMiJFUbNHrYnRAmi8vM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aoVgvFgDCuykmaMDGAJRw9FZ7dOtbqcDPxITukZI3n/5C6A5C1cs+HAKaNhoJyaYzqWJKC8Tq9hc7aTFfshUK5Q7s138Kv31qER31ZojqV8W1C5mCqDLsd5h2FSLe+iWTZ9liTSETmnnpy2MM4gJMW+0Z+oa92krKi0PApqniPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PTbdpUXT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772616634; x=1804152634;
  h=date:from:to:cc:subject:message-id;
  bh=XZ0Pwy9Z1AsqtFjsQbXmBHjFmMiJFUbNHrYnRAmi8vM=;
  b=PTbdpUXTJIo82TDMqC/9IhO4lF+A7rsSqCcgxsU9p++OiejrOzKuStUZ
   X9rnzQ1gEneznAU7lW7wHBvZYV1fc32pmdtyHMtONiMZpt4yMjeKO7yMO
   wNW+Lrf1l+FJ+vNBwXJx8Zvf31gwMrdYWW2xO2PeieT3tYu21En4CLoSB
   KFP53l8CfFLmul+ekxD0nvcHRW/pHac+d3xkDmhYiMQ5KDZ2BS9wg1d+c
   2Z6skBSCJEDLQFaAIxc6tlothRAXnPlgMMP/7NMelamo1GFly0GI+Qe9L
   9BPm28Fy/S4TOXltQqh9vNKuekW807Q4s3HOFstIIqaaGm0Va2iIQnrdF
   w==;
X-CSE-ConnectionGUID: 1u2TMGh2TuG9bxMHo2rORw==
X-CSE-MsgGUID: 04b5uA2/QECqkqFORXhuSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73545361"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="73545361"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 01:30:34 -0800
X-CSE-ConnectionGUID: sNaELKxMSeyS+s7Lc1cjuw==
X-CSE-MsgGUID: 4McO5t2VQyyjlKNwR4RaLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="256177290"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 04 Mar 2026 01:30:32 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxiYm-000000003Xt-1Fj9;
	Wed, 04 Mar 2026 09:30:28 +0000
Date: Wed, 04 Mar 2026 17:29:38 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 5d048bbed1bb2bbef612dad0bb9c177c434e63a4
Message-ID: <202603041730.U14iOHXz-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 87BFC1FD95D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32457-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 5d048bbed1bb2bbef612dad0bb9c177c434e63a4  wifi: mac80211: give the AP more time for EPPKE as well

elapsed time: 1345m

configs tested: 65
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.2.0
alpha        allyesconfig    gcc-15.2.0
arc          allmodconfig    clang-16
arc          allmodconfig    gcc-15.2.0
arc           allnoconfig    gcc-15.2.0
arc          allyesconfig    gcc-15.2.0
arm           allnoconfig    clang-23
arm          allyesconfig    clang-16
arm          allyesconfig    gcc-15.2.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.2.0
csky         allmodconfig    gcc-15.2.0
csky          allnoconfig    gcc-15.2.0
hexagon      allmodconfig    clang-17
hexagon      allmodconfig    gcc-15.2.0
hexagon       allnoconfig    clang-23
i386         allmodconfig    clang-20
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    clang-20
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-23
m68k         allmodconfig    gcc-15.2.0
m68k          allnoconfig    gcc-15.2.0
m68k         allyesconfig    clang-16
m68k         allyesconfig    gcc-15.2.0
microblaze    allnoconfig    gcc-15.2.0
microblaze   allyesconfig    gcc-15.2.0
mips         allmodconfig    gcc-15.2.0
mips          allnoconfig    gcc-15.2.0
mips         allyesconfig    gcc-15.2.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.2.0
openrisc      allnoconfig    gcc-15.2.0
parisc       allmodconfig    gcc-15.2.0
parisc        allnoconfig    gcc-15.2.0
parisc       allyesconfig    clang-19
parisc       allyesconfig    gcc-15.2.0
powerpc      allmodconfig    gcc-15.2.0
powerpc       allnoconfig    gcc-15.2.0
riscv        allmodconfig    clang-23
riscv         allnoconfig    gcc-15.2.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390         allmodconfig    clang-19
s390          allnoconfig    clang-23
s390         allyesconfig    gcc-15.2.0
sh           allmodconfig    gcc-15.2.0
sh            allnoconfig    gcc-15.2.0
sh           allyesconfig    clang-19
sh           allyesconfig    gcc-15.2.0
sparc         allnoconfig    gcc-15.2.0
sparc64      allmodconfig    clang-23
um           allmodconfig    clang-19
um            allnoconfig    clang-23
um           allyesconfig    gcc-14
um           allyesconfig    gcc-15.2.0
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.2.0
xtensa       allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-wireless+bounces-33285-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMClCwC4t2mpUgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33285-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 08:57:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29185295E85
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 08:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B3513003BC8
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 07:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB32353EE3;
	Mon, 16 Mar 2026 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IgXHDetv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A7924E4AF
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773647864; cv=none; b=U7/Aaz1mqAm6jEBbTOtvMvePrBs4nIjryMUcjyP/C0joN6FMjEmLLQWx8H4zeWgywjnZ5EQLOe2B8Bot1KI3BCl2nf5YdoAkVtsnKATm2V20x51HEc6SPyxd8PW9EyDpUgdH/7yPPgCtsg8IM6/wFUxXymUIrPPBix7xL55VO48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773647864; c=relaxed/simple;
	bh=p/Wvnc+ThisvVZsoVQFkuzPkNH15kbeYs0Qn+C4f9lc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FM6vzjPTZcmAqNpV3OIQhxMifKpVh7RxXjZFHA0k5xI7BSv3JQljSAa5iLESHPtNrVq30wwq9nFt798sOqJDipZtolNDr7fZhpfZFKwyagJ9//xIzhRS2kHNimlRI+uTunjs8MW2u0Gkkwti9mmseHmp5PFc++RCNpxIWcEmVMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IgXHDetv; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773647862; x=1805183862;
  h=date:from:to:cc:subject:message-id;
  bh=p/Wvnc+ThisvVZsoVQFkuzPkNH15kbeYs0Qn+C4f9lc=;
  b=IgXHDetvuJIYRMeL0Fasgir6duq2oPyKb9kjj3q7XRxYsib47D352pWo
   er/rU6KVN0T/z/R4iW/+yl0X8/XCgjS4UbuLYMm/uAJuttbtaU5XxRmlU
   N+vZRlQrtVU713A1+SmHxyzpLrwacd0sYIYwcNmX1c4+Hzf/mjWoxFOAS
   1m5lWTvAifTbajCrRjs0XqIRhbVsFpa7O3RTsOpZ8OYDlG4V2LDhXj7aL
   fyAJ8rtC6VVlSmSwYgXVal5m63cxFyo7kdVAM2zTcDaZtMT+AADfpEZqf
   SrdDb7BJ5wh/PHM1P4TeEpHrk0CcpYXJw1hUK6VKhEuMbYpS/iU9Eb7+g
   A==;
X-CSE-ConnectionGUID: rMaeUpUXS0uhKcjTnFIG4g==
X-CSE-MsgGUID: OwSe2VUTTOqI/p2QbkZA1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="86135229"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="86135229"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:57:42 -0700
X-CSE-ConnectionGUID: AurqCf/QRGWtealWE9EPIw==
X-CSE-MsgGUID: uIeZ+RCUQ+u91lbw4i3aXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="226296179"
Received: from lkp-server01.sh.intel.com (HELO 892944969b78) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 16 Mar 2026 00:57:41 -0700
Received: from kbuild by 892944969b78 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w22pW-000000000KG-0q9H;
	Mon, 16 Mar 2026 07:57:38 +0000
Date: Mon, 16 Mar 2026 15:56:47 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 7d73872d949c488a1d7c308031d6a9d89b5e0a8b
Message-ID: <202603161541.nyCee0IY-lkp@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33285-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 29185295E85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 7d73872d949c488a1d7c308031d6a9d89b5e0a8b  wifi: mac80211: check tdls flag in ieee80211_tdls_oper

elapsed time: 762m

configs tested: 60
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.2.0
alpha                  allyesconfig    gcc-15.2.0
arc                    allmodconfig    gcc-15.2.0
arc                     allnoconfig    gcc-15.2.0
arc                    allyesconfig    gcc-15.2.0
arm                     allnoconfig    clang-23
arm                    allyesconfig    gcc-15.2.0
arm64                  allmodconfig    clang-19
arm64                   allnoconfig    gcc-15.2.0
csky                   allmodconfig    gcc-15.2.0
csky                    allnoconfig    gcc-15.2.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-23
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-23
m68k                   allmodconfig    gcc-15.2.0
m68k                    allnoconfig    gcc-15.2.0
m68k                   allyesconfig    gcc-15.2.0
microblaze              allnoconfig    gcc-15.2.0
microblaze             allyesconfig    gcc-15.2.0
mips                   allmodconfig    gcc-15.2.0
mips                    allnoconfig    gcc-15.2.0
mips                   allyesconfig    gcc-15.2.0
nios2                  allmodconfig    gcc-11.5.0
nios2                   allnoconfig    gcc-11.5.0
openrisc               allmodconfig    gcc-15.2.0
openrisc                allnoconfig    gcc-15.2.0
parisc                 allmodconfig    gcc-15.2.0
parisc                  allnoconfig    gcc-15.2.0
parisc                 allyesconfig    gcc-15.2.0
powerpc                allmodconfig    gcc-15.2.0
powerpc                 allnoconfig    gcc-15.2.0
riscv                  allmodconfig    clang-23
riscv                   allnoconfig    gcc-15.2.0
riscv                  allyesconfig    clang-16
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-23
s390                   allyesconfig    gcc-15.2.0
sh                     allmodconfig    gcc-15.2.0
sh                      allnoconfig    gcc-15.2.0
sh                     allyesconfig    gcc-15.2.0
sparc                   allnoconfig    gcc-15.2.0
sparc       randconfig-001-20260316    gcc-8.5.0
sparc       randconfig-002-20260316    gcc-12.5.0
sparc64                allmodconfig    clang-23
sparc64     randconfig-001-20260316    gcc-8.5.0
sparc64     randconfig-002-20260316    gcc-15.2.0
um                     allmodconfig    clang-19
um                      allnoconfig    clang-23
um                     allyesconfig    gcc-14
um          randconfig-001-20260316    gcc-14
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.2.0
xtensa                 allyesconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


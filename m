Return-Path: <linux-wireless+bounces-37409-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YjSDG1edImruawEAu9opvQ
	(envelope-from <linux-wireless+bounces-37409-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 11:56:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C03F564719A
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 11:56:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=W3Ybuehq;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37409-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37409-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 912EF3016EE2
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 09:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F96A3B71C2;
	Fri,  5 Jun 2026 09:42:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE94F3B71CF
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2026 09:42:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652554; cv=none; b=olKOCxY4jgZV0/4eBPuna2iCtbdbJw35UF5HvBNORC5pOOX8ePk1xZCgwSTsr72VuuXSafX2FSjW4k3t0LJ4DKjVBdPFLn+KQS3Z0hmvQsNRsgjLVwQFP6i54lFa96Dc+aWRacaWwD6GjfV3pbec/GSNjILxoBoPeWQJ9KGC1IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652554; c=relaxed/simple;
	bh=ylgfeeqfTXctfMDfqci2+Z0B1x7b7+9zqt1NwYIfnIA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lR3qOPvIyexnXmZc5+poC3mOvetfyIApjuv8zbR4ApvYDNN/v0Bpz7+6Tkb+ZMtihpxySLkbo0imHNYHHa95QchBynk3hK0j+/EWPHUeWJCa8mnTfddZmFGiULpdT7rxiZYz+pkTer8yry3RWgac54EvS8UrpOnRiWFy+bgAcw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3Ybuehq; arc=none smtp.client-ip=198.175.65.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780652553; x=1812188553;
  h=date:from:to:cc:subject:message-id;
  bh=ylgfeeqfTXctfMDfqci2+Z0B1x7b7+9zqt1NwYIfnIA=;
  b=W3Ybuehq0NaevTfpClUl+YJF/wgDK6Lnooe8JI1dsbtXDkYREyeME1i/
   eeLMEvvR6GcZ+xyH1GyLxpWo8NZpi+lAwxFqPefnnXTLWNhcGlmATAgbd
   Htfxj3nj4ctu9CmpKraSMJCpydF/cTlMeqmcNSP18TjCzmpQkilCIWd70
   qymZViYoElItMEC+vjdAEO/wxRE4dvGTN2TaexhXe7pQNkHxcOhcrjuHP
   /VCbCZ0Z55gHecQ88L3vznLrmxmO8usgfazxFwpqm914IM1PzSaKdnril
   LWhitYQoMZ0hTN4Y4RQ+samh1lKACunffrM/iBeZpjwd4lkX7HATXCSS4
   Q==;
X-CSE-ConnectionGUID: X9iNAUmzSSSxgplcRu7g/A==
X-CSE-MsgGUID: isWvQbbFQGO2HHrCCdhTXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="98904382"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="98904382"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 02:42:33 -0700
X-CSE-ConnectionGUID: YjD4pakoTfGWxLGRREqvUA==
X-CSE-MsgGUID: ERYQanG8SkmZFG3GXxpBgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="248727173"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 05 Jun 2026 02:42:32 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wVR4P-00000000Fou-0Rue;
	Fri, 05 Jun 2026 09:42:29 +0000
Date: Fri, 05 Jun 2026 17:42:17 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD REGRESSION
 a26c2a22e7e88b2b5afb1349f3994fc564c988b1
Message-ID: <202606051706.0oHF7GPo-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37409-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS(0.00)[m:johannes.berg@intel.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:mid,intel.com:from_mime,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C03F564719A

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: a26c2a22e7e88b2b5afb1349f3994fc564c988b1  Merge tag 'iwlwifi-next-2026-06-03' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202606051450.DX9mBmLK-lkp@intel.com

    net/mac80211/mesh_hwmp.c:405:3: error: a label can only be part of a statement and a declaration is not a statement
    net/mac80211/mesh_hwmp.c:407:3: error: expected expression before 'struct'
    net/mac80211/mesh_hwmp.c:412:31: error: 'preq_elem_bottom' undeclared (first use in this function); did you mean 'preq_elem_top'?

Unverified Error/Warning (likely false positive, kindly check if interested):

    https://lore.kernel.org/oe-kbuild/202606051125.XaYVDQZf-lkp@intel.com

    drivers/net/wireless/ath/ath12k/wifi7/hw.c:979 ath12k_wifi7_mac_op_tx() error: buffer overflow 'ahsta->link' 15 <= 15

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm64-randconfig-001-20260605
|   |-- net-mac80211-mesh_hwmp.c:error:a-label-can-only-be-part-of-a-statement-and-a-declaration-is-not-a-statement
|   |-- net-mac80211-mesh_hwmp.c:error:expected-expression-before-struct
|   `-- net-mac80211-mesh_hwmp.c:error:preq_elem_bottom-undeclared-(first-use-in-this-function)
`-- x86_64-randconfig-161
    `-- drivers-net-wireless-ath-ath12k-wifi7-hw.c-ath12k_wifi7_mac_op_tx()-error:buffer-overflow-ahsta-link

elapsed time: 736m

configs tested: 72
configs skipped: 97

tested configs:
arm                           allnoconfig    clang-23
arm                          allyesconfig    gcc-15.2.0
arm                             defconfig    clang-23
arm                        dove_defconfig    gcc-16.1.0
arm               randconfig-001-20260605    gcc-13.4.0
arm               randconfig-002-20260605    gcc-8.5.0
arm               randconfig-003-20260605    clang-23
arm               randconfig-004-20260605    gcc-15.2.0
arm64                        allmodconfig    clang-19
arm64                         allnoconfig    gcc-15.2.0
arm64                           defconfig    gcc-16.1.0
arm64                      randconfig-001    gcc-14.3.0
arm64             randconfig-001-20260605    gcc-8.5.0
arm64                      randconfig-002    gcc-8.5.0
arm64             randconfig-002-20260605    gcc-13.4.0
arm64                      randconfig-003    clang-20
arm64             randconfig-003-20260605    gcc-11.5.0
arm64                      randconfig-004    clang-23
arm64             randconfig-004-20260605    clang-23
i386                         allmodconfig    clang-20
i386                          allnoconfig    gcc-14
i386                         allyesconfig    clang-20
i386    buildonly-randconfig-001-20260605    clang-20
i386    buildonly-randconfig-002-20260605    clang-20
i386    buildonly-randconfig-003-20260605    clang-20
i386    buildonly-randconfig-004-20260605    clang-20
i386    buildonly-randconfig-005-20260605    gcc-12
i386    buildonly-randconfig-006-20260605    gcc-14
i386                            defconfig    clang-22
i386              randconfig-001-20260605    clang-20
i386              randconfig-002-20260605    clang-20
i386              randconfig-003-20260605    gcc-14
i386              randconfig-004-20260605    gcc-14
i386              randconfig-005-20260605    clang-20
i386              randconfig-006-20260605    gcc-14
i386              randconfig-007-20260605    clang-20
i386              randconfig-011-20260605    clang-20
i386              randconfig-012-20260605    clang-20
i386              randconfig-013-20260605    clang-20
i386              randconfig-014-20260605    clang-20
i386              randconfig-015-20260605    clang-20
i386              randconfig-016-20260605    clang-20
i386              randconfig-017-20260605    clang-20
x86_64                       allmodconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20260605    gcc-14
x86_64  buildonly-randconfig-002-20260605    gcc-14
x86_64  buildonly-randconfig-003-20260605    gcc-14
x86_64  buildonly-randconfig-004-20260605    gcc-14
x86_64  buildonly-randconfig-005-20260605    gcc-14
x86_64  buildonly-randconfig-006-20260605    gcc-14
x86_64                          defconfig    gcc-14
x86_64            randconfig-001-20260605    clang-22
x86_64            randconfig-002-20260605    clang-22
x86_64            randconfig-003-20260605    clang-22
x86_64            randconfig-004-20260605    gcc-13
x86_64            randconfig-005-20260605    clang-22
x86_64            randconfig-006-20260605    gcc-14
x86_64            randconfig-011-20260605    clang-22
x86_64            randconfig-012-20260605    gcc-14
x86_64            randconfig-013-20260605    clang-22
x86_64            randconfig-014-20260605    clang-22
x86_64            randconfig-015-20260605    gcc-14
x86_64            randconfig-016-20260605    clang-22
x86_64            randconfig-071-20260605    gcc-14
x86_64            randconfig-072-20260605    gcc-14
x86_64            randconfig-073-20260605    clang-22
x86_64            randconfig-074-20260605    gcc-14
x86_64            randconfig-075-20260605    gcc-12
x86_64            randconfig-076-20260605    gcc-14
x86_64                      rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


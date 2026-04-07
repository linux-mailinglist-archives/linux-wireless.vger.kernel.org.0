Return-Path: <linux-wireless+bounces-34470-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFc5KkUd1Wnr0wcAu9opvQ
	(envelope-from <linux-wireless+bounces-34470-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 17:05:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D893B09F4
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 17:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAEC030D9028
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 14:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6214F33D51F;
	Tue,  7 Apr 2026 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViABiTZf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E933D6F8
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573861; cv=none; b=ji8Y1aZoFcP1DFN/NDgd1ZquysmTyoJ2ZA+toO9O0MyvQM87RV+iK8NwzsouTLsQ8isJC8Gnj9L63t3ofReg1JBpqwPwXTDKWJid+w31WxAo6C05UfO3vDYljCg3KxftRX5nOsatC6v42FzmcYHIcjdCQnTBQA1llpzQ7MGETmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573861; c=relaxed/simple;
	bh=15L1ST6FhRrF8Jjim2IjULzpYsP2AHkFcs2Y64FsoSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0+rVQraKZw4iKhPgsPNRMRBVujtMSuiV2hSbzcwoM9HggTSdPzlS3gSmMMKJiZZkSjNtnQ1Rx+9Qyyjc4sqjwvTQZJnzYJLByzrpHLHS5lq7lNCFqAivMIJebTXTvjeHRLRpoBmJBPmj9yi9ltc/PSwpGKBvfDMs/BMkMGdGiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViABiTZf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775573859; x=1807109859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=15L1ST6FhRrF8Jjim2IjULzpYsP2AHkFcs2Y64FsoSQ=;
  b=ViABiTZfdVdNqf4ygXZ/JAjAPxt8+ktUMHX8dkAo6+yQ/enQZEgkEcfv
   Lepg2WLHpG5s+GMi3es9NdrCI8xxHzHgCq3vVaYAHhVF8xQluzzEvQ0Z6
   iB2UzIn1jdUeoL1pzPoZQpinpR330EXdMYquddstaggWsba65sqA5hs8V
   MoyqfLrg9y+gQ2/qVfd1W2OIWyJqSyqOZw3I9dkdx2heITb8o0Sx4eohL
   kqWaE28K6phiGAdYuqYLUUOxUJt3SLOqkJJJq33D1DOtyItU1kq6qSb12
   vk6tVkDRO34yUJD/FEFWlJ7InpfuL6hFrXiT24gsDp7yLO/hXZZo6MZfV
   g==;
X-CSE-ConnectionGUID: m38f7ah6S/WeKCh0X/RO1Q==
X-CSE-MsgGUID: 5vIL972uR1ia9xBAxNB/kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="99165690"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="99165690"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 07:57:36 -0700
X-CSE-ConnectionGUID: CKEHrC1fQjWp0a0pD58hOA==
X-CSE-MsgGUID: DGaOj9jHRqahhdv5QRranA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="233157229"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 07 Apr 2026 07:57:34 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wA7rv-000000000i1-08tD;
	Tue, 07 Apr 2026 14:57:31 +0000
Date: Tue, 7 Apr 2026 22:56:37 +0800
From: kernel test robot <lkp@intel.com>
To: Joshua Klinesmith <joshuaklinesmith@gmail.com>,
	linux-wireless@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, nbd@nbd.name,
	lorenzo@kernel.org, ryder.lee@mediatek.com,
	shayne.chen@mediatek.com, sean.wang@mediatek.com,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>
Subject: Re: [PATCH wireless v2] wifi: mt76: mt7996: replace direct WTBL
 access with MCU for station statistics
Message-ID: <202604072218.tGCSoRNR-lkp@intel.com>
References: <20260407053855.75828-1-joshuaklinesmith@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407053855.75828-1-joshuaklinesmith@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,nbd.name,kernel.org,mediatek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-34470-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,01.org:url,intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0D893B09F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Joshua,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless/main]
[also build test ERROR on linus/master v7.0-rc7 next-20260406]
[cannot apply to wireless-next/main]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joshua-Klinesmith/wifi-mt76-mt7996-replace-direct-WTBL-access-with-MCU-for-station-statistics/20260407-151612
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git main
patch link:    https://lore.kernel.org/r/20260407053855.75828-1-joshuaklinesmith%40gmail.com
patch subject: [PATCH wireless v2] wifi: mt76: mt7996: replace direct WTBL access with MCU for station statistics
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20260407/202604072218.tGCSoRNR-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260407/202604072218.tGCSoRNR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604072218.tGCSoRNR-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:4870:10: error: incompatible pointer types assigning to 'struct mt76_vif_link *' from 'struct mt76_vif_data *' [-Werror,-Wincompatible-pointer-types]
    4870 |                                 mvif = &msta_link->sta->vif->mt76;
         |                                      ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:4871:35: error: no member named 'link' in 'struct mt76_vif_link'
    4871 |                                 mlink = rcu_dereference(mvif->link[wcid->link_id]);
         |                                                         ~~~~  ^
   include/linux/rcupdate.h:752:50: note: expanded from macro 'rcu_dereference'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                                                  ^
   include/linux/rcupdate.h:662:27: note: expanded from macro 'rcu_dereference_check'
     662 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:514:10: note: expanded from macro '__rcu_dereference_check'
     514 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                 ^
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:4871:35: error: no member named 'link' in 'struct mt76_vif_link'
    4871 |                                 mlink = rcu_dereference(mvif->link[wcid->link_id]);
         |                                                         ~~~~  ^
   include/linux/rcupdate.h:752:50: note: expanded from macro 'rcu_dereference'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                                                  ^
   include/linux/rcupdate.h:662:27: note: expanded from macro 'rcu_dereference_check'
     662 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:514:31: note: expanded from macro '__rcu_dereference_check'
     514 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                      ^
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:4871:35: error: no member named 'link' in 'struct mt76_vif_link'
    4871 |                                 mlink = rcu_dereference(mvif->link[wcid->link_id]);
         |                                                         ~~~~  ^
   include/linux/rcupdate.h:752:50: note: expanded from macro 'rcu_dereference'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                                                  ^
   include/linux/rcupdate.h:662:27: note: expanded from macro 'rcu_dereference_check'
     662 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:514:53: note: expanded from macro '__rcu_dereference_check'
     514 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:706:22: note: expanded from macro 'compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:694:23: note: expanded from macro '_compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:4871:35: error: no member named 'link' in 'struct mt76_vif_link'
    4871 |                                 mlink = rcu_dereference(mvif->link[wcid->link_id]);
         |                                                         ~~~~  ^
   include/linux/rcupdate.h:752:50: note: expanded from macro 'rcu_dereference'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                                                  ^
   include/linux/rcupdate.h:662:27: note: expanded from macro 'rcu_dereference_check'
     662 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:514:53: note: expanded from macro '__rcu_dereference_check'
     514 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:706:22: note: expanded from macro 'compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:694:23: note: expanded from macro '_compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:4871:35: error: no member named 'link' in 'struct mt76_vif_link'
    4871 |                                 mlink = rcu_dereference(mvif->link[wcid->link_id]);
         |                                                         ~~~~  ^
   include/linux/rcupdate.h:752:50: note: expanded from macro 'rcu_dereference'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                                                  ^
   include/linux/rcupdate.h:662:27: note: expanded from macro 'rcu_dereference_check'
     662 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:514:53: note: expanded from macro '__rcu_dereference_check'
     514 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:706:22: note: expanded from macro 'compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:694:23: note: expanded from macro '_compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:4871:35: error: no member named 'link' in 'struct mt76_vif_link'
    4871 |                                 mlink = rcu_dereference(mvif->link[wcid->link_id]);
         |                                                         ~~~~  ^
   include/linux/rcupdate.h:752:50: note: expanded from macro 'rcu_dereference'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                                                  ^
   include/linux/rcupdate.h:662:27: note: expanded from macro 'rcu_dereference_check'
     662 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:514:53: note: expanded from macro '__rcu_dereference_check'
     514 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:706:22: note: expanded from macro 'compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:694:23: note: expanded from macro '_compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:4871:35: error: no member named 'link' in 'struct mt76_vif_link'
    4871 |                                 mlink = rcu_dereference(mvif->link[wcid->link_id]);
         |                                                         ~~~~  ^
   include/linux/rcupdate.h:752:50: note: expanded from macro 'rcu_dereference'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                                                  ^
   include/linux/rcupdate.h:662:27: note: expanded from macro 'rcu_dereference_check'
     662 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:514:53: note: expanded from macro '__rcu_dereference_check'
     514 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:706:22: note: expanded from macro 'compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:694:23: note: expanded from macro '_compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:4871:35: error: no member named 'link' in 'struct mt76_vif_link'
    4871 |                                 mlink = rcu_dereference(mvif->link[wcid->link_id]);
         |                                                         ~~~~  ^
   include/linux/rcupdate.h:752:50: note: expanded from macro 'rcu_dereference'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                                                  ^
   include/linux/rcupdate.h:662:27: note: expanded from macro 'rcu_dereference_check'
     662 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:514:53: note: expanded from macro '__rcu_dereference_check'
     514 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:65: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                  ^
   include/linux/compiler_types.h:642:53: note: expanded from macro '__unqual_scalar_typeof'
     642 | #define __unqual_scalar_typeof(x) __typeof_unqual__(x)
         |                                                     ^
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:4871:35: error: no member named 'link' in 'struct mt76_vif_link'
    4871 |                                 mlink = rcu_dereference(mvif->link[wcid->link_id]);
         |                                                         ~~~~  ^
   include/linux/rcupdate.h:752:50: note: expanded from macro 'rcu_dereference'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                                                  ^
   include/linux/rcupdate.h:662:27: note: expanded from macro 'rcu_dereference_check'
     662 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:514:53: note: expanded from macro '__rcu_dereference_check'
     514 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:72: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:4871:35: error: no member named 'link' in 'struct mt76_vif_link'
    4871 |                                 mlink = rcu_dereference(mvif->link[wcid->link_id]);
         |                                                         ~~~~  ^
   include/linux/rcupdate.h:752:50: note: expanded from macro 'rcu_dereference'
     752 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                                                  ^
   include/linux/rcupdate.h:662:27: note: expanded from macro 'rcu_dereference_check'
     662 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:517:12: note: expanded from macro '__rcu_dereference_check'
     517 |         ((typeof(*p) __force __kernel *)(local)); \
         |                   ^
>> drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:4871:11: error: assigning to 'struct mt76_vif_link *' from incompatible type 'void'
    4871 |                                 mlink = rcu_dereference(mvif->link[wcid->link_id]);
         |                                       ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   12 errors generated.


vim +4870 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c

  4786	
  4787	int mt7996_mcu_get_per_sta_info(struct mt7996_phy *phy, u16 tag)
  4788	{
  4789		struct mt7996_dev *dev = phy->dev;
  4790		struct mt7996_mcu_per_sta_info_event *res;
  4791		struct mt76_wcid *wcid;
  4792		struct sk_buff *skb;
  4793		int i, ret, sta_num, resp_sta_num;
  4794		int wcid_idx = 0;
  4795		struct {
  4796			u8 _rsv1;
  4797			u8 unsolicit;
  4798			u8 _rsv2[2];
  4799	
  4800			__le16 tag;
  4801			__le16 len;
  4802			__le16 sta_num;
  4803			u8 _rsv3[2];
  4804			__le16 wlan_idx[PER_STA_INFO_MAX_NUM];
  4805		} __packed req = {
  4806			.tag = cpu_to_le16(tag),
  4807			.len = cpu_to_le16(sizeof(req) - 4),
  4808		};
  4809	
  4810		while (wcid_idx < mt7996_wtbl_size(dev)) {
  4811			sta_num = 0;
  4812	
  4813			rcu_read_lock();
  4814			for (i = wcid_idx;
  4815			     i < mt7996_wtbl_size(dev) && sta_num < PER_STA_INFO_MAX_NUM;
  4816			     i++) {
  4817				wcid = rcu_dereference(dev->mt76.wcid[i]);
  4818				if (!wcid || !wcid->sta)
  4819					continue;
  4820				req.wlan_idx[sta_num++] = cpu_to_le16(i);
  4821			}
  4822			rcu_read_unlock();
  4823			wcid_idx = i;
  4824	
  4825			if (!sta_num)
  4826				continue;
  4827	
  4828			req.sta_num = cpu_to_le16(sta_num);
  4829	
  4830			ret = mt76_mcu_send_and_get_msg(&dev->mt76,
  4831							MCU_WM_UNI_CMD(PER_STA_INFO),
  4832							&req, sizeof(req), true, &skb);
  4833			if (ret)
  4834				return ret;
  4835	
  4836			res = (struct mt7996_mcu_per_sta_info_event *)skb->data;
  4837	
  4838			resp_sta_num = le16_to_cpu(res->sta_num);
  4839			if (resp_sta_num > sta_num ||
  4840			    skb->len < struct_size(res, rssi, resp_sta_num)) {
  4841				dev_kfree_skb(skb);
  4842				return -EINVAL;
  4843			}
  4844	
  4845			rcu_read_lock();
  4846			for (i = 0; i < resp_sta_num; i++) {
  4847				struct mt7996_sta_link *msta_link;
  4848				struct mt76_vif_link *mvif;
  4849				struct mt76_vif_link *mlink;
  4850				struct mt76_phy *mphy;
  4851				u16 wlan_idx;
  4852				s8 rssi[4];
  4853	
  4854				switch (tag) {
  4855				case UNI_PER_STA_RSSI:
  4856					wlan_idx = le16_to_cpu(res->rssi[i].wlan_idx);
  4857					wcid = mt76_wcid_ptr(dev, wlan_idx);
  4858					if (!wcid || !wcid->sta)
  4859						break;
  4860	
  4861					msta_link = container_of(wcid,
  4862								 struct mt7996_sta_link,
  4863								 wcid);
  4864	
  4865					rssi[0] = (res->rssi[i].rcpi[0] - 220) / 2;
  4866					rssi[1] = (res->rssi[i].rcpi[1] - 220) / 2;
  4867					rssi[2] = (res->rssi[i].rcpi[2] - 220) / 2;
  4868					rssi[3] = (res->rssi[i].rcpi[3] - 220) / 2;
  4869	
> 4870					mvif = &msta_link->sta->vif->mt76;
> 4871					mlink = rcu_dereference(mvif->link[wcid->link_id]);
  4872					if (mlink) {
  4873						mphy = mt76_vif_link_phy(mlink);
  4874						if (mphy)
  4875							msta_link->ack_signal =
  4876								mt76_rx_signal(mphy->antenna_mask,
  4877									       rssi);
  4878					}
  4879	
  4880					ewma_avg_signal_add(&msta_link->avg_ack_signal,
  4881							    -msta_link->ack_signal);
  4882					break;
  4883				}
  4884			}
  4885			rcu_read_unlock();
  4886	
  4887			dev_kfree_skb(skb);
  4888		}
  4889	
  4890		return 0;
  4891	}
  4892	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


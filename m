Return-Path: <linux-wireless+bounces-37410-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AIeyDgSkImp6bQEAu9opvQ
	(envelope-from <linux-wireless+bounces-37410-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 12:25:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F1A6474C7
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 12:25:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=h35ZrMuI;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37410-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37410-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1425B300D33C
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 10:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AFB3F0AA8;
	Fri,  5 Jun 2026 10:10:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0D1378D9C;
	Fri,  5 Jun 2026 10:10:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654217; cv=none; b=ByIfwMU7Z6EJfloQXxrPkyr2+34YE6Iyq1ZvkvxcBffqnNVD8Evyv4gcTDM20jgAv8KNlLvdr1yvNZ1ggum5zU0uTxUD/NmzkGY9Y/UyPXfaAFUqaP9EtA3fftM4Bj/jM7Nv/Z/qjsNp8ARvvkRCGEtP5FJG53qG4YMZ7smTkgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654217; c=relaxed/simple;
	bh=OniSiIUZfkX9DzebqNGw39xDzYzBX34avMJiWZQ0/+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBeSLrM2WeSeLIAfB1sA6HTCaiEZ+4BnwyxOcK2rhi0RPndabCGVx0gCkWgqyfWp7AnyRejDKI8ZdWr+ERdJDF/N3/B5BWxRq2otUdt+ho9lGZu+saqQ4+h1V93w0xHRIspj0NsFyMetC4XyobGD1MmT+rVOn69fhXBGaX9rzec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h35ZrMuI; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780654216; x=1812190216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OniSiIUZfkX9DzebqNGw39xDzYzBX34avMJiWZQ0/+w=;
  b=h35ZrMuI2ArPDX2i7Z/4XcYi0XGxs7goOvbyH+ShKUG6sKC0b32sNTcc
   OG9eSuwWrlB42DEwp9ITiEJMCQ+MYhZHyKJ8B14XP1zIk/x9sTTenUTx/
   foWpVdPnmORNT03bY3XEM01rhMQBhSkbaLHtldOjKN3rGjpPZU4mwF6Sw
   mZLnAMj7Oh7fqZnqI2kQ3oU5FKtc9RR4Je7RNoh0QvJlMTN8mVvsc5MsO
   vnhbpftX7TBdye3QQvaCuCcZey+XGcg9YpWWg2vImrFv2/Z5Uo0I8FLWi
   1f85pkwI878BPRwgvLteazoZVxuGD5C3gXIh9EdIp74v3ye9QK3qXMb/5
   g==;
X-CSE-ConnectionGUID: CmPlc9R7QfS9YIRlujpCLw==
X-CSE-MsgGUID: zrHEpBZlQouuIZM/Xtdmzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="99060920"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="99060920"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 03:10:15 -0700
X-CSE-ConnectionGUID: G2iaHSZwT8WTfLzUaJEI1g==
X-CSE-MsgGUID: pueleeM3QFS0yypcI/V8zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="268499513"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa002.fm.intel.com with ESMTP; 05 Jun 2026 03:10:13 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wVRVD-000000002Y5-3MAz;
	Fri, 05 Jun 2026 10:10:11 +0000
Date: Fri, 5 Jun 2026 12:09:42 +0200
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 wireless-next] wifi: mac80211: fold tid_ampdu_rx
 allocations into a flexible array
Message-ID: <202606051234.K5D1iGLy-lkp@intel.com>
References: <20260605005627.317194-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605005627.317194-1-rosenp@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37410-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:linux-wireless@vger.kernel.org,m:oe-kbuild-all@lists.linux.dev,m:johannes@sipsolutions.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,git-scm.com:url,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95F1A6474C7

Hi Rosen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v7.1-rc6 next-20260604]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/wifi-mac80211-fold-tid_ampdu_rx-allocations-into-a-flexible-array/20260605-085839
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20260605005627.317194-1-rosenp%40gmail.com
patch subject: [PATCHv2 wireless-next] wifi: mac80211: fold tid_ampdu_rx allocations into a flexible array
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project f43d6834093b19baf79beda8c0337ab020ac5f17)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260605/202606051234.K5D1iGLy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606051234.K5D1iGLy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   int kref_put_mutex (struct kref *kref, void (*release)(struct kref *kref), struct mutex *mutex) __cond_acquires(true# mutex)
   ------------------------------------------------------------------------------------------------^
   Documentation/core-api/kref:328: ./include/linux/kref.h:94: WARNING: Invalid C declaration: Expected end of definition. [error at 92]
   int kref_put_lock (struct kref *kref, void (*release)(struct kref *kref), spinlock_t *lock) __cond_acquires(true# lock)
   --------------------------------------------------------------------------------------------^
>> Documentation/driver-api/80211/mac80211-advanced:228: ./net/mac80211/sta_info.h:229: WARNING: Inline strong start-string without end-string. [docutils]
>> Documentation/driver-api/80211/mac80211-advanced:228: ./net/mac80211/sta_info.h:229: WARNING: Inline strong start-string without end-string. [docutils]
   Documentation/driver-api/basics:42: ./kernel/time/time.c:370: WARNING: Duplicate C declaration, also defined at driver-api/basics:436.
   Declaration is '.. c:function:: unsigned int jiffies_to_msecs (const unsigned long j)'. [duplicate_declaration.c]
   Documentation/driver-api/basics:42: ./kernel/time/time.c:393: WARNING: Duplicate C declaration, also defined at driver-api/basics:453.
   Declaration is '.. c:function:: unsigned int jiffies_to_usecs (const unsigned long j)'. [duplicate_declaration.c]
   Documentation/driver-api/target:25: ./drivers/target/target_core_user.c:35: ERROR: Unexpected section title.

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


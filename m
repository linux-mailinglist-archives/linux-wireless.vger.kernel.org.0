Return-Path: <linux-wireless+bounces-37364-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BLsnOvtyIGp/3gAAu9opvQ
	(envelope-from <linux-wireless+bounces-37364-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 20:31:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E542B63A929
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 20:31:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="U/nTyzJE";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37364-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37364-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82A7230136EE
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 18:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8C93859E0;
	Wed,  3 Jun 2026 18:25:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964CC3E717A
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 18:25:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511153; cv=none; b=qUunPntfeQ3Dpxp06eki+c2lSH+gXjexEyKfQQMMGyDk6vfM/Y+GY9EqdsZDKOixFTstMZSLzXQbu7omQKK3UIQHASF1jW+f7/Fsali61VVLMn9VUdMFgVNgVdd9Yo7YQv79EICNZYjcIGHgpvAiHXE+vBK1IkNcKWK/0ruwCEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511153; c=relaxed/simple;
	bh=paMVrycLzmw7F4LnUkBVQLqKtPbWFLbLGm9QNpm1SQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnJYzI0sgtur85yIO8+If5gJ0aaRW2e/TnoKHdT4rFD6XPbWHnI+TWyuJkUrQF/4p5aVSY+v/KXcOMvt/mdMOQq34QmzBYoMLuyCO8bSJd3UO/QG7cJBAy8+7141AGJ9MUoNEnRrWiU1hl7FGfSAsbCnWXMA/vas25Euz2tBZCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/nTyzJE; arc=none smtp.client-ip=192.198.163.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780511149; x=1812047149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=paMVrycLzmw7F4LnUkBVQLqKtPbWFLbLGm9QNpm1SQM=;
  b=U/nTyzJEgJeIVxc9JQBKxJuGBivQmvvDqQN3wLZFj4gasvJ8KAvbsSWT
   S1f/BQpXMnZ44oGjVv3YL9F/zjNHmQdC0Ly4hIk4359ZHNqMvhcrrqbSQ
   WDhcsU0mtSxf4+Vp9QE4jnSNnEF7wjebPO5vbhtAQUwg8hwm43IVuTxar
   yXxrTrbjRcZQg4JCfCexDwSbgZvlbjMTW4NvWNLzci7+oA6R6Yfg51/qQ
   nJosF28Q+Pak40MatuKCchX64NbDhDyQSanoDX53kGPJUZ04tnIpFITLM
   ZBkQLcGzv/dxRI5Tx4ZA0Iwp8MdiGaV8uKUmpnKCWmUgsIlgpvPSPHAku
   A==;
X-CSE-ConnectionGUID: deZjGPAiQHmoBygD8u+XTQ==
X-CSE-MsgGUID: g4RQfjMWQ5G1y+6GHO2CAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="83910356"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="83910356"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 11:25:49 -0700
X-CSE-ConnectionGUID: MvGNGFrZRCmDznG3cSZtZg==
X-CSE-MsgGUID: MJQpYvGNQ326Jv7lWoM4gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="282411987"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by orviesa001.jf.intel.com with ESMTP; 03 Jun 2026 11:25:47 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wUqHg-0000000027p-36e6;
	Wed, 03 Jun 2026 18:25:44 +0000
Date: Wed, 3 Jun 2026 20:25:30 +0200
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH] wifi: cfg80211: enforce HE/EHT cap/oper consistency
Message-ID: <202606032002.XZQOw63p-lkp@intel.com>
References: <20260603091812.101894-2-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603091812.101894-2-johannes@sipsolutions.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37364-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:oe-kbuild-all@lists.linux.dev,m:johannes.berg@intel.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E542B63A929

Hi Johannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v7.1-rc6 next-20260602]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Berg/wifi-cfg80211-enforce-HE-EHT-cap-oper-consistency/20260603-173706
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20260603091812.101894-2-johannes%40sipsolutions.net
patch subject: [PATCH] wifi: cfg80211: enforce HE/EHT cap/oper consistency
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260603/202606032002.XZQOw63p-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260603/202606032002.XZQOw63p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606032002.XZQOw63p-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/wireless/nl80211.c: In function 'nl80211_parse_counter_offsets':
>> net/wireless/nl80211.c:12054:15: error: 'params' undeclared (first use in this function); did you mean 'parameq'?
   12054 |         if (!!params->he_cap != !!params->he_oper)
         |               ^~~~~~
         |               parameq
   net/wireless/nl80211.c:12054:15: note: each undeclared identifier is reported only once for each function it appears in


vim +12054 net/wireless/nl80211.c

 12020	
 12021	static int nl80211_parse_counter_offsets(struct cfg80211_registered_device *rdev,
 12022						 const u8 *data, size_t datalen,
 12023						 int first_count, struct nlattr *attr,
 12024						 const u16 **offsets, unsigned int *n_offsets)
 12025	{
 12026		int i;
 12027	
 12028		*n_offsets = 0;
 12029	
 12030		if (!attr)
 12031			return 0;
 12032	
 12033		if (!nla_len(attr) || (nla_len(attr) % sizeof(u16)))
 12034			return -EINVAL;
 12035	
 12036		*n_offsets = nla_len(attr) / sizeof(u16);
 12037		if (rdev->wiphy.max_num_csa_counters &&
 12038		    (*n_offsets > rdev->wiphy.max_num_csa_counters))
 12039			return -EINVAL;
 12040	
 12041		*offsets = nla_data(attr);
 12042	
 12043		/* sanity checks - counters should fit and be the same */
 12044		for (i = 0; i < *n_offsets; i++) {
 12045			u16 offset = (*offsets)[i];
 12046	
 12047			if (offset >= datalen)
 12048				return -EINVAL;
 12049	
 12050			if (first_count != -1 && data[offset] != first_count)
 12051				return -EINVAL;
 12052		}
 12053	
 12054		if (!!params->he_cap != !!params->he_oper)
 12055			return -EINVAL;
 12056	
 12057		if (!!params->eht_cap != !!params->eht_oper)
 12058			return -EINVAL;
 12059	
 12060		return 0;
 12061	}
 12062	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


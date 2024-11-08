Return-Path: <linux-wireless+bounces-15136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 600469C18D8
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 10:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CFB1F21A9A
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 09:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B841E103B;
	Fri,  8 Nov 2024 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FSifCGmH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527231E0DDC;
	Fri,  8 Nov 2024 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057065; cv=none; b=jZPhR9OvO+ToLLeJtchf0/bWDGCP4Lr+oB3xUG1vSl8WFsvlP2HH9ZPbAdNaeL8Ia4CbFTfCK0KeK+UiQ7ZEBVG8v3MM8r/18T+VzXlxsCneSf8XEPmqEgT4NVT5kLLgqnAmDEt/cLuUhGW7K68rUI/Qu7i7TxP0NB7LkbfOAUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057065; c=relaxed/simple;
	bh=BDOzONkZ2cgnFx3zIeWH6wdDGJPqgkivPauC1vIWhrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bt3OHsUzr5KQMe/UCJEI7ezt5ZH5oihIvPXzGhObWQl6bwPOUYlNk9RuEta+eEvskPP0ay2z9wIx8bR1O+oU+7VsQ6QefTSE28R5CEK1kjFjZiRyhsFrJOv2jN/VGVxId3jQj2VZAxOoMlfWOYHaTmbnjeQOqpVStCB6v3RQLY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FSifCGmH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731057063; x=1762593063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BDOzONkZ2cgnFx3zIeWH6wdDGJPqgkivPauC1vIWhrw=;
  b=FSifCGmHYam4RO1fAcYpXxyVfOzfHbjkjFGIf8Dly8+83Q+xwgd9bo6S
   fJwbLmMawWJN8SmTKfOnYGa0TI/xJFpDBQenw/fZKD8poalXuBwNts230
   IE1ZrALxNPHmz+Xu71fYm6FEfAILHxTJE49pUAhC0swSgu1xEI10bHhLn
   bZGZwAoF0bPzluf8/SPuGu6pRN8RudbyaLacj9V7lpdYAldWIN5kVUal5
   1meOHTI8LLMHwnXVfAirj+HDkhz7vz82tUIaaveeGdrYgx08jgAIATq2b
   SbY1Ae/JCFCM6EmVMvNrcAODDQpLRnA6dWHDhaJJOhRilVgCG3yY3Q9rD
   w==;
X-CSE-ConnectionGUID: mqLuNnxwTo6ayfy2f8QhkQ==
X-CSE-MsgGUID: PdmuqxMGQEamojW94UXxyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="41548438"
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="41548438"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 01:10:59 -0800
X-CSE-ConnectionGUID: 5NUzoZ0uS2ms29zG29vpKA==
X-CSE-MsgGUID: odqMnD4oQCi3mDgiENhthQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85372045"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Nov 2024 01:10:57 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9L14-000rFE-2Q;
	Fri, 08 Nov 2024 09:10:54 +0000
Date: Fri, 8 Nov 2024 17:10:05 +0800
From: kernel test robot <lkp@intel.com>
To: Saru2003 <sarvesh20123@gmail.com>, johannes@sipsolutions.net
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Saru2003 <sarvesh20123@gmail.com>
Subject: Re: [PATCH] Fix: Ensure auth_data and ap_addr are properly set
 before marking STA as authenticated
Message-ID: <202411081625.6Qy8h3Mu-lkp@intel.com>
References: <20241108022828.6571-1-sarvesh20123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108022828.6571-1-sarvesh20123@gmail.com>

Hi Saru2003,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.12-rc6 next-20241107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Saru2003/Fix-Ensure-auth_data-and-ap_addr-are-properly-set-before-marking-STA-as-authenticated/20241108-103338
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20241108022828.6571-1-sarvesh20123%40gmail.com
patch subject: [PATCH] Fix: Ensure auth_data and ap_addr are properly set before marking STA as authenticated
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241108/202411081625.6Qy8h3Mu-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411081625.6Qy8h3Mu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411081625.6Qy8h3Mu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/mac80211/mlme.c: In function 'ieee80211_mark_sta_auth':
>> net/mac80211/mlme.c:4341:34: warning: the comparison will always evaluate as 'true' for the address of 'ap_addr' will never be NULL [-Waddress]
    4341 |         if (!ifmgd->auth_data || !ifmgd->auth_data->ap_addr) {
         |                                  ^
   In file included from net/mac80211/mlme.c:28:
   net/mac80211/ieee80211_i.h:414:12: note: 'ap_addr' declared here
     414 |         u8 ap_addr[ETH_ALEN] __aligned(2);
         |            ^~~~~~~


vim +4341 net/mac80211/mlme.c

  4334	
  4335	static bool ieee80211_mark_sta_auth(struct ieee80211_sub_if_data *sdata)
  4336	{
  4337		struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
  4338		const u8 *ap_addr;
  4339		struct sta_info *sta;
  4340		
> 4341		if (!ifmgd->auth_data || !ifmgd->auth_data->ap_addr) {
  4342			sdata_info(sdata, "auth_data not set or ap_addr missing\n");
  4343			return false;
  4344		}
  4345	
  4346		ap_addr = ifmgd->auth_data->ap_addr;
  4347	
  4348		lockdep_assert_wiphy(sdata->local->hw.wiphy);
  4349	
  4350		sdata_info(sdata, "authenticated\n");
  4351		ifmgd->auth_data->done = true;
  4352		ifmgd->auth_data->timeout = jiffies + IEEE80211_AUTH_WAIT_ASSOC;
  4353		ifmgd->auth_data->timeout_started = true;
  4354		run_again(sdata, ifmgd->auth_data->timeout);
  4355	
  4356		/* move station state to auth */
  4357		sta = sta_info_get(sdata, ap_addr);
  4358		if (!sta) {
  4359		        sdata_info(sdata, "STA %pM not found, skipping authentication mark\n", ap_addr);
  4360			return false;
  4361		}
  4362		if (sta_info_move_state(sta, IEEE80211_STA_AUTH)) {
  4363			sdata_info(sdata, "failed moving %pM to auth\n", ap_addr);
  4364			return false;
  4365		}
  4366	
  4367		return true;
  4368	}
  4369	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


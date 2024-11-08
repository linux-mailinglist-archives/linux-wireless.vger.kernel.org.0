Return-Path: <linux-wireless+bounces-15135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A06A79C18D6
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 10:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41161C23116
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 09:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2091E0DD7;
	Fri,  8 Nov 2024 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UK9qYCqF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9595D1E00AC;
	Fri,  8 Nov 2024 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057063; cv=none; b=ZoIsYgFcdA/HyPMdm7UrdVgCJbfZNSC5PuglMZeJefd9kN9SCUi/tmK0eLkP7odHDkNKia4Y0ZnbU2c9v7f9jlGiAVAyMrShD0mG0lRqOc1+F5qerLNbA29KS32ylBwWs4X6wB608VJNx7P1sqsE9ggjDVn/41PnZIFW1FFkxhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057063; c=relaxed/simple;
	bh=7y7+2Fk1QIr+WK3Rimae+4gKnLT1X/9v8Uy+PYWgLr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biUZ+27v7+kd+JAfQFMGlxd8QqZHvCxqiFdV65i1buFP4eNlS+MC9liUNodc/n00LQbkBk1zQL7x1pkeUdKJwbc73D4ucKXoDYe+Hbw7DePLGCIG21XaEyHbYuq9oAodRodr529uwUF9GP/EpmbJFu8r7Em4pJEaJ9hEHe6PfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UK9qYCqF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731057061; x=1762593061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7y7+2Fk1QIr+WK3Rimae+4gKnLT1X/9v8Uy+PYWgLr8=;
  b=UK9qYCqFTOzNNIlGyXJf4b8NfcCFt5JoleQyhee4vRHV4Nn8j3ASqSmE
   Ek3PE7wPmEUQee4kcbjqBhFp5AibzVX0LJQHPGAjxK1jzjOnWo8Rj5wZm
   VkfHa6T9ZUaNoU5MfiRAfulWPnGh51JmpqFghUzVyOYXXN6mM8JEuuVBs
   bCw5y4SkACU78p2l6ZiKdr0Xw+LS2FXGQ7pSA9/4JmcKEiK6xvVK/MWPl
   eshDFqs7jiVsLBBkS1v2uc7KJDX7PnS/apVa4ZBLVqlxo/5FhJP2vxWVL
   xR8ggzcAQgWU3PPqEyFOoXVlP/gQWERgOvCQ9TZDAK+Ngrkz7kpu/+AHM
   w==;
X-CSE-ConnectionGUID: yDxoNjsRQK2EtN92jtHwfw==
X-CSE-MsgGUID: aI5QNHB1RxCCakStMb6m4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="41548451"
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="41548451"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 01:11:00 -0800
X-CSE-ConnectionGUID: jeHofmArRXenqQOFeDXg/w==
X-CSE-MsgGUID: BXQKvnMKR1KcbmQqyN1xUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85372043"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Nov 2024 01:10:57 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9L14-000rFC-2N;
	Fri, 08 Nov 2024 09:10:54 +0000
Date: Fri, 8 Nov 2024 17:10:05 +0800
From: kernel test robot <lkp@intel.com>
To: Saru2003 <sarvesh20123@gmail.com>, johannes@sipsolutions.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Saru2003 <sarvesh20123@gmail.com>
Subject: Re: [PATCH] Fix: Ensure auth_data and ap_addr are properly set
 before marking STA as authenticated
Message-ID: <202411081640.YeO04UUX-lkp@intel.com>
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241108/202411081640.YeO04UUX-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411081640.YeO04UUX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411081640.YeO04UUX-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/mac80211/mlme.c:16:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> net/mac80211/mlme.c:4341:46: warning: address of array 'ifmgd->auth_data->ap_addr' will always evaluate to 'true' [-Wpointer-bool-conversion]
    4341 |         if (!ifmgd->auth_data || !ifmgd->auth_data->ap_addr) {
         |                                  ~~~~~~~~~~~~~~~~~~~^~~~~~~
   5 warnings generated.


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


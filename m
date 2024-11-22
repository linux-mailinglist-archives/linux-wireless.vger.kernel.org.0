Return-Path: <linux-wireless+bounces-15586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4789D57D0
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 02:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C4F1F23389
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 01:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F98C70808;
	Fri, 22 Nov 2024 01:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOFNs4kx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B267E575
	for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2024 01:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239997; cv=none; b=Y0gT6gdLakigXF1HXctNa4td6tIs1W0gwQBZt9FzwwMkV76Istpwo9rpdp3BRZ2ONVQnB6IjXcaClGQ5DX9otKabTI5HvxoCsaMLzsQi8M53UTGV/cfB8nW1VgxdzdtfGVKe0Yy2G/qQ8oealRwS6iZdLRxAQEUfZYPcbvT5C0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239997; c=relaxed/simple;
	bh=jKQJ+GMAco1FNjD4Ln+cmer6nDAu5V84BITmpzOodZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHbFpEkoR3Fc/cPWaVX4hcRwsFVUlGNvc1ige8i5Z8p9cHXYj5ugMDjf7Ejt0Rgh1ChF92/pi5EuIQrNZ7XSX+ZVJ6Ujo136YO2bwr6pAtt52La3OxJpr2DUxHgvaAXnerqlKuroDnx+gkx/zvm3V8N+sUGqPUTpVkpCHNQqPVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GOFNs4kx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732239995; x=1763775995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jKQJ+GMAco1FNjD4Ln+cmer6nDAu5V84BITmpzOodZ4=;
  b=GOFNs4kx/B4GoduFNga1Q4NNKxyPgiHaw1phsK9zES9L4kX/4yGlCx6U
   wNKdNg6hW6LcW6r/nG5heFGSJW1FAkKT/0IIfHf4ptnKTx3Uy6oXSvzNd
   CwLrGhWrmKd5zXpnMHp/37PUHHEG+bCT5vzUVYim5nbKGtYDcEc0KvXJS
   MBkii56IGgdDIiGYK98RMKgvDXgzCqLl6ezrzmb70I3d2i85sNP46Zq40
   IHASosJuTEcm9PDc9xxclbI2TIKsih0ZWr85PS4W8nMz2vuHMdKiRuC0p
   ERrr+/BR/bPnKW1CVZ67Vp6hUujr+DKA9+nQZL2YhS8rjOpc2FmcsZCNP
   g==;
X-CSE-ConnectionGUID: PO5yh9uHSv+iZUNgxaImqQ==
X-CSE-MsgGUID: av90mpk8R9+cdzABxUrhgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="43447925"
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="43447925"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 17:46:29 -0800
X-CSE-ConnectionGUID: Y5lmLyacTCeqjzLJd3rktQ==
X-CSE-MsgGUID: XNosZlouRuGa8GlJcFh9Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="113716359"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 21 Nov 2024 17:46:26 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEIka-0003Yt-1e;
	Fri, 22 Nov 2024 01:46:24 +0000
Date: Fri, 22 Nov 2024 09:46:05 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH v2 1/2] wifi: cfg80211: define and use wiphy guard
Message-ID: <202411220915.PM4S8Hsp-lkp@intel.com>
References: <20241121232705.df08bb9e8a9e.I610c9b14f36902e75e1d13f0db29f8bef2298804@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121232705.df08bb9e8a9e.I610c9b14f36902e75e1d13f0db29f8bef2298804@changeid>

Hi Johannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20241121]
[also build test ERROR on linus/master]
[cannot apply to wireless/main v6.12 v6.12-rc7 v6.12-rc6 v6.12]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Berg/wifi-mac80211-use-wiphy-guard/20241122-062854
base:   next-20241121
patch link:    https://lore.kernel.org/r/20241121232705.df08bb9e8a9e.I610c9b14f36902e75e1d13f0db29f8bef2298804%40changeid
patch subject: [PATCH v2 1/2] wifi: cfg80211: define and use wiphy guard
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241122/202411220915.PM4S8Hsp-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411220915.PM4S8Hsp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411220915.PM4S8Hsp-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/wireless/core.c:22:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2223:
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
>> net/wireless/core.c:1132:3: error: redefinition of label '__UNIQUE_ID_label1828'
    1132 |                 scoped_guard(wiphy, &rdev->wiphy)
         |                 ^
   include/linux/cleanup.h:339:24: note: expanded from macro 'scoped_guard'
     339 |         __scoped_guard(_name, __UNIQUE_ID(label), args)
         |                               ^
   include/linux/compiler.h:189:29: note: expanded from macro '__UNIQUE_ID'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:117:1: note: expanded from here
     117 | __UNIQUE_ID_label1828
         | ^
   net/wireless/core.c:1132:3: note: previous definition is here
   include/linux/cleanup.h:339:24: note: expanded from macro 'scoped_guard'
     339 |         __scoped_guard(_name, __UNIQUE_ID(label), args)
         |                               ^
   include/linux/compiler.h:189:29: note: expanded from macro '__UNIQUE_ID'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:117:1: note: expanded from here
     117 | __UNIQUE_ID_label1828
         | ^
>> net/wireless/core.c:1132:3: error: cannot jump from this goto statement to its label
    1132 |                 scoped_guard(wiphy, &rdev->wiphy)
         |                 ^
   include/linux/cleanup.h:339:2: note: expanded from macro 'scoped_guard'
     339 |         __scoped_guard(_name, __UNIQUE_ID(label), args)
         |         ^
   include/linux/cleanup.h:332:10: note: expanded from macro '__scoped_guard'
     332 |              ({ goto _label; }))                                        \
         |                 ^
   net/wireless/core.c:1132:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
   include/linux/cleanup.h:339:2: note: expanded from macro 'scoped_guard'
     339 |         __scoped_guard(_name, __UNIQUE_ID(label), args)
         |         ^
   include/linux/cleanup.h:330:20: note: expanded from macro '__scoped_guard'
     330 |         for (CLASS(_name, scope)(args);                                 \
         |                           ^
   net/wireless/core.c:1130:29: note: jump enters a statement expression
    1130 |         wait_event(rdev->dev_wait, ({
         |                                    ^
   4 warnings and 2 errors generated.


vim +/__UNIQUE_ID_label1828 +1132 net/wireless/core.c

  1125	
  1126	void wiphy_unregister(struct wiphy *wiphy)
  1127	{
  1128		struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
  1129	
  1130		wait_event(rdev->dev_wait, ({
  1131			int __count;
> 1132			scoped_guard(wiphy, &rdev->wiphy)
  1133				__count = rdev->opencount;
  1134			__count == 0; }));
  1135	
  1136		if (rdev->wiphy.rfkill)
  1137			rfkill_unregister(rdev->wiphy.rfkill);
  1138	
  1139		rtnl_lock();
  1140		wiphy_lock(&rdev->wiphy);
  1141		nl80211_notify_wiphy(rdev, NL80211_CMD_DEL_WIPHY);
  1142		rdev->wiphy.registered = false;
  1143	
  1144		WARN_ON(!list_empty(&rdev->wiphy.wdev_list));
  1145	
  1146		/*
  1147		 * First remove the hardware from everywhere, this makes
  1148		 * it impossible to find from userspace.
  1149		 */
  1150		debugfs_remove_recursive(rdev->wiphy.debugfsdir);
  1151		list_del_rcu(&rdev->list);
  1152		synchronize_rcu();
  1153	
  1154		/*
  1155		 * If this device got a regulatory hint tell core its
  1156		 * free to listen now to a new shiny device regulatory hint
  1157		 */
  1158		wiphy_regulatory_deregister(wiphy);
  1159	
  1160		cfg80211_rdev_list_generation++;
  1161		device_del(&rdev->wiphy.dev);
  1162	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


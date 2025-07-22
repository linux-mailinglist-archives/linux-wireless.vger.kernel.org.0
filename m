Return-Path: <linux-wireless+bounces-25876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AD9B0E4F8
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 22:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59AD67AF020
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 20:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A79285412;
	Tue, 22 Jul 2025 20:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGK8btBe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE44728540F
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753216122; cv=none; b=pLj78xwPw0WcLTY3xHkSqCXncM7NkCGGttdd04Ha0E/qPQ1Knp9fTMie+bsjotmZSOD7cDcKkUnbbai3nAbTUWrjivZL/4gjcMeHKWk94QPSxbe3Ayhhw9UTV+ncuAd4NfafMUy0PqcRsXRt6qaTW5s+7ufkd7ESueMifu8zQp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753216122; c=relaxed/simple;
	bh=dX3/jgZiJGMG4Si62Mfiujb1q4P6X69vbMXRK7niyn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncG+aUCsLUBQp6Cze7wPpQkpH0+yHW8Wfv7iZ4WhBDu8EGgdgep9JehF4xcdfwf2qR/9tynepbjY026M2qRcMOxQOQvTaFXZ9NBCrZk4aPykeiQPP+fVg7X7OSvrwIQMgUGCKdZV9MAWTKbseDLrK3wxMys11hB08We+qAySOCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGK8btBe; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753216120; x=1784752120;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dX3/jgZiJGMG4Si62Mfiujb1q4P6X69vbMXRK7niyn8=;
  b=KGK8btBeAWnGHRssJ/20uySsiKbbgSXn4VjMSN2qfWCtIMG9leVSNraT
   g5Zf+S2hHiaCuFSl2M/bnP2rA7wnfSyZHFxKfEq2N0B1c0ei8RR3tuZXr
   kJKxraVWjeQjEetDRxwPxX02PA41byUOlBbFR9r51f/JAqGE4Fd88ho8w
   94ZNb/kmPl0wE0BlV42zCQWIGJi6BnJoJxgD8TB553ix/XUnDwv5vAChs
   pPEitvS9ygxVXo4VoIjoMjVLHaRtxDA4yis1NHug/R+CHP82hNA/l2La2
   EQ6G/HbrNVUB7OhNKe1LAAa69yrnHj8XsBWYxO3Or3PqsUCXO9ge3Gvww
   Q==;
X-CSE-ConnectionGUID: mBE/+u+kRuCUnRyU1C3/vw==
X-CSE-MsgGUID: vuI5OiWSTnW6GNeePVwrPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="58098510"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="58098510"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 13:28:40 -0700
X-CSE-ConnectionGUID: 3q3laYnfRLuEv6sDMd6L3g==
X-CSE-MsgGUID: Usjy72LYS4aCIdhhAWrTYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="158999456"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 22 Jul 2025 13:28:37 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueJbH-000Ifv-0A;
	Tue, 22 Jul 2025 20:28:35 +0000
Date: Wed, 23 Jul 2025 04:27:45 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
	Martin Kaistra <martin.kaistra@linutronix.de>
Subject: Re: [PATCH wireless-next] wifi: mac80211: fix WARN_ON for monitor
 mode on some devices
Message-ID: <202507230413.YIpXeSjn-lkp@intel.com>
References: <20250722152517.30340-2-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722152517.30340-2-johannes@sipsolutions.net>

Hi Johannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.16-rc7 next-20250722]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Berg/wifi-mac80211-fix-WARN_ON-for-monitor-mode-on-some-devices/20250722-233552
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20250722152517.30340-2-johannes%40sipsolutions.net
patch subject: [PATCH wireless-next] wifi: mac80211: fix WARN_ON for monitor mode on some devices
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250723/202507230413.YIpXeSjn-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250723/202507230413.YIpXeSjn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507230413.YIpXeSjn-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   net/mac80211/main.c: In function 'ieee80211_link_info_change_notify':
>> net/mac80211/main.c:414:9: warning: enumeration value 'NL80211_IFTYPE_UNSPECIFIED' not handled in switch [-Wswitch]
     414 |         switch (sdata->vif.type)
         |         ^~~~~~
>> net/mac80211/main.c:414:9: warning: enumeration value 'NL80211_IFTYPE_ADHOC' not handled in switch [-Wswitch]
>> net/mac80211/main.c:414:9: warning: enumeration value 'NL80211_IFTYPE_STATION' not handled in switch [-Wswitch]
>> net/mac80211/main.c:414:9: warning: enumeration value 'NL80211_IFTYPE_AP' not handled in switch [-Wswitch]
>> net/mac80211/main.c:414:9: warning: enumeration value 'NL80211_IFTYPE_WDS' not handled in switch [-Wswitch]
>> net/mac80211/main.c:414:9: warning: enumeration value 'NL80211_IFTYPE_MONITOR' not handled in switch [-Wswitch]
>> net/mac80211/main.c:414:9: warning: enumeration value 'NL80211_IFTYPE_MESH_POINT' not handled in switch [-Wswitch]
>> net/mac80211/main.c:414:9: warning: enumeration value 'NL80211_IFTYPE_P2P_CLIENT' not handled in switch [-Wswitch]
>> net/mac80211/main.c:414:9: warning: enumeration value 'NL80211_IFTYPE_P2P_GO' not handled in switch [-Wswitch]
>> net/mac80211/main.c:414:9: warning: enumeration value 'NL80211_IFTYPE_P2P_DEVICE' not handled in switch [-Wswitch]
>> net/mac80211/main.c:414:9: warning: enumeration value 'NL80211_IFTYPE_OCB' not handled in switch [-Wswitch]
>> net/mac80211/main.c:414:9: warning: enumeration value 'NL80211_IFTYPE_NAN' not handled in switch [-Wswitch]
>> net/mac80211/main.c:414:9: warning: enumeration value 'NUM_NL80211_IFTYPES' not handled in switch [-Wswitch]
>> net/mac80211/main.c:414:9: warning: enumeration value 'NL80211_IFTYPE_MAX' not handled in switch [-Wswitch]
>> net/mac80211/main.c:417:9: error: case label not within a switch statement
     417 |         case NL80211_IFTYPE_MONITOR:
         |         ^~~~
>> net/mac80211/main.c:420:17: error: break statement not within loop or switch
     420 |                 break;
         |                 ^~~~~
>> net/mac80211/main.c:421:9: error: 'default' label not within a switch statement
     421 |         default:
         |         ^~~~~~~
   net/mac80211/main.c:422:17: error: break statement not within loop or switch
     422 |                 break;
         |                 ^~~~~
   net/mac80211/main.c: At top level:
>> net/mac80211/main.c:425:9: error: expected identifier or '(' before 'if'
     425 |         if (!check_sdata_in_driver(sdata))
         |         ^~
   In file included from net/mac80211/main.c:30:
>> net/mac80211/driver-ops.h:22:2: error: expected identifier or '(' before ')' token
      22 | })
         |  ^
   net/mac80211/main.c:425:14: note: in expansion of macro 'check_sdata_in_driver'
     425 |         if (!check_sdata_in_driver(sdata))
         |              ^~~~~~~~~~~~~~~~~~~~~
>> net/mac80211/main.c:428:49: error: expected ')' before '->' token
     428 |         drv_link_info_changed(local, sdata, link->conf, link->link_id, changed);
         |                                                 ^~
         |                                                 )
   net/mac80211/main.c:429:1: error: expected identifier or '(' before '}' token
     429 | }
         | ^


vim +417 net/mac80211/main.c

   402	
   403	void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
   404					       struct ieee80211_link_data *link,
   405					       u64 changed)
   406	{
   407		struct ieee80211_local *local = sdata->local;
   408	
   409		WARN_ON_ONCE(changed & BSS_CHANGED_VIF_CFG_FLAGS);
   410	
   411		if (!changed)
   412			return;
   413	
 > 414		switch (sdata->vif.type)
   415		case NL80211_IFTYPE_AP_VLAN:
   416			return;
 > 417		case NL80211_IFTYPE_MONITOR:
   418			if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
   419				return;
 > 420			break;
 > 421		default:
   422			break;
   423		}
   424	
 > 425		if (!check_sdata_in_driver(sdata))
   426			return;
   427	
 > 428		drv_link_info_changed(local, sdata, link->conf, link->link_id, changed);
 > 429	}
   430	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


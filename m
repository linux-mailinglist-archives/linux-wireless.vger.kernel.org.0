Return-Path: <linux-wireless+bounces-19071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAA1A38928
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 17:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF631691F6
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 16:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D7521D59D;
	Mon, 17 Feb 2025 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gC5iJJdd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1951531DC
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809862; cv=none; b=i5sqIm2H84B70XRUEARxqJzYKGw0LsukajeXWAFi1Rr3OZK5xDAW9S009DQVKLSwFm5UPzgWK50rp2b/GF/v6+F/jQnzXTvlb9o04Ry0RPyZ6pH0RY1Z/g+yoBMMg0utpGnrwEF/Pygnlu3YyS4NK0adwrtCixYXYT5FBWWQS8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809862; c=relaxed/simple;
	bh=DlHyTM2wIfgM/OxQ/A9ZgPiaeOgS3PnW8/ppZcTRwck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kV85pxf69laQr6+xAK+GSwieYLZ65E+Gu46CN+NpswLUfFWu0iIepIX0jF6OxR77bTEWUSvvXkWiv9MbsVCM+RqlNb8hyOVFQFGxYqQCCGz7vJZAEDvMND8FhMT0fK1NkUZU+yxkzdykNsCwkzYlGPjLkYAbDCbs8gHmqiFalxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gC5iJJdd; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739809861; x=1771345861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DlHyTM2wIfgM/OxQ/A9ZgPiaeOgS3PnW8/ppZcTRwck=;
  b=gC5iJJddymUlW+GAr5SmTbv3Cu5HCh10B4T802ju04Hs1UvFRVc+p5Mf
   S/VwemctuZcc9ge9lh7jn45Yyz2jvjb4UbvrSpU3zve+sOeuN80eqplg9
   h2L2EdVxvqXtYZ3InktZugLtajFkQMPwxVVZvhRoDCcw/CW6aITZmTbXw
   +ENGFeOQSEasynbEz9O6nw7XTEAp2y5CjOgTKqWtHzMOeqSboKTmn8LaN
   zVLZ4TfhhYBezNhScTavORcdZ7NmejHJYt1DMksxkuqVpngWU7HneXWHk
   mCHNlYB+2eM3W8zFv3SdMB4wucMvmvJuQQxlphHpJsy8xgs6vDaxwMxi6
   A==;
X-CSE-ConnectionGUID: Bb9ySeL3ToK8EWiCDXINAw==
X-CSE-MsgGUID: 6+uJYDXAT2WIosrlM3VWrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51477957"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="51477957"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 08:31:00 -0800
X-CSE-ConnectionGUID: rngo6N8WRYCMLSHIHbRZOg==
X-CSE-MsgGUID: bwDG5knoTmCGB3aUPKOjJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118789814"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 17 Feb 2025 08:30:58 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tk41I-001DLP-0e;
	Mon, 17 Feb 2025 16:30:56 +0000
Date: Tue, 18 Feb 2025 00:30:00 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Wetzel <Alexander@wetzel-home.de>,
	linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <alexander@wetzel-home.de>
Subject: Re: [PATCH v2 08/10] wifi: mac80211: Simplify AMPDU handling
Message-ID: <202502180007.MFwMk2L7-lkp@intel.com>
References: <20250217081721.45110-9-Alexander@wetzel-home.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217081721.45110-9-Alexander@wetzel-home.de>

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main ath/ath-next linus/master v6.14-rc3 next-20250217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Wetzel/wifi-mac80211-move-rate-control-setup/20250217-162046
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20250217081721.45110-9-Alexander%40wetzel-home.de
patch subject: [PATCH v2 08/10] wifi: mac80211: Simplify AMPDU handling
config: i386-buildonly-randconfig-004-20250217 (https://download.01.org/0day-ci/archive/20250218/202502180007.MFwMk2L7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250218/202502180007.MFwMk2L7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502180007.MFwMk2L7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/mac80211/tx.c: In function 'ieee80211_tx_prepare':
>> net/mac80211/tx.c:1140:14: warning: variable 'aggr_check' set but not used [-Wunused-but-set-variable]
    1140 |         bool aggr_check = false;
         |              ^~~~~~~~~~
--
   net/mac80211/rx.c: In function 'ieee80211_rx_mesh_fast_forward':
>> net/mac80211/rx.c:2778:30: warning: variable 'tid_tx' set but not used [-Wunused-but-set-variable]
    2778 |         struct tid_ampdu_tx *tid_tx;
         |                              ^~~~~~


vim +/aggr_check +1140 net/mac80211/tx.c

1a7915501ca94a Felix Fietkau    2021-06-29  1126  
58d4185e36913d Johannes Berg    2007-09-26  1127  /*
58d4185e36913d Johannes Berg    2007-09-26  1128   * initialises @tx
7c10770f995820 Johannes Berg    2015-03-20  1129   * pass %NULL for the station if unknown, a valid pointer if known
7c10770f995820 Johannes Berg    2015-03-20  1130   * or an ERR_PTR() if the station is known not to exist
58d4185e36913d Johannes Berg    2007-09-26  1131   */
9ae54c8463691b Johannes Berg    2008-01-31  1132  static ieee80211_tx_result
3b8d81e020f77c Johannes Berg    2009-06-17  1133  ieee80211_tx_prepare(struct ieee80211_sub_if_data *sdata,
3b8d81e020f77c Johannes Berg    2009-06-17  1134  		     struct ieee80211_tx_data *tx,
7c10770f995820 Johannes Berg    2015-03-20  1135  		     struct sta_info *sta, struct sk_buff *skb)
e2ebc74d7e3d71 Johannes Berg    2007-07-27  1136  {
3b8d81e020f77c Johannes Berg    2009-06-17  1137  	struct ieee80211_local *local = sdata->local;
58d4185e36913d Johannes Berg    2007-09-26  1138  	struct ieee80211_hdr *hdr;
e039fa4a4195ac Johannes Berg    2008-05-15  1139  	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
1a7915501ca94a Felix Fietkau    2021-06-29 @1140  	bool aggr_check = false;
e2ebc74d7e3d71 Johannes Berg    2007-07-27  1141  
e2ebc74d7e3d71 Johannes Berg    2007-07-27  1142  	memset(tx, 0, sizeof(*tx));
e2ebc74d7e3d71 Johannes Berg    2007-07-27  1143  	tx->skb = skb;
e2ebc74d7e3d71 Johannes Berg    2007-07-27  1144  	tx->local = local;
3b8d81e020f77c Johannes Berg    2009-06-17  1145  	tx->sdata = sdata;
252b86c43225d0 Johannes Berg    2011-11-16  1146  	__skb_queue_head_init(&tx->skbs);
e2ebc74d7e3d71 Johannes Berg    2007-07-27  1147  
cd8ffc800ce18e Johannes Berg    2009-03-23  1148  	/*
cd8ffc800ce18e Johannes Berg    2009-03-23  1149  	 * If this flag is set to true anywhere, and we get here,
cd8ffc800ce18e Johannes Berg    2009-03-23  1150  	 * we are doing the needed processing, so remove the flag
cd8ffc800ce18e Johannes Berg    2009-03-23  1151  	 * now.
cd8ffc800ce18e Johannes Berg    2009-03-23  1152  	 */
cc20ff2c6b5d3e Felix Fietkau    2020-09-08  1153  	info->control.flags &= ~IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
cd8ffc800ce18e Johannes Berg    2009-03-23  1154  
58d4185e36913d Johannes Berg    2007-09-26  1155  	hdr = (struct ieee80211_hdr *) skb->data;
58d4185e36913d Johannes Berg    2007-09-26  1156  
7c10770f995820 Johannes Berg    2015-03-20  1157  	if (likely(sta)) {
7c10770f995820 Johannes Berg    2015-03-20  1158  		if (!IS_ERR(sta))
7c10770f995820 Johannes Berg    2015-03-20  1159  			tx->sta = sta;
7c10770f995820 Johannes Berg    2015-03-20  1160  	} else {
3f0e0b220f8007 Felix Fietkau    2010-01-08  1161  		if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
f14543ee4d0681 Felix Fietkau    2009-11-10  1162  			tx->sta = rcu_dereference(sdata->u.vlan.sta);
7c10770f995820 Johannes Berg    2015-03-20  1163  			if (!tx->sta && sdata->wdev.use_4addr)
3f0e0b220f8007 Felix Fietkau    2010-01-08  1164  				return TX_DROP;
10cb8e617560fc Markus Theil     2021-02-06  1165  		} else if (tx->sdata->control_port_protocol == tx->skb->protocol) {
b4d57adb727ec7 Felix Fietkau    2010-01-31  1166  			tx->sta = sta_info_get_bss(sdata, hdr->addr1);
3f0e0b220f8007 Felix Fietkau    2010-01-08  1167  		}
1a7915501ca94a Felix Fietkau    2021-06-29  1168  		if (!tx->sta && !is_multicast_ether_addr(hdr->addr1)) {
abe60632f311d5 Johannes Berg    2009-11-25  1169  			tx->sta = sta_info_get(sdata, hdr->addr1);
1a7915501ca94a Felix Fietkau    2021-06-29  1170  			aggr_check = true;
1a7915501ca94a Felix Fietkau    2021-06-29  1171  		}
7c10770f995820 Johannes Berg    2015-03-20  1172  	}
58d4185e36913d Johannes Berg    2007-09-26  1173  
badffb725c86cc Jiri Slaby       2007-08-28  1174  	if (is_multicast_ether_addr(hdr->addr1)) {
5cf121c3cdb955 Johannes Berg    2008-02-25  1175  		tx->flags &= ~IEEE80211_TX_UNICAST;
e039fa4a4195ac Johannes Berg    2008-05-15  1176  		info->flags |= IEEE80211_TX_CTL_NO_ACK;
6fd67e937ece53 Simon Wunderlich 2011-11-18  1177  	} else
5cf121c3cdb955 Johannes Berg    2008-02-25  1178  		tx->flags |= IEEE80211_TX_UNICAST;
58d4185e36913d Johannes Berg    2007-09-26  1179  
a26eb27ab43014 Johannes Berg    2011-10-07  1180  	if (!(info->flags & IEEE80211_TX_CTL_DONTFRAG)) {
a26eb27ab43014 Johannes Berg    2011-10-07  1181  		if (!(tx->flags & IEEE80211_TX_UNICAST) ||
a26eb27ab43014 Johannes Berg    2011-10-07  1182  		    skb->len + FCS_LEN <= local->hw.wiphy->frag_threshold ||
a26eb27ab43014 Johannes Berg    2011-10-07  1183  		    info->flags & IEEE80211_TX_CTL_AMPDU)
a26eb27ab43014 Johannes Berg    2011-10-07  1184  			info->flags |= IEEE80211_TX_CTL_DONTFRAG;
58d4185e36913d Johannes Berg    2007-09-26  1185  	}
58d4185e36913d Johannes Berg    2007-09-26  1186  
e2ebc74d7e3d71 Johannes Berg    2007-07-27  1187  	if (!tx->sta)
e039fa4a4195ac Johannes Berg    2008-05-15  1188  		info->flags |= IEEE80211_TX_CTL_CLEAR_PS_FILT;
f7418bc10d8402 Felix Fietkau    2015-09-24  1189  	else if (test_and_clear_sta_flag(tx->sta, WLAN_STA_CLEAR_PS_FILT)) {
e039fa4a4195ac Johannes Berg    2008-05-15  1190  		info->flags |= IEEE80211_TX_CTL_CLEAR_PS_FILT;
f7418bc10d8402 Felix Fietkau    2015-09-24  1191  		ieee80211_check_fast_xmit(tx->sta);
f7418bc10d8402 Felix Fietkau    2015-09-24  1192  	}
58d4185e36913d Johannes Berg    2007-09-26  1193  
e039fa4a4195ac Johannes Berg    2008-05-15  1194  	info->flags |= IEEE80211_TX_CTL_FIRST_FRAGMENT;
e2ebc74d7e3d71 Johannes Berg    2007-07-27  1195  
9ae54c8463691b Johannes Berg    2008-01-31  1196  	return TX_CONTINUE;
e2ebc74d7e3d71 Johannes Berg    2007-07-27  1197  }
e2ebc74d7e3d71 Johannes Berg    2007-07-27  1198  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


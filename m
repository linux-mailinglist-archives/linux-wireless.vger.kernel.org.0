Return-Path: <linux-wireless+bounces-23468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B65AC6830
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 13:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A006A7ABF58
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 11:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081A227A139;
	Wed, 28 May 2025 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KVSF8Ill"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB7B1F0E34;
	Wed, 28 May 2025 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748430774; cv=none; b=AZE0ZO9CavfpQ2XCd6g+OBraakr+6VoHs/N1xjH9U1UQ24dln7nSgaPjCIIyzLwMXaqo/yWk3TKoTy22ZCv8+rJW4Tvx0UrDZ5TtJ/tVnIcjgeGiJ0t1ZGC5loHRk34gnDKLv/cGS4YHecLEZQIFXxhgPuKyRn18npSa1+7o0sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748430774; c=relaxed/simple;
	bh=c6XCpPi3M9BjDPmcDyl0ht/M9nZpoLiGCe0c8n7fGEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRzK2HxH42TgI/ypi3ud7YuZev2E4CRvNyBttTno6NlBUzH5Qadrx1+phcQs+0TYg4pNjaGWQ3A3mdR85VEqPc4Ac+/uHXQsNU7d6GBJfKrrX5y1ZNKv4UeoVwwxtKe05hbEOGcg7zjmF07O1K+G/hCeDPNCtfEJaoOdEFfK6eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KVSF8Ill; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748430773; x=1779966773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c6XCpPi3M9BjDPmcDyl0ht/M9nZpoLiGCe0c8n7fGEs=;
  b=KVSF8IlljaT1L1pTAyK8oDSSPU/zWyB1XtSaxNQH54O6ik/Y+FuWfxPp
   KuOl23uOTm/cR35WHNIGMKoq2QF8GH8okHSZTCFtvvIh7wTTAWLYbZ0nd
   eT8VE/9ieYHHhTYj6SD1G/Qoo5hsAoy0G0wTwyeOHbBkvOHuS6SQ545xI
   T7uOJUi7J1Iq1EcOo+gxD97XWZtdUjY5i5rKLvZdGarGwRTvINw5TpThB
   IkT/NAqKB7ziKOSKlVzs6lIKlW3hrJOj343vaH2DJIWP3SZxhW5uP7BWp
   FTL+ZmE2wKD254/utJH6KwnSomm6j4kMz3U85FZAxjC+j4qRjV6DLWn8F
   g==;
X-CSE-ConnectionGUID: BEXSK10GRSemXHzPW8qjHw==
X-CSE-MsgGUID: fQkDMC8ZTbSHFY8g3KMadA==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="67865579"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="67865579"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 04:12:52 -0700
X-CSE-ConnectionGUID: Z5GF7ThkQ/2fRNHoz4p8Bw==
X-CSE-MsgGUID: TctObnezS36UB8YJTadhng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="147966943"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 28 May 2025 04:12:50 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKEiF-000VbA-11;
	Wed, 28 May 2025 11:12:47 +0000
Date: Wed, 28 May 2025 19:12:41 +0800
From: kernel test robot <lkp@intel.com>
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-next] wifi: mac80211: consider links for
 validating SCAN_FLAG_AP in scan request during MLO
Message-ID: <202505281853.CBjCB3yV-lkp@intel.com>
References: <20250528-fix_scan_ap_flag_requirement_during_mlo-v1-1-35ac0e3a2f7b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528-fix_scan_ap_flag_requirement_during_mlo-v1-1-35ac0e3a2f7b@oss.qualcomm.com>

Hi Aditya,

kernel test robot noticed the following build errors:

[auto build test ERROR on ea15e046263b19e91ffd827645ae5dfa44ebd044]

url:    https://github.com/intel-lab-lkp/linux/commits/Aditya-Kumar-Singh/wifi-mac80211-consider-links-for-validating-SCAN_FLAG_AP-in-scan-request-during-MLO/20250528-113350
base:   ea15e046263b19e91ffd827645ae5dfa44ebd044
patch link:    https://lore.kernel.org/r/20250528-fix_scan_ap_flag_requirement_during_mlo-v1-1-35ac0e3a2f7b%40oss.qualcomm.com
patch subject: [PATCH wireless-next] wifi: mac80211: consider links for validating SCAN_FLAG_AP in scan request during MLO
config: arm-randconfig-003-20250528 (https://download.01.org/0day-ci/archive/20250528/202505281853.CBjCB3yV-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250528/202505281853.CBjCB3yV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505281853.CBjCB3yV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/mac80211/cfg.c:2953:16: error: call to undeclared function 'cfg80211_get_radio_idx_by_chan'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2953 |                         radio_idx = cfg80211_get_radio_idx_by_chan(wiphy, chan);
         |                                     ^
>> net/mac80211/cfg.c:2955:8: error: call to undeclared function 'ieee80211_is_radio_idx_in_scan_req'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2955 |                         if (ieee80211_is_radio_idx_in_scan_req(wiphy, req,
         |                             ^
   2 errors generated.


vim +/cfg80211_get_radio_idx_by_chan +2953 net/mac80211/cfg.c

  2895	
  2896	static int ieee80211_scan(struct wiphy *wiphy,
  2897				  struct cfg80211_scan_request *req)
  2898	{
  2899		struct ieee80211_sub_if_data *sdata;
  2900		struct ieee80211_link_data *link;
  2901		struct ieee80211_channel *chan;
  2902		int radio_idx;
  2903		u8 link_id;
  2904	
  2905		sdata = IEEE80211_WDEV_TO_SUB_IF(req->wdev);
  2906	
  2907		switch (ieee80211_vif_type_p2p(&sdata->vif)) {
  2908		case NL80211_IFTYPE_STATION:
  2909		case NL80211_IFTYPE_ADHOC:
  2910		case NL80211_IFTYPE_MESH_POINT:
  2911		case NL80211_IFTYPE_P2P_CLIENT:
  2912		case NL80211_IFTYPE_P2P_DEVICE:
  2913			break;
  2914		case NL80211_IFTYPE_P2P_GO:
  2915			if (sdata->local->ops->hw_scan)
  2916				break;
  2917			/*
  2918			 * FIXME: implement NoA while scanning in software,
  2919			 * for now fall through to allow scanning only when
  2920			 * beaconing hasn't been configured yet
  2921			 */
  2922			fallthrough;
  2923		case NL80211_IFTYPE_AP:
  2924			/*
  2925			 * If the scan has been forced (and the driver supports
  2926			 * forcing), don't care about being beaconing already.
  2927			 * This will create problems to the attached stations (e.g. all
  2928			 * the frames sent while scanning on other channel will be
  2929			 * lost)
  2930			 */
  2931			for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
  2932			     link_id++) {
  2933				link = sdata_dereference(sdata->link[link_id], sdata);
  2934				if (!link)
  2935					continue;
  2936	
  2937				/* if the link is not beaconing, ignore it */
  2938				if (!sdata_dereference(link->u.ap.beacon, sdata))
  2939					continue;
  2940	
  2941				/* If we are here then at least one of the link is
  2942				 * beaconing and since radio level information is
  2943				 * not present or single underlying radio is present,
  2944				 * no point in checking further and hence return if
  2945				 * flag requirements are not met.
  2946				 */
  2947				if (wiphy->n_radio < 2 &&
  2948				    (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
  2949				     !(req->flags & NL80211_SCAN_FLAG_AP)))
  2950					return -EOPNOTSUPP;
  2951	
  2952				chan = link->conf->chanreq.oper.chan;
> 2953				radio_idx = cfg80211_get_radio_idx_by_chan(wiphy, chan);
  2954	
> 2955				if (ieee80211_is_radio_idx_in_scan_req(wiphy, req,
  2956								       radio_idx) &&
  2957				    (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
  2958				     !(req->flags & NL80211_SCAN_FLAG_AP)))
  2959					return -EOPNOTSUPP;
  2960			}
  2961			break;
  2962		case NL80211_IFTYPE_NAN:
  2963		default:
  2964			return -EOPNOTSUPP;
  2965		}
  2966	
  2967		return ieee80211_request_scan(sdata, req);
  2968	}
  2969	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


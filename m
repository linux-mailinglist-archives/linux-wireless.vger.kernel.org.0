Return-Path: <linux-wireless+bounces-11324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9FC94F804
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 22:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928AE1F21502
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 20:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7266619307E;
	Mon, 12 Aug 2024 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2gBumqn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4838E191F80
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493710; cv=none; b=NRM17Vem8Tc2EnALLX21x3dqeR8ypfovRGxNhVUlIl8fVkzpj81hxC3TT6xRK+I4OQgJPAJ3grSC+doTkQxwCJwEbaQoGYN/Sdi4IrBSTdoMLQiFRYuYuslLrcQhCVbGgxd9h19kszliHA1wQiXH190ENnodhMsUppfUglweQco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493710; c=relaxed/simple;
	bh=Mp+2hS7vhM0qysPbjMn18bMX3IzD0xhYa58wgS6KvzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5LCdSkirJo2Bwprk8QJr1eWbP/y/rCxPMbU7qkXyaQtYoL8ex/0OPovbREsnpjlWqWGau1ePiOsXpc9ieDWwCTJ6A23DqqeVBTDKeyLjQDJcO0O/viDo1yX/0rkVhO8AHEjWO84hI/YtnfSKsZFEBzEcHa/Ikk9tAYwQrG92dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2gBumqn; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723493709; x=1755029709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mp+2hS7vhM0qysPbjMn18bMX3IzD0xhYa58wgS6KvzE=;
  b=j2gBumqnqcduQVEl/snLo3Ajb0xdc+309JRz0YR3sMvfBvAhQkutrb3X
   cYvr2MNKLLnQRG94AAQEUg3p8N3RisrIzOeYe+R4kjKpF+j+lvLvrEYe7
   QFYW5ScP/btNI/MZmNHzHv5HKe8DavRDJdnfBg9jaYXHV4kFG0Ez9kvj/
   2cjVMxBXqhCiRmd7a5IL2A7txbJ56fp1flzJCadcWgMH7uHdcz5R4hejk
   hwWFifOrhYSdXqOLTilV6rz9RWrx+2QdyMK9DFUWzgGhM6Wuipculs4uK
   AVApk2pfN2WsVY6qU+bgM6GZzHpEyrp3cGIVnJV+XIjT/gJt6gLKIjuuK
   w==;
X-CSE-ConnectionGUID: j/wCLnyFRB+2Sw0ARRTiMA==
X-CSE-MsgGUID: AjlP19r5Say4ZLZ+tyd36g==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21483796"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="21483796"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 13:15:08 -0700
X-CSE-ConnectionGUID: t5FwYez/Smu9qKxMfNY+jQ==
X-CSE-MsgGUID: TkjqrdVoRs2Z8BO15bWsqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="62781080"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 12 Aug 2024 13:15:06 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdbRX-000C8p-2w;
	Mon, 12 Aug 2024 20:15:03 +0000
Date: Tue, 13 Aug 2024 04:14:05 +0800
From: kernel test robot <lkp@intel.com>
To: johannes@sipsolutions.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org, Issam Hamdi <ih@simonwunderlich.de>,
	Kretschmer Mathias <mathias.kretschmer@fit.fraunhofer.de>
Subject: Re: [PATCH] cfg80211: Set the channel definition for the different
 Wi-Fi modes when starting CAC
Message-ID: <202408130337.tnSP4Qys-lkp@intel.com>
References: <20240812120909.2721400-1-root@hissam.office.simonwunderlich.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812120909.2721400-1-root@hissam.office.simonwunderlich.net>

Hi root,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.11-rc3 next-20240812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/root/cfg80211-Set-the-channel-definition-for-the-different-Wi-Fi-modes-when-starting-CAC/20240812-202257
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240812120909.2721400-1-root%40hissam.office.simonwunderlich.net
patch subject: [PATCH] cfg80211: Set the channel definition for the different Wi-Fi modes when starting CAC
config: i386-buildonly-randconfig-005-20240813 (https://download.01.org/0day-ci/archive/20240813/202408130337.tnSP4Qys-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240813/202408130337.tnSP4Qys-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408130337.tnSP4Qys-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/wireless/nl80211.c:10146:11: warning: 9 enumeration values not handled in switch: 'NL80211_IFTYPE_UNSPECIFIED', 'NL80211_IFTYPE_STATION', 'NL80211_IFTYPE_AP_VLAN'... [-Wswitch]
    10146 |                 switch (wdev->iftype) {
          |                         ^~~~~~~~~~~~
   1 warning generated.


vim +10146 net/wireless/nl80211.c

 10068	
 10069	static int nl80211_start_radar_detection(struct sk_buff *skb,
 10070						 struct genl_info *info)
 10071	{
 10072		struct cfg80211_registered_device *rdev = info->user_ptr[0];
 10073		struct net_device *dev = info->user_ptr[1];
 10074		struct wireless_dev *wdev = dev->ieee80211_ptr;
 10075		struct wiphy *wiphy = wdev->wiphy;
 10076		struct cfg80211_chan_def chandef;
 10077		enum nl80211_dfs_regions dfs_region;
 10078		unsigned int cac_time_ms;
 10079		int err = -EINVAL;
 10080	
 10081		flush_delayed_work(&rdev->dfs_update_channels_wk);
 10082	
 10083		switch (wdev->iftype) {
 10084		case NL80211_IFTYPE_AP:
 10085		case NL80211_IFTYPE_P2P_GO:
 10086		case NL80211_IFTYPE_MESH_POINT:
 10087		case NL80211_IFTYPE_ADHOC:
 10088			break;
 10089		default:
 10090			/* caution - see cfg80211_beaconing_iface_active() below */
 10091			return -EINVAL;
 10092		}
 10093	
 10094		wiphy_lock(wiphy);
 10095	
 10096		dfs_region = reg_get_dfs_region(wiphy);
 10097		if (dfs_region == NL80211_DFS_UNSET)
 10098			goto unlock;
 10099	
 10100		err = nl80211_parse_chandef(rdev, info, &chandef);
 10101		if (err)
 10102			goto unlock;
 10103	
 10104		err = cfg80211_chandef_dfs_required(wiphy, &chandef, wdev->iftype);
 10105		if (err < 0)
 10106			goto unlock;
 10107	
 10108		if (err == 0) {
 10109			err = -EINVAL;
 10110			goto unlock;
 10111		}
 10112	
 10113		if (!cfg80211_chandef_dfs_usable(wiphy, &chandef)) {
 10114			err = -EINVAL;
 10115			goto unlock;
 10116		}
 10117	
 10118		if (nla_get_flag(info->attrs[NL80211_ATTR_RADAR_BACKGROUND])) {
 10119			err = cfg80211_start_background_radar_detection(rdev, wdev,
 10120									&chandef);
 10121			goto unlock;
 10122		}
 10123	
 10124		if (cfg80211_beaconing_iface_active(wdev) || wdev->cac_started) {
 10125			err = -EBUSY;
 10126			goto unlock;
 10127		}
 10128	
 10129		/* CAC start is offloaded to HW and can't be started manually */
 10130		if (wiphy_ext_feature_isset(wiphy, NL80211_EXT_FEATURE_DFS_OFFLOAD)) {
 10131			err = -EOPNOTSUPP;
 10132			goto unlock;
 10133		}
 10134	
 10135		if (!rdev->ops->start_radar_detection) {
 10136			err = -EOPNOTSUPP;
 10137			goto unlock;
 10138		}
 10139	
 10140		cac_time_ms = cfg80211_chandef_dfs_cac_time(&rdev->wiphy, &chandef);
 10141		if (WARN_ON(!cac_time_ms))
 10142			cac_time_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
 10143	
 10144		err = rdev_start_radar_detection(rdev, dev, &chandef, cac_time_ms);
 10145		if (!err) {
 10146			switch (wdev->iftype) {
 10147			case NL80211_IFTYPE_MESH_POINT:
 10148				wdev->u.mesh.chandef = chandef;
 10149				break;
 10150			case NL80211_IFTYPE_ADHOC:
 10151				wdev->u.ibss.chandef = chandef;
 10152				break;
 10153			case NL80211_IFTYPE_OCB:
 10154				wdev->u.ocb.chandef = chandef;
 10155				break;
 10156			case NL80211_IFTYPE_AP:
 10157			case NL80211_IFTYPE_P2P_GO:
 10158				wdev->links[0].ap.chandef = chandef;
 10159				break;
 10160			}
 10161			wdev->cac_started = true;
 10162			wdev->cac_start_time = jiffies;
 10163			wdev->cac_time_ms = cac_time_ms;
 10164		}
 10165	unlock:
 10166		wiphy_unlock(wiphy);
 10167	
 10168		return err;
 10169	}
 10170	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


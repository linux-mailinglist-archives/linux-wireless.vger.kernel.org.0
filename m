Return-Path: <linux-wireless+bounces-17928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B94A1C411
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 16:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D623B161E68
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 15:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A969835973;
	Sat, 25 Jan 2025 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="duNbV1/f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDD4282F0
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737819680; cv=none; b=UlnUiWGk3Q8EozAskY2qJio8v8TGTcPts5w0NSk4rulQ18xeDDjN0e7hfG0OCQ9YPYzkGXwKmK8Ask343q81z1rk4WgWp9kQWVe2VFdO5avxj+RsZOxiJYdA0VssZk7DKTXZXETDnextu/7d1O2TOShUNOdjk5JYKGOEaiQI4+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737819680; c=relaxed/simple;
	bh=9PGUnIpityFd8iv4sDmNS6FOsJFZNCszTXx0cqDkvb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyBqM4Tk7Y3lC3ytMAPbfs1ftKNBA+Wdr9eSFWp4wjyahsp2oapRxhzs0XxzrIkw8/8LRkeSKuQJSNSDL2shCSTs4K5YuE/Dkt8aIvFD4SsAMSY9iEZ8Z5yIBrrW144ZFrZzCMxes7rgdPAF22VjNwUloyhWx9/hcUFMsS9s3hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=duNbV1/f; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737819678; x=1769355678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9PGUnIpityFd8iv4sDmNS6FOsJFZNCszTXx0cqDkvb4=;
  b=duNbV1/f7hy3oElgYqnvm9jb4jK7lLmmCdRUxW85qVkJCXFwdilMZM5i
   QDGyRp5zHfQN0lCosS2MSEyzn7PDALLtWkG5rb27Ql2SE6SlSWMYV3RDG
   Vb+SRGUKLNC/Frvc8XxmjjzDG0ulq3NV0g/GtoqFgNa70Nh11u3Dn1FdC
   yoiaqH2uXigqrQ4ZUhOmCKxrYmCPzx6ho9Cn0+7MyE3UxkQKOxb7Qvq06
   ALFGngzeLjYyLRQvqhElsXKGx7llokLu5k160mNoMmepX0T4Pv1m4JAB+
   IUiiIU1Gxnp3yj3j26jddfEnQhMjdS4DclGa/Lc7OC5ngHzBoehP2sIU8
   g==;
X-CSE-ConnectionGUID: AOMS2z5xSC25vD4YmMn45Q==
X-CSE-MsgGUID: zPg+lmbWTbOKVkVn+/qNjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11326"; a="48927676"
X-IronPort-AV: E=Sophos;i="6.13,234,1732608000"; 
   d="scan'208";a="48927676"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2025 07:41:17 -0800
X-CSE-ConnectionGUID: TOxT7N/XSmacA/eUsG59kQ==
X-CSE-MsgGUID: B0Y0BSVPQSimZpQZDPgMOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,234,1732608000"; 
   d="scan'208";a="107824959"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 25 Jan 2025 07:41:16 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tbiHZ-000dxt-0W;
	Sat, 25 Jan 2025 15:41:13 +0000
Date: Sat, 25 Jan 2025 23:40:25 +0800
From: kernel test robot <lkp@intel.com>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
	ath12k@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: Re: [PATCH v2 1/5] wifi: cfg80211: Add Support to Set RTS Threshold
 for each Radio
Message-ID: <202501252150.mBnKxse3-lkp@intel.com>
References: <20250124171756.3418663-2-quic_rdevanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250124171756.3418663-2-quic_rdevanat@quicinc.com>

Hi Roopni,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e7ef944b3e2c31b608800925e784f67596375770]

url:    https://github.com/intel-lab-lkp/linux/commits/Roopni-Devanathan/wifi-cfg80211-Add-Support-to-Set-RTS-Threshold-for-each-Radio/20250125-012016
base:   e7ef944b3e2c31b608800925e784f67596375770
patch link:    https://lore.kernel.org/r/20250124171756.3418663-2-quic_rdevanat%40quicinc.com
patch subject: [PATCH v2 1/5] wifi: cfg80211: Add Support to Set RTS Threshold for each Radio
config: arm-imx_v6_v7_defconfig (https://download.01.org/0day-ci/archive/20250125/202501252150.mBnKxse3-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 19306351a2c45e266fa11b41eb1362b20b6ca56d)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250125/202501252150.mBnKxse3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501252150.mBnKxse3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/wireless/nl80211.c:3603:12: warning: stack frame size (1128) exceeds limit (1024) in 'nl80211_set_wiphy' [-Wframe-larger-than]
    3603 | static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
         |            ^
   1 warning generated.


vim +/nl80211_set_wiphy +3603 net/wireless/nl80211.c

f444de05d20e27 Johannes Berg          2010-05-05  3602  
556829657397b9 Johannes Berg          2007-09-20 @3603  static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
556829657397b9 Johannes Berg          2007-09-20  3604  {
a05829a7222e9d Johannes Berg          2021-01-22  3605  	struct cfg80211_registered_device *rdev = NULL;
f444de05d20e27 Johannes Berg          2010-05-05  3606  	struct net_device *netdev = NULL;
f444de05d20e27 Johannes Berg          2010-05-05  3607  	struct wireless_dev *wdev;
a1e567c83f5414 Bill Jordan            2010-09-10  3608  	int result = 0, rem_txq_params = 0;
318884875bdddc Jouni Malinen          2008-10-30  3609  	struct nlattr *nl_txq_params;
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3610  	u32 changed;
c23c182175594b Roopni Devanathan      2025-01-24  3611  	u8 retry_short = 0, retry_long = 0, radio_id = NL80211_WIPHY_RADIO_ID_MAX;
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3612  	u32 frag_threshold = 0, rts_threshold = 0;
81077e82c3f591 Lukáš Turek            2009-12-21  3613  	u8 coverage_class = 0;
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3614  	u32 txq_limit = 0, txq_memory_limit = 0, txq_quantum = 0;
556829657397b9 Johannes Berg          2007-09-20  3615  
a05829a7222e9d Johannes Berg          2021-01-22  3616  	rtnl_lock();
f444de05d20e27 Johannes Berg          2010-05-05  3617  	/*
f444de05d20e27 Johannes Berg          2010-05-05  3618  	 * Try to find the wiphy and netdev. Normally this
f444de05d20e27 Johannes Berg          2010-05-05  3619  	 * function shouldn't need the netdev, but this is
f444de05d20e27 Johannes Berg          2010-05-05  3620  	 * done for backward compatibility -- previously
f444de05d20e27 Johannes Berg          2010-05-05  3621  	 * setting the channel was done per wiphy, but now
f444de05d20e27 Johannes Berg          2010-05-05  3622  	 * it is per netdev. Previous userland like hostapd
f444de05d20e27 Johannes Berg          2010-05-05  3623  	 * also passed a netdev to set_wiphy, so that it is
f444de05d20e27 Johannes Berg          2010-05-05  3624  	 * possible to let that go to the right netdev!
f444de05d20e27 Johannes Berg          2010-05-05  3625  	 */
4bbf4d56583dd5 Johannes Berg          2009-03-24  3626  
f444de05d20e27 Johannes Berg          2010-05-05  3627  	if (info->attrs[NL80211_ATTR_IFINDEX]) {
f444de05d20e27 Johannes Berg          2010-05-05  3628  		int ifindex = nla_get_u32(info->attrs[NL80211_ATTR_IFINDEX]);
f444de05d20e27 Johannes Berg          2010-05-05  3629  
7f2b8562c2ee6e Ying Xue               2014-01-15  3630  		netdev = __dev_get_by_index(genl_info_net(info), ifindex);
5fe231e873729f Johannes Berg          2013-05-08  3631  		if (netdev && netdev->ieee80211_ptr)
f26cbf401be935 Zhao, Gang             2014-04-21  3632  			rdev = wiphy_to_rdev(netdev->ieee80211_ptr->wiphy);
5fe231e873729f Johannes Berg          2013-05-08  3633  		else
f444de05d20e27 Johannes Berg          2010-05-05  3634  			netdev = NULL;
f444de05d20e27 Johannes Berg          2010-05-05  3635  	}
f444de05d20e27 Johannes Berg          2010-05-05  3636  
f444de05d20e27 Johannes Berg          2010-05-05  3637  	if (!netdev) {
878d9ec7367816 Johannes Berg          2012-06-15  3638  		rdev = __cfg80211_rdev_from_attrs(genl_info_net(info),
878d9ec7367816 Johannes Berg          2012-06-15  3639  						  info->attrs);
a05829a7222e9d Johannes Berg          2021-01-22  3640  		if (IS_ERR(rdev)) {
a05829a7222e9d Johannes Berg          2021-01-22  3641  			rtnl_unlock();
4c476991062a0a Johannes Berg          2010-10-04  3642  			return PTR_ERR(rdev);
a05829a7222e9d Johannes Berg          2021-01-22  3643  		}
f444de05d20e27 Johannes Berg          2010-05-05  3644  		wdev = NULL;
f444de05d20e27 Johannes Berg          2010-05-05  3645  		netdev = NULL;
f444de05d20e27 Johannes Berg          2010-05-05  3646  		result = 0;
71fe96bf9db8b1 Johannes Berg          2012-10-24  3647  	} else
f444de05d20e27 Johannes Berg          2010-05-05  3648  		wdev = netdev->ieee80211_ptr;
f444de05d20e27 Johannes Berg          2010-05-05  3649  
f42d22d3f79639 Johannes Berg          2024-11-22  3650  	guard(wiphy)(&rdev->wiphy);
a05829a7222e9d Johannes Berg          2021-01-22  3651  
f444de05d20e27 Johannes Berg          2010-05-05  3652  	/*
f444de05d20e27 Johannes Berg          2010-05-05  3653  	 * end workaround code, by now the rdev is available
f444de05d20e27 Johannes Berg          2010-05-05  3654  	 * and locked, and wdev may or may not be NULL.
f444de05d20e27 Johannes Berg          2010-05-05  3655  	 */
4bbf4d56583dd5 Johannes Berg          2009-03-24  3656  
4bbf4d56583dd5 Johannes Berg          2009-03-24  3657  	if (info->attrs[NL80211_ATTR_WIPHY_NAME])
318884875bdddc Jouni Malinen          2008-10-30  3658  		result = cfg80211_dev_rename(
318884875bdddc Jouni Malinen          2008-10-30  3659  			rdev, nla_data(info->attrs[NL80211_ATTR_WIPHY_NAME]));
0391a45c800780 Johannes Berg          2021-01-28  3660  	rtnl_unlock();
4bbf4d56583dd5 Johannes Berg          2009-03-24  3661  
318884875bdddc Jouni Malinen          2008-10-30  3662  	if (result)
f42d22d3f79639 Johannes Berg          2024-11-22  3663  		return result;
318884875bdddc Jouni Malinen          2008-10-30  3664  
c23c182175594b Roopni Devanathan      2025-01-24  3665  	if (info->attrs[NL80211_ATTR_WIPHY_RADIO_INDEX]) {
c23c182175594b Roopni Devanathan      2025-01-24  3666  		/* Radio idx is not expected for non-multi radio wiphy */
c23c182175594b Roopni Devanathan      2025-01-24  3667  		if (!rdev->wiphy.n_radio)
c23c182175594b Roopni Devanathan      2025-01-24  3668  			return -EINVAL;
c23c182175594b Roopni Devanathan      2025-01-24  3669  
c23c182175594b Roopni Devanathan      2025-01-24  3670  		radio_id = nla_get_u8(info->attrs[NL80211_ATTR_WIPHY_RADIO_INDEX]);
c23c182175594b Roopni Devanathan      2025-01-24  3671  		if (radio_id > rdev->wiphy.n_radio)
c23c182175594b Roopni Devanathan      2025-01-24  3672  			return -EINVAL;
c23c182175594b Roopni Devanathan      2025-01-24  3673  	}
c23c182175594b Roopni Devanathan      2025-01-24  3674  
318884875bdddc Jouni Malinen          2008-10-30  3675  	if (info->attrs[NL80211_ATTR_WIPHY_TXQ_PARAMS]) {
318884875bdddc Jouni Malinen          2008-10-30  3676  		struct ieee80211_txq_params txq_params;
318884875bdddc Jouni Malinen          2008-10-30  3677  		struct nlattr *tb[NL80211_TXQ_ATTR_MAX + 1];
318884875bdddc Jouni Malinen          2008-10-30  3678  
f42d22d3f79639 Johannes Berg          2024-11-22  3679  		if (!rdev->ops->set_txq_params)
f42d22d3f79639 Johannes Berg          2024-11-22  3680  			return -EOPNOTSUPP;
318884875bdddc Jouni Malinen          2008-10-30  3681  
f42d22d3f79639 Johannes Berg          2024-11-22  3682  		if (!netdev)
f42d22d3f79639 Johannes Berg          2024-11-22  3683  			return -EINVAL;
f70f01c2ebbe31 Eliad Peller           2011-09-25  3684  
133a3ff2c93422 Johannes Berg          2011-11-03  3685  		if (netdev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP &&
f42d22d3f79639 Johannes Berg          2024-11-22  3686  		    netdev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
f42d22d3f79639 Johannes Berg          2024-11-22  3687  			return -EINVAL;
133a3ff2c93422 Johannes Berg          2011-11-03  3688  
f42d22d3f79639 Johannes Berg          2024-11-22  3689  		if (!netif_running(netdev))
f42d22d3f79639 Johannes Berg          2024-11-22  3690  			return -ENETDOWN;
2b5f8b0b44e17e Johannes Berg          2012-04-02  3691  
318884875bdddc Jouni Malinen          2008-10-30  3692  		nla_for_each_nested(nl_txq_params,
318884875bdddc Jouni Malinen          2008-10-30  3693  				    info->attrs[NL80211_ATTR_WIPHY_TXQ_PARAMS],
318884875bdddc Jouni Malinen          2008-10-30  3694  				    rem_txq_params) {
8cb081746c031f Johannes Berg          2019-04-26  3695  			result = nla_parse_nested_deprecated(tb,
8cb081746c031f Johannes Berg          2019-04-26  3696  							     NL80211_TXQ_ATTR_MAX,
bfe2c7b1cce4a1 Johannes Berg          2016-10-26  3697  							     nl_txq_params,
fe52145f91fe81 Johannes Berg          2017-04-12  3698  							     txq_params_policy,
fe52145f91fe81 Johannes Berg          2017-04-12  3699  							     info->extack);
ae811e21df28de Johannes Berg          2014-01-24  3700  			if (result)
f42d22d3f79639 Johannes Berg          2024-11-22  3701  				return result;
f42d22d3f79639 Johannes Berg          2024-11-22  3702  
318884875bdddc Jouni Malinen          2008-10-30  3703  			result = parse_txq_params(tb, &txq_params);
318884875bdddc Jouni Malinen          2008-10-30  3704  			if (result)
f42d22d3f79639 Johannes Berg          2024-11-22  3705  				return result;
318884875bdddc Jouni Malinen          2008-10-30  3706  
9d2bb84d54a403 Shaul Triebitz         2022-08-02  3707  			txq_params.link_id =
9d2bb84d54a403 Shaul Triebitz         2022-08-02  3708  				nl80211_link_id_or_invalid(info->attrs);
9d2bb84d54a403 Shaul Triebitz         2022-08-02  3709  
9d2bb84d54a403 Shaul Triebitz         2022-08-02  3710  			if (txq_params.link_id >= 0 &&
9d2bb84d54a403 Shaul Triebitz         2022-08-02  3711  			    !(netdev->ieee80211_ptr->valid_links &
9d2bb84d54a403 Shaul Triebitz         2022-08-02  3712  			      BIT(txq_params.link_id)))
9d2bb84d54a403 Shaul Triebitz         2022-08-02  3713  				result = -ENOLINK;
9d2bb84d54a403 Shaul Triebitz         2022-08-02  3714  			else if (txq_params.link_id >= 0 &&
9d2bb84d54a403 Shaul Triebitz         2022-08-02  3715  				 !netdev->ieee80211_ptr->valid_links)
9d2bb84d54a403 Shaul Triebitz         2022-08-02  3716  				result = -EINVAL;
9d2bb84d54a403 Shaul Triebitz         2022-08-02  3717  			else
e35e4d28b687d4 Hila Gonen             2012-06-27  3718  				result = rdev_set_txq_params(rdev, netdev,
318884875bdddc Jouni Malinen          2008-10-30  3719  							     &txq_params);
318884875bdddc Jouni Malinen          2008-10-30  3720  			if (result)
f42d22d3f79639 Johannes Berg          2024-11-22  3721  				return result;
318884875bdddc Jouni Malinen          2008-10-30  3722  		}
318884875bdddc Jouni Malinen          2008-10-30  3723  	}
556829657397b9 Johannes Berg          2007-09-20  3724  
72bdcf34380917 Jouni Malinen          2008-11-26  3725  	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
69c3f2d30c3576 Ilan Peer              2022-06-12  3726  		int link_id = nl80211_link_id_or_invalid(info->attrs);
69c3f2d30c3576 Ilan Peer              2022-06-12  3727  
4e2f3d67e3afef Johannes Berg          2022-06-20  3728  		if (wdev) {
e16821bcfb364b Jouni Malinen          2014-04-28  3729  			result = __nl80211_set_channel(
e16821bcfb364b Jouni Malinen          2014-04-28  3730  				rdev,
e16821bcfb364b Jouni Malinen          2014-04-28  3731  				nl80211_can_set_dev_channel(wdev) ? netdev : NULL,
69c3f2d30c3576 Ilan Peer              2022-06-12  3732  				info, link_id);
4e2f3d67e3afef Johannes Berg          2022-06-20  3733  		} else {
69c3f2d30c3576 Ilan Peer              2022-06-12  3734  			result = __nl80211_set_channel(rdev, netdev, info, link_id);
4e2f3d67e3afef Johannes Berg          2022-06-20  3735  		}
69c3f2d30c3576 Ilan Peer              2022-06-12  3736  
72bdcf34380917 Jouni Malinen          2008-11-26  3737  		if (result)
f42d22d3f79639 Johannes Berg          2024-11-22  3738  			return result;
72bdcf34380917 Jouni Malinen          2008-11-26  3739  	}
72bdcf34380917 Jouni Malinen          2008-11-26  3740  
98d2ff8bec82fc Juuso Oikarinen        2010-06-23  3741  	if (info->attrs[NL80211_ATTR_WIPHY_TX_POWER_SETTING]) {
c8442118ad9cd0 Johannes Berg          2012-10-24  3742  		struct wireless_dev *txp_wdev = wdev;
98d2ff8bec82fc Juuso Oikarinen        2010-06-23  3743  		enum nl80211_tx_power_setting type;
98d2ff8bec82fc Juuso Oikarinen        2010-06-23  3744  		int idx, mbm = 0;
98d2ff8bec82fc Juuso Oikarinen        2010-06-23  3745  
c8442118ad9cd0 Johannes Berg          2012-10-24  3746  		if (!(rdev->wiphy.features & NL80211_FEATURE_VIF_TXPOWER))
c8442118ad9cd0 Johannes Berg          2012-10-24  3747  			txp_wdev = NULL;
c8442118ad9cd0 Johannes Berg          2012-10-24  3748  
f42d22d3f79639 Johannes Berg          2024-11-22  3749  		if (!rdev->ops->set_tx_power)
f42d22d3f79639 Johannes Berg          2024-11-22  3750  			return -EOPNOTSUPP;
98d2ff8bec82fc Juuso Oikarinen        2010-06-23  3751  
98d2ff8bec82fc Juuso Oikarinen        2010-06-23  3752  		idx = NL80211_ATTR_WIPHY_TX_POWER_SETTING;
98d2ff8bec82fc Juuso Oikarinen        2010-06-23  3753  		type = nla_get_u32(info->attrs[idx]);
98d2ff8bec82fc Juuso Oikarinen        2010-06-23  3754  
98d2ff8bec82fc Juuso Oikarinen        2010-06-23  3755  		if (!info->attrs[NL80211_ATTR_WIPHY_TX_POWER_LEVEL] &&
f42d22d3f79639 Johannes Berg          2024-11-22  3756  		    (type != NL80211_TX_POWER_AUTOMATIC))
f42d22d3f79639 Johannes Berg          2024-11-22  3757  			return -EINVAL;
98d2ff8bec82fc Juuso Oikarinen        2010-06-23  3758  
98d2ff8bec82fc Juuso Oikarinen        2010-06-23  3759  		if (type != NL80211_TX_POWER_AUTOMATIC) {
98d2ff8bec82fc Juuso Oikarinen        2010-06-23  3760  			idx = NL80211_ATTR_WIPHY_TX_POWER_LEVEL;
98d2ff8bec82fc Juuso Oikarinen        2010-06-23  3761  			mbm = nla_get_u32(info->attrs[idx]);
98d2ff8bec82fc Juuso Oikarinen        2010-06-23  3762  		}
98d2ff8bec82fc Juuso Oikarinen        2010-06-23  3763  
c8442118ad9cd0 Johannes Berg          2012-10-24  3764  		result = rdev_set_tx_power(rdev, txp_wdev, type, mbm);
98d2ff8bec82fc Juuso Oikarinen        2010-06-23  3765  		if (result)
f42d22d3f79639 Johannes Berg          2024-11-22  3766  			return result;
98d2ff8bec82fc Juuso Oikarinen        2010-06-23  3767  	}
98d2ff8bec82fc Juuso Oikarinen        2010-06-23  3768  
afe0cbf87500f0 Bruno Randolf          2010-11-10  3769  	if (info->attrs[NL80211_ATTR_WIPHY_ANTENNA_TX] &&
afe0cbf87500f0 Bruno Randolf          2010-11-10  3770  	    info->attrs[NL80211_ATTR_WIPHY_ANTENNA_RX]) {
afe0cbf87500f0 Bruno Randolf          2010-11-10  3771  		u32 tx_ant, rx_ant;
7a087e7484c9e4 Kirtika Ruchandani     2016-05-29  3772  
7f531e03abf016 Bruno Randolf          2010-12-16  3773  		if ((!rdev->wiphy.available_antennas_tx &&
7f531e03abf016 Bruno Randolf          2010-12-16  3774  		     !rdev->wiphy.available_antennas_rx) ||
f42d22d3f79639 Johannes Berg          2024-11-22  3775  		    !rdev->ops->set_antenna)
f42d22d3f79639 Johannes Berg          2024-11-22  3776  			return -EOPNOTSUPP;
afe0cbf87500f0 Bruno Randolf          2010-11-10  3777  
afe0cbf87500f0 Bruno Randolf          2010-11-10  3778  		tx_ant = nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_ANTENNA_TX]);
afe0cbf87500f0 Bruno Randolf          2010-11-10  3779  		rx_ant = nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_ANTENNA_RX]);
afe0cbf87500f0 Bruno Randolf          2010-11-10  3780  
a7ffac9591a2a0 Bruno Randolf          2010-12-08  3781  		/* reject antenna configurations which don't match the
7f531e03abf016 Bruno Randolf          2010-12-16  3782  		 * available antenna masks, except for the "all" mask */
7f531e03abf016 Bruno Randolf          2010-12-16  3783  		if ((~tx_ant && (tx_ant & ~rdev->wiphy.available_antennas_tx)) ||
f42d22d3f79639 Johannes Berg          2024-11-22  3784  		    (~rx_ant && (rx_ant & ~rdev->wiphy.available_antennas_rx)))
f42d22d3f79639 Johannes Berg          2024-11-22  3785  			return -EINVAL;
a7ffac9591a2a0 Bruno Randolf          2010-12-08  3786  
7f531e03abf016 Bruno Randolf          2010-12-16  3787  		tx_ant = tx_ant & rdev->wiphy.available_antennas_tx;
7f531e03abf016 Bruno Randolf          2010-12-16  3788  		rx_ant = rx_ant & rdev->wiphy.available_antennas_rx;
a7ffac9591a2a0 Bruno Randolf          2010-12-08  3789  
e35e4d28b687d4 Hila Gonen             2012-06-27  3790  		result = rdev_set_antenna(rdev, tx_ant, rx_ant);
afe0cbf87500f0 Bruno Randolf          2010-11-10  3791  		if (result)
f42d22d3f79639 Johannes Berg          2024-11-22  3792  			return result;
afe0cbf87500f0 Bruno Randolf          2010-11-10  3793  	}
afe0cbf87500f0 Bruno Randolf          2010-11-10  3794  
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3795  	changed = 0;
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3796  
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3797  	if (info->attrs[NL80211_ATTR_WIPHY_RETRY_SHORT]) {
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3798  		retry_short = nla_get_u8(
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3799  			info->attrs[NL80211_ATTR_WIPHY_RETRY_SHORT]);
7f2b8562c2ee6e Ying Xue               2014-01-15  3800  
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3801  		changed |= WIPHY_PARAM_RETRY_SHORT;
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3802  	}
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3803  
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3804  	if (info->attrs[NL80211_ATTR_WIPHY_RETRY_LONG]) {
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3805  		retry_long = nla_get_u8(
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3806  			info->attrs[NL80211_ATTR_WIPHY_RETRY_LONG]);
7f2b8562c2ee6e Ying Xue               2014-01-15  3807  
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3808  		changed |= WIPHY_PARAM_RETRY_LONG;
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3809  	}
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3810  
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3811  	if (info->attrs[NL80211_ATTR_WIPHY_FRAG_THRESHOLD]) {
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3812  		frag_threshold = nla_get_u32(
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3813  			info->attrs[NL80211_ATTR_WIPHY_FRAG_THRESHOLD]);
f42d22d3f79639 Johannes Berg          2024-11-22  3814  		if (frag_threshold < 256)
f42d22d3f79639 Johannes Berg          2024-11-22  3815  			return -EINVAL;
7f2b8562c2ee6e Ying Xue               2014-01-15  3816  
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3817  		if (frag_threshold != (u32) -1) {
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3818  			/*
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3819  			 * Fragments (apart from the last one) are required to
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3820  			 * have even length. Make the fragmentation code
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3821  			 * simpler by stripping LSB should someone try to use
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3822  			 * odd threshold value.
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3823  			 */
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3824  			frag_threshold &= ~0x1;
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3825  		}
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3826  		changed |= WIPHY_PARAM_FRAG_THRESHOLD;
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3827  	}
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3828  
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3829  	if (info->attrs[NL80211_ATTR_WIPHY_RTS_THRESHOLD]) {
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3830  		rts_threshold = nla_get_u32(
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3831  			info->attrs[NL80211_ATTR_WIPHY_RTS_THRESHOLD]);
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3832  		changed |= WIPHY_PARAM_RTS_THRESHOLD;
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3833  	}
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3834  
81077e82c3f591 Lukáš Turek            2009-12-21  3835  	if (info->attrs[NL80211_ATTR_WIPHY_COVERAGE_CLASS]) {
f42d22d3f79639 Johannes Berg          2024-11-22  3836  		if (info->attrs[NL80211_ATTR_WIPHY_DYN_ACK])
f42d22d3f79639 Johannes Berg          2024-11-22  3837  			return -EINVAL;
3057dbfdab1b86 Lorenzo Bianconi       2014-09-04  3838  
81077e82c3f591 Lukáš Turek            2009-12-21  3839  		coverage_class = nla_get_u8(
81077e82c3f591 Lukáš Turek            2009-12-21  3840  			info->attrs[NL80211_ATTR_WIPHY_COVERAGE_CLASS]);
81077e82c3f591 Lukáš Turek            2009-12-21  3841  		changed |= WIPHY_PARAM_COVERAGE_CLASS;
81077e82c3f591 Lukáš Turek            2009-12-21  3842  	}
81077e82c3f591 Lukáš Turek            2009-12-21  3843  
3057dbfdab1b86 Lorenzo Bianconi       2014-09-04  3844  	if (info->attrs[NL80211_ATTR_WIPHY_DYN_ACK]) {
f42d22d3f79639 Johannes Berg          2024-11-22  3845  		if (!(rdev->wiphy.features & NL80211_FEATURE_ACKTO_ESTIMATION))
f42d22d3f79639 Johannes Berg          2024-11-22  3846  			return -EOPNOTSUPP;
3057dbfdab1b86 Lorenzo Bianconi       2014-09-04  3847  
3057dbfdab1b86 Lorenzo Bianconi       2014-09-04  3848  		changed |= WIPHY_PARAM_DYN_ACK;
81077e82c3f591 Lukáš Turek            2009-12-21  3849  	}
81077e82c3f591 Lukáš Turek            2009-12-21  3850  
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3851  	if (info->attrs[NL80211_ATTR_TXQ_LIMIT]) {
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3852  		if (!wiphy_ext_feature_isset(&rdev->wiphy,
f42d22d3f79639 Johannes Berg          2024-11-22  3853  					     NL80211_EXT_FEATURE_TXQS))
f42d22d3f79639 Johannes Berg          2024-11-22  3854  			return -EOPNOTSUPP;
f42d22d3f79639 Johannes Berg          2024-11-22  3855  
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3856  		txq_limit = nla_get_u32(
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3857  			info->attrs[NL80211_ATTR_TXQ_LIMIT]);
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3858  		changed |= WIPHY_PARAM_TXQ_LIMIT;
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3859  	}
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3860  
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3861  	if (info->attrs[NL80211_ATTR_TXQ_MEMORY_LIMIT]) {
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3862  		if (!wiphy_ext_feature_isset(&rdev->wiphy,
f42d22d3f79639 Johannes Berg          2024-11-22  3863  					     NL80211_EXT_FEATURE_TXQS))
f42d22d3f79639 Johannes Berg          2024-11-22  3864  			return -EOPNOTSUPP;
f42d22d3f79639 Johannes Berg          2024-11-22  3865  
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3866  		txq_memory_limit = nla_get_u32(
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3867  			info->attrs[NL80211_ATTR_TXQ_MEMORY_LIMIT]);
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3868  		changed |= WIPHY_PARAM_TXQ_MEMORY_LIMIT;
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3869  	}
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3870  
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3871  	if (info->attrs[NL80211_ATTR_TXQ_QUANTUM]) {
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3872  		if (!wiphy_ext_feature_isset(&rdev->wiphy,
f42d22d3f79639 Johannes Berg          2024-11-22  3873  					     NL80211_EXT_FEATURE_TXQS))
f42d22d3f79639 Johannes Berg          2024-11-22  3874  			return -EOPNOTSUPP;
f42d22d3f79639 Johannes Berg          2024-11-22  3875  
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3876  		txq_quantum = nla_get_u32(
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3877  			info->attrs[NL80211_ATTR_TXQ_QUANTUM]);
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3878  		changed |= WIPHY_PARAM_TXQ_QUANTUM;
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3879  	}
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3880  
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3881  	if (changed) {
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3882  		u8 old_retry_short, old_retry_long;
c23c182175594b Roopni Devanathan      2025-01-24  3883  		u32 old_frag_threshold, old_rts_threshold[NL80211_WIPHY_RADIO_ID_MAX];
c23c182175594b Roopni Devanathan      2025-01-24  3884  		u8 old_coverage_class, i;
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3885  		u32 old_txq_limit, old_txq_memory_limit, old_txq_quantum;
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3886  
f42d22d3f79639 Johannes Berg          2024-11-22  3887  		if (!rdev->ops->set_wiphy_params)
f42d22d3f79639 Johannes Berg          2024-11-22  3888  			return -EOPNOTSUPP;
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3889  
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3890  		old_retry_short = rdev->wiphy.retry_short;
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3891  		old_retry_long = rdev->wiphy.retry_long;
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3892  		old_frag_threshold = rdev->wiphy.frag_threshold;
c23c182175594b Roopni Devanathan      2025-01-24  3893  		if (radio_id >= rdev->wiphy.n_radio) {
c23c182175594b Roopni Devanathan      2025-01-24  3894  			old_rts_threshold[0] = rdev->wiphy.rts_threshold;
c23c182175594b Roopni Devanathan      2025-01-24  3895  			for (i = 0; i < rdev->wiphy.n_radio; i++)
c23c182175594b Roopni Devanathan      2025-01-24  3896  				old_rts_threshold[i] = rdev->wiphy.radio_cfg[i].rts_threshold;
c23c182175594b Roopni Devanathan      2025-01-24  3897  		} else {
c23c182175594b Roopni Devanathan      2025-01-24  3898  			old_rts_threshold[radio_id] = rdev->wiphy.radio_cfg[radio_id].rts_threshold;
c23c182175594b Roopni Devanathan      2025-01-24  3899  		}
81077e82c3f591 Lukáš Turek            2009-12-21  3900  		old_coverage_class = rdev->wiphy.coverage_class;
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3901  		old_txq_limit = rdev->wiphy.txq_limit;
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3902  		old_txq_memory_limit = rdev->wiphy.txq_memory_limit;
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3903  		old_txq_quantum = rdev->wiphy.txq_quantum;
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3904  
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3905  		if (changed & WIPHY_PARAM_RETRY_SHORT)
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3906  			rdev->wiphy.retry_short = retry_short;
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3907  		if (changed & WIPHY_PARAM_RETRY_LONG)
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3908  			rdev->wiphy.retry_long = retry_long;
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3909  		if (changed & WIPHY_PARAM_FRAG_THRESHOLD)
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3910  			rdev->wiphy.frag_threshold = frag_threshold;
c23c182175594b Roopni Devanathan      2025-01-24  3911  		if (changed & WIPHY_PARAM_RTS_THRESHOLD) {
c23c182175594b Roopni Devanathan      2025-01-24  3912  			if (radio_id >= rdev->wiphy.n_radio) {
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3913  				rdev->wiphy.rts_threshold = rts_threshold;
c23c182175594b Roopni Devanathan      2025-01-24  3914  				for (i = 0; i < rdev->wiphy.n_radio; i++)
c23c182175594b Roopni Devanathan      2025-01-24  3915  					rdev->wiphy.radio_cfg[i].rts_threshold = rts_threshold;
c23c182175594b Roopni Devanathan      2025-01-24  3916  			} else {
c23c182175594b Roopni Devanathan      2025-01-24  3917  				rdev->wiphy.radio_cfg[radio_id].rts_threshold =	rts_threshold;
c23c182175594b Roopni Devanathan      2025-01-24  3918  			}
c23c182175594b Roopni Devanathan      2025-01-24  3919  		}
81077e82c3f591 Lukáš Turek            2009-12-21  3920  		if (changed & WIPHY_PARAM_COVERAGE_CLASS)
81077e82c3f591 Lukáš Turek            2009-12-21  3921  			rdev->wiphy.coverage_class = coverage_class;
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3922  		if (changed & WIPHY_PARAM_TXQ_LIMIT)
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3923  			rdev->wiphy.txq_limit = txq_limit;
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3924  		if (changed & WIPHY_PARAM_TXQ_MEMORY_LIMIT)
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3925  			rdev->wiphy.txq_memory_limit = txq_memory_limit;
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3926  		if (changed & WIPHY_PARAM_TXQ_QUANTUM)
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3927  			rdev->wiphy.txq_quantum = txq_quantum;
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3928  
c23c182175594b Roopni Devanathan      2025-01-24  3929  		result = rdev_set_wiphy_params(rdev, radio_id, changed);
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3930  		if (result) {
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3931  			rdev->wiphy.retry_short = old_retry_short;
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3932  			rdev->wiphy.retry_long = old_retry_long;
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3933  			rdev->wiphy.frag_threshold = old_frag_threshold;
c23c182175594b Roopni Devanathan      2025-01-24  3934  			if (radio_id >= rdev->wiphy.n_radio) {
c23c182175594b Roopni Devanathan      2025-01-24  3935  				rdev->wiphy.rts_threshold = old_rts_threshold[0];
c23c182175594b Roopni Devanathan      2025-01-24  3936  				for (i = 0; i < rdev->wiphy.n_radio; i++)
c23c182175594b Roopni Devanathan      2025-01-24  3937  					rdev->wiphy.radio_cfg[i].rts_threshold = old_rts_threshold[i];
c23c182175594b Roopni Devanathan      2025-01-24  3938  			} else {
c23c182175594b Roopni Devanathan      2025-01-24  3939  				rdev->wiphy.radio_cfg[radio_id].rts_threshold = old_rts_threshold[radio_id];
c23c182175594b Roopni Devanathan      2025-01-24  3940  			}
81077e82c3f591 Lukáš Turek            2009-12-21  3941  			rdev->wiphy.coverage_class = old_coverage_class;
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3942  			rdev->wiphy.txq_limit = old_txq_limit;
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3943  			rdev->wiphy.txq_memory_limit = old_txq_memory_limit;
52539ca89f365d Toke Høiland-Jørgensen 2018-05-08  3944  			rdev->wiphy.txq_quantum = old_txq_quantum;
f42d22d3f79639 Johannes Berg          2024-11-22  3945  			return result;
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3946  		}
b9a5f8cab751d3 Jouni Malinen          2009-04-20  3947  	}
a05829a7222e9d Johannes Berg          2021-01-22  3948  
f42d22d3f79639 Johannes Berg          2024-11-22  3949  	return 0;
556829657397b9 Johannes Berg          2007-09-20  3950  }
556829657397b9 Johannes Berg          2007-09-20  3951  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-wireless+bounces-28090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17552BEF4EF
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 06:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B985D3E1E06
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 04:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219772BDC19;
	Mon, 20 Oct 2025 04:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fOwLcce1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5042BDC3F;
	Mon, 20 Oct 2025 04:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760935478; cv=none; b=PW2mI+PCldxXh7FfAWjrtXf5IEaxXXf2aVyaq4Okkka1pVpEMlxd0ZMbaJcLnJ+YwqMN+9BlYP2CKGMR/BID412ioJPoN5XxYjSUsGoR5D/VtlI7tsJgBk4Dbhv0a5Q/unglONYT2r+IzU3V2jQaw9ZiqYk8x1/qQr5ttuCRC4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760935478; c=relaxed/simple;
	bh=304Yr1T1ZRL1VpqnFx3paSyfEmkD8GLktg/kA1hWBsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gt1HESDwTBhux32li3VQjPhWAzV4pHUagVZPh1C1dxkhHW6KyQxgvKJZJKFrjN8pZhokdEe1Wotu+3UNji/OqkbApfTyrBOdbaKfekDrPNn7PvM9nQkcZ9r2cR+xLUAFZQ0O4sSIbXReeFSydXoFRDUJwcwVl+xNh6rntIQgpPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fOwLcce1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760935476; x=1792471476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=304Yr1T1ZRL1VpqnFx3paSyfEmkD8GLktg/kA1hWBsE=;
  b=fOwLcce1pQopCvZjknxcveNDPkzwWf6T7FfclCQFj2CMzaU+JbGdzHDi
   bvkd5bsFmu3p8IjEgGec8FucxCBIJogVYFMVDIP9sCIGIc3a8DhjbdftB
   iLynG4YetW4ilibMeaR/pQ156ctpqKWUNnmKdNCSBX4eLLjh+lc1mM+/C
   x9jBt+e/vYqv4Vdz1qg64qGF9ZYqCBg/0bMlGXnjTOfOBbPKe3stVQeRM
   9B2rI3s3ekvi49j8t3Mz07yt0VYUhCsv9yG2fOv5T27TPomL2OWX9qV7m
   i2/f+INBS1gMNqRSkmzrKWBrbX2N96iGswm/PlvmPeqheek8obETzgdU4
   Q==;
X-CSE-ConnectionGUID: 6/z/Ja4ZQUWmbwsS1N7Few==
X-CSE-MsgGUID: sixJwz6lSEOd+vQmzKCGsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="65666591"
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="65666591"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 21:44:35 -0700
X-CSE-ConnectionGUID: 4z0u4NppRxm0lWYQ3abMHw==
X-CSE-MsgGUID: LAjfWbQvQ2mnz75G2nGsJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="187657353"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 19 Oct 2025 21:44:31 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vAhkO-0009U1-0j;
	Mon, 20 Oct 2025 04:44:05 +0000
Date: Mon, 20 Oct 2025 12:43:43 +0800
From: kernel test robot <lkp@intel.com>
To: Aleksander Jan Bajkowski <olek2@wp.pl>, nbd@nbd.name,
	lorenzo@kernel.org, ryder.lee@mediatek.com,
	shayne.chen@mediatek.com, sean.wang@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	howard-yh.hsu@mediatek.com, StanleyYP.Wang@mediatek.com,
	rosenp@gmail.com, luoxueqin@kylinos.cn, chad@monroe.io,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] wifi: mt76: add tx checksum offload for mt7915, mt7921,
 mt7981 and mt7986
Message-ID: <202510201250.Hpsrohca-lkp@intel.com>
References: <20251019155316.3537185-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251019155316.3537185-1-olek2@wp.pl>

Hi Aleksander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.18-rc2 next-20251017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aleksander-Jan-Bajkowski/wifi-mt76-add-tx-checksum-offload-for-mt7915-mt7921-mt7981-and-mt7986/20251019-235515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20251019155316.3537185-1-olek2%40wp.pl
patch subject: [PATCH] wifi: mt76: add tx checksum offload for mt7915, mt7921, mt7981 and mt7986
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20251020/202510201250.Hpsrohca-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 754ebc6ebb9fb9fbee7aef33478c74ea74949853)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251020/202510201250.Hpsrohca-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510201250.Hpsrohca-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/mediatek/mt76/mt792x_core.c:636:19: warning: expression result unused [-Wunused-value]
     636 |                 NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
         |                 ~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +636 drivers/net/wireless/mediatek/mt76/mt792x_core.c

   618	
   619	int mt792x_init_wiphy(struct ieee80211_hw *hw)
   620	{
   621		struct mt792x_phy *phy = mt792x_hw_phy(hw);
   622		struct mt792x_dev *dev = phy->dev;
   623		struct wiphy *wiphy = hw->wiphy;
   624	
   625		hw->queues = 4;
   626		if (dev->has_eht) {
   627			hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_EHT;
   628			hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_EHT;
   629		} else {
   630			hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
   631			hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
   632		}
   633		hw->netdev_features = NETIF_F_RXCSUM;
   634	
   635		if (is_mt7921(&dev->mt76))
 > 636			NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
   637	
   638		hw->radiotap_timestamp.units_pos =
   639			IEEE80211_RADIOTAP_TIMESTAMP_UNIT_US;
   640	
   641		phy->slottime = 9;
   642	
   643		hw->sta_data_size = sizeof(struct mt792x_sta);
   644		hw->vif_data_size = sizeof(struct mt792x_vif);
   645		hw->chanctx_data_size = sizeof(struct mt792x_chanctx);
   646	
   647		if (dev->fw_features & MT792x_FW_CAP_CNM) {
   648			wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
   649			wiphy->iface_combinations = if_comb_chanctx;
   650			wiphy->n_iface_combinations = ARRAY_SIZE(if_comb_chanctx);
   651		} else {
   652			wiphy->flags &= ~WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
   653			wiphy->iface_combinations = if_comb;
   654			wiphy->n_iface_combinations = ARRAY_SIZE(if_comb);
   655		}
   656		wiphy->flags &= ~(WIPHY_FLAG_IBSS_RSN | WIPHY_FLAG_4ADDR_AP |
   657				  WIPHY_FLAG_4ADDR_STATION);
   658		wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
   659					 BIT(NL80211_IFTYPE_AP) |
   660					 BIT(NL80211_IFTYPE_P2P_CLIENT) |
   661					 BIT(NL80211_IFTYPE_P2P_GO) |
   662					 BIT(NL80211_IFTYPE_P2P_DEVICE);
   663		wiphy->max_remain_on_channel_duration = 5000;
   664		wiphy->max_scan_ie_len = MT76_CONNAC_SCAN_IE_LEN;
   665		wiphy->max_scan_ssids = 4;
   666		wiphy->max_sched_scan_plan_interval =
   667			MT76_CONNAC_MAX_TIME_SCHED_SCAN_INTERVAL;
   668		wiphy->max_sched_scan_ie_len = IEEE80211_MAX_DATA_LEN;
   669		wiphy->max_sched_scan_ssids = MT76_CONNAC_MAX_SCHED_SCAN_SSID;
   670		wiphy->max_match_sets = MT76_CONNAC_MAX_SCAN_MATCH;
   671		wiphy->max_sched_scan_reqs = 1;
   672		wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH |
   673				WIPHY_FLAG_SPLIT_SCAN_6GHZ;
   674	
   675		wiphy->features |= NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
   676				   NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
   677		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
   678		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_LEGACY);
   679		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HT);
   680		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_VHT);
   681		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HE);
   682		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT);
   683		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
   684	
   685		ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
   686		ieee80211_hw_set(hw, HAS_RATE_CONTROL);
   687		ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
   688		ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
   689		ieee80211_hw_set(hw, WANT_MONITOR_VIF);
   690		ieee80211_hw_set(hw, SUPPORTS_PS);
   691		ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
   692		ieee80211_hw_set(hw, SUPPORTS_VHT_EXT_NSS_BW);
   693		ieee80211_hw_set(hw, CONNECTION_MONITOR);
   694		ieee80211_hw_set(hw, NO_VIRTUAL_MONITOR);
   695		ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
   696		ieee80211_hw_set(hw, SUPPORTS_ONLY_HE_MULTI_BSSID);
   697	
   698		if (is_mt7921(&dev->mt76)) {
   699			ieee80211_hw_set(hw, CHANCTX_STA_CSA);
   700		}
   701	
   702		if (dev->pm.enable)
   703			ieee80211_hw_set(hw, CONNECTION_MONITOR);
   704	
   705		hw->max_tx_fragments = 4;
   706	
   707		return 0;
   708	}
   709	EXPORT_SYMBOL_GPL(mt792x_init_wiphy);
   710	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


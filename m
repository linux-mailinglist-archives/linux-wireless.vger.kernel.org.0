Return-Path: <linux-wireless+bounces-19661-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93DCA4AEB9
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Mar 2025 03:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6B516F030
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Mar 2025 02:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5068F2C1A2;
	Sun,  2 Mar 2025 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWNxaO/S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1A5219ED;
	Sun,  2 Mar 2025 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740882006; cv=none; b=rXmyqKmu+8A9oiipEUaWDXG75+nFuQXXd+ZZ8fMkRog53czOeQJWhnXFy2/JbiFggBxYKNanTGLPeGiAblszMnoTnU81nfaf8Yy72c0e2TVa7RYHAuayYg3qYhUBD9paesq9O/PjLPzlfDCZECv+mjDFCcc+k/RYvw94jBNVwCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740882006; c=relaxed/simple;
	bh=ygGOXZz3q74B49XoCo/bcdvVVY8y617VZkDMUPN6Nh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8ghSy980Vn0TRiLsOznqKhi2zGn1+BM5xqVVXcfyh4AfW2TKAS74WtcarObuMxVDnyfZMD5t4xM/+QXcTaGT0xbxkqEkjxfOX1sF+oLqvzvJ8rMY/VU4SVVRMEOvlWXqqBKzdDnBJRDjvY0qC1H4m8vDt0+Iou7F53JmucTYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWNxaO/S; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740882004; x=1772418004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ygGOXZz3q74B49XoCo/bcdvVVY8y617VZkDMUPN6Nh4=;
  b=jWNxaO/SlvDWqpB5MauRn8NzqbcyFfWFMEkyIcJxuuC67/kWsk/kNosl
   e6kv1dtsGT+Eun4hLt1uMprnfkzgsVsOllDkPqRag0jtdFqE9TGd80D5U
   3xyrON7Eie3Xj1gHxyIvvGr5aUSevqbNM+MmbDUypZBhA3oSQfhRvzeL6
   CBjmWrORRnPSDt65v9Cyi907Hsof5g/Ow6Lpl3Sa35s07qrGIdDK0FyAq
   3YCI5o7tKzppYOQ2XLJRf9h4cjqORZhg71Wg5sOHRl9Nq7NNyJriqfFgW
   BYzW7F7MHM/akwX+0szFVQCOhj1ulmFk+xUlDE+ZMBitYCBsNC4Anj+Z9
   Q==;
X-CSE-ConnectionGUID: Ia6ikqwQQueZTpUplX37Fw==
X-CSE-MsgGUID: y3wGlYqNSuqt76HD7/0YFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="41901083"
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="41901083"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 18:20:03 -0800
X-CSE-ConnectionGUID: K2tkNldLTlC47VSuYZL5OA==
X-CSE-MsgGUID: W0Bq2vvfQbWf6HYe9gVDFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="122285997"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 01 Mar 2025 18:20:01 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toYvv-000Gxm-1w;
	Sun, 02 Mar 2025 02:19:59 +0000
Date: Sun, 2 Mar 2025 10:19:12 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
	linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>, linux-devel@silabs.com,
	=?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>
Subject: Re: [PATCH 2/5] wifi: wfx: declare support for WoWLAN
Message-ID: <202503021057.5qCOqraa-lkp@intel.com>
References: <20250228171441.109321-3-jerome.pouiller@silabs.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250228171441.109321-3-jerome.pouiller@silabs.com>

Hi Jérôme,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.14-rc4 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/J-r-me-Pouiller/wifi-wfx-align-declarations-between-bus_spi-c-and-bus_sdio-c/20250301-022722
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20250228171441.109321-3-jerome.pouiller%40silabs.com
patch subject: [PATCH 2/5] wifi: wfx: declare support for WoWLAN
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20250302/202503021057.5qCOqraa-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503021057.5qCOqraa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503021057.5qCOqraa-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/wireless/silabs/wfx/main.c: In function 'wfx_init_common':
>> drivers/net/wireless/silabs/wfx/main.c:300:18: error: 'struct wiphy' has no member named 'wowlan'
     300 |         hw->wiphy->wowlan = &wfx_wowlan_support;
         |                  ^~


vim +300 drivers/net/wireless/silabs/wfx/main.c

   263	
   264	struct wfx_dev *wfx_init_common(struct device *dev, const struct wfx_platform_data *pdata,
   265					const struct wfx_hwbus_ops *hwbus_ops, void *hwbus_priv)
   266	{
   267		struct ieee80211_hw *hw;
   268		struct wfx_dev *wdev;
   269	
   270		hw = ieee80211_alloc_hw(sizeof(struct wfx_dev), &wfx_ops);
   271		if (!hw)
   272			return NULL;
   273	
   274		SET_IEEE80211_DEV(hw, dev);
   275	
   276		ieee80211_hw_set(hw, TX_AMPDU_SETUP_IN_HW);
   277		ieee80211_hw_set(hw, AMPDU_AGGREGATION);
   278		ieee80211_hw_set(hw, CONNECTION_MONITOR);
   279		ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
   280		ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
   281		ieee80211_hw_set(hw, SIGNAL_DBM);
   282		ieee80211_hw_set(hw, SUPPORTS_PS);
   283		ieee80211_hw_set(hw, MFP_CAPABLE);
   284	
   285		hw->vif_data_size = sizeof(struct wfx_vif);
   286		hw->sta_data_size = sizeof(struct wfx_sta_priv);
   287		hw->queues = 4;
   288		hw->max_rates = 8;
   289		hw->max_rate_tries = 8;
   290		hw->extra_tx_headroom = sizeof(struct wfx_hif_msg) + sizeof(struct wfx_hif_req_tx) +
   291					4 /* alignment */ + 8 /* TKIP IV */;
   292		hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
   293					     BIT(NL80211_IFTYPE_ADHOC) |
   294					     BIT(NL80211_IFTYPE_AP);
   295		hw->wiphy->probe_resp_offload = NL80211_PROBE_RESP_OFFLOAD_SUPPORT_WPS |
   296						NL80211_PROBE_RESP_OFFLOAD_SUPPORT_WPS2 |
   297						NL80211_PROBE_RESP_OFFLOAD_SUPPORT_P2P |
   298						NL80211_PROBE_RESP_OFFLOAD_SUPPORT_80211U;
   299		hw->wiphy->features |= NL80211_FEATURE_AP_SCAN;
 > 300		hw->wiphy->wowlan = &wfx_wowlan_support;
   301		hw->wiphy->flags |= WIPHY_FLAG_AP_PROBE_RESP_OFFLOAD;
   302		hw->wiphy->flags |= WIPHY_FLAG_AP_UAPSD;
   303		hw->wiphy->max_remain_on_channel_duration = 5000;
   304		hw->wiphy->max_ap_assoc_sta = HIF_LINK_ID_MAX;
   305		hw->wiphy->max_scan_ssids = 2;
   306		hw->wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
   307		hw->wiphy->n_iface_combinations = ARRAY_SIZE(wfx_iface_combinations);
   308		hw->wiphy->iface_combinations = wfx_iface_combinations;
   309		/* FIXME: also copy wfx_rates and wfx_2ghz_chantable */
   310		hw->wiphy->bands[NL80211_BAND_2GHZ] = devm_kmemdup(dev, &wfx_band_2ghz,
   311								   sizeof(wfx_band_2ghz), GFP_KERNEL);
   312		if (!hw->wiphy->bands[NL80211_BAND_2GHZ])
   313			goto err;
   314	
   315		wdev = hw->priv;
   316		wdev->hw = hw;
   317		wdev->dev = dev;
   318		wdev->hwbus_ops = hwbus_ops;
   319		wdev->hwbus_priv = hwbus_priv;
   320		memcpy(&wdev->pdata, pdata, sizeof(*pdata));
   321		of_property_read_string(dev->of_node, "silabs,antenna-config-file", &wdev->pdata.file_pds);
   322		wdev->pdata.gpio_wakeup = devm_gpiod_get_optional(dev, "wakeup", GPIOD_OUT_LOW);
   323		if (IS_ERR(wdev->pdata.gpio_wakeup))
   324			goto err;
   325	
   326		if (wdev->pdata.gpio_wakeup)
   327			gpiod_set_consumer_name(wdev->pdata.gpio_wakeup, "wfx wakeup");
   328	
   329		mutex_init(&wdev->conf_mutex);
   330		mutex_init(&wdev->scan_lock);
   331		mutex_init(&wdev->rx_stats_lock);
   332		mutex_init(&wdev->tx_power_loop_info_lock);
   333		init_completion(&wdev->firmware_ready);
   334		INIT_DELAYED_WORK(&wdev->cooling_timeout_work, wfx_cooling_timeout_work);
   335		skb_queue_head_init(&wdev->tx_pending);
   336		init_waitqueue_head(&wdev->tx_dequeue);
   337		wfx_init_hif_cmd(&wdev->hif_cmd);
   338	
   339		if (devm_add_action_or_reset(dev, wfx_free_common, wdev))
   340			return NULL;
   341	
   342		return wdev;
   343	
   344	err:
   345		ieee80211_free_hw(hw);
   346		return NULL;
   347	}
   348	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


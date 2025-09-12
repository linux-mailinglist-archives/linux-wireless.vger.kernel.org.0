Return-Path: <linux-wireless+bounces-27266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C49BB54D85
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 14:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7ACB16AA00
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 12:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388532957C2;
	Fri, 12 Sep 2025 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0J9tdwh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DBC238C08
	for <linux-wireless@vger.kernel.org>; Fri, 12 Sep 2025 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679694; cv=none; b=O/yfRr+1oX5AoCmG+5sGzYGU2pvP4Nkf3+WeVXg36PiKlDe2wpRgexECFVGJlUVQrwRp59zgZFRGvN8MiddOIw5gRj3MaOTregwdSzmMsVduWOEnp1CMWRO4iZ2EdcKzDRyFbBEgmg9uR7LzfSB9XCO1Hhar04FlrXYosu+mNWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679694; c=relaxed/simple;
	bh=b5WHxd4xwn9rgvCSXcEEDbW+90LANpn1Bb2s22tI1ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZ04kPwidz1D2v4/LWE8kZPdNRVH71Oh6fDkKSCs7kT27HQprJhkPFLzIlNQMVK6ujaRUf729VmVIjXkdTFrMAv0LLhF69/9Wj3tADZqTqPx312iDgq6sOsBXI1/V0SxaiUdGXiM4s+LcigytSYjXEJYkMqfTCndxSjWu5QNDGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D0J9tdwh; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757679692; x=1789215692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b5WHxd4xwn9rgvCSXcEEDbW+90LANpn1Bb2s22tI1ac=;
  b=D0J9tdwhhZXY/4tXtLa5GI6ZInnhrCv20rGFGnQkNNbM/O9Au4wF1hAR
   Op4gwkbHkxX1mxoEGlLeYCyOgAGxqsm373N9f6KcbeeeKKYCkQH6ulvNV
   eUtkZrDgsxtmrcpJJyFXJu08OE0hVELzx245TwPK33yvAxMLol33gqc0g
   rzTjslLJ3RFGcIzgHHWkJM4QsaJBuJQbi78EUE+mqy/OFiQftzGp8OGGw
   KFE4TNibHrh2+PjSgJi5+TV7tWcoYZowMuqE17xcb8IcQjNGAxPViykCC
   3QA4omfMFZqRCTiZwqL9W8HCcUPAaPZjSsbX8Y6NYZfkNamncbeG7tKCd
   A==;
X-CSE-ConnectionGUID: tTwwF+TJRSiQkiDxQFva9A==
X-CSE-MsgGUID: l30skVbuRv6xvUg+HhE1nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="70647304"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="70647304"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 05:21:31 -0700
X-CSE-ConnectionGUID: GEbi4FkfSrOFGVHD0mHSpQ==
X-CSE-MsgGUID: TN0X/Ch1QVyqm85T/0E1MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="174396413"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 12 Sep 2025 05:21:29 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ux2mM-00010m-2S;
	Fri, 12 Sep 2025 12:21:26 +0000
Date: Fri, 12 Sep 2025 20:21:09 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH mt76 5/5] wifi: mt76: mt7996: Add NPU offload support to
 MT7996 driver
Message-ID: <202509122047.IrKGvn3P-lkp@intel.com>
References: <20250910-mt76-npu-devel-v1-5-dbde4a37b9c0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-mt76-npu-devel-v1-5-dbde4a37b9c0@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8620dfbed395fc72f968dfd07f1b50eba352bae6]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/wifi-mt76-Move-Q_READ-Q_WRITE-definitions-in-dma-h/20250910-230350
base:   8620dfbed395fc72f968dfd07f1b50eba352bae6
patch link:    https://lore.kernel.org/r/20250910-mt76-npu-devel-v1-5-dbde4a37b9c0%40kernel.org
patch subject: [PATCH mt76 5/5] wifi: mt76: mt7996: Add NPU offload support to MT7996 driver
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250912/202509122047.IrKGvn3P-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 21857ae337e0892a5522b6e7337899caa61de2a6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250912/202509122047.IrKGvn3P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509122047.IrKGvn3P-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from <built-in>:3:
   In file included from include/linux/compiler_types.h:171:
   include/linux/compiler-clang.h:28:9: warning: '__SANITIZE_ADDRESS__' macro redefined [-Wmacro-redefined]
      28 | #define __SANITIZE_ADDRESS__
         |         ^
   <built-in>:371:9: note: previous definition is here
     371 | #define __SANITIZE_ADDRESS__ 1
         |         ^
>> drivers/net/wireless/mediatek/mt76/mt7996/main.c:2261:2: warning: use of a '#elifdef' directive is a C23 extension [-Wc23-extensions]
    2261 | #elifdef CONFIG_MT7996_NPU
         |  ^
   2 warnings generated.


vim +2261 drivers/net/wireless/mediatek/mt76/mt7996/main.c

  2205	
  2206	const struct ieee80211_ops mt7996_ops = {
  2207		.add_chanctx = mt76_add_chanctx,
  2208		.remove_chanctx = mt76_remove_chanctx,
  2209		.change_chanctx = mt76_change_chanctx,
  2210		.assign_vif_chanctx = mt76_assign_vif_chanctx,
  2211		.unassign_vif_chanctx = mt76_unassign_vif_chanctx,
  2212		.switch_vif_chanctx = mt76_switch_vif_chanctx,
  2213		.tx = mt7996_tx,
  2214		.start = mt7996_start,
  2215		.stop = mt7996_stop,
  2216		.add_interface = mt7996_add_interface,
  2217		.remove_interface = mt7996_remove_interface,
  2218		.config = mt7996_config,
  2219		.conf_tx = mt7996_conf_tx,
  2220		.configure_filter = mt7996_configure_filter,
  2221		.vif_cfg_changed = mt7996_vif_cfg_changed,
  2222		.link_info_changed = mt7996_link_info_changed,
  2223		.sta_state = mt7996_sta_state,
  2224		.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
  2225		.link_sta_rc_update = mt7996_link_sta_rc_update,
  2226		.set_key = mt7996_set_key,
  2227		.ampdu_action = mt7996_ampdu_action,
  2228		.set_rts_threshold = mt7996_set_rts_threshold,
  2229		.wake_tx_queue = mt76_wake_tx_queue,
  2230		.hw_scan = mt76_hw_scan,
  2231		.cancel_hw_scan = mt76_cancel_hw_scan,
  2232		.remain_on_channel = mt76_remain_on_channel,
  2233		.cancel_remain_on_channel = mt76_cancel_remain_on_channel,
  2234		.release_buffered_frames = mt76_release_buffered_frames,
  2235		.get_txpower = mt7996_get_txpower,
  2236		.channel_switch_beacon = mt7996_channel_switch_beacon,
  2237		.get_stats = mt7996_get_stats,
  2238		.get_et_sset_count = mt7996_get_et_sset_count,
  2239		.get_et_stats = mt7996_get_et_stats,
  2240		.get_et_strings = mt7996_get_et_strings,
  2241		.get_tsf = mt7996_get_tsf,
  2242		.set_tsf = mt7996_set_tsf,
  2243		.offset_tsf = mt7996_offset_tsf,
  2244		.get_survey = mt76_get_survey,
  2245		.get_antenna = mt76_get_antenna,
  2246		.set_antenna = mt7996_set_antenna,
  2247		.set_bitrate_mask = mt7996_set_bitrate_mask,
  2248		.set_coverage_class = mt7996_set_coverage_class,
  2249		.sta_statistics = mt7996_sta_statistics,
  2250		.sta_set_4addr = mt7996_sta_set_4addr,
  2251		.sta_set_decap_offload = mt7996_sta_set_decap_offload,
  2252		.add_twt_setup = mt7996_mac_add_twt_setup,
  2253		.twt_teardown_request = mt7996_twt_teardown_request,
  2254	#ifdef CONFIG_MAC80211_DEBUGFS
  2255		.sta_add_debugfs = mt7996_sta_add_debugfs,
  2256	#endif
  2257		.set_radar_background = mt7996_set_radar_background,
  2258		.net_fill_forward_path = mt7996_net_fill_forward_path,
  2259	#ifdef CONFIG_NET_MEDIATEK_SOC_WED
  2260		.net_setup_tc = mt76_wed_net_setup_tc,
> 2261	#elifdef CONFIG_MT7996_NPU

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


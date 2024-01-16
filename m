Return-Path: <linux-wireless+bounces-1961-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DA882E93C
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 06:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7DE1C22873
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 05:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE44B882A;
	Tue, 16 Jan 2024 05:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HyCJkWnB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4D68829
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 05:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705384063; x=1736920063;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cTNJ2VtNUv9ItPJVMIrjgwL3OtP5/4kd0BPES0C2Cv8=;
  b=HyCJkWnBeg83CPM+OTnyBYu0xJPDiZAttZRA2KcJ/9UEwC+h6EnMzDqV
   ukPqpWCQ2Zw8q5LXHo618ynBjCQ0uX59hxCjFcoSWl0YiYPMc4eNgft48
   RFcFBn/+XgdTxj04nZ/u+UyGal++OQasNQnAtgCOrxcr6sO7+UYBSak6p
   EQUIHdzjPGT3ijfaIfgE5C9FVK4iI4UmvcE8GN9RHYvXBGutsXtkm+gPT
   TStj741SLjWi5R84TZeuHLS1fDp5itBxQQybylWMdaJeQkQb3hVN2nNR9
   edu9bFrZmX9dRQzfVB4EFY4r/QrPCttITww5Xblmys/+8cKLQzasmviOU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="13255294"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="13255294"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 21:47:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="854236994"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="854236994"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jan 2024 21:47:40 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPcIT-00005U-20;
	Tue, 16 Jan 2024 05:47:37 +0000
Date: Tue, 16 Jan 2024 13:47:32 +0800
From: kernel test robot <lkp@intel.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: [wireless-next:main 32/56]
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5623:40: sparse:
 sparse: invalid assignment: |=
Message-ID: <202401161318.YtXoCkjU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
head:   ece90a8622320bf5a24d3326da1f8e109891573c
commit: b837f78fbffa5f8e7e7c59879db54793abf161ec [32/56] wifi: rtl8xxxu: add hw crypto support for AP mode
config: riscv-randconfig-r132-20240116 (https://download.01.org/0day-ci/archive/20240116/202401161318.YtXoCkjU-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240116/202401161318.YtXoCkjU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401161318.YtXoCkjU-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5623:40: sparse: sparse: invalid assignment: |=
   drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5623:40: sparse:    left side has type restricted __le32
   drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:5623:40: sparse:    right side has type unsigned long
   drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c: note: in included file (through include/linux/rculist.h, include/linux/pid.h, include/linux/sched.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +5623 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c

  5539	
  5540	static void rtl8xxxu_tx(struct ieee80211_hw *hw,
  5541				struct ieee80211_tx_control *control,
  5542				struct sk_buff *skb)
  5543	{
  5544		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
  5545		struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
  5546		struct rtl8xxxu_priv *priv = hw->priv;
  5547		struct rtl8xxxu_txdesc32 *tx_desc;
  5548		struct rtl8xxxu_tx_urb *tx_urb;
  5549		struct ieee80211_sta *sta = NULL;
  5550		struct ieee80211_vif *vif = tx_info->control.vif;
  5551		struct rtl8xxxu_vif *rtlvif = (struct rtl8xxxu_vif *)vif->drv_priv;
  5552		struct device *dev = &priv->udev->dev;
  5553		u32 queue, rts_rate;
  5554		u16 pktlen = skb->len;
  5555		int tx_desc_size = priv->fops->tx_desc_size;
  5556		u8 macid;
  5557		int ret;
  5558		bool ampdu_enable, sgi = false, short_preamble = false, bmc = false;
  5559	
  5560		if (skb_headroom(skb) < tx_desc_size) {
  5561			dev_warn(dev,
  5562				 "%s: Not enough headroom (%i) for tx descriptor\n",
  5563				 __func__, skb_headroom(skb));
  5564			goto error;
  5565		}
  5566	
  5567		if (unlikely(skb->len > (65535 - tx_desc_size))) {
  5568			dev_warn(dev, "%s: Trying to send over-sized skb (%i)\n",
  5569				 __func__, skb->len);
  5570			goto error;
  5571		}
  5572	
  5573		tx_urb = rtl8xxxu_alloc_tx_urb(priv);
  5574		if (!tx_urb) {
  5575			dev_warn(dev, "%s: Unable to allocate tx urb\n", __func__);
  5576			goto error;
  5577		}
  5578	
  5579		if (ieee80211_is_action(hdr->frame_control))
  5580			rtl8xxxu_dump_action(dev, hdr);
  5581	
  5582		tx_info->rate_driver_data[0] = hw;
  5583	
  5584		if (control && control->sta)
  5585			sta = control->sta;
  5586	
  5587		queue = rtl8xxxu_queue_select(hdr, skb);
  5588	
  5589		tx_desc = skb_push(skb, tx_desc_size);
  5590	
  5591		memset(tx_desc, 0, tx_desc_size);
  5592		tx_desc->pkt_size = cpu_to_le16(pktlen);
  5593		tx_desc->pkt_offset = tx_desc_size;
  5594	
  5595		/* These bits mean different things to the RTL8192F. */
  5596		if (priv->rtl_chip != RTL8192F)
  5597			tx_desc->txdw0 =
  5598				TXDESC_OWN | TXDESC_FIRST_SEGMENT | TXDESC_LAST_SEGMENT;
  5599		if (is_multicast_ether_addr(ieee80211_get_DA(hdr)) ||
  5600		    is_broadcast_ether_addr(ieee80211_get_DA(hdr))) {
  5601			tx_desc->txdw0 |= TXDESC_BROADMULTICAST;
  5602			bmc = true;
  5603		}
  5604	
  5605	
  5606		tx_desc->txdw1 = cpu_to_le32(queue << TXDESC_QUEUE_SHIFT);
  5607		macid = rtl8xxxu_get_macid(priv, sta);
  5608	
  5609		if (tx_info->control.hw_key) {
  5610			switch (tx_info->control.hw_key->cipher) {
  5611			case WLAN_CIPHER_SUITE_WEP40:
  5612			case WLAN_CIPHER_SUITE_WEP104:
  5613			case WLAN_CIPHER_SUITE_TKIP:
  5614				tx_desc->txdw1 |= cpu_to_le32(TXDESC_SEC_RC4);
  5615				break;
  5616			case WLAN_CIPHER_SUITE_CCMP:
  5617				tx_desc->txdw1 |= cpu_to_le32(TXDESC_SEC_AES);
  5618				break;
  5619			default:
  5620				break;
  5621			}
  5622			if (bmc && rtlvif->hw_key_idx != 0xff) {
> 5623				tx_desc->txdw1 |= TXDESC_EN_DESC_ID;
  5624				macid = rtlvif->hw_key_idx;
  5625			}
  5626		}
  5627	
  5628		/* (tx_info->flags & IEEE80211_TX_CTL_AMPDU) && */
  5629		ampdu_enable = false;
  5630		if (ieee80211_is_data_qos(hdr->frame_control) && sta) {
  5631			if (sta->deflink.ht_cap.ht_supported) {
  5632				u32 ampdu, val32;
  5633				u8 *qc = ieee80211_get_qos_ctl(hdr);
  5634				u8 tid = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
  5635	
  5636				ampdu = (u32)sta->deflink.ht_cap.ampdu_density;
  5637				val32 = ampdu << TXDESC_AMPDU_DENSITY_SHIFT;
  5638				tx_desc->txdw2 |= cpu_to_le32(val32);
  5639	
  5640				ampdu_enable = true;
  5641	
  5642				if (!test_bit(tid, priv->tx_aggr_started) &&
  5643				    !(skb->protocol == cpu_to_be16(ETH_P_PAE)))
  5644					if (!ieee80211_start_tx_ba_session(sta, tid, 0))
  5645						set_bit(tid, priv->tx_aggr_started);
  5646			}
  5647		}
  5648	
  5649		if (ieee80211_is_data_qos(hdr->frame_control) &&
  5650		    sta && sta->deflink.ht_cap.cap &
  5651		    (IEEE80211_HT_CAP_SGI_40 | IEEE80211_HT_CAP_SGI_20))
  5652			sgi = true;
  5653	
  5654		if (sta && vif && vif->bss_conf.use_short_preamble)
  5655			short_preamble = true;
  5656	
  5657		if (skb->len > hw->wiphy->rts_threshold)
  5658			tx_info->control.use_rts = true;
  5659	
  5660		if (sta && vif && vif->bss_conf.use_cts_prot)
  5661			tx_info->control.use_cts_prot = true;
  5662	
  5663		if (ampdu_enable || tx_info->control.use_rts ||
  5664		    tx_info->control.use_cts_prot)
  5665			rts_rate = DESC_RATE_24M;
  5666		else
  5667			rts_rate = 0;
  5668	
  5669		priv->fops->fill_txdesc(hw, hdr, tx_info, tx_desc, sgi, short_preamble,
  5670					ampdu_enable, rts_rate, macid);
  5671	
  5672		rtl8xxxu_calc_tx_desc_csum(tx_desc);
  5673	
  5674		/* avoid zero checksum make tx hang */
  5675		if (priv->rtl_chip == RTL8710B || priv->rtl_chip == RTL8192F)
  5676			tx_desc->csum = ~tx_desc->csum;
  5677	
  5678		usb_fill_bulk_urb(&tx_urb->urb, priv->udev, priv->pipe_out[queue],
  5679				  skb->data, skb->len, rtl8xxxu_tx_complete, skb);
  5680	
  5681		usb_anchor_urb(&tx_urb->urb, &priv->tx_anchor);
  5682		ret = usb_submit_urb(&tx_urb->urb, GFP_ATOMIC);
  5683		if (ret) {
  5684			usb_unanchor_urb(&tx_urb->urb);
  5685			rtl8xxxu_free_tx_urb(priv, tx_urb);
  5686			goto error;
  5687		}
  5688		return;
  5689	error:
  5690		dev_kfree_skb(skb);
  5691	}
  5692	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


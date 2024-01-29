Return-Path: <linux-wireless+bounces-2671-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7AF840700
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 14:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343C91C24694
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 13:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1750E634ED;
	Mon, 29 Jan 2024 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sGm8WFmd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mo4bKeki"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A00634F1
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706535180; cv=none; b=Ckx5ZcGVHUgN3/lcGDbyvB7zWc9OD6G3XLTfBD9BnvHy0kt+OSaw8Mhw4Shzx0WutrbWmHBtWzNbLDuj5GsKPawVqlvVdDMSrEtj2osarYsnUdM+foaQwkpLgHprjWC7cmRD1M38z4yXPm+DTd3XfbRXOCqyzh+eTCC9V62Syac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706535180; c=relaxed/simple;
	bh=5NRZQpxNE68NfON9OLhzdXa7bflGR5c5OubAIdfK/r4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZhT62wQjogVEVIH++k17etxdy3gcDdsYnH4orcFtDrClzfE0EimjS++HRMIRc6xhEus/FFEiaUD2Iz19oPKgAtiyG+Ufk64l12gvTsqevTp9O5dY5p0YeHqlw8raERUMjqjGQ3hvsHeIh/ZBg/iZGucjXpLxdw9VjBAxxZ6bLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sGm8WFmd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mo4bKeki; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <fe3303ff-da29-4f64-a1cf-451535fd58bc@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706535175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MoZo6it93dE2wUUYE3XJlDRneDzNKRP5h/ks8gGsRbM=;
	b=sGm8WFmdQ/FugqPgiEMmRA5kJlsz3dKuwTHtiYpwv/2kFTDOaUkQIyWCZd14vBK0Tfa1c4
	zdPPT14YbTAYEanbyzc+40vgdlYgnrS7LRvlsCfqqO7mPg6Tg282c3kjnNnYDSYYRBYfd6
	+GcXwstjZTuqTjVjvA3ipdyfV4TOXiAjb46JXO9ClhaW8tnPeN0/QGsQRl843oRMY9eWdy
	d+Ssg1g91xs6COV8SnICWgNhrUGhOiuUyJOIewR19uUAjMrcNFwP7TndsVMVUG200jRbJa
	BCvlUnFAA/BFageOg0pBVQzaQi29RxG5q5JQLpMCn3CAVLTPY/RmRYkwQbk3lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706535175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MoZo6it93dE2wUUYE3XJlDRneDzNKRP5h/ks8gGsRbM=;
	b=Mo4bKekiOkRHJf7uVDMsuyGDS/GQq9OsYoHavcKI5s4eN92oAA/ibQhn9DXt8gOUNFg9Jc
	fzHbX+PuHLqVByDg==
Date: Mon, 29 Jan 2024 14:32:55 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] wifi: rtl8xxxu: update rate mask per sta
Content-Language: de-DE
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20240124082705.1098960-1-martin.kaistra@linutronix.de>
 <e6011da5e0144d7ea3556d0ec99aa1a0@realtek.com>
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <e6011da5e0144d7ea3556d0ec99aa1a0@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 26.01.24 um 03:41 schrieb Ping-Ke Shih:
> 
> 
>> -----Original Message-----
>> From: Martin Kaistra <martin.kaistra@linutronix.de>
>> Sent: Wednesday, January 24, 2024 4:27 PM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
>> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de>
>> Subject: [PATCH v2] wifi: rtl8xxxu: update rate mask per sta
>>
>> Until now, rtl8xxxu_watchdog_callback() only fetches RSSI and updates
>> the rate mask in station mode. This means, in AP mode only the default
>> rate mask is used.
>>
>> In order to have the rate mask reflect the actual connection quality,
>> extend rtl8xxxu_watchdog_callback() to iterate over every sta. Like in
>> the rtw88 driver, add a function to collect all currently present stas
>> and then iterate over a list of copies to ensure no RCU lock problems
>> for register access via USB. Remove the existing RCU lock in
>> rtl8xxxu_refresh_rate_mask().
>>
>> Since the currently used ieee80211_ave_rssi() is only for 'vif', add
>> driver-level tracking of RSSI per sta.
>>
>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>> ---
>> changes v1->v2: move 'rssi_level' into struct rtl8xxxu_sta_info
>> v1: https://lore.kernel.org/linux-wireless/20240117145516.497966-1-martin.kaistra@linutronix.de/
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index 3b954c2fe448f..3820d3c308759 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -4993,8 +4993,8 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>>          struct device *dev = &priv->udev->dev;
>>          struct ieee80211_sta *sta;
>>          struct rtl8xxxu_ra_report *rarpt;
>> +       u8 val8, macid;
>>          u32 val32;
>> -       u8 val8;
>>
>>          rarpt = &priv->ra_report;
>>
>> @@ -5004,6 +5004,7 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>>                  rtl8xxxu_set_linktype(priv, vif->type, rtlvif->port_num);
>>
>>                  if (vif->cfg.assoc) {
>> +                       struct rtl8xxxu_sta_info *sta_info;
> 
> nit: I remember that declaration at beginning of function is preferred.

I will move it to the beginning of the function.

> 
>>                          u32 ramask;
>>                          int sgi = 0;
>>                          u8 highest_rate;
>> @@ -5017,6 +5018,7 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>>                                  rcu_read_unlock();
>>                                  goto error;
>>                          }
>> +                       macid = rtl8xxxu_get_macid(priv, sta);
>>
>>                          if (sta->deflink.ht_cap.ht_supported)
>>                                  dev_info(dev, "%s: HT supported\n", __func__);
>> @@ -5037,14 +5039,15 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>>                                  bw = RATE_INFO_BW_40;
>>                          else
>>                                  bw = RATE_INFO_BW_20;
>> +
>> +                       sta_info = (struct rtl8xxxu_sta_info *)sta->drv_priv;
>> +                       sta_info->rssi_level = RTL8XXXU_RATR_STA_INIT;
> 
> For AP mode, we should do this as well at rtl8xxxu_sta_add() before calling
> rtl8xxxu_refresh_rate_mask()?

refresh_rate_mask is called from sta_add with force == true, so a new value is 
set there to sta_info->rssi_level regardless of the previous value, but it can't 
hurt to have a proper initialisation.

> 
>>                          rcu_read_unlock();
>>
>>                          rtl8xxxu_update_ra_report(rarpt, highest_rate, sgi, bw);
>>
>> -                       priv->rssi_level = RTL8XXXU_RATR_STA_INIT;
>> -
>>                          priv->fops->update_rate_mask(priv, ramask, 0, sgi,
>> -                                                    bw == RATE_INFO_BW_40, 0);
>> +                                                    bw == RATE_INFO_BW_40, macid);
>>
>>                          rtl8xxxu_write8(priv, REG_BCN_MAX_ERR, 0xff);
>>
>> @@ -6317,6 +6320,76 @@ static void rtl8188e_c2hcmd_callback(struct work_struct *work)
>>          }
>>   }
>>
>> +#define rtl8xxxu_iterate_vifs_atomic(priv, iterator, data)                     \
>> +       ieee80211_iterate_active_interfaces_atomic((priv)->hw,                  \
>> +                       IEEE80211_IFACE_ITER_NORMAL, iterator, data)
>> +
>> +struct rtl8xxxu_rx_addr_match_data {
>> +       struct rtl8xxxu_priv *priv;
>> +       struct ieee80211_hdr *hdr;
>> +       struct ieee80211_rx_status *rx_status;
>> +       u8 *bssid;
>> +};
>> +
>> +static void rtl8xxxu_rx_addr_match_iter(void *data, u8 *mac,
>> +                                       struct ieee80211_vif *vif)
>> +{
>> +       struct rtl8xxxu_rx_addr_match_data *iter_data = data;
>> +       struct ieee80211_sta *sta;
>> +       struct ieee80211_hdr *hdr = iter_data->hdr;
>> +       struct rtl8xxxu_priv *priv = iter_data->priv;
>> +       struct rtl8xxxu_sta_info *sta_info;
>> +       struct ieee80211_rx_status *rx_status = iter_data->rx_status;
>> +       u8 *bssid = iter_data->bssid;
>> +
>> +       if (!ether_addr_equal(vif->bss_conf.bssid, bssid))
>> +               return;
>> +
>> +       if (!(ether_addr_equal(vif->addr, hdr->addr1) ||
>> +             ieee80211_is_beacon(hdr->frame_control)))
>> +               return;
> 
> nit: Here checks bssid, addr1 and beacon frame. For me, if you want to combine
> some of them, would it be reasonable to combine bssid and add1?
Ok, I will do that for v3.

> 
>> +
>> +       sta = ieee80211_find_sta_by_ifaddr(priv->hw, hdr->addr2,
>> +                                          vif->addr);
>> +       if (!sta)
>> +               return;
>> +
>> +       sta_info = (struct rtl8xxxu_sta_info *)sta->drv_priv;
>> +       ewma_rssi_add(&sta_info->avg_rssi, -rx_status->signal);
>> +}
>> +
>> +static inline u8 *get_hdr_bssid(struct ieee80211_hdr *hdr)
> 
> Would you like to add a ieee80211_get_BSSID() to ieee80211.h in separated
> patch? But I wonder if it is enough to check addr1 only?

I just saw that there already is a ieee80211_get_bssid() in net/mac80211/util.c. 
Only problem is that it needs enum nl80211_iftype type as parameter and I 
currently do not have that available in rtl8xxxu_parse_rxdesc16()..

> 
>> +{
>> +       __le16 fc = hdr->frame_control;
>> +       u8 *bssid;
>> +
>> +       if (ieee80211_has_tods(fc))
>> +               bssid = hdr->addr1;
>> +       else if (ieee80211_has_fromds(fc))
>> +               bssid = hdr->addr2;
>> +       else
>> +               bssid = hdr->addr3;
>> +
>> +       return bssid;
>> +}
>> +
>> +static void rtl8xxxu_rx_addr_match(struct rtl8xxxu_priv *priv,
>> +                                  struct ieee80211_rx_status *rx_status,
>> +                                  struct ieee80211_hdr *hdr)
>> +{
>> +       struct rtl8xxxu_rx_addr_match_data data = {};
>> +
>> +       if (ieee80211_is_ctl(hdr->frame_control))
>> +               return;
>> +
>> +       data.priv = priv;
>> +       data.hdr = hdr;
>> +       data.rx_status = rx_status;
>> +       data.bssid = get_hdr_bssid(hdr);
>> +
>> +       rtl8xxxu_iterate_vifs_atomic(priv, rtl8xxxu_rx_addr_match_iter, &data);
>> +}
>> +
>>   int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
>>   {
>>          struct ieee80211_hw *hw = priv->hw;
>> @@ -6376,18 +6449,26 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
>>                          skb_queue_tail(&priv->c2hcmd_queue, skb);
>>                          schedule_work(&priv->c2hcmd_work);
>>                  } else {
>> +                       struct ieee80211_hdr *hdr;
>> +
>>                          phy_stats = (struct rtl8723au_phy_stats *)skb->data;
>>
>>                          skb_pull(skb, drvinfo_sz + desc_shift);
>>
>>                          skb_trim(skb, pkt_len);
>>
>> -                       if (rx_desc->phy_stats)
>> +                       hdr = (struct ieee80211_hdr *)skb->data;
>> +                       if (rx_desc->phy_stats) {
>>                                  priv->fops->parse_phystats(
>>                                          priv, rx_status, phy_stats,
>>                                          rx_desc->rxmcs,
>> -                                       (struct ieee80211_hdr *)skb->data,
>> +                                       hdr,
>>                                          rx_desc->crc32 || rx_desc->icverr);
>> +                               if (!rx_desc->crc32 && !rx_desc->icverr)
>> +                                       rtl8xxxu_rx_addr_match(priv,
>> +                                                              rx_status,
>> +                                                              hdr);
> 
> This function name isn't clear, because it doesn't just match rx addr,
> but it is to update RSSI by rx_status for corresponding station.

Does rtl8xxxu_rx_update_rssi() sound better to you?

> 
>> +                       }
>>
>>                          rx_status->mactime = rx_desc->tsfl;
>>                          rx_status->flag |= RX_FLAG_MACTIME_START;
> 
> [...]
> 



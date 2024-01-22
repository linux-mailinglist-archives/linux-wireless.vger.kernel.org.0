Return-Path: <linux-wireless+bounces-2311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5F1835E2F
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 10:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048FA28105B
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 09:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261E933CF8;
	Mon, 22 Jan 2024 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GgBVG+rw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WHy4QR2t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A7233CF4
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915826; cv=none; b=hwV7RPeZVmPyMClEDvFDo5Lw+7/mwtZELEA2eyR1iZktxdu1TgYXOYmSGcNWsnEZmJzBxJ7AGAPz1zY6HTYudb7XuL12ZBxnd2ufMR7sK1Jhv3NCKxEShsnLASPU6f1VP2y2FRmI1lDfHqYBMmtzp3X+7bh57te/CcdMP0Miz0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915826; c=relaxed/simple;
	bh=qcy8U6Iaqjeh+WCsJ6AV+gMk6WkLxc7wSvFlvxk+0dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XrXtcP/f6g+x1UydKXEgaosvkW092SqffthHkGjzQsUiNn/yTkHlN5r/QnMJrU+qJuIQs0e9rTGKTvkg24n82bSP0PlfMSoxYYp3Ri7n67jvseSiNo0eiGN1f+XAyETw1wWjnuWfOoGI1fhgIDVpqXc78RoIH/eunwayboBbn7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GgBVG+rw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WHy4QR2t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <9aadc704-48ec-4417-82fa-c5f7b19801ff@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705915821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAtwDoFDYba16sV4a5VfCkXzC5gXTdhAVWmoJkQBpTw=;
	b=GgBVG+rwJuG8HTMlBoholMdyUA2LYnLjdIkhWpfkSIWa+cH3vud3q2OrY1LBS2dsLpE56d
	bm6P0xgfZWg40D5l/cWGIlubQTyL/x9sk5pAaOmQ5uzJPAjOgyUD7zYRAN3rlLrl0nDo9x
	5qRE1qo4UaGLSVNCqu8YKGRilvGc/TrVHCIA+Akex7aEoLrcNgelNLZ0sNIVHIJz0h3NaP
	8tLmv8O24XmHM6J1Pxg5TVKfTaOdr0rq96aTi9f3ebKgd6YxCGFrFncDIvoYMG69vQAwRv
	kxLfvTiQYNmeKRZrzzWaXlB1n8qe5MxzgDJJ6/XJGXKBLW62K6DkRQAw4xNkyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705915821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAtwDoFDYba16sV4a5VfCkXzC5gXTdhAVWmoJkQBpTw=;
	b=WHy4QR2tiWSq74NQlcW8jMNPpnT5taoLd+sz0PFsN80L16hz+HwFGUtISY586Jdif/AlzE
	uw5BqrZ3YX1QkxDw==
Date: Mon, 22 Jan 2024 10:30:21 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] wifi: rtl8xxxu: update rate mask per sta
Content-Language: de-DE
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20240117145516.497966-1-martin.kaistra@linutronix.de>
 <4d5f06f2407042f2862af7559ed66eac@realtek.com>
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <4d5f06f2407042f2862af7559ed66eac@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 18.01.24 um 02:37 schrieb Ping-Ke Shih:
> 
> 
>> -----Original Message-----
>> From: Martin Kaistra <martin.kaistra@linutronix.de>
>> Sent: Wednesday, January 17, 2024 10:55 PM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
>> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de>
>> Subject: [PATCH] wifi: rtl8xxxu: update rate mask per sta
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
> 
> [...]
> 
>> @@ -6317,6 +6318,76 @@ static void rtl8188e_c2hcmd_callback(struct work_struct *work)
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
>> +
>> +       sta = ieee80211_find_sta_by_ifaddr(priv->hw, hdr->addr2,
>> +                                          vif->addr);
> 
> Can't we search for 'sta' by rx_desc->mac_id? Then, you don't need a lot of
> code to check address.

I assume, you mean rx_desc->macid? When I try to test this, it looks to me as if 
the assignment of macid to sta in rx does not match the assignment in the driver.
For example, I expect the first connected station to be macid 2, which is also 
sent to the firmware by report_connect, but in rxdesc it is macid 1. Can this 
even be influenced by the driver?


> 
>> +       if (!sta)
>> +               return;
>> +
>> +       sta_info = (struct rtl8xxxu_sta_info *)sta->drv_priv;
>> +       ewma_rssi_add(&sta_info->avg_rssi, -rx_status->signal);
>> +}
>> +
> 
> [...]
> 
>> @@ -7119,7 +7203,7 @@ static void rtl8xxxu_refresh_rate_mask(struct rtl8xxxu_priv *priv,
>>          u8 go_up_gap = 5;
>>          u8 macid = rtl8xxxu_get_macid(priv, sta);
>>
>> -       rssi_level = priv->rssi_level;
>> +       rssi_level = priv->rssi_level[macid];
> 
> Is it possible to move 'rssi_level' into struct rtl8xxxu_sta_info?
> 
>>          snr = rtl8xxxu_signal_to_snr(signal);
>>          snr_thresh_high = RTL8XXXU_SNR_THRESH_HIGH;
>>          snr_thresh_low = RTL8XXXU_SNR_THRESH_LOW;
> 
> [...]
> 
>> @@ -7329,40 +7411,60 @@ static void rtl8xxxu_track_cfo(struct rtl8xxxu_priv *priv)
>>          rtl8xxxu_set_atc_status(priv, abs(cfo_average) >= CFO_TH_ATC);
>>   }
>>
>> -static void rtl8xxxu_watchdog_callback(struct work_struct *work)
>> +static void rtl8xxxu_ra_iter(void *data, struct ieee80211_sta *sta)
>>   {
>> -       struct ieee80211_vif *vif;
>> -       struct rtl8xxxu_priv *priv;
>> -       int i;
>> +       struct rtl8xxxu_sta_info *sta_info = (struct rtl8xxxu_sta_info *)sta->drv_priv;
>> +       struct rtl8xxxu_priv *priv = data;
>> +       int signal = -ewma_rssi_read(&sta_info->avg_rssi);
> 
> The unit conversion of signal is a little complicated --
> from physt to rx_status->signal to sta_info->avg_rssi.
> 
> I think you did it well. Just want to confirm have you checked the final result
> is equal to before at runtime?

Yes, I did a comparison in station mode and the values before and after look 
similar.

> 
> [...]
> 



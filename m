Return-Path: <linux-wireless+bounces-1110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463DD81A584
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 17:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824041C22227
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 16:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F164776B;
	Wed, 20 Dec 2023 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qDi/0H4o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6NJSEVvL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D39C4776A
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <19477f91-4a4e-4ce2-91ca-09ab4f56384a@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703090613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PjEnfeJAx0jR0VMxt9zpWX7D3wXEdg91QboDUMn6ik=;
	b=qDi/0H4oPvxQlTkGqi+2Q+zuaVdSfm05bhw8RffRWZIpuD4xdvzfJijDOI8gmrFLr1b6in
	5lmMCbSF725+BtRBJYTnNvpYhEZxcFt7nMktkTbzYLD8M7wrpeW2oNwnYFvD8C/REXP6xZ
	aTK2TDr+voodeFp8cM6cxKC31f8WseSP3lafFdUNPSl1HL8+gs50r0JHrGf2Ns4yUHVgwh
	dwZjLtCeQecuEH3YPo0uelrGImq+E6wjNmg3UznCWzxn8lmHne0uXbQZQXdUmS8JY4ezVm
	FYg402JXXdid94XuLYRS4lOIDXrL2lgg4eZdj65FzucEe2jPOqfeNc2RhNDAOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703090613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PjEnfeJAx0jR0VMxt9zpWX7D3wXEdg91QboDUMn6ik=;
	b=6NJSEVvLT25zmhzIPacpUasekky1FSLzQ6n7a25rvup9tT+0wqOMdI8gQNTzG15hrz0QOp
	cQW8AydApwgMwSAQ==
Date: Wed, 20 Dec 2023 17:43:33 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 07/20] wifi: rtl8xxxu: extend check for matching bssid to
 both interfaces
Content-Language: de-DE
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
 <20231218143645.433356-8-martin.kaistra@linutronix.de>
 <cddf0a0b59a1425fa0e37743feaaafa4@realtek.com>
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <cddf0a0b59a1425fa0e37743feaaafa4@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 20.12.23 um 06:51 schrieb Ping-Ke Shih:
> 
> 
>> -----Original Message-----
>> From: Martin Kaistra <martin.kaistra@linutronix.de>
>> Sent: Monday, December 18, 2023 10:37 PM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
>> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de>
>> Subject: [PATCH 07/20] wifi: rtl8xxxu: extend check for matching bssid to both interfaces
>>
>> The driver will support two interfaces soon, which both can be in
>> station mode, so extend the check, whether cfo information should be
>> parsed, to cover both interfaces.
>>
>> For better code readability put the lines with priv->vifs[port_num] in a
>> separate function.
>>
>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>> ---
>>   .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 22 ++++++++++++-------
>>   1 file changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index fd6b6e2eba038..c3039049e9f5b 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -5706,6 +5706,16 @@ static void rtl8xxxu_update_beacon_work_callback(struct work_struct *work)
>>          rtl8xxxu_send_beacon_frame(hw, vif);
>>   }
>>
>> +static inline bool rtl8xxxu_is_packet_match_bssid(struct rtl8xxxu_priv *priv,
>> +                                                 struct ieee80211_hdr *hdr,
>> +                                                 int port_num)
>> +{
>> +       return priv->vifs[port_num] &&
>> +               priv->vifs[port_num]->type == NL80211_IFTYPE_STATION &&
>> +               priv->vifs[port_num]->cfg.assoc &&
>> +               ether_addr_equal(priv->vifs[port_num]->bss_conf.bssid, hdr->addr2);
> 
> nit: coding style: align "priv->vifs", like
> 
> return priv->vifs[...]
>         priv->vifs[port_num]....
> 
> 
>> +}
>> +
>>   void rtl8723au_rx_parse_phystats(struct rtl8xxxu_priv *priv,
>>                                   struct ieee80211_rx_status *rx_status,
>>                                   struct rtl8723au_phy_stats *phy_stats,
>> @@ -5722,12 +5732,10 @@ void rtl8723au_rx_parse_phystats(struct rtl8xxxu_priv *priv,
>>                  rx_status->signal = priv->fops->cck_rssi(priv, phy_stats);
>>          } else {
>>                  bool parse_cfo = priv->fops->set_crystal_cap &&
>> -                                priv->vif &&
>> -                                priv->vif->type == NL80211_IFTYPE_STATION &&
>> -                                priv->vif->cfg.assoc &&
>>                                   !crc_icv_err &&
>>                                   !ieee80211_is_ctl(hdr->frame_control) &&
>> -                                ether_addr_equal(priv->vif->bss_conf.bssid, hdr->addr2);
>> +                                (rtl8xxxu_is_packet_match_bssid(priv, hdr, 0) ||
>> +                                 rtl8xxxu_is_packet_match_bssid(priv, hdr, 1));
> 
> I feel that driver can only track single one CFO (carrier frequency offset)
> from AP. Considering STA+STA case with two different APs, it would cause
> ping-pong CFO values between two APs.
> 
> A simple way is just to ignore CFO for STA+STA case. Another way is to
> reference the methods implemented by rtw89 where function name is
> rtw89_phy_multi_sta_cfo_calc(). One method is to record CFO tail for each
> mac_id and use the average as target CFO value to hardware.

This is only a problem, if both interfaces are in STA mode and are actually 
connected, right?
Then, I will add a check and ignore CFO in that case.

> 
> Ping-Ke
> 



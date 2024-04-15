Return-Path: <linux-wireless+bounces-6301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B82F8A485C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 08:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483CC282B1C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 06:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAE91EB30;
	Mon, 15 Apr 2024 06:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FZAhLG0+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fKV6BuLZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302B81DA32
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 06:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163771; cv=none; b=WLh4NXoAkP/35qoNvqldB2GEa80dhFmUUEpeYd11BIKnF0RQ8N7XhgQrvJWlIVp08UzSpicf0vCUu2V1rSDYsRWiueaZNbYwIfZ09OrKd1ewXatmkcNe5zq4R4KZNkQY4tQ5OFnKGTNmlHgE8Vaocenq2bou5qS7K3C68+MrleY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163771; c=relaxed/simple;
	bh=Usw8AWKJMfzExrVBtNpOxxCLsdhnhrxNh0lKn39LnIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azFWObeqN9WHAQMajMNi/1cW/ZTKBxceiagOAiKVUQN/R+j0umapgt+GqZ739kbfFjViwbtii0epDdMY0GvBK6b0Qd+h3ITVLR95HEMdvYnAObBkp+CVKEuQioZ651liNYvt7YYrx+88anFwFFHzVba26AeDraA8OtucYNjn0M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FZAhLG0+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fKV6BuLZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <5b3af47c-7efb-4ca3-93bd-06c682dfc84f@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713163767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8J2qEh2REp/gU9Xr4nan5s84hwy8vd5jlbtrNbdWuv4=;
	b=FZAhLG0+PI1H++VJPLNOyG7y9e4WnNFPOoFaebsbgp6Papd+xE1oBhbKO8YlF4lv+A3X6w
	Golfju5mon5WPhQ7o1Paoqx58WFteV0pfm3d9sflXxlzKSsqL7XlMs0PydK3NvNZQucO8Z
	mBLOLx0EhZP3wKiE0kwSohGGWsoGJUIQnvo80IL3OMFMqbdF6aHo03b2UDegYyxpKeOb9O
	zqDeTCA/kj+Cj/DSxgvAdfI2n5YfhvqsbhjKV/AWffnv2Rq4soy5lTRNV85EsZtPEbGW06
	LF5PY0g2+fKLsELq+EYwlrxZkMuC/uPd8NvzTvh2KSk5crHb8nReqjFhlvgrdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713163767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8J2qEh2REp/gU9Xr4nan5s84hwy8vd5jlbtrNbdWuv4=;
	b=fKV6BuLZC/QV9IiwAVwz7kArsa5P1OqZSsSo7B4L2UCZhPij7WiVA6W/ArQpa0t0tSf/nW
	stedISZ0pqjJd1BQ==
Date: Mon, 15 Apr 2024 08:49:27 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] wifi: rtl8xxxu: enable MFP support
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>, linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20240314164850.86432-1-martin.kaistra@linutronix.de>
 <fa903f58-2362-49a1-9880-2b3fcbe1869e@gmail.com>
Content-Language: de-DE
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <fa903f58-2362-49a1-9880-2b3fcbe1869e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 14.04.24 um 13:32 schrieb Bitterblue Smith:
> On 14/03/2024 18:48, Martin Kaistra wrote:
>> In order to connect to networks which require 802.11w, add the
>> MFP_CAPABLE flag and let mac80211 do the actual crypto in software.
>>
>> When a robust management frames is received, rx_dec->swdec is not set,
>> even though the HW did not decrypt it. Extend the check and don't set
>> RX_FLAG_DECRYPTED for these frames in order to use SW decryption.
>>
>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>> ---
>>   drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index 4a49f8f9d80f2..870bd952f5902 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -6473,7 +6473,9 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
>>   			rx_status->mactime = rx_desc->tsfl;
>>   			rx_status->flag |= RX_FLAG_MACTIME_START;
>>   
>> -			if (!rx_desc->swdec)
>> +			if (!rx_desc->swdec &&
>> +			    !(_ieee80211_is_robust_mgmt_frame(hdr) &&
>> +			      ieee80211_has_protected(hdr->frame_control)))
>>   				rx_status->flag |= RX_FLAG_DECRYPTED;
>>   			if (rx_desc->crc32)
>>   				rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
>> @@ -6578,7 +6580,9 @@ int rtl8xxxu_parse_rxdesc24(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
>>   			rx_status->mactime = rx_desc->tsfl;
>>   			rx_status->flag |= RX_FLAG_MACTIME_START;
>>   
>> -			if (!rx_desc->swdec)
>> +			if (!rx_desc->swdec &&
>> +			    !(_ieee80211_is_robust_mgmt_frame(hdr) &&
>> +			      ieee80211_has_protected(hdr->frame_control)))
>>   				rx_status->flag |= RX_FLAG_DECRYPTED;
>>   			if (rx_desc->crc32)
>>   				rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
>> @@ -7998,6 +8002,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
>>   	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
>>   	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
>>   	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
>> +	ieee80211_hw_set(hw, MFP_CAPABLE);
>>   
>>   	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
>>   
> 
> I ran into this problem recently with rtl8192du:
> https://lore.kernel.org/linux-wireless/ed12ec17-ae6e-45fa-a72f-23e0a34654da@gmail.com/
> 
> Does the same fix work for you in rtl8xxxu? Checking the "security"
> field of the RX descriptor is simpler than calling two functions.
> Sorry to bother you when the patch is already applied.

Thanks for the hint. I tried to do something similar to what has been done in 
other rtlwifi drivers and missed the solution in rtw88, which is probably better:

rtlwifi/rtl8188ee/trx.c
rtlwifi/rtl8192ce/trx.c
rtlwifi/rtl8192ee/trx.c
rtlwifi/rtl8192se/trx.c
rtlwifi/rtl8723ae/trx.c
rtlwifi/rtl8723be/trx.c
rtlwifi/rtl8821ae/trx.c

Shouldn't it be changed in these locations as well?

I will do a test for rtl8xxxu and if it is successful send a new patch.

> 
> Also, won't you send the patch to the stable tree?

The rtl8xxxu driver previously did not have the MFP_CAPABLE flag set. As I am 
adding new functionality (support for WPA3), I don't think this should go to stable.


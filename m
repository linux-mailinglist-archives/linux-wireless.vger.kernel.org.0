Return-Path: <linux-wireless+bounces-6415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7558A7C72
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 08:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1991C20C24
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 06:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA4369DFB;
	Wed, 17 Apr 2024 06:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HQzq+KV2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="231D2Ezm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA16369E00
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 06:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336191; cv=none; b=MOOTrDY6tlb1xxgF2Yl2oRctG0l864ygD6xqsT/xCy3keyV+6QCna5Gwc4WwPoUtFFLsi1MhVbdOcdeDLa+CUymsoQgIEVUdvsv8OpUr9aGChqHXbzQGUI+8PZ24XGLzN/qmcXPu1aInIbrX/kVKhDuWPKxiuHRuWl/qo9en/XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336191; c=relaxed/simple;
	bh=qpXG6c9nKFMFcTDmiwpa1n483isIcGbGV8i2/xh0Nd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAtOCVfu/sBmsFcewznGp4/wcI1r2d4Sl4Mc6Egoxv0f00LDQ7yyheX/Euiv6kA+zEXUZ8dEkQ0oRjk6PC17MFH596wnfL3Q0wH8TMdynZC5ZpkAICbLd/IPxrNzfZntOIe8bgybXIfWwl8ajHFg133xhKNc5sE5MHn3txeCWTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HQzq+KV2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=231D2Ezm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <1e600703-1208-4adb-a486-2a770cff55ed@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713336187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G8uE3hpgLkK5pbQDO1A+Ebli5C3uvi7V2VlAtSxPk4E=;
	b=HQzq+KV2uM85YCM7Bl/hWSKvZmCnF15cXhUksGed8AJ6bqYaqNAXvfLl+YSS7P7ooMdrb+
	V2HAVKjTFbk8asyFE2SQ1gtRdUWqNdvNHwZ0TxSFmxpFrFUVbN1/xdhJRp/DUBZ2Nvawn5
	irnH0inmkIEkjFsPN+jzkw56IoUCAbvN7oM6QFsNAoTr7I9AIvuyZN7OTbIz85cSpBFnmo
	BncVzEHtOz6Qn8pN+HqVhi2uy6GOo+Zm4W/sqQgl0AO3ps3wlYzn6fTCuc+FUAxTsIZiTd
	EjRnfqxgYDnkNyWUA+jqzUW3edXJWhrhyJM+dayi1NC1li18nk2ETydR1em31A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713336187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G8uE3hpgLkK5pbQDO1A+Ebli5C3uvi7V2VlAtSxPk4E=;
	b=231D2EzmJdfgd0/9Jy2Z+57Wx+X65FbQ2/ukUwxK40gUz9qIQiyftlh8w3bSePPuPXUrsD
	cZ3Bsoz21+SF8vCA==
Date: Wed, 17 Apr 2024 08:43:07 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] wifi: rtl8xxxu: enable MFP support
To: linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>
References: <20240314164850.86432-1-martin.kaistra@linutronix.de>
 <fa903f58-2362-49a1-9880-2b3fcbe1869e@gmail.com>
 <5b3af47c-7efb-4ca3-93bd-06c682dfc84f@linutronix.de>
 <1cbb57c2-3d8f-4932-9132-d46a871c944b@gmail.com>
Content-Language: de-DE
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <1cbb57c2-3d8f-4932-9132-d46a871c944b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ping-Ke,

Am 15.04.24 um 21:14 schrieb Bitterblue Smith:
> On 15/04/2024 09:49, Martin Kaistra wrote:
>> Am 14.04.24 um 13:32 schrieb Bitterblue Smith:
>>> On 14/03/2024 18:48, Martin Kaistra wrote:
>>>> In order to connect to networks which require 802.11w, add the
>>>> MFP_CAPABLE flag and let mac80211 do the actual crypto in software.
>>>>
>>>> When a robust management frames is received, rx_dec->swdec is not set,
>>>> even though the HW did not decrypt it. Extend the check and don't set
>>>> RX_FLAG_DECRYPTED for these frames in order to use SW decryption.
>>>>
>>>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>>>> ---
>>>>    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 9 +++++++--
>>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>>> index 4a49f8f9d80f2..870bd952f5902 100644
>>>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>>> @@ -6473,7 +6473,9 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
>>>>                rx_status->mactime = rx_desc->tsfl;
>>>>                rx_status->flag |= RX_FLAG_MACTIME_START;
>>>>    -            if (!rx_desc->swdec)
>>>> +            if (!rx_desc->swdec &&
>>>> +                !(_ieee80211_is_robust_mgmt_frame(hdr) &&
>>>> +                  ieee80211_has_protected(hdr->frame_control)))
>>>>                    rx_status->flag |= RX_FLAG_DECRYPTED;
>>>>                if (rx_desc->crc32)
>>>>                    rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
>>>> @@ -6578,7 +6580,9 @@ int rtl8xxxu_parse_rxdesc24(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
>>>>                rx_status->mactime = rx_desc->tsfl;
>>>>                rx_status->flag |= RX_FLAG_MACTIME_START;
>>>>    -            if (!rx_desc->swdec)
>>>> +            if (!rx_desc->swdec &&
>>>> +                !(_ieee80211_is_robust_mgmt_frame(hdr) &&
>>>> +                  ieee80211_has_protected(hdr->frame_control)))
>>>>                    rx_status->flag |= RX_FLAG_DECRYPTED;
>>>>                if (rx_desc->crc32)
>>>>                    rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
>>>> @@ -7998,6 +8002,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
>>>>        ieee80211_hw_set(hw, HAS_RATE_CONTROL);
>>>>        ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
>>>>        ieee80211_hw_set(hw, AMPDU_AGGREGATION);
>>>> +    ieee80211_hw_set(hw, MFP_CAPABLE);
>>>>          wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
>>>>    
>>>
>>> I ran into this problem recently with rtl8192du:
>>> https://lore.kernel.org/linux-wireless/ed12ec17-ae6e-45fa-a72f-23e0a34654da@gmail.com/
>>>
>>> Does the same fix work for you in rtl8xxxu? Checking the "security"
>>> field of the RX descriptor is simpler than calling two functions.
>>> Sorry to bother you when the patch is already applied.
>>
>> Thanks for the hint. I tried to do something similar to what has been done in other rtlwifi drivers and missed the solution in rtw88, which is probably better:
>>
>> rtlwifi/rtl8188ee/trx.c
>> rtlwifi/rtl8192ce/trx.c
>> rtlwifi/rtl8192ee/trx.c
>> rtlwifi/rtl8192se/trx.c
>> rtlwifi/rtl8723ae/trx.c
>> rtlwifi/rtl8723be/trx.c
>> rtlwifi/rtl8821ae/trx.c
>>
>> Shouldn't it be changed in these locations as well?
>>
>> I will do a test for rtl8xxxu and if it is successful send a new patch.
>>
>>>
>>> Also, won't you send the patch to the stable tree?
>>
>> The rtl8xxxu driver previously did not have the MFP_CAPABLE flag set. As I am adding new functionality (support for WPA3), I don't think this should go to stable.
> 
> Without your patch I can't connect to my phone's hotspot
> when it uses WPA3:
> 
> Apr 08 12:50:57 ideapad2 wpa_supplicant[1231]: nl80211: kernel reports: key setting validation failed
> Apr 08 12:50:57 ideapad2 wpa_supplicant[1231]: wlp3s0f3u2: WPA: Failed to configure IGTK to the driver
> Apr 08 12:50:57 ideapad2 wpa_supplicant[1231]: wlp3s0f3u2: RSN: Failed to configure IGTK
> 
> It doesn't say anything about WPA3 or management frame
> protection, just prints those unhelpful errors and tries
> to connect over and over again. To me that looks more like
> fixing a bug than adding new functionality. It's just sad
> that people need to install kernel 6.10+ in order to support
> WPA3, when the patch is so small.

I would like to know your opinion on this. imho this patch should not go to 
stable and I would therefore propose to just send a patch to improve the checks.
If you as a maintainer however say, you would like to see this in stable, then I 
will send a revert and a new patch.

Martin


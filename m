Return-Path: <linux-wireless+bounces-6340-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA77E8A5A6F
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 21:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F6D6B221D1
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 19:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31DC155A58;
	Mon, 15 Apr 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcwblVde"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208D4205E03
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713208499; cv=none; b=UyXjtLiqYb1uJdIYNZXAwpp/NnJ3MyAFeTNa3BQSeQTALn32iwgb8HvBjuET9M5m13MOgD2yS1Zjs+3Se9xthouuR/B0m70ZjR6bTTz1hXDRLMaaZzJgJoNz6+07hEUzMIMDg+LhPYPdNS3ja9FwQWv2uLAHZFLaE7dQeWjBjsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713208499; c=relaxed/simple;
	bh=qk96wSk7944OaT/WaIwen4O+LnxkaguUAUN+p+nZfEg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kgwmq3mYhID4UAkbEbgby5uFYNeuozlf5yoEQcjWIgvJPOnRYmTsGaIV/p2W9T/ydDUrmlDOA+diuUa24dRFhcxW2Gl7CYSIsQWH8xliMYRraYws/eWVaWtNiWXVH07lW8V00s+/FnNUas3DiD2Jgz9ypbNFlR+dFjMNMZkcUyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcwblVde; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5252e5aa01so299044766b.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 12:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713208496; x=1713813296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xnYYHoJklhAaMVvmsoosRZLEjn/TIbgGX2uDg0fTGFE=;
        b=WcwblVdewj21E10mbCTIWICLdJv3B1gyJ+LxEsAAGwu0CadWYewf5I7eNyAQ2F+QNI
         a0u+LFOps9aZZI4b0ZoUWjcNnR/JEZ9JUPjUuk4TsYfYCk1jD4eyt7EUtUglplt8Kp+7
         u043vG47edONQdci5wSxGNpKrl+F7En4MggmEfF/3BwtaaOopXnkqNyKrgaZZWGWGYfl
         Hs9TWhSmjdse8ysp3q0+c0f8WF3d/eB7c7ZhwgFcA0VcYWPxK+fc6MXm3n9Arn1RqLCD
         TseloBabw1YWxDh3QE4DEmLv3zVvdqw3+hOJBmB65N7nO7Kd8XyEKiHstAlf9A62lD97
         iEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713208496; x=1713813296;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xnYYHoJklhAaMVvmsoosRZLEjn/TIbgGX2uDg0fTGFE=;
        b=f2y/0qJBKENRmc0nW6tbzSuQ7nity0Joqvk9fwsiWUibkYJzk5NBfuIMxcuURKCaDN
         wPp9/MCu0qQi1QycFG+e0Wg5DnDNpx3MlHG5ngUnK1Qn8GszU7Bxl0MQDgkAVCnRWPOH
         IPQawQ5HlaDsCZ3nn8PVTDTjxSyUw3CsVjaxbeqHvlc+FYZowiXN7wOXzCm4eBoFAcr/
         Ol/J2rgQ364q3oj5qOpARFJ11nfN0GH477E8w5TTITPxXPGgwRr5saAel/MR313+HYy/
         q/zuN7g90tzPQgRLZ771aEIgteflYEux1avz/mJuPAzChSM+RrAvSNK4xIr+GMv9K7Gx
         tTbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvvZWD8TJ32bVmlyPyaxRcFUVSbERsILp6TKvSazsD/bEKA1azG7+xRV+iswqsVN/6WgVvreht25WZj7xObS3LAA9ZJy3SQlmjbMMQuew=
X-Gm-Message-State: AOJu0YyN1AX8otJ2Me7ZSpgA5WDf1puC40/FD2g+PncI78aQu80nY/z8
	cCC87SI+fYhvmMJwp5kXh8AMHFlO4r4DRsBpkjogeH1/FgXs0JL+
X-Google-Smtp-Source: AGHT+IEiTmWdTmHKL/otciQJbAw+p7MTFs9OLbPFPwvpYh0hIUBmMVBbIDHRjw9urq5WZQ47BqzGmw==
X-Received: by 2002:a17:906:c113:b0:a52:7015:f8b0 with SMTP id do19-20020a170906c11300b00a527015f8b0mr1928339ejc.30.1713208496074;
        Mon, 15 Apr 2024 12:14:56 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id y24-20020a1709063a9800b00a5268203c85sm1946056ejd.107.2024.04.15.12.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 12:14:55 -0700 (PDT)
Message-ID: <1cbb57c2-3d8f-4932-9132-d46a871c944b@gmail.com>
Date: Mon, 15 Apr 2024 22:14:54 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH] wifi: rtl8xxxu: enable MFP support
To: Martin Kaistra <martin.kaistra@linutronix.de>,
 linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20240314164850.86432-1-martin.kaistra@linutronix.de>
 <fa903f58-2362-49a1-9880-2b3fcbe1869e@gmail.com>
 <5b3af47c-7efb-4ca3-93bd-06c682dfc84f@linutronix.de>
Content-Language: en-US
In-Reply-To: <5b3af47c-7efb-4ca3-93bd-06c682dfc84f@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/04/2024 09:49, Martin Kaistra wrote:
> Am 14.04.24 um 13:32 schrieb Bitterblue Smith:
>> On 14/03/2024 18:48, Martin Kaistra wrote:
>>> In order to connect to networks which require 802.11w, add the
>>> MFP_CAPABLE flag and let mac80211 do the actual crypto in software.
>>>
>>> When a robust management frames is received, rx_dec->swdec is not set,
>>> even though the HW did not decrypt it. Extend the check and don't set
>>> RX_FLAG_DECRYPTED for these frames in order to use SW decryption.
>>>
>>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>>> ---
>>>   drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 9 +++++++--
>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>> index 4a49f8f9d80f2..870bd952f5902 100644
>>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>> @@ -6473,7 +6473,9 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
>>>               rx_status->mactime = rx_desc->tsfl;
>>>               rx_status->flag |= RX_FLAG_MACTIME_START;
>>>   -            if (!rx_desc->swdec)
>>> +            if (!rx_desc->swdec &&
>>> +                !(_ieee80211_is_robust_mgmt_frame(hdr) &&
>>> +                  ieee80211_has_protected(hdr->frame_control)))
>>>                   rx_status->flag |= RX_FLAG_DECRYPTED;
>>>               if (rx_desc->crc32)
>>>                   rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
>>> @@ -6578,7 +6580,9 @@ int rtl8xxxu_parse_rxdesc24(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
>>>               rx_status->mactime = rx_desc->tsfl;
>>>               rx_status->flag |= RX_FLAG_MACTIME_START;
>>>   -            if (!rx_desc->swdec)
>>> +            if (!rx_desc->swdec &&
>>> +                !(_ieee80211_is_robust_mgmt_frame(hdr) &&
>>> +                  ieee80211_has_protected(hdr->frame_control)))
>>>                   rx_status->flag |= RX_FLAG_DECRYPTED;
>>>               if (rx_desc->crc32)
>>>                   rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
>>> @@ -7998,6 +8002,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
>>>       ieee80211_hw_set(hw, HAS_RATE_CONTROL);
>>>       ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
>>>       ieee80211_hw_set(hw, AMPDU_AGGREGATION);
>>> +    ieee80211_hw_set(hw, MFP_CAPABLE);
>>>         wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
>>>   
>>
>> I ran into this problem recently with rtl8192du:
>> https://lore.kernel.org/linux-wireless/ed12ec17-ae6e-45fa-a72f-23e0a34654da@gmail.com/
>>
>> Does the same fix work for you in rtl8xxxu? Checking the "security"
>> field of the RX descriptor is simpler than calling two functions.
>> Sorry to bother you when the patch is already applied.
> 
> Thanks for the hint. I tried to do something similar to what has been done in other rtlwifi drivers and missed the solution in rtw88, which is probably better:
> 
> rtlwifi/rtl8188ee/trx.c
> rtlwifi/rtl8192ce/trx.c
> rtlwifi/rtl8192ee/trx.c
> rtlwifi/rtl8192se/trx.c
> rtlwifi/rtl8723ae/trx.c
> rtlwifi/rtl8723be/trx.c
> rtlwifi/rtl8821ae/trx.c
> 
> Shouldn't it be changed in these locations as well?
> 
> I will do a test for rtl8xxxu and if it is successful send a new patch.
> 
>>
>> Also, won't you send the patch to the stable tree?
> 
> The rtl8xxxu driver previously did not have the MFP_CAPABLE flag set. As I am adding new functionality (support for WPA3), I don't think this should go to stable.

Without your patch I can't connect to my phone's hotspot
when it uses WPA3:

Apr 08 12:50:57 ideapad2 wpa_supplicant[1231]: nl80211: kernel reports: key setting validation failed
Apr 08 12:50:57 ideapad2 wpa_supplicant[1231]: wlp3s0f3u2: WPA: Failed to configure IGTK to the driver
Apr 08 12:50:57 ideapad2 wpa_supplicant[1231]: wlp3s0f3u2: RSN: Failed to configure IGTK

It doesn't say anything about WPA3 or management frame
protection, just prints those unhelpful errors and tries
to connect over and over again. To me that looks more like
fixing a bug than adding new functionality. It's just sad
that people need to install kernel 6.10+ in order to support
WPA3, when the patch is so small.


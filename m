Return-Path: <linux-wireless+bounces-3547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D05853334
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 15:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4E728703A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 14:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F1141C60;
	Tue, 13 Feb 2024 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdgtNPtr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E597C1E51E
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834759; cv=none; b=dSG4z6uoTy7vAkOlUxJ42nM2PxbzSEDWIaWKRnDJ7u23v/GfUS04yig7KKYWfZLCXUTLczjdQuDOMjJJ0jGX959u32CYGzGxz3LqsA4kO5s0mR4MkG7TD7zueLAYCvLpw0ScUPtnuqdPxNH25VhO7HO1SEdIgeQqUXUBXqQaSNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834759; c=relaxed/simple;
	bh=FWQjqAVe6YRa0ILllTEC0nQ2wj2LyvOHfsttFXK599c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=unsz8mXlCrYp3hWWXzCFwp+hR+79PL9DnOyXmHD5Xl82cm7jAni3dn9TaV1ACMCafQ1PRGfwlZlTiyIBV8MMwgwRYk23dkC5xsn5ur7TuzyUjxu+WGsm4Yt77MI+adMKEP62mPx2UaxGAP4rN5R0m4rOE7Qh0VuAryupfPItfJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdgtNPtr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-411ca9dfffdso3331945e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 06:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707834756; x=1708439556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lRrv/rHkzPxcLsvI3ali7lWxLHy99Qq844PqT/KqpB4=;
        b=mdgtNPtrPqHNSFiF9ayueJXTm2A2cDzeFXrJKQhMzCiEJ4tYQJNp8XufQzO4tPTSYU
         yYaMAp8yEryP2O1+ea8wLiLrCF06kzD1kNDvqzkKgVevrHkbu2gJuR8KmLbEHECDbkPY
         0WeIJUrihbWquCfwYTX7KH8SdHCs9b6dhKmDaudQh7R0xt/jG/aTElSI75Fu0PuPexuB
         mFg6uqE40ux4AsrZwhyciPNjr44NVeIEdNPDEWjM8QT8R6KUsUJ50CFdOB6dzRcvzPo0
         pUGPfkXbtEcVPIp7VmtWdXEZWL9eXc0qm8aFuRMAVfD4dJnNwXca9+r34srYw4OuStTE
         4l6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834756; x=1708439556;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lRrv/rHkzPxcLsvI3ali7lWxLHy99Qq844PqT/KqpB4=;
        b=aYgEji/59EiWJvugvlvsjnChvKfoCe0IUhHrGtIMGEYJPl0jsq/1EKw6rH1asgkCPL
         i8vo2Jz1tV8cVO0DgNNZXxWGyn8V6vC8/pVoREj6I21OwOI/+iEmtgSnXdiAStVXxpBd
         62avVxAxr5j+QqZAz3U8gjQ7WXZDGl/GL5rzgOa1ew/1KrR5Px/EgOMMClu7atM+gR0Y
         d1OIc97SyNC8S1CD2mQc4hdZ8Q6N60HUs7x2/NLY/Uim44FsBTWyUpK/jpTyXTo3l5CK
         /sK8QGymYZmFJZkYJbldjnAaLqJzcB3mk9amOZXcMq2oAaIuquttJWMGi+faHffXHmua
         s8bg==
X-Forwarded-Encrypted: i=1; AJvYcCWq4bAamVC2K23NyS5Xdk9QiBcS/ZwVVkU0RyNg8xz8drukUQFMc7hfkSrzq1iFcckXv+Njx++0ytCaaALjQHooAcB6bbJs/2K2jGENVVM=
X-Gm-Message-State: AOJu0YyYQX4EtpkN/b3Bhm5xNp5G7l33MHS6PcH5BoF0Khn29gpPzldF
	A4mzlAgnblfyZSfvNHP+KHtjmzdT0zM13HGahzjWsGjp2twof+W+
X-Google-Smtp-Source: AGHT+IHIYZZ1ZGImuXp+H7AI2tlTMc31XptbS8CsmRm1EN6IF4+96Tw3asgLkR/UuWGgaEhFx4ALIA==
X-Received: by 2002:a05:600c:3491:b0:411:a751:322b with SMTP id a17-20020a05600c349100b00411a751322bmr2565481wmq.18.1707834755948;
        Tue, 13 Feb 2024 06:32:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVxqWGor6BXCDsL4XzClJrSkBKVH0H3Drht1OZ9rjxO7rwbTU+3didrrK6eD5m2StSFj96mk1/woby7IzxaeTVOgxlclE8iy1b1T+uU22k=
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d44cb000000b0033b43a5f53csm9623995wrr.103.2024.02.13.06.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 06:32:35 -0800 (PST)
Message-ID: <62f4c9be-d7a9-45d3-bc29-9901d64ebafe@gmail.com>
Date: Tue, 13 Feb 2024 16:32:34 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH] wifi: rtlwifi: rtl8192cu: Fix TX aggregation
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
References: <651dae37-1911-4dcd-870b-4b60f759ca82@gmail.com>
 <cd687092be44f7fe596f20aa7305c0e4618437ab.camel@realtek.com>
Content-Language: en-US
In-Reply-To: <cd687092be44f7fe596f20aa7305c0e4618437ab.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 14:50, Ping-Ke Shih wrote:
> On Thu, 2024-02-08 at 21:54 +0200, Bitterblue Smith wrote:
>>
>> rtl8192cu is checking rtl_mac.tids when deciding if it should enable
>> aggregation. This is wrong because rtl_mac.tids is not initialised
>> anywhere. Check rtl_sta_info.tids instead, which is initialised.
>>
>> Also, when enabling aggregation also enable RTS. The vendor driver does
>> this, my router does this. It seems like the thing to do.
>>
>> Also also, it seems right to set the AMPDU density only when enabling
>> aggregation.
>>
>> Also also also, delete the unused member rtl_mac.tids and the unused
>> macros RTL_AGG_ON and RTL_AGG_OFF.
>>
>> Naturally, with working AMPDU the download/upload speeds are better.
>> Before: 59/32 Mbps.
>> After:  68/46 Mbps.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  .../wireless/realtek/rtlwifi/rtl8192cu/trx.c  | 27 ++++++++++---------
>>  .../wireless/realtek/rtlwifi/rtl8192cu/trx.h  |  2 --
>>  drivers/net/wireless/realtek/rtlwifi/wifi.h   |  3 ---
>>  3 files changed, 15 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
>> b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
>> index e5c81c1c63c0..cbbd1dab8af0 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
>> @@ -475,8 +475,9 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
>>         struct rtl_priv *rtlpriv = rtl_priv(hw);
>>         struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
>>         struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
>> -       u8 *qc = ieee80211_get_qos_ctl(hdr);
>> -       u8 tid = qc[0] & IEEE80211_QOS_CTL_TID_MASK;
>> +       struct rtl_sta_info *sta_entry;
>> +       u8 agg_state = RTL_AGG_STOP;
>> +       u8 ampdu_density = 0;
>>         u16 seq_number;
>>         __le16 fc = hdr->frame_control;
>>         u8 rate_flag = info->control.rates[0].flags;
>> @@ -498,10 +499,20 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
>>         set_tx_desc_tx_rate(txdesc, tcb_desc->hw_rate);
>>         if (tcb_desc->use_shortgi || tcb_desc->use_shortpreamble)
>>                 set_tx_desc_data_shortgi(txdesc, 1);
>> -       if (mac->tids[tid].agg.agg_state == RTL_AGG_ON &&
>> -                   info->flags & IEEE80211_TX_CTL_AMPDU) {
>> +
>> +       if (sta) {
>> +               sta_entry = (struct rtl_sta_info *)sta->drv_priv;
> 
> nit: It would be better to be separated statement of ieee80211_get_tid(hdr)
> 
> tid = ieee80211_get_tid(hdr);
> agg_state = sta_entry->tids[tid].agg.agg_state;
> 

All right.

> >> +               agg_state = sta_entry->tids[ieee80211_get_tid(hdr)].agg.agg_state;
>> +               ampdu_density = sta->deflink.ht_cap.ampdu_density;
>> +       }
>> +
>> +       if (agg_state == RTL_AGG_OPERATIONAL &&
>> +           info->flags & IEEE80211_TX_CTL_AMPDU) {
>>                 set_tx_desc_agg_enable(txdesc, 1);
>>                 set_tx_desc_max_agg_num(txdesc, 0x14);
> 
> Have you tried larger number of this? 
> As IEEE80211_MAX_AMPDU_BUF_HT is 0x40, set 0x3f here to get higher TX
> throughput if USB speed can afford. 
> 

With this patch, the upload speed is 46 Mbps. But that's just
because my device is detected as 1T2R and it's not allowed to use
rates above MCS7. When I fix that problem the upload speed is 82 Mbps
in the same conditions, about 3 meters from the router.

If I then move the device just 60 cm away, the upload speed is 92
Mbps.

I tried 0x1f now (this field is only 5 bits). The upload speed doesn't
get better. Maybe it gets a bit worse.

> You can reference an equation of rtw89: 
> 
> 	ampdu_num = (u8)((rtwsta->ampdu_params[tid].agg_num ?
> 			  rtwsta->ampdu_params[tid].agg_num :
> 			  4 << sta->deflink.ht_cap.ampdu_factor) - 1);
> 
> This is new for rtlwifi, so we can have this later. 
> 
> 
> [...]
> 
> 
> 



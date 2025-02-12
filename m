Return-Path: <linux-wireless+bounces-18845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 458B9A32855
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 15:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2803A7250
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 14:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300C220FA90;
	Wed, 12 Feb 2025 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4CME8Ev"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6A220FA8F
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739370330; cv=none; b=XmIOvFA2VYoedDFaaST6pMLrYCU32TJbAnXHPlSivCQtP1B4QQDIwEO1hAfcUu4O5KzLnqbETk4cfoo+w8aYADL/EPN9gE+yhDlGi6KgWJXtD7MXdv/eOezuQP4mHVtm1nKVPz98KvE8dflOt+oIIwAXikMUj164wBnd34gXSs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739370330; c=relaxed/simple;
	bh=RJMMloWgcQdUFqDSeKQ2oopBz2j77s3iX0H35AhUc2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NaZMJiGGTOA7InNx3rgDgK+i3Y5NVgVRzy9yxuan34+jNjW77Q6T6zcjWbxwjA4KUhSWNS2t8lTIRiyDM8RDmQ3M/Dw2QAvgF/WAUIAbgDDGg3O2QkrekPt0IaMGEtl4OQmh7HXhFVHdoZn8qdiWzFEjp0ED2AVon87QZM69r14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4CME8Ev; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471a25753a4so17137181cf.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 06:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739370327; x=1739975127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6a2ncZGrEKwYAetWIYfT9wk3W+4dzvqnS2tU96ciDA8=;
        b=I4CME8EvBmIUEdB3myMCVsDs6I8SkMWZ9w3Hbuu+ZriJAJ+99il7EHB3w3cuF9B1ic
         qx50yGPVdJGbZCSUAEmRdiD4/YJPhilBRxxXsTPYrneet3RLK4oUG/MRJuawwzXSfuG4
         /GCBBikv9OtTy104lz0OzwuDUEiBi1bz87cKU0ucFBc7LnH+r6iwQ1wqtv6FZquEe+3p
         iXKvjE97chzO6rIRZVBkwPeW6Tx+wUJKyl5smq83DeBcvUkcA6PTL3/bBjdaaF9QEOIx
         GGTUWB6JEGRJwjYxnFb7/YahzGkV6P4yKKY/sBRKsG2JKIpvbnub+k9F+9N49VcqtUKR
         9y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739370327; x=1739975127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6a2ncZGrEKwYAetWIYfT9wk3W+4dzvqnS2tU96ciDA8=;
        b=EiC8GXLKjsX3aXIP9bH1GwcpcejbDyfjeeu4V6Aj7mS9Van/V60UvLhG2GdDcZ6tE7
         yVXE4Sm+AYUfohg9GPYNX8pEuGrnKHqtlXzp+MwCPezvuDw8yazryujnqj4b973JtJy+
         Z4PAgQXmBqqG4GcWg24BEKu/Z2VQZqvd1a05lpRy2Ow/yK7h4xKlcLjgCiklTSUIf5R/
         Yzp9RGub5yoJd17Ywdg1oJa+0ZSbL+AIEqGzgIdp9FZ1W9Fb0xTOWugKfIC6Fsx6+Pl8
         rf4NDlsnvBbcd/tqYAV7k8IuyfsueTl7q2a37+9FoImjSQI6DiogRS3D++5rEk1Wfqgx
         U4Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUyEgau+K+vxxbHJZTYkayPE/aRL3PWT1KgSblqXWIK+vrSrBJKqPMuhvSHg+ZoPQBJ8Z83iAznxkYKrKmuqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqKdhMqajohBBVKY+ssO1RttBbkWz7l3hU5fNNnPXR/sicuPEt
	PBpnQQPLGfH8P0XNwpvDGmtoc8K0DaUgTH85hxLgt9sjWxt+HpLa
X-Gm-Gg: ASbGncut6mIZzD13ldmLMR8GVPADNFF8HrE4eB3bnrJ05cCKLfrBE14H9jSQgZ68VLE
	qqJmQJOy/xNd35EPIGaeD1clVhtE6xoZPa8fU6YhpOcJ/xTa7ePT3pCJrdXVLdFE8drAj3hMCVf
	QZO0mC9DkVgELmI0rVTZK6p8QO/w28CMB3TEaAP6STliNNO7EBuMW4roM4Rzv/hGXkZe+jQsYfd
	8fz9/6LWYDfTgwjygBc0XaO+6hwUcIx9i5osXha2ci863wCtgm8z046KRGv/ct362V9+lWZEpxD
	aeGrzN11zpnpYLDTMp4=
X-Google-Smtp-Source: AGHT+IHyy2b5dRkkpIlh970tTduoVTKuBakJRPTRZft3Zijmlwtcmb+LBj3FqVU1FaEqFgpZf0ze2Q==
X-Received: by 2002:a05:622a:180e:b0:471:b9e1:6707 with SMTP id d75a77b69052e-471b9e16e0bmr22457801cf.11.1739370327224;
        Wed, 12 Feb 2025 06:25:27 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471793f639bsm54826191cf.35.2025.02.12.06.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 06:25:26 -0800 (PST)
Message-ID: <e570804d-6835-47da-9c4b-5520b4d6daa7@gmail.com>
Date: Wed, 12 Feb 2025 06:25:24 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT] brcmfmac: Fix structure size for WPA3 external SAE
To: KeithG <ys3al35l@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 Ting-Ying Li <tingying.li@cypress.com>,
 Ting-Ying Li <tingying.li@infineon.com>
References: <CAG17S_NqbLogvTWyoYobZ6kOpfXHnScfm4-dB1EqsmpB+q+zxA@mail.gmail.com>
 <20241215120401.238320-1-arend.vanspriel@broadcom.com>
 <69874369-495c-4698-af1f-502d21371f7d@gmail.com>
 <CAG17S_Oh7mjecrSju=CxfB5eSqTGewY5gUYqK3YC-oW4jW5G7g@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_Oh7mjecrSju=CxfB5eSqTGewY5gUYqK3YC-oW4jW5G7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Keith,

On 2/12/25 6:13 AM, KeithG wrote:
> On Wed, Feb 12, 2025 at 7:42 AM James Prestwood <prestwoj@gmail.com> wrote:
>> Hi Arend,
>>
>> On 12/15/24 4:04 AM, Arend van Spriel wrote:
>>> From: Ting-Ying Li <tingying.li@cypress.com>
>>>
>>> Add pmkid parameter in "brcmf_auth_req_status_le" structure to
>>> align the buffer size defined in firmware "wl_auth_req_status"
>>> structure.
>>>
>>> Signed-off-by: Ting-Ying Li <tingying.li@infineon.com>
>>> [arend: adapted path to apply to per-vendor variant]
>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>> ---
>>>    .../net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h    | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
>>> index 18129adb5dc2..1cbe66526d82 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
>>> @@ -54,6 +54,7 @@ struct brcmf_auth_req_status_le {
>>>        u8 peer_mac[ETH_ALEN];
>>>        __le32 ssid_len;
>>>        u8 ssid[IEEE80211_MAX_SSID_LEN];
>>> +     u8 pmkid[WLAN_PMKID_LEN];
>>>    };
>>>
>>>    /**
>>>
>>> base-commit: 1cac3bd863bef434d43e6b0554ac5d7f7f6350fe
>>> prerequisite-patch-id: d5b3eb93d54bd6a0508a91f4627ec3e59a810928
>>> prerequisite-patch-id: 653281e1349a038c7f48b3513243f3211fffab9e
>>> prerequisite-patch-id: 0e47ab711ef159237e20c860834d3ac269b05eb2
>> I've tested this and can also confirm it does fix external auth on
>> brcmfmac. I adapted it to work with the upstream 6.6 raspi kernel and
>> had no issues using IWD + external auth to connect to a WPA3 network. Is
>> this something that can be upstreamed?
>>
>> This is the firmware I'm using (no changes to the default raspi distro):
>>
>> Firmware: BCM4345/6 wl0: Aug 29 2023 01:47:08 version 7.45.265 (28bca26
>> CY) FWID 01-b677b91b
>>
>> Thanks,
>>
>> James
>>
> James,
>
> It is easy to do, but I am starting to get confused. Is this in
> addition to or instead of the patch you posted:
> [RFC] netdev: avoid PMKSA for fullmac drivers
This IWD patch is still needed. I'll poke Denis to merge this.
> Does it invalidate the need for using the latest cypress/infineon firmware:
> Firmware: BCM4345/6 wl0: Oct 28 2024 23:27:00 version 7.45.286
> (be70ab3 CY) FWID 01-95efe7fa
I guess? It just worked for me with this kernel patch and the firmware 
that comes stock with raspbian. I haven't tried the latest cypress FW.
>
> If we can go to a default kernel and the 7.45.265 firmware, and still
> have wpa3, that would simplify things and make us happier.
Its not going to work with the default 6.6 kernel (or likely any 
unpatched kernel). You definitely need the above kernel patch adding the 
pmkid field.
>
> Keith


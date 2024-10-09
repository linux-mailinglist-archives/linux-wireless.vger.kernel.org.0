Return-Path: <linux-wireless+bounces-13750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AC7995DB1
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 04:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678B71F25C02
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 02:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3703617C61;
	Wed,  9 Oct 2024 02:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4bWWsp0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E211136341
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 02:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728440579; cv=none; b=qDTLDV1Izem0Sk4h+nbrj+byKMD6PCKsbQJavP281DB35TW/Bc0ikEgqALs0nAHTYKeoudBXLAEWa7G15nW1UrfSIQd6yp48OYNGezgCXlQLcovspXQmtFZyrwgXkZgacaq1JPrKxC/aBuN3dgZAps3ThE3ZkpsdOslxkJ3HP8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728440579; c=relaxed/simple;
	bh=kpiHyh3ocQeggESZJOLyRPcid9hTPvwHybR3g+joj8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMzvgYCCzfYrP5oVF0748klQhPQCLA3i9I1ssWM+rf2lRlpX5Kg1sRWJljqJvwKuU3a5W45v1y7mkQCf8MPXqHz4prJgqxN89tL9WYWs4x0REpi1Sa1DXGn6/IGlzjUhjL334Gh/+gXlwfBGnY1P7eo2dBEPG8ptN+PuVc2l5og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4bWWsp0; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-7a9a7bea3cfso367712185a.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Oct 2024 19:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728440576; x=1729045376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=weUUuRAoghyBz6FgerXA1YixGamIMNDhvhsUYrGfjKg=;
        b=f4bWWsp08QokGD6yniNmbJZqGow1HkilW9tE4on5NCODBQYZPGAvf4cICaBUyLo+kw
         8JTUQhbfRzXqwT3+I8yOvBE/gxbfsdMfkPJwDbkjkfBciNTPKEWdSFT+p3SgDsnRdvfA
         7f697+sTU+OeO+/1nsRmeYX/JTVZnJCPam04PdZq/1YqyIfDq1M7iVGPbGRAZBmehUGs
         TsgONbIFL1jMLQxnVCSDbqQrFRNq+pdmTwTIy1xcFp/dCUc0pIuY5XRASCh1uxssyuS+
         QQHJsnK/paAFsQTEBa7mojONdiXrHllBAHjTfbO1dTsUlEqyAxOYgAoVYSx2AUZaObS7
         2dHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728440576; x=1729045376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=weUUuRAoghyBz6FgerXA1YixGamIMNDhvhsUYrGfjKg=;
        b=o+GyYWF0nwJkyRMNDsFDOwBzH2jamvtHU9xdvObN182elL5tcVQ9FQlTorVPI7uxCV
         YwwsaOMPTiCOltEKGB6n3Pq8CqgLlkBq0tUEwfTTqY4tgIojHaZE1q0/nuKUBn8Eg6PZ
         buZ7upBfswY5IHuHlbl7dV97oWfsjQej7hKIDHNP9XPxLItLvb0MCKTHGs7BRDz3cqSu
         3C0lncLH8i39Ign6uCBrsHhW9X4G3SC4HupkUY3rIdgOPe9ZGwnB2Ow5ld9KrxHCBvnW
         ww0T5KevJKjO1unRR3IuVYRkreFnApRsJmEUpjmeD4qgqLnJIQGZFtuSIyNg2go04+nC
         jnIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUODK5pninbS5dycZdeFviB4AeOWcC0GiyIr2WDlIxUA/WQl+HjfrI+g8nWZ0mxvVo49eGVHZPoxjWuMizd7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuMutm3/kvZ3cAJLyFlxuHQEBTib+WUj60VTkxFGJMSWW+NoXL
	rkEPAm3xlQ4SPHtZpXHqI1cPJldhO8U6+nHrBI7EcvV/f58ub0BE
X-Google-Smtp-Source: AGHT+IEwxJNvuKRSiqyXP2M2lr4oU40745qAIbLo93EQkHwaH7MNfxd5KNVlwE3LpA96Ps5I4tmMlg==
X-Received: by 2002:a05:620a:410f:b0:7af:ccb5:c8e6 with SMTP id af79cd13be357-7b07953a4bfmr150264285a.18.1728440576377;
        Tue, 08 Oct 2024 19:22:56 -0700 (PDT)
Received: from [10.194.139.248] (mobile-130-126-255-54.near.illinois.edu. [130.126.255.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae756611b5sm414861485a.77.2024.10.08.19.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 19:22:55 -0700 (PDT)
Message-ID: <3262c5dc-42e1-4e02-b77f-d11e9cd3d08b@gmail.com>
Date: Tue, 8 Oct 2024 21:22:54 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] wifi: mt76: Fix NULL Dereference caused by
 mt76_connac_get_he_phy_cap()
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
 shayne.chen@mediatek.com, sean.wang@mediatek.com, kvalo@kernel.org,
 angelogioacchino.delregno@collabora.com, johannes.berg@intel.com,
 quic_adisi@quicinc.com, deren.wu@mediatek.com, chui-hao.chiu@mediatek.com,
 mingyen.hsieh@mediatek.com, howard-yh.hsu@mediatek.com,
 StanleyYP.Wang@mediatek.com, allen.ye@mediatek.com,
 benjamin-jw.lin@mediatek.com, Bo.Jiao@mediatek.com,
 evelyn.tsai@mediatek.com, meichia.chiu@mediatek.com,
 linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, chenyuan0y@gmail.com, zzjas98@gmail.com
References: <20241003180959.12158-1-zichenxie0106@gmail.com>
 <e116a42e-877e-439e-a83d-1afbaf35748b@gmail.com>
 <CANdh5G4mnj-N1gV=O=OiFFrZYFP+nzjte2dZTCAobzBHxSdhpA@mail.gmail.com>
 <7daf8976-91ee-4045-a9a7-d9d14d53c6dd@gmail.com>
Content-Language: en-US
From: Zichen Xie <zichenxie0106@gmail.com>
In-Reply-To: <7daf8976-91ee-4045-a9a7-d9d14d53c6dd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/10/7 14:13, Matthias Brugger wrote:
>
>
> On 07/10/2024 17:36, Zichen Xie wrote:
>> IMHO, using operator "&" for a NULL dereferenced pointer won't cause a
>> crash. 've' will only be assigned to a invalid address.
>>
>
> Please don't top post.
>
>> So we can put off the NULL check after
>> 'const struct ieee80211_he_cap_elem *ve = &vc->he_cap_elem;'
>>
>
> You are right, nevertheless for better code readability I'd still 
> advise to change the code so that vc is checked for NULL before any 
> use of struct vc.

The code snippets here does the same thing like me.

https://elixir.bootlin.com/linux/v6.12-rc2/source/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c#L1547

Should I also repair it for readability?


>
> Regards,
> Matthias
>
>> Best Regards,
>> Zichen
>>
>> On Mon, Oct 7, 2024 at 9:23 AM Matthias Brugger 
>> <matthias.bgg@gmail.com> wrote:
>>>
>>>
>>>
>>> On 03/10/2024 20:09, Gax-c wrote:
>>>> From: Zichen Xie <zichenxie0106@gmail.com>
>>>>
>>>> mt76_connac_get_he_phy_cap() may return a NULL pointer,
>>>> leading to NULL Pointer Dereference.
>>>> Add a NULL check for the returned pointer.
>>>>
>>>> Fixes: a5c372f77aa7 ("wifi: mt76: mt7925: extend 
>>>> mt7925_mcu_bss_he_tlv for per-link BSS")
>>>> Fixes: e6d557a78b60 ("mt76: mt7915: rely on mt76_connac_get_phy 
>>>> utilities")
>>>> Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek 
>>>> Wi-Fi 7 (802.11be) devices")
>>>> Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
>>>> ---
>>>>    drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 5 +++++
>>>>    drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 2 ++
>>>>    drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 2 ++
>>>>    3 files changed, 9 insertions(+)
>>>>
>>>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c 
>>>> b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
>>>> index 87d0dd040001..762be3a37228 100644
>>>> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
>>>> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
>>>> @@ -551,6 +551,8 @@ mt7915_mcu_bss_he_tlv(struct sk_buff *skb, 
>>>> struct ieee80211_vif *vif,
>>>>        struct tlv *tlv;
>>>>
>>>>        cap = mt76_connac_get_he_phy_cap(phy->mt76, vif);
>>>> +     if (!cap)
>>>> +             return;
>>>>
>>>>        tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_HE_BASIC, 
>>>> sizeof(*he));
>>>>
>>>> @@ -1145,6 +1147,9 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta 
>>>> *sta, struct ieee80211_vif *vif,
>>>>        u8 nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
>>>>        u8 snd_dim, sts;
>>>>
>>>> +     if (!vc)
>>>> +             return;
>>>> +
>>>
>>> That will already blow up at line:
>>>           const struct ieee80211_he_cap_elem *ve = &vc->he_cap_elem;
>>>
>>> This needs some more code changes.
>>>
>>> Regards,
>>> Matthias
>>>
>>>>        bf->tx_mode = MT_PHY_TYPE_HE_SU;
>>>>
>>>>        mt7915_mcu_sta_sounding_rate(bf);
>>>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c 
>>>> b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
>>>> index 748ea6adbc6b..55e4cda2f20f 100644
>>>> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
>>>> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
>>>> @@ -2508,6 +2508,8 @@ mt7925_mcu_bss_he_tlv(struct sk_buff *skb, 
>>>> struct ieee80211_bss_conf *link_conf,
>>>>        struct tlv *tlv;
>>>>
>>>>        cap = mt76_connac_get_he_phy_cap(phy->mt76, link_conf->vif);
>>>> +     if (!cap)
>>>> +             return;
>>>>
>>>>        tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_HE_BASIC, 
>>>> sizeof(*he));
>>>>
>>>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c 
>>>> b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
>>>> index 6c445a9dbc03..55bb2d0e67e5 100644
>>>> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
>>>> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
>>>> @@ -798,6 +798,8 @@ mt7996_mcu_bss_he_tlv(struct sk_buff *skb, 
>>>> struct ieee80211_vif *vif,
>>>>        struct tlv *tlv;
>>>>
>>>>        cap = mt76_connac_get_he_phy_cap(phy->mt76, vif);
>>>> +     if (!cap)
>>>> +             return;
>>>>
>>>>        tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_HE_BASIC, 
>>>> sizeof(*he));
>>>>


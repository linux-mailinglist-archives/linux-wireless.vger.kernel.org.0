Return-Path: <linux-wireless+bounces-13640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 560AE993701
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 21:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709351C2107D
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 19:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DF31D9A43;
	Mon,  7 Oct 2024 19:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiko1z93"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E625481727
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728328387; cv=none; b=BPq6+yeztDEKVLnDcZWUyxgZgMe19sJOv7tdNsOVX0P/MiBCtTIDa35d7RTvT2twDksV1sm81DFU9J1WQOEJ0oxUAdDCZrzs+AStX4FtWB29Er19KA4BtsKEopu6Ij/GMoBJfOSEPLMFZls5jKytKhwZFo0QUfO2hY8gGkiKwk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728328387; c=relaxed/simple;
	bh=GlYqa5m9A0VbRn38UBoV9NUWzNSGgvOFDU4WcYs6SVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6sRbq13/2KFbRLsYTuvmoOaaXMKuJ4JtrOKPMahOTkbgdjfv3w8f+u3isZpqQwsE9wWBTV/xTIBGLx2peqTEqUJeX79tiO9fPed81R7qRItKsDAnFD0epF8WIjN1wDyakllB4BbRoEmIduSDaLhpMhXAoJXKMeaY3mhxKW5QxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiko1z93; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so44421645e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 07 Oct 2024 12:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728328384; x=1728933184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ShhT/vHksoduNWzniHlm+epitbFxEPYf5rvVKJrDRZg=;
        b=eiko1z93rXwhEYqNsgYDx6GxipRJbmEHmUv5Jg1J5SZ6M3SqthS1VfRou3kgpE7/mh
         9ibIKTNd7OyIrAbiuLB8t+MD15WEHlyHAhoakHbTey50qd5LqYFKijOkYQG7S3ptC4pU
         7LCmQblMZidYDR1tNsbiJoyfyrkusJhSZMgltnIvdvwe6JjRoaxmf4WfagsjfcU28lxQ
         Rjovp3LZImR6jcY9l3rSSjH3SSIqm/RJHKlEua6veZC0ghLkqwOQWGFjVnVyJWDI78rF
         ignRJJXv/5W50bxA2PgOW6VRu/lPse29lDTwK8/2wAaytbAoRZLQB4QtFDYe94egBhnd
         LtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728328384; x=1728933184;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShhT/vHksoduNWzniHlm+epitbFxEPYf5rvVKJrDRZg=;
        b=mpHdvSdfc86VVdsDfnd+Mv7/86Sw45JVs6bMrcLWee0xFsMIeoc7e5aumux8RPnkRM
         HIxmztzEnayFNB8fyf6ptlnP2//S/FHGBz0fK+8Twqx8VjzixiqPyvLjqke1HW2ZGLTV
         Q0LkKIGYY/B0dYfvjpsDmoPK4wpNt2LPXKfeXhJtZ1pHcdtHzV02cXq23Ga9WU2q+SlX
         7+ZQgfvFVvEBZD6ZlzpIyZfREaqyXHIC5CEFZBByT0zxLl1Ki4t8FgnsozYss/Y9l3Nz
         VCy6zMcqHU2AMjwr6DpK8Ky+8OeEMnUxn5pXfnEktA7fRXVPOHFhbB/m2QOJf4rqd++s
         UfGw==
X-Forwarded-Encrypted: i=1; AJvYcCX5jVz02MHOV6Mdbk9wf5VCL/H9Z9R3R7QUI31yo8rIifDh9tSANvWZn2FTXtmnayMjKe5xbVWMMbgHLscnqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaG9hqOgPFpjxFAgYINLlCt2wmSLyKM94GPIDFjR8d4Lebo88P
	XT9GAKRzB5jyVpR7NaDzgHJuiZTLY3H+DE1yOe9xkSlnYTNUSWJq
X-Google-Smtp-Source: AGHT+IE+zZWZ9qVvcPMEIxBXwOwAzQW9PUjSFwcxs57tiZexsgplWtpYLfCRqA+B4BspmSy/tVKYKA==
X-Received: by 2002:a05:600c:3507:b0:42c:b309:8d18 with SMTP id 5b1f17b1804b1-42f85ac1ff6mr94183895e9.19.1728328383809;
        Mon, 07 Oct 2024 12:13:03 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.162.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f8697f01asm102397365e9.0.2024.10.07.12.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 12:13:02 -0700 (PDT)
Message-ID: <7daf8976-91ee-4045-a9a7-d9d14d53c6dd@gmail.com>
Date: Mon, 7 Oct 2024 21:13:00 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] wifi: mt76: Fix NULL Dereference caused by
 mt76_connac_get_he_phy_cap()
To: Zichen Xie <zichenxie0106@gmail.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
 shayne.chen@mediatek.com, sean.wang@mediatek.com, kvalo@kernel.org,
 angelogioacchino.delregno@collabora.com, johannes.berg@intel.com,
 quic_adisi@quicinc.com, deren.wu@mediatek.com, chui-hao.chiu@mediatek.com,
 mingyen.hsieh@mediatek.com, howard-yh.hsu@mediatek.com,
 StanleyYP.Wang@mediatek.com, allen.ye@mediatek.com,
 benjamin-jw.lin@mediatek.com, Bo.Jiao@mediatek.com,
 evelyn.tsai@mediatek.com, meichia.chiu@mediatek.com, krzk@kernel.org,
 linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, chenyuan0y@gmail.com, zzjas98@gmail.com
References: <20241003180959.12158-1-zichenxie0106@gmail.com>
 <e116a42e-877e-439e-a83d-1afbaf35748b@gmail.com>
 <CANdh5G4mnj-N1gV=O=OiFFrZYFP+nzjte2dZTCAobzBHxSdhpA@mail.gmail.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <CANdh5G4mnj-N1gV=O=OiFFrZYFP+nzjte2dZTCAobzBHxSdhpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/10/2024 17:36, Zichen Xie wrote:
> IMHO, using operator "&" for a NULL dereferenced pointer won't cause a
> crash. 've' will only be assigned to a invalid address.
> 

Please don't top post.

> So we can put off the NULL check after
> 'const struct ieee80211_he_cap_elem *ve = &vc->he_cap_elem;'
> 

You are right, nevertheless for better code readability I'd still advise to 
change the code so that vc is checked for NULL before any use of struct vc.

Regards,
Matthias

> Best Regards,
> Zichen
> 
> On Mon, Oct 7, 2024 at 9:23 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>>
>>
>>
>> On 03/10/2024 20:09, Gax-c wrote:
>>> From: Zichen Xie <zichenxie0106@gmail.com>
>>>
>>> mt76_connac_get_he_phy_cap() may return a NULL pointer,
>>> leading to NULL Pointer Dereference.
>>> Add a NULL check for the returned pointer.
>>>
>>> Fixes: a5c372f77aa7 ("wifi: mt76: mt7925: extend mt7925_mcu_bss_he_tlv for per-link BSS")
>>> Fixes: e6d557a78b60 ("mt76: mt7915: rely on mt76_connac_get_phy utilities")
>>> Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
>>> Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
>>> ---
>>>    drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 5 +++++
>>>    drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 2 ++
>>>    drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 2 ++
>>>    3 files changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
>>> index 87d0dd040001..762be3a37228 100644
>>> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
>>> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
>>> @@ -551,6 +551,8 @@ mt7915_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
>>>        struct tlv *tlv;
>>>
>>>        cap = mt76_connac_get_he_phy_cap(phy->mt76, vif);
>>> +     if (!cap)
>>> +             return;
>>>
>>>        tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_HE_BASIC, sizeof(*he));
>>>
>>> @@ -1145,6 +1147,9 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta, struct ieee80211_vif *vif,
>>>        u8 nss_mcs = mt7915_mcu_get_sta_nss(mcs_map);
>>>        u8 snd_dim, sts;
>>>
>>> +     if (!vc)
>>> +             return;
>>> +
>>
>> That will already blow up at line:
>>           const struct ieee80211_he_cap_elem *ve = &vc->he_cap_elem;
>>
>> This needs some more code changes.
>>
>> Regards,
>> Matthias
>>
>>>        bf->tx_mode = MT_PHY_TYPE_HE_SU;
>>>
>>>        mt7915_mcu_sta_sounding_rate(bf);
>>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
>>> index 748ea6adbc6b..55e4cda2f20f 100644
>>> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
>>> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
>>> @@ -2508,6 +2508,8 @@ mt7925_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_bss_conf *link_conf,
>>>        struct tlv *tlv;
>>>
>>>        cap = mt76_connac_get_he_phy_cap(phy->mt76, link_conf->vif);
>>> +     if (!cap)
>>> +             return;
>>>
>>>        tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_HE_BASIC, sizeof(*he));
>>>
>>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
>>> index 6c445a9dbc03..55bb2d0e67e5 100644
>>> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
>>> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
>>> @@ -798,6 +798,8 @@ mt7996_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
>>>        struct tlv *tlv;
>>>
>>>        cap = mt76_connac_get_he_phy_cap(phy->mt76, vif);
>>> +     if (!cap)
>>> +             return;
>>>
>>>        tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_HE_BASIC, sizeof(*he));
>>>


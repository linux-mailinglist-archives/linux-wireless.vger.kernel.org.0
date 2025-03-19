Return-Path: <linux-wireless+bounces-20582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E258A69BBD
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 23:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504B616A0AE
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 22:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0EA21A434;
	Wed, 19 Mar 2025 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFu+Z6vx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C63213E97
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421782; cv=none; b=B/tIDiJdjvoaCO3sya6t/OOGY0rZQlWqt3zHS+xTgoa4T56vgZ9iH57L2iEcysy3FTK9/b/35Tgv2cDduTjEbp2SrkLZIUGhTWhMkc+hePEvXjhxj5L2HI9cmHql5q526WBt17a0PTsdg0mZIRn4t0Z4O8EIrg+0J9pPxlpUBIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421782; c=relaxed/simple;
	bh=2c286KXkTseFxBY7FxQO88NPSWw5WFg9mOOiTMqatqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eU2RCkNUfGXY5x0H1tSvhfusE0lGXGiJD0VqR5rQj17Z5WcUoTmBFcpl1M7X9VCrqlQdXRU9kG5UByzR6/2GmlAAK8h9keULHsu4PFfCfZ7ULz48m2yTtkeSjL1tYIWTYAXxNHFfBFT69uTSobSsZ+cx5NrNbw86Qxpkdx6aCJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFu+Z6vx; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abf3d64849dso26579666b.3
        for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 15:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742421779; x=1743026579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Hxs4yDZMMw7+63opFO1EZl0VnxUPMQxmPHmoHU6zfM=;
        b=mFu+Z6vxOJHjl+T7sMG+niRoF0AEXtmHRp+lLW3sp0XTM1q5b5J9+F1q4BJajspgOp
         1qbyM2kY8AJlU/AU4ki8cYyLFY4FU5b8syHLPYf+E0KZm6jppRYuAwRZ5TMOMdSd9pww
         aI2NUCC3ldb4UMaOlUIyvc3r7uhu+inVi6DfH9oO/qMSGdAQp310RkVe40kWKIKoOOZt
         ip8LcbxR95UZay1W7l0SMlMDMIUg49bpwwd5gM8Na0ZJ4o8QdIZKAF8ybjIJs7I0n1nS
         6WcetEN3DIyL2bqleZZq4XgEnF2X2tvODP96/NlaUlxxcUkD2RE1HfCP5dnKMTXYXlp+
         QINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421779; x=1743026579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Hxs4yDZMMw7+63opFO1EZl0VnxUPMQxmPHmoHU6zfM=;
        b=EoFOPeyEFH8z4iH+bgBh9uv0bOM1bByo2UmGFlbvFiO3zirRcrgm6GO99bFqG5Jl2D
         r3Y2gA16Xv+d9IocHsG/5waw2f901SuKMBeDC0tk0+N4FO31doZIuIi5clMJ75XsG/wn
         50dTsRYRAe8+oEHupWoL9M+PPKCaSL6Ap7DJ7pjQij2acG/icecmraSf78aSwC8dyQCE
         hsL5kH+BnXdiTUyFnx/XEpptcyWUqPVhlE5EtpjzolECsfXGmyKbjQ+orZ7z83kf22Dx
         rJD0A84dEuHvb2Nqs85EvH6UYFlxWwJnqw0G+RG0n5nD2KQO+pFWUvxQtVZDGqQBE5a4
         eyVg==
X-Forwarded-Encrypted: i=1; AJvYcCUAYuzcUJ0bqW0mUajbs3DxG6So3DCOLRfvupAwaQ0Yld5Mo9CaklVIvJuSln02Y3kfIOzvS3SznC2ZO1lHCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yywt/MnwA4CAlrtr4Kuj3cOGd+fWz1wiQAIXOyednIS3FXWk/kN
	hzi+bi26A+ouZyqRTMLJndmG/OQM822C2S98zf6FrA6sPodzb8BTraXQMQ==
X-Gm-Gg: ASbGncutSbIw8Ityr8xZuKEdHaeea32k38Wr9m+RGVPl+PKwMz4h1llp1L8LaLgqb15
	NK6VtsGmPfFq2tpdkvNILxyXlgYOy5XXYEdsEhv3zk57LddQ83C/h2eK/spwLuHvbH4t+CQ8uql
	Avff2olMmjfnok0rnEF2yrTUde/oSM9cmmmDbS/mgroJJ44HoukBCZvCZU0RexSeLMZx5eZwnA3
	FGDUTkX90tIfROmHKBZ4K2IHyC9Vw2NCW3aZrNdSvRJJ8PMpmGQnXhmsjEDKSZZphzn95e5Cdl8
	zKlSmigivzZ9eQPWyd8km18v/kAXjbNs7dgRCuvtDUl/oKlW1FWmnYF0rXQxXHdE
X-Google-Smtp-Source: AGHT+IGel3lLZlc2GDF7VBZLuiHUuTKFCSrioG3F6/bALpeKJ10kXOC8d701PGkpQlEW1zKEDdOHjg==
X-Received: by 2002:a17:907:d785:b0:abf:e7c1:b3bf with SMTP id a640c23a62f3a-ac3b7a9882dmr616952166b.11.1742421778904;
        Wed, 19 Mar 2025 15:02:58 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314aa6499sm1054741566b.183.2025.03.19.15.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 15:02:57 -0700 (PDT)
Message-ID: <b76818b3-e711-4721-a902-99c557e00a73@gmail.com>
Date: Thu, 20 Mar 2025 00:02:55 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 3/4] wifi: rtw88: Set AMPDU factor to hardware
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <c845ff10-08d9-4057-8f54-1579a548788d@gmail.com>
 <289795d5-49ae-4789-8f14-b2d016843a53@gmail.com>
 <b972a60bb0b04b5f817047027970d896@realtek.com>
 <0ac48cfe-dc7a-442f-b893-41416cd3017d@gmail.com>
 <095328518444426887e039202fa8c609@realtek.com>
 <aa278922-5fac-4f47-acc2-25cc2c133365@gmail.com>
 <95da11e5ec6f43babaedc6dfc25c3cbf@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <95da11e5ec6f43babaedc6dfc25c3cbf@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2025 02:28, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 18/03/2025 04:06, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>> On 17/03/2025 05:01, Ping-Ke Shih wrote:
>>>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>>>>
>>>>>> Tell the chip the maximum AMPDU size supported by the AP. This greatly
>>>>>> improves the TX speed of RTL8814AU in the 2.4 GHz band. Before: ~90
>>>>>> Mbps. After: ~300 Mbps.
>>>>>>
>>>>>> Add this configuration for all the chips, even if it only has an effect
>>>>>> on RTL8814AU in my tests. Surely they all need this.
>>>>>
>>>>> The hardware default value of REG_AMPDU_MAX_LENGTH is 0xffff (unlimited)
>>>>> for most chips. It seems like RTL8812A/RTL8821A are also exceptions, so
>>>>> at power on function they do
>>>>>     rtw_write32(rtwdev, REG_AMPDU_MAX_LENGTH, 0xffffffff);
>>>>>
>>>>> I feel RTL8814A has similar setting, so maybe you can just add similar
>>>>> stuff.
>>>>>
>>>>> By the way, the AMPDU is controlled by TX descriptor basically:
>>>>>       pkt_info->ampdu_factor = ampdu_factor;
>>>>>       pkt_info->ampdu_density = ampdu_density;
>>>>>       pkt_info->ampdu_en = ampdu_en;
>>>>>
>>>>> Since you didn't change this part at all, I still feel setting
>>>>> REG_AMPDU_MAX_LENGTH to 0xffffffff can fix low throughput problem.
>>>>>
>>>>
>>>> I tried 0xffffffff just now and it doesn't work. It's the same with
>>>> both of my routers. They advertise a maximum AMPDU size of 64 K.
>>>> I can't just set it to 0xffff either, because then the upload speed
>>>> in the 5 GHz band suffers a lot. The dual band router advertises a
>>>> maximum AMPDU size of 256 K in the 5 GHz band so it gets a value of
>>>> 0x3ffff.
>>>
>>> Not sure if 0xffffffff is a special value. Since this is a limit of
>>> AMPDU length, you can set a constant large value such as 0x3ffff you
>>> have tested. Is there special case it can't handle?
>>>
>>>
>>
>> 0x3ffff is not good for the 2.4 GHz band. The upload is only ~90 Mbps
>> with both of the routers I tested. Same with 0x1ffff. Only 0xffff
>> works well for them.
> 
> Have you checked the packets in the air? How about their difference?
> Intuitively larger REG_AMPDU_MAX_LENGTH would be better.
> 

I checked today. With 0xffffffff I see 29% retransmission rate. With
0xffff the retransmission rate is only 8.6%.

>>
>> 0xffff is too little for the 5 GHz band. The upload speed is ~200 Mbps
>> less than with 0x3ffff.
>>
>> I guess if you really don't want this patch I can hardcode 0xffff and
>> 0x3ffff in rtw8814a_switch_band(). I just don't know if all access
>> points will be happy with that.
> 
> Initially I wanted to simply this patch, because changing REG_AMPDU_MAX_LENGTH
> for other chips without testing is risky. With your tests, the behavior of
> REG_AMPDU_MAX_LENGTH works not fully expected, so I suspect the risk
> is even higher. 
> 
> Therefore, I would like limit this change to RTL8814A. Though hardcode proposal
> is not sure workable for all AP, we also don't know this patch works for all
> AP. Anyway this proposal is fine to me if we don't have other ideas.
> 
> 
All right, I will limit this only to RTL8814A.


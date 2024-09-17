Return-Path: <linux-wireless+bounces-12912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3231997AEA2
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 12:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A20B30957
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 10:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4A616FF25;
	Tue, 17 Sep 2024 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf6Ng0hY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EF816BE39;
	Tue, 17 Sep 2024 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567695; cv=none; b=AyfwEAlkuoY9CfWNs+COO6eIFCrafkLcwkGQOCHW0QE+qzfyWrVtHVDZkds3LCuSNm6oUAz4X8zsy181059QwkhtR2/WXE8eW62mPGXW9816dTNfyB6tzAZgUI5r0g0GrLrDZENtfzEPbDIlojuJNJeMfLePbJdIByHjF6fNqRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567695; c=relaxed/simple;
	bh=Zjuf7lESNXXXmJ1CBu0nQw9jUXCZZ0Wamegwacai9SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0Jbc0Jxk/xu57kv9C3PUYWH/UOJwGksqCKxi9frn2V5sVqdfGctU/h0ZhE3XeNpJe5HUEaqvwyUzpy419GEvroZJCvj1AiZ2wfB9DoYYZ/WtgMzoykW2ogPIBd1d6KpHYA4ZdQN9WZrkYe7DBMgWbp32poM0JWpLUDdkn+NdiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wf6Ng0hY; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f74e468baeso47200941fa.2;
        Tue, 17 Sep 2024 03:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726567691; x=1727172491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KJbxN/BoBiYWDohSMCRDVcluwineaYIhEPM4cB3crFw=;
        b=Wf6Ng0hY8Lh9ugp+z31YtlOtTQKJBl6XdPm5Wlj5KenDiKH2yC4NO7j1T5W301JlAY
         Q/UuPsZ9jmsSwL8RU9DcGaYSa+dO++Ah0ge5X0CCPxb8QxDz00un43zKJb2/7LV6iesd
         ksoJxf+WdxBjdZaFHSQtNH2gpHqtaOfV9AOvHngSIxLk8V7Y3W5QOMNGDydnWCqzg580
         WmH7FDUgJQhqkkKGWow0qJYdlyew1KG1ArqCEMzeRKkprR4gZVhwzCBjIL4gGYw4g6zZ
         EE6nHA96m4iQ5TS6LQnAZzrvqI3phSQc1806zzeAvD6XsVvp5P1xEB7tEY9O8Nz3ipXN
         ixxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726567691; x=1727172491;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJbxN/BoBiYWDohSMCRDVcluwineaYIhEPM4cB3crFw=;
        b=Bu39V+f3p79U5FcpvWuqTT80//HxBtZ85QcW/9/hTqwBURJ7CV6i5QCC5GD7P99cQf
         7spw8cJ4Zqb5SxBrS7BKVZ+FtjotsedVtV4EB20qBTRpxtLoX7cR2agATswzIOQDwmWP
         JG6gVuHenVv4qlXYUWTgK223G0dPcE4ffZXWzvv40PUV4Av+u/W3GyddK0f/mEFgw6k1
         P8v/uXoZJlmgqaAH3H5V9ksDaTEwvpcsZ5OfAOBTcE4bNdECHGPWJVw5lzjSyslkP64z
         bxkk4SoIRHMl6Sp1xpIwZQTIZfKPh1Bl7X5stgMVak4PYAKG+UMRsMbcaIWzhQrKmQ07
         qBJA==
X-Forwarded-Encrypted: i=1; AJvYcCXBiYBhoAyinoFcmG6QFqPcN3TyqJvqIMzQeZ8vzz+zNAmqG6A/C+DUoSugq5cujO9ump1qN5MpXTVamKqIgnE=@vger.kernel.org, AJvYcCXMIJpZmFdtsb6fOylOsYnMyF2kTrMZiAiDJ6ognDxEy5yrnTBwSf7LDBYFPeI7SndOiWeg7tdrba1qYBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdCLp4PLoFGoC1zNmNfcP/rVjIGooCVifchttSt6flPPbfHaRf
	1rLwOlevwBIiqEILg4PirMwYHIHk2ibW/3jzLHmBkAPlub+P5TSAsCgBz6EP6Ew=
X-Google-Smtp-Source: AGHT+IGiqzBAYFz/mDtE2N5VLwEzMkWQFs36XzIRE4/HfHEtFG+isbnI1S5WWQgrzxd2uMOGc0oGfQ==
X-Received: by 2002:a2e:e11:0:b0:2f7:53b8:ca57 with SMTP id 38308e7fff4ca-2f791a01ef2mr51657271fa.19.1726567690819;
        Tue, 17 Sep 2024 03:08:10 -0700 (PDT)
Received: from [192.168.0.10] ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b1947e2sm135592985e9.44.2024.09.17.03.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 03:08:10 -0700 (PDT)
Message-ID: <5823a50e-c607-4e1c-ba4d-d88b38c734cb@gmail.com>
Date: Tue, 17 Sep 2024 13:08:08 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG and WARNINGs from mt7921s on next-20240916
To: Felix Fietkau <nbd@nbd.name>, Kalle Valo <kvalo@kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, Deren Wu
 <deren.wu@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Ma Ke <make24@iscas.ac.cn>,
 regressions@lists.linux.dev
References: <144fbf79-950c-4cd1-bc68-4e00b47b03e9@gmail.com>
 <ZujCwvd4XiwljDyv@lore-desk> <87ldzqdcsv.fsf@kernel.org>
 <b8e11bbc-c718-4acf-acc0-6b31f25fae27@nbd.name>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Content-Language: en-US, tr, en-GB
In-Reply-To: <b8e11bbc-c718-4acf-acc0-6b31f25fae27@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2024-09-17 12:15 +03:00, Felix Fietkau wrote:
> On 17.09.24 08:17, Kalle Valo wrote:
>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>>
>>>> Hi,
>>>>
>>>> I ran into some bug messages while testing linux-next on a MT8186
>>>> Magneton Chromebook (mt8186-corsola-magneton-sku393218). It boots 
>>>> to the OS, but at least Wi-Fi and Bluetooth are unavailable.
>>>>
>>>> As a start, I tried reverting commit abbd838c579e ("Merge tag 
>>>> 'mt76-for-kvalo-2024-09-06' of https://github.com/nbd168/wireless")
>>>> and it works fine after that. Didn't have time to do a full bisect, 
>>>> but will try if nobody has any immediate opinions.
>>>>
>>>> There are a few traces, here's some select lines to catch your attention,
>>>> not sure how informational they are:
>>>>
>>>> [   16.040525] kernel BUG at net/core/skbuff.c:2268!
>>>> [   16.040531] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>>>> [ 16.040803] CPU: 3 UID: 0 PID: 526 Comm: mt76-sdio-txrx Not tainted
>>>> 6.11.0-next-20240916-deb-00002-g7b544e01c649 #1
>>>> [   16.040897] Call trace:
>>>> [   16.040899]  pskb_expand_head+0x2b0/0x3c0
>>>> [   16.040905]  mt76s_tx_run_queue+0x274/0x410 [mt76_sdio]
>>>> [   16.040909]  mt76s_txrx_worker+0xe4/0xac8 [mt76_sdio]
>>>> [   16.040914]  mt7921s_txrx_worker+0x98/0x1e0 [mt7921s]
>>>> [   16.040924]  __mt76_worker_fn+0x80/0x128 [mt76]
>>>> [   16.040934]  kthread+0xe8/0xf8
>>>> [   16.040940]  ret_from_fork+0x10/0x20
>>>
>>> Hi,
>>>
>>> I guess this issue has been introduced by the following commit:
>>>
>>> commit 3688c18b65aeb2a1f2fde108400afbab129a8cc1
>>> Author: Felix Fietkau <nbd@nbd.name>
>>> Date:   Tue Aug 27 11:30:01 2024 +0200                  
>>>
>>>     wifi: mt76: mt7915: retry mcu messages                                            
>>>                         
>>>     In some cases MCU messages can get lost. Instead of failing completely,
>>>     attempt to recover by re-sending them.
>>>      
>>>     Link: https://patch.msgid.link/20240827093011.18621-14-nbd@nbd.name
>>>     Signed-off-by: Felix Fietkau <nbd@nbd.name>
>>>
>>>
>>> In particular, skb_get() in mt76_mcu_skb_send_and_get_msg() is bumping skb users
>>> refcount (making the skb shared) and pskb_expand_head() (run by __skb_grow() in
>>> mt76s_tx_run_queue()) does not like shared skbs.
>>>
>>> @Felix: any input on it?
> 
> Sorry about that. Please try this patch, it should probably resolve this issue:
> 
> ---
> --- a/drivers/net/wireless/mediatek/mt76/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mcu.c
> @@ -84,13 +84,15 @@ int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *dev, struct sk_buff *skb,
>   	mutex_lock(&dev->mcu.mutex);
>   
>   	if (dev->mcu_ops->mcu_skb_prepare_msg) {
> +		orig_skb = skb;
>   		ret = dev->mcu_ops->mcu_skb_prepare_msg(dev, skb, cmd, &seq);
>   		if (ret < 0)
>   			goto out;
>   	}
>   
>   retry:
> -	orig_skb = skb_get(skb);
> +	if (orig_skb)
> +		skb_get(orig_skb);
>   	ret = dev->mcu_ops->mcu_skb_send_msg(dev, skb, cmd, &seq);
>   	if (ret < 0)
>   		goto out;
> @@ -105,7 +107,7 @@ int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *dev, struct sk_buff *skb,
>   	do {
>   		skb = mt76_mcu_get_response(dev, expires);
>   		if (!skb && !test_bit(MT76_MCU_RESET, &dev->phy.state) &&
> -		    retry++ < dev->mcu_ops->max_retry) {
> +		    orig_skb && retry++ < dev->mcu_ops->max_retry) {
>   			dev_err(dev->dev, "Retry message %08x (seq %d)\n",
>   				cmd, seq);
>   			skb = orig_skb;
> 

Tested-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>

Thanks!


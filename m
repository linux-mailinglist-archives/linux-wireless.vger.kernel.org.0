Return-Path: <linux-wireless+bounces-12910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4987E97AD87
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 11:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AFE1282D35
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 09:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9CC136351;
	Tue, 17 Sep 2024 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMf0b+rA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45B71369B4;
	Tue, 17 Sep 2024 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563922; cv=none; b=E+0MLftb6TdtzET1JN1IiNGIhvD6Q4Er4Gv3zZSBhGGNRTC2esT3IY0N6G0KSZSXAjqrn7Ko+q1HKzyLcW+yJyd3ItNV0LjKQ6n6FPoVEF5PKFt9f3m/GfMNmTfVnqFIOYx8ruslCPfu7qsp9ZcMOEJylOBBXHRKnJlZZaxWnFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563922; c=relaxed/simple;
	bh=OHzIsORNWOnBrIg7XJ7bfKSdglTf2UxbNSnmMm4yDvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J2vpUsql9133+SrcPCE76mxu0wz898mQGatU8am/4sv5SBV/OZGWdoQTDb76yqNQ6vYQgLzt8hxwgvFmQx+0ewE8vFJuJuInLj9wpqBfvZsyoHE1MyFAHVYiaIuF1GwYfiB4RhGvfvuJO2cE6bfzJCMw68YOgJxfkto/Zd+mbIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMf0b+rA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cba0dc922so41478075e9.3;
        Tue, 17 Sep 2024 02:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726563919; x=1727168719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oSrvhSccG4jYV4fFOorkzHAURIRqtMxP8iPHb1jw5uI=;
        b=IMf0b+rAmzO9UzD4N2uuvOcllaheraWHC/27LfcJnLrNVnG2wVEyAqOzy0zg5mUyX4
         IFcly600Vlwy1VsEWORJNGqyTGBWaMtgSBluPk1aRvpsDtN7fxUDRl3g9d0OfcPEcGF5
         sWL8AS6WbmhC+Amrs8Hg9oChZviQ3ZxUAshrmkarmBQA2CkjEHcbW/gaW3kXTXOivpUT
         xtzHf3hFtY7koofeOoNNXlp3QY1gb6p9T9bVye9DX9ZQlj4Hlzp00sFEk5szKiA3qcVt
         SOVQiU2KEood0R3YMSojbAiI1QKnq9Rg4pb6Oj6pKEy48lhyiM0Y4+ylV/jpEh4zZZz2
         Ucuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726563919; x=1727168719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSrvhSccG4jYV4fFOorkzHAURIRqtMxP8iPHb1jw5uI=;
        b=rLeR4PPkBRIV5D1A3yqdcfiELHmYnSozRI3KADRuh9F+kiaoQOs1ZVPKYl668hJEqe
         IzIXw7uDkjn2i+enmqTs8VymO8zOw21Xu3/+doaUka3fgpUqvJ2x+yczqDNK47TfBExF
         hEiNnSOwWgTGImJ1z4/NVTH0reKwserjrumRVy37aOV1L4hVhA5dYOi27Y7eoz2UN7a1
         DWY+HQQhIbgNUJxt1uAb5VnDJusWc+OsGhLa+BG2BOAwpYcBeY1UpjA2cp8eC71P5Fuu
         YLkRjOL8GdOm29n/yFVpdXo2wHwl702jVhWoztfE5tLcvu6w5fjX5UJJJI07gdlazlob
         qtWw==
X-Forwarded-Encrypted: i=1; AJvYcCU64Ffs7cSDfTTtHzHnpYAF2zWKBOR/f0wxfUUIz7Pu36D9YkJAEQLK1X4X6G8oxJaweBesWGekp0u9JlQ=@vger.kernel.org, AJvYcCW8IEU94ZztfoLrmKNVB+esBkXnsLdHwXoRSSXohBF7L4AkKvHmhw7XCbc1sXGLORem1oXkK7NcBHM4ZFti+ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj6n8ERzOVUlQv0xJJtGakglwYJ0nRMwkgfvJLjdUcjwjv0lwQ
	9PlswMwiJwIlEyRYVQ3jhDtXOEBW9RSJZJv0QH6IIinj6Olobyfi
X-Google-Smtp-Source: AGHT+IFU3P3MQf5VTEuLKF85MQML6XIcvLrFQezS4OKNLvV1EMyIBYelPAYYhEKEIx215+fARri8Bg==
X-Received: by 2002:a05:600c:4fc8:b0:427:ff3b:7a20 with SMTP id 5b1f17b1804b1-42cdb56714bmr108943345e9.27.1726563918916;
        Tue, 17 Sep 2024 02:05:18 -0700 (PDT)
Received: from [192.168.0.10] ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b15d3ebsm130744695e9.28.2024.09.17.02.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 02:05:18 -0700 (PDT)
Message-ID: <5a0a8892-c88e-4cac-a53c-a31385217235@gmail.com>
Date: Tue, 17 Sep 2024 12:05:15 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG and WARNINGs from mt7921s on next-20240916
To: Kalle Valo <kvalo@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Felix Fietkau <nbd@nbd.name>
Cc: linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, Deren Wu
 <deren.wu@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Ma Ke <make24@iscas.ac.cn>,
 regressions@lists.linux.dev, =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?=
 <nfraprado@collabora.com>
References: <144fbf79-950c-4cd1-bc68-4e00b47b03e9@gmail.com>
 <ZujCwvd4XiwljDyv@lore-desk> <87ldzqdcsv.fsf@kernel.org>
Content-Language: en-US, tr, en-GB
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <87ldzqdcsv.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 2024-09-17 09:17 +03:00, Kalle Valo wrote:
> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> 
>>> Hi,
>>>
>>> I ran into some bug messages while testing linux-next on a MT8186
>>> Magneton Chromebook (mt8186-corsola-magneton-sku393218). It boots 
>>> to the OS, but at least Wi-Fi and Bluetooth are unavailable.
>>>
>>> As a start, I tried reverting commit abbd838c579e ("Merge tag 
>>> 'mt76-for-kvalo-2024-09-06' of https://github.com/nbd168/wireless")
>>> and it works fine after that. Didn't have time to do a full bisect, 
>>> but will try if nobody has any immediate opinions.
>>>
>>> There are a few traces, here's some select lines to catch your attention,
>>> not sure how informational they are:
>>>
>>> [   16.040525] kernel BUG at net/core/skbuff.c:2268!
>>> [   16.040531] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>>> [ 16.040803] CPU: 3 UID: 0 PID: 526 Comm: mt76-sdio-txrx Not tainted
>>> 6.11.0-next-20240916-deb-00002-g7b544e01c649 #1
>>> [   16.040897] Call trace:
>>> [   16.040899]  pskb_expand_head+0x2b0/0x3c0
>>> [   16.040905]  mt76s_tx_run_queue+0x274/0x410 [mt76_sdio]
>>> [   16.040909]  mt76s_txrx_worker+0xe4/0xac8 [mt76_sdio]
>>> [   16.040914]  mt7921s_txrx_worker+0x98/0x1e0 [mt7921s]
>>> [   16.040924]  __mt76_worker_fn+0x80/0x128 [mt76]
>>> [   16.040934]  kthread+0xe8/0xf8
>>> [   16.040940]  ret_from_fork+0x10/0x20
>>
>> Hi,
>>
>> I guess this issue has been introduced by the following commit:
>>
>> commit 3688c18b65aeb2a1f2fde108400afbab129a8cc1
>> Author: Felix Fietkau <nbd@nbd.name>
>> Date:   Tue Aug 27 11:30:01 2024 +0200                  
>>
>>     wifi: mt76: mt7915: retry mcu messages                                            
>>                         
>>     In some cases MCU messages can get lost. Instead of failing completely,
>>     attempt to recover by re-sending them.
>>      
>>     Link: https://patch.msgid.link/20240827093011.18621-14-nbd@nbd.name
>>     Signed-off-by: Felix Fietkau <nbd@nbd.name>
>>
>>
>> In particular, skb_get() in mt76_mcu_skb_send_and_get_msg() is bumping skb users
>> refcount (making the skb shared) and pskb_expand_head() (run by __skb_grow() in
>> mt76s_tx_run_queue()) does not like shared skbs.
>>
>> @Felix: any input on it?
> 
> Adding regressions list to Cc.

Reverting just that commit fixes my issue. Looks like it's the same
issue recently reported by kernelci as a reply to that patch [1].

[1] https://lore.kernel.org/all/d907b13a-f8be-4cb8-a0bb-560a21278041@notapiano/

Adding Cc: Nícolas F. R. A. Prado <nfraprado@collabora.com> per above.


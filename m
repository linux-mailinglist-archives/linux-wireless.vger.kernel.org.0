Return-Path: <linux-wireless+bounces-13061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCC197D709
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 16:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0AC51C216B1
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 14:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3B013B2B0;
	Fri, 20 Sep 2024 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy5FQ45u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D9017B50B
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726843466; cv=none; b=WbFqdUXLIb+GvXbYqZ4A+zOC/r7tZQGnd04lzWvr5uK9W7qDI53xwJvkXIzOdDdbptDFEouoIzo0cSVbMIhOS83QR7IqXjzJRwCUFVK8v8EM23sWjMLIOqgZadLjRaeJ7JkZAfdJH6qGEVIVNzOwz9nGz/nRWuBj3ITREOlskPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726843466; c=relaxed/simple;
	bh=vypZ7iiUvj/q5IPLAs8YaRFxdVgfGJmnWkgXLiVlalY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewV4gy9skmG1Vv0ZUnTQMgqrsxSsGTt6smPiA9VjRcijxJDIO0IeT0ICqOKLPfrUb/GJITkayKAVOWCtcqDJDbcPbrSfRBqyhpAe+yorC/U4lCuzcBRlW5vsE8Mi6JlSiMDme1d2EnLeaQ5jsbemtbG11vNGuDQ1A6duA4CrTWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dy5FQ45u; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso366370666b.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726843462; x=1727448262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dS5EeUZRh2L5ydcLjm1ei/RImAqUMtMfi74Y09oS2HU=;
        b=dy5FQ45uz9Om/2Bvq3N+b9J2l8LuGSCsGM8WEkwjTK6TAoGFTepCsmGV7di7lCMgW9
         PZGaEbOm6zd8tWPftmcbkHY02VJPviqbrjTMmPNwRaOMqPEnh1kW1DiWwg8H9ETUA6UI
         Oa6NfHo3wwnyF87YSPYATNEq2l3d6RNG6R2EqqYzjLDzFTiSgb05pRuL7g+k/I2lXTCs
         EYI++7ahj9lUYxxFR9TmIp4EVGfycIMK28m4YC0wRaRB9Ba4upVTlEUeAnqnTN6jbAUy
         GtIATH3vtIzoIYePLLPp1kOl4tksuLpuTLjGOfghOaq4kmWluvNXB/WCFzyq/SZR/p/v
         XX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726843462; x=1727448262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dS5EeUZRh2L5ydcLjm1ei/RImAqUMtMfi74Y09oS2HU=;
        b=QPoWqZx5yBQ9Te9yhrMprSFug+se6han098QbnO1c6Cs5q0XKrVF1xtnbYXDnQcU0+
         tUHQrynE5pV5NiP5V7WQChBoUW2I35P+kbvT6rgVnKv4vH+kA1y2bY+VyrOdExXIwXl0
         wx4rGkNHUj1N92lmGUgsYz+bOVnCdB5bMAxYSkaeLwjOX1JZTQ6jQw73bjNDcASvL9CS
         wdFNMnC7cQ/6VrWHk/jNuVEbuqFJzB/HBmuB2uaPsENaGliGZ+EGPdsDYIcRHWpsD8aB
         bjUz3dZGZ9oU59a1kbShAO+y689WEDUEirzkEun8mX28cIDe0+lnRMTxXLNTX7ziB4Gx
         b+1w==
X-Forwarded-Encrypted: i=1; AJvYcCUo/nc4DmOG5cFygtOHbnfqgkRJzqeG1HdYAG5sNaYIr7Ox6Fak6BtVpZSZxe3Bq6voJXtz+lsl65LxpusifA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Rr6g+9YRTkZ4FUBwPMWXj0qRuuPwbJDwJ7oYptMo9GKgJ6hy
	9TiegilPEPH8Y3bqQzJ+zUVgQJx1XcidE/kiSWtQ1Eysx5oxds/A
X-Google-Smtp-Source: AGHT+IHZURHGQdQzbQ5zilYAA2CJ/wXGkm6kmsnVXh+9yyheH+47ZQeFk+7y8mcq0nQQxP3EqfkbVQ==
X-Received: by 2002:a17:907:9408:b0:a8d:498f:640 with SMTP id a640c23a62f3a-a90c1d6ec4dmr726508166b.21.1726843462225;
        Fri, 20 Sep 2024 07:44:22 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f4400sm858188466b.84.2024.09.20.07.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 07:44:21 -0700 (PDT)
Message-ID: <e932ece0-d8b3-442f-a861-c6f42e1610c7@gmail.com>
Date: Fri, 20 Sep 2024 17:44:20 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] wifi: rtw88: use ieee80211_purge_tx_queue() to
 purge TX skb
To: Ping-Ke Shih <pkshih@realtek.com>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "pbrobinson@gmail.com" <pbrobinson@gmail.com>
References: <20240822014255.10211-1-pkshih@realtek.com>
 <20240822014255.10211-2-pkshih@realtek.com>
 <c0f73bb2-45e7-4caf-b9e5-21ee064635bf@RTEXMBS04.realtek.com.tw>
 <6725980b-adbc-4f2e-a3a8-b03b5c0aab3a@gmail.com>
 <857b5b8036134b50bed5c2a0455f7c03@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <857b5b8036134b50bed5c2a0455f7c03@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/09/2024 16:11, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 20/09/2024 09:33, Ping-Ke Shih wrote:
>>> Ping-Ke Shih <pkshih@realtek.com> wrote:
>>>
>>>> When removing kernel modules by:
>>>>    rmmod rtw88_8723cs rtw88_8703b rtw88_8723x rtw88_sdio rtw88_core
>>>>
>>>> Driver uses skb_queue_purge() to purge TX skb, but not report tx status
>>>> causing "Have pending ack frames!" warning. Use ieee80211_purge_tx_queue()
>>>> to correct this.
>>>>
>>>> Since ieee80211_purge_tx_queue() doesn't take locks, to prevent racing
>>>> between TX work and purge TX queue, flush and destroy TX work in advance.
>>>>
>>>>    wlan0: deauthenticating from aa:f5:fd:60:4c:a8 by local
>>>>      choice (Reason: 3=DEAUTH_LEAVING)
>>>>    ------------[ cut here ]------------
>>>>    Have pending ack frames!
>>>>    WARNING: CPU: 3 PID: 9232 at net/mac80211/main.c:1691
>>>>        ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
>>>>    CPU: 3 PID: 9232 Comm: rmmod Tainted: G         C
>>>>        6.10.1-200.fc40.aarch64 #1
>>>>    Hardware name: pine64 Pine64 PinePhone Braveheart
>>>>       (1.1)/Pine64 PinePhone Braveheart (1.1), BIOS 2024.01 01/01/2024
>>>>    pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>>    pc : ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
>>>>    lr : ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
>>>>    sp : ffff80008c1b37b0
>>>>    x29: ffff80008c1b37b0 x28: ffff000003be8000 x27: 0000000000000000
>>>>    x26: 0000000000000000 x25: ffff000003dc14b8 x24: ffff80008c1b37d0
>>>>    x23: ffff000000ff9f80 x22: 0000000000000000 x21: 000000007fffffff
>>>>    x20: ffff80007c7e93d8 x19: ffff00006e66f400 x18: 0000000000000000
>>>>    x17: ffff7ffffd2b3000 x16: ffff800083fc0000 x15: 0000000000000000
>>>>    x14: 0000000000000000 x13: 2173656d61726620 x12: 6b636120676e6964
>>>>    x11: 0000000000000000 x10: 000000000000005d x9 : ffff8000802af2b0
>>>>    x8 : ffff80008c1b3430 x7 : 0000000000000001 x6 : 0000000000000001
>>>>    x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
>>>>    x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000003be8000
>>>>    Call trace:
>>>>     ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
>>>>     idr_for_each+0x74/0x110
>>>>     ieee80211_free_hw+0x44/0xe8 [mac80211]
>>>>     rtw_sdio_remove+0x9c/0xc0 [rtw88_sdio]
>>>>     sdio_bus_remove+0x44/0x180
>>>>     device_remove+0x54/0x90
>>>>     device_release_driver_internal+0x1d4/0x238
>>>>     driver_detach+0x54/0xc0
>>>>     bus_remove_driver+0x78/0x108
>>>>     driver_unregister+0x38/0x78
>>>>     sdio_unregister_driver+0x2c/0x40
>>>>     rtw_8723cs_driver_exit+0x18/0x1000 [rtw88_8723cs]
>>>>     __do_sys_delete_module.isra.0+0x190/0x338
>>>>     __arm64_sys_delete_module+0x1c/0x30
>>>>     invoke_syscall+0x74/0x100
>>>>     el0_svc_common.constprop.0+0x48/0xf0
>>>>     do_el0_svc+0x24/0x38
>>>>     el0_svc+0x3c/0x158
>>>>     el0t_64_sync_handler+0x120/0x138
>>>>     el0t_64_sync+0x194/0x198
>>>>    ---[ end trace 0000000000000000 ]---
>>>>
>>>> Reported-by: Peter Robinson <pbrobinson@gmail.com>
>>>> Closes: https://lore.kernel.org/linux-wireless/CALeDE9OAa56KMzgknaCD3quOgYuEHFx9_hcT=OFgmMAb+8MPyA@mail.gmail.com/
>>>> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>>>> Tested-by: Ping-Ke Shih <pkshih@realtek.com> # 8723DU
>>>
>>> 1 patch(es) applied to rtw-next branch of rtw.git, thanks.
>>>
>>> 3e5e4a801aaf wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb
>>>
>>> ---
>>> https://github.com/pkshih/rtw.git
>>>
>>>
>>
>> A small problem: patch 1/2 is not applied yet:
>>
>> linux/drivers/net/wireless/realtek/rtw88/usb.c:430:17: error: implicit declaration of function ‘ieee80211_purge_tx_queue’; did you mean ‘ieee80211_wake_queue’? [-Wimplicit-function-declaration]
>>   430 |                 ieee80211_purge_tx_queue(rtwdev->hw, &rtwusb->tx_queue[i]);
>>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~
>>       |                 ieee80211_wake_queue
>>
> 
> Patch 1/2 is merged [1]. Have you update kernel from rtw tree?
> 
> [1] 53bc1b73b678 ("wifi: mac80211: export ieee80211_purge_tx_queue() for drivers")
> 
> 

Oh, right. This is what happens when I try to compile just rtw88.
I didn't see an email from Johannes or Kalle saying the patch was
applied, so I assumed it wasn't. Sorry about that.


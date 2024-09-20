Return-Path: <linux-wireless+bounces-13056-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777D297D5E8
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 14:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1BABB236FE
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 12:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7731A166F00;
	Fri, 20 Sep 2024 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFJWmf0i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AABD168C3F
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726837101; cv=none; b=UldEORxFSZhMkXQcA7nweErChREAVP7txlLVGrbTLMXCc33IPaQhl7IBn0xUXR0qODS8iA90/pbM9y+sKPzotLtQLbu9XDIAtXKoOx/fT5Jh7WBLK8xuJK2YZhuwzv9sh+EnmHtZLUKFURoDKtmdoYwnmhcTYzH8B+Rjc4xLXbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726837101; c=relaxed/simple;
	bh=bDTji/8BxGdNsR/D13MW+0fTjsNIhGWfUNiLa263RRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lf1PAvdd9fNCEiiFBlVfj9PxGW1cF1Nq8qnsGE372DcvobLWs4WC3bv4N+VXJQqtkJmqNBCr4jmek9ltBerDoWCnpyjnt8s3qNdvjqoox0KpcnIQHN64WYK/A9dQJxwJDa8/D7VsxfaJHPV+hn/E9HFmaZ5QFQRCx6KCDMAUO/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFJWmf0i; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c26311c6f0so2606998a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 05:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726837098; x=1727441898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GR2cbI7CTyrBgSPJ+AWdxR3dpGiE88y0DtU504tPchI=;
        b=bFJWmf0i418LljvferQqRIoTKvW7v45SxJ8wVGYt3LWLf3T7Exc8tKGtNmbR9lWGf7
         jQd5EVWu98y0kvYPUy2HUcWLdgGBdjAWhCzHm/IIY8MWTfbKsm6AKo+BCK+eYoJEcgcJ
         dpRxVO3L02yKRGBFpZD9vJ3Qgc5zvCYrtNit3XB6JJLcmD28KdvstexwCbGBz78PUOSe
         E7KuPwGakqqPOryws5U1VdFq1eJm9GU49R7EEktES+qiC1OhS8et1w9PYXjzmje1YqZH
         wlTjewQvUJZHeMpalpxO++Tb9r62rYPPGvcksc2/WAs5E3WN8Kcq68R+sbvYhv8/PCre
         JndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726837098; x=1727441898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GR2cbI7CTyrBgSPJ+AWdxR3dpGiE88y0DtU504tPchI=;
        b=v09QiuIfXSkzi1sCBhkfxvV1cxPIkos0TALxcSuGeytSviHthk6qk+fnQfa6724EEX
         MV6ApuKBboVjYXb7vtaug6BmCADHBGlc9Cy3XUIGcIdRe7P+76V4sjlQa7/FchbHQnFM
         Fm1mQ3ik3y/I7a5T2LL7dXug8pKAefxPGXTfSP5Vx4a7T7C8+zYSL8JxFI4gFqt0iyoj
         /LQbh6Y3+0BvVb5u0JLSg+uMZ0bUyRtG3xeI4EAtKy9gV9OvwPQa1NchI2oIxGY5SeK8
         ExITqsVLDs0Cn1EAlNvh8vl5WaczqBxHtbmijBlH2dX7tAOsT6ZIze+4+OZqSu2uHVcl
         /8qA==
X-Forwarded-Encrypted: i=1; AJvYcCVTw+XTay7h1qH74X9FCYUhtfC1mjAG0Xmks1zTQ8gfQVf22xYOx5qqX/yg14+zj3ROG9AQgY4JZhdquuU6cQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzavgN/WIVbI/IdM8I0Gwq/GqNBYfTKV14Wsqno80/LuSj+yYtU
	gbyvXBIcuWqsTjwrW69iA+WDNLHoc1ioikRjPRlDkCAfg/xoKS4C
X-Google-Smtp-Source: AGHT+IH3ymd+pun5mFyhcvBFMQFb5DFdQJglDwr39S8OU6rCqsSjVBAjV15flIjmiFE8eeAQKjvvDg==
X-Received: by 2002:a05:6402:1e8b:b0:5a2:5bd2:ca50 with SMTP id 4fb4d7f45d1cf-5c464a5ad55mr2350707a12.25.1726837097558;
        Fri, 20 Sep 2024 05:58:17 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb495b3sm7111800a12.20.2024.09.20.05.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 05:58:17 -0700 (PDT)
Message-ID: <6725980b-adbc-4f2e-a3a8-b03b5c0aab3a@gmail.com>
Date: Fri, 20 Sep 2024 15:58:15 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] wifi: rtw88: use ieee80211_purge_tx_queue() to
 purge TX skb
To: Ping-Ke Shih <pkshih@realtek.com>, johannes@sipsolutions.net,
 linux-wireless@vger.kernel.org
Cc: pbrobinson@gmail.com
References: <20240822014255.10211-1-pkshih@realtek.com>
 <20240822014255.10211-2-pkshih@realtek.com>
 <c0f73bb2-45e7-4caf-b9e5-21ee064635bf@RTEXMBS04.realtek.com.tw>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <c0f73bb2-45e7-4caf-b9e5-21ee064635bf@RTEXMBS04.realtek.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/09/2024 09:33, Ping-Ke Shih wrote:
> Ping-Ke Shih <pkshih@realtek.com> wrote:
> 
>> When removing kernel modules by:
>>    rmmod rtw88_8723cs rtw88_8703b rtw88_8723x rtw88_sdio rtw88_core
>>
>> Driver uses skb_queue_purge() to purge TX skb, but not report tx status
>> causing "Have pending ack frames!" warning. Use ieee80211_purge_tx_queue()
>> to correct this.
>>
>> Since ieee80211_purge_tx_queue() doesn't take locks, to prevent racing
>> between TX work and purge TX queue, flush and destroy TX work in advance.
>>
>>    wlan0: deauthenticating from aa:f5:fd:60:4c:a8 by local
>>      choice (Reason: 3=DEAUTH_LEAVING)
>>    ------------[ cut here ]------------
>>    Have pending ack frames!
>>    WARNING: CPU: 3 PID: 9232 at net/mac80211/main.c:1691
>>        ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
>>    CPU: 3 PID: 9232 Comm: rmmod Tainted: G         C
>>        6.10.1-200.fc40.aarch64 #1
>>    Hardware name: pine64 Pine64 PinePhone Braveheart
>>       (1.1)/Pine64 PinePhone Braveheart (1.1), BIOS 2024.01 01/01/2024
>>    pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>    pc : ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
>>    lr : ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
>>    sp : ffff80008c1b37b0
>>    x29: ffff80008c1b37b0 x28: ffff000003be8000 x27: 0000000000000000
>>    x26: 0000000000000000 x25: ffff000003dc14b8 x24: ffff80008c1b37d0
>>    x23: ffff000000ff9f80 x22: 0000000000000000 x21: 000000007fffffff
>>    x20: ffff80007c7e93d8 x19: ffff00006e66f400 x18: 0000000000000000
>>    x17: ffff7ffffd2b3000 x16: ffff800083fc0000 x15: 0000000000000000
>>    x14: 0000000000000000 x13: 2173656d61726620 x12: 6b636120676e6964
>>    x11: 0000000000000000 x10: 000000000000005d x9 : ffff8000802af2b0
>>    x8 : ffff80008c1b3430 x7 : 0000000000000001 x6 : 0000000000000001
>>    x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
>>    x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000003be8000
>>    Call trace:
>>     ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
>>     idr_for_each+0x74/0x110
>>     ieee80211_free_hw+0x44/0xe8 [mac80211]
>>     rtw_sdio_remove+0x9c/0xc0 [rtw88_sdio]
>>     sdio_bus_remove+0x44/0x180
>>     device_remove+0x54/0x90
>>     device_release_driver_internal+0x1d4/0x238
>>     driver_detach+0x54/0xc0
>>     bus_remove_driver+0x78/0x108
>>     driver_unregister+0x38/0x78
>>     sdio_unregister_driver+0x2c/0x40
>>     rtw_8723cs_driver_exit+0x18/0x1000 [rtw88_8723cs]
>>     __do_sys_delete_module.isra.0+0x190/0x338
>>     __arm64_sys_delete_module+0x1c/0x30
>>     invoke_syscall+0x74/0x100
>>     el0_svc_common.constprop.0+0x48/0xf0
>>     do_el0_svc+0x24/0x38
>>     el0_svc+0x3c/0x158
>>     el0t_64_sync_handler+0x120/0x138
>>     el0t_64_sync+0x194/0x198
>>    ---[ end trace 0000000000000000 ]---
>>
>> Reported-by: Peter Robinson <pbrobinson@gmail.com>
>> Closes: https://lore.kernel.org/linux-wireless/CALeDE9OAa56KMzgknaCD3quOgYuEHFx9_hcT=OFgmMAb+8MPyA@mail.gmail.com/
>> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>> Tested-by: Ping-Ke Shih <pkshih@realtek.com> # 8723DU
> 
> 1 patch(es) applied to rtw-next branch of rtw.git, thanks.
> 
> 3e5e4a801aaf wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb
> 
> ---
> https://github.com/pkshih/rtw.git
> 
> 

A small problem: patch 1/2 is not applied yet:

linux/drivers/net/wireless/realtek/rtw88/usb.c:430:17: error: implicit declaration of function ‘ieee80211_purge_tx_queue’; did you mean ‘ieee80211_wake_queue’? [-Wimplicit-function-declaration]
  430 |                 ieee80211_purge_tx_queue(rtwdev->hw, &rtwusb->tx_queue[i]);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
      |                 ieee80211_wake_queue



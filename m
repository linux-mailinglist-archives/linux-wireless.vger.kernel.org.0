Return-Path: <linux-wireless+bounces-27812-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 149BABB909A
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Oct 2025 19:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86078346AAB
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Oct 2025 17:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6F4283FE7;
	Sat,  4 Oct 2025 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Whwg3XFr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283F4239E91
	for <linux-wireless@vger.kernel.org>; Sat,  4 Oct 2025 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759599445; cv=none; b=QVuSDhtZLITCHgOivfwhz4axcwoPaowQulz3cFChpWaTM3cAydxLXoOq8cm0gzyE/rWQNMCSkZicuTCsvdt7pDQ8SjVn+GviNoldnBjEgz59yaCONzCRVYYAryXvPy7LQ0LyGmzuxIRrDe7MZw9bmN6HwukIFKrJehFaKVHr/mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759599445; c=relaxed/simple;
	bh=4sHIXCwpt1/Md361YU8/WSBJOvjA4z3TGv6XZXV64sk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LJnA6cL3dkB4cazWnZfxX11ysOA0fTt/P9mtghctIkPzCF3gfzNYeHJLfjgB7k0r5N7xekOxO65Z5fLxzYlzzYn76ZDd6GjpXVOyX6/qwPK/XEevzHfKTDVAR60CP2vy2akg7VjzDg4bL7nqJWn7ziQlG3PI63Kr32xx9NZ5vDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Whwg3XFr; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3d5088259eso498722766b.1
        for <linux-wireless@vger.kernel.org>; Sat, 04 Oct 2025 10:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759599441; x=1760204241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3raRxwvGTM3ylvcN3K2wTHut+BkSdrAShA304pZSN3o=;
        b=Whwg3XFry5BWqHsRw11aACBlPCsAAzFqN7ofsJEym0oN6pkv9OqvFlIvJCDi5TaSZS
         hiLHCpJBGiHss8ELoRbu6RgNYNuedSs9IlYnkYnTvS9r1OI4WcA1yqfW5KsXQtqvJn93
         JSi92BT+tSIuXUxzSk3C0dnv/5A4mKw+N5uO8QKuk/qS8TkKntx/3/2Z6wJr2laXRJQV
         2Lvj2YEmFF8sLKWf9s323ONijRcI3HLVf9KbE6Rqr+wzmDZh1C37tREKR1pvtQHKbXp6
         m9WhVnaeYP57SdTLoYDLix4BMOsYB1WyB4ELifFFO16mGWA8N4oJmkThQBf6ki9s4bpy
         wy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759599441; x=1760204241;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3raRxwvGTM3ylvcN3K2wTHut+BkSdrAShA304pZSN3o=;
        b=NvYhjGg5V6mSDSLQSzGFS7RuJzj0xy/hcdwEz97UcQK92zTgSwnvLmoFryW6yjX2rq
         zdfk6nR85VuEDWqYeDN7MYFw1EuRBovltFgmX6waqwUwBSGv/i32o4Y1F4KlCkKB6Iga
         ZqwmjD+aJ/Rtp0rLr3zKC2d2YL3BLjNmkQgz2eFh2b3WJkjuvToJ0VT3pvSeFtIClTcs
         VFNGwr5gQHal3G4kx5nuaOE3xIm2JvSAXNwnDhp2777/bO/JZ1b0sWgt1FBOqOWtSQUa
         vDANYCRZjJItHDvdpalSzhH5J0rAuaSTtbh3YnBXkWxR9rdcNfWyPxCPoof26BvppeDe
         AX4A==
X-Forwarded-Encrypted: i=1; AJvYcCXMYdfFqyrINzWLTRN8palJ8ou4qB8bqY7tTasf2o+/E8F1lbhfpTiFS2+zIZQgLGEhFjVqSk4EnqsT29qY5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxN7HANFMBqZpUULtSMvfQE7cH+oFdmx7IvPr1qBtWoqBrrZdIr
	mSfye9VAPJr2nVB+An/1oD4aVmqeX+L/38IWIub6aNgh4LlXqujK0YMP
X-Gm-Gg: ASbGncu2b7/DHGB9i7yZadH/xREaafxz9V+kw+GJsPc331OYkvrMWNgZ+cMnd8NhjaB
	8F/u/KoHmAWso/6Bso1Z0zS2h+0kNYIu9wRUGtewVk/BOw7tQwu/mqCfkY5m+BVk+v4vYi7zaAZ
	gr4d8/DDZ6gOMi32LqJITR3OIH/ZtwSQCzpaNGusS/lw8XdIT7yNowkU6DT/56MBKkbVk8oYieK
	UejKVI9ZavqfrBZDZZQYoVXnEKOagqqVYP/GVgXQDGXYC3FAEyy4vmnCilMSIuiYtpbLq6b3YWE
	TYztKQe31dF0/FMUl8E/aCchpok+dberEordNJ/4HoAy2Jk+dfuCOxxUyWKUm8jC17L1NK2EYbT
	PK0lEhQyY2rb8jv5VAIWKO5NBrqsGHb1xc9gXXMC4kZbSC7z2v5kH5+PLXb95STEh
X-Google-Smtp-Source: AGHT+IEJUQ7qq474w8rtB7J4HTS8KuFCrk9CcH9sq6v3sqURFw7Y+LQ4G+vVF87638UgYESWP939Kw==
X-Received: by 2002:a17:906:9fcf:b0:b41:e675:95e3 with SMTP id a640c23a62f3a-b49c20531d6mr976793666b.16.1759599441077;
        Sat, 04 Oct 2025 10:37:21 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9f11sm729145966b.4.2025.10.04.10.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 10:37:20 -0700 (PDT)
Message-ID: <88f30433-98fa-4f9a-bbe3-9d630b72c2e4@gmail.com>
Date: Sat, 4 Oct 2025 20:37:17 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw-next v2 0/7] wifi: rtw89: improvements for USB part
To: Fedor Pchelkin <pchelkin@ispras.ru>, Ping-Ke Shih <pkshih@realtek.com>
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>, Po-Hao Huang
 <phhuang@realtek.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20251002200857.657747-1-pchelkin@ispras.ru>
Content-Language: en-US
In-Reply-To: <20251002200857.657747-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/10/2025 23:08, Fedor Pchelkin wrote:
> The first two patches concern memory leak issues found during testing.
> 
> The third and the fourth one do some extra small changes.
> 
> The other ones implement TX completion functionality missing for the USB
> part of rtw89 driver, suggested by Bitterblue Smith [1].  This will allow
> handling TX wait skbs and the ones flagged with IEEE80211_TX_CTL_REQ_TX_STATUS
> correctly.
> 
> rtw89 has several ways of handling TX status report events.  The first one
> is based on RPP feature which is used by PCIe HCI.  The other one depends
> on firmware sending a corresponding C2H message, quite similar to what
> rtw88 has.  RTL8851BU vendor driver [2] was taken for reference.
> 
> [1]: https://lore.kernel.org/linux-wireless/0cb4d19b-94c7-450e-ac56-8b0d4a1d889f@gmail.com/
> [2]: https://github.com/fofajardo/rtl8851bu.git
> 
> Series has been tested to work with RTL8851BU (USB) and RTL8852BE (PCIe)
> devices.
> 
> 
> Changelog.
> 
> v2: - add new 3/7 and 4/7 patches prepared due feedback to previous comments
>       or developed in process
>     - further changelog below --- in the patches
> 
> v1: https://lore.kernel.org/linux-wireless/20250920132614.277719-1-pchelkin@ispras.ru/
> 
> Fedor Pchelkin (7):
>   wifi: rtw89: usb: use common error path for skbs in
>     rtw89_usb_rx_handler()
>   wifi: rtw89: usb: fix leak in rtw89_usb_write_port()
>   wifi: rtw89: usb: use ieee80211_free_txskb() where appropriate
>   wifi: rtw89: refine rtw89_core_tx_wait_complete()
>   wifi: rtw89: implement C2H TX report handler
>   wifi: rtw89: handle IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
>   wifi: rtw89: process TX wait skbs for USB via C2H handler
> 
>  drivers/net/wireless/realtek/rtw89/core.c | 41 ++++++++++++---
>  drivers/net/wireless/realtek/rtw89/core.h | 45 +++++++++++++----
>  drivers/net/wireless/realtek/rtw89/fw.h   | 14 ++++++
>  drivers/net/wireless/realtek/rtw89/mac.c  | 46 +++++++++++++++++
>  drivers/net/wireless/realtek/rtw89/mac.h  | 61 +++++++++++++++++++++++
>  drivers/net/wireless/realtek/rtw89/pci.c  |  2 +-
>  drivers/net/wireless/realtek/rtw89/pci.h  |  4 --
>  drivers/net/wireless/realtek/rtw89/txrx.h |  6 ++-
>  drivers/net/wireless/realtek/rtw89/usb.c  | 41 +++++++++++----
>  9 files changed, 228 insertions(+), 32 deletions(-)
> 

I tested these patches with RTL8851BU, RTL8832AU, RTL8832BU, RTL8832CU, and
RTL8912AU. They all work, with a few additions.

Before these patches RTL8851BU and RTL8832AU would remain "connected" when
I power off the router. That's because they don't have beacon filtering in
the firmware and the null frames sent by mac80211 were always marked with
IEEE80211_TX_STAT_ACK. With these patches they disconnect immediately when
I power off the router. So that works nicely.

What doesn't work is TX reports for management frames. Currently rtw89
doesn't configure the firmware to provide TX reports for the management
queue. That can be enabled with SET_CMC_TBL_MGQ_RPT_EN for the wifi 6 chips
and with CCTLINFO_G7_W0_MGQ_RPT_EN for RTL8922AU.

The other thing that doesn't work is the TX reports are different for
RTL8852CU and RTL8922AU. It's only a small difference for RTL8852CU:

#define RTW89_C2H_MAC_TX_RPT_W5_DATA_TX_CNT_V1 GENMASK(15, 10)

RTL8922AU is more strange. It needs something like this:

#define RTW89_C2H_MAC_TX_RPT_W12_TX_STATE_V2 GENMASK(9, 8)
#define RTW89_C2H_MAC_TX_RPT_W12_SW_DEFINE_V2 GENMASK(15, 12)
#define RTW89_C2H_MAC_TX_RPT_W14_DATA_TX_CNT_V2 GENMASK(15, 10)

The C2H is 80 bytes here (header included).

I think that's everything.


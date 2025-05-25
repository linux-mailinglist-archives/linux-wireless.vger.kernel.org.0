Return-Path: <linux-wireless+bounces-23396-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67637AC3745
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 00:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F7D18948DA
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 22:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423C8A29;
	Sun, 25 May 2025 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5ngUn3J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D471163
	for <linux-wireless@vger.kernel.org>; Sun, 25 May 2025 22:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748210699; cv=none; b=JeRCKwiN5PBmaeNJipJ0Otx+d5Dc3VlcX+RqmlNbiEty+gPY1WQFbN2WxP6D+dG1me+Yxqd7swumxUPwQQ/DPbIOh2/V1/UwBCcRsSIB7cu7b5v9sy9apAHLzQnoVxTVhW5QyoV3RthGRJjfhiotpM8ZYlam+BpLIkvwrq6u1DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748210699; c=relaxed/simple;
	bh=VxDSaSB1OwjxRua7Jz0PFRODu2D0OJFHTsILQVtRm9c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=c9JiJEPeTcI53OCYD1tj/+5+U57InS/4LJkkvbBp5I80iS/M8xwh26ecaBErVVR+5wuKbBbYyuwFudyLOvngi5pmW6evWjaWtfvwyjmI0kMokA30z6sNTBqQqWfbAi3PksGjlb+vIsXkN5lA3ORHmPtyYOuGOSoB0hvKueLZg68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5ngUn3J; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60497d07279so998302a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 25 May 2025 15:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748210695; x=1748815495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrX30DS1shWkgfGJ4aIfFMLRg/47aQXaaJ6aTMR9qLE=;
        b=U5ngUn3JE0tzptp2L2KFhdlZqgIhtRA4+eqP9j+cGjHSTSAxA8ojJgn61IGYhfboL9
         mL2ybEvoxyEiuN0+QwRu43zTtUM/FtGsepi3NlgZQLcKH5n6P+Z4zzLzlrJiOZc9cZuP
         TCI+ydmV6x6wWSoY1ITyk7PDUH8KCVvdyqzEbNXpqH3KXrLKD7SgrDt5YjfZ66eqyFrl
         amejoNhOJwkHmGSBbmXgqzPRQPJyTHtFa5pXuS5sTXv6rx7+1Q3XtlttdJp+zBkANOEH
         vUBafdf7cqXU7xap0aRb1VSyuL1mic0O5jRvqZ32uxdOSpGzTB1Bj4dzfDb7AU/BGMhg
         t6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748210695; x=1748815495;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hrX30DS1shWkgfGJ4aIfFMLRg/47aQXaaJ6aTMR9qLE=;
        b=Z7Xo1knmlDJcSmZFp84C/GqfbcNR5gjLaCVrS9qm3L5m2TfzvCXuXtCHIu9zCbVfH+
         3+Du1Cy9bxb1bYalZshlPGsCS8iTNYJcqit2hWKcSgmhSo4CepcyQnNpbTo6590eqCoF
         WQZPkBTyyenJHFEe+DiREJFaRuqcvatsD4K4idtUKj6Zv4wQQtGFxVOu3Gj8gMX8GwlT
         OHfQoTmtIZg+GotEl/ZZyQnEYHYMhbbIhzYeCIbOtwyCj9P8mDbeTGaYvjotzZNyctWO
         JlOM7+JWiX6EzExrf1b7CxmUsFMKbkDxk2fOaUtjOedkLFAGE98LBxhUz8IP6DJzhpAf
         yIpw==
X-Forwarded-Encrypted: i=1; AJvYcCXGO6+RhcBEb8vx0n0D+QHWF0sjEtrzcp4WXH4uUmL0WBBe+pcdxGd0SSGMC4W1+LiYV5liXhrlNaG7XQ0qZw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4EZORbsvtG+YZ9rXV1vqwq01BdXnpYaMmy2Px8F5z/+8PSXbM
	1V8o5yabNahP1+NF0OeErIPX+toIH5gh/LYME3+1aSxYkXWaib0f+plx
X-Gm-Gg: ASbGnctpcOQ+QNCbM80J3yMXfvOgw6q0PQB45DkX08AWKUE9Zm4rh/3WY0dCcB7Abx6
	Fw4ALVHcF1l7BoniYUMmfj5LE/hlSz53CWhJMnBMPBzp48ZMteeo6TvKKgY9e2d79CkfFUeDr7m
	HZU1cLBqmbDwmL+yi2BrxSqxj4dgjlWbhZZlJ3HOmo3Hf0J8scJOnvNasz2H0Dsi22z70oBKNBo
	r3tNJ6AknFOsQ0zRj/Fh/r+6Nymrf/NsPwkllVTuTjnlWgkq4+WZobKToOQ2YLZqC/R67/ZFtBm
	uFphWyWuDu/Rf919r7ov4uFQaL0YyxalTjeYs4pymyh+BIXHtAPwZQKJM8nZfQK5MqbyZg==
X-Google-Smtp-Source: AGHT+IFNYeldQaS8iHE5SaXwCDjfeE2cXGgx5bKnD1RNW9Z4hhlCS/YwPQ38YD3e10fKVxaHwjDTog==
X-Received: by 2002:a17:907:8686:b0:ad5:b251:17f8 with SMTP id a640c23a62f3a-ad85b185a24mr622525866b.41.1748210695395;
        Sun, 25 May 2025 15:04:55 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d06b532sm1568724166b.43.2025.05.25.15.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 15:04:55 -0700 (PDT)
Message-ID: <83a7ade0-2c9a-4148-b998-db52e05587b8@gmail.com>
Date: Mon, 26 May 2025 01:04:53 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw-next v1 02/13] wifi: rtw89: Get dle_mem via
 rtw89_hci_dle_mem()
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <594d5987-5e6d-405c-b482-d101b43cb65c@gmail.com>
 <e587721eeb7244beaa1f07b88d9b4f59@realtek.com>
Content-Language: en-US
In-Reply-To: <e587721eeb7244beaa1f07b88d9b4f59@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/05/2025 03:56, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Don't access dle_mem in get_dle_mem_cfg() directly. USB 2, USB 3, and
>> SDIO will need different sets of values.
>>
>> Rename dle_mem in struct rtw89_chip_info to dle_mem_pcie and get it
>> via rtw89_hci_dle_mem() and rtw89_pci_ops_dle_mem().
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw89/core.h      | 10 +++++++++-
>>  drivers/net/wireless/realtek/rtw89/mac.c       |  2 +-
>>  drivers/net/wireless/realtek/rtw89/pci.c       |  8 ++++++++
>>  drivers/net/wireless/realtek/rtw89/rtw8851b.c  |  2 +-
>>  drivers/net/wireless/realtek/rtw89/rtw8852a.c  |  2 +-
>>  drivers/net/wireless/realtek/rtw89/rtw8852b.c  |  2 +-
>>  drivers/net/wireless/realtek/rtw89/rtw8852bt.c |  2 +-
>>  drivers/net/wireless/realtek/rtw89/rtw8852c.c  |  2 +-
>>  drivers/net/wireless/realtek/rtw89/rtw8922a.c  |  2 +-
>>  9 files changed, 24 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
>> index be1259cfa712..afcf0353a625 100644
>> --- a/drivers/net/wireless/realtek/rtw89/core.h
>> +++ b/drivers/net/wireless/realtek/rtw89/core.h
>> @@ -3579,6 +3579,8 @@ struct rtw89_hci_ops {
>>         void (*disable_intr)(struct rtw89_dev *rtwdev);
>>         void (*enable_intr)(struct rtw89_dev *rtwdev);
>>         int (*rst_bdram)(struct rtw89_dev *rtwdev);
> 
> an empty line
> 
>> +       const struct rtw89_dle_mem *(*dle_mem)(struct rtw89_dev *rtwdev,
>> +                                              u8 qta_mode);
>>  };
>>
>>  struct rtw89_hci_info {
>> @@ -4271,7 +4273,7 @@ struct rtw89_chip_info {
>>         bool dis_2g_40m_ul_ofdma;
>>         u32 rsvd_ple_ofst;
>>         const struct rtw89_hfc_param_ini *hfc_param_ini;
>> -       const struct rtw89_dle_mem *dle_mem;
>> +       const struct rtw89_dle_mem *dle_mem_pcie;
> 
> I reconsider if this can be an array with a new enum = {PCIE, USB2, USB3, SDIO}
> stored in hal->hci_dle_mem_type. Then, consumers can just access it via
> chip->dle_mem[hal->hci_dle_mem_type][quota]. But, I'm not sure if USB
> subsystem can notify driver when USB speed is changed. 
> 
> This is a thought to simply the struct definition. 
> 

The hard part is naming the new enum. It's basically rtw89_hci_type
but more detailed.

I don't expect the USB speed to change during the lifetime of struct
rtw89_dev. When the device switches from USB 2 to USB 3 it disconnects
and reappears as a new device:

Apr 21 22:02:22 ideapad2 kernel: usb 1-4: new high-speed USB device number 17 using xhci_hcd
Apr 21 22:02:22 ideapad2 kernel: usb 1-4: New USB device found, idVendor=0bda, idProduct=c832, bcdDevice= 0.00
Apr 21 22:02:22 ideapad2 kernel: usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Apr 21 22:02:22 ideapad2 kernel: usb 1-4: Product: 802.11ax WLAN Adapter
Apr 21 22:02:22 ideapad2 kernel: usb 1-4: Manufacturer: Realtek
Apr 21 22:02:22 ideapad2 kernel: usb 1-4: SerialNumber: 00e04c000001
Apr 21 22:02:24 ideapad2 kernel: eric-tx CALL alloc_txring !!!!
Apr 21 22:02:24 ideapad2 kernel: usb 1-4: USB disconnect, device number 17
Apr 21 22:02:24 ideapad2 kernel: rtl8852cu 1-4:1.0: Runtime PM usage count underflow!

Apr 21 22:02:27 ideapad2 kernel: usb 2-4: new SuperSpeed USB device number 2 using xhci_hcd
Apr 21 22:02:27 ideapad2 kernel: usb 2-4: New USB device found, idVendor=0bda, idProduct=c832, bcdDevice= 0.00
Apr 21 22:02:28 ideapad2 kernel: usb 2-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Apr 21 22:02:28 ideapad2 kernel: usb 2-4: Product: 802.11ax WLAN Adapter
Apr 21 22:02:28 ideapad2 kernel: usb 2-4: Manufacturer: Realtek
Apr 21 22:02:28 ideapad2 kernel: usb 2-4: SerialNumber: 00e04c000001
Apr 21 22:02:28 ideapad2 kernel: eric-tx CALL alloc_txring !!!!
Apr 21 22:02:28 ideapad2 kernel: rtl8852cu 2-4:1.0 wlp3s0f3u4: renamed from wlan0

>>         u8 wde_qempty_acq_grpnum;
>>         u8 wde_qempty_mgq_grpsel;
>>         u32 rf_base_addr[2];
>> @@ -6146,6 +6148,12 @@ static inline void rtw89_hci_clear(struct rtw89_dev *rtwdev, struct pci_dev *pde
>>                 rtwdev->hci.ops->clear(rtwdev, pdev);
>>  }
>>
>> +static inline const
>> +struct rtw89_dle_mem *rtw89_hci_dle_mem(struct rtw89_dev *rtwdev, u8 qta_mode)
>> +{
>> +       return rtwdev->hci.ops->dle_mem(rtwdev, qta_mode);
>> +}
>> +
>>  static inline
>>  struct rtw89_tx_skb_data *RTW89_TX_SKB_CB(struct sk_buff *skb)
>>  {
>> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
>> index 592fbb6d2728..77d35db3e133 100644
>> --- a/drivers/net/wireless/realtek/rtw89/mac.c
>> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
>> @@ -1719,7 +1719,7 @@ static const struct rtw89_dle_mem *get_dle_mem_cfg(struct rtw89_dev *rtwdev,
>>         struct rtw89_mac_info *mac = &rtwdev->mac;
>>         const struct rtw89_dle_mem *cfg;
>>
>> -       cfg = &rtwdev->chip->dle_mem[mode];
>> +       cfg = rtw89_hci_dle_mem(rtwdev, mode);
>>         if (!cfg)
>>                 return NULL;
>>
>> diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
>> index c2fe5a898dc7..1dec603012ba 100644
>> --- a/drivers/net/wireless/realtek/rtw89/pci.c
>> +++ b/drivers/net/wireless/realtek/rtw89/pci.c
>> @@ -4341,6 +4341,13 @@ static int __maybe_unused rtw89_pci_resume(struct device *dev)
>>  SIMPLE_DEV_PM_OPS(rtw89_pm_ops, rtw89_pci_suspend, rtw89_pci_resume);
>>  EXPORT_SYMBOL(rtw89_pm_ops);
>>
>> +static const
>> +struct rtw89_dle_mem *rtw89_pci_ops_dle_mem(struct rtw89_dev *rtwdev,
>> +                                           u8 qta_mode)
>> +{
>> +       return &rtwdev->chip->dle_mem_pcie[qta_mode];
>> +}
>> +
>>  const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
>>         .isr_rdu = B_AX_RDU_INT,
>>         .isr_halt_c2h = B_AX_HALT_C2H_INT_EN,
>> @@ -4413,6 +4420,7 @@ static const struct rtw89_hci_ops rtw89_pci_ops = {
>>         .disable_intr   = rtw89_pci_disable_intr_lock,
>>         .enable_intr    = rtw89_pci_enable_intr_lock,
>>         .rst_bdram      = rtw89_pci_reset_bdram,
> 
> an empty line
> 
>> +       .dle_mem        = rtw89_pci_ops_dle_mem,
>>  };
>>
> 
> [...]
> 
> 



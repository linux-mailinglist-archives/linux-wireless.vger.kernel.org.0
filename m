Return-Path: <linux-wireless+bounces-26262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB826B2096B
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 14:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ADD218A5089
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 12:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685092D3ECE;
	Mon, 11 Aug 2025 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkeUW0is"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB9E171D2
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916967; cv=none; b=m0w9zjmgggaaFrbOSMgSLCHoKXIA31vu/cnLLy0cGf88pajNNqB8ZpBSGEMPI+Y8WlsRWgKU4S4Le970wpvpitksa4IlQP4IFHI4EyvfDkDpZFT6mo+/B6nBQX9RhX68868FPbIyFbgESdHxfQs5HpN+jYv72DbVCtvuM0j42n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916967; c=relaxed/simple;
	bh=t/oSwQAYhyK1o8La4kkyv/XwhU9KE4xln07TmrJvpH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Abl41uSZfd3s98vedFIqrNxgjM1dWlnAOM5J68a1w4KWpTDUNruMUC673xPXPNH9cooYyook3ZdFY2UYheDAm2zsq7+kus2dzKY7zo025PQooRFe+ASvTxqftbIpVl/yhS3tuqzAXiJLD0xU2ZekDnb+qKIyIu9CQ1kmn2FIEf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkeUW0is; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-458bdde7dedso29142355e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 05:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754916963; x=1755521763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NMWzX+9y7BUx4BPnll+4VDgcpm9So3eJPyfbV44hLqs=;
        b=DkeUW0isAHtlR+poqNHBr83MlIgCwZp4OoLU5nocYYf8FxgtDda1LMDUHUnVVVBoAu
         Prz0i4/DbOaoUNGFUVxWwSQy54sWSEJngPCgvFkF0Etn1xAFP+SD4XoauRFLuwgEqf6D
         SiTS6RNVIl2Que2ml6LfpZzPhxQeTAGDOSOwKprPJPwUxkSp/kEM4KyHAxqgCzoMeg9w
         222k7UQ1BgBvE9OZ676+0vv/N8OMoMcNwgNZ+yDkeKNcurFB4LSsYCUgttseqxlbTCM8
         Ux02aX5q40S9DE2nk+9u7l2M3KSJNhYc1Jq3SVOGP2BDmm4PCUZTw3zfe/vtLnuxQlpD
         7SLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754916963; x=1755521763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NMWzX+9y7BUx4BPnll+4VDgcpm9So3eJPyfbV44hLqs=;
        b=xTMnoMWkTS/g85lqRVNq8ox9cp65qAwAVCLFpRLoacwAes0JlINCyyj762nQqOTu/D
         B8cHfKRI8Lro3kSRCtRZaYKlY/aOlgjjrYX3avUqr5yvWEJRSIrIv+K6U8H1j79UGG/W
         6HpL+dmgiuizA/vfNOoU0jxFcCwoBS3chS0aKZl3st7aQsyxZXRQjYHqrV8M2UBSdCOu
         INlCTxIcXMs7tuL/f1bSHKewXb070EkbaBrcv/L3Ng3g6lODETegdkZupIZr1gT/jrSt
         NE0Np8PCtMaTB17t5pZaqGo24VWMgwyPBs85QAo6YG31rB518lS90exyX+nj2CTtkmL4
         i2yA==
X-Forwarded-Encrypted: i=1; AJvYcCXoQ9X73ZLtkKKIhZltgBmhAaNGnyCU6+x5MYKYyinjDm/yJ/hV7Al1pV/8mwO58q574HbkVozNBVmwCU7dZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcwmzsPr7Bidi2Jb1PLGokNsJZkSN8cxtBikBVLL6I2KCcZXEd
	nMqCkoHFJ3Bwk+LukNAj2YvQFPQgdxv5Ma5kTVWUH/3qo1di50yzAUjfLqRyng==
X-Gm-Gg: ASbGnctNQFUAYyF6E8+Yxz3u4Xn04Git9q9wt3kNybN14fejRvzkH+DV7L8TPAPXL6f
	j0sI2f3x+a6Uy0tIv3cEME8CYYP0+MPIpawCegXJIAmEOECFMBiuyAN1YX3OEzmMz3W+xRrYdEu
	NwdkXINRPoeyivNXWZG2EIGjVYZTUcNMKmAxKtBSv5u8vvaqQ63LFzjLRHCmc1OH7eyYoVaJRhT
	fj8FxNxsFmjsiWZjTOacjVQJTdVGQ1Cz54suaOGLaPW+LHJS5ncueJKorGizfVm9RMfut2Po2Sw
	zKbZCJF4A85tgWuQ2byZl2Sl5tk7RdNG+qdFE/0ZIzxoWmkrfeq9FlEqkwytCESYIgyopZ14PCv
	Nj4hl88TA3iLV605q/13Z2Wc/OJ74yQ==
X-Google-Smtp-Source: AGHT+IEysF2v8pm587z/XR5lNtCO1yU/TLWezNz/qOOjRLyUVODEMN/fFAjE7OwhJWnPoJbQZoIWyg==
X-Received: by 2002:a05:600c:4746:b0:453:23fe:ca86 with SMTP id 5b1f17b1804b1-459f4ea0f2dmr118866765e9.4.1754916963299;
        Mon, 11 Aug 2025 05:56:03 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5843021sm274596055e9.3.2025.08.11.05.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 05:56:02 -0700 (PDT)
Message-ID: <aed4c8cb-b265-444d-a17c-eb464cf4dd78@gmail.com>
Date: Mon, 11 Aug 2025 15:56:01 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RTL8188S WLAN Adapter failure
To: Helge Deller <deller@gmx.de>, Jes.Sorensen@gmail.com,
 Ping-Ke Shih <pkshih@realtek.com>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <ee0acfef-a753-4f90-87df-15f8eaa9c3a8@gmx.de>
 <015e5657-d21e-4214-9854-975c32b1990f@gmail.com>
 <34e345ed-a114-494a-b3f7-72dfab6b628a@gmx.de>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <34e345ed-a114-494a-b3f7-72dfab6b628a@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/08/2025 14:46, Helge Deller wrote:
> On 8/11/25 00:12, Bitterblue Smith wrote:
>> On 10/08/2025 23:36, Helge Deller wrote:
>>> The USB dongle which came with my DreamBox DM7020HD years ago seems to fail now.
>>> Any idea or suggestion what I should try?
>>>
>>> [427792.562049] usb 3-7: new high-speed USB device number 56 using xhci_hcd
>>> [427792.689358] usb 3-7: New USB device found, idVendor=07b8, idProduct=8188, bcdDevice= 2.00
>>> [427792.689376] usb 3-7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>>> [427792.689381] usb 3-7: Product: RTL8188S WLAN Adapter
>>> [427792.689385] usb 3-7: Manufacturer: Manufacturer Realtek
>>> [427792.689388] usb 3-7: SerialNumber: 00e04c000001
>>> [427792.695145] usb 3-7: This Realtek USB WiFi dongle (0x07b8:0x8188) is untested!
>>> [427792.695151] usb 3-7: Please report results to Jes.Sorensen@gmail.com
>>> [427792.934142] usb 3-7: Dumping efuse for RTL8188CU (0x200 bytes):
>>> [427792.934151] 00000000: 29 81 00 00 a9 16 00 00 b8 07 88 81 90 85 62 9c  ).............b.
>>> [427792.934155] 00000010: 06 00 ec f0 0e 16 44 3f 17 03 4d 61 6e 75 66 61  ......D?..Manufa
>>> [427792.934157] 00000020: 63 74 75 72 65 72 20 52 65 61 6c 74 65 6b 20 18  cturer Realtek .
>>> [427792.934159] 00000030: 03 52 54 4c 38 31 38 38 53 20 57 4c 41 4e 20 41  .RTL8188S WLAN A
>>> [427792.934160] 00000040: 64 61 70 74 65 72 20 00 00 00 00 00 00 00 00 00  dapter .........
>>> [427792.934162] 00000050: 06 02 00 00 00 24 24 24 00 00 00 26 26 26 00 00  .....$$$...&&&..
>>> [427792.934163] 00000060: 00 00 00 00 00 00 00 00 12 00 00 09 0d 00 00 00  ................
>>> [427792.934164] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>> [427792.934166] 00000080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934167] 00000090: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934168] 000000a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934170] 000000b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934171] 000000c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934172] 000000d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934174] 000000e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934175] 000000f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934176] 00000100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934178] 00000110: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934179] 00000120: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934180] 00000130: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934182] 00000140: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934183] 00000150: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934184] 00000160: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934186] 00000170: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934187] 00000180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934188] 00000190: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934190] 000001a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934191] 000001b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934192] 000001c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934193] 000001d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934195] 000001e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934196] 000001f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>> [427792.934198] usb 3-7: RTL8188CU rev A (TSMC) romver 0, 1T1R, TX queues 3, WiFi=1, BT=0, GPS=0, HI PA=0
>>> [427792.934203] usb 3-7: RTL8188CU MAC: 44:3f:17:03:4d:61
>>> [427792.934206] usb 3-7: rtl8xxxu: Loading firmware rtlwifi/rtl8192cufw_TMSC.bin
>>> [427792.938371] usb 3-7: Firmware revision 88.2 (signature 0x88c1)
>>> [427792.939417] rtl8192cu_power_on: Enabling LDOV12D (24)
>>> [427793.115145] rtl8192cu_power_on: FSMCO_MAC_ENABLE poll failed
>>> [427793.115156] usb 3-7: rtl8xxxu_init_device: Failed power on
>>> [427793.116003] rtl8xxxu 3-7:1.0: probe with driver rtl8xxxu failed with error -16
>>>
>>
>> Your dongle has the RTL8188SU chip inside. rtl8xxxu and rtl8192cu
>> are not the right drivers.
>>
>> The right driver is r8712u, but it was removed in kernel 6.13.
> 
> Ah, ok.
> 
>> You can use kernel 6.12. Or you can compile r8712u for your current
>> kernel. Maybe r8712u could even be accepted back in the kernel if
>> you convert it to use mac80211/cfg80211.
>> https://lore.kernel.org/linux-staging/20241020144933.10956-1-philipp.g.hortmann@gmail.com/
> 
> According to that commit message, a replacement with MAC80211 support
> is available at https://github.com/chunkeey/rtl8192su
> But development on it seems to have stopped some years ago.
> Is there any specific reason for this?

I think the people working on it ran into some problems with the
driver/firmware and also didn't have time for it anymore:

https://lore.kernel.org/linux-wireless/3717687.FpcDfXaOEr@debian64/

> I have no clue on wireless development, so if I'm willing to test this
> driver and provide feedback, would someone be interested and may help to bring
> it upstream? Or doesn't it make sense to invest the time in that?
> 
> Helge

The work has to be done by someone who has the hardware. That makes
you the best candidate for the job.


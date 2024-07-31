Return-Path: <linux-wireless+bounces-10758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D6994348C
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 18:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9531C23121
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 16:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B381BC09A;
	Wed, 31 Jul 2024 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OijMSoC2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AFF12B93
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445085; cv=none; b=OPxIJqc4g7yopq4BOfW9aKaZUsvJ9ILGvv6UUVH5xelKZPRuoHIzwf2DewyNgK1Xi5rImZrbD6WTMtECBgpQ8wbZDzCSP1TVxU8glxZo2gcn1F0p8ccqjT8Ue+MrU7EOO7/fjeL3Upy2C2tyKqUcbvdpScf1xnPqyLlRaGIzaMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445085; c=relaxed/simple;
	bh=S2O4GT7mcs8HYNmiCEsTRlyJqhFOvtKNLXigsTbTqwg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jHd9KWypVhlXzW9xM12+KtV0aY94OhF3ZyQfMrf5B2Z49rmqmEkuxQN5UR9w1IVW3gAPW8or21KXu9BgL6rRupfR/QRp6I8T742/UUM09tQp5a2vKbzGEMZtgM2oTSzcVcBVkiuYCvsfzffi9tZEQPXvBcMyhpVgm69Tg2lmTaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OijMSoC2; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so752505066b.0
        for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722445082; x=1723049882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CXbrb01I+eCN8PTzhjNxZ4nFmOIXCmDYLgnTYR7LTcY=;
        b=OijMSoC2BpnbmxDNe7omWPbMWAcyyupln5usjQhe4FI2caxuBLjBZfe2ljv6WFlpP6
         Anq5lNq/vAAjuvhPy+HefZzIKXbryA0lD8WCs1s2twNahS033FikBR063PqdJRMPFCpn
         RnIJ/DuBfUTvf5gm8XVchuh24DFruZJCZWRrf2vrL3kJg2OtqjFapgj2DK85kPy08ZK6
         1zMgRv12gE4NCSTcwuad6Tyhcja758g46gOtg0pvWNYQPmAlp+nDHcltg0jL/xTm0fuj
         H2h8jIcf6Qz1drC/uPTRElPV7NZ4/yWNukLBEqJI92497OAIV3FEHWo3HAA6tZj+rjkK
         y7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722445082; x=1723049882;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXbrb01I+eCN8PTzhjNxZ4nFmOIXCmDYLgnTYR7LTcY=;
        b=pD/ywIAytZ8HzAiF1SQch4rHasiWOCe5soGaflIEVdxlovvKgaAz92F9vBYivyblE4
         a0B9Z2FSuNF9L16KSk8a2eTNyilXVbEGyfXjLsEzkL6HttYoV7aCFoawl61/qLmZ/F22
         IjczXPFk3xSNnbY/7wlSLKcidqxSUHN+yivl/OXXPzoG6/E9kyQ0EqkN40egKC+GIa4A
         a6s/lFBCkasXfEZMJlPks3wU+nQ/brRUZZy+fWP6DJ+m45HRr7vMqWze2tfwBKgkRMGs
         mk4+z1YOW3/rG8Ky1dCuLZ6LmcPLgRN9DqtFvGaguBBnxNHeXXbwryQWSi7ZAWQrL92w
         g9FA==
X-Forwarded-Encrypted: i=1; AJvYcCWsLUsCoc8Et/oAbmTj92ZsC3JcqbKK56dAylp7udwD1JUBMZ/zVf8RqYedTqUtKmfFrlBm7h52jhFPg9+9EZ1vRajLF9OYsBICgSl7jeA=
X-Gm-Message-State: AOJu0YzLhmq6q/tsYsfuqvkIeXoNmXWUIbhGfjRzmPizUbHd1tjijybg
	BEskOBJxBG3GACoBHjPR6E4SxZdnYoNG5lG01EIR5zJm0sOtSlhnIn7ewA==
X-Google-Smtp-Source: AGHT+IFNUD+zVgCylhib4DJAlgfzYkt4a+9+Lk02wOgJIHljImXa3bMTcfjAF0RZda6NTlqD8oydtg==
X-Received: by 2002:a17:906:c10f:b0:a7a:a33e:47cc with SMTP id a640c23a62f3a-a7d40185a3emr1126894666b.59.1722445081650;
        Wed, 31 Jul 2024 09:58:01 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad9d41esm785395966b.154.2024.07.31.09.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 09:58:01 -0700 (PDT)
Message-ID: <152dece9-f328-4ad4-95df-5eeae85f6056@gmail.com>
Date: Wed, 31 Jul 2024 19:57:59 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 1/4] wifi: rtw88: Init RX burst length for
 8822cu/8822bu/8821cu
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Sascha Hauer <sha@pengutronix.de>
References: <c03390ce-34c2-42dd-9bd6-b231bb1f2fae@gmail.com>
 <4a8ac99c87214b4c92dde42e26006964@realtek.com>
Content-Language: en-US
In-Reply-To: <4a8ac99c87214b4c92dde42e26006964@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/07/2024 06:57, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Init RX burst length according to the USB speed.
>>
>> This is needed in order to make USB RX aggregation work.
>>
>> Tested with RTL8811CU.
> 
> Having a throughput after this change would be better.
> 
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> I would mention in the commit message what BIT_DMA_BURST_CNT,
>> BIT_DMA_MODE, and BIT_DROP_DATA_EN are doing, but I don't know.
> 
> That will be helpful to other developers. Please put them in second paragraph. 
> 
> [...]
> 
>> +static void rtw8821cu_init_burst_pkt_len(struct rtw_dev *rtwdev)
>> +{
>> +       u8 rxdma, burst_size;
>> +
>> +       rxdma = BIT_DMA_BURST_CNT | BIT_DMA_MODE;
>> +
>> +       if (rtw_read8(rtwdev, REG_SYS_CFG2 + 3) == 0x20)
>> +               burst_size = BIT_DMA_BURST_SIZE_1024;
>> +       else if ((rtw_read8(rtwdev, REG_USB_USBSTAT) & 0x3) == 0x1)
>> +               burst_size = BIT_DMA_BURST_SIZE_512;
>> +       else
>> +               burst_size = BIT_DMA_BURST_SIZE_64;
>> +
>> +       u8p_replace_bits(&rxdma, burst_size, BIT_DMA_BURST_SIZE);
>> +
>> +       rtw_write8(rtwdev, REG_RXDMA_MODE, rxdma);
>> +       rtw_write16_set(rtwdev, REG_TXDMA_OFFSET_CHK, BIT_DROP_DATA_EN);
>> +}
>> +
> 
> All use the same setup. 
> Can we move it to usb.c? Maybe rtw_usb_interface_cfg() is a good place?
> (still exclude untested chips.)
> 

rtw_usb_interface_cfg() is a good place. I will move it there.
The other chips will complicate it a bit, but that's okay.

RTL8723DU doesn't check for USB 3, of course:

	if (rtwusb->udev->speed == USB_SPEED_HIGH)
		burst_size = BIT_DMA_BURST_SIZE_512;
	else
		burst_size = BIT_DMA_BURST_SIZE_64;

RTL8821AU/RTL8812AU:

	if (chip->id == RTW_CHIP_TYPE_8821A)
		speedvalue = BIT(7);
	else
		speedvalue = rtw_read8(rtwdev, REG_SYS_CFG2 + 3);

	if (speedvalue & BIT(7)) { /* USB 2/1.1 Mode */
		temp = rtw_read8(rtwdev, 0xfe17);
		if (((temp >> 4) & 0x03) == 0)
			burst_size = BIT_DMA_BURST_SIZE_512;
		else
			burst_size = BIT_DMA_BURST_SIZE_64;
	} else { /* USB3 Mode */
		burst_size = BIT_DMA_BURST_SIZE_1024;
	}

RTL8814AU:

	speedvalue = rtw_read8(rtwdev, REG_SYS_CFG2 + 3);

	if (speedvalue & BIT(7)) { /* USB 2/1.1 Mode */
		if (rtwusb->udev->speed == USB_SPEED_HIGH)
			burst_size = BIT_DMA_BURST_SIZE_512;
		else
			burst_size = BIT_DMA_BURST_SIZE_64;
	} else { /* USB3 Mode */
		burst_size = BIT_DMA_BURST_SIZE_1024;
	}

I don't understand why we can't just check rtwusb->udev->speed
instead of reading various registers. Then they could all use
the same code.

(By the way, RTL8821AU/RTL8812AU is ready now. I will send
the patches after this patch set is sorted out. There are about
16 smaller patches to prepare things, and then the new driver.)


Return-Path: <linux-wireless+bounces-7126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8002E8BA30F
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 00:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383622834B8
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 22:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D5A57C87;
	Thu,  2 May 2024 22:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI8VgojO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3515257CB4
	for <linux-wireless@vger.kernel.org>; Thu,  2 May 2024 22:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714688324; cv=none; b=sGHT54CtwlcqdrpG1JIYEU+xY053yCML7j0+6NpT0E8g42YJNhAa5EmQZExRUw127TLegn1SCV3dCQM4WcTK2zGJuvHmG6mnGX0jPaYtm7eMMmrOv8GwrX5Z0ee1m35PIMDt1oP+p/8ANFgJLxN1pu54qhZPfV3TE2Zje81TPlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714688324; c=relaxed/simple;
	bh=KI6a5yJezI2AIi9cX5lpy+OWfFtqLHmrREfUvIi/Fcs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=r1UhJ149YD171F/GTB8+qjrN6OEph8i2UNhwtIVz0u/1yOLTZWZSVvKH0V2uMf91upBBITJhm2dCyHpLaUhUboPHfmBOhhXZ4L0Qe3fiYyxSPdUfZqog9HrezffNp1KsyEsR9Ol/cHJon+5+yLmSqq/3arOYsiuj6/RztBDM5qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UI8VgojO; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-238e171b118so3753028fac.3
        for <linux-wireless@vger.kernel.org>; Thu, 02 May 2024 15:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714688321; x=1715293121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ACQ33A5M7DwldHmh8uCYxPPrecUN7o9pXT7wtCr0KHg=;
        b=UI8VgojO/xakHemIxrV7zDPvPP6Z0QFLsKnlF0g7WYP+Q+mUvHHIn2yZODxj6+YdLe
         2Ow/On4ZwXuC68zvzVq3sXeoSsE62kTKz8hZ9fzr1XwlI3QP2z0eZVXPXX83Ag9dbXjD
         eHs4ROv3YMGD0hGBKK4CdejLNo9gdj2BB+pZZbyGIjElN4wJeYXj8BzG+KRoCv8bveHL
         dpP2kt88cCGjnoYxpQ7A4XQXaZ0Ivj5VQiyEqNUHQGdqljaWwfdzTK00VHkekpIpDPRQ
         HUB271id2SSXZ3d/ajPmSUD9wvNba5+R1PZLteLYvpwU8gkn7qXXy1UXJMb/R9F9v+fy
         Jyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714688321; x=1715293121;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACQ33A5M7DwldHmh8uCYxPPrecUN7o9pXT7wtCr0KHg=;
        b=X2izQyoVyhURD3mzhmXqwi7aOOdhzzHpRD8Cen4O2Fl9StuiqoKsidURckpzWHKesq
         xxtnWpYVC/Py9OJ8PSJhZ2J7mdlxTgg+ss7FTjVAnstaAfvuAPtoVjjPN8g/PmeHxaLx
         2rdOk+NSi2qjOGcBCKmX3rIVVDShhD5BwvDoQbW2GSPCg6TN3wtQdNG7VjebYXqQ3Fec
         aUIk9r2DAu6hs1hIJ2vNtzm5l/W0/eNtop/ZGbGWic/3U50i5MAjRMeDUzRS/TIvUg+U
         Bx42snxiG6fjE7tNw1ZhRo/W9VJdrAOt5ZOV0rc016wy+OIebU29MjHxcrgAVd1t2mHQ
         ce/w==
X-Forwarded-Encrypted: i=1; AJvYcCVY3YR3qt5l2n+anwsy9iFL1sOfH2sMf1cH3eAROEJ0BcwyfCcsgQwPXjvmX1zQAV7P7eXaCuwBGMEwBM5h1oVcUEsvz1nffJuTplVcKJ8=
X-Gm-Message-State: AOJu0Yxd9caoSWntUoYKSvJV7G397GUX9kWh3UhC7ZUmWKzgetwWrzmc
	C2CvKOuI/ze9Wyjq52Kq6o3fT62k/OBCKc5Mj/Eko43RBpZ5wTO+FSoRd+R+
X-Google-Smtp-Source: AGHT+IETR+wZMPKBZ1QztqSY8RWektxcGgVO2HR+W6BJS9MMn7T2RmBL3LMoYe7mqg3y4gqa3MrmPg==
X-Received: by 2002:a05:6871:821:b0:234:d838:eed9 with SMTP id q33-20020a056871082100b00234d838eed9mr1433421oap.9.1714688321182;
        Thu, 02 May 2024 15:18:41 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id wz7-20020a0568707ec700b00238abc3bb0bsm339469oab.40.2024.05.02.15.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 15:18:40 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <a4307823-f834-4cea-8206-6e966bb091ff@lwfinger.net>
Date: Thu, 2 May 2024 17:18:38 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] wifi: rtw88: usb: Simplify rtw_usb_write_data
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <681e03c1-d19e-44de-bc45-e71ce14c5ed2@gmail.com>
Content-Language: en-US
In-Reply-To: <681e03c1-d19e-44de-bc45-e71ce14c5ed2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/24 4:23 PM, Bitterblue Smith wrote:
> The skb created in this function always has the same headroom,
> the chip's TX descriptor size. Use chip->tx_pkt_desc_sz directly.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
> This is the patch I promised earlier:
> https://lore.kernel.org/linux-wireless/cae2d330-a4fb-4570-9dde-09684af23ffd@gmail.com/
> ---
>   drivers/net/wireless/realtek/rtw88/usb.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/usb.c b/usb.c
> index 1dfe7c6ae4ba..ff57976b9d3b 100644
> --- a/usb.c
> +++ b/usb.c
> @@ -440,23 +440,21 @@ static int rtw_usb_write_data(struct rtw_dev *rtwdev,
>   {
>   	const struct rtw_chip_info *chip = rtwdev->chip;
>   	struct sk_buff *skb;
> -	unsigned int desclen, headsize, size;
> +	unsigned int size;
>   	u8 qsel;
>   	int ret = 0;
>    
>   	size =pkt_info->tx_pkt_size;
>   	qsel = pkt_info->qsel;
> -	desclen = chip->tx_pkt_desc_sz;
> -	headsize = pkt_info->offset ? pkt_info->offset : desclen;
>   
> -	skb = dev_alloc_skb(headsize + size);
> +	skb = dev_alloc_skb(chip->tx_pkt_desc_sz + size);
>   	if (unlikely(!skb))
>   		return -ENOMEM;
>   
> -	skb_reserve(skb, headsize);
> +	skb_reserve(skb, chip->tx_pkt_desc_sz);
>   	skb_put_data(skb, buf, size);
> -	skb_push(skb, headsize);
> -	memset(skb->data, 0, headsize);
> +	skb_push(skb, chip->tx_pkt_desc_sz);
> +	memset(skb->data, 0, chip->tx_pkt_desc_sz);
>   	rtw_tx_fill_tx_desc(pkt_info, skb);
>   	rtw_tx_fill_txdesc_checksum(rtwdev, pkt_info, skb->data);
>   
> @@ -471,12 +469,10 @@ static int rtw_usb_write_data(struct rtw_dev *rtwdev,
>   static int rtw_usb_write_data_rsvd_page(struct rtw_dev *rtwdev, u8 *buf,
>   					u32 size)
>   {
> -	const struct rtw_chip_info *chip = rtwdev->chip;
>   	struct rtw_tx_pkt_info pkt_info = {0};
>   
>   	pkt_info.tx_pkt_size = size;
>   	pkt_info.qsel = TX_DESC_QSEL_BEACON;
> -	pkt_info.offset = chip->tx_pkt_desc_sz;
>   
>   	return rtw_usb_write_data(rtwdev, &pkt_info, buf);
>   }

This patch doesn't work. When I add it and start an 8822bu, I get:

[   46.695755] usb 3-6: new high-speed USB device number 4 using xhci_hcd
[   46.844397] usb 3-6: New USB device found, idVendor=0bda, idProduct=b82c, 
bcdDevice= 2.10
[   46.844404] usb 3-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   46.844406] usb 3-6: Product: 802.11ac NIC
[   46.844408] usb 3-6: Manufacturer: Realtek
[   46.844410] usb 3-6: SerialNumber: 123456
[   47.524214] rtw_8822bu 3-6:1.2: Firmware version 27.2.0, H2C version 13
[   47.573043] rtw_8822bu 3-6:1.2: error beacon valid
[   47.573165] rtw_8822bu 3-6:1.2: failed to download rsvd page
[   47.573488] rtw_8822bu 3-6:1.2: failed to download firmware
[   47.576745] rtw_8822bu 3-6:1.2: failed to setup chip efuse info
[   47.576750] rtw_8822bu 3-6:1.2: failed to setup chip information
[   47.577302] rtw_8822bu 3-6:1.2: probe with driver rtw_8822bu failed with 
error -16

When I added code to test if chip->tx_pkt_desc_sz was equal to 
pkt_info->tx_pkt_size at entry, it reported that there was a difference.

This patch may work for some of the devices, but clearly not for all.

NACK.

Larry


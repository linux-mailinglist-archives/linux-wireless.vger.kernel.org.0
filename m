Return-Path: <linux-wireless+bounces-7136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 700A38BAA31
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 11:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01231F2216A
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 09:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A41E14F9CC;
	Fri,  3 May 2024 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxfEmklb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B5614F9D5
	for <linux-wireless@vger.kernel.org>; Fri,  3 May 2024 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730018; cv=none; b=IF9e/dy+5YSJQaG/6MuqTELte/LniALzuPT0RUXcK6VeWX6F5St2dQtTSfXQjI5IMIWVHet46cVdupY2QHzxOaNk5CZLvYqPqfL7tHdyt+9NXwb9E5t0mPMzpnZ8RI3/OVxam7L96TNbY2R5SRGM+tJZz3H2dvGLsivb2HME1pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730018; c=relaxed/simple;
	bh=v8LKdn1fON9bNe4WuzRPKpaAZektEcdWLcvzwR79wV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oo14N1WT+NQXuooK/vgk1vFlmqklsBFLYL5bW1eweM+nwnpn2Zq79T2fnAlgTwhc9105sYHeLuehuw9AB7JHHp4MH4oHlfuIrfIC9cULPv1GvIBFV5ds2alvKEdyzUhZnAACH7Tap7CKvTlTGnlxd0z79JRIqKBUtMogOAoDokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxfEmklb; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e1fa1f1d9bso25739321fa.0
        for <linux-wireless@vger.kernel.org>; Fri, 03 May 2024 02:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714730015; x=1715334815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NTxJ5I+PcoW4oFy8Sa+TL9F9Y9ux6cGLAnfUmiQYi98=;
        b=CxfEmklbdjiY7JlUcBFBrtB3ecCiH68Cw8uGcyLSNrPLYe71yaTw6qKf9ILYmKsTiO
         HwC8uXtVzQK22tsZ56sYzChIvvnrWDZzJr7JoqVRlOZvqRsKCYoxOhFqb7IG12aQlq9M
         hENfy5zghYs8U8ue0ajgimnDwHQeuZaC9TAWTzIl/v15LQ/PWeGSHfyQ6WhJCaBR0XQ6
         tjho5DUYyod+7mk7CWgx5THxPlToIamPC0J5HwsGgWaTItF8XvNyK54/T3ximL1DfNPK
         GT4BKJ6wzGcmog9uFVk73HH6M/UOvMRofWx420KQ6xF4nGfurj1r2Clz/uLJLCV4PG0n
         LuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714730015; x=1715334815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTxJ5I+PcoW4oFy8Sa+TL9F9Y9ux6cGLAnfUmiQYi98=;
        b=NV6rLhiGhfgCU1u7OLOs12eb8RTP3PNn96bUmj1IemNGQt/l6wYH2hymkbRpjmbkIz
         peSNJKZB0S1g4lrzafSjjh6lKrY6d+28ABjuHxWX/vmyGN1q+sA0+uzPrS2/bxjKbWYs
         kAAhn09UNJEmzr/oi9T1dnNdh4ouJklVy7cgMUdxG7krfcOtZCH3my6+qPerAZTFdPQ7
         AJDcxbqDs3pCdqUlR8ZHqLWwndhqEBkDuT/SYtx2SBqT/5Lu5lFv2zGlTKWnckSVFt6k
         g8JHmARMrlGOaxUmN0xtEq+59i1Z/So3E7soChjcgyttOEoR+SoZka0HxO54rH7SiVGm
         6hBg==
X-Forwarded-Encrypted: i=1; AJvYcCUbajo6Y/FXM9mAqPE7Vg/jy81hMrHmnzf6IBNyTjCvO6aqxPTrmCTnwtiwLTJGBn2UbiLLJhRJmIC9M1yk0+Bt5FtAxUnmsZXZ8Ah1OH0=
X-Gm-Message-State: AOJu0YwiI/XTuQ+WYHymTzIOX2+Srdww4LJfVUoPA8BisJH3ujblCimT
	NsqmZdRCb+ZDgQc/pzb+tZGGhF+LbMH0BfkFuQTbL1aBMgSLncml
X-Google-Smtp-Source: AGHT+IHCWKd72WzOQNpBhg/HYiE8c3lPb3E7DCRMLi1Dolgj31heKju6JR56qjfzeqTmPbnmkLPt9w==
X-Received: by 2002:a2e:a551:0:b0:2d8:5af9:90c5 with SMTP id e17-20020a2ea551000000b002d85af990c5mr2287581ljn.39.1714730014491;
        Fri, 03 May 2024 02:53:34 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id lc5-20020a170906f90500b00a599c783c04sm31537ejb.20.2024.05.03.02.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 02:53:34 -0700 (PDT)
Message-ID: <cb7db549-23bf-4c9d-be1d-4480eb8f2b77@gmail.com>
Date: Fri, 3 May 2024 12:53:32 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtw88: usb: Simplify rtw_usb_write_data
To: Larry Finger <Larry.Finger@lwfinger.net>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <681e03c1-d19e-44de-bc45-e71ce14c5ed2@gmail.com>
 <a4307823-f834-4cea-8206-6e966bb091ff@lwfinger.net>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <a4307823-f834-4cea-8206-6e966bb091ff@lwfinger.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/05/2024 01:18, Larry Finger wrote:
> On 5/2/24 4:23 PM, Bitterblue Smith wrote:
>> The skb created in this function always has the same headroom,
>> the chip's TX descriptor size. Use chip->tx_pkt_desc_sz directly.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> This is the patch I promised earlier:
>> https://lore.kernel.org/linux-wireless/cae2d330-a4fb-4570-9dde-09684af23ffd@gmail.com/
>> ---
>>   drivers/net/wireless/realtek/rtw88/usb.c | 14 +++++---------
>>   1 file changed, 5 insertions(+), 9 deletions(-)
>>
>> diff --git a/usb.c b/usb.c
>> index 1dfe7c6ae4ba..ff57976b9d3b 100644
>> --- a/usb.c
>> +++ b/usb.c
>> @@ -440,23 +440,21 @@ static int rtw_usb_write_data(struct rtw_dev *rtwdev,
>>   {
>>       const struct rtw_chip_info *chip = rtwdev->chip;
>>       struct sk_buff *skb;
>> -    unsigned int desclen, headsize, size;
>> +    unsigned int size;
>>       u8 qsel;
>>       int ret = 0;
>>          size =pkt_info->tx_pkt_size;
>>       qsel = pkt_info->qsel;
>> -    desclen = chip->tx_pkt_desc_sz;
>> -    headsize = pkt_info->offset ? pkt_info->offset : desclen;
>>   -    skb = dev_alloc_skb(headsize + size);
>> +    skb = dev_alloc_skb(chip->tx_pkt_desc_sz + size);
>>       if (unlikely(!skb))
>>           return -ENOMEM;
>>   -    skb_reserve(skb, headsize);
>> +    skb_reserve(skb, chip->tx_pkt_desc_sz);
>>       skb_put_data(skb, buf, size);
>> -    skb_push(skb, headsize);
>> -    memset(skb->data, 0, headsize);
>> +    skb_push(skb, chip->tx_pkt_desc_sz);
>> +    memset(skb->data, 0, chip->tx_pkt_desc_sz);
>>       rtw_tx_fill_tx_desc(pkt_info, skb);
>>       rtw_tx_fill_txdesc_checksum(rtwdev, pkt_info, skb->data);
>>   @@ -471,12 +469,10 @@ static int rtw_usb_write_data(struct rtw_dev *rtwdev,
>>   static int rtw_usb_write_data_rsvd_page(struct rtw_dev *rtwdev, u8 *buf,
>>                       u32 size)
>>   {
>> -    const struct rtw_chip_info *chip = rtwdev->chip;
>>       struct rtw_tx_pkt_info pkt_info = {0};
>>         pkt_info.tx_pkt_size = size;
>>       pkt_info.qsel = TX_DESC_QSEL_BEACON;
>> -    pkt_info.offset = chip->tx_pkt_desc_sz;
>>         return rtw_usb_write_data(rtwdev, &pkt_info, buf);
>>   }
> 
> This patch doesn't work. When I add it and start an 8822bu, I get:
> 
> [   46.695755] usb 3-6: new high-speed USB device number 4 using xhci_hcd
> [   46.844397] usb 3-6: New USB device found, idVendor=0bda, idProduct=b82c, bcdDevice= 2.10
> [   46.844404] usb 3-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [   46.844406] usb 3-6: Product: 802.11ac NIC
> [   46.844408] usb 3-6: Manufacturer: Realtek
> [   46.844410] usb 3-6: SerialNumber: 123456
> [   47.524214] rtw_8822bu 3-6:1.2: Firmware version 27.2.0, H2C version 13
> [   47.573043] rtw_8822bu 3-6:1.2: error beacon valid
> [   47.573165] rtw_8822bu 3-6:1.2: failed to download rsvd page
> [   47.573488] rtw_8822bu 3-6:1.2: failed to download firmware
> [   47.576745] rtw_8822bu 3-6:1.2: failed to setup chip efuse info
> [   47.576750] rtw_8822bu 3-6:1.2: failed to setup chip information
> [   47.577302] rtw_8822bu 3-6:1.2: probe with driver rtw_8822bu failed with error -16
> 
> When I added code to test if chip->tx_pkt_desc_sz was equal to pkt_info->tx_pkt_size at entry, it reported that there was a difference.
> 
> This patch may work for some of the devices, but clearly not for all.
> 
> NACK.
> 
> Larry

Thank you for testing. Indeed, the second hunk is breaking
the firmware upload.


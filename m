Return-Path: <linux-wireless+bounces-7138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1E48BAA8E
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 12:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A351F20FF7
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 10:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C72814F9DF;
	Fri,  3 May 2024 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq+hUpm6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A910353372
	for <linux-wireless@vger.kernel.org>; Fri,  3 May 2024 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714731208; cv=none; b=K1cy9QbHzPBaUhEBN0QvZdSQge95uwve8jgy9y8rDW4AV27APs9b2TXWuty/EbY6IvUTVBOk5icxQBm7YnZJHyNjlg7RWqrkVc+wJQebGlswAXu528vMZBJ2h7BAPyrV66/RvEul+5xK/yFxLAMvXcrDj/+ucKfQDJhbDO3Ixk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714731208; c=relaxed/simple;
	bh=LweS5oUODwV9ehOX2JjEnxUCCGiB33Li5M6z++MCHPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZMLzTcqeanzclhEXSxI8WIZyrdhrdkhYGSrWmOK9rVXREYvx+8OX0v5ic9110edQ7b0GISgdHI+R0UV4M9day84dVtJRX3NhDkfAseq7P1wrQ0WOxmxUfvCByKemrUl5KmYbIXcxgeWnuKf2ccK2vj6Fl6cavGcTV8C7c+jnDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zq+hUpm6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41b782405bbso55528015e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 03 May 2024 03:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714731205; x=1715336005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h17OwDD5lf6y74cOJM4kGZvM2w0eUVFWG942ECgpPjU=;
        b=Zq+hUpm6GTRsOC9547sFt0x+hbCWkC2kk5mU/4P2tOZmZ5qnNKesRlr/ACYDryvg1d
         D8yy8iahyoENk6NPeqpmt2qXcm+lL3e5eQD6mRSJmT4+/oBY/+lbDJ3ZPi9RKQpmdAFF
         bPdqnXn/bjuQ9zgWnyA94UOgxslitt2VdnaVHBNy08+w5YX8c5NRRRZroDv2a/ztokgn
         +Fujnf3zb57Svxr3CKzkYscz8vxfBoJJHRrZL/5xp1e5k5JbKNYbsT1Yby/9e2pSLkJh
         n3J9jPq93YlsdFT7BxA8otPNn/2kF8J0X+fJTJbkHPx87m6pFoZ5g55PM8PI+v1rVcZ8
         3hZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714731205; x=1715336005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h17OwDD5lf6y74cOJM4kGZvM2w0eUVFWG942ECgpPjU=;
        b=Ayh+qQGgIZa94nmk6ctI48arqFMXEnVw0pUZvHF6aXXy5izgZpmJiZP1zJrKZjC4Nf
         CHaHcuwwyNuvAExjGeDBswYhrPBX+0gdVc+lYvdG/soBx0aoBHpYaYGb1C9m90PSXQDf
         PLekjEbMrqS5Qcm4LLJZWzJ+t2+wv7YmA85C9xhsIMQCP1957DO3DSc8lLi6F6IPB4aq
         8dVatxEE5u/X52bbyw3VsQ7+bqNavgbhvu+zFxnOuBlt5GfxtEkb4MzCce94wuzNICu+
         lf6S2TFXAgizTCuEpCAjvfOObGxWQdSkKtuaWjFP+mqaruoh/YLBtqN2i35BSaTNYsod
         EO3g==
X-Forwarded-Encrypted: i=1; AJvYcCXHAg6/xN5mK1H9W8f94Rs/Ri1Wufimh4E09Tc/fm7ue2fJXHIEqsYLw9h5tpx6IyBmPbzsB3F4TcljVjB9S4M2r08erHRE+jnBV+nnwd0=
X-Gm-Message-State: AOJu0YwgqjZptzm5Y3HdZ8c8HEGFCA6jH8xTFNjR7myr4cTnkFQWg5w6
	MX1tFlJXV3aDlfLHJS8P9Krqu1NJpxujoZum6kjEO9878PvTDxPb
X-Google-Smtp-Source: AGHT+IG7WwBp3ABUgPSr6mAfUeWkrKYLjKlmpeLja33JBgmt2pOdeSAAy5+sE+RGsPjrzQXzlZhAOQ==
X-Received: by 2002:a05:600c:3d10:b0:41a:408b:dbaa with SMTP id bh16-20020a05600c3d1000b0041a408bdbaamr1894775wmb.0.1714731204879;
        Fri, 03 May 2024 03:13:24 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id j7-20020a5d5647000000b0034e52844757sm1976661wrw.95.2024.05.03.03.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 03:13:24 -0700 (PDT)
Message-ID: <55ad5c32-c818-44fc-a6a8-a95e970de8cf@gmail.com>
Date: Fri, 3 May 2024 13:13:22 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtw88: usb: Simplify rtw_usb_write_data
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Sascha Hauer <sha@pengutronix.de>
References: <681e03c1-d19e-44de-bc45-e71ce14c5ed2@gmail.com>
 <c90907baf8554581bbdb51e65dcd943e@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <c90907baf8554581bbdb51e65dcd943e@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/05/2024 03:35, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> The skb created in this function always has the same headroom,
>> the chip's TX descriptor size. Use chip->tx_pkt_desc_sz directly.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> This is the patch I promised earlier:
>> https://lore.kernel.org/linux-wireless/cae2d330-a4fb-4570-9dde-09684af23ffd@gmail.com/
>> ---
>>  drivers/net/wireless/realtek/rtw88/usb.c | 14 +++++---------
>>  1 file changed, 5 insertions(+), 9 deletions(-)
>>
>> diff --git a/usb.c b/usb.c
>> index 1dfe7c6ae4ba..ff57976b9d3b 100644
>> --- a/usb.c
>> +++ b/usb.c
>> @@ -440,23 +440,21 @@ static int rtw_usb_write_data(struct rtw_dev *rtwdev,
>>  {
>>         const struct rtw_chip_info *chip = rtwdev->chip;
>>         struct sk_buff *skb;
>> -       unsigned int desclen, headsize, size;
>> +       unsigned int size;
>>         u8 qsel;
>>         int ret = 0;
>>
>>         size = pkt_info->tx_pkt_size;
>>         qsel = pkt_info->qsel;
>> -       desclen = chip->tx_pkt_desc_sz;
>> -       headsize = pkt_info->offset ? pkt_info->offset : desclen;
>>
>> -       skb = dev_alloc_skb(headsize + size);
>> +       skb = dev_alloc_skb(chip->tx_pkt_desc_sz + size);
>>         if (unlikely(!skb))
>>                 return -ENOMEM;
>>
>> -       skb_reserve(skb, headsize);
>> +       skb_reserve(skb, chip->tx_pkt_desc_sz);
>>         skb_put_data(skb, buf, size);
>> -       skb_push(skb, headsize);
>> -       memset(skb->data, 0, headsize);
>> +       skb_push(skb, chip->tx_pkt_desc_sz);
>> +       memset(skb->data, 0, chip->tx_pkt_desc_sz);
>>         rtw_tx_fill_tx_desc(pkt_info, skb);
>>         rtw_tx_fill_txdesc_checksum(rtwdev, pkt_info, skb->data);
>>
>> @@ -471,12 +469,10 @@ static int rtw_usb_write_data(struct rtw_dev *rtwdev,
>>  static int rtw_usb_write_data_rsvd_page(struct rtw_dev *rtwdev, u8 *buf,
>>                                         u32 size)
>>  {
>> -       const struct rtw_chip_info *chip = rtwdev->chip;
>>         struct rtw_tx_pkt_info pkt_info = {0};
>>
>>         pkt_info.tx_pkt_size = size;
>>         pkt_info.qsel = TX_DESC_QSEL_BEACON;
>> -       pkt_info.offset = chip->tx_pkt_desc_sz;
> 
> pkt_info.offset is still used by rtw_tx_fill_tx_desc(), so you can't remove
> this line. I think this is because Larry NAKed this patch. 
> 

Yes, that's the problem. I will send v2 without this hunk.


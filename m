Return-Path: <linux-wireless+bounces-24244-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7909EADE996
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 13:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951F6166194
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 11:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C86288C9F;
	Wed, 18 Jun 2025 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlgvzVfB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965A3288520
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750244781; cv=none; b=JqooBjLaIVHCQFk+fBY8q7BIja/hhCqvQ6DmXiMU5AIzvmTKWX04j69pD6uBVEIlA3gD5+VKzupslkIBRljaD1QfK7JI16vcSN0zXC5JAdoP8v5j7Cij8OnNGbyxN9iK//wDnr+tRq6b89hS+ES8Yu4icllMrTqvuVvKO13Ybe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750244781; c=relaxed/simple;
	bh=S37iUxfetdZSfbSYrSEZIVgEOuPLmREVCGogNXDjj/o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=tpOCUXarloK9dqu03ea9yxgi8Oq1WlpHRCNCRVh1yfcp2zwS5ssXULPaRpTswV0orExILppd2HOf05wyt7Ar2eUpK+9NL5W5NsQpwvdi8dETaqu6vZzQYzdgqQzpEmRDGGAh+57i7Gxzwu6M1LYd/AuaO+DhIXqB+LMRbO9q078=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlgvzVfB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-450cfb79177so41570095e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 04:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750244777; x=1750849577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQ8n/JBJXvOEi2RZsPLlwTWlNzGZ/OHz/HZTSKTxzD4=;
        b=nlgvzVfBGuuAUlBHOM/LVZvUqDXgjTM9tMP3sLowzz4uyhH6P5+QuwY+iH6EXb1tpv
         d1BVHgrnUMV8PGkthlGys/lfaaf886AE1C/ooiJYJ6Lk81xQx56njqCA23BIygadM/Qh
         HWM+E/vKVqOqJefla6JP+PuEd2TL36UehlrZZqdhKozp6EP8g4fEn8PRwVnLrT00bxNx
         QCiXV6iHHmi1VZ+vS32vqfHkB+OmnxJ/7qhWHhjoPvzRdh5ij+KcMmBiZam5RQi4TBhU
         TuCGVqT6pebuDSvefX4bxg08lM0bu16lzwYU3pwFZXe3iD7hx0WvUbmSgs/5GifyvCO9
         F7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750244777; x=1750849577;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQ8n/JBJXvOEi2RZsPLlwTWlNzGZ/OHz/HZTSKTxzD4=;
        b=ROhW4fj0O9B1rjF/2+Lht3otRGkhUtCkgx/CDc3a/fM8Zux1A/gdcxQtWuPkALfirc
         Fr7zAEZWYdW4H826fPlYlkP7KqaD3lcizSaK5vY75mmRK5z8eiQZBKEmETYxfzcw7GvU
         LPLjfBA2xBpjzDcmJDsBjCBvdIKVRzDe4hx5He30KmEWyOl6wHty33k57LtV56dDGKYf
         LSr19ifjWsBcdW50GBw3zixRLjizXh0m05t1pJZPoG0DB7fwYWdbvneOOjebbZI2sW3v
         qwFyMx0I4RZdM6/U7X3CsKz/Lhwu135luX5POBmZaIoRc3du5SL6fLMYuEaexjnBiBtZ
         o7JA==
X-Forwarded-Encrypted: i=1; AJvYcCWHE0CKkIeQH2hvXseRY9K6MIf7ZAk3B+Se2yMgRLIRQGkjgk3RtjNsHrHx/DrWbymxT4MtZmIanJ2kU82PAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQ3q/dEscOtT98vkjz5kzB+TiRCf2K9MeOimxdil0RCzzOdQZ
	kQE4NLlaAvIUbM5wFb5eX5HFCLJFlWcbBxuu9NkyPmIvgb+gSweZXq9b
X-Gm-Gg: ASbGncvLf+JqHicfEyHHb9rlnPyT00VFkdP04NWWCLTohq2jZFCdc1wzDV7/Hzk1VKU
	pIfvIg/g4y+uoKBd7w2O1y/3k6HokxvRsZ8OZ60v/qSkEUFwVfFdvwuNYmTYGF83/rzPsGYtVgJ
	I7GFN06Tpr7dMEp691lt7CSHu6Zw5LM2+tQRXQPJ3QELW9sT3bxBVu5IjttOhITC8cCcJ3nzHLi
	Am0FgzT4JBHEQAI2OXefwsZESrM6UqGxPaZXfeSKhSkPZvhtHlg4xT/891xpI5gOz+HVIBXmqsQ
	hMV8mOpH1+TSbKSromhUyZHhpBsAxiQ/hEdnW8487XlFmt3Ppadhs4L9MOm1bAmnHJp7peh1tHL
	BfZbh
X-Google-Smtp-Source: AGHT+IFHt+0XfjtlOUtzC22cq1u6WAWTb1iB0lsELMO8Fkja8XpF6yXZdSHEh3XSE9MIl0a2c7V1Zw==
X-Received: by 2002:a05:600c:c169:b0:445:49e:796b with SMTP id 5b1f17b1804b1-4533cad3ccemr178056325e9.17.1750244776615;
        Wed, 18 Jun 2025 04:06:16 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e261a72sm201924825e9.38.2025.06.18.04.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 04:06:16 -0700 (PDT)
Message-ID: <c0bc00de-38fb-4e87-af66-1a10e56f19eb@gmail.com>
Date: Wed, 18 Jun 2025 14:06:15 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw-next v2 12/14] wifi: rtw89: Add usb.{c,h}
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
 <3bde86a3-0aa3-4a36-8d26-f87cc0bf73cb@gmail.com>
 <74737a34bdee467cb0abb614c7b7ab17@realtek.com>
Content-Language: en-US
In-Reply-To: <74737a34bdee467cb0abb614c7b7ab17@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/06/2025 06:10, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Add very basic USB support. No TX/RX aggregation, no TX queues, no
>> switching to USB 3 mode.
>>
>> RTL8851BU and RTL8832BU work.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Some minor suggestions. 
> 
> [...]
> 
>> +static void rtw89_usb_vendorreq(struct rtw89_dev *rtwdev, u32 addr,
>> +                               void *data, u16 len, u8 reqtype)
>> +{
>> +       struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
>> +       struct usb_device *udev = rtwusb->udev;
>> +       unsigned int pipe;
>> +       u16 value, index;
>> +       int attempt, ret;
>> +
>> +       if (test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
>> +               return;
>> +
>> +       value = u32_get_bits(addr, GENMASK(15, 0));
>> +       index = u32_get_bits(addr, GENMASK(23, 16));
>> +
>> +       for (attempt = 0; attempt < 10; attempt++) {
>> +               *rtwusb->vendor_req_buf = 0;
>> +
>> +               if (reqtype == RTW89_USB_VENQT_READ) {
>> +                       pipe = usb_rcvctrlpipe(udev, 0);
>> +               } else { /* RTW89_USB_VENQT_WRITE */
>> +                       pipe = usb_sndctrlpipe(udev, 0);
>> +
>> +                       memcpy(rtwusb->vendor_req_buf, data, len);
>> +               }
>> +
>> +               ret = usb_control_msg(udev, pipe, RTW89_USB_VENQT, reqtype,
>> +                                     value, index, rtwusb->vendor_req_buf,
>> +                                     len, 500);
>> +
>> +               if (ret == len) { /* Success */
>> +                       atomic_set(&rtwusb->continual_io_error, 0);
>> +
>> +                       if (reqtype == RTW89_USB_VENQT_READ)
>> +                               memcpy(data, rtwusb->vendor_req_buf, len);
>> +
>> +                       break;
>> +               }
>> +
>> +               if (ret == -ESHUTDOWN || ret == -ENODEV)
>> +                       set_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags);
>> +               else if (ret < 0)
>> +                       rtw89_warn(rtwdev,
>> +                                  "usb %s%u 0x%x fail ret=%d value=0x%x attempt=%d\n",
>> +                                  reqtype == RTW89_USB_VENQT_READ ? "read" : "write",
>> +                                  len * 8, addr, ret,
>> +                                  le32_to_cpup(rtwusb->vendor_req_buf),
> 
> vendor_req_buf isn't always set fully (4 bytes), it would print out partially
> incorrect value. Would you like `%*ph` format with variable length? Like
>   "value=%*ph", len, rtwusb->vendor_req_buf
> 

I think it's fine the way it is because vendor_req_buf is zeroed
at the beginning of the for loop.

>> +                                  attempt);
>> +               else if (ret > 0 && reqtype == RTW89_USB_VENQT_READ)
>> +                       memcpy(data, rtwusb->vendor_req_buf, len);
>> +
>> +               if (atomic_inc_return(&rtwusb->continual_io_error) > 4) {
>> +                       set_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags);
>> +                       break;
>> +               }
>> +       }
>> +}
>> +
> 
> [...]
> 
>> +
>> +static int rtw89_usb_fwcmd_submit(struct rtw89_dev *rtwdev,
>> +                                 struct rtw89_core_tx_request *tx_req)
>> +{
>> +       struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
>> +       struct rtw89_usb_tx_ctrl_block *txcb;
>> +       struct sk_buff *skb = tx_req->skb;
>> +       int txdesc_size = rtwdev->chip->h2c_desc_size;
>> +       void *txdesc;
>> +       int ret;
>> +
>> +       if (((desc_info->pkt_size + txdesc_size) % 512) == 0) {
>> +               rtw89_info(rtwdev, "avoiding multiple of 512\n");
>> +               desc_info->pkt_size += 4;
>> +               skb_put(skb, 4);
>> +       }
>> +
>> +       txcb = kmalloc(sizeof(*txcb), GFP_ATOMIC);
>> +       if (!txcb)
>> +               return -ENOMEM;
>> +
>> +       txdesc = skb_push(skb, txdesc_size);
>> +       memset(txdesc, 0, txdesc_size);
>> +       rtw89_chip_fill_txdesc_fwcmd(rtwdev, desc_info, txdesc);
>> +
>> +       txcb->rtwdev = rtwdev;
>> +       skb_queue_head_init(&txcb->tx_ack_queue);
>> +
>> +       skb_queue_tail(&txcb->tx_ack_queue, skb);
>> +
>> +       ret = rtw89_usb_write_port(rtwdev, RTW89_DMA_H2C, skb->data, skb->len,
>> +                                  rtw89_usb_write_port_complete_fwcmd, txcb);
>> +
> 
> nit: no need empty line 
> 
>> +       if (ret) {
>> +               rtw89_err(rtwdev, "%s failed: %d\n", __func__, ret);
>> +
>> +               skb_dequeue(&txcb->tx_ack_queue);
>> +               kfree(txcb);
>> +       }
>> +
>> +       return ret;
>> +}
>> +
> 
> [...]
> 
>> +
>> +static void rtw89_usb_rx_handler(struct work_struct *work)
>> +{
>> +       struct rtw89_usb *rtwusb = container_of(work, struct rtw89_usb, rx_work);
>> +       struct rtw89_dev *rtwdev = rtwusb->rtwdev;
>> +       struct rtw89_rx_desc_info desc_info;
>> +       struct sk_buff *rx_skb;
>> +       struct sk_buff *skb;
>> +       u32 pkt_offset;
>> +       int limit;
>> +
>> +       for (limit = 0; limit < 200; limit++) {
>> +               rx_skb = skb_dequeue(&rtwusb->rx_queue);
>> +               if (!rx_skb)
>> +                       break;
>> +
>> +               if (skb_queue_len(&rtwusb->rx_queue) >= RTW89_USB_MAX_RXQ_LEN) {
>> +                       rtw89_warn(rtwdev, "rx_queue overflow\n");
>> +                       dev_kfree_skb_any(rx_skb);
>> +                       continue;
>> +               }
>> +
>> +               memset(&desc_info, 0, sizeof(desc_info));
>> +               rtw89_chip_query_rxdesc(rtwdev, &desc_info, rx_skb->data, 0);
>> +
>> +               skb = rtw89_alloc_skb_for_rx(rtwdev, desc_info.pkt_size);
>> +               if (!skb) {
>> +                       rtw89_debug(rtwdev, RTW89_DBG_HCI,
>> +                                   "failed to allocate RX skb of size %u\n",
>> +                                   desc_info.pkt_size);
>> +                       continue;
>> +               }
>> +
>> +               pkt_offset = desc_info.offset + desc_info.rxd_len;
>> +
>> +               skb_put_data(skb, rx_skb->data + pkt_offset,
>> +                            desc_info.pkt_size);
>> +
>> +               rtw89_core_rx(rtwdev, &desc_info, skb);
>> +
>> +               if (skb_queue_len(&rtwusb->rx_free_queue) >= RTW89_USB_RX_SKB_NUM)
>> +                       dev_kfree_skb_any(rx_skb);
>> +               else
>> +                       skb_queue_tail(&rtwusb->rx_free_queue, rx_skb);
>> +       }
>> +
>> +       if (limit == 200)
> 
> Not sure if it is worth to reschedule itself again under this condition?
> 

I guess it can't hurt.

>> +               rtw89_debug(rtwdev, RTW89_DBG_HCI,
>> +                           "left %d rx skbs in the queue for later\n",
>> +                           skb_queue_len(&rtwusb->rx_queue));
>> +}
>> +
> 
> [...]
> 
>> +static int rtw89_usb_intf_init(struct rtw89_dev *rtwdev,
>> +                              struct usb_interface *intf)
>> +{
>> +       struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
>> +       int ret;
>> +
>> +       ret = rtw89_usb_parse(rtwdev, intf);
>> +       if (ret)
>> +               return ret;
>> +
>> +       rtwusb->vendor_req_buf = kmalloc(sizeof(u32), GFP_KERNEL);
> 
> sizeof(*rtwusb->vendor_req_buf) or sizeof(__le32)
> 
>> +       if (!rtwusb->vendor_req_buf)
>> +               return -ENOMEM;
>> +
>> +       rtwusb->udev = usb_get_dev(interface_to_usbdev(intf));
>> +
>> +       usb_set_intfdata(intf, rtwdev->hw);
>> +
>> +       SET_IEEE80211_DEV(rtwdev->hw, &intf->dev);
>> +
>> +       return 0;
>> +}
>> +
> 
> 
> [...]
> 



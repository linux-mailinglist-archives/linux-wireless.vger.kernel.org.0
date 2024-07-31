Return-Path: <linux-wireless+bounces-10760-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D7D94348F
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 18:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D367284EB3
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 16:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDA134CDE;
	Wed, 31 Jul 2024 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXyvw6rp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD012B93
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445131; cv=none; b=hMzb5bno9w0YSyqC8rJHXivDMM2mtm6uXFD51FQHuxpTmWV0nmRr4f4OkQ12XKnrjHiGpdyDysepdMAQ2koYj+VxuWe8/KZOfopMgVR49q+/HmJjET/DKhGaIaxaRpCj+kmQ8bpcIlbZbXvYFCLXXl6heH1hbYnGW5v61agpFjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445131; c=relaxed/simple;
	bh=vzKungwENAvqS2+kmIh74VrDthm2l7CjdNw8ZJCNmpw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cl0OrFnQQoGrJYs1bBAWz1ZcCWrW8i4wvpnIvqN4/5k89dfIrKlYg3Yj2VkF63O5xWaLYyoWz0mCPeXyF9YIkHQEE3LA2r1GG3zeAHuOVaxLyefmUkgtBBCRQCW8ZL08swGBRa48QgKk3ID+Fp8onj52H9LAWQ6P4dCnjkl+qfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXyvw6rp; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso478865266b.3
        for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722445128; x=1723049928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EJSjfKUpNR8XkrdgB6gstr/Zqkhu3Ag2kAo0e2gawTY=;
        b=gXyvw6rpcJDAtaDAo8ksd7fg4uXOYDoKVgqiZ3OooyphBnJRUFeR74fnFDQm6PS14j
         lwQhbdkwGIahN8jww13dD7ORbYXEaAFRa3cJNSYzLd7Xf/0c47/4oSAkO7b/0ui98vc+
         UgQ6y3v7le8jzqhkSMN8EWWOrIpTYM30cuI7fLVNV3EiZ0eFy9Yhj1wIopjcYZEaV3zH
         Djx0X2xFVmMmWKllMzORaiXxIi4E2caPwtcZ0KIX9W7GKm0ow4mJiWP/EIx2l0BS/wxX
         WrT79QkIytWjzG+8w5ijfA9U2g1GdhMI6AFEKnKYWb1BesoubkL2sQXfk/8z8unVQr/k
         lYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722445128; x=1723049928;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJSjfKUpNR8XkrdgB6gstr/Zqkhu3Ag2kAo0e2gawTY=;
        b=oa/Nc/eLFSwoaX2ykCWYTRyGIs7CV+sBtRdtvN+dsNUYpGV9gEL0fBL9AVwgkALba/
         25islRfqe+RoNyD0j0+2nh1WKukeEb4rvlH4spc8vxP2UnsoJI+hj0lORTOpUg8rAAmf
         eNDWygQSE9qgroOh0aN7mdnGS8nQNbezoAMhRg0LIQ6m+NIi/MmDEtBpUMOBococMHKF
         7QjohSpyf6EEeM4xRH8PyLlw7+j8C3JRAlXwEgF3dbzXv8PuRcvNCx4YEJv0v7L7k51L
         oFAawQiaj/OGhzCKJPjE0yg++VFW/aQyz99z5DwSASS7TIsggCJGaQD7PwmrSlqB9u/C
         Uu3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNypFxsNo+VNS3MFjHQRRJH3EqbihTl9adfbtGgMylvt6wL3HjgOvMSCQm77+PIPW/9JPY8SmvjgVut7GWbTw04i2l+a9qMuJ90mtYKy8=
X-Gm-Message-State: AOJu0Yw7lDS7bZzshyhUXQSznCeumpM1ulcXLfTdP3ZZYrtXtDsVKfWG
	pOR1J9zvjUO9l3u3X09HspAvNd7l9EZe2nQVCwR3Q17X/Nh1q37+
X-Google-Smtp-Source: AGHT+IGVe4iwPTyYZtvgjpWfLTErjsMvDR78nyg6DkFiaHmuZi6ipIxwsBDkC75Qj0WlNuklDtLG9g==
X-Received: by 2002:a17:907:3203:b0:a7a:ca07:1de3 with SMTP id a640c23a62f3a-a7d4014c5camr1172143266b.56.1722445127686;
        Wed, 31 Jul 2024 09:58:47 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4de6fsm794921366b.63.2024.07.31.09.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 09:58:47 -0700 (PDT)
Message-ID: <5818af41-36ad-4947-bab2-e29cd7207049@gmail.com>
Date: Wed, 31 Jul 2024 19:58:45 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 3/4] wifi: rtw88: usb: Support RX aggregation
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Sascha Hauer <sha@pengutronix.de>
References: <c03390ce-34c2-42dd-9bd6-b231bb1f2fae@gmail.com>
 <a549707a-09f4-4787-8111-65cc266675d6@gmail.com>
 <4722139b12d443a1a62927a408344a66@realtek.com>
Content-Language: en-US
In-Reply-To: <4722139b12d443a1a62927a408344a66@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/07/2024 07:33, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>
>> The chips can be configured to aggregate several frames into a single
>> USB transfer. Modify rtw_usb_rx_handler() to support this case.
>>
>> RX aggregation improves the RX speed on certain ARM systems, like the
>> NanoPi NEO Core2.
>>
>> Currently none of the chips are configured to aggregate frames.
>>
>> Tested with RTL8811CU and RTL8723DU.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw88/usb.c | 57 +++++++++++++++---------
>>  1 file changed, 37 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
>> index 73948078068f..d61be1029a7b 100644
>> --- a/drivers/net/wireless/realtek/rtw88/usb.c
>> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
>> @@ -546,11 +546,12 @@ static void rtw_usb_rx_handler(struct work_struct *work)
>>         struct rtw_usb *rtwusb = container_of(work, struct rtw_usb, rx_work);
>>         struct rtw_dev *rtwdev = rtwusb->rtwdev;
>>         const struct rtw_chip_info *chip = rtwdev->chip;
>> -       struct rtw_rx_pkt_stat pkt_stat;
>> +       u32 pkt_desc_sz = chip->rx_pkt_desc_sz;
>>         struct ieee80211_rx_status rx_status;
>> +       u32 pkt_offset, next_pkt, urb_len;
>> +       struct rtw_rx_pkt_stat pkt_stat;
>> +       struct sk_buff *next_skb = NULL;
>>         struct sk_buff *skb;
>> -       u32 pkt_desc_sz = chip->rx_pkt_desc_sz;
>> -       u32 pkt_offset;
>>         u8 *rx_desc;
>>         int limit;
>>
>> @@ -559,29 +560,44 @@ static void rtw_usb_rx_handler(struct work_struct *work)
>>                 if (!skb)
>>                         break;
>>
>> -               rx_desc = skb->data;
>> -               chip->ops->query_rx_desc(rtwdev, rx_desc, &pkt_stat,
>> -                                        &rx_status);
>> -               pkt_offset = pkt_desc_sz + pkt_stat.drv_info_sz +
>> -                            pkt_stat.shift;
>> -
>> -               if (pkt_stat.is_c2h) {
>> -                       skb_put(skb, pkt_stat.pkt_len + pkt_offset);
>> -                       rtw_fw_c2h_cmd_rx_irqsafe(rtwdev, pkt_offset, skb);
>> -                       continue;
>> -               }
>> -
>>                 if (skb_queue_len(&rtwusb->rx_queue) >= RTW_USB_MAX_RXQ_LEN) {
>>                         dev_dbg_ratelimited(rtwdev->dev, "failed to get rx_queue, overflow\n");
>>                         dev_kfree_skb_any(skb);
>>                         continue;
>>                 }
>>
>> -               skb_put(skb, pkt_stat.pkt_len);
>> -               skb_reserve(skb, pkt_offset);
>> -               rtw_rx_stats(rtwdev, pkt_stat.vif, skb);
>> -               memcpy(skb->cb, &rx_status, sizeof(rx_status));
>> -               ieee80211_rx_irqsafe(rtwdev->hw, skb);
>> +               urb_len = skb->len;
>> +
>> +               do {
>> +                       rx_desc = skb->data;
>> +                       chip->ops->query_rx_desc(rtwdev, rx_desc, &pkt_stat,
>> +                                                &rx_status);
>> +                       pkt_offset = pkt_desc_sz + pkt_stat.drv_info_sz +
>> +                                    pkt_stat.shift;
>> +
>> +                       next_pkt = round_up(pkt_stat.pkt_len + pkt_offset, 8);
>> +
>> +                       if (urb_len >= next_pkt + pkt_desc_sz)
>> +                               next_skb = skb_clone(skb, GFP_KERNEL);
>> +
>> +                       if (pkt_stat.is_c2h) {
>> +                               skb_trim(skb, pkt_stat.pkt_len + pkt_offset);
>> +                               rtw_fw_c2h_cmd_rx_irqsafe(rtwdev, pkt_offset, skb);
>> +                       } else {
>> +                               skb_pull(skb, pkt_offset);
>> +                               skb_trim(skb, pkt_stat.pkt_len);
>> +                               rtw_rx_stats(rtwdev, pkt_stat.vif, skb);
>> +                               memcpy(skb->cb, &rx_status, sizeof(rx_status));
>> +                               ieee80211_rx_irqsafe(rtwdev->hw, skb);
>> +                       }
>> +
>> +                       skb = next_skb;
>> +                       if (skb)
>> +                               skb_pull(next_skb, next_pkt);
>> +
>> +                       urb_len -= next_pkt;
> 
> I would like a checking to prevent underflow caused by unexpected hardware data.
> 

There is a check above: if (urb_len >= next_pkt + pkt_desc_sz)
If this check fails, skb becomes NULL and the loop stops.

>> +                       next_skb = NULL;
>> +               } while (skb && urb_len >= pkt_desc_sz);>>         }
>>  }
>>
>> @@ -625,6 +641,7 @@ static void rtw_usb_read_port_complete(struct urb *urb)
>>                         if (skb)
>>                                 dev_kfree_skb_any(skb);
>>                 } else {
>> +                       skb_put(skb, urb->actual_length);
>>                         skb_queue_tail(&rtwusb->rx_queue, skb);
>>                         queue_work(rtwusb->rxwq, &rtwusb->rx_work);
>>                 }
>> --
>> 2.45.2
> 



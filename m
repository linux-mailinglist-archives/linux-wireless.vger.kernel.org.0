Return-Path: <linux-wireless+bounces-16268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5599ED47B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 19:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB96280AC3
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 18:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F56246344;
	Wed, 11 Dec 2024 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcIuBPKh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81361BD9CA
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733940429; cv=none; b=MYLpSfxtGWvyoY9fuBRGYBcUUkY0/KEwTvPmcg+DwpSjFc3VrReqVAz9+HH3W17j++kkt3hOBN/QKdT/9ewjXjUa0H/h64Hv4F7B3c2cdiVPLFP4XaIUhQbW7g7YM0EKMxr7ccP6WS3qnwUvmeZ9sYQuQBQikYF/znZCStm8/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733940429; c=relaxed/simple;
	bh=jIp6BKgc5riWf30p+6NdJLtLqfhUE1vaIBCp9EwmpbE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Lgz0dGGCDhG4mNTMnMaX3e1aCilQUByR9I4GP+HxQImSKBbrxHry4LhXEoy276JdtlhlkN0RV2Nr5SH9Y5h8kA0EnvB343Fd+exuNS0uHgD5NKzXT3XPZjTJvHdo3RKSRzxSl9eKkqMNLdFMjdTMrZZA27m6Jnb01mrc4WI2O3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcIuBPKh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa679ad4265so187413866b.0
        for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 10:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733940426; x=1734545226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=URwMuho4Be2SL+q2rQ/Phlv7EhxNk6teEeqfMb/gj28=;
        b=WcIuBPKh+RHjESWnKMVXK0eWsDEbJFAEOHd99qR4sY0gOLQhs5np9FIzqIGOIRv1YI
         gIeV2el3At+lasQljZWVqYhyfimg30tU3Y4tdFxSi3kcppIqaeDSxfXRfc5kPSGa9Y/6
         VIIzgpmrRTSj5cfcVzJTWhARAnIN1mUFMzltI4N3bNv+Qkzy3mf3Z/tI/dzM4b7yeC9a
         KLaYUdgNuDZs4RHOMZalJLr+aXehI2KgpCPRMPuQpiXOPj5CyNWaY4yR812JScMdaFSw
         ooiNJU9eA9NSig5uk+Y9P5taCBvcdsVI+DE0Ils/7YrtDa1vmm+D/4xlSGr+a4Em6Rh/
         1l3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733940426; x=1734545226;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URwMuho4Be2SL+q2rQ/Phlv7EhxNk6teEeqfMb/gj28=;
        b=EfkIGa9brDl1NTuktw2z8ZcHzLemU7nAC1QY+pCYiE9tiKOnqiT3jyfeR/KCFrDqhR
         RdzN6BFUdFn1Ij8SPB2Wh6IyG34qVUjtQ7lRYCT37WxVhj7HfaRRFWHfDdtfqdaaWo2I
         RpX2NkU3g81U3UKvIYXxvFrvmD40Yw12siCFWLDNX4AkzYta/kunGC4rODFOigL0mn/B
         kFT4UJkdh6k2qfw2J5e0sFKI8OzIx1kAnNJb7TGCxvu2vyPb6pW/LfY7cA1JWUQfYzHp
         0VpNeR39zFsfj2VGf8183Tw8QtmyICLSmQMQPqyRVEbGuM7oYdYqOB2SLz/7XLDo9wR3
         z1HA==
X-Forwarded-Encrypted: i=1; AJvYcCXEnVtq2Nrhurxpk1jFLS5KkupJMsQJ1W3tDDextdNLqsF0cCrYuZsv3mC+TjZSD9nSfjvKEFqmiFu1Qs00Ng==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNkk+7ai2Pkzp8Cv6k+ikqc7Tlc41ZsKc5Eng266WeZgrmjpzK
	MbKuQEiwFh+534zEZ7SwikAIV+DVwdCqLz5Asrhi4Qad3DUHr7Kp
X-Gm-Gg: ASbGncug1EgD5HpukfZtZvRM6wOJ8T/SnjYy7clR2GN5OaPTTIkvw+e/yaPL282UuOk
	Yk9K/vtu+R+N0wMlUqbIQw5BuNuFyppqnInOS1xt1OE6krobTe0DSs08vJXB2fjslejQbgrLxxn
	CZrXor7+7x/L8KSbkx0A/Q116F5Shu6RwMUVQneRpYHV+K+JA+3Wd8EPEktfoLmZKGULNQWHqqk
	+umCTm/a4EYgbdM3G8ifulklt6yGxIQobsd6dlrEGggGNLuV9xEwFzBsuKBJhU=
X-Google-Smtp-Source: AGHT+IGKbfXgwK/EeRUvBNXDq5JNtZs7RFi1B/YMZ9l/V35q5mmmK59GVL0nbt3ZBwEInArj64fLXQ==
X-Received: by 2002:a17:907:7da0:b0:aa6:bedc:2e4c with SMTP id a640c23a62f3a-aa6c40bb599mr28620966b.3.1733940425431;
        Wed, 11 Dec 2024 10:07:05 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa674a112c7sm607827066b.147.2024.12.11.10.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 10:07:05 -0800 (PST)
Message-ID: <03f70884-fdc9-4523-b882-2b6b61e48133@gmail.com>
Date: Wed, 11 Dec 2024 20:07:02 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 2/2] wifi: rtw88: usb: Preallocate and reuse the RX skbs
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Sascha Hauer <sha@pengutronix.de>
References: <28b09f4d-5271-470d-99b6-a0bbe0224739@gmail.com>
 <4e83ae71-60e2-4f24-a251-18cd59543d6d@gmail.com>
 <3a9104bb97db4df6a285e94291fd84c7@realtek.com>
 <1546573d-ce4d-4629-8d05-925fff079493@gmail.com>
 <e467e5003335418cab2f90807ce07b7a@realtek.com>
Content-Language: en-US
In-Reply-To: <e467e5003335418cab2f90807ce07b7a@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2024 03:26, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 19/11/2024 02:50, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>> The USB driver uses four USB Request Blocks for RX. Before submitting
>>>> one, it allocates a 32768 byte skb for the RX data. This allocation can
>>>> fail, maybe due to temporary memory fragmentation. When the allocation
>>>> fails, the corresponding URB is never submitted again. After four such
>>>> allocation failures, all RX stops because the driver is not requesting
>>>> data from the device anymore.
>>>>
>>>> Don't allocate a 32768 byte skb when submitting a USB Request Block
>>>> (which happens very often). Instead preallocate 8 such skbs, and reuse
>>>> them over and over. If all 8 are busy, allocate a new one. This is
>>>> pretty rare. If the allocation fails, use a work to try again later.
>>>> When there are enough free skbs again, free the excess skbs.
>>>>
>>>> Also, use WQ_BH for the RX workqueue. With a normal or high priority
>>>> workqueue the skbs are processed too slowly when the system is even a
>>>> little busy, like when opening a new page in a browser, and the driver
>>>> runs out of free skbs and allocates a lot of new ones.
>>>>
>>>> Move C2H_ADAPTIVITY to the c2h workqueue instead of handling it directly
>>>> from rtw_fw_c2h_cmd_rx_irqsafe(), which runs in the RX workqueue. It
>>>> reads hardware registers, which is not "irqsafe" with USB.
>>>
>>> This part should be in a separated patch.
>>>
>>
>> Do you mean just C2H_ADAPTIVITY or WQ_BH as well?
> 
> Just C2H_ADAPTIVITY.
> 
> With patch subject, people can't understand this change. 
> 
>>
>>>>
>>>> This is more or less what the out-of-tree Realtek drivers do, except
>>>> they use a tasklet instead of a BH workqueue.
>>>>
>>>> Tested with RTL8723DU, RTL8821AU, RTL8812AU, RTL8812BU, RTL8822CU,
>>>> RTL8811CU.
>>>>
>>>> Closes: https://lore.kernel.org/linux-wireless/6e7ecb47-7ea0-433a-a19f-05f88a2edf6b@gmail.com/
>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>> ---
>>>>  drivers/net/wireless/realtek/rtw88/fw.c  |  7 +--
>>>>  drivers/net/wireless/realtek/rtw88/usb.c | 73 ++++++++++++++++++++----
>>>>  drivers/net/wireless/realtek/rtw88/usb.h |  3 +
>>>>  3 files changed, 67 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
>>>> index e6e9946fbf44..02389b7c6876 100644
>>>> --- a/drivers/net/wireless/realtek/rtw88/fw.c
>>>> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
>>>> @@ -332,6 +332,9 @@ void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
>>>>         case C2H_RA_RPT:
>>>>                 rtw_fw_ra_report_handle(rtwdev, c2h->payload, len);
>>>>                 break;
>>>> +       case C2H_ADAPTIVITY:
>>>> +               rtw_fw_adaptivity_result(rtwdev, c2h->payload, len);
>>>> +               break;
>>>>         default:
>>>>                 rtw_dbg(rtwdev, RTW_DBG_FW, "C2H 0x%x isn't handled\n", c2h->id);
>>>>                 break;
>>>> @@ -367,10 +370,6 @@ void rtw_fw_c2h_cmd_rx_irqsafe(struct rtw_dev *rtwdev, u32 pkt_offset,
>>>>                 rtw_fw_scan_result(rtwdev, c2h->payload, len);
>>>>                 dev_kfree_skb_any(skb);
>>>>                 break;
>>>> -       case C2H_ADAPTIVITY:
>>>> -               rtw_fw_adaptivity_result(rtwdev, c2h->payload, len);
>>>> -               dev_kfree_skb_any(skb);
>>>> -               break;
>>>>         default:
>>>>                 /* pass offset for further operation */
>>>>                 *((u32 *)skb->cb) = pkt_offset;
>>>> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
>>>> index 727569d4ef4b..5c2dfa2ced92 100644
>>>> --- a/drivers/net/wireless/realtek/rtw88/usb.c
>>>> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
>>>> @@ -585,7 +585,7 @@ static void rtw_usb_rx_handler(struct work_struct *work)
>>>>                                 goto skip_packet;
>>>>                         }
>>>>
>>>> -                       skb = alloc_skb(skb_len, GFP_KERNEL);
>>>> +                       skb = alloc_skb(skb_len, GFP_ATOMIC);
>>>>                         if (!skb) {
>>>>                                 rtw_dbg(rtwdev, RTW_DBG_USB,
>>>>                                         "failed to allocate RX skb of size %u\n",
>>>> @@ -612,7 +612,11 @@ static void rtw_usb_rx_handler(struct work_struct *work)
>>>>                         rx_desc += next_pkt;
>>>>                 } while (rx_desc + pkt_desc_sz < rx_skb->data + rx_skb->len);
>>>>
>>>> -               dev_kfree_skb_any(rx_skb);
>>>> +               if (skb_queue_len(&rtwusb->rx_free_queue) >=
>>>> +                   RTW_USB_RX_SKB_NUM - RTW_USB_RXCB_NUM)
>>>> +                       dev_kfree_skb_any(rx_skb);
>>>> +               else
>>>> +                       skb_queue_tail(&rtwusb->rx_free_queue, rx_skb);
>>>
>>> Why not just queue and reuse rx_skb for all? That would be simpler.
>>>
>>
>> I didn't want to let it allocate too many skbs. I didn't find any kind
>> of limit in the official drivers, so maybe it would be fine.
> 
> The case ' skb_queue_len(&rtwusb->rx_free_queue) >= 8 - 4' is rare? 
> If so, I think this is fine. If not, to repeatedly allocate and free 
> would cause memory fragment, and higher probability to failed to allocate
> memory with GFP_ATOMIC. Also seemingly additional 4 persistent rx_skb
> is not a big cost. 
> 
> 

I feel like it's rare for me, but I never counted how often it happens.

Someone else reported that in a period of 14.5 hours additional skbs
were allocated and freed 295 times. This is their log:
https://github.com/user-attachments/files/17792914/dmesg_grep_rtw_8821au.txt
This computer has i7-6700 CPU with 32 GB of RAM.

Another user reported that additional skbs were allocated and freed
3824 times in a period of 1.25 hours. This is their log:
https://github.com/user-attachments/files/18008735/log.txt
This computer is a Raspberry Pi 3B with 1 GB RAM.

I agree that another 4 skbs would be fine. I don't know what the upper
limit should be. The user with the Raspberry Pi 3B also tested with no
limit and reported that the driver allocated 17 extra skbs. That seems
like too many to me.


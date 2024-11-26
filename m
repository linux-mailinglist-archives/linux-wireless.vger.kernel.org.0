Return-Path: <linux-wireless+bounces-15731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BCF9D9E75
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 21:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73CCC166E06
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 20:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD987E782;
	Tue, 26 Nov 2024 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyIwCwpk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73658149C64
	for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2024 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732653621; cv=none; b=rZn8lWjBlnvxJ7+0Bb3sqLFBpyrna6FnDl7CFWU7Pph8OBEbPHr/XAT3bKut3mdQky9fBgVeHj/VEF+KQuSgenA/1ye3PwoBx4dQIf97wgDaq++SvY28lhJl86j0W2uYSXlGSusQ2x3h4X9Ig1jcRKedKXdBo9ZjPnlCQ2pyN5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732653621; c=relaxed/simple;
	bh=jhYbxegr/2Mc7DDgxQHy/lmPh4E/N8yr4zu2A8wH7Ao=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ejik37iNXUzFzYa5jH0NfZpQeo9sr3WCZEFMZ6H5e1rpNs6lQa9LP9wuHit7kH9z/TF5dZxeQcwVa9MHeI6jI2V0y/G0yH9ewtRCX1+McuOHNGuI0mli0s9WDW7ME/xoCKeO5gwKFOpNSk9Ht4x38eTTRXKZUZP80jCFVIfAUeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyIwCwpk; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cfabc686c8so7027028a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2024 12:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732653618; x=1733258418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5kf3es1ZxDHTjs3N9kNh+y8y/WNVZLha2qy2c3MXSf4=;
        b=TyIwCwpkGGpem9563GFlfjq8w9+JnZM0KNQJDxWOPENljdli+n5saewcn0fk7AXT1v
         Nuv41S4RehJ8pdTeVAK0YupGcPMzKd/aX9G1GKbx6TNhxjY9eJIIufUROiA5msgpDoZa
         8xu6WbtEiud84XEn6v1AYLEXlYFGTGQMLMe2hWQ/FOI4oNeGdgvYNAmzPCtJcbWuKDv1
         X6JuPvxl33UXpORLuYIIZKD/fhhxREO+mbBxE25u3daYaFO80PBer+YETxP8Np+jSa1E
         UYvmlc5q9pTFXV9n92Y3Su99jRXsVo7j8rAPqVJFr5TztXaVYUxLBM3FOMwxJrKA7OdV
         E4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732653618; x=1733258418;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5kf3es1ZxDHTjs3N9kNh+y8y/WNVZLha2qy2c3MXSf4=;
        b=Qd1C+qALccpxG7zdbHACdVKjZm8Uj7NMRnuRpk3kXcL5NmO7MxK1Z7kOniZ8R9dQtB
         S4y7LfC9wMBEWmav89+3TX4rYHnbF3VIiAjrvc57EXhnfUEyIgMKWiPg5sNPC+sgJQRD
         Yf6i5LEeVBLqfHldloOu0jKoOvJNRuKctUMxUlGZZFK55jKzp8JuC1pVXNfm/Zr9+DFo
         UOXin1MEmtmDjKI75ZdffdV6Y6SI2JU/LtLISA1sjfGgALcywwVNIdSeaLoyFxdteotr
         b5g70Mb+B06pBJBA8PmHdn8OtJcrCxQ+8eJ+UMgp6I1l2uQpjYu5bhYcE3xZl54W4uhx
         CMew==
X-Forwarded-Encrypted: i=1; AJvYcCVx21+vjsvuEXstYNlcQbBHMfKoLSynskEKitbp8EQoubFpYkl5K51bR7I7fMPqQEL96ruFGf9NHwB0/wRQ1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz71btvhIBSkIlqEwG8skLX6uY61wQWfSSNN5Y9IvR8CjCa/ryT
	/zUHJt9D3s5Rr2hFUJ9wJB4opnxD8/YRR5Np+pUESFxGuL7BNV7n
X-Gm-Gg: ASbGnctelw+n9PHn8tz61bpG2CZykRQg0+5/StaJ1Ng8FuSXIZRMmCVgkCcUkcF8mmU
	DihuIIZsN3kpxp/qCRbXERpVXSOD4TsNq7J25rj1Qkj6EkJH/OmrzxjJI12f5DIczcc0DM25ssn
	Uje7FeieSp1dhyNlL9lZ1nxg1mJJYSTMgmTKATeA7IcN/lM+lU9UEwGK8LnkTjmiSEed7i4SKIo
	oj9L2piGxGfLFWGxLbNpVIuALeov6fwWWxPp3YtdNZuy5zTOlg+cJgt
X-Google-Smtp-Source: AGHT+IFo08qX1UQNuyGPr1xIQXVVZrjqLBCtE/5WogO9+Y25n+WbKoaHotTd4Jff84E7syedp647Lw==
X-Received: by 2002:a05:6402:50c9:b0:5cf:de72:c140 with SMTP id 4fb4d7f45d1cf-5d080b8cdc6mr538695a12.7.1732653617543;
        Tue, 26 Nov 2024 12:40:17 -0800 (PST)
Received: from [192.168.0.50] ([81.196.40.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3fc777sm5467364a12.68.2024.11.26.12.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 12:40:16 -0800 (PST)
Message-ID: <13504753-c105-47ba-b98f-160daf06965b@gmail.com>
Date: Tue, 26 Nov 2024 22:40:13 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 1/2] wifi: rtw88: usb: Copy instead of cloning the RX skb
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Sascha Hauer <sha@pengutronix.de>
References: <28b09f4d-5271-470d-99b6-a0bbe0224739@gmail.com>
 <e9f32f00c63945bfb97dff12d081478e@realtek.com>
 <133b8a9d-55e2-4483-ab2d-9ed06ef5ed96@gmail.com>
 <15f83014e5c54762b34e11a1aa552934@realtek.com>
Content-Language: en-US
In-Reply-To: <15f83014e5c54762b34e11a1aa552934@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2024 03:17, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 18/11/2024 11:16, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>> "iperf3 -c 192.168.0.1 -R --udp -b 0" shows about 40% of datagrams
>>>> are lost. Many torrents don't download faster than 3 MiB/s, probably
>>>> because the Bittorrent protocol uses UDP. This is somehow related to
>>>> the use of skb_clone() in the RX path.
>>>
>>> Using skb_clone() can improve throughput is weird to me too. Do you check
>>> top with 100% cpu usage?
>>>
>>
>> I checked the CPU usage now and the results are interesting. In short,
>> patch 1/2 slightly raises the CPU usage, and patch 2/2 lowers it a lot.
> 
> Originally I just wanted to know if throughput is a limit of CPU bound.
> Anyway good to know this patchset can improve CPU usage. 
> 
>>>>
>>>> Don't use skb_clone(). Instead allocate a new skb for each 802.11 frame
>>>> received and copy the data from the big (32768 byte) skb.
>>>>
>>>> With this patch, "iperf3 -c 192.168.0.1 -R --udp -b 0" shows only 1-2%
>>>> of datagrams are lost, and torrents can reach download speeds of 36
>>>> MiB/s.
>>>>
>>>> Tested with RTL8812AU and RTL8822CU.
>>>>
>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>> ---
>>>>  drivers/net/wireless/realtek/rtw88/usb.c | 52 ++++++++++++++----------
>>>>  1 file changed, 31 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
>>>> index 93ac4837e1b5..727569d4ef4b 100644
>>>> --- a/drivers/net/wireless/realtek/rtw88/usb.c
>>>> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
>>>> @@ -7,6 +7,7 @@
>>>>  #include <linux/mutex.h>
>>>>  #include "main.h"
>>>>  #include "debug.h"
>>>> +#include "mac.h"
>>>>  #include "reg.h"
>>>>  #include "tx.h"
>>>>  #include "rx.h"
>>>> @@ -546,49 +547,58 @@ static void rtw_usb_rx_handler(struct work_struct *work)
>>>>  {
>>>>         struct rtw_usb *rtwusb = container_of(work, struct rtw_usb, rx_work);
>>>>         struct rtw_dev *rtwdev = rtwusb->rtwdev;
>>>> -       const struct rtw_chip_info *chip = rtwdev->chip;
>>>> -       u32 pkt_desc_sz = chip->rx_pkt_desc_sz;
>>>>         struct ieee80211_rx_status rx_status;
>>>> -       u32 pkt_offset, next_pkt, urb_len;
>>>>         struct rtw_rx_pkt_stat pkt_stat;
>>>> -       struct sk_buff *next_skb;
>>>> +       struct sk_buff *rx_skb;
>>>>         struct sk_buff *skb;
>>>> +       u32 pkt_desc_sz = rtwdev->chip->rx_pkt_desc_sz;
>>>> +       u32 max_skb_len = pkt_desc_sz + PHY_STATUS_SIZE * 8 +
>>>> +                         IEEE80211_MAX_MPDU_LEN_VHT_11454;
>>>> +       u32 pkt_offset, next_pkt, skb_len;
>>>>         u8 *rx_desc;
>>>>         int limit;
>>>>
>>>>         for (limit = 0; limit < 200; limit++) {
>>>> -               skb = skb_dequeue(&rtwusb->rx_queue);
>>>> -               if (!skb)
>>>> +               rx_skb = skb_dequeue(&rtwusb->rx_queue);
>>>> +               if (!rx_skb)
>>>>                         break;
>>>>
>>>>                 if (skb_queue_len(&rtwusb->rx_queue) >= RTW_USB_MAX_RXQ_LEN) {
>>>>                         dev_dbg_ratelimited(rtwdev->dev, "failed to get rx_queue, overflow\n");
>>>> -                       dev_kfree_skb_any(skb);
>>>> +                       dev_kfree_skb_any(rx_skb);
>>>>                         continue;
>>>>                 }
>>>>
>>>> -               urb_len = skb->len;
>>>> +               rx_desc = rx_skb->data;
>>>>
>>>>                 do {
>>>> -                       rx_desc = skb->data;
>>>>                         rtw_rx_query_rx_desc(rtwdev, rx_desc, &pkt_stat,
>>>>                                              &rx_status);
>>>>                         pkt_offset = pkt_desc_sz + pkt_stat.drv_info_sz +
>>>>                                      pkt_stat.shift;
>>>>
>>>> -                       next_pkt = round_up(pkt_stat.pkt_len + pkt_offset, 8);
>>>> +                       skb_len = pkt_stat.pkt_len + pkt_offset;
>>>> +                       if (skb_len > max_skb_len) {
>>>
>>> This seems a new rule introduced by this patch. Do you really encounter this
>>> case? Maybe this is the cause of slow download throughput?
>>>
>>
>> No, I never saw this case. It just seemed like a good idea to check the
>> size passed to alloc_skb. Maybe it's not needed?
> 
> I think it is fine. 
> 
> Asking some questions before, I just tried to find a cause why 40% datagram get
> lost as you mentioned in commit message, but I can't. 
> 

By the way, I saw 30-40% datagrams lost with RTL8822CE as well. But the
PCI driver is not using skb_clone so I'm not sure what is going on there.



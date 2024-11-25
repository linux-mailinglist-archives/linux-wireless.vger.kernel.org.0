Return-Path: <linux-wireless+bounces-15699-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8408F9D8F4C
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 00:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D74D1B2142F
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 23:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD8118FDA5;
	Mon, 25 Nov 2024 23:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keSxGk+3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051E9848C
	for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 23:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732578584; cv=none; b=NTLzD7HzNJeKewORK+BzRiEXuUKwLHe3KAuN+RXteoTnyWxXqbKAqJ4/rxQgUFZ/8l0IEN8SDkPTZfVN8QpROaGTfUa3ujBNIgJfgwW8f5/lJTvcMDUNEpWvAE8uwVNZvzQRleYKRxIYEVmPnkUitg8qaecyeqB8JbBj2Nfazc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732578584; c=relaxed/simple;
	bh=gvnTJsW3t/aZI47S4TWWlUa+19o8BofmU1xHW+PUmeM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZpA4kfgTkeUxCQn5X5VvjcYt+rmGnyFaurXlWgqtNwUbZs6Obg8pAYueeFMVffhMDXSPCwvD0RTenTw/bzwTBOmh9eBHh6SnfT16Vi5Dlb36iRXVoD7Il1SxNDGaa+FCGBDyQESpQLLt91F1+MRP5VQ6APQSY1jxtEtKa5Z2bBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keSxGk+3; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-382376fcc4fso2925431f8f.2
        for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 15:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732578581; x=1733183381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X3LMmTb6OTx+I3fuoDFQqKkOuQdkntQ7/i2LEZePVz8=;
        b=keSxGk+3gJilUAsCwtWeH+B6U9fERJDBEzoy97k5rsYEiA2Z7aSlCdJSHdYpowIkjV
         SPOfg99ocKojL4tntBvAvd0rsLcpLCOnvruECRwLYU4Ozw1WYl8ncw5XNq//0szGb6b6
         4aRkpaD1H1ShjIKUOx0rkgAGjhWtciRzrlmvQ16wOzJ46RigEAD2G/W//7diYjO0Ojg2
         BDjSTzH28vQ2aIU48tz/iK0MNxn0LFuAXlzhm1wa8CmIXw5TdjsUYa6IWIcNhn+qimdb
         zbAuskpSpZMTWX9o2tOjntCj8JRTzE6R/TJmlZXaPNgiaL31vKXA01aESv+BTvlNNh9Q
         aAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732578581; x=1733183381;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3LMmTb6OTx+I3fuoDFQqKkOuQdkntQ7/i2LEZePVz8=;
        b=EPPSTgdnfb0HNJS4D1Z6mhSGtELgVU3llR0Edz/lrfk0f3ZLVZprgercz20uaD6vzs
         O9OXa+bbutMCLGT1mCcJjH/6wpW9INNPN5GSV4NnxUXtfLvHqSxFKCt9ZfFAdtv0FiW0
         6rXRhMvf+GGV7sCALYT/ChvVf+49pD6epHQpjwspmWevQ67a9PIGryYeuIVtnlWXq72U
         p9/RK4huLa6NR44qm61gdoQeW3gikGiCRKadBZl3a4wB8NmtRnKwWEuzZmFtR5SXvgLg
         gjiDG4L8nRZL7VN4TDIQ13jTekT1FKOM9LnoUXDpujM1bCUZ9GyQLlddv8FfeQQgWY64
         EpmA==
X-Forwarded-Encrypted: i=1; AJvYcCW6lj9yxMoj58/S8ZXU0bJhc0AW+9wc0uxz6DeYeMwFY51+Z6crjKWbuKjuj1FvxlnytvviOw1IDE9uuD2s0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/SfwPl+QCyLi/QEchzjT6/LfN0FmF+/4fIrizY9RBybyotZ4N
	xZHK7PQEwca9omPewnYYYF0rPPoNsA0GvljwHUQAmAtqyVgk4+nm
X-Gm-Gg: ASbGncudHWYhIiST1Nw/+NZ0ohVQthm2erCuKGEwHouiKWiZy1qKET4hRZgELJVSnKj
	h05CERjkUBHEsMXLAJZ065Dxhn6YOGCE8C2dwLTRVFcxdTHuXyTu2pjf9m6AXax7+mT8sR/EHrR
	DAtARapB/PmcD/XR9TGCHUi65xGzIpnJgirqK8nQbG7tz0os/eV/t7ajESMw+UEnug4Ry6M494c
	Z7JT1QNFo/kn4KhgcZgzgES2u0foHddLCONvaDOMVnEIFHkJ7V1B6Z8
X-Google-Smtp-Source: AGHT+IG9WdnqJozTTkiu9HzMJDzFq25YLhTjqoJGkxVqy5MGSwnam/EX2qFMHTyIZvv1n8NvJXGFEw==
X-Received: by 2002:a5d:5849:0:b0:382:59c1:ccdf with SMTP id ffacd0b85a97d-38260bcbb70mr11048466f8f.46.1732578581042;
        Mon, 25 Nov 2024 15:49:41 -0800 (PST)
Received: from [192.168.0.50] ([81.196.40.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3b0b50sm4662566a12.30.2024.11.25.15.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 15:49:39 -0800 (PST)
Message-ID: <1546573d-ce4d-4629-8d05-925fff079493@gmail.com>
Date: Tue, 26 Nov 2024 01:49:37 +0200
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
Content-Language: en-US
In-Reply-To: <3a9104bb97db4df6a285e94291fd84c7@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/11/2024 02:50, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> The USB driver uses four USB Request Blocks for RX. Before submitting
>> one, it allocates a 32768 byte skb for the RX data. This allocation can
>> fail, maybe due to temporary memory fragmentation. When the allocation
>> fails, the corresponding URB is never submitted again. After four such
>> allocation failures, all RX stops because the driver is not requesting
>> data from the device anymore.
>>
>> Don't allocate a 32768 byte skb when submitting a USB Request Block
>> (which happens very often). Instead preallocate 8 such skbs, and reuse
>> them over and over. If all 8 are busy, allocate a new one. This is
>> pretty rare. If the allocation fails, use a work to try again later.
>> When there are enough free skbs again, free the excess skbs.
>>
>> Also, use WQ_BH for the RX workqueue. With a normal or high priority
>> workqueue the skbs are processed too slowly when the system is even a
>> little busy, like when opening a new page in a browser, and the driver
>> runs out of free skbs and allocates a lot of new ones.
>>
>> Move C2H_ADAPTIVITY to the c2h workqueue instead of handling it directly
>> from rtw_fw_c2h_cmd_rx_irqsafe(), which runs in the RX workqueue. It
>> reads hardware registers, which is not "irqsafe" with USB.
> 
> This part should be in a separated patch. 
> 

Do you mean just C2H_ADAPTIVITY or WQ_BH as well?

>>
>> This is more or less what the out-of-tree Realtek drivers do, except
>> they use a tasklet instead of a BH workqueue.
>>
>> Tested with RTL8723DU, RTL8821AU, RTL8812AU, RTL8812BU, RTL8822CU,
>> RTL8811CU.
>>
>> Closes: https://lore.kernel.org/linux-wireless/6e7ecb47-7ea0-433a-a19f-05f88a2edf6b@gmail.com/
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw88/fw.c  |  7 +--
>>  drivers/net/wireless/realtek/rtw88/usb.c | 73 ++++++++++++++++++++----
>>  drivers/net/wireless/realtek/rtw88/usb.h |  3 +
>>  3 files changed, 67 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
>> index e6e9946fbf44..02389b7c6876 100644
>> --- a/drivers/net/wireless/realtek/rtw88/fw.c
>> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
>> @@ -332,6 +332,9 @@ void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
>>         case C2H_RA_RPT:
>>                 rtw_fw_ra_report_handle(rtwdev, c2h->payload, len);
>>                 break;
>> +       case C2H_ADAPTIVITY:
>> +               rtw_fw_adaptivity_result(rtwdev, c2h->payload, len);
>> +               break;
>>         default:
>>                 rtw_dbg(rtwdev, RTW_DBG_FW, "C2H 0x%x isn't handled\n", c2h->id);
>>                 break;
>> @@ -367,10 +370,6 @@ void rtw_fw_c2h_cmd_rx_irqsafe(struct rtw_dev *rtwdev, u32 pkt_offset,
>>                 rtw_fw_scan_result(rtwdev, c2h->payload, len);
>>                 dev_kfree_skb_any(skb);
>>                 break;
>> -       case C2H_ADAPTIVITY:
>> -               rtw_fw_adaptivity_result(rtwdev, c2h->payload, len);
>> -               dev_kfree_skb_any(skb);
>> -               break;
>>         default:
>>                 /* pass offset for further operation */
>>                 *((u32 *)skb->cb) = pkt_offset;
>> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
>> index 727569d4ef4b..5c2dfa2ced92 100644
>> --- a/drivers/net/wireless/realtek/rtw88/usb.c
>> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
>> @@ -585,7 +585,7 @@ static void rtw_usb_rx_handler(struct work_struct *work)
>>                                 goto skip_packet;
>>                         }
>>
>> -                       skb = alloc_skb(skb_len, GFP_KERNEL);
>> +                       skb = alloc_skb(skb_len, GFP_ATOMIC);
>>                         if (!skb) {
>>                                 rtw_dbg(rtwdev, RTW_DBG_USB,
>>                                         "failed to allocate RX skb of size %u\n",
>> @@ -612,7 +612,11 @@ static void rtw_usb_rx_handler(struct work_struct *work)
>>                         rx_desc += next_pkt;
>>                 } while (rx_desc + pkt_desc_sz < rx_skb->data + rx_skb->len);
>>
>> -               dev_kfree_skb_any(rx_skb);
>> +               if (skb_queue_len(&rtwusb->rx_free_queue) >=
>> +                   RTW_USB_RX_SKB_NUM - RTW_USB_RXCB_NUM)
>> +                       dev_kfree_skb_any(rx_skb);
>> +               else
>> +                       skb_queue_tail(&rtwusb->rx_free_queue, rx_skb);
> 
> Why not just queue and reuse rx_skb for all? That would be simpler. 
> 

I didn't want to let it allocate too many skbs. I didn't find any kind
of limit in the official drivers, so maybe it would be fine.

>>         }
>>  }
>>
>> @@ -621,23 +625,57 @@ static void rtw_usb_read_port_complete(struct urb *urb);
>>  static void rtw_usb_rx_resubmit(struct rtw_usb *rtwusb, struct rx_usb_ctrl_block *rxcb)
>>  {
>>         struct rtw_dev *rtwdev = rtwusb->rtwdev;
>> +       struct sk_buff *rx_skb;
>> +       gfp_t priority = in_interrupt() ? GFP_ATOMIC : GFP_KERNEL;
> 
> I remember in_interrupt() is not recommended. Can't we pass necessary gfp_t
> via function argument by callers?
> 

Yes, I can do that.

>>         int error;
>>
>> -       rxcb->rx_skb = alloc_skb(RTW_USB_MAX_RECVBUF_SZ, GFP_ATOMIC);
>> -       if (!rxcb->rx_skb)
>> -               return;
>> +       rx_skb = skb_dequeue(&rtwusb->rx_free_queue);
>> +       if (!rx_skb)
>> +               rx_skb = alloc_skb(RTW_USB_MAX_RECVBUF_SZ, priority);
>> +
>> +       if (!rx_skb)
>> +               goto try_later;
>> +
>> +       rxcb->rx_skb = rx_skb;
>> +
>> +       skb_reset_tail_pointer(rxcb->rx_skb);
>> +       rxcb->rx_skb->len = 0;
> 
> How about moving these initialization upward before ' rxcb->rx_skb = rx_skb;'?
> Statements can be shorter, and it is reasonable to initialize data before
> assignment. 
> 
>>
>>         usb_fill_bulk_urb(rxcb->rx_urb, rtwusb->udev,
>>                           usb_rcvbulkpipe(rtwusb->udev, rtwusb->pipe_in),
>>                           rxcb->rx_skb->data, RTW_USB_MAX_RECVBUF_SZ,
>>                           rtw_usb_read_port_complete, rxcb);
>>
>> -       error = usb_submit_urb(rxcb->rx_urb, GFP_ATOMIC);
>> +       error = usb_submit_urb(rxcb->rx_urb, priority);
> 
> Not sure if 'priority' fits the meaning. Maybe many kernel code just
> uses 'gfp'.
> 
>>         if (error) {
>> -               kfree_skb(rxcb->rx_skb);
>> +               skb_queue_tail(&rtwusb->rx_free_queue, rxcb->rx_skb);
>> +
>>                 if (error != -ENODEV)
>>                         rtw_err(rtwdev, "Err sending rx data urb %d\n",
>>                                 error);
> 
> Since here rxcb->rx_skb != NULL, will it be a problem? The rxcb will not be
> submitted again? Should all error cases go to try_later label?
> 

Right, the rxcb will be submitted again only if the error was ENOMEM
I don't know what other errors can be considered temporary. I never
ran into the case where the error is not ENODEV.

> 
>> +
>> +               if (error == -ENOMEM)
>> +                       goto try_later;
>> +       }
>> +
>> +       return;
>> +
>> +try_later:
>> +       rxcb->rx_skb = NULL;
>> +       queue_work(rtwusb->rxwq, &rtwusb->rx_urb_work);
>> +}
>> +
>> +static void rtw_usb_rx_resubmit_work(struct work_struct *work)
>> +{
>> +       struct rtw_usb *rtwusb = container_of(work, struct rtw_usb, rx_urb_work);
>> +       struct rx_usb_ctrl_block *rxcb;
>> +       int i;
>> +
>> +       for (i = 0; i < RTW_USB_RXCB_NUM; i++) {
>> +               rxcb = &rtwusb->rx_cb[i];
>> +
>> +               if (!rxcb->rx_skb)
>> +                       rtw_usb_rx_resubmit(rtwusb, rxcb);
>>         }
>>  }
>>



Return-Path: <linux-wireless+bounces-23394-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ADDAC3743
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 00:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85F217393B
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 22:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6662C79F5;
	Sun, 25 May 2025 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNhCBB6k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C8FA29
	for <linux-wireless@vger.kernel.org>; Sun, 25 May 2025 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748210610; cv=none; b=Zx3UwVhEqxl9nnLAVZn07GOPuZUHv9/d2b1oEHoDZ8CiVCr3U/DudTBVLOD+skEuqJtHLwZfh7XV4nQxtI4Om/qcv49TCWz4AIIr/clJLFb9FG6JstbNybNnSdxF/BBD60W5fEAohdNpk6hwPGboHTaAXszuBzRvCn+LLn5669g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748210610; c=relaxed/simple;
	bh=RkukWBVE5im366u/0YExKsU39VF9Ri6H3RdZ43rJ/HE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=kk/hA9ZL2mNfg5sf9WypatQUd7kt6q9MDudAQAlzx1kb0uDEd1OVG/bD4ZV4uThgkUxdShSVqPtNHMAsJBHBDf2vuWqYWyDrO5r5HhEP72B4HxIAPBGqQvzn+h8G8kG3EAO3PK9k/90xQ1I+3nfEbzc8aPyhoTcFE4VVH+voQFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNhCBB6k; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad53a96baf9so317522066b.3
        for <linux-wireless@vger.kernel.org>; Sun, 25 May 2025 15:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748210605; x=1748815405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZU8a9ByswdhEU/enCbKMP1t7MtuELCnRgrK4PP3emo=;
        b=RNhCBB6ksD55TpKRhvPL6R692je/h8dxqoMeKlz7cEnet5jBROQIvkJJEAKmrcaCHT
         9YiloSTdb59MZcj9I4IUoBW9YgGg3lncUl75rodVQ1TbbS2LAWb53m+XsclHc94NNua2
         vmDqqfG+4dAnZUXiaa5m5MWv3pOlvhMIDyBRhv5Yw65pNpcZgJWEUJzvu4MJXFLjW4Gc
         f4iXk3VMhl1SiIfjaD7pQraqpioZSudPptfzB8Z6cuMfQuLpB3llM0VEQ0BRJbV/qoAd
         ltkaPwOAbEPYZUHQt8te9h1Fz3f72bEWtXxL+A8+efkN0sfiGQ1SRTEt9xAYjyrL4xj5
         9oqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748210605; x=1748815405;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZU8a9ByswdhEU/enCbKMP1t7MtuELCnRgrK4PP3emo=;
        b=Fx6ywR7BUFz6KUoDtmzE3dFwNHHlj2MS/2BiJjfnA9TsDetaikfUWz5FEdGsNYAEml
         oiFbdynEN5TDOd49VD0mlA5U+r83q9DSj/peho5E7oPwJloUjq7cvU6Ti2GZwB5gYZxk
         azliiieiMtDpBjTcodv1RkNTuF3oSyv8txrMOsjEWrYGMFRLJiMkriMzbaHGSVyDUxVA
         yCTGuSFRJtdBlYVUK1MeL566wHHXhe9GeWJ/8j2iTaXninmTjMLlzyCex4okFtVUGFQ8
         wszbE6lBqFPRGPenHWKXrkF11QRK2udxVKyRIn0wI/0eWieWeJymgQdxboJ9JoGVVC5k
         Kr/A==
X-Forwarded-Encrypted: i=1; AJvYcCXBQYJg1JZaUOU4qZiIRvx3Ued4n8lgbtPPEhA/1QaEgL/J0q6e2DooRuo/KwWFALiLso/rfZ0RfpHqs+6A6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDbjqIOFyqkWnSrTbTd9oBm40J8Fwg5YSYKrn2+RG4F1n5wNpA
	0B5Tt4aXhZAW2g+BTTKB1Y8sFrHeCXA2wmvabwEnNIXl7kNYBJRveinB
X-Gm-Gg: ASbGncuXdcM09G8XtMg/cZacABQTHlHlhDCcHB8qjTGLlQYJNCOQvuA90IH/Gos5dKT
	8jmgWN1/isyURGYdO+52tZH8rTrBdagY/Csw65yXzJsn1XIY8f2BewjkRMjF14E7/RkzQ3qOIHM
	zToT7JuIFT5oKLKY66r8XmgJDdibp11hAOWcyzj2uWN6sMoYl0W+3r4yCYhHp1UOAuOC2dPRxu8
	pwoc6JybW32HpdbeJKLf2BkgvFOJRzsT64w55B+FBHqE672ZUngI2cVu/5pKKuwucTvZyJg1rn7
	S1ggtz+TM0p3uTgFgM8/TR6qrLqLU191OsR8ocHKVqUMsmCVc9W3MB8T9Mw=
X-Google-Smtp-Source: AGHT+IGcbbPsQcrl0Ud8fkJCQmo2WyPRhQlqxxVXlCXZzai7hjTLzU7XGDKOlfKZ9Ii4VmbZvts7Tg==
X-Received: by 2002:a17:907:7faa:b0:ad5:c07:49f8 with SMTP id a640c23a62f3a-ad85b3071f1mr660418066b.41.1748210605363;
        Sun, 25 May 2025 15:03:25 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d277a2esm1581976366b.83.2025.05.25.15.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 15:03:24 -0700 (PDT)
Message-ID: <f9f205bb-9084-42c0-9942-533d2787fd13@gmail.com>
Date: Mon, 26 May 2025 01:03:23 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw-next v1 11/13] wifi: rtw89: Add usb.{c,h}
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <9a3d63a2-2a8f-4f1d-a9cb-b79c255c1a51@gmail.com>
 <60b78caaf3c049a1a5595bb89d553777@realtek.com>
Content-Language: en-US
In-Reply-To: <60b78caaf3c049a1a5595bb89d553777@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/05/2025 09:12, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Add very basic USB support. No TX/RX aggregation, no TX queues, no
>> switching to USB 3 mode.
>>
>> RTL8851BU and RTL8832BU work.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw89/usb.c | 1030 ++++++++++++++++++++++
>>  drivers/net/wireless/realtek/rtw89/usb.h |   61 ++
>>  2 files changed, 1091 insertions(+)
>>  create mode 100644 drivers/net/wireless/realtek/rtw89/usb.c
>>  create mode 100644 drivers/net/wireless/realtek/rtw89/usb.h
>>
>> diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
>> new file mode 100644
>> index 000000000000..6e8a544b352c
>> --- /dev/null
>> +++ b/drivers/net/wireless/realtek/rtw89/usb.c
>> @@ -0,0 +1,1030 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>> +/* Copyright(c) 2025  Realtek Corporation
>> + */
>> +
>> +#include <linux/usb.h>
>> +#include "debug.h"
>> +#include "mac.h"
>> +#include "reg.h"
>> +#include "txrx.h"
>> +#include "usb.h"
>> +
>> +static void rtw89_usb_vendorreq(struct rtw89_dev *rtwdev, u32 addr,
>> +                               void *data, u16 len, u8 reqtype)
>> +{
>> +       struct rtw89_usb *rtwusb = rtw89_get_usb_priv(rtwdev);
>> +       struct usb_device *udev = rtwusb->udev;
>> +       unsigned int pipe;
>> +       u16 value, index;
>> +       int attempt, ret;
>> +
>> +       value = addr & 0x0000ffff;
>> +       index = (addr & 0x00ff0000) >> 16;
> 
> u16_get_bits(addr, GENMASK(23, 16)) ?
> 
> 
>> +
>> +       mutex_lock(&rtwusb->vendor_req_mutex);
> 
> rtw89 takes wiphy_lock for control path. Is there any case more than 
> one threads run at the same time?
> 

Maybe not. I just copied this from the vendor driver. How can I be
sure only one thread runs?

I added this above the mutex_lock() today:

	if (mutex_is_locked(&rtwusb->vendor_req_mutex))
		pr_err("mutex already locked elsewhere\n");

So far it hasn't printed the message.

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
> 
> By "rtwusb->vendor_req_buf = kmalloc(sizeof(u32), GFP_KERNEL);", it seems like 
> buffer size of vendor_req_buf is only 4 bytes. Is it enough space to do
> memcpy()? Also, why not just a local variable ?
> 

It is enough space, len can only be 1, 2, or 4 here. It's not a local
variable because usb_control_msg() needs memory suitable for DMA.

> 
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
>> +                                  attempt);
>> +               else if (ret > 0 && reqtype == RTW89_USB_VENQT_READ)
>> +                       memcpy(data, rtwusb->vendor_req_buf, len);
>> +
>> +               if (atomic_inc_return(&rtwusb->continual_io_error) > 4) {
>> +                       set_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags);
>> +                       break;
>> +               }
>> +       }
>> +
>> +       mutex_unlock(&rtwusb->vendor_req_mutex);
>> +}
>> +
>> +static u32 rtw89_usb_read_cmac(struct rtw89_dev *rtwdev, u32 addr)
>> +{
>> +       u32 addr32, val32, shift;
>> +       __le32 data = 0;
>> +       int count;
>> +
>> +       addr32 = addr & ~0x3;
>> +       shift = (addr & 0x3) * 8;
>> +
>> +       for (count = 0; ; count++) {
>> +               rtw89_usb_vendorreq(rtwdev, addr32, &data, 4,
>> +                                   RTW89_USB_VENQT_READ);
>> +
>> +               val32 = le32_to_cpu(data);
>> +
> 
> no empty line between assignment and immediate checking. 
> 
>> +               if (val32 != RTW89_R32_DEAD)
>> +                       break;
>> +
>> +               if (count >= MAC_REG_POOL_COUNT) {
>> +                       rtw89_warn(rtwdev, "%s: addr %#x = %#x\n",
>> +                                  __func__, addr32, val32);
>> +                       val32 = RTW89_R32_DEAD;
>> +                       break;
>> +               }
>> +
>> +               rtw89_write32(rtwdev, R_AX_CK_EN, B_AX_CMAC_ALLCKEN);
>> +       }
>> +
>> +       return val32 >> shift;
>> +}
> 
> [...]
> 
>> +static void rtw89_usb_write_port_complete(struct urb *urb)
>> +{
>> +       struct rtw89_usb_tx_ctrl_block *txcb = urb->context;
>> +       struct rtw89_dev *rtwdev = txcb->rtwdev;
>> +       struct ieee80211_tx_info *info;
>> +       struct sk_buff *skb;
>> +
>> +       while (true) {
> 
> Is it possible that more than one skb are in txcb->tx_ack_queue?
> With USB aggregation afterword, it will become possible?
> 

Right now there is only one skb in txcb->tx_ack_queue. But yes,
with USB TX aggregation it will have several skb. The maximum
number depends on the chip. I think RTL8851BU can take up to 9 in
one USB transfer.

>> +               skb = skb_dequeue(&txcb->tx_ack_queue);
>> +               if (!skb)
>> +                       break;
>> +
>> +               info = IEEE80211_SKB_CB(skb);
>> +               ieee80211_tx_info_clear_status(info);
>> +
>> +               if (urb->status == 0) {
>> +                       if (info->flags & IEEE80211_TX_CTL_NO_ACK)
>> +                               info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
>> +                       else
>> +                               info->flags |= IEEE80211_TX_STAT_ACK;
>> +               }
>> +
>> +               ieee80211_tx_status_irqsafe(rtwdev->hw, skb);
>> +       }
>> +
>> +       switch (urb->status) {
>> +       case 0:
>> +       case -EPIPE:
>> +       case -EPROTO:
>> +       case -EINPROGRESS:
>> +       case -ENOENT:
>> +       case -ECONNRESET:
>> +               break;
>> +       default:
>> +               set_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags);
>> +               break;
>> +       }
>> +
>> +       kfree(txcb);
>> +       usb_free_urb(urb);
>> +}
>> +
> 
> [...]
> 
>> +
>> +static void rtw89_usb_read_port_complete(struct urb *urb);
> 
> Move to beginning of this file. 
> 
>> +
>> +static void rtw89_usb_rx_resubmit(struct rtw89_usb *rtwusb,
>> +                                 struct rtw89_usb_rx_ctrl_block *rxcb,
>> +                                 gfp_t gfp)
>> +{
>> +       struct rtw89_dev *rtwdev = rtwusb->rtwdev;
>> +       struct sk_buff *rx_skb;
>> +       int error;
> 
> Why not 'int ret' in commom? 
> 
> [...]
> 
>> +
>> +static void rtw89_usb_cancel_rx_bufs(struct rtw89_usb *rtwusb)
>> +{
>> +       struct rtw89_usb_rx_ctrl_block *rxcb;
>> +       int i;
>> +
>> +       for (i = 0; i < RTW89_USB_RXCB_NUM; i++) {
>> +               rxcb = &rtwusb->rx_cb[i];
>> +               usb_kill_urb(rxcb->rx_urb);
> 
> rtw89_usb_disconnect() calls rtw89_usb_cancel_rx_bufs() and then call
> rtw89_usb_free_rx_bufs(). Is it a problem that usb_kill_urb() is called twice?
> 

I think it's not a problem because nothing bad happened so far.
But usb_kill_urb() in rtw89_usb_free_rx_bufs() is unnecessary so
I'll remove it.

>> +       }
>> +}
>> +
>> +static void rtw89_usb_free_rx_bufs(struct rtw89_usb *rtwusb)
>> +{
>> +       struct rtw89_usb_rx_ctrl_block *rxcb;
>> +       int i;
>> +
>> +       for (i = 0; i < RTW89_USB_RXCB_NUM; i++) {
>> +               rxcb = &rtwusb->rx_cb[i];
>> +
>> +               usb_kill_urb(rxcb->rx_urb);
>> +               usb_free_urb(rxcb->rx_urb);
>> +       }
>> +}
>> +
> 
> [...]
> 
>> +
>> +static int rtw89_usb_ops_mac_lv1_rcvy(struct rtw89_dev *rtwdev,
>> +                                     enum rtw89_lv1_rcvy_step step)
>> +{
>> +       u32 reg, mask;
>> +
>> +       switch (rtwdev->chip->chip_id) {
>> +       case RTL8851B:
>> +       case RTL8852A:
>> +       case RTL8852B:
>> +               reg = R_AX_USB_WLAN0_1;
>> +               mask = B_AX_USBRX_RST | B_AX_USBTX_RST;
>> +               break;
>> +       case RTL8852C:
>> +               reg = R_AX_USB_WLAN0_1_V1;
>> +               mask = B_AX_USBRX_RST_V1 | B_AX_USBTX_RST_V1;
>> +               break;
>> +       default:
>> +               rtw89_err(rtwdev, "%s: fix me\n", __func__);
>> +               return -EOPNOTSUPP;
>> +       }
>> +
>> +       switch (step) {
>> +       case RTW89_LV1_RCVY_STEP_1:
>> +               rtw89_write32_set(rtwdev, reg, mask);
>> +
>> +               msleep(30);
>> +
> 
> maybe no need this empty line.
> 
>> +               break;
>> +       case RTW89_LV1_RCVY_STEP_2:
>> +               rtw89_write32_clr(rtwdev, reg, mask);
>> +
> 
> no need this empty line.
> 
>> +               break;
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
> 
> [...]
> 
>> +static int rtw89_usb_intf_init(struct rtw89_dev *rtwdev,
>> +                              struct usb_interface *intf)
>> +{
>> +       struct rtw89_usb *rtwusb = rtw89_get_usb_priv(rtwdev);
>> +       int ret;
>> +
>> +       ret = rtw89_usb_parse(rtwdev, intf);
>> +       if (ret)
>> +               return ret;
>> +
>> +       rtwusb->vendor_req_buf = kmalloc(sizeof(u32), GFP_KERNEL);
> 
> I mentioned this allocation before. 
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
>> +       mutex_init(&rtwusb->vendor_req_mutex);
>> +
>> +       return 0;
>> +}
>> +
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtw89/usb.h b/drivers/net/wireless/realtek/rtw89/usb.h
>> new file mode 100644
>> index 000000000000..86caae1b9d0b
>> --- /dev/null
>> +++ b/drivers/net/wireless/realtek/rtw89/usb.h
>> @@ -0,0 +1,61 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
>> +/* Copyright(c) 2025  Realtek Corporation
>> + */
>> +
>> +#ifndef __RTW89_USB_H__
>> +#define __RTW89_USB_H__
>> +
> 
> [...]
> 
>> +
>> +static inline struct rtw89_usb *rtw89_get_usb_priv(struct rtw89_dev *rtwdev)
> 
> Not sure if it is worth of this wrapper. Or just rtw89_usb_priv()? 
> 

I like it because it's shorter than (struct rtw89_usb *)rtwdev->priv.

>> +{
>> +       return (struct rtw89_usb *)rtwdev->priv;
>> +}
>> +
>> +int rtw89_usb_probe(struct usb_interface *intf,
>> +                   const struct usb_device_id *id);
>> +void rtw89_usb_disconnect(struct usb_interface *intf);
>> +
>> +#endif
>> --
>> 2.49.0
> 



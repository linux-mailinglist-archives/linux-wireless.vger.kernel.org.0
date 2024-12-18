Return-Path: <linux-wireless+bounces-16554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0659F701C
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 23:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1B41633A3
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 22:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E493A1F238D;
	Wed, 18 Dec 2024 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxKXScZZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1A835948
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 22:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734561355; cv=none; b=RN1hiCzzfro90Aj7Lt1MnJKT+H/+9qUWPilVwhoVanME8WHrZCzxuL8fTb1t3XIh69VWPdlR31HqRVEqJcDwq33fhVYRgGZPtqJFmMi8tzrpRvUJJdKK1TgnTVmn5+hMMuFYYeAT6xYWWF+ssHT3Z36VbK/DmDVOIrywl64BkCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734561355; c=relaxed/simple;
	bh=3xcfigb3IHA0dIzCFqWTaaCVsIsQHsvxJCOp7P1LawM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cYbU4JWHb94TUuQpUbz0+tu5VXpUf4S2xrAVQmmE6LFir/3QBv0I1Eh41Nj+L4VHrrexYUFwAqnrVPJAYGJ93RhESbjovDVAjGGafCpU50M9M37/qM0jKcpeJTLCIzLwRFAaTZklXgZQi5ZkAxPpZAIPTyIHnYpP9mEnKzNQbDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxKXScZZ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d27243ba8bso230219a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 14:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734561352; x=1735166152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fJ2gHbKoqM9i6XR47e0TKuDWjHxNW1wjgSVRL5Of1nA=;
        b=FxKXScZZ7VRTtGdCQryQwwZyAtpGMEK03bm2cSetmRstrjFZTIcNOvRPUosXOlChs0
         cHL+sxXm2H9HhUSTm86jld238cro8vHW1tVJEBgoCxQkYIJybs+cT1f4Zu5k0a1+6+b+
         TfSRKZ6HXpeOtxWfAoG6hohUT94DIHk9oM2tHHs2KcPqF6GmYXdZGfzXrhnZmid6IryW
         VeE/CHCddMEMwTAmaQE7S1qnin4nU8AUBMxfPCtsYu/CmTT4T1LrzsPtwkg0WwHZOUu1
         06VIE9gME1pa2QCtt0uMMjReJV8Xl6K/+yILRdMHaG11uYT1Ks7B/jJDBdxUInQ1RrwS
         ADvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734561352; x=1735166152;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJ2gHbKoqM9i6XR47e0TKuDWjHxNW1wjgSVRL5Of1nA=;
        b=wnsx/r+lgs+s2KRK5kTOhGTBGWtqpuLpBfavl+i0TlSyQMIEqszK0Zmz5AL3Gdmt5H
         kSyT2bd3TgrgJPRkx8Lw82twiGRVLGWRd/QrG+tDhrYUqWfqlEyjnkG42LIPcatSrBPr
         d2OhqJHVp4R0b8JeRDCIRGKjrjgz2Se+Fl83Ddi6hKLQl2g9RdYgmMA/8D9TYQwLA6nv
         w4MFAjVE4e3nQG/9dHxQsgzTlHo1G/b70lGJyP9swkl2UR6Q31IMFtJSCvYC1FJk20fl
         33uQn7u5uo9zffTpVeSI0Vz6UiJJoIVmwyIa6cVgC5VKmsw5taV6fGe1D06veVrK5iY3
         wswQ==
X-Gm-Message-State: AOJu0YwvY+J1P3jWJlEkJ2NSVwyo3N+HBVPJCyhjKj1HaY9SWLxmnq4Z
	nD5B2zBwnBgqtlZIhXm1rdgc/Is6RJu5OcSgCnvHTYfMzTMxdh7YINLBTQ==
X-Gm-Gg: ASbGncuRu7S7XB6qkAKjQdYIzfIiUhVDFuN7+4cUNwdPLQc+1fmPArKgCt72C2gaagS
	Pj85q5xv3PvAc6SjwKMSZkgELQTplPz/RjtgaMqquDNu5lqfQqzQfdoQ9Qw9oDerQIplMzWqDZG
	dG7kDfCfEQAc/ZMrHX9MpKZKi8KsabuUtsCDEmQ/TqAXErFFMlxgj9GYTIj+n8OdqFJOAnqWXaH
	SPSQAOkFRNBUsDdVYa+V4kjz+itzL0aj6OPxICbtWwW5Ptwt9Xq+Fh7uhiGigTu
X-Google-Smtp-Source: AGHT+IEVpcU9MNdtEQm0e1NVe8/EEGqOLuSoNYo8AZx6K3dfkVM789CeZAs60eEWp+iWxftZwgxxOQ==
X-Received: by 2002:a05:6402:51c8:b0:5d2:729f:995b with SMTP id 4fb4d7f45d1cf-5d7ee418449mr4175303a12.24.1734561351905;
        Wed, 18 Dec 2024 14:35:51 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80679eebcsm6200a12.41.2024.12.18.14.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 14:35:50 -0800 (PST)
Message-ID: <9cee7a34-c38d-4128-824d-0ec139ca5a4e@gmail.com>
Date: Thu, 19 Dec 2024 00:35:49 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/3] wifi: rtw88: usb: Preallocate and reuse the RX skbs
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <8c9d4f9d-ebd8-4dc0-a0c4-9ebe430521dd@gmail.com>
Content-Language: en-US
In-Reply-To: <8c9d4f9d-ebd8-4dc0-a0c4-9ebe430521dd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The USB driver uses four USB Request Blocks for RX. Before submitting
one, it allocates a 32768 byte skb for the RX data. This allocation can
fail, maybe due to temporary memory fragmentation. When the allocation
fails, the corresponding URB is never submitted again. After four such
allocation failures, all RX stops because the driver is not requesting
data from the device anymore.

Don't allocate a 32768 byte skb when submitting a USB Request Block
(which happens very often). Instead preallocate 8 such skbs, and reuse
them over and over. If all 8 are busy, allocate a new one. This is
pretty rare. If the allocation fails, use a work to try again later.
When there are enough free skbs again, free the excess skbs.

Also, use WQ_BH for the RX workqueue. With a normal or high priority
workqueue the skbs are processed too slowly when the system is even a
little busy, like when opening a new page in a browser, and the driver
runs out of free skbs and allocates a lot of new ones.

This is more or less what the out-of-tree Realtek drivers do, except
they use a tasklet instead of a BH workqueue.

Tested with RTL8723DU, RTL8821AU, RTL8812AU, RTL8812BU, RTL8822CU,
RTL8811CU.

Closes: https://lore.kernel.org/linux-wireless/6e7ecb47-7ea0-433a-a19f-05f88a2edf6b@gmail.com/
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Pass the appropriate gfp_t flags as a parameter to
   rtw_usb_rx_resubmit() instead of using in_interrupt(). Call it "gfp"
   instead of "priority".
 - Initialise rx_skb a little earlier in rtw_usb_rx_resubmit().
 - Move C2H_ADAPTIVITY in a new patch (2/3).
 - Allow the driver to allocate 4 more persistent skbs after the initial
   8.
---
 drivers/net/wireless/realtek/rtw88/usb.c | 79 +++++++++++++++++++-----
 drivers/net/wireless/realtek/rtw88/usb.h |  3 +
 2 files changed, 67 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 4dbd5167faa4..b405f8317021 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -585,7 +585,7 @@ static void rtw_usb_rx_handler(struct work_struct *work)
 				goto skip_packet;
 			}
 
-			skb = alloc_skb(skb_len, GFP_KERNEL);
+			skb = alloc_skb(skb_len, GFP_ATOMIC);
 			if (!skb) {
 				rtw_dbg(rtwdev, RTW_DBG_USB,
 					"failed to allocate RX skb of size %u\n",
@@ -612,32 +612,70 @@ static void rtw_usb_rx_handler(struct work_struct *work)
 			rx_desc += next_pkt;
 		} while (rx_desc + pkt_desc_sz < rx_skb->data + rx_skb->len);
 
-		dev_kfree_skb_any(rx_skb);
+		if (skb_queue_len(&rtwusb->rx_free_queue) >= RTW_USB_RX_SKB_NUM)
+			dev_kfree_skb_any(rx_skb);
+		else
+			skb_queue_tail(&rtwusb->rx_free_queue, rx_skb);
 	}
 }
 
 static void rtw_usb_read_port_complete(struct urb *urb);
 
-static void rtw_usb_rx_resubmit(struct rtw_usb *rtwusb, struct rx_usb_ctrl_block *rxcb)
+static void rtw_usb_rx_resubmit(struct rtw_usb *rtwusb,
+				struct rx_usb_ctrl_block *rxcb,
+				gfp_t gfp)
 {
 	struct rtw_dev *rtwdev = rtwusb->rtwdev;
+	struct sk_buff *rx_skb;
 	int error;
 
-	rxcb->rx_skb = alloc_skb(RTW_USB_MAX_RECVBUF_SZ, GFP_ATOMIC);
-	if (!rxcb->rx_skb)
-		return;
+	rx_skb = skb_dequeue(&rtwusb->rx_free_queue);
+	if (!rx_skb)
+		rx_skb = alloc_skb(RTW_USB_MAX_RECVBUF_SZ, gfp);
+
+	if (!rx_skb)
+		goto try_later;
+
+	skb_reset_tail_pointer(rx_skb);
+	rx_skb->len = 0;
+
+	rxcb->rx_skb = rx_skb;
 
 	usb_fill_bulk_urb(rxcb->rx_urb, rtwusb->udev,
 			  usb_rcvbulkpipe(rtwusb->udev, rtwusb->pipe_in),
 			  rxcb->rx_skb->data, RTW_USB_MAX_RECVBUF_SZ,
 			  rtw_usb_read_port_complete, rxcb);
 
-	error = usb_submit_urb(rxcb->rx_urb, GFP_ATOMIC);
+	error = usb_submit_urb(rxcb->rx_urb, gfp);
 	if (error) {
-		kfree_skb(rxcb->rx_skb);
+		skb_queue_tail(&rtwusb->rx_free_queue, rxcb->rx_skb);
+
 		if (error != -ENODEV)
 			rtw_err(rtwdev, "Err sending rx data urb %d\n",
 				error);
+
+		if (error == -ENOMEM)
+			goto try_later;
+	}
+
+	return;
+
+try_later:
+	rxcb->rx_skb = NULL;
+	queue_work(rtwusb->rxwq, &rtwusb->rx_urb_work);
+}
+
+static void rtw_usb_rx_resubmit_work(struct work_struct *work)
+{
+	struct rtw_usb *rtwusb = container_of(work, struct rtw_usb, rx_urb_work);
+	struct rx_usb_ctrl_block *rxcb;
+	int i;
+
+	for (i = 0; i < RTW_USB_RXCB_NUM; i++) {
+		rxcb = &rtwusb->rx_cb[i];
+
+		if (!rxcb->rx_skb)
+			rtw_usb_rx_resubmit(rtwusb, rxcb, GFP_ATOMIC);
 	}
 }
 
@@ -653,15 +691,16 @@ static void rtw_usb_read_port_complete(struct urb *urb)
 		    urb->actual_length < 24) {
 			rtw_err(rtwdev, "failed to get urb length:%d\n",
 				urb->actual_length);
-			if (skb)
-				dev_kfree_skb_any(skb);
+			skb_queue_tail(&rtwusb->rx_free_queue, skb);
 		} else {
 			skb_put(skb, urb->actual_length);
 			skb_queue_tail(&rtwusb->rx_queue, skb);
 			queue_work(rtwusb->rxwq, &rtwusb->rx_work);
 		}
-		rtw_usb_rx_resubmit(rtwusb, rxcb);
+		rtw_usb_rx_resubmit(rtwusb, rxcb, GFP_ATOMIC);
 	} else {
+		skb_queue_tail(&rtwusb->rx_free_queue, skb);
+
 		switch (urb->status) {
 		case -EINVAL:
 		case -EPIPE:
@@ -679,8 +718,6 @@ static void rtw_usb_read_port_complete(struct urb *urb)
 			rtw_err(rtwdev, "status %d\n", urb->status);
 			break;
 		}
-		if (skb)
-			dev_kfree_skb_any(skb);
 	}
 }
 
@@ -868,16 +905,26 @@ static struct rtw_hci_ops rtw_usb_ops = {
 static int rtw_usb_init_rx(struct rtw_dev *rtwdev)
 {
 	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
+	struct sk_buff *rx_skb;
+	int i;
 
-	rtwusb->rxwq = create_singlethread_workqueue("rtw88_usb: rx wq");
+	rtwusb->rxwq = alloc_workqueue("rtw88_usb: rx wq", WQ_BH, 0);
 	if (!rtwusb->rxwq) {
 		rtw_err(rtwdev, "failed to create RX work queue\n");
 		return -ENOMEM;
 	}
 
 	skb_queue_head_init(&rtwusb->rx_queue);
+	skb_queue_head_init(&rtwusb->rx_free_queue);
 
 	INIT_WORK(&rtwusb->rx_work, rtw_usb_rx_handler);
+	INIT_WORK(&rtwusb->rx_urb_work, rtw_usb_rx_resubmit_work);
+
+	for (i = 0; i < RTW_USB_RX_SKB_NUM; i++) {
+		rx_skb = alloc_skb(RTW_USB_MAX_RECVBUF_SZ, GFP_KERNEL);
+		if (rx_skb)
+			skb_queue_tail(&rtwusb->rx_free_queue, rx_skb);
+	}
 
 	return 0;
 }
@@ -890,7 +937,7 @@ static void rtw_usb_setup_rx(struct rtw_dev *rtwdev)
 	for (i = 0; i < RTW_USB_RXCB_NUM; i++) {
 		struct rx_usb_ctrl_block *rxcb = &rtwusb->rx_cb[i];
 
-		rtw_usb_rx_resubmit(rtwusb, rxcb);
+		rtw_usb_rx_resubmit(rtwusb, rxcb, GFP_KERNEL);
 	}
 }
 
@@ -902,6 +949,8 @@ static void rtw_usb_deinit_rx(struct rtw_dev *rtwdev)
 
 	flush_workqueue(rtwusb->rxwq);
 	destroy_workqueue(rtwusb->rxwq);
+
+	skb_queue_purge(&rtwusb->rx_free_queue);
 }
 
 static int rtw_usb_init_tx(struct rtw_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw88/usb.h b/drivers/net/wireless/realtek/rtw88/usb.h
index 86697a5c0103..9b695b688b24 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.h
+++ b/drivers/net/wireless/realtek/rtw88/usb.h
@@ -38,6 +38,7 @@
 #define RTW_USB_RXAGG_TIMEOUT		10
 
 #define RTW_USB_RXCB_NUM		4
+#define RTW_USB_RX_SKB_NUM		8
 
 #define RTW_USB_EP_MAX			4
 
@@ -81,7 +82,9 @@ struct rtw_usb {
 
 	struct rx_usb_ctrl_block rx_cb[RTW_USB_RXCB_NUM];
 	struct sk_buff_head rx_queue;
+	struct sk_buff_head rx_free_queue;
 	struct work_struct rx_work;
+	struct work_struct rx_urb_work;
 };
 
 static inline struct rtw_usb_tx_data *rtw_usb_get_tx_data(struct sk_buff *skb)
-- 
2.47.1



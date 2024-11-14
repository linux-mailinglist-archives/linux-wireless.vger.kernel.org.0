Return-Path: <linux-wireless+bounces-15308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 131819C95CD
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 00:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7585284B1A
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 23:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56881B219B;
	Thu, 14 Nov 2024 23:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACQ9zNLb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFAC1B218F
	for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2024 23:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625680; cv=none; b=GZXj+y0C4AmSpyEOdR0pH9+LGQ9BcYLKcpjmkEtVRavDkerYd/K/4jPLgx+0a0lrXnThHQkvXNf9CSNYDSBN0r5F1TwIm365Mc9yfDot/qU+/ifZ+d3BiXQnpwQHlh9aB29MK8QmaLuRQhyaOj9fbPZ6qZLvO0yfWb/Kt7V9q5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625680; c=relaxed/simple;
	bh=IV57Jts+oFVcI9FNsSNDKTh4IhqBP0DIGV+Wzyzw3hM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V1AB6PgNQLpLMjXphH51dSE7Ukma5E7eRA82mKWlXmbB5F8EF2ue/zgye+8Xw7O6czdp6tXZilNHwTRFqhdiM8tLRAuKAUv9/vAs8aebhg/Qu1yKLd9UmAc8YUp72Mty/wwubMB8nA1vsGUwuqmSY3iB67oR89NloB1ZWPj+LUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACQ9zNLb; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso177344166b.1
        for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2024 15:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625677; x=1732230477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MgJmzUrXPTEJvqLp3f27cCPRtCUqVYWqFMfFL6djntg=;
        b=ACQ9zNLbpG9aQbMtAytWA0cWQUYpWLx0aMKxF+UTPsxcxH5ijfaFifeo/H/RhzOVv1
         fqQpd9/l9MU+LDj7v1bkDB4P68Rx3Vy5g1A6E0u83liN+OmZu19Xmy90ICFa0DVatqkY
         b7Xs3Wd9ou21lwYGj0fBIXCbd18kUGQhMfICK/nbLTcUg0tc0I7KIAn94jfjKhnQShaW
         pcQoH2h6x2tuzKO1glXxnHsUfCIkpwHbcKpVjQC35N24984id0Ud+cmzuATA2FdtgFgU
         qhEG+Rd3HfFImH45fBEcYgpZUPsGz+oOjc+8X2Vf7kS66WD+E50ZleSh1f719WhXeIK0
         iRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625677; x=1732230477;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MgJmzUrXPTEJvqLp3f27cCPRtCUqVYWqFMfFL6djntg=;
        b=IehlFVbFOKfU42IXwEmGpr14j2qNStiDLMZT9QsrMFMfAsx/hL67g6ruENicSteeDW
         LV0rts2OZwuN1Tl32FIpYojSoPcZ5LcEHGKC8n9pNtH/FTxfskduQV9xnRK6Vme1Ec+W
         aLpIObQAi1YS8EfKEdZlbs85fshRAyppq1BPZV7ECNqma83AGRd7YHsioveSCNbNI+T+
         cmSlC75JN/+Oe2Y7BU/BpvT1b7DhLnLC9/p7Q1fHzgSyaPbqmuBxF4CHFqJFiNtc5FJh
         LSdCxsgLg/NMPuCAvmilEDLY3bR0rLPk3rlrHS31mB6oGNsPmD7M+3NUPlFJS9DxOlwb
         M2YA==
X-Gm-Message-State: AOJu0YzB6Ihym6SFobR9uwXQ5zT/fFhv0aAhZ2rkh5bDJ1v3KwYavm/F
	nCI3Km3dqQQfA1kmQn1xa37/h0FB3CJ3iryrEuZ8bxzZkIb2R01yhSqTIw==
X-Google-Smtp-Source: AGHT+IG+iAdb6zAs4pBbBKtad/ZAPgqf6hiqHmMGeQrO+1Z+NHkXPtqdfI3U4JGJd4mNaTO7dIOLNA==
X-Received: by 2002:a17:907:3e0c:b0:a9a:825:4c46 with SMTP id a640c23a62f3a-aa4834826b8mr29873166b.28.1731625676707;
        Thu, 14 Nov 2024 15:07:56 -0800 (PST)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e046ea8sm111069266b.169.2024.11.14.15.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 15:07:56 -0800 (PST)
Message-ID: <4e83ae71-60e2-4f24-a251-18cd59543d6d@gmail.com>
Date: Fri, 15 Nov 2024 01:07:53 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] wifi: rtw88: usb: Preallocate and reuse the RX skbs
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <28b09f4d-5271-470d-99b6-a0bbe0224739@gmail.com>
Content-Language: en-US
In-Reply-To: <28b09f4d-5271-470d-99b6-a0bbe0224739@gmail.com>
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

Move C2H_ADAPTIVITY to the c2h workqueue instead of handling it directly
from rtw_fw_c2h_cmd_rx_irqsafe(), which runs in the RX workqueue. It
reads hardware registers, which is not "irqsafe" with USB.

This is more or less what the out-of-tree Realtek drivers do, except
they use a tasklet instead of a BH workqueue.

Tested with RTL8723DU, RTL8821AU, RTL8812AU, RTL8812BU, RTL8822CU,
RTL8811CU.

Closes: https://lore.kernel.org/linux-wireless/6e7ecb47-7ea0-433a-a19f-05f88a2edf6b@gmail.com/
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c  |  7 +--
 drivers/net/wireless/realtek/rtw88/usb.c | 73 ++++++++++++++++++++----
 drivers/net/wireless/realtek/rtw88/usb.h |  3 +
 3 files changed, 67 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index e6e9946fbf44..02389b7c6876 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -332,6 +332,9 @@ void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
 	case C2H_RA_RPT:
 		rtw_fw_ra_report_handle(rtwdev, c2h->payload, len);
 		break;
+	case C2H_ADAPTIVITY:
+		rtw_fw_adaptivity_result(rtwdev, c2h->payload, len);
+		break;
 	default:
 		rtw_dbg(rtwdev, RTW_DBG_FW, "C2H 0x%x isn't handled\n", c2h->id);
 		break;
@@ -367,10 +370,6 @@ void rtw_fw_c2h_cmd_rx_irqsafe(struct rtw_dev *rtwdev, u32 pkt_offset,
 		rtw_fw_scan_result(rtwdev, c2h->payload, len);
 		dev_kfree_skb_any(skb);
 		break;
-	case C2H_ADAPTIVITY:
-		rtw_fw_adaptivity_result(rtwdev, c2h->payload, len);
-		dev_kfree_skb_any(skb);
-		break;
 	default:
 		/* pass offset for further operation */
 		*((u32 *)skb->cb) = pkt_offset;
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 727569d4ef4b..5c2dfa2ced92 100644
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
@@ -612,7 +612,11 @@ static void rtw_usb_rx_handler(struct work_struct *work)
 			rx_desc += next_pkt;
 		} while (rx_desc + pkt_desc_sz < rx_skb->data + rx_skb->len);
 
-		dev_kfree_skb_any(rx_skb);
+		if (skb_queue_len(&rtwusb->rx_free_queue) >=
+		    RTW_USB_RX_SKB_NUM - RTW_USB_RXCB_NUM)
+			dev_kfree_skb_any(rx_skb);
+		else
+			skb_queue_tail(&rtwusb->rx_free_queue, rx_skb);
 	}
 }
 
@@ -621,23 +625,57 @@ static void rtw_usb_read_port_complete(struct urb *urb);
 static void rtw_usb_rx_resubmit(struct rtw_usb *rtwusb, struct rx_usb_ctrl_block *rxcb)
 {
 	struct rtw_dev *rtwdev = rtwusb->rtwdev;
+	struct sk_buff *rx_skb;
+	gfp_t priority = in_interrupt() ? GFP_ATOMIC : GFP_KERNEL;
 	int error;
 
-	rxcb->rx_skb = alloc_skb(RTW_USB_MAX_RECVBUF_SZ, GFP_ATOMIC);
-	if (!rxcb->rx_skb)
-		return;
+	rx_skb = skb_dequeue(&rtwusb->rx_free_queue);
+	if (!rx_skb)
+		rx_skb = alloc_skb(RTW_USB_MAX_RECVBUF_SZ, priority);
+
+	if (!rx_skb)
+		goto try_later;
+
+	rxcb->rx_skb = rx_skb;
+
+	skb_reset_tail_pointer(rxcb->rx_skb);
+	rxcb->rx_skb->len = 0;
 
 	usb_fill_bulk_urb(rxcb->rx_urb, rtwusb->udev,
 			  usb_rcvbulkpipe(rtwusb->udev, rtwusb->pipe_in),
 			  rxcb->rx_skb->data, RTW_USB_MAX_RECVBUF_SZ,
 			  rtw_usb_read_port_complete, rxcb);
 
-	error = usb_submit_urb(rxcb->rx_urb, GFP_ATOMIC);
+	error = usb_submit_urb(rxcb->rx_urb, priority);
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
+			rtw_usb_rx_resubmit(rtwusb, rxcb);
 	}
 }
 
@@ -653,8 +691,7 @@ static void rtw_usb_read_port_complete(struct urb *urb)
 		    urb->actual_length < 24) {
 			rtw_err(rtwdev, "failed to get urb length:%d\n",
 				urb->actual_length);
-			if (skb)
-				dev_kfree_skb_any(skb);
+			skb_queue_tail(&rtwusb->rx_free_queue, skb);
 		} else {
 			skb_put(skb, urb->actual_length);
 			skb_queue_tail(&rtwusb->rx_queue, skb);
@@ -662,6 +699,8 @@ static void rtw_usb_read_port_complete(struct urb *urb)
 		}
 		rtw_usb_rx_resubmit(rtwusb, rxcb);
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
2.47.0



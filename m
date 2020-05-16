Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CCC1D606E
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2020 12:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgEPKun (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 May 2020 06:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725917AbgEPKun (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 May 2020 06:50:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA84C061A0C
        for <linux-wireless@vger.kernel.org>; Sat, 16 May 2020 03:50:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h17so6282347wrc.8
        for <linux-wireless@vger.kernel.org>; Sat, 16 May 2020 03:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=lEXuPvFGjE4malU7fQB2EUdQISjNfzYyGgcDPxh2TpY=;
        b=ROksojIEr6T11iwZiyy0Wxqos6BCJayDicZzAa9sQUtvbLFJ0UbHS2HaMPihlf+6rN
         rhKD5IGnTlR4TAlLOMxUDWFRBoHO3ettjdEMHkzYCMPP3M728lS0/xZ7LJhjyEshelSm
         k3GwtVvkLLVuYPS3g4c9Gn79j+ntnQhYuMrnZSw+vtTzbdyj2qK1YCAC1sleWZ5QU+nm
         r1AyAL5lMPc/oxlyr+WmvUovGuQ+eztk1+RfURedDA6+mgMhuMwXLkDk8GRQizkANOPK
         fEcDO/FYIsLJkOtqlYNx+KGTJqRo5b7B8S11JlT3o2D8B3YFkAFBoye9bUAJps9EJRCj
         iInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=lEXuPvFGjE4malU7fQB2EUdQISjNfzYyGgcDPxh2TpY=;
        b=SnRebaok/vSyIXeV/yCP847eBXaKI76slQjSmfkSOUQCCAMKEbjAeyH7GSLbILuc/f
         kjhjfSir42wC2edMYbC/K0IOYqsqRkLURWuPGI0nmfyvKtE9bWjGdxhO3YWQsZDjdvRr
         ZoZvwexgUCvyE6M0FS1cSJM2FZycb68F2YjalxTksWH5pQiLO3G1aGKzbng5DDFRQWEA
         b65oQPwi4xyUKy36J5al5BoW4S+H/OeXLJqzA6wTn3+3NB41W9+4iVEQDNSdSYmRLhfC
         qaXNLA9qHj3iOYX+hGgU9dDcnzG7M4zvigJmIM0lbGW0L7D8NRPipFHYhLRVPbgU3hi4
         5tog==
X-Gm-Message-State: AOAM53235G+qq0RCwWaHV4eF9lWSZ+aUhdbKSLEla45bnU9F84VYUo7F
        0eH191UtA9gy89eOuLvk/srToLCN
X-Google-Smtp-Source: ABdhPJyNNGmFTmra3dAaZyz2R74a6zJ9M7LmM+cDlMsNyAeE8StPA2n6ZCUSMG5RugNNbetAP7Q96g==
X-Received: by 2002:a5d:4c86:: with SMTP id z6mr8702803wrs.279.1589626240978;
        Sat, 16 May 2020 03:50:40 -0700 (PDT)
Received: from [192.168.43.18] ([185.69.145.77])
        by smtp.gmail.com with ESMTPSA id m65sm7413289wmm.17.2020.05.16.03.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 03:50:40 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 4/4] staging: vt6656: use usb_anchor for tx queue.
Message-ID: <077f42f8-4f7f-adc4-5a14-955165cef9f1@gmail.com>
Date:   Sat, 16 May 2020 11:50:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use usb_anchor to track tx submitted urbs and initialize the
urb as needed in vnt_tx_context.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/device.h   |  2 +-
 drivers/staging/vt6656/main_usb.c | 18 ++++--------------
 drivers/staging/vt6656/usbpipe.c  | 14 ++++++++++++--
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
index 08294b21c4e9..d1b19dcaf991 100644
--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -238,7 +238,6 @@ struct vnt_rcb {
 struct vnt_usb_send_context {
 	void *priv;
 	struct sk_buff *skb;
-	struct urb *urb;
 	struct ieee80211_hdr *hdr;
 	void *tx_buffer;
 	unsigned int buf_len;
@@ -292,6 +291,7 @@ struct vnt_private {
 
 	/* Variables to track resources for the BULK Out Pipe */
 	struct vnt_usb_send_context *tx_context[CB_MAX_TX_DESC];
+	struct usb_anchor tx_submitted;
 	u32 num_tx_context;
 
 	/* Variables to track resources for the Interrupt In Pipe */
diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index 930ee424ecdf..c0169e32621b 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -445,17 +445,13 @@ static void vnt_free_tx_bufs(struct vnt_private *priv)
 	struct vnt_usb_send_context *tx_context;
 	int ii;
 
+	usb_kill_anchored_urbs(&priv->tx_submitted);
+
 	for (ii = 0; ii < priv->num_tx_context; ii++) {
 		tx_context = priv->tx_context[ii];
 		if (!tx_context)
 			continue;
 
-		/* deallocate URBs */
-		if (tx_context->urb) {
-			usb_kill_urb(tx_context->urb);
-			usb_free_urb(tx_context->urb);
-		}
-
 		kfree(tx_context);
 	}
 }
@@ -496,6 +492,8 @@ static int vnt_alloc_bufs(struct vnt_private *priv)
 	struct vnt_rcb *rcb;
 	int ii;
 
+	init_usb_anchor(&priv->tx_submitted);
+
 	for (ii = 0; ii < priv->num_tx_context; ii++) {
 		tx_context = kmalloc(sizeof(*tx_context), GFP_KERNEL);
 		if (!tx_context) {
@@ -506,14 +504,6 @@ static int vnt_alloc_bufs(struct vnt_private *priv)
 		priv->tx_context[ii] = tx_context;
 		tx_context->priv = priv;
 		tx_context->pkt_no = ii;
-
-		/* allocate URBs */
-		tx_context->urb = usb_alloc_urb(0, GFP_KERNEL);
-		if (!tx_context->urb) {
-			ret = -ENOMEM;
-			goto free_tx;
-		}
-
 		tx_context->in_use = false;
 	}
 
diff --git a/drivers/staging/vt6656/usbpipe.c b/drivers/staging/vt6656/usbpipe.c
index 43f1ef32a9ce..2164f45e13ab 100644
--- a/drivers/staging/vt6656/usbpipe.c
+++ b/drivers/staging/vt6656/usbpipe.c
@@ -456,7 +456,7 @@ int vnt_tx_context(struct vnt_private *priv,
 		   struct vnt_usb_send_context *context)
 {
 	int status;
-	struct urb *urb = context->urb;
+	struct urb *urb;
 
 	if (test_bit(DEVICE_FLAGS_DISCONNECTED, &priv->flags)) {
 		context->in_use = false;
@@ -468,6 +468,12 @@ int vnt_tx_context(struct vnt_private *priv,
 		return -E2BIG;
 	}
 
+	urb = usb_alloc_urb(0, GFP_ATOMIC);
+	if (!urb) {
+		context->in_use = false;
+		return -ENOMEM;
+	}
+
 	usb_fill_bulk_urb(urb,
 			  priv->usb,
 			  usb_sndbulkpipe(priv->usb, 3),
@@ -476,12 +482,16 @@ int vnt_tx_context(struct vnt_private *priv,
 			  vnt_tx_context_complete,
 			  context);
 
+	usb_anchor_urb(urb, &priv->tx_submitted);
+
 	status = usb_submit_urb(urb, GFP_ATOMIC);
 	if (status) {
 		dev_dbg(&priv->usb->dev, "Submit Tx URB failed %d\n", status);
-
+		usb_unanchor_urb(urb);
 		context->in_use = false;
 	}
 
+	usb_free_urb(urb);
+
 	return status;
 }
-- 
2.25.1

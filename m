Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C301D6065
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2020 12:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgEPKf1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 May 2020 06:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726206AbgEPKf0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 May 2020 06:35:26 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297B6C061A0C
        for <linux-wireless@vger.kernel.org>; Sat, 16 May 2020 03:35:26 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z72so5160050wmc.2
        for <linux-wireless@vger.kernel.org>; Sat, 16 May 2020 03:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=PI57yVFsMFnYb9rbLm40xiBPmWGcJoRd3kiI6gVBkeE=;
        b=rVEcPKiU4ubqlT0Xpt8FphZOlW+i/1KJlqLoRu1i1LzokJAx1trHqNoMPMxFldgws4
         0u1vvCQhlwmd6g2j4zjZztXRwTGJkF8qOqQhuq2Be/GZ3A9T4et0DoLboTK+MnkkQ/f7
         HC3YqZ5RnPvknnf/Snym4nMENA37O+tx/qC7k4eL3ZiQI39QjzS+92PKPGOyPr90JoHT
         LJi7IO+2JT2PLHQLQoMt12+r04mAH8F0rkpJF8PZ4J56bjnzITH/oKaLsa2NkOkbFLNp
         9T+INFNWOp7ZsKFT/SPCYwXtbnE5ceB/wfeyf6Tb0YQLNnsIyky3UD8TvRu6lKo9DK4Q
         vK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=PI57yVFsMFnYb9rbLm40xiBPmWGcJoRd3kiI6gVBkeE=;
        b=s7B3mnFY7oaR6dej5Ijx9onRuRI2/nVZRCg8IHaFD3ImVeDC5JWUfiwkSXWZKoJ5hG
         goD3Ng6mSRlLIz3wduvCbbOouvZoFNZwQCn1ZeOyVr9R5DRfW18LszMfCcdKVs9mFVCF
         OSLt4Euy3e3zMNgsV/pXzwf019JvKg/CyD0MGfYdd3VQWmWw2jjdakBbSoSWAeJkRGHd
         4YuiLQ/pFPjVNViSY5035tYYTlW56pBtXhycziDpJB5UQuOWR7GBIFy5tRCLQEX0Hq9h
         a78Fn99R+Aztyek1oA8rFjIgiKkHftlVbmcLR4PlneRAIAPfkpGO+rTu/iqE8xMYxyOv
         /nDA==
X-Gm-Message-State: AOAM532dvgsdbdpMjVOjXedJGaZhVA5DZ3UTxrvXwXd8kxnNshkn/6MD
        +rC8I0ORFvzgFrLWHy9GoI8t7veG
X-Google-Smtp-Source: ABdhPJxtYwKqEAUiLE+HWFWrVdxjJ/jfGhaM1JWlWsUO08JBe1HMp7ECBirVEtt4xTK4cdsgFgh3pQ==
X-Received: by 2002:a7b:c951:: with SMTP id i17mr8306422wml.63.1589625324388;
        Sat, 16 May 2020 03:35:24 -0700 (PDT)
Received: from [192.168.43.18] ([185.69.145.77])
        by smtp.gmail.com with ESMTPSA id m7sm7219904wmc.40.2020.05.16.03.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 03:35:23 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 1/4] staging: vt6656: Use sk_buff buffer for tx header
Message-ID: <7b967bfc-1d4b-4b45-efab-d54f16cca226@gmail.com>
Date:   Sat, 16 May 2020 11:35:22 +0100
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

mac80211 can provide space for the driver to put a tx header on
the skb buffer instead coping the entire frame on to a local
buffer with the header.

To use this extra_tx_headroom must be set in mac80211 with the largest
possible header which is struct vnt_tx_buffer.

The driver has 8 possible combinations of tx header size which
are found in vnt_get_hdr_size replacing vnt_mac_hdr_pos.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/device.h   |  1 +
 drivers/staging/vt6656/main_usb.c |  1 +
 drivers/staging/vt6656/rxtx.c     | 91 ++++++++++++++++++-------------
 drivers/staging/vt6656/rxtx.h     |  8 ++-
 drivers/staging/vt6656/usbpipe.c  |  2 +-
 5 files changed, 61 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
index d19d802b5d4f..074b98dfac91 100644
--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -240,6 +240,7 @@ struct vnt_usb_send_context {
 	struct sk_buff *skb;
 	struct urb *urb;
 	struct ieee80211_hdr *hdr;
+	void *tx_buffer;
 	unsigned int buf_len;
 	u32 frame_len;
 	u16 tx_hdr_size;
diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index b5790d4d7152..930ee424ecdf 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -1053,6 +1053,7 @@ vt6656_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	ieee80211_hw_set(priv->hw, SUPPORTS_PS);
 	ieee80211_hw_set(priv->hw, PS_NULLFUNC_STACK);
 
+	priv->hw->extra_tx_headroom = sizeof(struct vnt_tx_buffer);
 	priv->hw->max_signal = 100;
 
 	SET_IEEE80211_DEV(priv->hw, &intf->dev);
diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 8348ffe6ebfa..792833f8192a 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -188,19 +188,6 @@ static __le16 vnt_get_cts_duration(struct vnt_usb_send_context *context)
 					    context->frame_len, info);
 }
 
-static u16 vnt_mac_hdr_pos(struct vnt_usb_send_context *tx_context,
-			   struct ieee80211_hdr *hdr)
-{
-	u8 *head = tx_context->data + offsetof(struct vnt_tx_buffer, fifo_head);
-	u8 *hdr_pos = (u8 *)hdr;
-
-	tx_context->hdr = hdr;
-	if (!tx_context->hdr)
-		return 0;
-
-	return (u16)(hdr_pos - head);
-}
-
 static void vnt_rxtx_datahead_g(struct vnt_usb_send_context *tx_context,
 				struct vnt_tx_datahead_g *buf)
 {
@@ -221,8 +208,6 @@ static void vnt_rxtx_datahead_g(struct vnt_usb_send_context *tx_context,
 	buf->time_stamp_off_a = vnt_time_stamp_off(priv, rate);
 	buf->time_stamp_off_b = vnt_time_stamp_off(priv,
 						   priv->top_cck_basic_rate);
-
-	tx_context->tx_hdr_size = vnt_mac_hdr_pos(tx_context, &buf->hdr);
 }
 
 static void vnt_rxtx_datahead_ab(struct vnt_usb_send_context *tx_context,
@@ -241,8 +226,6 @@ static void vnt_rxtx_datahead_ab(struct vnt_usb_send_context *tx_context,
 	/* Get Duration and TimeStampOff */
 	buf->duration = hdr->duration_id;
 	buf->time_stamp_off = vnt_time_stamp_off(priv, rate);
-
-	tx_context->tx_hdr_size = vnt_mac_hdr_pos(tx_context, &buf->hdr);
 }
 
 static void vnt_fill_ieee80211_rts(struct vnt_usb_send_context *tx_context,
@@ -479,6 +462,39 @@ static void vnt_fill_txkey(struct vnt_usb_send_context *tx_context,
 	}
 }
 
+static u16 vnt_get_hdr_size(struct ieee80211_tx_info *info)
+{
+	u16 size = sizeof(struct vnt_tx_datahead_ab);
+
+	if (info->control.use_cts_prot) {
+		if (info->control.use_rts)
+			size = sizeof(struct vnt_rts_g);
+		else
+			size = sizeof(struct vnt_cts);
+	} else if (info->control.use_rts) {
+		size = sizeof(struct vnt_rts_ab);
+	}
+
+	if (info->control.hw_key) {
+		if (info->control.hw_key->cipher == WLAN_CIPHER_SUITE_CCMP)
+			size += sizeof(struct vnt_mic_hdr);
+	}
+
+	/* Get rrv_time header */
+	if (info->control.use_cts_prot) {
+		if (info->control.use_rts)
+			size += sizeof(struct vnt_rrv_time_rts);
+		else
+			size += sizeof(struct vnt_rrv_time_cts);
+	} else {
+		size += sizeof(struct vnt_rrv_time_ab);
+	}
+
+	size += sizeof(struct vnt_tx_fifo_head);
+
+	return size;
+}
+
 int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
@@ -531,12 +547,29 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	tx_context->need_ack = false;
 	tx_context->frame_len = skb->len + 4;
 	tx_context->tx_rate =  rate->hw_value;
+	tx_context->hdr = hdr;
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	tx_buffer = (struct vnt_tx_buffer *)tx_context->data;
-	tx_buffer_head = &tx_buffer->fifo_head;
+	tx_header_size = vnt_get_hdr_size(info);
 	tx_body_size = skb->len;
+	tx_bytes = tx_header_size + tx_body_size;
+	tx_header_size += sizeof(struct vnt_tx_usb_header);
+
+	tx_buffer = skb_push(skb, tx_header_size);
+	tx_buffer_head = &tx_buffer->fifo_head;
+
+	/* Fill USB header */
+	tx_buffer->usb.tx_byte_count = cpu_to_le16(tx_bytes);
+	tx_buffer->usb.pkt_no = tx_context->pkt_no;
+	tx_buffer->usb.type = 0x00;
+
+	tx_context->type = CONTEXT_DATA_PACKET;
+	tx_context->tx_buffer = tx_buffer;
+	tx_context->buf_len = skb->len;
+
+	/* Return skb->data to mac80211 header */
+	skb_pull(skb, tx_header_size);
 
 	/*Set fifo controls */
 	if (pkt_type == PK_TYPE_11A)
@@ -603,18 +636,8 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	vnt_generate_tx_parameter(tx_context, tx_buffer, &mic_hdr,
 				  need_mic, need_rts);
 
-	tx_header_size = tx_context->tx_hdr_size;
-	if (!tx_header_size) {
-		tx_context->in_use = false;
-		return -ENOMEM;
-	}
-
 	tx_buffer_head->frag_ctl |= cpu_to_le16(FRAGCTL_NONFRAG);
 
-	tx_bytes = tx_header_size + tx_body_size;
-
-	memcpy(tx_context->hdr, skb->data, tx_body_size);
-
 	if (info->control.hw_key) {
 		tx_key = info->control.hw_key;
 		if (tx_key->keylen > 0)
@@ -625,15 +648,6 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	priv->seq_counter = (le16_to_cpu(hdr->seq_ctrl) &
 						IEEE80211_SCTL_SEQ) >> 4;
 
-	tx_buffer->tx_byte_count = cpu_to_le16(tx_bytes);
-	tx_buffer->pkt_no = tx_context->pkt_no;
-	tx_buffer->type = 0x00;
-
-	tx_bytes += 4;
-
-	tx_context->type = CONTEXT_DATA_PACKET;
-	tx_context->buf_len = tx_bytes;
-
 	spin_lock_irqsave(&priv->lock, flags);
 
 	if (vnt_tx_context(priv, tx_context)) {
@@ -725,6 +739,7 @@ static int vnt_beacon_xmit(struct vnt_private *priv, struct sk_buff *skb)
 	beacon_buffer->type = 0x01;
 
 	context->type = CONTEXT_BEACON_PACKET;
+	context->tx_buffer = &context->data;
 	context->buf_len = count + 4; /* USB header */
 
 	spin_lock_irqsave(&priv->lock, flags);
diff --git a/drivers/staging/vt6656/rxtx.h b/drivers/staging/vt6656/rxtx.h
index 3c36a4b893dc..819b45394673 100644
--- a/drivers/staging/vt6656/rxtx.h
+++ b/drivers/staging/vt6656/rxtx.h
@@ -77,14 +77,12 @@ struct vnt_tx_datahead_g {
 	__le16 duration_a;
 	__le16 time_stamp_off_b;
 	__le16 time_stamp_off_a;
-	struct ieee80211_hdr hdr;
 } __packed;
 
 struct vnt_tx_datahead_ab {
 	struct vnt_phy_field ab;
 	__le16 duration;
 	__le16 time_stamp_off;
-	struct ieee80211_hdr hdr;
 } __packed;
 
 /* RTS buffer header */
@@ -161,10 +159,14 @@ struct vnt_tx_fifo_head {
 	__le16 current_rate;
 } __packed;
 
-struct vnt_tx_buffer {
+struct vnt_tx_usb_header {
 	u8 type;
 	u8 pkt_no;
 	__le16 tx_byte_count;
+} __packed;
+
+struct vnt_tx_buffer {
+	struct vnt_tx_usb_header usb;
 	struct vnt_tx_fifo_head fifo_head;
 	union vnt_tx_head tx_head;
 } __packed;
diff --git a/drivers/staging/vt6656/usbpipe.c b/drivers/staging/vt6656/usbpipe.c
index 06dedf291db2..904645fa0eb0 100644
--- a/drivers/staging/vt6656/usbpipe.c
+++ b/drivers/staging/vt6656/usbpipe.c
@@ -466,7 +466,7 @@ int vnt_tx_context(struct vnt_private *priv,
 	usb_fill_bulk_urb(urb,
 			  priv->usb,
 			  usb_sndbulkpipe(priv->usb, 3),
-			  context->data,
+			  context->tx_buffer,
 			  context->buf_len,
 			  vnt_tx_context_complete,
 			  context);
-- 
2.25.1

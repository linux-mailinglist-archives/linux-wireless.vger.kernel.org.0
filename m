Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2D41DCA43
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 11:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgEUJia (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 05:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbgEUJia (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 05:38:30 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E519CC061A0E
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:38:29 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l17so6013191wrr.4
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=OgyKLtsl9tNNZ+v+VLvWxQraa+qu3UB9bjlUpwB1inI=;
        b=kFN0jhhJnSIpf27pQnJxKA3G7ECLmLhcTQoiAu2pGIBpKqn8lQNBFvWEjdxEJuAL9E
         T+RNjyehSBZk51qqRYYRCJXMQMJcwOHr0/PmONibbePBVo5FjGyrYQcC0evwTZTQRP0m
         JB1I8RM9HLyTTbjzSW+sOXzAClB/dR0V0nR9WmNfata8nP2cNyw5ZxOwa6XTqIKCWMvT
         DE0zbikggO7Ja0K2OewPVAEgLJsjhR70R6f+gP/Gyv1MtC7qs2xdKwtlnOdjnqIQq4Z8
         rPvGT16/TvlL7mtHK40K9/EnvmqMG6HTvVuY79p/rv/kjMXN2HuVWBMBv5W5ZgnWMET5
         z1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=OgyKLtsl9tNNZ+v+VLvWxQraa+qu3UB9bjlUpwB1inI=;
        b=ID9K3rzw6ctscWc7iM5h/j0FU6fdooZ/qKw6edTFsdi1RTniqGEBPTPhHWSw1VC3ZT
         yXkHdPynvEaf4DxY1qM2IheaL1UUyNW8lyBn20sEOfF7ZxCnKPOnYklpW5QpShW87yq/
         lG8B1UmyIbju1YE+zCysxT3IH2PzC5nnBTVNmD9UER8UUDRi9bWawowilVEkIfFepr+e
         CGv7R2RR9+bsw6Q2qC06jqTCTPkdg6xAinFPjLL148FrVuJnut9I18+WYbPNiFOw4P9r
         z/FNVv3Zg9LRB5VTU5M4KStrhAU16Gd49QwEFsCJr12JrDnQ3NTBn/MuCGhw5uPW50sG
         cTjQ==
X-Gm-Message-State: AOAM533TNKj8+DvLVCMsgpRs4iC5JzenetFtizq8d8uNzioJJ7zA68/F
        Um5kXQvnS/3lT3JAnlCEmgUdOYOTSfWtbg==
X-Google-Smtp-Source: ABdhPJyQ2cs17INGlJLY+RvMyXNB1VzYC+aF4aMyXhxT1NEgIo3yqdwW4TIiKjW5rR8eXjYXBmKk6A==
X-Received: by 2002:a5d:4041:: with SMTP id w1mr7746562wrp.245.1590053908476;
        Thu, 21 May 2020 02:38:28 -0700 (PDT)
Received: from [192.168.43.18] ([85.255.237.70])
        by smtp.gmail.com with ESMTPSA id e22sm5553779wrc.41.2020.05.21.02.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 02:38:28 -0700 (PDT)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 03/10] staging: vt6656: Move vnt_mic_hdr pointers to
 vnt_fill_txkey
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
Message-ID: <6420a6ae-82eb-f794-fa7c-bac419222ad6@gmail.com>
Date:   Thu, 21 May 2020 10:38:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mic_hdr has three possible locations ieee80211_tx_info can controls
these with control.use_cts_prot for rts or cts exchange or otherwise
the rts/data position.

Removing double pointer.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/rxtx.c | 37 ++++++++++++++---------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 24acc2de0fb9..87fe7df07f03 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -356,40 +356,30 @@ static void vnt_rxtx_ab(struct vnt_usb_send_context *tx_context,
 
 static void vnt_generate_tx_parameter(struct vnt_usb_send_context *tx_context,
 				      struct vnt_tx_buffer *tx_buffer,
-				      struct vnt_mic_hdr **mic_hdr,
 				      u32 need_mic, bool need_rts)
 {
 	if (tx_context->pkt_type == PK_TYPE_11GB ||
 	    tx_context->pkt_type == PK_TYPE_11GA) {
 		if (need_rts) {
-			if (need_mic)
-				*mic_hdr =
-					&tx_buffer->tx_head.tx_rts.tx.mic.hdr;
-
 			vnt_rxtx_rts(tx_context, &tx_buffer->tx_head, need_mic);
 
 			return;
 		}
 
-		if (need_mic)
-			*mic_hdr = &tx_buffer->tx_head.tx_cts.tx.mic.hdr;
-
 		vnt_rxtx_cts(tx_context, &tx_buffer->tx_head, need_mic);
 
 		return;
 	}
 
-	if (need_mic)
-		*mic_hdr = &tx_buffer->tx_head.tx_ab.tx.mic.hdr;
-
 	vnt_rxtx_ab(tx_context, &tx_buffer->tx_head, need_rts, need_mic);
 }
 
-static void vnt_fill_txkey(struct vnt_usb_send_context *tx_context,
+static void vnt_fill_txkey(struct vnt_tx_buffer *tx_buffer,
 			   u8 *key_buffer, struct ieee80211_key_conf *tx_key,
-			   struct sk_buff *skb, u16 payload_len,
-			   struct vnt_mic_hdr *mic_hdr)
+			   struct sk_buff *skb, u16 payload_len)
 {
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct vnt_mic_hdr *mic_hdr;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	u64 pn64;
 	u8 *iv = ((u8 *)hdr + ieee80211_get_hdrlen_from_skb(skb));
@@ -416,9 +406,14 @@ static void vnt_fill_txkey(struct vnt_usb_send_context *tx_context,
 
 		break;
 	case WLAN_CIPHER_SUITE_CCMP:
-
-		if (!mic_hdr)
-			return;
+		if (info->control.use_cts_prot) {
+			if (info->control.use_rts)
+				mic_hdr = &tx_buffer->tx_head.tx_rts.tx.mic.hdr;
+			else
+				mic_hdr = &tx_buffer->tx_head.tx_cts.tx.mic.hdr;
+		} else {
+			mic_hdr = &tx_buffer->tx_head.tx_ab.tx.mic.hdr;
+		}
 
 		mic_hdr->id = 0x59;
 		mic_hdr->payload_len = cpu_to_be16(payload_len);
@@ -497,7 +492,6 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	struct ieee80211_rate *rate;
 	struct ieee80211_key_conf *tx_key;
 	struct ieee80211_hdr *hdr;
-	struct vnt_mic_hdr *mic_hdr = NULL;
 	struct vnt_tx_buffer *tx_buffer;
 	struct vnt_tx_fifo_head *tx_buffer_head;
 	struct vnt_usb_send_context *tx_context;
@@ -624,16 +618,15 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 
 	tx_buffer_head->current_rate = cpu_to_le16(rate->hw_value);
 
-	vnt_generate_tx_parameter(tx_context, tx_buffer, &mic_hdr,
-				  need_mic, need_rts);
+	vnt_generate_tx_parameter(tx_context, tx_buffer, need_mic, need_rts);
 
 	tx_buffer_head->frag_ctl |= cpu_to_le16(FRAGCTL_NONFRAG);
 
 	if (info->control.hw_key) {
 		tx_key = info->control.hw_key;
 		if (tx_key->keylen > 0)
-			vnt_fill_txkey(tx_context, tx_buffer_head->tx_key,
-				       tx_key, skb, tx_body_size, mic_hdr);
+			vnt_fill_txkey(tx_buffer, tx_buffer_head->tx_key,
+				       tx_key, skb, tx_body_size);
 	}
 
 	priv->seq_counter = (le16_to_cpu(hdr->seq_ctrl) &
-- 
2.25.1



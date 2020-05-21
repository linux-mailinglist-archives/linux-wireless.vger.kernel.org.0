Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3983D1DCA53
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 11:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgEUJkU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 05:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbgEUJkU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 05:40:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F2FC061A0E
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:40:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n18so5696141wmj.5
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/pwdCDKjLF+e60HESsBhV0UAePDZFaCim4hK40cyzwA=;
        b=Zn1GURocLwVv1FHneGu28MRLLeF4Q1djtyuhV5Bb9sgDl0cC4K5A90QEfCbwEHFcqg
         k3JR8/RLEau0tIxz8ArgCiVcJDRqGQk19DDAg8iEN2IOkCIknBHI5gxUhJPZpjT54oLz
         z0YymAMBKm2wRIE6xHI3xzmVC1uvsYJ3HpdnWuNfdiVhOxwXgo3q+5hyYbWrTwsMWrvn
         3Ov/sVohqQDAL+/qDZVCDuKeO9n9AyGt6zA9zAwzibbegw2LNkFabNpyAMq1epIMP/ib
         P89rU6QV1zS9bNL1QSSoYRiyLrWMM89lpL6j04/kc8eTaxnPVOOerOHH+EFXKEXwIAl1
         ypwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/pwdCDKjLF+e60HESsBhV0UAePDZFaCim4hK40cyzwA=;
        b=tzjlIKNALQLtINz6Lb1us+FZBvJbGltfsnSZYMIaTLosobncK4TAcKreQhsXVThb1m
         cmhe/si9VsaR/9tdpfA+I8GOnYYdpJ6LIQocommuU85UtrxI2BlGR8vjiRr1YgB7YYLR
         y9YtCZUHXYjAc67VEJCHjuNbTvm2r5sX+uvW8BA/oSY2DB6za9dyr5nmwUs6Da7y8dUb
         RzkwRV/SbBrt4yi/tneuQv8I/yIdE2hrKR6E7rcBsaeeEhkgv1nTe+HbUwvlsG9e0B28
         lvoDeqrbvisVysliJAl3fTSoBW0biQccB6cOPiC+uYzwhj1wY/9sasLUDJTKcDrBaD6R
         1ilw==
X-Gm-Message-State: AOAM532go4uq0Ag0SuokL6deWlqH/lZQmHvAN+8fYX3Cqe7o9osRoNAV
        RfpncYTqOZA2uEiErgAZpGHdSIUMkcxvTw==
X-Google-Smtp-Source: ABdhPJxDsCiFlcccVVUlVIMz9Z8lTmL2kVVlADYDenAoPU8toxDtwdxzxyNsz23M83mZOMb6fjCOkw==
X-Received: by 2002:a7b:c5cc:: with SMTP id n12mr8088744wmk.69.1590054017620;
        Thu, 21 May 2020 02:40:17 -0700 (PDT)
Received: from [192.168.43.18] ([85.255.237.70])
        by smtp.gmail.com with ESMTPSA id 32sm5968714wrg.19.2020.05.21.02.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 02:40:17 -0700 (PDT)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 04/10] staging: vt6656: use ieee80211_tx_info to replace
 need_mic
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
Message-ID: <e8969f47-ffc7-6eb6-9f3c-72b06970c1b8@gmail.com>
Date:   Thu, 21 May 2020 10:40:16 +0100
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

Use the info->control.hw_key to replace need mic which is only
present when info->control.hw_key->cipher == WLAN_CIPHER_SUITE_CCMP.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/rxtx.c | 39 +++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 87fe7df07f03..ea5bcc772668 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -296,8 +296,9 @@ static void vnt_fill_cts_head(struct vnt_usb_send_context *tx_context,
 }
 
 static void vnt_rxtx_rts(struct vnt_usb_send_context *tx_context,
-			 union vnt_tx_head *tx_head, bool need_mic)
+			 union vnt_tx_head *tx_head)
 {
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_context->skb);
 	struct vnt_rrv_time_rts *buf = &tx_head->tx_rts.rts;
 	union vnt_tx_data_head *head = &tx_head->tx_rts.tx.head;
 
@@ -308,15 +309,18 @@ static void vnt_rxtx_rts(struct vnt_usb_send_context *tx_context,
 	buf->rrv_time_a = vnt_rxtx_rsvtime_le16(tx_context);
 	buf->rrv_time_b = buf->rrv_time_a;
 
-	if (need_mic)
-		head = &tx_head->tx_rts.tx.mic.head;
+	if (info->control.hw_key) {
+		if (info->control.hw_key->cipher == WLAN_CIPHER_SUITE_CCMP)
+			head = &tx_head->tx_rts.tx.mic.head;
+	}
 
 	vnt_rxtx_rts_g_head(tx_context, &head->rts_g);
 }
 
 static void vnt_rxtx_cts(struct vnt_usb_send_context *tx_context,
-			 union vnt_tx_head *tx_head, bool need_mic)
+			 union vnt_tx_head *tx_head)
 {
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_context->skb);
 	struct vnt_rrv_time_cts *buf = &tx_head->tx_cts.cts;
 	union vnt_tx_data_head *head = &tx_head->tx_cts.tx.head;
 
@@ -325,23 +329,28 @@ static void vnt_rxtx_cts(struct vnt_usb_send_context *tx_context,
 
 	buf->cts_rrv_time_ba = vnt_get_cts_duration(tx_context);
 
-	if (need_mic)
-		head = &tx_head->tx_cts.tx.mic.head;
+	if (info->control.hw_key) {
+		if (info->control.hw_key->cipher == WLAN_CIPHER_SUITE_CCMP)
+			head = &tx_head->tx_cts.tx.mic.head;
+	}
 
 	vnt_fill_cts_head(tx_context, head);
 }
 
 static void vnt_rxtx_ab(struct vnt_usb_send_context *tx_context,
 			union vnt_tx_head *tx_head,
-			bool need_rts, bool need_mic)
+			bool need_rts)
 {
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_context->skb);
 	struct vnt_rrv_time_ab *buf = &tx_head->tx_ab.ab;
 	union vnt_tx_data_head *head = &tx_head->tx_ab.tx.head;
 
 	buf->rrv_time = vnt_rxtx_rsvtime_le16(tx_context);
 
-	if (need_mic)
-		head = &tx_head->tx_ab.tx.mic.head;
+	if (info->control.hw_key) {
+		if (info->control.hw_key->cipher == WLAN_CIPHER_SUITE_CCMP)
+			head = &tx_head->tx_ab.tx.mic.head;
+	}
 
 	if (need_rts) {
 		buf->rts_rrv_time = vnt_get_rts_duration(tx_context);
@@ -356,22 +365,22 @@ static void vnt_rxtx_ab(struct vnt_usb_send_context *tx_context,
 
 static void vnt_generate_tx_parameter(struct vnt_usb_send_context *tx_context,
 				      struct vnt_tx_buffer *tx_buffer,
-				      u32 need_mic, bool need_rts)
+				      bool need_rts)
 {
 	if (tx_context->pkt_type == PK_TYPE_11GB ||
 	    tx_context->pkt_type == PK_TYPE_11GA) {
 		if (need_rts) {
-			vnt_rxtx_rts(tx_context, &tx_buffer->tx_head, need_mic);
+			vnt_rxtx_rts(tx_context, &tx_buffer->tx_head);
 
 			return;
 		}
 
-		vnt_rxtx_cts(tx_context, &tx_buffer->tx_head, need_mic);
+		vnt_rxtx_cts(tx_context, &tx_buffer->tx_head);
 
 		return;
 	}
 
-	vnt_rxtx_ab(tx_context, &tx_buffer->tx_head, need_rts, need_mic);
+	vnt_rxtx_ab(tx_context, &tx_buffer->tx_head, need_rts);
 }
 
 static void vnt_fill_txkey(struct vnt_tx_buffer *tx_buffer,
@@ -499,7 +508,6 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	u16 tx_bytes, tx_header_size, tx_body_size;
 	u8 pkt_type;
 	bool need_rts = false;
-	bool need_mic = false;
 
 	hdr = (struct ieee80211_hdr *)(skb->data);
 
@@ -609,7 +617,6 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 			break;
 		case WLAN_CIPHER_SUITE_CCMP:
 			tx_buffer_head->frag_ctl |= cpu_to_le16(FRAGCTL_AES);
-			need_mic = true;
 		default:
 			break;
 		}
@@ -618,7 +625,7 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 
 	tx_buffer_head->current_rate = cpu_to_le16(rate->hw_value);
 
-	vnt_generate_tx_parameter(tx_context, tx_buffer, need_mic, need_rts);
+	vnt_generate_tx_parameter(tx_context, tx_buffer, need_rts);
 
 	tx_buffer_head->frag_ctl |= cpu_to_le16(FRAGCTL_NONFRAG);
 
-- 
2.25.1



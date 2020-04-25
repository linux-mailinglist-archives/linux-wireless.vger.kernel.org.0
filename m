Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CDF1B85C5
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 12:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgDYKvE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 06:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgDYKvE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 06:51:04 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C2EC09B04A
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2020 03:51:03 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x25so13978876wmc.0
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2020 03:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=stRnWXDCszDJvrCi5ZihLzitGbW/KY/EVPkUasxJvN8=;
        b=L18vPNW8FLMNvLDI421g8ARlIXspmPuR0Pp7OyIXhAPqsyhWtT8NeqmRzpnb0FEqKM
         JQUyFJGdkuq1LMvn9CHtcd3DwcuZDfHwTZFYPNJgeCs+VMvAqXmAL4MVGMnGb+ZTOusD
         JWoNwOmO75lf32BXYQV/FuHWO6w/VTnK8GE+Rog6lp6QusS2lNWGlxRmMLyiGp5KTwu7
         SCocaQSp5ZZk+GYPCkU3QLMcSsJCw5PA5apOQUnsQvpmNof5ecjCiL/AG+4lCXrcW34z
         T/hDsNRA7i5wnZBoZf0y8sYqJFz94YZgkyU+2CmfGtOtBUv+ztLg4FD9lsU6+wSoJVWA
         UWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=stRnWXDCszDJvrCi5ZihLzitGbW/KY/EVPkUasxJvN8=;
        b=LGhMcFWt0oJIfu02XIw9vRZ/gcaluRIFwxWaIWAwvIbghdQojOaPv/kFM0DqNkIw2s
         RhrdQkgElKlYDZsqgyIhh84DHV8uMIHesr5TmibIzMs/SNN/qMboPFSZKEjOwih2c7cz
         OtyQAv+eiRh/8/Sl0ClIKEzBm4YTFEIAnFiK8qVpCx7IMFoJqGSPOqpGSg/NAZJwy06S
         4uyzEYW8a9ncAgVjT8d8VyywDReIMFvggc9Ou8dLRa9Hi0q+u+XXR3Plvg+uV3YpvFs2
         5Lj8riFW0OtSII7CKQe0kYipXNB8LuFMG4S1a/p7nPjdfDxcp5foIdT7REk4pBSBOrAq
         Ycpg==
X-Gm-Message-State: AGi0PuZa5GkhVPHJG/V5HACZ2zLzUtTzCL05k0odwy5x8b7TEJ1tJTEY
        SJ6jXXlAVml2XPKRRcoGmY6DrfA/
X-Google-Smtp-Source: APiQypIiiNvR3UZJ3CPueJ/m2s0GXhzX6X+z/wzD5VdyAAA6TO+IbEacu0/siy8ZxMyUqL/6OXQXAw==
X-Received: by 2002:a1c:5448:: with SMTP id p8mr15089107wmi.173.1587811862635;
        Sat, 25 Apr 2020 03:51:02 -0700 (PDT)
Received: from [192.168.43.18] (94.197.120.138.threembb.co.uk. [94.197.120.138])
        by smtp.gmail.com with ESMTPSA id e13sm2817721wrp.15.2020.04.25.03.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 03:51:02 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH v2] staging: vt6656: rxtx: remove duration_id and void
 returns.
Message-ID: <04a9c19f-c374-c175-6e46-d1bfbab2f42e@gmail.com>
Date:   Sat, 25 Apr 2020 11:50:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

duration_id is not used by driver anymore so remove the returns
and set all functions in patch to void.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
v1 had missing returns in vnt_generate_tx_parameter and vnt_rxtx_ab

 drivers/staging/vt6656/rxtx.c | 84 +++++++++++++++++------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 335ef4fd104f..a4235652cbff 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -327,8 +327,8 @@ static u16 vnt_mac_hdr_pos(struct vnt_usb_send_context *tx_context,
 	return (u16)(hdr_pos - head);
 }
 
-static u16 vnt_rxtx_datahead_g(struct vnt_usb_send_context *tx_context,
-			       struct vnt_tx_datahead_g *buf)
+static void vnt_rxtx_datahead_g(struct vnt_usb_send_context *tx_context,
+				struct vnt_tx_datahead_g *buf)
 {
 	struct vnt_private *priv = tx_context->priv;
 	struct ieee80211_hdr *hdr =
@@ -349,12 +349,10 @@ static u16 vnt_rxtx_datahead_g(struct vnt_usb_send_context *tx_context,
 						   priv->top_cck_basic_rate);
 
 	tx_context->tx_hdr_size = vnt_mac_hdr_pos(tx_context, &buf->hdr);
-
-	return le16_to_cpu(buf->duration_a);
 }
 
-static u16 vnt_rxtx_datahead_ab(struct vnt_usb_send_context *tx_context,
-				struct vnt_tx_datahead_ab *buf)
+static void vnt_rxtx_datahead_ab(struct vnt_usb_send_context *tx_context,
+				 struct vnt_tx_datahead_ab *buf)
 {
 	struct vnt_private *priv = tx_context->priv;
 	struct ieee80211_hdr *hdr =
@@ -371,12 +369,10 @@ static u16 vnt_rxtx_datahead_ab(struct vnt_usb_send_context *tx_context,
 	buf->time_stamp_off = vnt_time_stamp_off(priv, rate);
 
 	tx_context->tx_hdr_size = vnt_mac_hdr_pos(tx_context, &buf->hdr);
-
-	return le16_to_cpu(buf->duration);
 }
 
-static int vnt_fill_ieee80211_rts(struct vnt_usb_send_context *tx_context,
-				  struct ieee80211_rts *rts, __le16 duration)
+static void vnt_fill_ieee80211_rts(struct vnt_usb_send_context *tx_context,
+				   struct ieee80211_rts *rts, __le16 duration)
 {
 	struct ieee80211_hdr *hdr =
 				(struct ieee80211_hdr *)tx_context->skb->data;
@@ -387,12 +383,10 @@ static int vnt_fill_ieee80211_rts(struct vnt_usb_send_context *tx_context,
 
 	ether_addr_copy(rts->ra, hdr->addr1);
 	ether_addr_copy(rts->ta, hdr->addr2);
-
-	return 0;
 }
 
-static u16 vnt_rxtx_rts_g_head(struct vnt_usb_send_context *tx_context,
-			       struct vnt_rts_g *buf)
+static void vnt_rxtx_rts_g_head(struct vnt_usb_send_context *tx_context,
+				struct vnt_rts_g *buf)
 {
 	struct vnt_private *priv = tx_context->priv;
 	u16 rts_frame_len = 20;
@@ -415,11 +409,11 @@ static u16 vnt_rxtx_rts_g_head(struct vnt_usb_send_context *tx_context,
 
 	vnt_fill_ieee80211_rts(tx_context, &buf->data, buf->duration_aa);
 
-	return vnt_rxtx_datahead_g(tx_context, &buf->data_head);
+	vnt_rxtx_datahead_g(tx_context, &buf->data_head);
 }
 
-static u16 vnt_rxtx_rts_ab_head(struct vnt_usb_send_context *tx_context,
-				struct vnt_rts_ab *buf)
+static void vnt_rxtx_rts_ab_head(struct vnt_usb_send_context *tx_context,
+				 struct vnt_rts_ab *buf)
 {
 	struct vnt_private *priv = tx_context->priv;
 	u16 current_rate = tx_context->tx_rate;
@@ -434,11 +428,11 @@ static u16 vnt_rxtx_rts_ab_head(struct vnt_usb_send_context *tx_context,
 
 	vnt_fill_ieee80211_rts(tx_context, &buf->data, buf->duration);
 
-	return vnt_rxtx_datahead_ab(tx_context, &buf->data_head);
+	vnt_rxtx_datahead_ab(tx_context, &buf->data_head);
 }
 
-static u16 vnt_fill_cts_head(struct vnt_usb_send_context *tx_context,
-			     union vnt_tx_data_head *head)
+static void vnt_fill_cts_head(struct vnt_usb_send_context *tx_context,
+			      union vnt_tx_data_head *head)
 {
 	struct vnt_private *priv = tx_context->priv;
 	struct vnt_cts *buf = &head->cts_g;
@@ -460,11 +454,11 @@ static u16 vnt_fill_cts_head(struct vnt_usb_send_context *tx_context,
 
 	ether_addr_copy(buf->data.ra, priv->current_net_addr);
 
-	return vnt_rxtx_datahead_g(tx_context, &buf->data_head);
+	vnt_rxtx_datahead_g(tx_context, &buf->data_head);
 }
 
-static u16 vnt_rxtx_rts(struct vnt_usb_send_context *tx_context,
-			union vnt_tx_head *tx_head, bool need_mic)
+static void vnt_rxtx_rts(struct vnt_usb_send_context *tx_context,
+			 union vnt_tx_head *tx_head, bool need_mic)
 {
 	struct vnt_private *priv = tx_context->priv;
 	struct vnt_rrv_time_rts *buf = &tx_head->tx_rts.rts;
@@ -489,11 +483,11 @@ static u16 vnt_rxtx_rts(struct vnt_usb_send_context *tx_context,
 	if (need_mic)
 		head = &tx_head->tx_rts.tx.mic.head;
 
-	return vnt_rxtx_rts_g_head(tx_context, &head->rts_g);
+	vnt_rxtx_rts_g_head(tx_context, &head->rts_g);
 }
 
-static u16 vnt_rxtx_cts(struct vnt_usb_send_context *tx_context,
-			union vnt_tx_head *tx_head, bool need_mic)
+static void vnt_rxtx_cts(struct vnt_usb_send_context *tx_context,
+			 union vnt_tx_head *tx_head, bool need_mic)
 {
 	struct vnt_private *priv = tx_context->priv;
 	struct vnt_rrv_time_cts *buf = &tx_head->tx_cts.cts;
@@ -513,11 +507,12 @@ static u16 vnt_rxtx_cts(struct vnt_usb_send_context *tx_context,
 	if (need_mic)
 		head = &tx_head->tx_cts.tx.mic.head;
 
-	return vnt_fill_cts_head(tx_context, head);
+	vnt_fill_cts_head(tx_context, head);
 }
 
-static u16 vnt_rxtx_ab(struct vnt_usb_send_context *tx_context,
-		       union vnt_tx_head *tx_head, bool need_rts, bool need_mic)
+static void vnt_rxtx_ab(struct vnt_usb_send_context *tx_context,
+			union vnt_tx_head *tx_head,
+			bool need_rts, bool need_mic)
 {
 	struct vnt_private *priv = tx_context->priv;
 	struct vnt_rrv_time_ab *buf = &tx_head->tx_ab.ab;
@@ -540,16 +535,18 @@ static u16 vnt_rxtx_ab(struct vnt_usb_send_context *tx_context,
 			buf->rts_rrv_time = vnt_get_rtscts_rsvtime_le(priv, 2,
 				tx_context->pkt_type, frame_len, current_rate);
 
-		return vnt_rxtx_rts_ab_head(tx_context, &head->rts_ab);
+		vnt_rxtx_rts_ab_head(tx_context, &head->rts_ab);
+
+		return;
 	}
 
-	return vnt_rxtx_datahead_ab(tx_context, &head->data_head_ab);
+	vnt_rxtx_datahead_ab(tx_context, &head->data_head_ab);
 }
 
-static u16 vnt_generate_tx_parameter(struct vnt_usb_send_context *tx_context,
-				     struct vnt_tx_buffer *tx_buffer,
-				     struct vnt_mic_hdr **mic_hdr, u32 need_mic,
-				     bool need_rts)
+static void vnt_generate_tx_parameter(struct vnt_usb_send_context *tx_context,
+				      struct vnt_tx_buffer *tx_buffer,
+				      struct vnt_mic_hdr **mic_hdr,
+				      u32 need_mic, bool need_rts)
 {
 	if (tx_context->pkt_type == PK_TYPE_11GB ||
 	    tx_context->pkt_type == PK_TYPE_11GA) {
@@ -558,20 +555,23 @@ static u16 vnt_generate_tx_parameter(struct vnt_usb_send_context *tx_context,
 				*mic_hdr =
 					&tx_buffer->tx_head.tx_rts.tx.mic.hdr;
 
-			return vnt_rxtx_rts(tx_context, &tx_buffer->tx_head,
-					    need_mic);
+			vnt_rxtx_rts(tx_context, &tx_buffer->tx_head, need_mic);
+
+			return;
 		}
 
 		if (need_mic)
 			*mic_hdr = &tx_buffer->tx_head.tx_cts.tx.mic.hdr;
 
-		return vnt_rxtx_cts(tx_context, &tx_buffer->tx_head, need_mic);
+		vnt_rxtx_cts(tx_context, &tx_buffer->tx_head, need_mic);
+
+		return;
 	}
 
 	if (need_mic)
 		*mic_hdr = &tx_buffer->tx_head.tx_ab.tx.mic.hdr;
 
-	return vnt_rxtx_ab(tx_context, &tx_buffer->tx_head, need_rts, need_mic);
+	vnt_rxtx_ab(tx_context, &tx_buffer->tx_head, need_rts, need_mic);
 }
 
 static void vnt_fill_txkey(struct vnt_usb_send_context *tx_context,
@@ -658,7 +658,7 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	struct vnt_tx_fifo_head *tx_buffer_head;
 	struct vnt_usb_send_context *tx_context;
 	unsigned long flags;
-	u16 tx_bytes, tx_header_size, tx_body_size, duration_id;
+	u16 tx_bytes, tx_header_size, tx_body_size;
 	u8 pkt_type;
 	bool need_rts = false;
 	bool need_mic = false;
@@ -772,8 +772,8 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 
 	tx_buffer_head->current_rate = cpu_to_le16(rate->hw_value);
 
-	duration_id = vnt_generate_tx_parameter(tx_context, tx_buffer, &mic_hdr,
-						need_mic, need_rts);
+	vnt_generate_tx_parameter(tx_context, tx_buffer, &mic_hdr,
+				  need_mic, need_rts);
 
 	tx_header_size = tx_context->tx_hdr_size;
 	if (!tx_header_size) {
-- 
2.25.1

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710431DCA80
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 11:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgEUJyd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 05:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgEUJyd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 05:54:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA630C061A0E
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:54:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k13so6073008wrx.3
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5QeQ4he9h0xADmEWbOoDulC21CWqkbyqDnHh7T76EKo=;
        b=Kn+GS2GjsgZeE2Xk4ryfb00h4EBKZ6zR3fWSmjAj2dKsffKYVYYVodj8scDKH6R93A
         xGlOgDWRA4J1wE67EOu5Z+GJWQ3X+LHV1NNnYzxPJXzw5ilY22mQSmtIqRPeKrAggOQp
         rtwFtVg04mBGs4byajNCIvU9jMkSC/xYzix9fJLP2V8mZN/xjsyUaxD8epfAmtMHCxW7
         6LynC3jF6qdxnQ/ORlNNuTAr/lcvC3rLbwCJ33oLaLF/SB41KLmjuFTTZ/ySjEZ9zzmr
         8PRb3vtHRzfFqzEnV7Ly2Mx5bQ6wkrbRfoL6Ccffz0tpqrokUhXRawyLFuSy53fzIFrj
         440w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5QeQ4he9h0xADmEWbOoDulC21CWqkbyqDnHh7T76EKo=;
        b=m/agEI1vEQUtFmShtnupTKwL25PEm989LfrycnQwov/Llns8w5ybUytTWmZsWFPviz
         8wiBkBbJmlAji3wQ0UTCss1avywUpeJCqo4BcW3qzsVa6g3LXjW+JuqlQT1QYvZGBhbx
         xiTLSn0e9TkYCo+t+QXEZ+6vfZX+nBYyHeFSuXy61gZDKdyzU5cLmLZcPDU7liQlG03v
         l9O8ZPgjD5T7IrPZAXPZuvhQ4Zqjr+h6CKksex7p3Fgx8oBIDmx2bQ+uzZ7x0V4bsxDv
         nAakJCCHPTWbM9M3jfN6d2GSoDZCqOzlxUtFl+SAAIiobK9dJw4eowENZFDzetx+AJ6D
         4a+g==
X-Gm-Message-State: AOAM5339v5Im2sqlAVYAJ1aLGxSGhd+7VBlQIJKJ6h+aulZhJkpuAoNw
        fKtnAsNXbogCLSt3SkqTILdJGWg3SFAvAA==
X-Google-Smtp-Source: ABdhPJz7KRZBSjlGdNM0DfJ2R+MxsYaiwL3K8y61pbBHazmB9QdsMbNr2NehwxvRG4r+rKu0urDL/Q==
X-Received: by 2002:adf:e441:: with SMTP id t1mr7664441wrm.347.1590054870889;
        Thu, 21 May 2020 02:54:30 -0700 (PDT)
Received: from [192.168.43.18] ([85.255.237.70])
        by smtp.gmail.com with ESMTPSA id b12sm6295375wmj.0.2020.05.21.02.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 02:54:30 -0700 (PDT)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 09/10] staging: vt6656: Move calling point of vnt_fill_txkey.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
Message-ID: <f08a6f07-a77e-0b8e-cb05-505a1f995683@gmail.com>
Date:   Thu, 21 May 2020 10:54:29 +0100
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

Change vnt_fill_txkey to return true if mic_hdr is needed and
change calling point at where it is to be placed.

tx_buffer is already in tx_context.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/rxtx.c | 191 +++++++++++++++++-----------------
 1 file changed, 95 insertions(+), 96 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index a0672ca51138..bbe449af8acf 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -295,94 +295,8 @@ static void vnt_fill_cts_head(struct vnt_usb_send_context *tx_context,
 	vnt_rxtx_datahead_g(tx_context, &buf->data_head);
 }
 
-static void vnt_rxtx_rts(struct vnt_usb_send_context *tx_context,
-			 union vnt_tx_head *tx_head)
-{
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_context->skb);
-	struct vnt_rrv_time_rts *buf = &tx_head->tx_rts.rts;
-	union vnt_tx_data_head *head = &tx_head->tx_rts.tx.head;
-
-	buf->rts_rrv_time_aa = vnt_get_rts_duration(tx_context);
-	buf->rts_rrv_time_ba = buf->rts_rrv_time_aa;
-	buf->rts_rrv_time_bb = buf->rts_rrv_time_aa;
-
-	buf->rrv_time_a = vnt_rxtx_rsvtime_le16(tx_context);
-	buf->rrv_time_b = buf->rrv_time_a;
-
-	if (info->control.hw_key) {
-		if (info->control.hw_key->cipher == WLAN_CIPHER_SUITE_CCMP)
-			head = &tx_head->tx_rts.tx.mic.head;
-	}
-
-	vnt_rxtx_rts_g_head(tx_context, &head->rts_g);
-}
-
-static void vnt_rxtx_cts(struct vnt_usb_send_context *tx_context,
-			 union vnt_tx_head *tx_head)
-{
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_context->skb);
-	struct vnt_rrv_time_cts *buf = &tx_head->tx_cts.cts;
-	union vnt_tx_data_head *head = &tx_head->tx_cts.tx.head;
-
-	buf->rrv_time_a = vnt_rxtx_rsvtime_le16(tx_context);
-	buf->rrv_time_b = buf->rrv_time_a;
-
-	buf->cts_rrv_time_ba = vnt_get_cts_duration(tx_context);
-
-	if (info->control.hw_key) {
-		if (info->control.hw_key->cipher == WLAN_CIPHER_SUITE_CCMP)
-			head = &tx_head->tx_cts.tx.mic.head;
-	}
-
-	vnt_fill_cts_head(tx_context, head);
-}
-
-static void vnt_rxtx_ab(struct vnt_usb_send_context *tx_context,
-			union vnt_tx_head *tx_head)
-{
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_context->skb);
-	struct vnt_rrv_time_ab *buf = &tx_head->tx_ab.ab;
-	union vnt_tx_data_head *head = &tx_head->tx_ab.tx.head;
-
-	buf->rrv_time = vnt_rxtx_rsvtime_le16(tx_context);
-
-	if (info->control.hw_key) {
-		if (info->control.hw_key->cipher == WLAN_CIPHER_SUITE_CCMP)
-			head = &tx_head->tx_ab.tx.mic.head;
-	}
-
-	if (info->control.use_rts) {
-		buf->rts_rrv_time = vnt_get_rts_duration(tx_context);
-
-		vnt_rxtx_rts_ab_head(tx_context, &head->rts_ab);
-
-		return;
-	}
-
-	vnt_rxtx_datahead_ab(tx_context, &head->data_head_ab);
-}
-
-static void vnt_generate_tx_parameter(struct vnt_usb_send_context *tx_context,
-				      struct vnt_tx_buffer *tx_buffer)
-{
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_context->skb);
-
-	if (info->control.use_cts_prot) {
-		if (info->control.use_rts) {
-			vnt_rxtx_rts(tx_context, &tx_buffer->tx_head);
-
-			return;
-		}
-
-		vnt_rxtx_cts(tx_context, &tx_buffer->tx_head);
-
-		return;
-	}
-
-	vnt_rxtx_ab(tx_context, &tx_buffer->tx_head);
-}
-
-static void vnt_fill_txkey(struct vnt_tx_buffer *tx_buffer, struct sk_buff *skb)
+/* returns true if mic_hdr is needed */
+static bool vnt_fill_txkey(struct vnt_tx_buffer *tx_buffer, struct sk_buff *skb)
 {
 	struct vnt_tx_fifo_head *fifo = &tx_buffer->fifo_head;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
@@ -455,10 +369,101 @@ static void vnt_fill_txkey(struct vnt_tx_buffer *tx_buffer, struct sk_buff *skb)
 
 		memcpy(fifo->tx_key, tx_key->key, WLAN_KEY_LEN_CCMP);
 
-		break;
+		return true;
 	default:
 		break;
 	}
+
+	return false;
+}
+
+static void vnt_rxtx_rts(struct vnt_usb_send_context *tx_context)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_context->skb);
+	struct vnt_tx_buffer *tx_buffer = tx_context->tx_buffer;
+	union vnt_tx_head *tx_head = &tx_buffer->tx_head;
+	struct vnt_rrv_time_rts *buf = &tx_head->tx_rts.rts;
+	union vnt_tx_data_head *head = &tx_head->tx_rts.tx.head;
+
+	buf->rts_rrv_time_aa = vnt_get_rts_duration(tx_context);
+	buf->rts_rrv_time_ba = buf->rts_rrv_time_aa;
+	buf->rts_rrv_time_bb = buf->rts_rrv_time_aa;
+
+	buf->rrv_time_a = vnt_rxtx_rsvtime_le16(tx_context);
+	buf->rrv_time_b = buf->rrv_time_a;
+
+	if (info->control.hw_key) {
+		if (vnt_fill_txkey(tx_buffer, tx_context->skb))
+			head = &tx_head->tx_rts.tx.mic.head;
+	}
+
+	vnt_rxtx_rts_g_head(tx_context, &head->rts_g);
+}
+
+static void vnt_rxtx_cts(struct vnt_usb_send_context *tx_context)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_context->skb);
+	struct vnt_tx_buffer *tx_buffer = tx_context->tx_buffer;
+	union vnt_tx_head *tx_head = &tx_buffer->tx_head;
+	struct vnt_rrv_time_cts *buf = &tx_head->tx_cts.cts;
+	union vnt_tx_data_head *head = &tx_head->tx_cts.tx.head;
+
+	buf->rrv_time_a = vnt_rxtx_rsvtime_le16(tx_context);
+	buf->rrv_time_b = buf->rrv_time_a;
+
+	buf->cts_rrv_time_ba = vnt_get_cts_duration(tx_context);
+
+	if (info->control.hw_key) {
+		if (vnt_fill_txkey(tx_buffer, tx_context->skb))
+			head = &tx_head->tx_cts.tx.mic.head;
+	}
+
+	vnt_fill_cts_head(tx_context, head);
+}
+
+static void vnt_rxtx_ab(struct vnt_usb_send_context *tx_context)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_context->skb);
+	struct vnt_tx_buffer *tx_buffer = tx_context->tx_buffer;
+	union vnt_tx_head *tx_head = &tx_buffer->tx_head;
+	struct vnt_rrv_time_ab *buf = &tx_head->tx_ab.ab;
+	union vnt_tx_data_head *head = &tx_head->tx_ab.tx.head;
+
+	buf->rrv_time = vnt_rxtx_rsvtime_le16(tx_context);
+
+	if (info->control.hw_key) {
+		if (vnt_fill_txkey(tx_buffer, tx_context->skb))
+			head = &tx_head->tx_ab.tx.mic.head;
+	}
+
+	if (info->control.use_rts) {
+		buf->rts_rrv_time = vnt_get_rts_duration(tx_context);
+
+		vnt_rxtx_rts_ab_head(tx_context, &head->rts_ab);
+
+		return;
+	}
+
+	vnt_rxtx_datahead_ab(tx_context, &head->data_head_ab);
+}
+
+static void vnt_generate_tx_parameter(struct vnt_usb_send_context *tx_context)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_context->skb);
+
+	if (info->control.use_cts_prot) {
+		if (info->control.use_rts) {
+			vnt_rxtx_rts(tx_context);
+
+			return;
+		}
+
+		vnt_rxtx_cts(tx_context);
+
+		return;
+	}
+
+	vnt_rxtx_ab(tx_context);
 }
 
 static u16 vnt_get_hdr_size(struct ieee80211_tx_info *info)
@@ -621,16 +626,10 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 
 	tx_buffer_head->current_rate = cpu_to_le16(rate->hw_value);
 
-	vnt_generate_tx_parameter(tx_context, tx_buffer);
+	vnt_generate_tx_parameter(tx_context);
 
 	tx_buffer_head->frag_ctl |= cpu_to_le16(FRAGCTL_NONFRAG);
 
-	if (info->control.hw_key) {
-		tx_key = info->control.hw_key;
-		if (tx_key->keylen > 0)
-			vnt_fill_txkey(tx_buffer, skb);
-	}
-
 	priv->seq_counter = (le16_to_cpu(hdr->seq_ctrl) &
 						IEEE80211_SCTL_SEQ) >> 4;
 
-- 
2.25.1



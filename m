Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93C31DCA55
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 11:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgEUJmS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 05:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbgEUJmR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 05:42:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B78C061A0E
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:42:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w7so5957698wre.13
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=usJtu7R5Hhl5Z8TUzvQCBPkQWGFxbJL90BBgLqwpdIk=;
        b=ooEt1Hk7utn7Qm4uNttmPvtDsV3s7zI0OmcwuzGJBvDeYSRB9dT2mm/kg7q1C8sbCn
         XdPMeE7Ks+Qvca3wIB7N+Cr4amqY5EK9TxhtsbIy2jJQcx7InuD/zM9HDt4MGfmW87MA
         MXJg61qH4iLC5nP9vZ6x02/GNWY6CVCghjNgzN/bXsBO7sUtnJtUtMHeXp+95WDuLfCJ
         9UryTqHZnJmpeISL1ZTbPv5UyiKVVl2F7a0uIy4rrEmVqKVhpMRSE7V+fLvfWZk/5mXx
         zh8jmBE8u4ReQsDE3K81oMj3Exmp9AbaeyCHdTSeuj+TQZ9w2xCjv5PPEFcyW+bpoXTT
         5SZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=usJtu7R5Hhl5Z8TUzvQCBPkQWGFxbJL90BBgLqwpdIk=;
        b=KIU7+zM4gWvpsaP/BJmPlaLdKXd3f8scHeFqIa7ff4pvuQEQkaSniHIU5YCDxjdUCy
         uy3UlhJo4lDPkUvX0gVOL2l+NEoHpEmNIEJ0PH2/yORDpj56PPsnvoh5ELkNTTuQDeiW
         sC14XO7F1CLmeKJ3SnOw3QtVAa7KlxJXuu1/T30a/+Uy6kJ+m3Hrl28wXojflDVFJcvn
         pT72HV79GNfdMbiY/U9rRomWxWSia79+y19DXwwuNMfy141KQjK9sOC1CdGdhNNZEVZU
         3E7OOK9DNymYGAWAwUibT62I5cFYdQ2cxhwyDMk7AdAOHRx40P2VFqOfFQKT6nQXfHq5
         pErg==
X-Gm-Message-State: AOAM53180L2XVKG4Yti8NKTDejEvaxb5yYX7d8k2U5lyB0uMFY4ObL+P
        bDeawvW2g6oJI7JwRod42X51yqNa95NMFw==
X-Google-Smtp-Source: ABdhPJxiLG5qiRNjsAXF07VxPFnfbRskoYUxrb0zVqUB/bv0v8atJjlSVybhquwsWliQKebfQHFrYA==
X-Received: by 2002:adf:fdc5:: with SMTP id i5mr7517714wrs.176.1590054135855;
        Thu, 21 May 2020 02:42:15 -0700 (PDT)
Received: from [192.168.43.18] ([85.255.237.70])
        by smtp.gmail.com with ESMTPSA id u65sm5937594wmg.8.2020.05.21.02.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 02:42:15 -0700 (PDT)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 05/10] staging: vt6656: rxtx use ieee80211_tx_info for rts/cts
 control
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
Message-ID: <1b21b3db-b9ef-c167-8f88-b32646ba5a19@gmail.com>
Date:   Thu, 21 May 2020 10:42:14 +0100
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

Use the control for rts/cts exhanges replacing need_rts and use_cts_prot for
packet type PK_TYPE_11GB / PK_TYPE_11GA

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/rxtx.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index ea5bcc772668..310d0eccebd1 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -338,8 +338,7 @@ static void vnt_rxtx_cts(struct vnt_usb_send_context *tx_context,
 }
 
 static void vnt_rxtx_ab(struct vnt_usb_send_context *tx_context,
-			union vnt_tx_head *tx_head,
-			bool need_rts)
+			union vnt_tx_head *tx_head)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_context->skb);
 	struct vnt_rrv_time_ab *buf = &tx_head->tx_ab.ab;
@@ -352,7 +351,7 @@ static void vnt_rxtx_ab(struct vnt_usb_send_context *tx_context,
 			head = &tx_head->tx_ab.tx.mic.head;
 	}
 
-	if (need_rts) {
+	if (info->control.use_rts) {
 		buf->rts_rrv_time = vnt_get_rts_duration(tx_context);
 
 		vnt_rxtx_rts_ab_head(tx_context, &head->rts_ab);
@@ -364,12 +363,12 @@ static void vnt_rxtx_ab(struct vnt_usb_send_context *tx_context,
 }
 
 static void vnt_generate_tx_parameter(struct vnt_usb_send_context *tx_context,
-				      struct vnt_tx_buffer *tx_buffer,
-				      bool need_rts)
+				      struct vnt_tx_buffer *tx_buffer)
 {
-	if (tx_context->pkt_type == PK_TYPE_11GB ||
-	    tx_context->pkt_type == PK_TYPE_11GA) {
-		if (need_rts) {
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_context->skb);
+
+	if (info->control.use_cts_prot) {
+		if (info->control.use_rts) {
 			vnt_rxtx_rts(tx_context, &tx_buffer->tx_head);
 
 			return;
@@ -380,7 +379,7 @@ static void vnt_generate_tx_parameter(struct vnt_usb_send_context *tx_context,
 		return;
 	}
 
-	vnt_rxtx_ab(tx_context, &tx_buffer->tx_head, need_rts);
+	vnt_rxtx_ab(tx_context, &tx_buffer->tx_head);
 }
 
 static void vnt_fill_txkey(struct vnt_tx_buffer *tx_buffer,
@@ -507,7 +506,6 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	unsigned long flags;
 	u16 tx_bytes, tx_header_size, tx_body_size;
 	u8 pkt_type;
-	bool need_rts = false;
 
 	hdr = (struct ieee80211_hdr *)(skb->data);
 
@@ -594,10 +592,8 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	if (ieee80211_has_retry(hdr->frame_control))
 		tx_buffer_head->fifo_ctl |= cpu_to_le16(FIFOCTL_LRETRY);
 
-	if (tx_rate->flags & IEEE80211_TX_RC_USE_RTS_CTS) {
-		need_rts = true;
+	if (info->control.use_rts)
 		tx_buffer_head->fifo_ctl |= cpu_to_le16(FIFOCTL_RTS);
-	}
 
 	if (ieee80211_has_a4(hdr->frame_control))
 		tx_buffer_head->fifo_ctl |= cpu_to_le16(FIFOCTL_LHEAD);
@@ -625,7 +621,7 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 
 	tx_buffer_head->current_rate = cpu_to_le16(rate->hw_value);
 
-	vnt_generate_tx_parameter(tx_context, tx_buffer, need_rts);
+	vnt_generate_tx_parameter(tx_context, tx_buffer);
 
 	tx_buffer_head->frag_ctl |= cpu_to_le16(FRAGCTL_NONFRAG);
 
-- 
2.25.1



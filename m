Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954091DCA66
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 11:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgEUJr3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 05:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbgEUJr2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 05:47:28 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837A3C061A0E
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:47:28 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l17so6039543wrr.4
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 02:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=JZE3YWU43/SedpISagSRSovxov9m1YwcPTRT1+qH7GU=;
        b=iNBmHpgu89/26tgoQV6hPE4K/0UELMRDzL8pg6EM8FAIUNdw6d4x/jyRbwG8Oskh82
         GFQjnT8YDShNZ4WXOy18TCUCXZrAN5B0kOKTuIRVR/H4RgK0fNLmE9RGNOEGFcTvWXL9
         w6okd3UEVfJMcVWPW7Vky2e/wV334MC+bW3xGk1eBNJX6bRwRJZRakuE7PsmVT+p7dV8
         AknwqVi/KDyEBgtXIf8/36n+qwSz1cy1E4Sa1V7mWI7x4Wcm7z4mya7Su96fIMN8VodA
         EQJbX9DQNEdEFrMaVvtY/isRnRhyqbvzEqFXBKXU8MIK7DavtpS5+Nt9XlSsNGPmu2Zu
         vWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=JZE3YWU43/SedpISagSRSovxov9m1YwcPTRT1+qH7GU=;
        b=Un6/7MIKE5qTk7g1edcSzBT47TNB9IjJU6Mu6IFS6+si3v/aEn0OaVZReEMCYI227J
         4PyR0HhTYCBSHRPwpytKdMPF3xKpz5YvLJqjD1v3vzyzOyiuGFhgF3ERVoBgD1K3Ccdf
         imFgMJtKnWnVMDsrwIEtHB3vqtKhBUoE9Ub38JuGbF0kiFmlgnMRDJtqCKUtncSmaB1w
         SU9UwGZ/LSDWnkNJzjjYo40abAjIVLcd8dE5S+roITYMnjVmqjhwxjyc9RSR/r/NMHQw
         TOaUA4CGPZ+4M4vvmGqo0eVZR7azpbVDAtJ4pqAuIuly/oFl8fUnXbh93xnfPX40domO
         sC0Q==
X-Gm-Message-State: AOAM533/TEWmAm53C9q1h+NA5Qji4a5VjFmaiY9tr65t26uzkrD697Y5
        8Kda8zi5AWU0ilHlSNmwetel7EGUpK/m6A==
X-Google-Smtp-Source: ABdhPJyOtqUOsV1YHo4zWUH3DUaCgWdkiqHwaIpR1V/PYqlzmbxvqfUgVV3p5V5nUslLkA06Ls+/Vw==
X-Received: by 2002:a05:6000:85:: with SMTP id m5mr7271879wrx.281.1590054447037;
        Thu, 21 May 2020 02:47:27 -0700 (PDT)
Received: from [192.168.43.18] ([85.255.237.70])
        by smtp.gmail.com with ESMTPSA id z9sm5851379wrp.66.2020.05.21.02.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 02:47:26 -0700 (PDT)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 07/10] staging: vt6656: move tx_body_size/payload_len to
 skb->len
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
Message-ID: <12e96cb5-a2a5-de3c-ebe7-ca5a4e2b5594@gmail.com>
Date:   Thu, 21 May 2020 10:47:25 +0100
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

both variables can be removed and replaced with skb->len.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/rxtx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 2d7a8fc70d92..b9164142e2b5 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -384,13 +384,14 @@ static void vnt_generate_tx_parameter(struct vnt_usb_send_context *tx_context,
 
 static void vnt_fill_txkey(struct vnt_tx_buffer *tx_buffer,
 			   struct ieee80211_key_conf *tx_key,
-			   struct sk_buff *skb, u16 payload_len)
+			   struct sk_buff *skb)
 {
 	struct vnt_tx_fifo_head *fifo = &tx_buffer->fifo_head;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct vnt_mic_hdr *mic_hdr;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	u64 pn64;
+	u16 payload_len = skb->len;
 	u8 *iv = ((u8 *)hdr + ieee80211_get_hdrlen_from_skb(skb));
 
 	/* strip header and icv len from payload */
@@ -505,7 +506,7 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	struct vnt_tx_fifo_head *tx_buffer_head;
 	struct vnt_usb_send_context *tx_context;
 	unsigned long flags;
-	u16 tx_bytes, tx_header_size, tx_body_size;
+	u16 tx_bytes, tx_header_size;
 	u8 pkt_type;
 
 	hdr = (struct ieee80211_hdr *)(skb->data);
@@ -546,8 +547,7 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	tx_header_size = vnt_get_hdr_size(info);
-	tx_body_size = skb->len;
-	tx_bytes = tx_header_size + tx_body_size;
+	tx_bytes = tx_header_size + skb->len;
 	tx_header_size += sizeof(struct vnt_tx_usb_header);
 
 	tx_buffer = skb_push(skb, tx_header_size);
@@ -629,7 +629,7 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	if (info->control.hw_key) {
 		tx_key = info->control.hw_key;
 		if (tx_key->keylen > 0)
-			vnt_fill_txkey(tx_buffer, tx_key, skb, tx_body_size);
+			vnt_fill_txkey(tx_buffer, tx_key, skb);
 	}
 
 	priv->seq_counter = (le16_to_cpu(hdr->seq_ctrl) &
-- 
2.25.1



Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB23E1E3C94
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 10:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388177AbgE0ItX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 04:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388150AbgE0ItW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 04:49:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5121C061A0F
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 01:49:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v19so2280368wmj.0
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 01:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=iuJaJSf0w8q+wcwKuU4TT506RpTyaAoUqC6QBZqFBjs=;
        b=KJEkFdabw29Nl7meOVf2kpE7hb/3cv9IfqGG0piPKwFRnMQgt2JLMH2GSkKqXgwUkV
         dFXts/xKcR6ojBpzbca+8L6KuT8iqqyD+g7R0DypUjpxtMsTMsEcZ39O1/+gaP0HiI8z
         1oPUAxJ0ptKckf70c5JwOhabxwAES2vBFtemhLr5m9DT9ua6wM4xFyd+5YIGLDGbz1Uq
         YJNDaXpQwnD7oibgZiu28xkW1lPv2IMqhlBDrlXZJBBByOcgpQN+gOxRkHdPU4QRA/CM
         6apY9ywNfq5WU7PcpyoXiA+FwyawflIAoJxuSfhDZT3CCzBvrfI70UgzN/x/jzZZTq8z
         jBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=iuJaJSf0w8q+wcwKuU4TT506RpTyaAoUqC6QBZqFBjs=;
        b=uNoJX78xlmEqz3UUBec6RbjCNSCjvbZtqlfH4HmgxDWLR0wGVQoL5J/HioGIjPScye
         JqWZsNYrlHjTpozCw7AZ4nZM+o93YFmQjueR4ZZ6JJkcWfhxxDhMhEgbqyv4yVfBGVW2
         v12ig44uCh5sWxoMQ1qtpsGCut/KsRcURQ7fpszAjlcPR7hssG1XJCIc1cArhlTcmkle
         YmUCxlvc74mfda5oRufwMwlvFhFT9vO8+4V6dMh/0PtHwhZ0qZa+BoRLfMF3s+A7CuU8
         OEnky2jd3LbGEOpbCK7AIuOHa75XopIXt1q1DluWaK7/blF02isIXHJkSyIXOBs+m3ix
         PZNw==
X-Gm-Message-State: AOAM532P/Wircv6z5+c2nk4+M0EcXbtvnc8pC/IrFXujyTksZc8/LCb/
        IwyB/iwGDZcVL/1Pz4FvuoJe+T+/
X-Google-Smtp-Source: ABdhPJyYpWWXGTfqBpgQP4q/ohVC38Yg2vlNwR07wjuranVo8a+V59ceHsJ4f3ipvqhLRbUxidpVHg==
X-Received: by 2002:a1c:dc02:: with SMTP id t2mr3223877wmg.8.1590569360403;
        Wed, 27 May 2020 01:49:20 -0700 (PDT)
Received: from [192.168.43.18] ([85.255.237.0])
        by smtp.gmail.com with ESMTPSA id v22sm2138991wml.21.2020.05.27.01.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 01:49:19 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 1/2] staging: vt6656: vnt_tx_packet use skb_clone to preserve
 sk_buff.
Message-ID: <b87e8cc1-f584-989d-830b-609d712f08c7@gmail.com>
Date:   Wed, 27 May 2020 09:49:18 +0100
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

The sk_buff needs to preserved for copying to various parts
of context and passing back to mac80211

clone sk_buff in context so to continue to writing to orginal
sk_buff data area to send in vnt_tx_context.

dev_kfree_skb the context on error or dev_kfree_skb the
orignal when done. The error handling continues as before.

Only one place in function needs to change from
ieee80211_get_hdrlen_from_skb to ieee80211_hdrlen(hdr) which
is already to pointing to correct position.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/rxtx.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index a1b16ef9b27f..05b9a9ee0e33 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -545,13 +545,18 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 		return -ENOMEM;
 	}
 
-	tx_context->skb = skb;
 	tx_context->pkt_type = pkt_type;
 	tx_context->frame_len = skb->len + 4;
 	tx_context->tx_rate =  rate->hw_value;
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
+	tx_context->skb = skb_clone(skb, GFP_ATOMIC);
+	if (!tx_context->skb) {
+		tx_context->in_use = false;
+		return -ENOMEM;
+	}
+
 	tx_header_size = vnt_get_hdr_size(info);
 	tx_bytes = tx_header_size + skb->len;
 	tx_header_size += sizeof(struct vnt_tx_usb_header);
@@ -565,12 +570,9 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	tx_buffer->usb.type = 0x00;
 
 	tx_context->type = CONTEXT_DATA_PACKET;
-	tx_context->tx_buffer = tx_buffer;
+	tx_context->tx_buffer = skb->data;
 	tx_context->buf_len = skb->len;
 
-	/* Return skb->data to mac80211 header */
-	skb_pull(skb, tx_header_size);
-
 	/*Set fifo controls */
 	if (pkt_type == PK_TYPE_11A)
 		tx_buffer_head->fifo_ctl = 0;
@@ -606,7 +608,7 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 		tx_buffer_head->fifo_ctl |= cpu_to_le16(FIFOCTL_LHEAD);
 
 	tx_buffer_head->frag_ctl =
-			cpu_to_le16(ieee80211_get_hdrlen_from_skb(skb) << 10);
+			cpu_to_le16(ieee80211_hdrlen(hdr->frame_control) << 10);
 
 	if (info->control.hw_key)
 		tx_context->frame_len += info->control.hw_key->icv_len;
@@ -623,10 +625,13 @@ int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	spin_lock_irqsave(&priv->lock, flags);
 
 	if (vnt_tx_context(priv, tx_context)) {
+		dev_kfree_skb(tx_context->skb);
 		spin_unlock_irqrestore(&priv->lock, flags);
 		return -EIO;
 	}
 
+	dev_kfree_skb(skb);
+
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
-- 
2.27.0.rc0

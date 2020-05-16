Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52281D6067
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2020 12:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgEPKji (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 May 2020 06:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725792AbgEPKjh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 May 2020 06:39:37 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A1DC061A0C
        for <linux-wireless@vger.kernel.org>; Sat, 16 May 2020 03:39:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d207so15666574wmd.0
        for <linux-wireless@vger.kernel.org>; Sat, 16 May 2020 03:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=F/l24gqVi6+zqyOP90zR/e+IEIcM46kA4/Twj4qiqXM=;
        b=aQ5fEr6NurRoHEV1waDICNTNS3pLGPTVIUq5KOvTnfeoC8ooLa4NnzM00Tw8hnzywK
         uNyXolm4F+z9r0VMD3zRdyZtzoLVP87BXTDgVhlC+JNDCZTRmP51G2yxun1WYZK/mYoU
         dqwxWdXZLfczo2KqzDflrhAWSLJhmcTuw1usgw19ygZhj6C06TqtWu4kwcma9Hkqr1C9
         AW9ETDBVeHDduN7nxXS/XfezJE9ZeL7t783Wk1BgszkYn4yHyrxPzPzObwv0SAEyIk6X
         7G3cYH2hmNKIqKFdsiMUbTuWAGOGMafl7t5x30R3IlYmNRIoWEAYYNMKRqh7HHbfJNwH
         zNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=F/l24gqVi6+zqyOP90zR/e+IEIcM46kA4/Twj4qiqXM=;
        b=CS1/QLlnWHpc2ybi5QFX41J3f2w3HXbDRTF9Z8Zt3cGMqKWUlOgiGD0L5uv+nTp4K6
         i4ZSJDB9MvqtGFub6oxCXVNOLyn4ucHAWmc59G9mR1+uZAcU8Dy0prnOkMFQVQg5jCoi
         Boto8eszAuEvbxcXKjlI+pcSmL2hXf2ju5F5q4Zc1jKeEO0KciNN7M8oJFgq2FXYlfj+
         eCnTFgfms7kacR3PzPPSjYvjm3ZKLWFDeavEC7WJalB+CuHmRJDRvR55xy1Nu7tiYw2U
         KX+tvT04ZIGq+cObBHIFsxluy1slxdmLek0LF69UFvy5dQCPt2V44V8aMttLJ0YWVaFz
         KAwQ==
X-Gm-Message-State: AOAM531m2DCzel9NyeDvwTaqG1wyTrQBkODcKQ4upIspd1Po+PjE+oxU
        pqqobiCCsVdfpblC2X6Tz1HWBmnR
X-Google-Smtp-Source: ABdhPJyhSeG4eqrNyARkidbYiQIx0AN/5ZfRbtwpJst8UdsjeDJN3h3QdxVlZ/TCBJ/sLORSPALScg==
X-Received: by 2002:a1c:7407:: with SMTP id p7mr9319690wmc.114.1589625575923;
        Sat, 16 May 2020 03:39:35 -0700 (PDT)
Received: from [192.168.43.18] ([185.69.145.77])
        by smtp.gmail.com with ESMTPSA id b7sm7207389wmj.29.2020.05.16.03.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 03:39:35 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 2/4] staging: vt6656: vnt_beacon_xmit use extra_tx_headroom.
Message-ID: <5f00d319-9242-65b2-d100-dcfe9b0e32be@gmail.com>
Date:   Sat, 16 May 2020 11:39:34 +0100
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

Create room for vnt_tx_short_buf_head in sk_buff and vnt_tx_usb_header.

The struct ieee80211_mgmt is not longer in the header and is at
the initial skb->data point.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/rxtx.c | 22 +++++++++-------------
 drivers/staging/vt6656/rxtx.h |  5 +----
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 792833f8192a..cf194c95df03 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -684,8 +684,9 @@ static int vnt_beacon_xmit(struct vnt_private *priv, struct sk_buff *skb)
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	beacon_buffer = (struct vnt_beacon_buffer *)&context->data[0];
-	short_head = &beacon_buffer->short_head;
+	mgmt_hdr = (struct ieee80211_mgmt *)skb->data;
+	short_head = skb_push(skb, sizeof(*short_head));
+	count = skb->len;
 
 	if (priv->bb_type == BB_TYPE_11A) {
 		current_rate = RATE_6M;
@@ -710,10 +711,6 @@ static int vnt_beacon_xmit(struct vnt_private *priv, struct sk_buff *skb)
 			vnt_time_stamp_off(priv, current_rate);
 	}
 
-	/* Generate Beacon Header */
-	mgmt_hdr = &beacon_buffer->mgmt_hdr;
-	memcpy(mgmt_hdr, skb->data, skb->len);
-
 	/* Get Duration */
 	short_head->duration = mgmt_hdr->duration;
 
@@ -732,15 +729,14 @@ static int vnt_beacon_xmit(struct vnt_private *priv, struct sk_buff *skb)
 	if (priv->seq_counter > 0x0fff)
 		priv->seq_counter = 0;
 
-	count = sizeof(struct vnt_tx_short_buf_head) + skb->len;
-
-	beacon_buffer->tx_byte_count = cpu_to_le16(count);
-	beacon_buffer->pkt_no = context->pkt_no;
-	beacon_buffer->type = 0x01;
+	beacon_buffer = skb_push(skb, sizeof(struct vnt_tx_usb_header));
+	beacon_buffer->usb.tx_byte_count = cpu_to_le16(count);
+	beacon_buffer->usb.pkt_no = context->pkt_no;
+	beacon_buffer->usb.type = 0x01;
 
 	context->type = CONTEXT_BEACON_PACKET;
-	context->tx_buffer = &context->data;
-	context->buf_len = count + 4; /* USB header */
+	context->tx_buffer = beacon_buffer;
+	context->buf_len = skb->len;
 
 	spin_lock_irqsave(&priv->lock, flags);
 
diff --git a/drivers/staging/vt6656/rxtx.h b/drivers/staging/vt6656/rxtx.h
index 819b45394673..fd64d0838e34 100644
--- a/drivers/staging/vt6656/rxtx.h
+++ b/drivers/staging/vt6656/rxtx.h
@@ -180,11 +180,8 @@ struct vnt_tx_short_buf_head {
 } __packed;
 
 struct vnt_beacon_buffer {
-	u8 type;
-	u8 pkt_no;
-	__le16 tx_byte_count;
+	struct vnt_tx_usb_header usb;
 	struct vnt_tx_short_buf_head short_head;
-	struct ieee80211_mgmt mgmt_hdr;
 } __packed;
 
 int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb);
-- 
2.25.1

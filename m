Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DA11C62B1
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 23:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgEEVMJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 17:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbgEEVMI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 17:12:08 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C640C061A0F
        for <linux-wireless@vger.kernel.org>; Tue,  5 May 2020 14:12:08 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u127so59407wmg.1
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2020 14:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=bS/cZOt/hptvsdPV4RhZemHIC9RWIuhYXFdYJuvfz4Q=;
        b=RiKHfoTU0lmqEt9zFwCmUgcmU8yfa3rf3uHGQLGPH6JTAPoAAww7WlKWNxNgzLDt80
         0KV/EY6/v2KJJzFmPiBZJrBJB1xABlIEiENNLX+CsWXxJzZ9qU/f1/Go7OpFFatssXnc
         82IvFupbR72GbV/vMzyveSa3ADB5+sIBhMNtnFer5l58/vl6IY6J9FqZBXfCvNQh949D
         ivICHK1u3NxJn9kQRWj/Qi4hkliAZ529ooStE1z8Mf2axzq16phWAvcG42MgtbkmPUET
         7Q+CrN15u22bamCZcs/z5Pd5RWPBL0X9Q2mGsNAr/m5KbNU7v+eCeTEOt+7VVBIZLLEV
         ZgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=bS/cZOt/hptvsdPV4RhZemHIC9RWIuhYXFdYJuvfz4Q=;
        b=sTE3OqSSiw5E9tM563e4LPBL5hnZ7lyr2ZEoy1ZDEFmTfLcBzKHpjit5gLy0DMVElL
         BrWDsnsxX7u9r8rmzn0HQQ6qJC5mqtV5fC0EdaJ78T9PK62HZujrPLAE/7KM8AfACcxX
         xLpn9khg0sZ1nfKaJCNElG69F9qOcChS2i5mmdEDAWGyvPxyi8/0mscCZvzVNljpmWZ2
         dPE3io8gjfcnhbf7HWHW9M5/0lgE60qbdsPqCG9iREtXB2p8tasFLQBfp1jS4tSdfjlL
         O6bL1iAhobHrT4rLICIvZOEXGbKXsy8nJ03YL6x6jPrkE8Fe4Wn50VkpEUFnKfXOfp5s
         w+VQ==
X-Gm-Message-State: AGi0PuaTw8oQiadAKFmn5E9dWHnybpDouuHJT394KO0kfN+5vhZZzA2k
        jEAt99bpVxa6ICpTgQv+kyc=
X-Google-Smtp-Source: APiQypJoIVCggnHBJVTQ/nK2vRO3YfMsPgL6hAJAdn4WVKzZ9rzKYPgNvWNvmCL63P/8680u75L/lw==
X-Received: by 2002:a7b:c390:: with SMTP id s16mr556784wmj.14.1588713127172;
        Tue, 05 May 2020 14:12:07 -0700 (PDT)
Received: from [192.168.43.18] (188.29.165.117.threembb.co.uk. [188.29.165.117])
        by smtp.gmail.com with ESMTPSA id k9sm5452228wrd.17.2020.05.05.14.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 14:12:06 -0700 (PDT)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 1/6] staging: vt6656: vnt_rxtx_rsvtime_le16 to use
 ieee80211_generic_frame_duration.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
Message-ID: <acff7fcc-0add-652b-7d07-22001b641257@gmail.com>
Date:   Tue, 5 May 2020 22:12:04 +0100
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

ieee80211_generic_frame_duration is the mac80211 equivalent to
vnt_get_rsvtime use this to get our frame time.

There is a change where there is rrv_time_a and rrv_time_b
the frame duration is always the same so both are equal.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/rxtx.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 68be0fa7b201..6724b213a723 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -216,11 +216,16 @@ static u32 vnt_get_rsvtime(struct vnt_private *priv, u8 pkt_type,
 	return data_time;
 }
 
-static __le16 vnt_rxtx_rsvtime_le16(struct vnt_private *priv, u8 pkt_type,
-				    u32 frame_length, u16 rate, int need_ack)
+static __le16 vnt_rxtx_rsvtime_le16(struct vnt_usb_send_context *context)
 {
-	return cpu_to_le16((u16)vnt_get_rsvtime(priv, pkt_type,
-		frame_length, rate, need_ack));
+	struct vnt_private *priv = context->priv;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(context->skb);
+	struct ieee80211_rate *rate = ieee80211_get_tx_rate(priv->hw, info);
+
+	return ieee80211_generic_frame_duration(priv->hw,
+						 info->control.vif, info->band,
+						 context->frame_len,
+						 rate);
 }
 
 static __le16 vnt_get_rtscts_rsvtime_le(struct vnt_private *priv, u8 rsv_type,
@@ -465,7 +470,6 @@ static void vnt_rxtx_rts(struct vnt_usb_send_context *tx_context,
 	union vnt_tx_data_head *head = &tx_head->tx_rts.tx.head;
 	u32 frame_len = tx_context->frame_len;
 	u16 current_rate = tx_context->tx_rate;
-	u8 need_ack = tx_context->need_ack;
 
 	buf->rts_rrv_time_aa = vnt_get_rtscts_rsvtime_le(priv, 2,
 			tx_context->pkt_type, frame_len, current_rate);
@@ -474,11 +478,8 @@ static void vnt_rxtx_rts(struct vnt_usb_send_context *tx_context,
 	buf->rts_rrv_time_bb = vnt_get_rtscts_rsvtime_le(priv, 0,
 			tx_context->pkt_type, frame_len, current_rate);
 
-	buf->rrv_time_a = vnt_rxtx_rsvtime_le16(priv, tx_context->pkt_type,
-						frame_len, current_rate,
-						need_ack);
-	buf->rrv_time_b = vnt_rxtx_rsvtime_le16(priv, PK_TYPE_11B, frame_len,
-					priv->top_cck_basic_rate, need_ack);
+	buf->rrv_time_a = vnt_rxtx_rsvtime_le16(tx_context);
+	buf->rrv_time_b = buf->rrv_time_a;
 
 	if (need_mic)
 		head = &tx_head->tx_rts.tx.mic.head;
@@ -494,12 +495,9 @@ static void vnt_rxtx_cts(struct vnt_usb_send_context *tx_context,
 	union vnt_tx_data_head *head = &tx_head->tx_cts.tx.head;
 	u32 frame_len = tx_context->frame_len;
 	u16 current_rate = tx_context->tx_rate;
-	u8 need_ack = tx_context->need_ack;
 
-	buf->rrv_time_a = vnt_rxtx_rsvtime_le16(priv, tx_context->pkt_type,
-					frame_len, current_rate, need_ack);
-	buf->rrv_time_b = vnt_rxtx_rsvtime_le16(priv, PK_TYPE_11B,
-				frame_len, priv->top_cck_basic_rate, need_ack);
+	buf->rrv_time_a = vnt_rxtx_rsvtime_le16(tx_context);
+	buf->rrv_time_b = buf->rrv_time_a;
 
 	buf->cts_rrv_time_ba = vnt_get_rtscts_rsvtime_le(priv, 3,
 			tx_context->pkt_type, frame_len, current_rate);
@@ -519,10 +517,8 @@ static void vnt_rxtx_ab(struct vnt_usb_send_context *tx_context,
 	union vnt_tx_data_head *head = &tx_head->tx_ab.tx.head;
 	u32 frame_len = tx_context->frame_len;
 	u16 current_rate = tx_context->tx_rate;
-	u8 need_ack = tx_context->need_ack;
 
-	buf->rrv_time = vnt_rxtx_rsvtime_le16(priv, tx_context->pkt_type,
-					      frame_len, current_rate, need_ack);
+	buf->rrv_time = vnt_rxtx_rsvtime_le16(tx_context);
 
 	if (need_mic)
 		head = &tx_head->tx_ab.tx.mic.head;
-- 
2.25.1

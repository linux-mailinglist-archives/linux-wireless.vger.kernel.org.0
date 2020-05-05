Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66591C62D3
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 23:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgEEVRb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 17:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729132AbgEEVRb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 17:17:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73223C061A0F
        for <linux-wireless@vger.kernel.org>; Tue,  5 May 2020 14:17:29 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so62750wmh.3
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2020 14:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=d0r3Leq0Re/fLKhqmXXw2a+2V44MmCt/uWMVWQ8KUMg=;
        b=UDoG4ITPPpw2kSqvRD8Z4DlHtr5C/cR2V+D7WQVfxjvMm8SwczHHj5KUl7Cn2uXoWN
         b0Ul6V6SrFudAfRkGIvyTH0cbG8OQ4ckuANs65157pVuoieW1WmTBuWkIfpdNNZaqHsM
         T8TwlW4FSlH5U6gtkHOj1UUWjlySVoVa7W2RjskotLA7EG/Jpmv1T+vZTerwKfQTG+u6
         JK171jY83fhqKOIOBodDDHv+sSF5Vb6AjHSEu05zdCzqcOBoLyVeIsh0WoXrs+tENvxw
         0hZwA+grTIu73wzCcGknLFROMkpZ0VDnAbyC1RjufAzMN25BIzplLlbrOVBgIwCcMp67
         ck2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=d0r3Leq0Re/fLKhqmXXw2a+2V44MmCt/uWMVWQ8KUMg=;
        b=g2QgEjKgD8gSdp0MPiulJyZigl1VCc67pukb/Lvq02l5NwovEOVC12OLGbynVYAoCT
         4eeeNHUS3sc/VgqE3Hk+O2e3n9memIXhpxR+CSab8ZNNuVk2aRBPQYbSMB2LEfBB6LTA
         R0wHlc5UO2ZB7aTfS02Q9Sr97tLeUyrifr0tC2lCpgLUPolfqiOboRwCM+5+yr5/HE+M
         UFmfwaNDQDgm2He5PNqMD0gH84BUKstqQmqTd5+8i0diiEhEes5rMznKUnn2dOXubIfu
         uEjmLHoaBa7ZJIT+n2pUzzo+joDPzaY2LMuHxh5UnHOMu5bJ9AAfDZwz1HKWoob0KOEI
         VkQw==
X-Gm-Message-State: AGi0Pub6ytuLsh8kqYRJG93B7o5gWGgrF9YNX6s/gPBGDUSI1cAEQBSy
        BWUnnonPl9dn1U+OIenX2zc=
X-Google-Smtp-Source: APiQypLGKJQ5FC95V+/FJx9rKnFHnQ3ate0PTS/I4KRO7xPfXbBtG9kqjPRkymGMWkHpToDwuip0Lg==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr33662wmc.51.1588713448256;
        Tue, 05 May 2020 14:17:28 -0700 (PDT)
Received: from [192.168.43.18] (188.29.165.117.threembb.co.uk. [188.29.165.117])
        by smtp.gmail.com with ESMTPSA id v7sm7629977wmg.3.2020.05.05.14.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 14:17:27 -0700 (PDT)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 4/6] staging: vt6656: Split RTS and CTS Duration functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
Message-ID: <d2983161-7935-48ce-c0ca-a26ebafa3997@gmail.com>
Date:   Tue, 5 May 2020 22:17:26 +0100
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

split vnt_get_rtscts_duration_le into vnt_get_rts_duration and
vnt_get_cts_duration.

The duration's are all the same in vnt_rxtx_rts_g_head.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/rxtx.c | 56 ++++++++++-------------------------
 1 file changed, 16 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 27069ac60b15..47da9dabb133 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -13,7 +13,6 @@
  *
  * Functions:
  *      vnt_generate_tx_parameter - Generate tx dma required parameter.
- *      vnt_get_rtscts_duration_le- get rtx/cts required duration
  *      vnt_get_rtscts_rsvtime_le- get rts/cts reserved time
  *      vnt_get_rsvtime- get frame reserved time
  *      vnt_fill_cts_head- fulfill CTS ctl header
@@ -38,10 +37,6 @@ static const u16 vnt_time_stampoff[2][MAX_RATE] = {
 	{384, 192, 130, 113, 54, 43, 37, 31, 28, 25, 24, 23},
 };
 
-#define RTSDUR_BB       0
-#define RTSDUR_BA       1
-#define RTSDUR_AA       2
-#define CTSDUR_BA       3
 #define DATADUR_B       10
 #define DATADUR_A       11
 
@@ -260,27 +255,22 @@ static __le16 vnt_get_rtscts_rsvtime_le(struct vnt_private *priv, u8 rsv_type,
 	return cpu_to_le16((u16)rrv_time);
 }
 
-static __le16 vnt_get_rtscts_duration_le(struct vnt_usb_send_context *context,
-					 u8 dur_type, u8 pkt_type, u16 rate)
+static __le16 vnt_get_rts_duration(struct vnt_usb_send_context *context)
 {
 	struct vnt_private *priv = context->priv;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(context->skb);
 
-	switch (dur_type) {
-	/* fall through */
-	case RTSDUR_BB:
-	case RTSDUR_BA:
-	case RTSDUR_AA:
-		return ieee80211_rts_duration(priv->hw, priv->vif,
-					      context->frame_len, info);
-	case CTSDUR_BA:
-		return ieee80211_ctstoself_duration(priv->hw, priv->vif,
-						    context->frame_len, info);
-	default:
-		break;
-	}
+	return ieee80211_rts_duration(priv->hw, priv->vif,
+				      context->frame_len, info);
+}
 
-	return cpu_to_le16(0);
+static __le16 vnt_get_cts_duration(struct vnt_usb_send_context *context)
+{
+	struct vnt_private *priv = context->priv;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(context->skb);
+
+	return ieee80211_ctstoself_duration(priv->hw, priv->vif,
+					    context->frame_len, info);
 }
 
 static u16 vnt_mac_hdr_pos(struct vnt_usb_send_context *tx_context,
@@ -359,22 +349,15 @@ static void vnt_rxtx_rts_g_head(struct vnt_usb_send_context *tx_context,
 {
 	struct vnt_private *priv = tx_context->priv;
 	u16 rts_frame_len = 20;
-	u16 current_rate = tx_context->tx_rate;
 
 	vnt_get_phy_field(priv, rts_frame_len, priv->top_cck_basic_rate,
 			  PK_TYPE_11B, &buf->b);
 	vnt_get_phy_field(priv, rts_frame_len, priv->top_ofdm_basic_rate,
 			  tx_context->pkt_type, &buf->a);
 
-	buf->duration_bb = vnt_get_rtscts_duration_le(tx_context, RTSDUR_BB,
-						      PK_TYPE_11B,
-						      priv->top_cck_basic_rate);
-	buf->duration_aa = vnt_get_rtscts_duration_le(tx_context, RTSDUR_AA,
-						      tx_context->pkt_type,
-						      current_rate);
-	buf->duration_ba = vnt_get_rtscts_duration_le(tx_context, RTSDUR_BA,
-						      tx_context->pkt_type,
-						      current_rate);
+	buf->duration_bb = vnt_get_rts_duration(tx_context);
+	buf->duration_aa = buf->duration_bb;
+	buf->duration_ba = buf->duration_bb;
 
 	vnt_fill_ieee80211_rts(tx_context, &buf->data, buf->duration_aa);
 
@@ -385,15 +368,12 @@ static void vnt_rxtx_rts_ab_head(struct vnt_usb_send_context *tx_context,
 				 struct vnt_rts_ab *buf)
 {
 	struct vnt_private *priv = tx_context->priv;
-	u16 current_rate = tx_context->tx_rate;
 	u16 rts_frame_len = 20;
 
 	vnt_get_phy_field(priv, rts_frame_len, priv->top_ofdm_basic_rate,
 			  tx_context->pkt_type, &buf->ab);
 
-	buf->duration = vnt_get_rtscts_duration_le(tx_context, RTSDUR_AA,
-						   tx_context->pkt_type,
-						   current_rate);
+	buf->duration = vnt_get_rts_duration(tx_context);
 
 	vnt_fill_ieee80211_rts(tx_context, &buf->data, buf->duration);
 
@@ -406,16 +386,12 @@ static void vnt_fill_cts_head(struct vnt_usb_send_context *tx_context,
 	struct vnt_private *priv = tx_context->priv;
 	struct vnt_cts *buf = &head->cts_g;
 	u32 cts_frame_len = 14;
-	u16 current_rate = tx_context->tx_rate;
 
 	/* Get SignalField,ServiceField,Length */
 	vnt_get_phy_field(priv, cts_frame_len, priv->top_cck_basic_rate,
 			  PK_TYPE_11B, &buf->b);
 	/* Get CTSDuration_ba */
-	buf->duration_ba =
-		vnt_get_rtscts_duration_le(tx_context, CTSDUR_BA,
-					   tx_context->pkt_type,
-					   current_rate);
+	buf->duration_ba = vnt_get_cts_duration(tx_context);
 	/*Get CTS Frame body*/
 	buf->data.duration = buf->duration_ba;
 	buf->data.frame_control =
-- 
2.25.1

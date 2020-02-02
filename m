Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1FB814FEFB
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Feb 2020 20:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgBBTst (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Feb 2020 14:48:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40007 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgBBTst (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Feb 2020 14:48:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so14588315wmi.5
        for <linux-wireless@vger.kernel.org>; Sun, 02 Feb 2020 11:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=M8a5rcYDIE3IE9rCBJBMZv3RXDbXwOGJ0PvF1q0ynHA=;
        b=BMsVLMT+mJNXDGPL+9RBrLOnL7JhpToFRjOcnZqE1CxAusgbIh3WPwnhx2nSkvEDdw
         nf+fU9qpKHKqVjfdHej67JDsRMLWSn6WCOXIQN5W4qZWX8NOnnSDEP/mE2OPrMWqfees
         UnYxrmSzyQiU0TjyqJNXsvVq55plVnv1P8T/eo2ErhgqGD7T3BT1HRFEonqJPx2UszDj
         ka8OaBDqMN3h++f+VGsJnyeTIZNPE/WR+W/wHSfHfmy45oB89rK/YrtdJ+IYFX7WjRSk
         69Cub840oBjdbTc+fujMD8GjL3a0NqZPYYwLOifMdN0X+JuUkJ0S2Yjn9IYdqDosnR7z
         GL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=M8a5rcYDIE3IE9rCBJBMZv3RXDbXwOGJ0PvF1q0ynHA=;
        b=iABOw77Jze0vnnQ7k2EYEW/fsaiX3Y3SzwIsunsOBExKNYBzeTncIRBhV/rJhJ7sMI
         2LDUyTFBnUUOQhtVyaCUo5TCuHp6zuXVuuMMNSO/5q3PJGMxgLNBMmCP7nwbTOf65NuW
         KIqC23rQlQEl4ql3zE0gVipuD5cZU5spvzvXvYh1/ZqFHeY/3wAsZUSfIDNVTykXa9AW
         U6arErWypOtoKkwdhp1Cw1E1BErEGQVKIIlwYO1yno11pGBk/PHUpR2BQTk07TFO4tdP
         WDZuxkOwzfgZEa1318Ws3PpzcnQobyd99UIKFboqSIHmB1RlNVgjdnxgqRgPXpFEGRaw
         kZRw==
X-Gm-Message-State: APjAAAUYRbYSO7ytajBYjRg7TPwnbSYtFWdzOhnC4fYWwSduE2j4UoaG
        JpukB1YEMZm92MakHPwLbW4spU8W
X-Google-Smtp-Source: APXvYqyKa5U3Tw42v3VrovvHAc1l6uEu30AeIRoVI59BhAR5ZD6fH26MkOfsYr7FQJTo+0thD2giBA==
X-Received: by 2002:a05:600c:2318:: with SMTP id 24mr25368015wmo.48.1580672925999;
        Sun, 02 Feb 2020 11:48:45 -0800 (PST)
Received: from [192.168.43.18] (92.40.248.192.threembb.co.uk. [92.40.248.192])
        by smtp.gmail.com with ESMTPSA id s15sm21934981wrp.4.2020.02.02.11.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2020 11:48:45 -0800 (PST)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 2/2] staging: vt6656: Remove fall back functions and headers.
Message-ID: <33732aad-5905-c173-ea81-431265e4f7e7@gmail.com>
Date:   Sun, 2 Feb 2020 19:48:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fall back is no longer used in driver so remove all
functions and headers.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/device.h |   1 -
 drivers/staging/vt6656/rxtx.c   | 206 --------------------------------
 drivers/staging/vt6656/rxtx.h   |  60 ----------
 3 files changed, 267 deletions(-)

diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
index fe6c11266123..da868adba7c9 100644
--- a/drivers/staging/vt6656/device.h
+++ b/drivers/staging/vt6656/device.h
@@ -244,7 +244,6 @@ struct vnt_usb_send_context {
 	u8 pkt_no;
 	u8 pkt_type;
 	u8 need_ack;
-	u8 fb_option;
 	bool in_use;
 	unsigned char data[MAX_TOTAL_SIZE_WITH_ALL_HEADERS];
 };
diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 0fabeb396563..74c1062dbaaa 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -39,30 +39,12 @@ static const u16 vnt_time_stampoff[2][MAX_RATE] = {
 	{384, 192, 130, 113, 54, 43, 37, 31, 28, 25, 24, 23},
 };
 
-static const u16 vnt_fb_opt0[2][5] = {
-	{RATE_12M, RATE_18M, RATE_24M, RATE_36M, RATE_48M}, /* fallback_rate0 */
-	{RATE_12M, RATE_12M, RATE_18M, RATE_24M, RATE_36M}, /* fallback_rate1 */
-};
-
-static const u16 vnt_fb_opt1[2][5] = {
-	{RATE_12M, RATE_18M, RATE_24M, RATE_24M, RATE_36M}, /* fallback_rate0 */
-	{RATE_6M,  RATE_6M,  RATE_12M, RATE_12M, RATE_18M}, /* fallback_rate1 */
-};
-
 #define RTSDUR_BB       0
 #define RTSDUR_BA       1
 #define RTSDUR_AA       2
 #define CTSDUR_BA       3
-#define RTSDUR_BA_F0    4
-#define RTSDUR_AA_F0    5
-#define RTSDUR_BA_F1    6
-#define RTSDUR_AA_F1    7
-#define CTSDUR_BA_F0    8
-#define CTSDUR_BA_F1    9
 #define DATADUR_B       10
 #define DATADUR_A       11
-#define DATADUR_A_F0    12
-#define DATADUR_A_F1    13
 
 static struct vnt_usb_send_context
 	*vnt_get_free_context(struct vnt_private *priv)
@@ -216,8 +198,6 @@ static __le16 vnt_get_rtscts_duration_le(struct vnt_usb_send_context *context,
 	switch (dur_type) {
 	case RTSDUR_BB:
 	case RTSDUR_BA:
-	case RTSDUR_BA_F0:
-	case RTSDUR_BA_F1:
 		cts_time = vnt_get_frame_time(priv->preamble_type, pkt_type,
 					      14, priv->top_cck_basic_rate);
 		dur_time = cts_time + 2 * priv->sifs +
@@ -226,8 +206,6 @@ static __le16 vnt_get_rtscts_duration_le(struct vnt_usb_send_context *context,
 		break;
 
 	case RTSDUR_AA:
-	case RTSDUR_AA_F0:
-	case RTSDUR_AA_F1:
 		cts_time = vnt_get_frame_time(priv->preamble_type, pkt_type,
 					      14, priv->top_ofdm_basic_rate);
 		dur_time = cts_time + 2 * priv->sifs +
@@ -236,8 +214,6 @@ static __le16 vnt_get_rtscts_duration_le(struct vnt_usb_send_context *context,
 		break;
 
 	case CTSDUR_BA:
-	case CTSDUR_BA_F0:
-	case CTSDUR_BA_F1:
 		dur_time = priv->sifs + vnt_get_rsvtime(priv,
 				pkt_type, frame_length, rate, need_ack);
 		break;
@@ -297,63 +273,6 @@ static u16 vnt_rxtx_datahead_g(struct vnt_usb_send_context *tx_context,
 	return le16_to_cpu(buf->duration_a);
 }
 
-static u16 vnt_rxtx_datahead_g_fb(struct vnt_usb_send_context *tx_context,
-				  struct vnt_tx_datahead_g_fb *buf)
-{
-	struct vnt_private *priv = tx_context->priv;
-	u32 frame_len = tx_context->frame_len;
-	u16 rate = tx_context->tx_rate;
-	u8 need_ack = tx_context->need_ack;
-
-	/* Get SignalField,ServiceField,Length */
-	vnt_get_phy_field(priv, frame_len, rate, tx_context->pkt_type, &buf->a);
-
-	vnt_get_phy_field(priv, frame_len, priv->top_cck_basic_rate,
-			  PK_TYPE_11B, &buf->b);
-
-	/* Get Duration and TimeStamp */
-	buf->duration_a = vnt_get_duration_le(priv, tx_context->pkt_type,
-					      need_ack);
-	buf->duration_b = vnt_get_duration_le(priv, PK_TYPE_11B, need_ack);
-
-	buf->duration_a_f0 = vnt_get_duration_le(priv, tx_context->pkt_type,
-						 need_ack);
-	buf->duration_a_f1 = vnt_get_duration_le(priv, tx_context->pkt_type,
-						 need_ack);
-
-	buf->time_stamp_off_a = vnt_time_stamp_off(priv, rate);
-	buf->time_stamp_off_b = vnt_time_stamp_off(priv,
-						   priv->top_cck_basic_rate);
-
-	tx_context->tx_hdr_size = vnt_mac_hdr_pos(tx_context, &buf->hdr);
-
-	return le16_to_cpu(buf->duration_a);
-}
-
-static u16 vnt_rxtx_datahead_a_fb(struct vnt_usb_send_context *tx_context,
-				  struct vnt_tx_datahead_a_fb *buf)
-{
-	struct vnt_private *priv = tx_context->priv;
-	u16 rate = tx_context->tx_rate;
-	u8 pkt_type = tx_context->pkt_type;
-	u8 need_ack = tx_context->need_ack;
-	u32 frame_len = tx_context->frame_len;
-
-	/* Get SignalField,ServiceField,Length */
-	vnt_get_phy_field(priv, frame_len, rate, pkt_type, &buf->a);
-	/* Get Duration and TimeStampOff */
-	buf->duration = vnt_get_duration_le(priv, pkt_type, need_ack);
-
-	buf->duration_f0 = vnt_get_duration_le(priv, pkt_type, need_ack);
-	buf->duration_f1 = vnt_get_duration_le(priv, pkt_type, need_ack);
-
-	buf->time_stamp_off = vnt_time_stamp_off(priv, rate);
-
-	tx_context->tx_hdr_size = vnt_mac_hdr_pos(tx_context, &buf->hdr);
-
-	return le16_to_cpu(buf->duration);
-}
-
 static u16 vnt_rxtx_datahead_ab(struct vnt_usb_send_context *tx_context,
 				struct vnt_tx_datahead_ab *buf)
 {
@@ -426,50 +345,6 @@ static u16 vnt_rxtx_rts_g_head(struct vnt_usb_send_context *tx_context,
 	return vnt_rxtx_datahead_g(tx_context, &buf->data_head);
 }
 
-static u16 vnt_rxtx_rts_g_fb_head(struct vnt_usb_send_context *tx_context,
-				  struct vnt_rts_g_fb *buf)
-{
-	struct vnt_private *priv = tx_context->priv;
-	u16 current_rate = tx_context->tx_rate;
-	u16 rts_frame_len = 20;
-
-	vnt_get_phy_field(priv, rts_frame_len, priv->top_cck_basic_rate,
-			  PK_TYPE_11B, &buf->b);
-	vnt_get_phy_field(priv, rts_frame_len, priv->top_ofdm_basic_rate,
-			  tx_context->pkt_type, &buf->a);
-
-	buf->duration_bb = vnt_get_rtscts_duration_le(tx_context, RTSDUR_BB,
-						      PK_TYPE_11B,
-						      priv->top_cck_basic_rate);
-	buf->duration_aa = vnt_get_rtscts_duration_le(tx_context, RTSDUR_AA,
-						      tx_context->pkt_type,
-						      current_rate);
-	buf->duration_ba = vnt_get_rtscts_duration_le(tx_context, RTSDUR_BA,
-						      tx_context->pkt_type,
-						      current_rate);
-
-	buf->rts_duration_ba_f0 =
-		vnt_get_rtscts_duration_le(tx_context, RTSDUR_BA_F0,
-					   tx_context->pkt_type,
-					   priv->tx_rate_fb0);
-	buf->rts_duration_aa_f0 =
-		vnt_get_rtscts_duration_le(tx_context, RTSDUR_AA_F0,
-					   tx_context->pkt_type,
-					   priv->tx_rate_fb0);
-	buf->rts_duration_ba_f1 =
-		vnt_get_rtscts_duration_le(tx_context, RTSDUR_BA_F1,
-					   tx_context->pkt_type,
-					   priv->tx_rate_fb1);
-	buf->rts_duration_aa_f1 =
-		vnt_get_rtscts_duration_le(tx_context, RTSDUR_AA_F1,
-					   tx_context->pkt_type,
-					   priv->tx_rate_fb1);
-
-	vnt_fill_ieee80211_rts(tx_context, &buf->data, buf->duration_aa);
-
-	return vnt_rxtx_datahead_g_fb(tx_context, &buf->data_head);
-}
-
 static u16 vnt_rxtx_rts_ab_head(struct vnt_usb_send_context *tx_context,
 				struct vnt_rts_ab *buf)
 {
@@ -489,71 +364,6 @@ static u16 vnt_rxtx_rts_ab_head(struct vnt_usb_send_context *tx_context,
 	return vnt_rxtx_datahead_ab(tx_context, &buf->data_head);
 }
 
-static u16 vnt_rxtx_rts_a_fb_head(struct vnt_usb_send_context *tx_context,
-				  struct vnt_rts_a_fb *buf)
-{
-	struct vnt_private *priv = tx_context->priv;
-	u16 current_rate = tx_context->tx_rate;
-	u16 rts_frame_len = 20;
-
-	vnt_get_phy_field(priv, rts_frame_len, priv->top_ofdm_basic_rate,
-			  tx_context->pkt_type, &buf->a);
-
-	buf->duration = vnt_get_rtscts_duration_le(tx_context, RTSDUR_AA,
-						   tx_context->pkt_type,
-						   current_rate);
-
-	buf->rts_duration_f0 =
-		vnt_get_rtscts_duration_le(tx_context, RTSDUR_AA_F0,
-					   tx_context->pkt_type,
-					   priv->tx_rate_fb0);
-
-	buf->rts_duration_f1 =
-		vnt_get_rtscts_duration_le(tx_context, RTSDUR_AA_F1,
-					   tx_context->pkt_type,
-					   priv->tx_rate_fb1);
-
-	vnt_fill_ieee80211_rts(tx_context, &buf->data, buf->duration);
-
-	return vnt_rxtx_datahead_a_fb(tx_context, &buf->data_head);
-}
-
-static u16 vnt_fill_cts_fb_head(struct vnt_usb_send_context *tx_context,
-				union vnt_tx_data_head *head)
-{
-	struct vnt_private *priv = tx_context->priv;
-	struct vnt_cts_fb *buf = &head->cts_g_fb;
-	u32 cts_frame_len = 14;
-	u16 current_rate = tx_context->tx_rate;
-
-	/* Get SignalField,ServiceField,Length */
-	vnt_get_phy_field(priv, cts_frame_len, priv->top_cck_basic_rate,
-			  PK_TYPE_11B, &buf->b);
-
-	buf->duration_ba =
-		vnt_get_rtscts_duration_le(tx_context, CTSDUR_BA,
-					   tx_context->pkt_type,
-					   current_rate);
-	/* Get CTSDuration_ba_f0 */
-	buf->cts_duration_ba_f0 =
-		vnt_get_rtscts_duration_le(tx_context, CTSDUR_BA_F0,
-					   tx_context->pkt_type,
-					   priv->tx_rate_fb0);
-	/* Get CTSDuration_ba_f1 */
-	buf->cts_duration_ba_f1 =
-		vnt_get_rtscts_duration_le(tx_context, CTSDUR_BA_F1,
-					   tx_context->pkt_type,
-					   priv->tx_rate_fb1);
-	/* Get CTS Frame body */
-	buf->data.duration = buf->duration_ba;
-	buf->data.frame_control =
-		cpu_to_le16(IEEE80211_FTYPE_CTL | IEEE80211_STYPE_CTS);
-
-	ether_addr_copy(buf->data.ra, priv->current_net_addr);
-
-	return vnt_rxtx_datahead_g_fb(tx_context, &buf->data_head);
-}
-
 static u16 vnt_fill_cts_head(struct vnt_usb_send_context *tx_context,
 			     union vnt_tx_data_head *head)
 {
@@ -606,9 +416,6 @@ static u16 vnt_rxtx_rts(struct vnt_usb_send_context *tx_context,
 	if (need_mic)
 		head = &tx_head->tx_rts.tx.mic.head;
 
-	if (tx_context->fb_option)
-		return vnt_rxtx_rts_g_fb_head(tx_context, &head->rts_g_fb);
-
 	return vnt_rxtx_rts_g_head(tx_context, &head->rts_g);
 }
 
@@ -633,10 +440,6 @@ static u16 vnt_rxtx_cts(struct vnt_usb_send_context *tx_context,
 	if (need_mic)
 		head = &tx_head->tx_cts.tx.mic.head;
 
-	/* Fill CTS */
-	if (tx_context->fb_option)
-		return vnt_fill_cts_fb_head(tx_context, head);
-
 	return vnt_fill_cts_head(tx_context, head);
 }
 
@@ -664,18 +467,9 @@ static u16 vnt_rxtx_ab(struct vnt_usb_send_context *tx_context,
 			buf->rts_rrv_time = vnt_get_rtscts_rsvtime_le(priv, 2,
 				tx_context->pkt_type, frame_len, current_rate);
 
-		if (tx_context->fb_option &&
-		    tx_context->pkt_type == PK_TYPE_11A)
-			return vnt_rxtx_rts_a_fb_head(tx_context,
-						      &head->rts_a_fb);
-
 		return vnt_rxtx_rts_ab_head(tx_context, &head->rts_ab);
 	}
 
-	if (tx_context->pkt_type == PK_TYPE_11A)
-		return vnt_rxtx_datahead_a_fb(tx_context,
-					      &head->data_head_a_fb);
-
 	return vnt_rxtx_datahead_ab(tx_context, &head->data_head_ab);
 }
 
diff --git a/drivers/staging/vt6656/rxtx.h b/drivers/staging/vt6656/rxtx.h
index d528607e02bf..10076efa4522 100644
--- a/drivers/staging/vt6656/rxtx.h
+++ b/drivers/staging/vt6656/rxtx.h
@@ -73,18 +73,6 @@ struct vnt_tx_datahead_g {
 	struct ieee80211_hdr hdr;
 } __packed;
 
-struct vnt_tx_datahead_g_fb {
-	struct vnt_phy_field b;
-	struct vnt_phy_field a;
-	__le16 duration_b;
-	__le16 duration_a;
-	__le16 duration_a_f0;
-	__le16 duration_a_f1;
-	__le16 time_stamp_off_b;
-	__le16 time_stamp_off_a;
-	struct ieee80211_hdr hdr;
-} __packed;
-
 struct vnt_tx_datahead_ab {
 	struct vnt_phy_field ab;
 	__le16 duration;
@@ -92,15 +80,6 @@ struct vnt_tx_datahead_ab {
 	struct ieee80211_hdr hdr;
 } __packed;
 
-struct vnt_tx_datahead_a_fb {
-	struct vnt_phy_field a;
-	__le16 duration;
-	__le16 time_stamp_off;
-	__le16 duration_f0;
-	__le16 duration_f1;
-	struct ieee80211_hdr hdr;
-} __packed;
-
 /* RTS buffer header */
 struct vnt_rts_g {
 	struct vnt_phy_field b;
@@ -113,21 +92,6 @@ struct vnt_rts_g {
 	struct vnt_tx_datahead_g data_head;
 } __packed;
 
-struct vnt_rts_g_fb {
-	struct vnt_phy_field b;
-	struct vnt_phy_field a;
-	__le16 duration_ba;
-	__le16 duration_aa;
-	__le16 duration_bb;
-	u16 wReserved;
-	__le16 rts_duration_ba_f0;
-	__le16 rts_duration_aa_f0;
-	__le16 rts_duration_ba_f1;
-	__le16 rts_duration_aa_f1;
-	struct ieee80211_rts data;
-	struct vnt_tx_datahead_g_fb data_head;
-} __packed;
-
 struct vnt_rts_ab {
 	struct vnt_phy_field ab;
 	__le16 duration;
@@ -136,15 +100,6 @@ struct vnt_rts_ab {
 	struct vnt_tx_datahead_ab data_head;
 } __packed;
 
-struct vnt_rts_a_fb {
-	struct vnt_phy_field a;
-	__le16 duration;
-	u16 wReserved;
-	__le16 rts_duration_f0;
-	__le16 rts_duration_f1;
-	struct ieee80211_rts data;
-	struct vnt_tx_datahead_a_fb data_head;
-} __packed;
 
 /* CTS buffer header */
 struct vnt_cts {
@@ -156,29 +111,14 @@ struct vnt_cts {
 	struct vnt_tx_datahead_g data_head;
 } __packed;
 
-struct vnt_cts_fb {
-	struct vnt_phy_field b;
-	__le16 duration_ba;
-	u16 wReserved;
-	__le16 cts_duration_ba_f0;
-	__le16 cts_duration_ba_f1;
-	struct ieee80211_cts data;
-	u16 reserved2;
-	struct vnt_tx_datahead_g_fb data_head;
-} __packed;
-
 union vnt_tx_data_head {
 	/* rts g */
 	struct vnt_rts_g rts_g;
-	struct vnt_rts_g_fb rts_g_fb;
 	/* rts a/b */
 	struct vnt_rts_ab rts_ab;
-	struct vnt_rts_a_fb rts_a_fb;
 	/* cts g */
 	struct vnt_cts cts_g;
-	struct vnt_cts_fb cts_g_fb;
 	/* no rts/cts */
-	struct vnt_tx_datahead_a_fb data_head_a_fb;
 	struct vnt_tx_datahead_ab data_head_ab;
 };
 
-- 
2.25.0

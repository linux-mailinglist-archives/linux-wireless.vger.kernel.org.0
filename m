Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC61D1AFAD8
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2020 15:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgDSNnw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Apr 2020 09:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDSNnw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Apr 2020 09:43:52 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4981C061A0C
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2020 06:43:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h2so7875075wmb.4
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2020 06:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=MKwbrX/1KpYkT/k2Vf/NKxGS/KRj9Qw3IUECal706uA=;
        b=qCmsYHdibMXWQMfMAiAAObGLoykNTCOdD9GpGmYfIm7T8lXK/V7GJyYx2o0WdnASSF
         YOGjD5gJ2gKJRLVWCQwsUs8XQKK+cDUhb8H48VAMirkDzcc6zHb31Wg1iDvr1lLQKqRP
         hx+3xmh41TNOjfr3GkIEGD70NBt2CLRcDW4KdNhwmbv4c2OYQPltcodQMXR9pauNHEJQ
         GKjoSXBRu2HNHkSrpd4V516e/ogz7yQwPJO7HZIkFe7WZP3k9t5JARaanVhTxCpW3zCW
         TUZwyE0So9AsNUG53T5EsRFUJL2qMBHF3hAnrOJkmxJoTxb5MC/RFR8kbSpoNWkdCU4S
         onvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=MKwbrX/1KpYkT/k2Vf/NKxGS/KRj9Qw3IUECal706uA=;
        b=YW5bfPM+Ftw+44RATWo7o8qybG7mZWSKn1UuVIgBh6GTMypUXmtPsVDe7UzXbrP0GX
         5w0XVCyN+Ouz5hPiL9F+sjd5Fk28eSFnmZ5dUer26ZnEcBh1b12WG43XSAIrgG8m7xkQ
         V/MtUzm1gUTx5Xq96Zj30TjUZT7RKNlyYOaH642auh7pLhxF0R3TSSaQpHqI8qv1b3vz
         eTq3SQFkfqy2RoBqErYbSTL0B78cHjmiZzXLNGpfXjrmPAyfCLtpZ616YtZvEKGBqUOk
         7UsmQqAFHN5nkjSrFMsTvn9UCOGjXcEqDSckSKetPanYZNgBB7mv+DcRyIPp2k2lkGIK
         XPiw==
X-Gm-Message-State: AGi0PuaxYnGJGUxyLyYaGGhntVX6SHjj72OXmg1hh6w785zFUJNAwPgE
        uwV7NbFKbV0mA/bsOw5xxBY=
X-Google-Smtp-Source: APiQypJj2uARFr5y3RFEMuy2zPLQdq/b+zfV97pZ0iAhf4k5pjsc33UcUL1yLRuMHcuUayjg+ookfQ==
X-Received: by 2002:a1c:2cc6:: with SMTP id s189mr13923374wms.137.1587303829292;
        Sun, 19 Apr 2020 06:43:49 -0700 (PDT)
Received: from [192.168.43.18] (188.29.165.57.threembb.co.uk. [188.29.165.57])
        by smtp.gmail.com with ESMTPSA id g74sm15770642wme.44.2020.04.19.06.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 06:43:48 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH] staging: vt6656: Move vnt_get_frame_time and
 vnt_get_phy_field to rxtx
Message-ID: <2a4fd665-2fe1-f1ad-1e9a-1b01f698ea79@gmail.com>
Date:   Sun, 19 Apr 2020 14:43:46 +0100
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

These functions are only used by rxtx so move them and their arrays
used with them abbreviating the function description.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/baseband.c | 139 ------------------------------
 drivers/staging/vt6656/baseband.h |  13 ---
 drivers/staging/vt6656/rxtx.c     | 111 ++++++++++++++++++++++++
 drivers/staging/vt6656/rxtx.h     |   7 ++
 4 files changed, 118 insertions(+), 152 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/baseband.c
index d21a9cf0afe5..e7000bba644a 100644
--- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -112,10 +112,6 @@ static u8 vnt_vt3184_vt3226d0[] = {
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00  /* 0xff */
 };
 
-static const u16 vnt_frame_time[MAX_RATE] = {
-	10, 20, 55, 110, 24, 36, 48, 72, 96, 144, 192, 216
-};
-
 struct vnt_threshold {
 	u8 bb_pre_ed_rssi;
 	u8 cr_201;
@@ -196,141 +192,6 @@ static const struct vnt_threshold vt3342_vnt_threshold[] = {
 	{41, 0xff, 0x00}
 };
 
-static const u8 vnt_phy_signal[] = {
-	0x00,	/* RATE_1M  */
-	0x01,	/* RATE_2M  */
-	0x02,	/* RATE_5M  */
-	0x03,	/* RATE_11M */
-	0x8b,	/* RATE_6M  */
-	0x8f,	/* RATE_9M  */
-	0x8a,	/* RATE_12M */
-	0x8e,	/* RATE_18M */
-	0x89,	/* RATE_24M */
-	0x8d,	/* RATE_36M */
-	0x88,	/* RATE_48M */
-	0x8c	/* RATE_54M */
-};
-
-/*
- * Description: Calculate data frame transmitting time
- *
- * Parameters:
- *  In:
- *	preamble_type	- Preamble Type
- *	pkt_type	- PK_TYPE_11A, PK_TYPE_11B, PK_TYPE_11GB, PK_TYPE_11GA
- *	frame_length	- Baseband Type
- *	tx_rate		- Tx Rate
- *  Out:
- *
- * Return Value: FrameTime
- *
- */
-unsigned int vnt_get_frame_time(u8 preamble_type, u8 pkt_type,
-				unsigned int frame_length, u16 tx_rate)
-{
-	unsigned int frame_time;
-	unsigned int preamble;
-	unsigned int rate;
-
-	if (tx_rate > RATE_54M)
-		return 0;
-
-	rate = (unsigned int)vnt_frame_time[tx_rate];
-
-	if (tx_rate <= RATE_11M) {
-		if (preamble_type == PREAMBLE_SHORT)
-			preamble = 96;
-		else
-			preamble = 192;
-
-		frame_time = DIV_ROUND_UP(frame_length * 80, rate);
-		return preamble + frame_time;
-	}
-
-	frame_time = DIV_ROUND_UP(frame_length * 8 + 22, rate);
-	frame_time = frame_time * 4;
-
-	if (pkt_type != PK_TYPE_11A)
-		frame_time += 6;
-	return 20 + frame_time;
-}
-
-/*
- * Description: Calculate Length, Service, and Signal fields of Phy for Tx
- *
- * Parameters:
- *  In:
- *      priv         - Device Structure
- *      frame_length   - Tx Frame Length
- *      tx_rate           - Tx Rate
- *  Out:
- *	struct vnt_phy_field *phy
- *		- pointer to Phy Length field
- *		- pointer to Phy Service field
- *		- pointer to Phy Signal field
- *
- * Return Value: none
- *
- */
-void vnt_get_phy_field(struct vnt_private *priv, u32 frame_length,
-		       u16 tx_rate, u8 pkt_type, struct vnt_phy_field *phy)
-{
-	u32 bit_count;
-	u32 count = 0;
-	u32 tmp;
-	int ext_bit;
-	int i;
-	u8 mask = 0;
-	u8 preamble_type = priv->preamble_type;
-
-	bit_count = frame_length * 8;
-	ext_bit = false;
-
-	switch (tx_rate) {
-	case RATE_1M:
-		count = bit_count;
-		break;
-	case RATE_2M:
-		count = bit_count / 2;
-		break;
-	case RATE_5M:
-		count = DIV_ROUND_UP(bit_count * 10, 55);
-		break;
-	case RATE_11M:
-		count = bit_count / 11;
-		tmp = count * 11;
-
-		if (tmp != bit_count) {
-			count++;
-
-			if ((bit_count - tmp) <= 3)
-				ext_bit = true;
-		}
-
-		break;
-	}
-
-	if (tx_rate > RATE_11M) {
-		if (pkt_type == PK_TYPE_11A)
-			mask = BIT(4);
-	} else if (tx_rate > RATE_1M) {
-		if (preamble_type == PREAMBLE_SHORT)
-			mask = BIT(3);
-	}
-
-	i = tx_rate > RATE_54M ? RATE_54M : tx_rate;
-	phy->signal = vnt_phy_signal[i] | mask;
-	phy->service = 0x00;
-
-	if (pkt_type == PK_TYPE_11B) {
-		if (ext_bit)
-			phy->service |= 0x80;
-		phy->len = cpu_to_le16((u16)count);
-	} else {
-		phy->len = cpu_to_le16((u16)frame_length);
-	}
-}
-
 /*
  * Description: Set Antenna mode
  *
diff --git a/drivers/staging/vt6656/baseband.h b/drivers/staging/vt6656/baseband.h
index dc42aa6ae1d9..ee7325d942fe 100644
--- a/drivers/staging/vt6656/baseband.h
+++ b/drivers/staging/vt6656/baseband.h
@@ -66,19 +66,6 @@
 #define TOP_RATE_2M         0x00200000
 #define TOP_RATE_1M         0x00100000
 
-/* Length, Service, and Signal fields of Phy for Tx */
-struct vnt_phy_field {
-	u8 signal;
-	u8 service;
-	__le16 len;
-} __packed;
-
-unsigned int vnt_get_frame_time(u8 preamble_type, u8 pkt_type,
-				unsigned int frame_length, u16 tx_rate);
-
-void vnt_get_phy_field(struct vnt_private *priv, u32 frame_length,
-		       u16 tx_rate, u8 pkt_type, struct vnt_phy_field *phy);
-
 int vnt_set_short_slot_time(struct vnt_private *priv);
 void vnt_set_vga_gain_offset(struct vnt_private *priv, u8 data);
 int vnt_set_antenna_mode(struct vnt_private *priv, u8 antenna_mode);
diff --git a/drivers/staging/vt6656/rxtx.c b/drivers/staging/vt6656/rxtx.c
index 8363d54cd821..335ef4fd104f 100644
--- a/drivers/staging/vt6656/rxtx.c
+++ b/drivers/staging/vt6656/rxtx.c
@@ -45,6 +45,25 @@ static const u16 vnt_time_stampoff[2][MAX_RATE] = {
 #define DATADUR_B       10
 #define DATADUR_A       11
 
+static const u16 vnt_frame_time[MAX_RATE] = {
+	10, 20, 55, 110, 24, 36, 48, 72, 96, 144, 192, 216
+};
+
+static const u8 vnt_phy_signal[] = {
+	0x00,	/* RATE_1M  */
+	0x01,	/* RATE_2M  */
+	0x02,	/* RATE_5M  */
+	0x03,	/* RATE_11M */
+	0x8b,	/* RATE_6M  */
+	0x8f,	/* RATE_9M  */
+	0x8a,	/* RATE_12M */
+	0x8e,	/* RATE_18M */
+	0x89,	/* RATE_24M */
+	0x8d,	/* RATE_36M */
+	0x88,	/* RATE_48M */
+	0x8c	/* RATE_54M */
+};
+
 static struct vnt_usb_send_context
 	*vnt_get_free_context(struct vnt_private *priv)
 {
@@ -78,6 +97,98 @@ static struct vnt_usb_send_context
 	return NULL;
 }
 
+/* Frame time for Tx */
+static unsigned int vnt_get_frame_time(u8 preamble_type, u8 pkt_type,
+				       unsigned int frame_length, u16 tx_rate)
+{
+	unsigned int frame_time;
+	unsigned int preamble;
+	unsigned int rate;
+
+	if (tx_rate > RATE_54M)
+		return 0;
+
+	rate = (unsigned int)vnt_frame_time[tx_rate];
+
+	if (tx_rate <= RATE_11M) {
+		if (preamble_type == PREAMBLE_SHORT)
+			preamble = 96;
+		else
+			preamble = 192;
+
+		frame_time = DIV_ROUND_UP(frame_length * 80, rate);
+		return preamble + frame_time;
+	}
+
+	frame_time = DIV_ROUND_UP(frame_length * 8 + 22, rate);
+	frame_time = frame_time * 4;
+
+	if (pkt_type != PK_TYPE_11A)
+		frame_time += 6;
+	return 20 + frame_time;
+}
+
+/* Get Length, Service, and Signal fields of Phy for Tx */
+static void vnt_get_phy_field(struct vnt_private *priv, u32 frame_length,
+			      u16 tx_rate, u8 pkt_type,
+			      struct vnt_phy_field *phy)
+{
+	u32 bit_count;
+	u32 count = 0;
+	u32 tmp;
+	int ext_bit;
+	int i;
+	u8 mask = 0;
+	u8 preamble_type = priv->preamble_type;
+
+	bit_count = frame_length * 8;
+	ext_bit = false;
+
+	switch (tx_rate) {
+	case RATE_1M:
+		count = bit_count;
+		break;
+	case RATE_2M:
+		count = bit_count / 2;
+		break;
+	case RATE_5M:
+		count = DIV_ROUND_UP(bit_count * 10, 55);
+		break;
+	case RATE_11M:
+		count = bit_count / 11;
+		tmp = count * 11;
+
+		if (tmp != bit_count) {
+			count++;
+
+			if ((bit_count - tmp) <= 3)
+				ext_bit = true;
+		}
+
+		break;
+	}
+
+	if (tx_rate > RATE_11M) {
+		if (pkt_type == PK_TYPE_11A)
+			mask = BIT(4);
+	} else if (tx_rate > RATE_1M) {
+		if (preamble_type == PREAMBLE_SHORT)
+			mask = BIT(3);
+	}
+
+	i = tx_rate > RATE_54M ? RATE_54M : tx_rate;
+	phy->signal = vnt_phy_signal[i] | mask;
+	phy->service = 0x00;
+
+	if (pkt_type == PK_TYPE_11B) {
+		if (ext_bit)
+			phy->service |= 0x80;
+		phy->len = cpu_to_le16((u16)count);
+	} else {
+		phy->len = cpu_to_le16((u16)frame_length);
+	}
+}
+
 static __le16 vnt_time_stamp_off(struct vnt_private *priv, u16 rate)
 {
 	return cpu_to_le16(vnt_time_stampoff[priv->preamble_type % 2]
diff --git a/drivers/staging/vt6656/rxtx.h b/drivers/staging/vt6656/rxtx.h
index 0e6226af7d41..3c36a4b893dc 100644
--- a/drivers/staging/vt6656/rxtx.h
+++ b/drivers/staging/vt6656/rxtx.h
@@ -23,6 +23,13 @@
 #define DEFAULT_MGN_LIFETIME_RES_64us	125  /* 64us */
 #define DEFAULT_MSDU_LIFETIME_RES_64us  8000
 
+/* Length, Service, and Signal fields of Phy for Tx */
+struct vnt_phy_field {
+	u8 signal;
+	u8 service;
+	__le16 len;
+} __packed;
+
 /* MIC HDR data header */
 struct vnt_mic_hdr {
 	u8 id;
-- 
2.25.1

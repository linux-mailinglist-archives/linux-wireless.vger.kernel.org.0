Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB62C36A264
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Apr 2021 19:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhDXRbG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Apr 2021 13:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhDXRbF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Apr 2021 13:31:05 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9631C061574
        for <linux-wireless@vger.kernel.org>; Sat, 24 Apr 2021 10:30:26 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id r123-20020a378f810000b029028244d5f023so17120176qkd.2
        for <linux-wireless@vger.kernel.org>; Sat, 24 Apr 2021 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b94yWJQ2p+2VWUhlgS+VEXjeZZgECOmKGd3boNqA2Uw=;
        b=WNuboMNUD51JnzaBdj4NZHg20r4lnFheTcHbP1pS7lZNUCk5sOhHJya5uoy4pV+j0B
         96Sed+M3fIZ5lTN4shPNdquZ03boFlnapWSn5tZXL4DdwrPJW5+4g+KedgZd4/3ctV8Q
         tElb/rNhZKoplcYQSbTzeZ2msHdcuATRi/C3OOnURv8uH8PEgmL9CjpMhjz6/PzbDDyo
         PBYKWz2IFnrRGW4EWeufiYW4d9aaWHIkMxq8nAyJiGS5YvyFrzqierFKI7x+Dv3jkiDg
         SUIlM9ArZYq66s3bbQ5542bURaPQS1q8/5L506UD7B6lNP0m5gWGO+hD/WI01HHt70J2
         a7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b94yWJQ2p+2VWUhlgS+VEXjeZZgECOmKGd3boNqA2Uw=;
        b=dJDxCeNVmqvQm8LKpqG55DuI7BlthZTKbPd94z51IKzjgzd/NORqec3arkxh5w8GAP
         uDl6CiosX80Bdf2fsd93uf+Wr+nzjsjlrEdgmQ20GCYYcABVcPVpAdyBGjVop5+AqBhj
         PfIpfGad+LBelg9dMIAa+1jMKzO7++2JhyV9PVYVe/eHS0b6s/Z+lsX8jMJengTXQpj5
         KsDm+cgnq3aKrOmxpu/3dYlMBrWR+Z2FFrbU9ahANv29vQH6TNb5hYDad6hUWHd2KD+8
         d5419LPs+tul+A1CjJQnnjGZI4DPvPghZluQtXitWrtxm14JOMyimTs8n2ubygCNJJ21
         Yxwg==
X-Gm-Message-State: AOAM531tih5kUUedazHdvYc1xkIAeuUhK/kZOc/+5VD3FwWSBNySyh8T
        WAxKVkzy6W/tI95jhzaXmMPvpBjDxIMpHlCHR7iStgCdZgCZWF8Hgr1d0iUcNu3EAPhq86ABocv
        /cgZge4+z27Q0qB9k3CukAy3CLi3MkBcU+aZYjKMs+htwh/VpUDkMjP5i154az7nOEd70QwZHO+
        Y=
X-Google-Smtp-Source: ABdhPJz4v0nSKmWITKUE58jphS03wm2NakSlLefntC0c3E4PJ4I328ExZJkDxRPohNBCDIPx4vqRnslnHIlj
X-Received: from coin.lon.corp.google.com ([2a00:79e0:d:204:fb12:87ba:efda:3935])
 (user=pterjan job=sendgmr) by 2002:ad4:42cf:: with SMTP id
 f15mr9977179qvr.50.1619285425897; Sat, 24 Apr 2021 10:30:25 -0700 (PDT)
Date:   Sat, 24 Apr 2021 18:29:59 +0100
In-Reply-To: <a69a3d60-71a0-3153-b248-dacc8b95bea8@gmail.com>
Message-Id: <20210424172959.1559890-1-pterjan@google.com>
Mime-Version: 1.0
References: <a69a3d60-71a0-3153-b248-dacc8b95bea8@gmail.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v2] rtl8xxxu: Fix device info for RTL8192EU devices
From:   Pascal Terjan <pterjan@google.com>
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <jes.sorensen@gmail.com>,
        Pascal Terjan <pterjan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Based on 2001:3319 and 2357:0109 which I used to test the fix and
0bda:818b and 2357:0108 for which I found efuse dumps online.

== 2357:0109 ==
=== Before ===
Vendor: Realtek
Product: \x03802.11n NI
Serial:
=== After ===
Vendor: Realtek
Product: 802.11n NIC
Serial not available.

== 2001:3319 ==
=== Before ===
Vendor: Realtek
Product: Wireless N
Serial: no USB Adap
=== After ===
Vendor: Realtek
Product: Wireless N Nano USB Adapter
Serial not available.

Signed-off-by: Pascal Terjan <pterjan@google.com>
---
v2: properly check we don't get out of the 80 bytes section and cosmetic fixes

 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  | 11 +---
 .../realtek/rtl8xxxu/rtl8xxxu_8192e.c         | 59 +++++++++++++++++--
 2 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index d6d1be4169e5..acb6b0cd3667 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -853,15 +853,10 @@ struct rtl8192eu_efuse {
 	u8 usb_optional_function;
 	u8 res9[2];
 	u8 mac_addr[ETH_ALEN];		/* 0xd7 */
-	u8 res10[2];
-	u8 vendor_name[7];
-	u8 res11[2];
-	u8 device_name[0x0b];		/* 0xe8 */
-	u8 res12[2];
-	u8 serial[0x0b];		/* 0xf5 */
-	u8 res13[0x30];
+	u8 device_info[80];
+	u8 res11[3];
 	u8 unknown[0x0d];		/* 0x130 */
-	u8 res14[0xc3];
+	u8 res12[0xc3];
 };
 
 struct rtl8xxxu_reg8val {
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index cfe2dfdae928..b06508d0cdf8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -554,9 +554,43 @@ rtl8192e_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
 	}
 }
 
+static void rtl8192eu_log_next_device_info(struct rtl8xxxu_priv *priv,
+					   char *record_name,
+					   char *device_info,
+					   unsigned int *record_offset)
+{
+	char *record = device_info + *record_offset;
+
+	/* A record is [ total length | 0x03 | value ] */
+	unsigned char l = record[0];
+
+	/*
+	 * The whole device info section seems to be 80 characters, make sure
+	 * we don't read further.
+	 */
+	if (*record_offset + l > 80) {
+		dev_warn(&priv->udev->dev,
+			 "invalid record length %d while parsing \"%s\" at offset %u.\n",
+			 l, record_name, *record_offset);
+		return;
+	}
+
+	if (l >= 2) {
+		char value[80];
+
+		memcpy(value, &record[2], l - 2);
+		value[l - 2] = '\0';
+		dev_info(&priv->udev->dev, "%s: %s\n", record_name, value);
+		*record_offset = *record_offset + l;
+	} else {
+		dev_info(&priv->udev->dev, "%s not available.\n", record_name);
+	}
+}
+
 static int rtl8192eu_parse_efuse(struct rtl8xxxu_priv *priv)
 {
 	struct rtl8192eu_efuse *efuse = &priv->efuse_wifi.efuse8192eu;
+	unsigned int record_offset;
 	int i;
 
 	if (efuse->rtl_id != cpu_to_le16(0x8129))
@@ -604,12 +638,25 @@ static int rtl8192eu_parse_efuse(struct rtl8xxxu_priv *priv)
 	priv->has_xtalk = 1;
 	priv->xtalk = priv->efuse_wifi.efuse8192eu.xtal_k & 0x3f;
 
-	dev_info(&priv->udev->dev, "Vendor: %.7s\n", efuse->vendor_name);
-	dev_info(&priv->udev->dev, "Product: %.11s\n", efuse->device_name);
-	if (memchr_inv(efuse->serial, 0xff, 11))
-		dev_info(&priv->udev->dev, "Serial: %.11s\n", efuse->serial);
-	else
-		dev_info(&priv->udev->dev, "Serial not available.\n");
+	/*
+	 * device_info section seems to be laid out as records
+	 * [ total length | 0x03 | value ] so:
+	 * - vendor length + 2
+	 * - 0x03
+	 * - vendor string (not null terminated)
+	 * - product length + 2
+	 * - 0x03
+	 * - product string (not null terminated)
+	 * Then there is one or 2 0x00 on all the 4 devices I own or found
+	 * dumped online.
+	 * As previous version of the code handled an optional serial
+	 * string, I now assume there may be a third record if the
+	 * length is not 0.
+	 */
+	record_offset = 0;
+	rtl8192eu_log_next_device_info(priv, "Vendor", efuse->device_info, &record_offset);
+	rtl8192eu_log_next_device_info(priv, "Product", efuse->device_info, &record_offset);
+	rtl8192eu_log_next_device_info(priv, "Serial", efuse->device_info, &record_offset);
 
 	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_EFUSE) {
 		unsigned char *raw = priv->efuse_wifi.raw;
-- 
2.30.2


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE46734692B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Mar 2021 20:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhCWTge (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Mar 2021 15:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhCWTg0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Mar 2021 15:36:26 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728CEC061763
        for <linux-wireless@vger.kernel.org>; Tue, 23 Mar 2021 12:36:25 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id s14so1863969qtw.20
        for <linux-wireless@vger.kernel.org>; Tue, 23 Mar 2021 12:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=56VTN0FUBRnVBARbqzGdkyXYNoI8u6ilkqebe9VyH9c=;
        b=GUS+CWBcIQkh8I8fr5OKzOYFk+tloF8Q/GWf18p53CrTIht/js1LArNJNrcQ8JkxA2
         F+Fp58EZl/Ce+EnQwG3oOgP1Wz6JuJyY/qt3LEQFqR2aBelPMOimhS4d6QVSmTM75gyw
         +DSaAdwFwC8ec4GdBytwn1uygKvHoienPD4LcEnCF6AJ9YqeLQgWncKkLBuEbATBBfDq
         nXIu73guCAynLC74XYx5iVB6y5nDoU6GIEaQqU9Gvw253sFgMdFnMeg+Jk9XD5srh1Gm
         qV9si7k0wDds3Z/qnypWd2FFbj1rNb0ok+kK/JWkW0zgm0c207YF8MRhCbTViJJ3nLaP
         MRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=56VTN0FUBRnVBARbqzGdkyXYNoI8u6ilkqebe9VyH9c=;
        b=K8s1qhirGjJJ0awnhSLXtSsRMb5V4vZRggXr8UtPiezrZ1fRBGG0xfaljSDiqiEtHw
         RHw161/E+4t0ssRfIBrgv9xVKwwmqXF7UFmTPm3ajMghnnA7tkIblflzDod+zyPfpFBZ
         MYG7Fea4+ePZgqRO+X4BWxMqVfL//2Vuo634kwLt0p3zwb0H+apxuwf03LfrbH7+B7kC
         YnLKcxqyKMPLkqrVqJc9CgtIas2SFxSJm05kQIngswm61WcMaHaGNaxS3PWMQEz/x9H6
         AFRsNYnas5PPNyDOW16ep1iUyprQbshitA/Jmp6DQgx5vszEoFcQ9UXwRLZm3L1CJejQ
         WrFA==
X-Gm-Message-State: AOAM532DFJ6Wn3+pC5qnKA9hNELQLs2jhxnB3XY4jJaGD98hm0zSKaTq
        cTlVQWgB0iQwG9svzDjNTKUpSoWuQVw5
X-Google-Smtp-Source: ABdhPJwISvLmCwG0KFIeJLNbZT26tdkIL0Z/h5xkEggwPo8ZcgN7mlNpSLdcGWggyp+0rX/UMnwFoF3kwIqe
X-Received: from coin.lon.corp.google.com ([2a00:79e0:d:204:cd66:be0a:5c1f:e5d4])
 (user=pterjan job=sendgmr) by 2002:a0c:f505:: with SMTP id
 j5mr6352108qvm.61.1616528184501; Tue, 23 Mar 2021 12:36:24 -0700 (PDT)
Date:   Tue, 23 Mar 2021 19:36:17 +0000
Message-Id: <20210323193617.3748164-1-pterjan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH] rtl8xxxu: Fix device info for RTL8192EU devices
From:   Pascal Terjan <pterjan@google.com>
To:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pascal Terjan <pterjan@google.com>
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
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  | 11 ++--
 .../realtek/rtl8xxxu/rtl8xxxu_8192e.c         | 53 ++++++++++++++++---
 2 files changed, 50 insertions(+), 14 deletions(-)

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
index cfe2dfdae928..9c5fad49ed2a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -554,9 +554,39 @@ rtl8192e_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
 	}
 }
 
+static void rtl8192eu_log_device_info(struct rtl8xxxu_priv *priv,
+				      char *record_name,
+				      char **record)
+{
+	/* A record is [ total length | 0x03 | value ] */
+	unsigned char l = (*record)[0];
+
+	/* The whole section seems to be 80 characters so a record should not
+	 * be able to be that large.
+	 */
+	if (l > 80) {
+		dev_warn(&priv->udev->dev,
+			 "invalid record length %d while parsing \"%s\".\n",
+			 l, record_name);
+		return;
+	}
+
+	if (l >= 2) {
+		char value[80];
+
+		memcpy(value, &(*record)[2], l - 2);
+		value[l - 2] = '\0';
+		dev_info(&priv->udev->dev, "%s: %s\n", record_name, value);
+		*record = *record + l;
+	} else {
+		dev_info(&priv->udev->dev, "%s not available.\n", record_name);
+	}
+}
+
 static int rtl8192eu_parse_efuse(struct rtl8xxxu_priv *priv)
 {
 	struct rtl8192eu_efuse *efuse = &priv->efuse_wifi.efuse8192eu;
+	char *record = efuse->device_info;
 	int i;
 
 	if (efuse->rtl_id != cpu_to_le16(0x8129))
@@ -604,12 +634,23 @@ static int rtl8192eu_parse_efuse(struct rtl8xxxu_priv *priv)
 	priv->has_xtalk = 1;
 	priv->xtalk = priv->efuse_wifi.efuse8192eu.xtal_k & 0x3f;
 
-	dev_info(&priv->udev->dev, "Vendor: %.7s\n", efuse->vendor_name);
-	dev_info(&priv->udev->dev, "Product: %.11s\n", efuse->device_name);
-	if (memchr_inv(efuse->serial, 0xff, 11))
-		dev_info(&priv->udev->dev, "Serial: %.11s\n", efuse->serial);
-	else
-		dev_info(&priv->udev->dev, "Serial not available.\n");
+	/* device_info section seems to be laid out as records
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
+	rtl8192eu_log_device_info(priv, "Vendor", &record);
+	rtl8192eu_log_device_info(priv, "Product", &record);
+	rtl8192eu_log_device_info(priv, "Serial", &record);
 
 	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_EFUSE) {
 		unsigned char *raw = priv->efuse_wifi.raw;
-- 
2.30.2


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D216F1B2C
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 17:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346323AbjD1PJG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 11:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346295AbjD1PIz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 11:08:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4E540F8
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 08:08:52 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682694522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3cHsqTdQpCd9hxCR7NHVGDEoNd4waneQ7NPdz8R4Cw4=;
        b=gLmerbl5sYbLofSdHlz6PfW01TbyyJZAJc5089wgrX50NVzQe15sRF/gvR/HY0BxYakdlf
        pI8yVXxF4DMVgdv/7rHi5W4HlA5qMFJk2+zSFPBev7auTDAJ9kOG0IXQiEgwgMpePPMwDX
        5yrpAjvnf85EzOZ5TskqizBuJ1AAXOKvE8HT6EGVXjDG57uowz95QA0OIKwTxn2/9TCIoE
        WK0t7b5oBvxtAxtRMKfmVC57JRT5O0rsmHbaSOBBMmprUQIasz4iHGngCljnkayDeIocc7
        bjf8rHaHtDvSbF5iysTeksfJaA/cerSO7TJ1GFjym7uCUFkQB7QSH0C+NOxYAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682694522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3cHsqTdQpCd9hxCR7NHVGDEoNd4waneQ7NPdz8R4Cw4=;
        b=6E4mreXASWmPb7qYCzSH4DWoD9cVDO3E0qU9VEJsnsuIwTtueccMvGufIWWCPXs+sedn/F
        jp9o3R1glOu0zQBg==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 18/18] wifi: rtl8xxxu: Set maximum number of supported stations
Date:   Fri, 28 Apr 2023 17:08:33 +0200
Message-Id: <20230428150833.218605-19-martin.kaistra@linutronix.de>
In-Reply-To: <20230428150833.218605-1-martin.kaistra@linutronix.de>
References: <20230428150833.218605-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set maximum number of associated stations supported in AP mode. For
8188f, the maximum number of supported macids is 16, reserve one for
broadcast/multicast frames.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h       | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 296f345784682..2c756640f59d3 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1944,6 +1944,7 @@ struct rtl8xxxu_fileops {
 	u8 ampdu_max_time;
 	u8 ustime_tsf_edca;
 	u8 supports_ap:1;
+	u16 max_macid_num;
 	u32 adda_1t_init;
 	u32 adda_1t_path_on;
 	u32 adda_2t_path_on_a;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 7fd258bf65e36..71b7f0d31bf43 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -1749,6 +1749,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
 	.ampdu_max_time = 0x70,
 	.ustime_tsf_edca = 0x28,
 	.supports_ap = 1,
+	.max_macid_num = 16,
 	.adda_1t_init = 0x03c00014,
 	.adda_1t_path_on = 0x03c00014,
 	.trxff_boundary = 0x3f7f,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 71c715ec5608d..67901b3ee8968 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7532,6 +7532,8 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 
 	hw->wiphy->max_scan_ssids = 1;
 	hw->wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
+	if (priv->fops->max_macid_num)
+		hw->wiphy->max_ap_assoc_sta = priv->fops->max_macid_num - 1;
 	hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION);
 	if (priv->fops->supports_ap)
 		hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_AP);
-- 
2.30.2


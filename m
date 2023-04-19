Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E756E770C
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 12:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjDSKCr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 06:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbjDSKCU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 06:02:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968ABCC1D
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 03:02:18 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681898534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pXI6YItGeAjpmqyGLWVEN/Vuov1z4OsOvqRubSYZUxI=;
        b=jMRIv2sgMJRuf/Ao+8bMc8bZKDUou7otiiskrm7dmSrjdDqRN86MUiaYWTjRSIpjcghFcK
        +i6ylasXGkw1lwbe5nOR9qHj1sK8fH2nVpF5stAKkW8WNZOt/RbCoRv3ZdjahlqJNoY/KZ
        tkEiLgGIUGvuH7mtGTVsrvxlUnLEIxQa0Q/7ZV/knvwhx22qHZViG8k+HE//OjTm80doqW
        NAv6lU4MD7nXupr8nXFE9q7Q3bi0qAEodbU3P//hwMW1gnPu8DQMg9ulTGtnFp9SvDRp4W
        TSIRai38H/4pUpPXWiiTk3sRwzi91MU22RUlGh69YHoguhwWKCuZy0RtYikJPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681898534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pXI6YItGeAjpmqyGLWVEN/Vuov1z4OsOvqRubSYZUxI=;
        b=5q6aml4JnQuvi5SQCJAT0Ncl0QJBfG7l/a+u11OjMBX5ODfCqIkffnO2/6gXN3GuR+mWyz
        Q0iskbstHMQL9LCA==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 18/18] wifi: rtl8xxxu: Set maximum number of supported stations
Date:   Wed, 19 Apr 2023 12:01:45 +0200
Message-Id: <20230419100145.159191-19-martin.kaistra@linutronix.de>
In-Reply-To: <20230419100145.159191-1-martin.kaistra@linutronix.de>
References: <20230419100145.159191-1-martin.kaistra@linutronix.de>
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
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h       | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 64e823f216967..e996168d0bfd1 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1946,6 +1946,7 @@ struct rtl8xxxu_fileops {
 	u8 ampdu_max_time;
 	u8 ustime_tsf_edca;
 	u8 supports_ap:1;
+	u16 max_sta_num;
 	u32 adda_1t_init;
 	u32 adda_1t_path_on;
 	u32 adda_2t_path_on_a;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 7dc2fd8aa5317..085721c734ae2 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -1752,6 +1752,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
 	.ampdu_max_time = 0x70,
 	.ustime_tsf_edca = 0x28,
 	.supports_ap = 1,
+	.max_sta_num = 16,
 	.adda_1t_init = 0x03c00014,
 	.adda_1t_path_on = 0x03c00014,
 	.trxff_boundary = 0x3f7f,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index bf471c3f98b86..6d0c775244274 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7464,6 +7464,8 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 
 	hw->wiphy->max_scan_ssids = 1;
 	hw->wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
+	if (priv->fops->max_sta_num)
+		hw->wiphy->max_ap_assoc_sta = priv->fops->max_sta_num - 1;
 	hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION);
 	if (priv->fops->supports_ap)
 		hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_AP);
-- 
2.30.2


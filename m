Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38E46E7712
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 12:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjDSKCs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 06:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjDSKCU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 06:02:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99714D331
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 03:02:18 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681898534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69WL1itCQ1I5JUrgS5XfICw/J+GFoSpRGmZlkli1sIE=;
        b=futpHay2wAZo8F4iczHIjsO7OEe4ffcI5oJFMwKWJ7McaBmMSKTAEwrmvVz1ppMN4P94ul
        Bib3NvVj5Pu0ZqnfZ72lKXWm3KpJMHgzTwu+RUM5pk1BqM34NTtBGuKrzszPaIz3mQI6Jt
        xvItqLir574Qg1VMKredU5eVy2k74ur986HlWchflN5YMGrkDv1msKdGQiNVJgNtuggE3w
        NAR+J4ViIFZNcKN1U4iTM4kouvsz/QMaqRZFI9FFbj6Nsbry5oCSmSKlIVH3SZLtWw952x
        zx1fTgOdRf8Z2n6NCQ/SIUcVLIQaX7LhDh+oQdfHSzh28z6SKAQ+3utxydSVhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681898534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69WL1itCQ1I5JUrgS5XfICw/J+GFoSpRGmZlkli1sIE=;
        b=l7xTFxHg6zUUnZCSmdR1JgNrdZHkPX304/+sfCe663uZxrWaHD8zmhq7UhFcKGcn021xvn
        z9WVvpakLaYA5/Dw==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 17/18] wifi: rtl8xxxu: Declare AP mode support for 8188f
Date:   Wed, 19 Apr 2023 12:01:44 +0200
Message-Id: <20230419100145.159191-18-martin.kaistra@linutronix.de>
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

Everything is in place now for AP mode, we can tell the system that we
support it. Put the feature behind a flag in priv->fops, because it is
not (yet) implemented for all chips.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h       | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 0610ab57f132d..64e823f216967 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1945,6 +1945,7 @@ struct rtl8xxxu_fileops {
 	u8 init_reg_hmtfr:1;
 	u8 ampdu_max_time;
 	u8 ustime_tsf_edca;
+	u8 supports_ap:1;
 	u32 adda_1t_init;
 	u32 adda_1t_path_on;
 	u32 adda_2t_path_on_a;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index dfb250adb1689..7dc2fd8aa5317 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -1751,6 +1751,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
 	.init_reg_hmtfr = 1,
 	.ampdu_max_time = 0x70,
 	.ustime_tsf_edca = 0x28,
+	.supports_ap = 1,
 	.adda_1t_init = 0x03c00014,
 	.adda_1t_path_on = 0x03c00014,
 	.trxff_boundary = 0x3f7f,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 7ff6f4e6a0ff5..bf471c3f98b86 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7465,6 +7465,8 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	hw->wiphy->max_scan_ssids = 1;
 	hw->wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
 	hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION);
+	if (priv->fops->supports_ap)
+		hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_AP);
 	hw->queues = 4;
 
 	sband = &rtl8xxxu_supported_band;
-- 
2.30.2


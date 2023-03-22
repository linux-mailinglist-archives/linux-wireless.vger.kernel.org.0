Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A816C524E
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 18:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjCVRUn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 13:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjCVRUc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 13:20:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41196507D
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 10:20:10 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679505554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RGylFTNJtT0bETsehxiKmLaUhY8rEh6ifrpDi9gt9jI=;
        b=kndBYfXlLwGT7tzLmokNgJv/1FsOJDBGybdf2h81shTyNheKdfWjXZ0s6CFFLIvdehCz7v
        umKFlzWaYIqM6MLgQi2rXbISsCSOFfALf2p2pI5aFAwCj+ywawghdn/OwVq4Rg2t535lUb
        KdxJbQGJohti/JqmK3yabUZ1CaUkoT+wAk1TZPlHREm2V9mp1zYUGGE/UYVPftZe6cOBDc
        x+bxvnelRpQXg5MMooROS/UVfpeg3cLO/umENKknkN4rYph+Sv5404vy/7ocSyDj4uL0sc
        OCLBSYuGpmP672DcjnDsu9/KALqnhgAasXqufbHletN0oMCm4H+6+vs06DAf4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679505554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RGylFTNJtT0bETsehxiKmLaUhY8rEh6ifrpDi9gt9jI=;
        b=sDb2gxObZ/kyvRe7l3xbs2BF6dPclKInMRSmtsyT0duF88L6JW4PhQjx5T/6fBbfpRLSiM
        zbE7OgwcA41sfJBA==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 14/14] wifi: rtl8xxxu: Declare AP mode support for 8188f
Date:   Wed, 22 Mar 2023 18:19:05 +0100
Message-Id: <20230322171905.492855-15-martin.kaistra@linutronix.de>
In-Reply-To: <20230322171905.492855-1-martin.kaistra@linutronix.de>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Everything is in place now for AP mode, we can tell the system that we
support it. Put the feature behind a flag in priv->fops, because it is
not (yet) implemented for all chips.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h       | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c | 1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 20304b0bd68a3..31f9cf9e558d7 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1930,6 +1930,7 @@ struct rtl8xxxu_fileops {
 	u8 has_tx_report:1;
 	u8 gen2_thermal_meter:1;
 	u8 needs_full_init:1;
+	u8 supports_ap:1;
 	u32 adda_1t_init;
 	u32 adda_1t_path_on;
 	u32 adda_2t_path_on_a;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 82dee1fed4779..c4c1f015a7fd9 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -1746,6 +1746,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
 	.has_tx_report = 1,
 	.gen2_thermal_meter = 1,
 	.needs_full_init = 1,
+	.supports_ap = 1,
 	.adda_1t_init = 0x03c00014,
 	.adda_1t_path_on = 0x03c00014,
 	.trxff_boundary = 0x3f7f,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index b6f811ad01333..31bd1f2711aed 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7449,6 +7449,8 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	hw->wiphy->max_scan_ssids = 1;
 	hw->wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
 	hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION);
+	if (priv->fops->supports_ap)
+		hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_AP);
 	hw->queues = 4;
 
 	sband = &rtl8xxxu_supported_band;
-- 
2.30.2


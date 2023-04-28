Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C118B6F1B24
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 17:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346304AbjD1PI7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 11:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346254AbjD1PIw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 11:08:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D5F2D49
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 08:08:50 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682694520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7ydoO2FP9o7s63ZPX+7hdFjNrR7f2L2SAnHsILX0RU=;
        b=liSFy4W39xrS7VDK4l124+XHmomvc4azGVpW8xVXtVlqJYeONJzeY+V2MMQ13G65MZz5Q+
        iC6TIfk/Qo5XSx45rmRgxS9hjMREiRFgIcG+EkJE+dAKEugwc4pM6hrHjobG72IyWdADGh
        Pn7OegeFciDtB/rVhjBBPZgDfwHYHHcVAI9AXduu+7gaWlpRyf82VuSlRHNj+AGsULBQWq
        7fiIBUEUVYOOFvAMdyrf0rweUCfEO3o5yDiRCFR7JMLWZSNZByLl4b0hYU/AdfbPEgodoP
        geSbjyPJXcjonebwSqYioYLaPpGUW/gkrXIbHTq183/UteN9dkAEyaYKFAhi5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682694520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7ydoO2FP9o7s63ZPX+7hdFjNrR7f2L2SAnHsILX0RU=;
        b=3fdCkT8IwB4CBAt5fqkMQnk6RJNEWBpT8veBK0tYyngT8GbymHdxRLQ+ua6twjIu1Fxu0e
        1T5iT2exWLcHFcBg==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 10/18] wifi: rtl8xxxu: Add sta_add() and sta_remove() callbacks
Date:   Fri, 28 Apr 2023 17:08:25 +0200
Message-Id: <20230428150833.218605-11-martin.kaistra@linutronix.de>
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

In AP mode, sta_add() gets called when a new STA gets associated to
us. Call rtl8xxxu_refresh_rate_mask() to set a rate mask for the newly
connected STA (referenced by the macid) and then send a media connnect
report. Ignore the call to sta_add() in station mode.

Reserve one macid for broadcast/multicast packets in init.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  9 ++++
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 52 +++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 2dc9b205f08c0..a918d1283d1e6 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1730,6 +1730,7 @@ struct rtl8xxxu_cfo_tracking {
 };
 
 #define RTL8XXXU_HW_LED_CONTROL	2
+#define RTL8XXXU_MAX_MAC_ID_NUM	128
 #define RTL8XXXU_BC_MC_MACID	0
 
 struct rtl8xxxu_priv {
@@ -1863,6 +1864,14 @@ struct rtl8xxxu_priv {
 	bool led_registered;
 	char led_name[32];
 	struct led_classdev led_cdev;
+	DECLARE_BITMAP(mac_id_map, RTL8XXXU_MAX_MAC_ID_NUM);
+};
+
+struct rtl8xxxu_sta_info {
+	struct ieee80211_sta *sta;
+	struct ieee80211_vif *vif;
+
+	u8 macid;
 };
 
 struct rtl8xxxu_rx_urb {
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index a3ca6ea9b2d66..dd678f2803894 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -3977,6 +3977,22 @@ void rtl8xxxu_init_burst(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_write8(priv, REG_RSV_CTRL, val8);
 }
 
+static u8 rtl8xxxu_acquire_macid(struct rtl8xxxu_priv *priv)
+{
+	u8 macid;
+
+	macid = find_first_zero_bit(priv->mac_id_map, RTL8XXXU_MAX_MAC_ID_NUM);
+	if (macid < RTL8XXXU_MAX_MAC_ID_NUM)
+		set_bit(macid, priv->mac_id_map);
+
+	return macid;
+}
+
+static void rtl8xxxu_release_macid(struct rtl8xxxu_priv *priv, u8 macid)
+{
+	clear_bit(macid, priv->mac_id_map);
+}
+
 static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
@@ -4446,6 +4462,8 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	if (priv->rtl_chip == RTL8188E)
 		rtl8188e_ra_info_init_all(&priv->ra_info);
 
+	set_bit(RTL8XXXU_BC_MC_MACID, priv->mac_id_map);
+
 exit:
 	return ret;
 }
@@ -7212,6 +7230,38 @@ static void rtl8xxxu_stop(struct ieee80211_hw *hw)
 	rtl8xxxu_free_tx_resources(priv);
 }
 
+static int rtl8xxxu_sta_add(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta)
+{
+	struct rtl8xxxu_sta_info *sta_info = (struct rtl8xxxu_sta_info *)sta->drv_priv;
+	struct rtl8xxxu_priv *priv = hw->priv;
+
+	if (vif->type == NL80211_IFTYPE_AP) {
+		sta_info->macid = rtl8xxxu_acquire_macid(priv);
+		if (sta_info->macid >= RTL8XXXU_MAX_MAC_ID_NUM)
+			return -ENOSPC;
+
+		rtl8xxxu_refresh_rate_mask(priv, 0, sta, true);
+		priv->fops->report_connect(priv, sta_info->macid, H2C_MACID_ROLE_STA, true);
+	}
+
+	return 0;
+}
+
+static int rtl8xxxu_sta_remove(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       struct ieee80211_sta *sta)
+{
+	struct rtl8xxxu_sta_info *sta_info = (struct rtl8xxxu_sta_info *)sta->drv_priv;
+	struct rtl8xxxu_priv *priv = hw->priv;
+
+	if (vif->type == NL80211_IFTYPE_AP)
+		rtl8xxxu_release_macid(priv, sta_info->macid);
+
+	return 0;
+}
+
 static const struct ieee80211_ops rtl8xxxu_ops = {
 	.tx = rtl8xxxu_tx,
 	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
@@ -7232,6 +7282,8 @@ static const struct ieee80211_ops rtl8xxxu_ops = {
 	.sta_statistics = rtl8xxxu_sta_statistics,
 	.get_antenna = rtl8xxxu_get_antenna,
 	.set_tim = rtl8xxxu_set_tim,
+	.sta_add = rtl8xxxu_sta_add,
+	.sta_remove = rtl8xxxu_sta_remove,
 };
 
 static int rtl8xxxu_parse_usb(struct rtl8xxxu_priv *priv,
-- 
2.30.2


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099806E7709
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 12:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjDSKCg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 06:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjDSKCT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 06:02:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52484AF1B
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 03:02:16 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681898532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=My9QeWa6mkmIb2LYAsD17Nob6Ldxg2QXzEouAXCqdpo=;
        b=0GkKGRI8pIE2r/uwjXa65y3nQDjzrh9kcGeCA2C4AD6CHTrO+X9pwuFWaaJ8Vu6KoLAsOp
        RwSEa5vPTl2EHDGJR9pUVMIaglelhKqkCgcZfGmKOMaRGHPVKA+FuRm4YKp5qjtBcc87hJ
        LQ9Jg/zSIyzcq3/RquQ8Spp5+jcGOgjE5nrtW4cibia/JnW95r4EIoLk+pkdIEPpJbWCeb
        063nSm0FbCBR0IIBVKqGs3FnRn23Kei/xWmreu/Ql/Ttg7ya+UpZGoMME8RnbykJWWnVhS
        rQ8mgOSKk3FVTTZX+mxYYKVADcjm/p9843FsDPH3LaTRb2t8WqD2Zacs4wJmrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681898532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=My9QeWa6mkmIb2LYAsD17Nob6Ldxg2QXzEouAXCqdpo=;
        b=5oSnphJ/eJI5Zq/yGc3df6f7OiwPGvQPXCkspL+joW7zhtjovt30HPyV6S4HH5NW1a/GoI
        NOJT0MBLbTxEviAw==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 10/18] wifi: rtl8xxxu: Add sta_add() and sta_remove() callbacks
Date:   Wed, 19 Apr 2023 12:01:37 +0200
Message-Id: <20230419100145.159191-11-martin.kaistra@linutronix.de>
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

In AP mode, sta_add() gets called when a new STA gets associated to
us. Call rtl8xxxu_refresh_rate_mask() to set a rate mask for the newly
connected STA (referenced by the macid) and then send a media connnect
report. Ignore the call to sta_add() in station mode.

Reserve one macid for broadcast/multicast packets in init.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  9 ++++
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 52 +++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 93091068b3fd2..fb8ba97566c23 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1730,6 +1730,7 @@ struct rtl8xxxu_cfo_tracking {
 };
 
 #define RTL8XXXU_HW_LED_CONTROL	2
+#define RTL8XXXU_MAX_MAC_ID_NUM	128
 #define RTL8XXXU_BC_MC_MACID	0
 
 struct rtl8xxxu_priv {
@@ -1865,6 +1866,14 @@ struct rtl8xxxu_priv {
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
index 19e115d10493a..d0c7d3a191f1a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -3902,6 +3902,22 @@ void rtl8xxxu_init_burst(struct rtl8xxxu_priv *priv)
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
@@ -4371,6 +4387,8 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	if (priv->rtl_chip == RTL8188E)
 		rtl8188e_ra_info_init_all(&priv->ra_info);
 
+	set_bit(RTL8XXXU_BC_MC_MACID, priv->mac_id_map);
+
 exit:
 	return ret;
 }
@@ -7144,6 +7162,38 @@ static void rtl8xxxu_stop(struct ieee80211_hw *hw)
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
@@ -7164,6 +7214,8 @@ static const struct ieee80211_ops rtl8xxxu_ops = {
 	.sta_statistics = rtl8xxxu_sta_statistics,
 	.get_antenna = rtl8xxxu_get_antenna,
 	.set_tim = rtl8xxxu_set_tim,
+	.sta_add = rtl8xxxu_sta_add,
+	.sta_remove = rtl8xxxu_sta_remove,
 };
 
 static int rtl8xxxu_parse_usb(struct rtl8xxxu_priv *priv,
-- 
2.30.2


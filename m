Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43936F031C
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 11:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243343AbjD0JKX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 05:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243385AbjD0JJz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 05:09:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B422119
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 02:09:52 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682586586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MCt2LU/pB6Fwcbwcn3hw9Cg/iz4Jr5DQg3zgVMsIX2k=;
        b=4UhaNKYO6s7aKWduOvVKB5BuKSsWVdu/MVCbo0x77RFjPq2SUIrEQScv5yto9iMSCXvv9I
        FZZ9gUqYZakzfmOd81XdZvEQMPl+d/pj+bfSb+ICrA8lwZEFunrzwosb8nAV2ehTKBKQEz
        fedGwCZumXmUuFAFmtBXEChr40oEp46pvEebuxOd/J7OGTb2FCgFyHx06v9Mb21jPj84m3
        jEBwNXvY5KKl/uFbgdy4lgN+2l9/IjBwO9VowdG3SHqvjPvAZ0K4RFuh3CRgcD6tB/itH5
        lS067nI4hA/z9bJocLo4SC/zdyjxDytGQgSj1X0II4WboBywcLZPpVPQoSnKQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682586586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MCt2LU/pB6Fwcbwcn3hw9Cg/iz4Jr5DQg3zgVMsIX2k=;
        b=pzntuSm7P9cjWwQf22u+wEWZ6pX9lbrZMS/nRXHGKBTBIC9amlbP674a1PkByyPSGwDjKf
        XRubDdLBDVQlJ5BA==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 10/18] wifi: rtl8xxxu: Add sta_add() and sta_remove() callbacks
Date:   Thu, 27 Apr 2023 11:09:14 +0200
Message-Id: <20230427090922.165088-11-martin.kaistra@linutronix.de>
In-Reply-To: <20230427090922.165088-1-martin.kaistra@linutronix.de>
References: <20230427090922.165088-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index bb3b4753d279c..4efa3833098b5 100644
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
@@ -7211,6 +7229,38 @@ static void rtl8xxxu_stop(struct ieee80211_hw *hw)
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
@@ -7231,6 +7281,8 @@ static const struct ieee80211_ops rtl8xxxu_ops = {
 	.sta_statistics = rtl8xxxu_sta_statistics,
 	.get_antenna = rtl8xxxu_get_antenna,
 	.set_tim = rtl8xxxu_set_tim,
+	.sta_add = rtl8xxxu_sta_add,
+	.sta_remove = rtl8xxxu_sta_remove,
 };
 
 static int rtl8xxxu_parse_usb(struct rtl8xxxu_priv *priv,
-- 
2.30.2


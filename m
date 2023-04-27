Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DA26F0316
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 11:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243300AbjD0JKL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 05:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243374AbjD0JJy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 05:09:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D2E1FCE
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 02:09:52 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682586585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OT3lYd7tnDIywUkFnZblBZMqjee9vTYaQEIggPby7fQ=;
        b=HYKutk8eH6cAPNiMoNlHd0SI35vmIyPa2B5KYo4xu9N3PvKGdfWbkygX2jmU+X0EJa5CUp
        13JNF334fIJtQGBfRkUl1wTNOSuNvMrkr/iFOBq5uIlBFjOaDvvJ1RbzMr44I6Rf6LNp79
        1JizSpfct5HxI+AVCyq0q/k6+nkdmBDWM5CDQ6h7ZynkrVrvifvaIddQBJvH7L5Gf0hSoU
        s2I+9vuvf+9o53uWWdiOFtY261AuYe1idOaM2OYHTltZb9wYBZctEhoYLF3tZMz+8O42yS
        vHrHk/j7yM/5CE0DG3O0PvHmLjS88eCgLlD3ng1hza23wbbfi+L/2oRDrrJ4Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682586585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OT3lYd7tnDIywUkFnZblBZMqjee9vTYaQEIggPby7fQ=;
        b=O3eBXNy1phx95W1qTAkOtP8oowjmNQsfFqgbV8+0XuFkrtvxCrz8HgxPmV9YQ941JgHGv4
        CR7AWN++1/oBvaCg==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 08/18] wifi: rtl8xxxu: Add parameter role to report_connect
Date:   Thu, 27 Apr 2023 11:09:12 +0200
Message-Id: <20230427090922.165088-9-martin.kaistra@linutronix.de>
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

This allows to tell the HW if a connection is made to a STA or an AP.
Add the implementation for the gen2 version.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h      |  9 ++++++---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 11 ++++++-----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 971f1cc38d323..2dc9b205f08c0 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1280,6 +1280,9 @@ struct rtl8xxxu_rfregs {
 #define  H2C_JOIN_BSS_DISCONNECT	0
 #define  H2C_JOIN_BSS_CONNECT		1
 
+#define H2C_MACID_ROLE_STA		1
+#define H2C_MACID_ROLE_AP		2
+
 /*
  * H2C (firmware) commands differ between the older generation chips
  * 8188[cr]u, 819[12]cu, and 8723au, and the more recent chips 8723bu,
@@ -1906,7 +1909,7 @@ struct rtl8xxxu_fileops {
 	void (*update_rate_mask) (struct rtl8xxxu_priv *priv,
 				  u32 ramask, u8 rateid, int sgi, int txbw_40mhz);
 	void (*report_connect) (struct rtl8xxxu_priv *priv,
-				u8 macid, bool connect);
+				u8 macid, u8 role, bool connect);
 	void (*report_rssi) (struct rtl8xxxu_priv *priv, u8 macid, u8 rssi);
 	void (*fill_txdesc) (struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 			     struct ieee80211_tx_info *tx_info,
@@ -2027,9 +2030,9 @@ void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
 void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
 				    u32 ramask, u8 rateid, int sgi, int txbw_40mhz);
 void rtl8xxxu_gen1_report_connect(struct rtl8xxxu_priv *priv,
-				  u8 macid, bool connect);
+				  u8 macid, u8 role, bool connect);
 void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
-				  u8 macid, bool connect);
+				  u8 macid, u8 role, bool connect);
 void rtl8xxxu_gen1_report_rssi(struct rtl8xxxu_priv *priv, u8 macid, u8 rssi);
 void rtl8xxxu_gen2_report_rssi(struct rtl8xxxu_priv *priv, u8 macid, u8 rssi);
 void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv);
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 10f2e18abb49a..2101d107b7d50 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4586,7 +4586,7 @@ void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
 }
 
 void rtl8xxxu_gen1_report_connect(struct rtl8xxxu_priv *priv,
-				  u8 macid, bool connect)
+				  u8 macid, u8 role, bool connect)
 {
 	struct h2c_cmd h2c;
 
@@ -4603,7 +4603,7 @@ void rtl8xxxu_gen1_report_connect(struct rtl8xxxu_priv *priv,
 }
 
 void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
-				  u8 macid, bool connect)
+				  u8 macid, u8 role, bool connect)
 {
 	/*
 	 * The firmware turns on the rate control when it knows it's
@@ -4619,6 +4619,7 @@ void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
 	else
 		h2c.media_status_rpt.parm &= ~BIT(0);
 
+	h2c.media_status_rpt.parm |= ((role << 4) & 0xf0);
 	h2c.media_status_rpt.macid = macid;
 
 	rtl8xxxu_gen2_h2c_cmd(priv, &h2c, sizeof(h2c.media_status_rpt));
@@ -4947,13 +4948,13 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			rtl8xxxu_write16(priv, REG_BCN_PSR_RPT,
 					 0xc000 | vif->cfg.aid);
 
-			priv->fops->report_connect(priv, 0, true);
+			priv->fops->report_connect(priv, 0, H2C_MACID_ROLE_AP, true);
 		} else {
 			val8 = rtl8xxxu_read8(priv, REG_BEACON_CTRL);
 			val8 |= BEACON_DISABLE_TSF_UPDATE;
 			rtl8xxxu_write8(priv, REG_BEACON_CTRL, val8);
 
-			priv->fops->report_connect(priv, 0, false);
+			priv->fops->report_connect(priv, 0, H2C_MACID_ROLE_AP, false);
 		}
 	}
 
@@ -5013,7 +5014,7 @@ static int rtl8xxxu_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	dev_dbg(dev, "Start AP mode\n");
 	rtl8xxxu_set_bssid(priv, vif->bss_conf.bssid);
 	rtl8xxxu_write16(priv, REG_BCN_INTERVAL, vif->bss_conf.beacon_int);
-	priv->fops->report_connect(priv, RTL8XXXU_BC_MC_MACID, true);
+	priv->fops->report_connect(priv, RTL8XXXU_BC_MC_MACID, 0, true);
 
 	return 0;
 }
-- 
2.30.2


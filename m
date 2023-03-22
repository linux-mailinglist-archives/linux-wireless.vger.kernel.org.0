Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAE66C5246
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 18:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCVRUX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 13:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjCVRUG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 13:20:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A55B67022
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 10:19:46 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679505552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aeS9vlbHyT8DbCb7vWiRgAvpaMSN6h0jgkXHTPTSBXY=;
        b=ej8nsCbxWZWJeViqH2uudvCDuguPwrfKmRHYp7YrE7c3CEmlp9F0aggZqPgk6/SnIn+9Rt
        weSRf29owOOOaO2vuBnHwaht2Rq5jX5jOiQYbXpq/sfkWRqcoKBHYWYw6pPxk1sCJUOfjc
        ta4Oud2LuzRP1kRtZK9jk2neow7etEfBWwuq1DzqhuJzEmhAOFgQHIc2atm2OTAxAc8HKW
        YmpEWp7r75VX8hhtKixefOmeT7eyQjMTrB8DUUkajHecrbs6JeAlKRqfOQI7FJv8dn7eFg
        txCv/8AEXeYdzL3aOcgB8MDYjlqbSngKaZHo50LjMNqO5qiaLtcDx/ntyzK3mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679505552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aeS9vlbHyT8DbCb7vWiRgAvpaMSN6h0jgkXHTPTSBXY=;
        b=02XDW92GM0XzNmDmj2KGUd2VZnffGV1D4OLaAlX1wz3UcR/LDSaZDAwk9qUGoL0O+oneTq
        1NXogQA312yOOBDA==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 07/14] wifi: rtl8xxxu: Add parameter macid to update_rate_mask
Date:   Wed, 22 Mar 2023 18:18:58 +0100
Message-Id: <20230322171905.492855-8-martin.kaistra@linutronix.de>
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

The HW maintains a rate_mask for each connection, referenced by the
macid. Add a parameter to update_rate_mask and add the macid to the
h2c call in the gen2 implementation.

Also extend refresh_rate_mask to generate the macid in AP mode from
sta->aid.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h    |  7 ++++---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c  |  3 ++-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c   | 17 +++++++++++++----
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index cac985271628c..c06ad33645974 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1905,7 +1905,8 @@ struct rtl8xxxu_fileops {
 	void (*set_tx_power) (struct rtl8xxxu_priv *priv, int channel,
 			      bool ht40);
 	void (*update_rate_mask) (struct rtl8xxxu_priv *priv,
-				  u32 ramask, u8 rateid, int sgi, int txbw_40mhz);
+				  u32 ramask, u8 rateid, int sgi, int txbw_40mhz,
+				  u8 macid);
 	void (*report_connect) (struct rtl8xxxu_priv *priv,
 				u8 macid, bool connect);
 	void (*report_rssi) (struct rtl8xxxu_priv *priv, u8 macid, u8 rssi);
@@ -2007,9 +2008,9 @@ void rtl8xxxu_gen2_config_channel(struct ieee80211_hw *hw);
 void rtl8xxxu_gen1_usb_quirks(struct rtl8xxxu_priv *priv);
 void rtl8xxxu_gen2_usb_quirks(struct rtl8xxxu_priv *priv);
 void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
-			       u32 ramask, u8 rateid, int sgi, int txbw_40mhz);
+			       u32 ramask, u8 rateid, int sgi, int txbw_40mhz, u8 macid);
 void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
-				    u32 ramask, u8 rateid, int sgi, int txbw_40mhz);
+				    u32 ramask, u8 rateid, int sgi, int txbw_40mhz, u8 macid);
 void rtl8xxxu_gen1_report_connect(struct rtl8xxxu_priv *priv,
 				  u8 macid, bool connect);
 void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
index 6a82ec47568ee..c3dc5130c9f37 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
@@ -1798,7 +1798,8 @@ static void rtl8188e_arfb_refresh(struct rtl8xxxu_ra_info *ra)
 
 static void
 rtl8188e_update_rate_mask(struct rtl8xxxu_priv *priv,
-			  u32 ramask, u8 rateid, int sgi, int txbw_40mhz)
+			  u32 ramask, u8 rateid, int sgi, int txbw_40mhz,
+			  u8 macid)
 {
 	struct rtl8xxxu_ra_info *ra = &priv->ra_info;
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index b20ff8bc40870..b5cb15e472f1c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4471,7 +4471,8 @@ static void rtl8xxxu_sw_scan_complete(struct ieee80211_hw *hw,
 }
 
 void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
-			       u32 ramask, u8 rateid, int sgi, int txbw_40mhz)
+			       u32 ramask, u8 rateid, int sgi, int txbw_40mhz,
+			       u8 macid)
 {
 	struct h2c_cmd h2c;
 
@@ -4491,7 +4492,8 @@ void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
 }
 
 void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
-				    u32 ramask, u8 rateid, int sgi, int txbw_40mhz)
+				    u32 ramask, u8 rateid, int sgi, int txbw_40mhz,
+				    u8 macid)
 {
 	struct h2c_cmd h2c;
 	u8 bw;
@@ -4508,6 +4510,7 @@ void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
 	h2c.b_macid_cfg.ramask1 = (ramask >> 8) & 0xff;
 	h2c.b_macid_cfg.ramask2 = (ramask >> 16) & 0xff;
 	h2c.b_macid_cfg.ramask3 = (ramask >> 24) & 0xff;
+	h2c.b_macid_cfg.macid = macid;
 
 	h2c.b_macid_cfg.data1 = rateid;
 	if (sgi)
@@ -4870,7 +4873,8 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			priv->vif = vif;
 			priv->rssi_level = RTL8XXXU_RATR_STA_INIT;
 
-			priv->fops->update_rate_mask(priv, ramask, 0, sgi, bw == RATE_INFO_BW_40);
+			priv->fops->update_rate_mask(priv, ramask, 0, sgi,
+						     bw == RATE_INFO_BW_40, 0);
 
 			rtl8xxxu_write8(priv, REG_BCN_MAX_ERR, 0xff);
 
@@ -6772,6 +6776,7 @@ static void rtl8xxxu_refresh_rate_mask(struct rtl8xxxu_priv *priv,
 	u8 txbw_40mhz;
 	u8 snr, snr_thresh_high, snr_thresh_low;
 	u8 go_up_gap = 5;
+	u8 macid = 0;
 
 	rssi_level = priv->rssi_level;
 	snr = rtl8xxxu_signal_to_snr(signal);
@@ -6891,7 +6896,11 @@ static void rtl8xxxu_refresh_rate_mask(struct rtl8xxxu_priv *priv,
 		}
 
 		priv->rssi_level = rssi_level;
-		priv->fops->update_rate_mask(priv, rate_bitmap, ratr_idx, sgi, txbw_40mhz);
+
+		if (priv->vif->type == NL80211_IFTYPE_AP)
+			macid = sta->aid + 1;
+
+		priv->fops->update_rate_mask(priv, rate_bitmap, ratr_idx, sgi, txbw_40mhz, macid);
 	}
 }
 
-- 
2.30.2


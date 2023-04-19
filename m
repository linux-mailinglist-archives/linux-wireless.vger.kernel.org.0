Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFEE6E770B
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 12:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjDSKCj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 06:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjDSKCT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 06:02:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519DD9762
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 03:02:16 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681898533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xKa4qBEBRkgD2unjSYzaKjlkInBCJIWK/vpwH3yGfVA=;
        b=a13LzkcIK3f3FMRytl10bLwL7HjydCz1CuXp6LUyogok8bZ05ai2pCbO7BnpMUx6To2lK2
        Q51kIEBtMdqGAXFNKSfYGNzmyNaDl25x2kOaGzbZiTPKnnhFGo/ucoFFLK7xZXAGvwTxIy
        y03vCO9M/+QLgo9kSaWGk5mUE3Rrab8uG6hWEDxSBLVYLdERdBYzI7f11MOcUgH2hmInzZ
        HR1xRpHO2mpypE+IIjWJnRQYSXWO9FyzyRO5FoyoMjEQRHE/SF9e14dfqXAU9p5hwj+I+v
        0k9sg2SOwJrXm6Ir9qqmobLlL09SPjpvMLK9MYH73w9peVGs2anDtabKMJu1iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681898533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xKa4qBEBRkgD2unjSYzaKjlkInBCJIWK/vpwH3yGfVA=;
        b=YBzEZ4B0t0g7gDzvFpi6HDAAH7JfSQ6nKRIvgfsF4WtNVWEUvsw+eih9od6iHhNPt6bN/Z
        7Mr2Cusd1YGQQzDA==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 12/18] wifi: rtl8xxxu: Add parameter macid to update_rate_mask
Date:   Wed, 19 Apr 2023 12:01:39 +0200
Message-Id: <20230419100145.159191-13-martin.kaistra@linutronix.de>
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

The HW maintains a rate_mask for each connection, referenced by the
macid. Add a parameter to update_rate_mask and add the macid to the
h2c call in the gen2 implementation.

Also extend refresh_rate_mask to get the macid from sta_info.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h    |  7 ++++---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c  |  3 ++-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c   | 13 +++++++++----
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 88ce369d33808..0610ab57f132d 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1918,7 +1918,8 @@ struct rtl8xxxu_fileops {
 	void (*set_tx_power) (struct rtl8xxxu_priv *priv, int channel,
 			      bool ht40);
 	void (*update_rate_mask) (struct rtl8xxxu_priv *priv,
-				  u32 ramask, u8 rateid, int sgi, int txbw_40mhz);
+				  u32 ramask, u8 rateid, int sgi, int txbw_40mhz,
+				  u8 macid);
 	void (*report_connect) (struct rtl8xxxu_priv *priv,
 				u8 macid, u8 role, bool connect);
 	void (*report_rssi) (struct rtl8xxxu_priv *priv, u8 macid, u8 rssi);
@@ -2025,9 +2026,9 @@ void rtl8xxxu_gen2_config_channel(struct ieee80211_hw *hw);
 void rtl8xxxu_gen1_usb_quirks(struct rtl8xxxu_priv *priv);
 void rtl8xxxu_gen2_usb_quirks(struct rtl8xxxu_priv *priv);
 void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
-			       u32 ramask, u8 rateid, int sgi, int txbw_40mhz);
+			       u32 ramask, u8 rateid, int sgi, int txbw_40mhz, u8 macid);
 void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
-				    u32 ramask, u8 rateid, int sgi, int txbw_40mhz);
+				    u32 ramask, u8 rateid, int sgi, int txbw_40mhz, u8 macid);
 void rtl8xxxu_gen1_report_connect(struct rtl8xxxu_priv *priv,
 				  u8 macid, u8 role, bool connect);
 void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
index af8436070ba77..3751fac3037dd 100644
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
index 4a41e1e3cdeaa..2e02812a4a85a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4491,7 +4491,8 @@ static void rtl8xxxu_sw_scan_complete(struct ieee80211_hw *hw,
 }
 
 void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
-			       u32 ramask, u8 rateid, int sgi, int txbw_40mhz)
+			       u32 ramask, u8 rateid, int sgi, int txbw_40mhz,
+			       u8 macid)
 {
 	struct h2c_cmd h2c;
 
@@ -4511,7 +4512,8 @@ void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
 }
 
 void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
-				    u32 ramask, u8 rateid, int sgi, int txbw_40mhz)
+				    u32 ramask, u8 rateid, int sgi, int txbw_40mhz,
+				    u8 macid)
 {
 	struct h2c_cmd h2c;
 	u8 bw;
@@ -4528,6 +4530,7 @@ void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
 	h2c.b_macid_cfg.ramask1 = (ramask >> 8) & 0xff;
 	h2c.b_macid_cfg.ramask2 = (ramask >> 16) & 0xff;
 	h2c.b_macid_cfg.ramask3 = (ramask >> 24) & 0xff;
+	h2c.b_macid_cfg.macid = macid;
 
 	h2c.b_macid_cfg.data1 = rateid;
 	if (sgi)
@@ -4893,7 +4896,8 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			priv->vif = vif;
 			priv->rssi_level = RTL8XXXU_RATR_STA_INIT;
 
-			priv->fops->update_rate_mask(priv, ramask, 0, sgi, bw == RATE_INFO_BW_40);
+			priv->fops->update_rate_mask(priv, ramask, 0, sgi,
+						     bw == RATE_INFO_BW_40, 0);
 
 			rtl8xxxu_write8(priv, REG_BCN_MAX_ERR, 0xff);
 
@@ -6805,6 +6809,7 @@ static void rtl8xxxu_refresh_rate_mask(struct rtl8xxxu_priv *priv,
 	u8 txbw_40mhz;
 	u8 snr, snr_thresh_high, snr_thresh_low;
 	u8 go_up_gap = 5;
+	u8 macid = rtl8xxxu_get_macid(priv, sta);
 
 	rssi_level = priv->rssi_level;
 	snr = rtl8xxxu_signal_to_snr(signal);
@@ -6924,7 +6929,7 @@ static void rtl8xxxu_refresh_rate_mask(struct rtl8xxxu_priv *priv,
 		}
 
 		priv->rssi_level = rssi_level;
-		priv->fops->update_rate_mask(priv, rate_bitmap, ratr_idx, sgi, txbw_40mhz);
+		priv->fops->update_rate_mask(priv, rate_bitmap, ratr_idx, sgi, txbw_40mhz, macid);
 	}
 }
 
-- 
2.30.2


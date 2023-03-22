Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58A36C524A
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 18:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCVRU2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 13:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjCVRUN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 13:20:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA98F1C7C2
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 10:19:52 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679505552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bGjdX7OSrxK42cpdDhcK+i4yz60CZ2rYgsRhZiDyBlQ=;
        b=zKw5XaPR1DV4o5djLRW+xv7DS/oiXbJDS9r58UiLtEPD/SqmZxSWjMsnmSbLLOFkKh4fnO
        X4rmZBdiVwC1ETDHVD3w37bkgAg5NxSXr0rJCxUaJZhIZJN4b3LFGE69Q9SCs3aw8NQRIb
        TktBYIf/iGWUqz8w2sfbH1zola+tYs6tc1Em6ebUHgCjX8fUk8ZqhZ+EXeF69pKcoibi8L
        +SgwQ5ZfiwtI/CAPYO7xPyu1U5Oh4clAOowYMRVWhvOZujegSvXAw3AOVbxCOoMfCkDDA/
        8VVCayEqtVRPun0SToW406OeT2ZtVO0fvFTvz49cMrNeOGxTRgmUhDKeVMMuAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679505552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bGjdX7OSrxK42cpdDhcK+i4yz60CZ2rYgsRhZiDyBlQ=;
        b=/GHpfQcUxpXpRLz7S1Gwn5rsMn96wCWqy4NIqddX1qWLCoAsCpeO90BBucdn/B+5CzmJJO
        mcerjuR5Yboa48AQ==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 09/14] wifi: rtl8xxxu: Add parameter role to report_connect
Date:   Wed, 22 Mar 2023 18:19:00 +0100
Message-Id: <20230322171905.492855-10-martin.kaistra@linutronix.de>
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

This allows to tell the HW if a connection is made to a STA or an AP.
Add the implementation for the gen2 version.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h      |  9 ++++++---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 11 ++++++-----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index c06ad33645974..e78e0bbd23354 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1280,6 +1280,9 @@ struct rtl8xxxu_rfregs {
 #define  H2C_JOIN_BSS_DISCONNECT	0
 #define  H2C_JOIN_BSS_CONNECT		1
 
+#define H2C_ROLE_STA			1
+#define H2C_ROLE_AP			2
+
 /*
  * H2C (firmware) commands differ between the older generation chips
  * 8188[cr]u, 819[12]cu, and 8723au, and the more recent chips 8723bu,
@@ -1908,7 +1911,7 @@ struct rtl8xxxu_fileops {
 				  u32 ramask, u8 rateid, int sgi, int txbw_40mhz,
 				  u8 macid);
 	void (*report_connect) (struct rtl8xxxu_priv *priv,
-				u8 macid, bool connect);
+				u8 macid, u8 role, bool connect);
 	void (*report_rssi) (struct rtl8xxxu_priv *priv, u8 macid, u8 rssi);
 	void (*fill_txdesc) (struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 			     struct ieee80211_tx_info *tx_info,
@@ -2012,9 +2015,9 @@ void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
 void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
 				    u32 ramask, u8 rateid, int sgi, int txbw_40mhz, u8 macid);
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
index 4209880d724be..5e36fddbbb488 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4524,7 +4524,7 @@ void rtl8xxxu_gen2_update_rate_mask(struct rtl8xxxu_priv *priv,
 }
 
 void rtl8xxxu_gen1_report_connect(struct rtl8xxxu_priv *priv,
-				  u8 macid, bool connect)
+				  u8 macid, u8 role, bool connect)
 {
 	struct h2c_cmd h2c;
 
@@ -4541,7 +4541,7 @@ void rtl8xxxu_gen1_report_connect(struct rtl8xxxu_priv *priv,
 }
 
 void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
-				  u8 macid, bool connect)
+				  u8 macid, u8 role, bool connect)
 {
 	/*
 	 * The firmware turns on the rate control when it knows it's
@@ -4557,6 +4557,7 @@ void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
 	else
 		h2c.media_status_rpt.parm &= ~BIT(0);
 
+	h2c.media_status_rpt.parm |= ((role << 4) & 0xf0);
 	h2c.media_status_rpt.macid = macid;
 
 	rtl8xxxu_gen2_h2c_cmd(priv, &h2c, sizeof(h2c.media_status_rpt));
@@ -4886,13 +4887,13 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			rtl8xxxu_write16(priv, REG_BCN_PSR_RPT,
 					 0xc000 | vif->cfg.aid);
 
-			priv->fops->report_connect(priv, 0, true);
+			priv->fops->report_connect(priv, 0, H2C_ROLE_AP, true);
 		} else {
 			val8 = rtl8xxxu_read8(priv, REG_BEACON_CTRL);
 			val8 |= BEACON_DISABLE_TSF_UPDATE;
 			rtl8xxxu_write8(priv, REG_BEACON_CTRL, val8);
 
-			priv->fops->report_connect(priv, 0, false);
+			priv->fops->report_connect(priv, 0, H2C_ROLE_AP, false);
 		}
 	}
 
@@ -4953,7 +4954,7 @@ static int rtl8xxxu_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	dev_dbg(dev, "Start AP mode\n");
 	rtl8xxxu_set_bssid(priv, vif->bss_conf.bssid);
 	rtl8xxxu_write16(priv, REG_BCN_INTERVAL, vif->bss_conf.beacon_int);
-	priv->fops->report_connect(priv, 0, true);
+	priv->fops->report_connect(priv, 0, 0, true);
 
 	return 0;
 }
-- 
2.30.2


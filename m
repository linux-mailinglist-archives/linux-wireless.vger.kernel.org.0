Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB096C5247
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 18:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCVRU0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 13:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCVRUL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 13:20:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BED06702F
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 10:19:51 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679505552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLV4RQbIkU/Wg79QJg4gHVRQdhYOT1muX8xdwhYFYAg=;
        b=jlIDJsJrmCHgnvyZIm4rbmaIA2Ey6HQnCIZS4xJFcPxEREp1Z2LLO/RcfA4j7OE6g8w3VH
        IhkuLdmsCa/eoqsKLdv9Iy2CVlGr8Gaj56vW3NCiXKMFeSPa/FB0ab5SY9N6tqvlZkAfcI
        HiaJZRKHoPMBdoNFdOGt8btU7By6tTTBnTF0z2IVgtdM0F3tgFHxzfKUalZugOI8QaPXT4
        hQHQbdxqMPbpBdltR0b/6B+CPmjeUg6i6fmbDVJXO+Oxo7bvbnpg4wO+RErLT3ffTdVa05
        A3xmWJoob72Z/VbKGl5vM2t+JvqT6BrGe8ADGTfQasOVSVHApMY6lqZi64aLIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679505552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLV4RQbIkU/Wg79QJg4gHVRQdhYOT1muX8xdwhYFYAg=;
        b=pUHlSNixVa0hlyz+aeemS4oU8wD7z3kBc/MomDPSoOKu0QaOClHTJiyfWLDRpzf5gl+OVP
        zlxLO20wDs2jloAQ==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 06/14] wifi: rtl8xxxu: Allow creating interface in AP mode
Date:   Wed, 22 Mar 2023 18:18:57 +0100
Message-Id: <20230322171905.492855-7-martin.kaistra@linutronix.de>
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

Use the sequence from the vendor driver for setting up the beacon
related registers.
Also set the MAC address register.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 31 ++++++++++++++++---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |  2 ++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index b233c66a7a5a8..b20ff8bc40870 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6408,18 +6408,39 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
 	int ret;
 	u8 val8;
 
+	if (!priv->vif)
+		priv->vif = vif;
+	else
+		return -EOPNOTSUPP;
+
 	switch (vif->type) {
 	case NL80211_IFTYPE_STATION:
-		if (!priv->vif)
-			priv->vif = vif;
-		else
-			return -EOPNOTSUPP;
 		rtl8xxxu_stop_tx_beacon(priv);
 
 		val8 = rtl8xxxu_read8(priv, REG_BEACON_CTRL);
 		val8 |= BEACON_ATIM | BEACON_FUNCTION_ENABLE |
 			BEACON_DISABLE_TSF_UPDATE;
 		rtl8xxxu_write8(priv, REG_BEACON_CTRL, val8);
+		ret = 0;
+		break;
+	case NL80211_IFTYPE_AP:
+		rtl8xxxu_write8(priv, REG_BEACON_CTRL,
+				BEACON_DISABLE_TSF_UPDATE | BEACON_CTRL_MBSSID);
+		rtl8xxxu_write8(priv, REG_ATIMWND, 0x0c); /* 12ms */
+		rtl8xxxu_write16(priv, REG_TSFTR_SYN_OFFSET, 0x7fff); /* ~32ms */
+		rtl8xxxu_write8(priv, REG_DUAL_TSF_RST, DUAL_TSF_RESET_TSF0);
+
+		/* enable BCN0 function */
+		rtl8xxxu_write8(priv, REG_BEACON_CTRL,
+				BEACON_DISABLE_TSF_UPDATE |
+				BEACON_FUNCTION_ENABLE | BEACON_CTRL_MBSSID |
+				BEACON_CTRL_TX_BEACON_RPT);
+
+		/* select BCN on port 0 */
+		val8 = rtl8xxxu_read8(priv, REG_CCK_CHECK);
+		val8 &= ~BIT_BCN_PORT_SEL;
+		rtl8xxxu_write8(priv, REG_CCK_CHECK, val8);
+
 		ret = 0;
 		break;
 	default:
@@ -6427,6 +6448,8 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
 	}
 
 	rtl8xxxu_set_linktype(priv, vif->type);
+	ether_addr_copy(priv->mac_addr, vif->addr);
+	rtl8xxxu_set_mac(priv);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
index 4dffbab494c3b..83e7f8fd82c0a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
@@ -572,6 +572,8 @@
 #define REG_ARFR1			0x0448
 #define REG_ARFR2			0x044c
 #define REG_ARFR3			0x0450
+#define REG_CCK_CHECK			0x0454
+#define BIT_BCN_PORT_SEL		BIT(5)
 #define REG_AMPDU_MAX_TIME_8723B	0x0456
 #define REG_AGGLEN_LMT			0x0458
 #define REG_AMPDU_MIN_SPACE		0x045c
-- 
2.30.2


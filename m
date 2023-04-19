Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0EA6E7702
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 12:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjDSKC3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 06:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjDSKCR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 06:02:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614E940C8
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 03:02:15 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681898532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pjgk+hbfJDwkMDO6GJj6K/e3LL2duws/ZPO2wGV2sFk=;
        b=Jw50XirjkJ/11MGYUpmpZytmFSSmpHxcW2NQY7s6xfyPDrO7o1zglgTNLrgweRMrO/qakJ
        8VxmJFtTpcUxO58763rwkF+BnbXrCg5cP8b7nqm3Zvjy1AgStzHCuJ3ww2sCGzz2ucSweD
        eWgpw8pHxiy2IHmt2QfpW67uLTSRflCot9l5Eo2K0h+l24Lpx+hcnAYqY/VWU7HRagvbOc
        Q9/HO/8/2EJV3aOhDF1TpLx2ozOFGAlbk8w7dRnULNEs6l6TVm/N21oQrM4iMdoS/BpBw0
        Tei2OivDPcLFuIwlJWF1iriROalsEFoV/m14r0693yvhwuisCuYnJqplperGXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681898532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pjgk+hbfJDwkMDO6GJj6K/e3LL2duws/ZPO2wGV2sFk=;
        b=Yr6dVkpAnZTfRREuke0xNYLQ6ePjTLQCrlGsdniUME3f81CSsCOl+++3EBSv9VnYsSiAdf
        ezCHe5odJ7utMvCA==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 06/18] wifi: rtl8xxxu: Allow creating interface in AP mode
Date:   Wed, 19 Apr 2023 12:01:33 +0200
Message-Id: <20230419100145.159191-7-martin.kaistra@linutronix.de>
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

Use the sequence from the vendor driver for setting up the beacon
related registers.
Also set the MAC address register here, in case the MAC address for the
new interface should be different from what was set in
rtl8xxxu_init_device(). This happens for example with the hostapd config
option "bssid".

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 31 ++++++++++++++++---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |  2 ++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 60b50a57da284..de44e79dd186a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6401,18 +6401,39 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
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
@@ -6420,6 +6441,8 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
 	}
 
 	rtl8xxxu_set_linktype(priv, vif->type);
+	ether_addr_copy(priv->mac_addr, vif->addr);
+	rtl8xxxu_set_mac(priv);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
index ad285e4ac0ec4..8571d5129f327 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
@@ -575,6 +575,8 @@
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


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901276F031B
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 11:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243254AbjD0JKC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 05:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243358AbjD0JJv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 05:09:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF582715
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 02:09:46 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682586584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kUnAPrudwNtdoew2r5Djr6+Ju/Y3ixu9VmygPb2IVgw=;
        b=3CdKAvcb9UgoVrsX59Q28W/2ae7/rQLj4vzGkyNRKTgUZ8LpO4aGT+DziIJ5AjOWIg0bRS
        Wy1iYpTJ31BkUssp7z4Qe38W7iqf+wl1i31ukrYHPlzSiA8rXA4Tia4QXmWmnE4pe7Tj/w
        8qYxQ1hhRy/LFnYJsREppAaWBrwi+fEmHmMsO6gECCi2k5O//BZYfDoPqS3TC7H/2wUusd
        5D8MMfKHeYlP7bK88/e2yay3VENTJX4BihOm8bdGTg4pbsX1YUT0AQ+9/OfOv94Kuwr7g7
        J4TC5mpD8GxiZ2tX7elyMGzHJvIyzZQGsnEavgAoj3RW5yRUJp5HCVQLoXIwdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682586584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kUnAPrudwNtdoew2r5Djr6+Ju/Y3ixu9VmygPb2IVgw=;
        b=reR7c7RyoNCmgdmKyJ9kM2jJhYNjlEuQELH2VrOPb0E8BOEsjJHEY6r6AUdJqDth5uOjk2
        Qow1KPhaf5MT9SBQ==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 03/18] wifi: rtl8xxxu: Add beacon functions
Date:   Thu, 27 Apr 2023 11:09:07 +0200
Message-Id: <20230427090922.165088-4-martin.kaistra@linutronix.de>
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

Add a workqueue to update the beacon contents asynchronously and
implement downloading the beacon to the HW and starting beacon tx like
the vendor driver.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  1 +
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 74 +++++++++++++++++++
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |  3 +
 3 files changed, 78 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 9cd6d171e9933..971f1cc38d323 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1851,6 +1851,7 @@ struct rtl8xxxu_priv {
 	struct delayed_work ra_watchdog;
 	struct work_struct c2hcmd_work;
 	struct sk_buff_head c2hcmd_queue;
+	struct work_struct update_beacon_work;
 	struct rtl8xxxu_btcoex bt_coex;
 	struct rtl8xxxu_ra_report ra_report;
 	struct rtl8xxxu_cfo_tracking cfo_tracking;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 9dc6f3ec7a305..a733c6856fb20 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1185,6 +1185,20 @@ static void rtl8xxxu_stop_tx_beacon(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_write8(priv, REG_TBTT_PROHIBIT + 2, val8);
 }
 
+static void rtl8xxxu_start_tx_beacon(struct rtl8xxxu_priv *priv)
+{
+	u8 val8;
+
+	val8 = rtl8xxxu_read8(priv, REG_FWHW_TXQ_CTRL + 2);
+	val8 |= EN_BCNQ_DL >> 16;
+	rtl8xxxu_write8(priv, REG_FWHW_TXQ_CTRL + 2, val8);
+
+	rtl8xxxu_write8(priv, REG_TBTT_PROHIBIT + 1, 0x80);
+	val8 = rtl8xxxu_read8(priv, REG_TBTT_PROHIBIT + 2);
+	val8 &= 0xF0;
+	rtl8xxxu_write8(priv, REG_TBTT_PROHIBIT + 2, val8);
+}
+
 
 /*
  * The rtl8723a has 3 channel groups for it's efuse settings. It only
@@ -4964,6 +4978,16 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		dev_dbg(dev, "Changed BASIC_RATES!\n");
 		rtl8xxxu_set_basic_rates(priv, bss_conf->basic_rates);
 	}
+
+	if (changed & BSS_CHANGED_BEACON_ENABLED && bss_conf->enable_beacon)
+		rtl8xxxu_start_tx_beacon(priv);
+
+	if (changed & BSS_CHANGED_BEACON)
+		schedule_work(&priv->update_beacon_work);
+
+	if (changed & BSS_CHANGED_BEACON_ENABLED && !bss_conf->enable_beacon)
+		rtl8xxxu_stop_tx_beacon(priv);
+
 error:
 	return;
 }
@@ -5545,6 +5569,55 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
 	dev_kfree_skb(skb);
 }
 
+static void rtl8xxxu_send_beacon_frame(struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif)
+{
+	struct rtl8xxxu_priv *priv = hw->priv;
+	struct sk_buff *skb = ieee80211_beacon_get(hw, vif, 0);
+	struct device *dev = &priv->udev->dev;
+	int retry;
+	u8 val8;
+
+	/* BCN_VALID, write 1 to clear, cleared by SW */
+	val8 = rtl8xxxu_read8(priv, REG_TDECTRL + 2);
+	val8 |= BIT_BCN_VALID >> 16;
+	rtl8xxxu_write8(priv, REG_TDECTRL + 2, val8);
+
+	/* SW_BCN_SEL - Port0 */
+	val8 = rtl8xxxu_read8(priv, REG_DWBCN1_CTRL_8723B + 2);
+	val8 &= ~(BIT_SW_BCN_SEL >> 16);
+	rtl8xxxu_write8(priv, REG_DWBCN1_CTRL_8723B + 2, val8);
+
+	if (skb)
+		rtl8xxxu_tx(hw, NULL, skb);
+
+	retry = 100;
+	do {
+		val8 = rtl8xxxu_read8(priv, REG_TDECTRL + 2);
+		if (val8 & (BIT_BCN_VALID >> 16))
+			break;
+		usleep_range(10, 20);
+	} while (--retry);
+
+	if (!retry)
+		dev_err(dev, "%s: Failed to read beacon valid bit\n", __func__);
+}
+
+static void rtl8xxxu_update_beacon_work_callback(struct work_struct *work)
+{
+	struct rtl8xxxu_priv *priv =
+		container_of(work, struct rtl8xxxu_priv, update_beacon_work);
+	struct ieee80211_hw *hw = priv->hw;
+	struct ieee80211_vif *vif = priv->vif;
+
+	if (!vif) {
+		WARN_ONCE(true, "no vif to update beacon\n");
+		return;
+	}
+
+	rtl8xxxu_send_beacon_frame(hw, vif);
+}
+
 void rtl8723au_rx_parse_phystats(struct rtl8xxxu_priv *priv,
 				 struct ieee80211_rx_status *rx_status,
 				 struct rtl8723au_phy_stats *phy_stats,
@@ -7311,6 +7384,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	spin_lock_init(&priv->rx_urb_lock);
 	INIT_WORK(&priv->rx_urb_wq, rtl8xxxu_rx_urb_work);
 	INIT_DELAYED_WORK(&priv->ra_watchdog, rtl8xxxu_watchdog_callback);
+	INIT_WORK(&priv->update_beacon_work, rtl8xxxu_update_beacon_work_callback);
 	skb_queue_head_init(&priv->c2hcmd_queue);
 
 	usb_set_intfdata(interface, hw);
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
index 4dffbab494c3b..ad285e4ac0ec4 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
@@ -456,6 +456,7 @@
 
 #define REG_FIFOPAGE			0x0204
 #define REG_TDECTRL			0x0208
+#define  BIT_BCN_VALID			BIT(16)
 
 #define REG_DWBCN0_CTRL_8188F		REG_TDECTRL
 
@@ -470,6 +471,7 @@
 #define  AUTO_LLT_INIT_LLT		BIT(16)
 
 #define REG_DWBCN1_CTRL_8723B		0x0228
+#define  BIT_SW_BCN_SEL			BIT(20)
 
 /* 0x0280 ~ 0x02FF	RXDMA Configuration */
 #define REG_RXDMA_AGG_PG_TH		0x0280	/* 0-7 : USB DMA size bits
@@ -516,6 +518,7 @@
 #define REG_FWHW_TXQ_CTRL		0x0420
 #define  FWHW_TXQ_CTRL_AMPDU_RETRY	BIT(7)
 #define  FWHW_TXQ_CTRL_XMIT_MGMT_ACK	BIT(12)
+#define  EN_BCNQ_DL			BIT(22)
 
 #define REG_HWSEQ_CTRL			0x0423
 #define REG_TXPKTBUF_BCNQ_BDNY		0x0424
-- 
2.30.2


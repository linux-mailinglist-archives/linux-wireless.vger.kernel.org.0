Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA0A6E7701
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 12:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjDSKC2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 06:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjDSKCQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 06:02:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC1A1FE7
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 03:02:12 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681898531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XSvcLS6hA0GGdNgI2qhZCvztLwZbV1NJVpzs6qzr9XI=;
        b=oCKu7oLRLIzPGluIErMALxnNapSQ/htuniVrRVutV7oepvSdceJUUAg92I5zh3MVcKKU+u
        gPfAShvFv3jPzk0lMvVQ5IiJTgfyRMB2X1AzADlL4/e2omK/mo7V/T6+s21mSrDUfkFbNH
        Rwnoh20J62H64OEJylGpk1K8ftLtHhYvJmwZecpdY7zSt9IVYWXpIiakRnEDPV48/ediFD
        vFvK0ZBJrs8lCbkVD2S1q3Jxbq6A7fpo7ngQvdkPBjp+HWbKIZs9czLGj25TuksMVk/e8x
        CrB5NiCe0ATwBp9kKCpl7FO7oajluMMKzoQ9IFMcUYrxdG45KupdO7E7vqSAFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681898531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XSvcLS6hA0GGdNgI2qhZCvztLwZbV1NJVpzs6qzr9XI=;
        b=Gc/aJ8Y2y/x0oxV8dbsQNDdTvw+urFOfxoYMCEIvHT3Q66XIbxD5hEn5RxbGmEdPqLFNO+
        6K7UMvMsSHhbDXBQ==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 03/18] wifi: rtl8xxxu: Add beacon functions
Date:   Wed, 19 Apr 2023 12:01:30 +0200
Message-Id: <20230419100145.159191-4-martin.kaistra@linutronix.de>
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

Add a workqueue to update the beacon contents asynchronously and
implement downloading the beacon to the HW and starting beacon tx like
the vendor driver.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  3 +
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 84 +++++++++++++++++++
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |  3 +
 3 files changed, 90 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index cb8c019b63372..93f744cd8d6d8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1745,6 +1745,8 @@ struct rtl8xxxu_priv {
 	bool shutdown;
 	struct work_struct rx_urb_wq;
 
+	bool beacon_enabled;
+
 	u8 mac_addr[ETH_ALEN];
 	char chip_name[8];
 	char chip_vendor[8];
@@ -1851,6 +1853,7 @@ struct rtl8xxxu_priv {
 	struct delayed_work ra_watchdog;
 	struct work_struct c2hcmd_work;
 	struct sk_buff_head c2hcmd_queue;
+	struct work_struct update_beacon_work;
 	struct rtl8xxxu_btcoex bt_coex;
 	struct rtl8xxxu_ra_report ra_report;
 	struct rtl8xxxu_cfo_tracking cfo_tracking;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 2c2513cee3a63..960e3efcb0ee2 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1104,6 +1104,24 @@ static void rtl8xxxu_stop_tx_beacon(struct rtl8xxxu_priv *priv)
 	val8 = rtl8xxxu_read8(priv, REG_TBTT_PROHIBIT + 2);
 	val8 &= ~BIT(0);
 	rtl8xxxu_write8(priv, REG_TBTT_PROHIBIT + 2, val8);
+
+	priv->beacon_enabled = false;
+}
+
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
+
+	priv->beacon_enabled = true;
 }
 
 
@@ -4885,6 +4903,22 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		dev_dbg(dev, "Changed BASIC_RATES!\n");
 		rtl8xxxu_set_basic_rates(priv, bss_conf->basic_rates);
 	}
+
+	if (changed & BSS_CHANGED_BEACON ||
+	    (changed & BSS_CHANGED_BEACON_ENABLED &&
+	     bss_conf->enable_beacon)) {
+		if (!priv->beacon_enabled) {
+			dev_dbg(dev, "BSS_CHANGED_BEACON_ENABLED\n");
+			rtl8xxxu_start_tx_beacon(priv);
+		}
+		schedule_work(&priv->update_beacon_work);
+	}
+
+	if (changed & BSS_CHANGED_BEACON_ENABLED && !bss_conf->enable_beacon) {
+		if (priv->beacon_enabled)
+			rtl8xxxu_stop_tx_beacon(priv);
+	}
+
 error:
 	return;
 }
@@ -5466,6 +5500,55 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
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
@@ -7234,6 +7317,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
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


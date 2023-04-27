Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67F26F030D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 11:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243246AbjD0JJ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 05:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243354AbjD0JJv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 05:09:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848DD30FC
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 02:09:46 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682586584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YHLQndD8+02gH+3IgdO6pIZSW7YIjRMlN8iFKSxa69A=;
        b=QucGN90vGZmqgwu3j30OfTng6MhpaPWSDeWHytWEsDWCvLZ7+oOw9uDQmfKsRPsys+sNx3
        fIVDRA4sCaiFDxSzIbwvroj7EKd0HWlgkxyMmsioByHgdZ6Sz+a1gF+ENWvsGOlIkePbtE
        jtwhCv9HPjmaRf6hWSK6voOwr69VJvCMcPbw8GEKTtkirw21nqUoUJfwuz4ujOZs8osjo/
        u+lSvi/Z4G9nOr65WBh1LEYinA3Tvip0XaDIEiHiHnXLBbyo15jjGeyzrLlghANeNywRdC
        6KTwa9FXQ/1rdfpxn+PrAbf2whbEvss4HJcNlOymWThkP54SYG0Bru4sT9ydyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682586584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YHLQndD8+02gH+3IgdO6pIZSW7YIjRMlN8iFKSxa69A=;
        b=SkKxSAGy01yhpP6YlX816mx/BpT0RXmjnir648ms8m6oyhAEfITopTxTVETtO4QUeXusZv
        P4ZE6WwWsQFTx2Bg==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 01/18] wifi: rtl8xxxu: Add start_ap() callback
Date:   Thu, 27 Apr 2023 11:09:05 +0200
Message-Id: <20230427090922.165088-2-martin.kaistra@linutronix.de>
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

This gets called at the start of AP mode operation. Set bssid, beacon
interval and send a connect report to the HW.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 8eafbf1cee718..9cd6d171e9933 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1727,6 +1727,7 @@ struct rtl8xxxu_cfo_tracking {
 };
 
 #define RTL8XXXU_HW_LED_CONTROL	2
+#define RTL8XXXU_BC_MC_MACID	0
 
 struct rtl8xxxu_priv {
 	struct ieee80211_hw *hw;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index fd8c8c6d53d60..b8fcf911c072e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4968,6 +4968,20 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return;
 }
 
+static int rtl8xxxu_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			     struct ieee80211_bss_conf *link_conf)
+{
+	struct rtl8xxxu_priv *priv = hw->priv;
+	struct device *dev = &priv->udev->dev;
+
+	dev_dbg(dev, "Start AP mode\n");
+	rtl8xxxu_set_bssid(priv, vif->bss_conf.bssid);
+	rtl8xxxu_write16(priv, REG_BCN_INTERVAL, vif->bss_conf.beacon_int);
+	priv->fops->report_connect(priv, RTL8XXXU_BC_MC_MACID, true);
+
+	return 0;
+}
+
 static u32 rtl8xxxu_80211_to_rtl_queue(u32 queue)
 {
 	u32 rtlqueue;
@@ -7093,6 +7107,7 @@ static const struct ieee80211_ops rtl8xxxu_ops = {
 	.config = rtl8xxxu_config,
 	.conf_tx = rtl8xxxu_conf_tx,
 	.bss_info_changed = rtl8xxxu_bss_info_changed,
+	.start_ap = rtl8xxxu_start_ap,
 	.configure_filter = rtl8xxxu_configure_filter,
 	.set_rts_threshold = rtl8xxxu_set_rts_threshold,
 	.start = rtl8xxxu_start,
-- 
2.30.2


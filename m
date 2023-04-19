Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59C16E76FD
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 12:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjDSKCZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 06:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjDSKCP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 06:02:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD3C10F8
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 03:02:12 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681898531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MeBHWzKcG48zqNuw1u9UoPw9iZ3hH0PZ0y/C5vYolGA=;
        b=FZ1pImfc/Xa515zIgcKAjOJdHRcJf2eGf/tE4zOVRsHXEYDdEpcSO1Wmf9srsgk4sLVxlE
        FiIjd3W90YoAqAfbrDaQsFg92fhOQ9wxh5e7Fl7qLAZrnV8GIOiTLJwYJfQ6sqwElKIakO
        9oW/iCTplBvH1Oqtrg9D5AA1C0SitrI4azss9/YgrhiFOo9DeCPeiYqz6SJ91rocLpo7Kp
        zZ7ZxxRu1wWjrueFBxyU0g8w5ArT1xp9VTL0chJHY+lG6+ayi3AfOaLy1Pwyjj7Dw3v+ak
        ApueqwlynZA0s1YWCWRwcuNH8CDDRIQBNZHa62Q/+IsoX/Iu4f2a/a2QIsp3mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681898531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MeBHWzKcG48zqNuw1u9UoPw9iZ3hH0PZ0y/C5vYolGA=;
        b=Y5fR05A1isPyHFuxGz17ikkK8Pc0JW08vhcCX4bBeXk/wU2AcE7MxJmVEkUBPnm2lNVZqV
        8yrAgjRgpcq0yRCA==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 01/18] wifi: rtl8xxxu: Add start_ap() callback
Date:   Wed, 19 Apr 2023 12:01:28 +0200
Message-Id: <20230419100145.159191-2-martin.kaistra@linutronix.de>
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

This gets called at the start of AP mode operation. Set bssid, beacon
interval and send a connect report to the HW.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 82a0290ccb299..cb8c019b63372 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1727,6 +1727,7 @@ struct rtl8xxxu_cfo_tracking {
 };
 
 #define RTL8XXXU_HW_LED_CONTROL	2
+#define RTL8XXXU_BC_MC_MACID	0
 
 struct rtl8xxxu_priv {
 	struct ieee80211_hw *hw;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 6106b47d0c37f..b2be89c35d914 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4889,6 +4889,20 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
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
@@ -7016,6 +7030,7 @@ static const struct ieee80211_ops rtl8xxxu_ops = {
 	.config = rtl8xxxu_config,
 	.conf_tx = rtl8xxxu_conf_tx,
 	.bss_info_changed = rtl8xxxu_bss_info_changed,
+	.start_ap = rtl8xxxu_start_ap,
 	.configure_filter = rtl8xxxu_configure_filter,
 	.set_rts_threshold = rtl8xxxu_set_rts_threshold,
 	.start = rtl8xxxu_start,
-- 
2.30.2


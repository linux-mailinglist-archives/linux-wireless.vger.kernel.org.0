Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7176C5240
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 18:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjCVRUK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 13:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCVRTx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 13:19:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740D367020
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 10:19:34 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679505550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5pjQ+byrkgGQUeoORXiVrJAFdNnAyZq7Kdgp2vBQvUo=;
        b=2rzyoOTbJrroQNkGIB3dDn/vOVDnAzcn6Hj8VsLEow1Hgur1pqK3MgZH8SVurgdBHgjhsy
        /JDhBUHD1J8oCrPARI3t96hGilyaZZ/LDoK67KpGc5sbfp7Wnhbq+J8BGi9CQ5k/5dZH5D
        0fzVChyuLzHu3rkqsmYOvOb3hJ3tQ2yPrJoXwMk10Ut6OdKBnUYP7dZgMlhRi7WNDndC8b
        nvtpNI5yHXJg0YPAMewbIBeoIFhjltkBhupTWFXw8rOHMJPuYCDhxZfQxvr0Ck6ausU9am
        KNsZXkN52oI+oC4qkzO2SbCZKQUCnXvnt/1EcVYkwuOzM13f6f6NEatsVFxOOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679505550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5pjQ+byrkgGQUeoORXiVrJAFdNnAyZq7Kdgp2vBQvUo=;
        b=8C6q0gyV8CiSlAURNV1xc7UOQ+0YmU+vm1alYf8//8ZXvF/q3hCq5NjFB4SF12OLpiSZoD
        c1R6R1K2o9ywbfBw==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 01/14] wifi: rtl8xxxu: Add start_ap() callback
Date:   Wed, 22 Mar 2023 18:18:52 +0100
Message-Id: <20230322171905.492855-2-martin.kaistra@linutronix.de>
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

This gets called at the start of AP mode operation. Set bssid, beacon
interval and send a connect report to the HW.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index c152b228606f1..90b98b9dcbd9d 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4899,6 +4899,20 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
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
+	priv->fops->report_connect(priv, 0, true);
+
+	return 0;
+}
+
 static u32 rtl8xxxu_80211_to_rtl_queue(u32 queue)
 {
 	u32 rtlqueue;
@@ -7026,6 +7040,7 @@ static const struct ieee80211_ops rtl8xxxu_ops = {
 	.config = rtl8xxxu_config,
 	.conf_tx = rtl8xxxu_conf_tx,
 	.bss_info_changed = rtl8xxxu_bss_info_changed,
+	.start_ap = rtl8xxxu_start_ap,
 	.configure_filter = rtl8xxxu_configure_filter,
 	.set_rts_threshold = rtl8xxxu_set_rts_threshold,
 	.start = rtl8xxxu_start,
-- 
2.30.2


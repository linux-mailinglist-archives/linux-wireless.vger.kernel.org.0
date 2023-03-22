Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8336C5249
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 18:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjCVRU1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 13:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjCVRUM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 13:20:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE6F1DBBC
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 10:19:52 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679505553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wsqe9w4nA31DicGlQraPVRYrPRMRMTJXbliLyuM6miU=;
        b=jrMA+0cJCyY4ptgVRgi8gJTRgGf2HYDQODOcdNDJR1pLOo6KVGmoKUSfC5dJRCuLi6Thbe
        HXCxDnTyhEJM5jMZtpCa919zMrGG3dwWG7ZQQJwspXQ6i/hhYT3/KEXGgJHldCteU09rEG
        ChsPgzTFl3LXoau2soPux/5pfEYCkHL0ndij0Wijq7/TrvS11b8oAkD4ypOzVWMD43JzPG
        0X3jALU7lmXUF852Q6pqvSe5508J6Shp/oDxCoissyKWm+eFfKsdCddwYefuGQpaMI3E3i
        a9zUq3KAL0SqskLLUGkn7K0TS3qyUiIfbl6VnUXSaxcHaV74UlKU7NupL04iaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679505553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wsqe9w4nA31DicGlQraPVRYrPRMRMTJXbliLyuM6miU=;
        b=rQH9zCDdXN9G+V1rBRR2hnFzp2y4IIjWvxWi3nUUfrjNzeG6XIbH6OjHu1T9qkl7VDgS28
        TTulX6ABx12ecdBw==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 10/14] wifi: rtl8xxxu: Add sta_add() callback
Date:   Wed, 22 Mar 2023 18:19:01 +0100
Message-Id: <20230322171905.492855-11-martin.kaistra@linutronix.de>
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

This function gets called in AP mode, when a new STA gets associated to
us. Call rtl8xxxu_refresh_rate_mask() to set a rate mask for the newly
connected STA (referenced by the macid) and then send a media connnect
report.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 5e36fddbbb488..d74a3c6452507 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7159,6 +7159,19 @@ static void rtl8xxxu_stop(struct ieee80211_hw *hw)
 	rtl8xxxu_free_tx_resources(priv);
 }
 
+static int rtl8xxxu_sta_add(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta)
+{
+	struct rtl8xxxu_priv *priv = hw->priv;
+
+	if (sta) {
+		rtl8xxxu_refresh_rate_mask(priv, 0, sta);
+		priv->fops->report_connect(priv, sta->aid + 1, H2C_ROLE_STA, true);
+	}
+	return 0;
+}
+
 static const struct ieee80211_ops rtl8xxxu_ops = {
 	.tx = rtl8xxxu_tx,
 	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
@@ -7179,6 +7192,7 @@ static const struct ieee80211_ops rtl8xxxu_ops = {
 	.sta_statistics = rtl8xxxu_sta_statistics,
 	.get_antenna = rtl8xxxu_get_antenna,
 	.set_tim = rtl8xxxu_set_tim,
+	.sta_add = rtl8xxxu_sta_add,
 };
 
 static int rtl8xxxu_parse_usb(struct rtl8xxxu_priv *priv,
-- 
2.30.2


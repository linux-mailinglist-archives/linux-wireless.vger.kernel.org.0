Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9C46E770F
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 12:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjDSKCj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 06:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjDSKCT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 06:02:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5049093C7
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 03:02:16 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681898532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ZJycN10oa+e/wWJn3PpZQWHhjEYLS/eMXxhA4xfd58=;
        b=D38khYMc2IcoboMCY+pfueFBco3sEiVyXqX9JnjUOQ7oeljapzXSeqoq25lauYE1U7bg2z
        /ecjamioHvJpLAhl1mxEbAr9IBlomQjnGchT1uyDj9H2xn6/aW0SGJfM0b/RziT5etGWFJ
        SCghS7ZdUG/FZGzzOI1Z62Dc3jAS0qJyCale4DTq33cn40h1V1d/w75+/ksHMPQCVAyOHD
        4EgT+GqRvfZ8V5ejmY2bKprc/R4lnFvFtgyAuSTeC2GTm95BHMDItJek8rdcDww0ZFvcW7
        Ff3OtGIw2Sr1VvKtFg61viNanN5HGtuCbXuExAj1V7v0MU3T7+W0o6ePBfrluA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681898532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ZJycN10oa+e/wWJn3PpZQWHhjEYLS/eMXxhA4xfd58=;
        b=mgyHfpncGBPArZ/hyelFzBreiY6fhPO7A61G2povyrXyhzzSd1rGANvJeeThVKKCcZtf4R
        Lor/vriLMzXxaLAg==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 09/18] wifi: rtl8xxxu: Add parameter force to rtl8xxxu_refresh_rate_mask
Date:   Wed, 19 Apr 2023 12:01:36 +0200
Message-Id: <20230419100145.159191-10-martin.kaistra@linutronix.de>
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

In AP mode, when multiple STAs connect to us, we need to set an initial
rate mask for each of them. This initialisation should happen regardless
of the rssi_level saved in the priv struct.

Add a parameter called force to rtl8xxxu_refresh_rate_mask() which will
be used for this initialisation.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 75b8b6d07ea67..19e115d10493a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6760,7 +6760,8 @@ static u8 rtl8xxxu_signal_to_snr(int signal)
 }
 
 static void rtl8xxxu_refresh_rate_mask(struct rtl8xxxu_priv *priv,
-				       int signal, struct ieee80211_sta *sta)
+				       int signal, struct ieee80211_sta *sta,
+				       bool force)
 {
 	struct ieee80211_hw *hw = priv->hw;
 	u16 wireless_mode;
@@ -6794,7 +6795,7 @@ static void rtl8xxxu_refresh_rate_mask(struct rtl8xxxu_priv *priv,
 	else
 		rssi_level = RTL8XXXU_RATR_STA_LOW;
 
-	if (rssi_level != priv->rssi_level) {
+	if (rssi_level != priv->rssi_level || force) {
 		int sgi = 0;
 		u32 rate_bitmap = 0;
 
@@ -7010,7 +7011,7 @@ static void rtl8xxxu_watchdog_callback(struct work_struct *work)
 		if (priv->fops->set_crystal_cap)
 			rtl8xxxu_track_cfo(priv);
 
-		rtl8xxxu_refresh_rate_mask(priv, signal, sta);
+		rtl8xxxu_refresh_rate_mask(priv, signal, sta, false);
 	}
 
 out:
-- 
2.30.2


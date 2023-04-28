Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98226F1B23
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 17:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346303AbjD1PI6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 11:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346272AbjD1PIw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 11:08:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E543C33
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 08:08:50 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682694520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ripM994YwH2FpgLTQOpO03asnDM15s7kyKZMntGjDOY=;
        b=zyHAawzSDmTnZJyK8k1GMMW5s8hYRcjxJmMpOrVt/xiBS6sTRkkLOAfSqlX6MT82EE+rvF
        lBwdv/DZ5vWySEs14cc70tQQUiVf9OXrZwWnB4W7Qj/CthERE4iFuoC+p54qHwSeO40LV2
        +csAUS4eO//GoQDD726UgJ5HsXPyqjD6jiy7PBu51imhakKoiOgphy4VT2FDSRRWSEQWCI
        ob7t+f+9I3DO69ZfzM9uNp4O9IwEu0MAD7iab4us3HHZ/M0QB36guXYeQza1tqJQCzhfjR
        h05E+tTvcBKqITcXvKb1ZYhGBp1BSvsqetVqw7mLiNxYmlhBtoDO9uoQrXHk/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682694520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ripM994YwH2FpgLTQOpO03asnDM15s7kyKZMntGjDOY=;
        b=6YRQwQgQeGLNODUZM4Q/69MfzmlsML+p80+s5Lbw2MGhUlkN1VhQjQWsjTxR3Fy2x3+Jg7
        jtd0MrHTJ5ILZuDQ==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 09/18] wifi: rtl8xxxu: Add parameter force to rtl8xxxu_refresh_rate_mask
Date:   Fri, 28 Apr 2023 17:08:24 +0200
Message-Id: <20230428150833.218605-10-martin.kaistra@linutronix.de>
In-Reply-To: <20230428150833.218605-1-martin.kaistra@linutronix.de>
References: <20230428150833.218605-1-martin.kaistra@linutronix.de>
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
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 0e951dee127ec..a3ca6ea9b2d66 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6830,7 +6830,8 @@ static u8 rtl8xxxu_signal_to_snr(int signal)
 }
 
 static void rtl8xxxu_refresh_rate_mask(struct rtl8xxxu_priv *priv,
-				       int signal, struct ieee80211_sta *sta)
+				       int signal, struct ieee80211_sta *sta,
+				       bool force)
 {
 	struct ieee80211_hw *hw = priv->hw;
 	u16 wireless_mode;
@@ -6864,7 +6865,7 @@ static void rtl8xxxu_refresh_rate_mask(struct rtl8xxxu_priv *priv,
 	else
 		rssi_level = RTL8XXXU_RATR_STA_LOW;
 
-	if (rssi_level != priv->rssi_level) {
+	if (rssi_level != priv->rssi_level || force) {
 		int sgi = 0;
 		u32 rate_bitmap = 0;
 
@@ -7080,7 +7081,7 @@ static void rtl8xxxu_watchdog_callback(struct work_struct *work)
 		if (priv->fops->set_crystal_cap)
 			rtl8xxxu_track_cfo(priv);
 
-		rtl8xxxu_refresh_rate_mask(priv, signal, sta);
+		rtl8xxxu_refresh_rate_mask(priv, signal, sta, false);
 	}
 
 out:
-- 
2.30.2


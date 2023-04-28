Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D749C6F1B29
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 17:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346312AbjD1PJC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 11:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346289AbjD1PIy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 11:08:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2C82726
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 08:08:51 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682694521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5TzCBkAhEE1r9irTGgb6179fix0fEgXAdCpZoHyDzVI=;
        b=d0JHi6n/pDSpsyzGYz3mrFdvz8YAEntytevcZFwor6XRcnZ8waEqI4EymMB12KwtVFUiPB
        bA0LXyPICd5khDac8vY2Fdh9WmOAuBfPhbl+Ze1JlIk/ZkECN4SMlSmUCjRQBVYhPh6X0W
        ltuAM5dp+KrHBH8kHqrh4sX9NGVoa1qtlIOpOwK2fycK7vREumaKGRJgsBBT8YhHjP3AXB
        J21gy/ylLlDM4sB2toxtT3U+q3rGNo/txpGfrh7xOQT7wHT49B01CFwmnKamCHv3ajDAQT
        0mOf/HRVls7FUdU0ToelmrkV2nORcHK7ZyqinR8Nra3OWcWD/snumIh7f4OhyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682694521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5TzCBkAhEE1r9irTGgb6179fix0fEgXAdCpZoHyDzVI=;
        b=jj7FBTWTX9bihWh0CWpImC5fpwDxYq2wIBad79IC/ubRbO+hCYQQO3MS/HThyJfdwpACf8
        BmJqp2hDxJJ5YZDw==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 14/18] wifi: rtl8xxxu: Clean up filter configuration
Date:   Fri, 28 Apr 2023 17:08:29 +0200
Message-Id: <20230428150833.218605-15-martin.kaistra@linutronix.de>
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

When RCR_CHECK_BSSID_MATCH is set in AP mode, we don't receive any data
frames. Rearrange RCR bits to filter flags to match other realtek drivers
and remove RCR_CHECK_BSSID_MATCH in AP mode.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 2e075094a37a5..9e9d172a37f1e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6689,22 +6689,22 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 	 */
 
 	if (*total_flags & FIF_BCN_PRBRESP_PROMISC)
-		rcr &= ~RCR_CHECK_BSSID_BEACON;
+		rcr &= ~(RCR_CHECK_BSSID_BEACON | RCR_CHECK_BSSID_MATCH);
 	else
-		rcr |= RCR_CHECK_BSSID_BEACON;
+		rcr |= RCR_CHECK_BSSID_BEACON | RCR_CHECK_BSSID_MATCH;
+
+	if (priv->vif && priv->vif->type == NL80211_IFTYPE_AP)
+		rcr &= ~RCR_CHECK_BSSID_MATCH;
 
 	if (*total_flags & FIF_CONTROL)
 		rcr |= RCR_ACCEPT_CTRL_FRAME;
 	else
 		rcr &= ~RCR_ACCEPT_CTRL_FRAME;
 
-	if (*total_flags & FIF_OTHER_BSS) {
+	if (*total_flags & FIF_OTHER_BSS)
 		rcr |= RCR_ACCEPT_AP;
-		rcr &= ~RCR_CHECK_BSSID_MATCH;
-	} else {
+	else
 		rcr &= ~RCR_ACCEPT_AP;
-		rcr |= RCR_CHECK_BSSID_MATCH;
-	}
 
 	if (*total_flags & FIF_PSPOLL)
 		rcr |= RCR_ACCEPT_PM;
-- 
2.30.2


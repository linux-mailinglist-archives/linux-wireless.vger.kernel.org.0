Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB1D6C523A
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 18:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCVRTo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 13:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjCVRT3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 13:19:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7635267001
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 10:19:15 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679505551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XUXUwnxkFGgPFMoE0610Xdltz8qG3jRuoMtYF72QBDI=;
        b=KBsG4I75W2mrudSvKfngPm0gUN8jtWC3Mm7XOX92SNlyrU5x0oVAj3vJkWO31+XzmEmkPK
        rGKZH5xM1fCxiYrbc+6kcCXIbjWK8tlliaIvuLuZGYgGH94txVUev6/WWO3kLH4Xohf9CD
        euUmejwfVO0II7Et2qapTXYg8B8ypvO0xC51h8y1dibvTUKykqniB261OlMuNeevZ1iyT0
        Pw83B+woNiEAtYMhUrJrAZoJbN+mxDzbZHutdxxEuihq/tKFu747HAdy4E2MnAtZxw/Rho
        6j4Y7MA3x9gCMIlicR9ezXPn9knOs3C9s0nFI+0uTXkX67lQGXYRPN0Y0F7ppw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679505551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XUXUwnxkFGgPFMoE0610Xdltz8qG3jRuoMtYF72QBDI=;
        b=Y/r77Pybyd3b5AOraz7jNefwWbO/yzZ+LC5OudTzWoRVw3PYSdPNSLlzn0aLpN2vRi3X++
        ewQlkgkQmMGcjKBA==
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 04/14] wifi: rtl8xxxu: Add set_tim() callback
Date:   Wed, 22 Mar 2023 18:18:55 +0100
Message-Id: <20230322171905.492855-5-martin.kaistra@linutronix.de>
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

Update beacon content if TIM bitmap maintained by mac80211 is changed.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 404fa6e322f58..f8380a2d51ae2 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4438,6 +4438,16 @@ int rtl8xxxu_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
 	return 0;
 }
 
+static int rtl8xxxu_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
+			    bool set)
+{
+	struct rtl8xxxu_priv *priv = hw->priv;
+
+	schedule_work(&priv->update_beacon_work);
+
+	return 0;
+}
+
 static void rtl8xxxu_sw_scan_start(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif, const u8 *mac)
 {
@@ -7133,6 +7143,7 @@ static const struct ieee80211_ops rtl8xxxu_ops = {
 	.ampdu_action = rtl8xxxu_ampdu_action,
 	.sta_statistics = rtl8xxxu_sta_statistics,
 	.get_antenna = rtl8xxxu_get_antenna,
+	.set_tim = rtl8xxxu_set_tim,
 };
 
 static int rtl8xxxu_parse_usb(struct rtl8xxxu_priv *priv,
-- 
2.30.2


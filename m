Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D947CAAAB
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Oct 2023 16:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjJPOAU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Oct 2023 10:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjJPOAS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Oct 2023 10:00:18 -0400
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [178.154.239.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBC8F7
        for <linux-wireless@vger.kernel.org>; Mon, 16 Oct 2023 07:00:13 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:478a:0:640:c46b:0])
        by forward102c.mail.yandex.net (Yandex) with ESMTP id B07C860AC8;
        Mon, 16 Oct 2023 17:00:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 70kRYkgDdGk0-poqSKrtK;
        Mon, 16 Oct 2023 17:00:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1697464811; bh=kOJ7II6tO7S4iwpyYiG177/0iJxu7rc9nBqTYoXZum8=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=BeYGoHSxmd1ofF51p//cWccvyR4z2qURDOOLKwKwWn11La6NwSjZFJZAilPOkl0YM
         cM4JWX6fEiqFKqOskDdEx3YKDxGcAiaMbAc8ye8jIxwSTNDR/1lfVRCok+tu/ceiuQ
         dAiAQECQZBfympQi3sl0TGNuo32T2wrFO9PB8y1c=
Authentication-Results: mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 3/3] wifi: rtlwifi: drop chk_switch_dmdp() from HAL interface
Date:   Mon, 16 Oct 2023 16:59:10 +0300
Message-ID: <20231016135925.129223-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016135925.129223-1-dmantipov@yandex.ru>
References: <20231016135925.129223-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since there is no chip-specific code behind 'chk_switch_dmdp()',
there is no need to maintain function pointer in 'struct rtl_hal_ops'
and relevant common code may be simplified. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtlwifi/base.c |  6 ------
 drivers/net/wireless/realtek/rtlwifi/core.c | 16 ----------------
 drivers/net/wireless/realtek/rtlwifi/wifi.h |  1 -
 3 files changed, 23 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index 807a53a97325..7ce37fb4fdbf 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -1317,12 +1317,6 @@ bool rtl_tx_mgmt_proc(struct ieee80211_hw *hw, struct sk_buff *skb)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	__le16 fc = rtl_get_fc(skb);
 
-	if (rtlpriv->dm.supp_phymode_switch &&
-	    mac->link_state < MAC80211_LINKED &&
-	    (ieee80211_is_auth(fc) || ieee80211_is_probe_req(fc))) {
-		if (rtlpriv->cfg->ops->chk_switch_dmdp)
-			rtlpriv->cfg->ops->chk_switch_dmdp(hw);
-	}
 	if (ieee80211_is_auth(fc)) {
 		rtl_dbg(rtlpriv, COMP_SEND, DBG_DMESG, "MAC80211_LINKING\n");
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/core.c b/drivers/net/wireless/realtek/rtlwifi/core.c
index cc9b2a459386..69e97647e3d6 100644
--- a/drivers/net/wireless/realtek/rtlwifi/core.c
+++ b/drivers/net/wireless/realtek/rtlwifi/core.c
@@ -662,13 +662,6 @@ static int rtl_op_config(struct ieee80211_hw *hw, u32 changed)
 		if (mac->act_scanning)
 			mac->n_channels++;
 
-		if (rtlpriv->dm.supp_phymode_switch &&
-			mac->link_state < MAC80211_LINKED &&
-			!mac->act_scanning) {
-			if (rtlpriv->cfg->ops->chk_switch_dmdp)
-				rtlpriv->cfg->ops->chk_switch_dmdp(hw);
-		}
-
 		/*
 		 *because we should back channel to
 		 *current_network.chan in scanning,
@@ -1197,10 +1190,6 @@ static void rtl_op_bss_info_changed(struct ieee80211_hw *hw,
 			mac->vendor = PEER_UNKNOWN;
 			mac->mode = 0;
 
-			if (rtlpriv->dm.supp_phymode_switch) {
-				if (rtlpriv->cfg->ops->chk_switch_dmdp)
-					rtlpriv->cfg->ops->chk_switch_dmdp(hw);
-			}
 			rtl_dbg(rtlpriv, COMP_MAC80211, DBG_DMESG,
 				"BSS_CHANGED_UN_ASSOC\n");
 		}
@@ -1464,11 +1453,6 @@ static void rtl_op_sw_scan_start(struct ieee80211_hw *hw,
 		rtlpriv->btcoexist.btc_ops->btc_scan_notify_wifi_only(rtlpriv,
 								      1);
 
-	if (rtlpriv->dm.supp_phymode_switch) {
-		if (rtlpriv->cfg->ops->chk_switch_dmdp)
-			rtlpriv->cfg->ops->chk_switch_dmdp(hw);
-	}
-
 	if (mac->link_state == MAC80211_LINKED) {
 		rtl_lps_leave(hw, true);
 		mac->link_state = MAC80211_LINKED_SCANNING;
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 434cb2b4ec8b..d3028b02d0bd 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2279,7 +2279,6 @@ struct rtl_hal_ops {
 	void (*set_rfreg)(struct ieee80211_hw *hw, enum radio_path rfpath,
 			  u32 regaddr, u32 bitmask, u32 data);
 	void (*linked_set_reg)(struct ieee80211_hw *hw);
-	void (*chk_switch_dmdp)(struct ieee80211_hw *hw);
 	void (*dualmac_switch_to_dmdp)(struct ieee80211_hw *hw);
 	bool (*phy_rf6052_config)(struct ieee80211_hw *hw);
 	void (*phy_rf6052_set_cck_txpower)(struct ieee80211_hw *hw,
-- 
2.41.0


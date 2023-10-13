Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832CD7C8602
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Oct 2023 14:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjJMMp7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Oct 2023 08:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjJMMp5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Oct 2023 08:45:57 -0400
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C35CC
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 05:45:53 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:6e01:0:640:627f:0])
        by forward101c.mail.yandex.net (Yandex) with ESMTP id 32D3660AAC;
        Fri, 13 Oct 2023 15:45:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id njfdsi4DaqM0-WTJ0MPH0;
        Fri, 13 Oct 2023 15:45:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1697201150; bh=yuOpAU+dL4/CjjdIvpJwucbOBSI2ABJqzyXyj5aOWCQ=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=R72NODc0IqyE5NWJSyP4bSa61TMkarN8xrfFjbG9vR6BNWTGya+L+3U9OdjRoTuPM
         7lUt3jTEId7OT/WXdACPp2+pjUhRVzPDxxFumDpb85PIbfJX4qxCi9khcjo46K+z3o
         rCITplMVItwBUXZ8Hj79wpEgZ/lffHh2ejp3h+1M=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] [v2] wifi: rtlwifi: cleanup struct rtl_ps_ctl
Date:   Fri, 13 Oct 2023 15:45:31 +0300
Message-ID: <20231013124534.19714-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <a4bb3324101e4269b7a922ea8ae70875@realtek.com>
References: <a4bb3324101e4269b7a922ea8ae70875@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove set but otherwise unused 'sleep_ms', 'last_action', 'state'
and 'last_slept' members of 'struct rtl_ps_ctl' (these seems to be
a leftovers from some older code) and adjust 'rtl_swlps_wq_callback()'
accordingly. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: drop 'state' member and related code as well (Ping-Ke Shih)
---
 drivers/net/wireless/realtek/rtlwifi/ps.c   | 17 +----------------
 drivers/net/wireless/realtek/rtlwifi/wifi.h |  4 ----
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/ps.c b/drivers/net/wireless/realtek/rtlwifi/ps.c
index 629c03271bde..6241e4fed4f6 100644
--- a/drivers/net/wireless/realtek/rtlwifi/ps.c
+++ b/drivers/net/wireless/realtek/rtlwifi/ps.c
@@ -681,25 +681,10 @@ void rtl_swlps_wq_callback(struct work_struct *work)
 						  ps_work.work);
 	struct ieee80211_hw *hw = rtlworks->hw;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	bool ps = false;
-
-	ps = (hw->conf.flags & IEEE80211_CONF_PS);
 
 	/* we can sleep after ps null send ok */
-	if (rtlpriv->psc.state_inap) {
+	if (rtlpriv->psc.state_inap)
 		rtl_swlps_rf_sleep(hw);
-
-		if (rtlpriv->psc.state && !ps) {
-			rtlpriv->psc.sleep_ms = jiffies_to_msecs(jiffies -
-						 rtlpriv->psc.last_action);
-		}
-
-		if (ps)
-			rtlpriv->psc.last_slept = jiffies;
-
-		rtlpriv->psc.last_action = jiffies;
-		rtlpriv->psc.state = ps;
-	}
 }
 
 static void rtl_p2p_noa_ie(struct ieee80211_hw *hw, void *data,
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 47b4685b6d24..e1004c4c928e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2032,19 +2032,15 @@ struct rtl_ps_ctl {
 
 	/* for SW LPS*/
 	bool sw_ps_enabled;
-	bool state;
 	bool state_inap;
 	bool multi_buffered;
 	u16 nullfunc_seq;
 	unsigned int dtim_counter;
-	unsigned int sleep_ms;
 	unsigned long last_sleep_jiffies;
 	unsigned long last_awake_jiffies;
 	unsigned long last_delaylps_stamp_jiffies;
 	unsigned long last_dtim;
 	unsigned long last_beacon;
-	unsigned long last_action;
-	unsigned long last_slept;
 
 	/*For P2P PS */
 	struct rtl_p2p_ps_info p2p_ps_info;
-- 
2.41.0


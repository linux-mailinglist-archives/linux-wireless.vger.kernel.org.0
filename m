Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AAA7195A6
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 10:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjFAIdN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 04:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjFAIcb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 04:32:31 -0400
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33921196
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 01:31:20 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5329:0:640:44d3:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id B150F60049;
        Thu,  1 Jun 2023 11:31:15 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 5VJLWClDc8c0-Uk16MIVI;
        Thu, 01 Jun 2023 11:31:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1685608275;
        bh=AbUczu2iL2RKhCux2S9Knwml6W7WBE9hLveBFZUPc1M=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=NXmjcalpcSU1KsNh8YH2YbCFZ77ak0K9KoTHfLoaQHS43RcINdi+SKmOwK3fw9YNQ
         e1SZsyGIlV9swougq29V4vFhyoca7Wkp3KrL9Oe/mrxdY4y6dFNgD5Gj/DaPWsuO4H
         ig5pPGWCclytU8ThMaE+OBHfxdkDZRk++lIvJo6g=
Authentication-Results: mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] [v4] wifi: rtlwifi: remove unused timer and related code
Date:   Thu,  1 Jun 2023 11:31:03 +0300
Message-Id: <20230601083103.45862-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601081715.44739-1-dmantipov@yandex.ru>
References: <20230601081715.44739-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Drop unused 'dualmac_easyconcurrent_retrytimer' of 'struct rtl_works',
corresponding 'rtl_easy_concurrent_retrytimer_callback()' handler,
'dualmac_easy_concurrent' function pointer of 'struct rtl_hal_ops'
and related call to 'timer_setup()' in '_rtl_init_deferred_work()'.

---
v4: changelog quirks (Ping-Ke Shih)
v3: make Signed-off-by: to match From: (Kalle Vallo)
v2: fix title (Ping-Ke Shih)

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtlwifi/base.c | 16 +---------------
 drivers/net/wireless/realtek/rtlwifi/base.h |  1 -
 drivers/net/wireless/realtek/rtlwifi/wifi.h |  2 --
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index 9e7e98b55eff..44846e96b2ab 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -452,8 +452,7 @@ static int _rtl_init_deferred_work(struct ieee80211_hw *hw)
 	/* <1> timer */
 	timer_setup(&rtlpriv->works.watchdog_timer,
 		    rtl_watch_dog_timer_callback, 0);
-	timer_setup(&rtlpriv->works.dualmac_easyconcurrent_retrytimer,
-		    rtl_easy_concurrent_retrytimer_callback, 0);
+
 	/* <2> work queue */
 	rtlpriv->works.hw = hw;
 	rtlpriv->works.rtl_wq = wq;
@@ -2366,19 +2365,6 @@ static void rtl_c2hcmd_wq_callback(struct work_struct *work)
 	rtl_c2hcmd_launcher(hw, 1);
 }
 
-void rtl_easy_concurrent_retrytimer_callback(struct timer_list *t)
-{
-	struct rtl_priv *rtlpriv =
-		from_timer(rtlpriv, t, works.dualmac_easyconcurrent_retrytimer);
-	struct ieee80211_hw *hw = rtlpriv->hw;
-	struct rtl_priv *buddy_priv = rtlpriv->buddy_priv;
-
-	if (buddy_priv == NULL)
-		return;
-
-	rtlpriv->cfg->ops->dualmac_easy_concurrent(hw);
-}
-
 /*********************************************************
  *
  * frame process functions
diff --git a/drivers/net/wireless/realtek/rtlwifi/base.h b/drivers/net/wireless/realtek/rtlwifi/base.h
index 0e4f8a8ae3a5..f081a9a90563 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.h
+++ b/drivers/net/wireless/realtek/rtlwifi/base.h
@@ -124,7 +124,6 @@ int rtl_send_smps_action(struct ieee80211_hw *hw,
 u8 *rtl_find_ie(u8 *data, unsigned int len, u8 ie);
 void rtl_recognize_peer(struct ieee80211_hw *hw, u8 *data, unsigned int len);
 u8 rtl_tid_to_ac(u8 tid);
-void rtl_easy_concurrent_retrytimer_callback(struct timer_list *t);
 extern struct rtl_global_var rtl_global_var;
 void rtl_phy_scan_operation_backup(struct ieee80211_hw *hw, u8 operation);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 082af216760f..bc1d68cb9183 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2300,7 +2300,6 @@ struct rtl_hal_ops {
 			  u32 regaddr, u32 bitmask, u32 data);
 	void (*linked_set_reg)(struct ieee80211_hw *hw);
 	void (*chk_switch_dmdp)(struct ieee80211_hw *hw);
-	void (*dualmac_easy_concurrent)(struct ieee80211_hw *hw);
 	void (*dualmac_switch_to_dmdp)(struct ieee80211_hw *hw);
 	bool (*phy_rf6052_config)(struct ieee80211_hw *hw);
 	void (*phy_rf6052_set_cck_txpower)(struct ieee80211_hw *hw,
@@ -2465,7 +2464,6 @@ struct rtl_works {
 
 	/*timer */
 	struct timer_list watchdog_timer;
-	struct timer_list dualmac_easyconcurrent_retrytimer;
 	struct timer_list fw_clockoff_timer;
 	struct timer_list fast_antenna_training_timer;
 	/*task */
-- 
2.40.1


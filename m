Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7847A7D2DEA
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 11:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjJWJSH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 05:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjJWJSG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 05:18:06 -0400
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76EF98
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 02:18:02 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:c20c:0:640:6c41:0])
        by forward102a.mail.yandex.net (Yandex) with ESMTP id 3D8EA60032;
        Mon, 23 Oct 2023 12:17:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id tHJ9fb1DZSw0-XpDSqD2K;
        Mon, 23 Oct 2023 12:17:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1698052677; bh=iap/sldgc82q14rWL5QyjORh3zxOPPUBdX9NBVVdZ0A=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=xElhUKRTSTAUDnp8mCcOkjjHcZDn2E9z5KfQVWOn8x9otx7N0VEq/CkoTPBOKt7dg
         CWRYPa84xS/fJfN5vlCtxsXE8hKu+I6Lkpd50ECJzzF5CY3Rb72GErALvIS99+GliL
         16L+8Mn+BlxVXnC6CeIDJknhOV08pSf5eCH7up6I=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 3/3] [v2] wifi: rtlwifi: typo fix
Date:   Mon, 23 Oct 2023 12:17:06 +0300
Message-ID: <20231023091722.52509-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023091722.52509-1-dmantipov@yandex.ru>
References: <5b9ea29daaaa4ebb8bc75cd384aaee80@realtek.com>
 <20231023091722.52509-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For rtl8192ee, change 'rtl92ee_dm_dynamic_primary_cca_ckeck()'
to 'rtl92ee_dm_dynamic_primary_cca_check()' and so adjust
'rtl92ee_dm_watchdog()' as well. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: join the series
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
index fad132512a20..17486e3f322c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
@@ -560,7 +560,7 @@ static void rtl92ee_dm_write_dynamic_cca(struct ieee80211_hw *hw,
 	primarycca->mf_state = cur_mf_state;
 }
 
-static void rtl92ee_dm_dynamic_primary_cca_ckeck(struct ieee80211_hw *hw)
+static void rtl92ee_dm_dynamic_primary_cca_check(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct false_alarm_statistics *falsealm_cnt = &rtlpriv->falsealm_cnt;
@@ -1083,7 +1083,7 @@ void rtl92ee_dm_watchdog(struct ieee80211_hw *hw)
 		rtl92ee_dm_refresh_rate_adaptive_mask(hw);
 		rtl92ee_dm_check_edca_turbo(hw);
 		rtl92ee_dm_dynamic_atc_switch(hw);
-		rtl92ee_dm_dynamic_primary_cca_ckeck(hw);
+		rtl92ee_dm_dynamic_primary_cca_check(hw);
 	}
 	spin_unlock(&rtlpriv->locks.rf_ps_lock);
 }
-- 
2.41.0


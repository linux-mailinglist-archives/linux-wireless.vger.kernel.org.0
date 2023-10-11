Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E417C48E8
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 06:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344777AbjJKExZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 00:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjJKExZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 00:53:25 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7060E94
        for <linux-wireless@vger.kernel.org>; Tue, 10 Oct 2023 21:53:18 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net [IPv6:2a02:6b8:c00:2584:0:640:9f7a:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id E305360993;
        Wed, 11 Oct 2023 07:53:15 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ErV7pqNDdeA0-SJvCyZI0;
        Wed, 11 Oct 2023 07:53:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1696999995; bh=StAW872blpzgQMdiGYJLukgGlBYRTrMPOUt9UDIO73o=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=Rd5CDc9qnbQNWwaWe34L6jqYSdR9ME9y2dizLTwPxwXUpaUs0HFc84v9Y14mW5SI9
         fzzVh2YddKxh9E0glqx0MglTCkUC3HEyyjLw8pwKmJAc+kj7YU6Y3S8cMBfWqoXbbD
         5kokSMhJ2oWEX+EiEhkQgydWaYXghUm0y8mJy6MY=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] [v2] wifi: rtlwifi: use convenient list_count_nodes()
Date:   Wed, 11 Oct 2023 07:52:01 +0300
Message-ID: <20231011045227.7989-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cbbd8f38e9ef4e3dba415952cf466ee8@realtek.com>
References: <cbbd8f38e9ef4e3dba415952cf466ee8@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Simplify 'rtl92ee_dm_common_info_self_update()',
'rtl8723be_dm_common_info_self_update()', and
'rtl8821ae_dm_common_info_self_update()' by using
'list_count_nodes()'. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: drop redundant initializers (Ping-Ke Shih)
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c | 7 ++-----
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c | 7 ++-----
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c | 6 ++----
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
index 997ff115b9ab..5a828a934fe9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
@@ -936,8 +936,7 @@ void rtl92ee_dm_init(struct ieee80211_hw *hw)
 static void rtl92ee_dm_common_info_self_update(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_sta_info *drv_priv;
-	u8 cnt = 0;
+	u8 cnt;
 
 	rtlpriv->dm.one_entry_only = false;
 
@@ -951,9 +950,7 @@ static void rtl92ee_dm_common_info_self_update(struct ieee80211_hw *hw)
 	    rtlpriv->mac80211.opmode == NL80211_IFTYPE_ADHOC ||
 	    rtlpriv->mac80211.opmode == NL80211_IFTYPE_MESH_POINT) {
 		spin_lock_bh(&rtlpriv->locks.entry_list_lock);
-		list_for_each_entry(drv_priv, &rtlpriv->entry_list, list) {
-			cnt++;
-		}
+		cnt = list_count_nodes(&rtlpriv->entry_list);
 		spin_unlock_bh(&rtlpriv->locks.entry_list_lock);
 
 		if (cnt == 1)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c
index c3c990cc032f..c53f95144812 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c
@@ -1210,8 +1210,7 @@ static void rtl8723be_dm_dynamic_atc_switch(struct ieee80211_hw *hw)
 static void rtl8723be_dm_common_info_self_update(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u8 cnt = 0;
-	struct rtl_sta_info *drv_priv;
+	u8 cnt;
 
 	rtlpriv->dm.one_entry_only = false;
 
@@ -1225,9 +1224,7 @@ static void rtl8723be_dm_common_info_self_update(struct ieee80211_hw *hw)
 		rtlpriv->mac80211.opmode == NL80211_IFTYPE_ADHOC ||
 		rtlpriv->mac80211.opmode == NL80211_IFTYPE_MESH_POINT) {
 		spin_lock_bh(&rtlpriv->locks.entry_list_lock);
-		list_for_each_entry(drv_priv, &rtlpriv->entry_list, list) {
-			cnt++;
-		}
+		cnt = list_count_nodes(&rtlpriv->entry_list);
 		spin_unlock_bh(&rtlpriv->locks.entry_list_lock);
 
 		if (cnt == 1)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
index f3fe16798c59..76b5395539d0 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
@@ -827,8 +827,7 @@ static void rtl8821ae_dm_dig(struct ieee80211_hw *hw)
 static void rtl8821ae_dm_common_info_self_update(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	u8 cnt = 0;
-	struct rtl_sta_info *drv_priv;
+	u8 cnt;
 
 	rtlpriv->dm.tx_rate = 0xff;
 
@@ -844,8 +843,7 @@ static void rtl8821ae_dm_common_info_self_update(struct ieee80211_hw *hw)
 	    rtlpriv->mac80211.opmode == NL80211_IFTYPE_ADHOC ||
 	    rtlpriv->mac80211.opmode == NL80211_IFTYPE_MESH_POINT) {
 		spin_lock_bh(&rtlpriv->locks.entry_list_lock);
-		list_for_each_entry(drv_priv, &rtlpriv->entry_list, list)
-			cnt++;
+		cnt = list_count_nodes(&rtlpriv->entry_list);
 		spin_unlock_bh(&rtlpriv->locks.entry_list_lock);
 
 		if (cnt == 1)
-- 
2.41.0


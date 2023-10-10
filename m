Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C966D7BFCDE
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Oct 2023 15:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjJJNEm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Oct 2023 09:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjJJNEl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Oct 2023 09:04:41 -0400
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [178.154.239.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024BFB7
        for <linux-wireless@vger.kernel.org>; Tue, 10 Oct 2023 06:04:33 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:1116:0:640:d64e:0])
        by forward100c.mail.yandex.net (Yandex) with ESMTP id 0FD2060AF6;
        Tue, 10 Oct 2023 16:04:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id T4dMM5FBc4Y0-pYhbnZjp;
        Tue, 10 Oct 2023 16:04:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1696943070; bh=ndLT2fKpXBuRMxvKj9I+u1TXiaVTTvlVHOoVUFBI3GY=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=ZDvBYCicslPeu8WCCWuvih73OOVXmMQuATzpDUpaBj/dpLzvZdA+p2+5ntW41QWre
         nj1tex7F8/AHlIh9tegEIFFMnEnAqcyabG9cWJqTOCDVfp3IbCmr7+bNtic7jxHouh
         LOl2m1nER7hRcvhf4AU5VieF1PHUqtBmW01OJgiM=
Authentication-Results: mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rtlwifi: use convenient list_count_nodes()
Date:   Tue, 10 Oct 2023 16:03:50 +0300
Message-ID: <20231010130353.30461-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c | 5 +----
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c | 5 +----
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c | 4 +---
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
index 997ff115b9ab..efd22b75c05f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
@@ -936,7 +936,6 @@ void rtl92ee_dm_init(struct ieee80211_hw *hw)
 static void rtl92ee_dm_common_info_self_update(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_sta_info *drv_priv;
 	u8 cnt = 0;
 
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
index c3c990cc032f..a54faec6f8a8 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c
@@ -1211,7 +1211,6 @@ static void rtl8723be_dm_common_info_self_update(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 cnt = 0;
-	struct rtl_sta_info *drv_priv;
 
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
index f3fe16798c59..fd739e482d0a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
@@ -828,7 +828,6 @@ static void rtl8821ae_dm_common_info_self_update(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 cnt = 0;
-	struct rtl_sta_info *drv_priv;
 
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


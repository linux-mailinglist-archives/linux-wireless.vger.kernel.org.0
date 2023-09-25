Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9877AD427
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 11:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjIYJFk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 05:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjIYJFj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 05:05:39 -0400
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D269B
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 02:05:29 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:47bd:0:640:2492:0])
        by forward103a.mail.yandex.net (Yandex) with ESMTP id F1DD546D13;
        Mon, 25 Sep 2023 12:05:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id M5K7oI0DdSw0-ft929BAB;
        Mon, 25 Sep 2023 12:05:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1695632723; bh=kKfLp1H49Qc/kK7vSip8/lj1lHh3sFtrzPliLozGPn8=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=k06siXduevAxd5eZPFtgouqW5finPnKlKODqYi1kQwyaqz8XvpScTIdHFh7RwQG4m
         aH2aLy8+wxCP73kcKZ5g2jJvrjnifKw00LZibdp5RrZfsB76NkDLGEx+EhY4ugQuYv
         OrsqCxZk+lPw++GC+XuP+ZBlDwcMzgbwHcG8Fohg=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rtlwifi: cleanup few rtlxxxx_set_hw_reg() routines
Date:   Mon, 25 Sep 2023 12:04:48 +0300
Message-ID: <20230925090452.25633-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
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

Since 'u8' comparison against zero is always false, drop the
corresponding branches of AMPDU_MIN_SPACE adjustment within
'rtlxxxx_set_hw_reg()' for rtl8188ee, rtl8192ce, rtl8192de,
rtl8723ae, rtl8723be, and rtl8821ae. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c | 5 -----
 drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c | 5 -----
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c | 4 ----
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c | 5 -----
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c | 6 ------
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c | 5 -----
 6 files changed, 30 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
index 58b1a46066b5..27f6c35ba0f9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
@@ -433,14 +433,9 @@ void rtl88ee_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 		break;
 	case HW_VAR_AMPDU_MIN_SPACE:{
 		u8 min_spacing_to_set;
-		u8 sec_min_space;
 
 		min_spacing_to_set = *val;
 		if (min_spacing_to_set <= 7) {
-			sec_min_space = 0;
-
-			if (min_spacing_to_set < sec_min_space)
-				min_spacing_to_set = sec_min_space;
 
 			mac->min_space_cfg = ((mac->min_space_cfg &
 					       0xf8) |
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c
index 049c4fe9eeed..0bc915723b93 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c
@@ -208,14 +208,9 @@ void rtl92ce_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 		}
 	case HW_VAR_AMPDU_MIN_SPACE:{
 			u8 min_spacing_to_set;
-			u8 sec_min_space;
 
 			min_spacing_to_set = *val;
 			if (min_spacing_to_set <= 7) {
-				sec_min_space = 0;
-
-				if (min_spacing_to_set < sec_min_space)
-					min_spacing_to_set = sec_min_space;
 
 				mac->min_space_cfg = ((mac->min_space_cfg &
 						       0xf8) |
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
index 31a18bbface9..743ac6871bf4 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
@@ -225,13 +225,9 @@ void rtl92de_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 	}
 	case HW_VAR_AMPDU_MIN_SPACE: {
 		u8 min_spacing_to_set;
-		u8 sec_min_space;
 
 		min_spacing_to_set = *val;
 		if (min_spacing_to_set <= 7) {
-			sec_min_space = 0;
-			if (min_spacing_to_set < sec_min_space)
-				min_spacing_to_set = sec_min_space;
 			mac->min_space_cfg = ((mac->min_space_cfg & 0xf8) |
 					      min_spacing_to_set);
 			*val = min_spacing_to_set;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
index d26d4c4314a3..6991713a66d0 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
@@ -212,14 +212,9 @@ void rtl8723e_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 		}
 	case HW_VAR_AMPDU_MIN_SPACE:{
 			u8 min_spacing_to_set;
-			u8 sec_min_space;
 
 			min_spacing_to_set = *((u8 *)val);
 			if (min_spacing_to_set <= 7) {
-				sec_min_space = 0;
-
-				if (min_spacing_to_set < sec_min_space)
-					min_spacing_to_set = sec_min_space;
 
 				mac->min_space_cfg = ((mac->min_space_cfg &
 						       0xf8) |
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
index 15575644551f..0e77de1baaf8 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
@@ -468,15 +468,9 @@ void rtl8723be_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 		break;
 	case HW_VAR_AMPDU_MIN_SPACE:{
 		u8 min_spacing_to_set;
-		u8 sec_min_space;
 
 		min_spacing_to_set = *((u8 *)val);
 		if (min_spacing_to_set <= 7) {
-			sec_min_space = 0;
-
-			if (min_spacing_to_set < sec_min_space)
-				min_spacing_to_set = sec_min_space;
-
 			mac->min_space_cfg = ((mac->min_space_cfg & 0xf8) |
 					      min_spacing_to_set);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
index 3f8f6da33b12..1633328bc3d1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
@@ -546,14 +546,9 @@ void rtl8821ae_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 		break;
 	case HW_VAR_AMPDU_MIN_SPACE:{
 		u8 min_spacing_to_set;
-		u8 sec_min_space;
 
 		min_spacing_to_set = *((u8 *)val);
 		if (min_spacing_to_set <= 7) {
-			sec_min_space = 0;
-
-			if (min_spacing_to_set < sec_min_space)
-				min_spacing_to_set = sec_min_space;
 
 			mac->min_space_cfg = ((mac->min_space_cfg &
 					       0xf8) |
-- 
2.41.0


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509AA73B1CE
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jun 2023 09:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjFWHki (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jun 2023 03:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFWHkg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jun 2023 03:40:36 -0400
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [178.154.239.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40541988
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jun 2023 00:40:33 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3b27:0:640:a9e4:0])
        by forward101c.mail.yandex.net (Yandex) with ESMTP id 2406960047;
        Fri, 23 Jun 2023 10:40:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id UeBtAtSDauQ0-U5HosVMl;
        Fri, 23 Jun 2023 10:40:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687506030;
        bh=hcJCwXrGazl14+q+Y2NH+1oxpaFyHLkqzcrGUUqs5tE=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=AHSFwajPyHWVeHGXhAHFA94sKwIFRqejyNqeTmStUp9ddMIf5RSDawGIHfZIdjZx+
         ToG91tieX/wVSB0vBYdsq0JawhhihmQHxUDRSyCuSzWGt4+W8ORjBpBY0WuxSUkzWy
         IQrgoP02tKARRgXV614pVUCrVyuwEbaDU43zP6Ys=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Siddhesh Poyarekar <siddhesh@gotplt.org>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: fix a bunch of clang-only fortify warnings
Date:   Fri, 23 Jun 2023 10:40:02 +0300
Message-ID: <20230623074026.94649-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When compiling with clang 16.0.5 and CONFIG_FORTIFY_SOURCE=y, I've
noticed a few similar warnings:

In file included from [filename:lineno]:
[...include stack skipped...]
In file included from ./include/linux/string.h:254:
./include/linux/fortify-string.h:529:4: warning: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
  529 |                         __read_overflow2_field(q_size_field, size);

The warning is confusing because the compiler actually complains on:

memcpy(data, *[string stats array], sizeof([string stats array]);

This is duplicated among a few drivers and interpreted as an attempt to
copy the whole array using its first (32-byte) member as a source buffer.
To silence this warning, it's enough to pass an address of array instead
of an address of its first member.

Note this warning is clang-only due to gcc bug[1] recently reported at [2].
Thanks to Siddhesh Poyarekar <siddhesh@gotplt.org> for sorting this out.

[1]. https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110373
[2]. https://lists.openwall.net/linux-hardening/2023/06/22/15

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath10k/debug.c          | 2 +-
 drivers/net/wireless/ath/ath9k/debug.c           | 2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c   | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 2 +-
 drivers/net/wireless/purelifi/plfxlc/mac.c       | 2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c    | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index f9518e1c9903..fe89bc61e531 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -1140,7 +1140,7 @@ void ath10k_debug_get_et_strings(struct ieee80211_hw *hw,
 				 u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *ath10k_gstrings_stats,
+		memcpy(data, ath10k_gstrings_stats,
 		       sizeof(ath10k_gstrings_stats));
 }
 
diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index fb7a2952d0ce..d9bac1c34349 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -1333,7 +1333,7 @@ void ath9k_get_et_strings(struct ieee80211_hw *hw,
 			  u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *ath9k_gstrings_stats,
+		memcpy(data, ath9k_gstrings_stats,
 		       sizeof(ath9k_gstrings_stats));
 }
 
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
index b3ed65e5c4da..b0a31a56834e 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
@@ -428,7 +428,7 @@ void ath9k_htc_get_et_strings(struct ieee80211_hw *hw,
 			      u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *ath9k_htc_gstrings_stats,
+		memcpy(data, ath9k_htc_gstrings_stats,
 		       sizeof(ath9k_htc_gstrings_stats));
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 1b361199c061..77d3303d8108 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1292,7 +1292,7 @@ void mt7915_get_et_strings(struct ieee80211_hw *hw,
 	if (sset != ETH_SS_STATS)
 		return;
 
-	memcpy(data, *mt7915_gstrings_stats, sizeof(mt7915_gstrings_stats));
+	memcpy(data, mt7915_gstrings_stats, sizeof(mt7915_gstrings_stats));
 	data += sizeof(mt7915_gstrings_stats);
 	page_pool_ethtool_stats_get_strings(data);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 3b6adb29cbef..b71ee4c8ed0d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1088,7 +1088,7 @@ mt7921_get_et_strings(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (sset != ETH_SS_STATS)
 		return;
 
-	memcpy(data, *mt7921_gstrings_stats, sizeof(mt7921_gstrings_stats));
+	memcpy(data, mt7921_gstrings_stats, sizeof(mt7921_gstrings_stats));
 
 	if (mt76_is_sdio(&dev->mt76))
 		return;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index f306e9c50ea3..cb1ce560cf40 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1164,7 +1164,7 @@ void mt7996_get_et_strings(struct ieee80211_hw *hw,
 			   u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *mt7996_gstrings_stats,
+		memcpy(data, mt7996_gstrings_stats,
 		       sizeof(mt7996_gstrings_stats));
 }
 
diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.c b/drivers/net/wireless/purelifi/plfxlc/mac.c
index 94ee831b5de3..506d2f31efb5 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.c
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.c
@@ -666,7 +666,7 @@ static void plfxlc_get_et_strings(struct ieee80211_hw *hw,
 				  u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *et_strings, sizeof(et_strings));
+		memcpy(data, et_strings, sizeof(et_strings));
 }
 
 static void plfxlc_get_et_stats(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index f446fd0e8cd0..1ace3c886763 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -3171,7 +3171,7 @@ static void mac80211_hwsim_get_et_strings(struct ieee80211_hw *hw,
 					  u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *mac80211_hwsim_gstrings_stats,
+		memcpy(data, mac80211_hwsim_gstrings_stats,
 		       sizeof(mac80211_hwsim_gstrings_stats));
 }
 
-- 
2.41.0


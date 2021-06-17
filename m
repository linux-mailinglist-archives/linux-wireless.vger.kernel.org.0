Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF113AB1DB
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 13:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhFQLEb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 07:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232251AbhFQLEb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 07:04:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58EEE610CA;
        Thu, 17 Jun 2021 11:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623927738;
        bh=51lFLtuBD6yWBxNY2HYbaFs6bxD50wtryWZwc711TuE=;
        h=From:To:Cc:Subject:Date:From;
        b=dyUszPgZggZ5ljKxl6sgQ0VHh4J9XazT8VnwITKZoVxJpX1AAOqh3oShO8t50A0CE
         6n5MYv8U5p2NY5CD/uAW5vC2Smhb7occIDJr+v9qT6MMQwOE/2B3Dxx06GwOOW0hca
         02V2qJqLIf80Qdvkb7pLp2RHgsIupmoQb+S5JEW6Llg7TH52U8yUFMr/90Y+q4Z5GW
         M3rDimS5LH7zOjY+45k7m+mQm8hVenY+Oyqq/ZIbEwsGQm9gFZxg9YV/Etrp97VoSk
         QDYc9D8sAV+Y+Eb0M2wRDGBVwN1j+XasPOE63TtlhzXqjBWniYFnDjkv0SoV6oVBiy
         Y6JKUTMg81JUg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: disable TWT capabilities for the moment
Date:   Thu, 17 Jun 2021 13:02:09 +0200
Message-Id: <295231e60299c95c563fbb5f7006496a3275b251.1623927672.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Disable TWT REQ/RES mac capabilities since TWT is not supported
yet in mt7915/mt7921.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 4 ----
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 92b16c5ecca7..7e7dea0bb030 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -666,8 +666,6 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 
 		switch (i) {
 		case NL80211_IFTYPE_AP:
-			he_cap_elem->mac_cap_info[0] |=
-				IEEE80211_HE_MAC_CAP0_TWT_RES;
 			he_cap_elem->mac_cap_info[2] |=
 				IEEE80211_HE_MAC_CAP2_BSR;
 			he_cap_elem->mac_cap_info[4] |=
@@ -681,8 +679,6 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 				IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
 			break;
 		case NL80211_IFTYPE_STATION:
-			he_cap_elem->mac_cap_info[0] |=
-				IEEE80211_HE_MAC_CAP0_TWT_REQ;
 			he_cap_elem->mac_cap_info[1] |=
 				IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index d20532dd4547..ad27b543d744 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -85,8 +85,6 @@ mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80211_band band,
 
 		switch (i) {
 		case NL80211_IFTYPE_STATION:
-			he_cap_elem->mac_cap_info[0] |=
-				IEEE80211_HE_MAC_CAP0_TWT_REQ;
 			he_cap_elem->mac_cap_info[1] |=
 				IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US;
 
-- 
2.31.1


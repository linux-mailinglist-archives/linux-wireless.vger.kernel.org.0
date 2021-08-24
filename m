Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1646F3F5BF3
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Aug 2021 12:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbhHXKXm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Aug 2021 06:23:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236104AbhHXKXm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Aug 2021 06:23:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C4A8610FB;
        Tue, 24 Aug 2021 10:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629800578;
        bh=6ouoeNaYox008aHgViWFKA9VCHvQ4Apg5vIrWI0zzXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cEtFVR4xhjcrbN5S1/Z/VLZg7FJMcFMYV1wS0T4nKMmmYno3xEhRtrxToF6yhuZHV
         lg+qHFyIGh58K7j7Npzb6RKit50HxQJaAbmDSnxuQG3sRWlAK0YRP+vqHYFg1KVWkb
         FPYyonItePvD5KCjLBc+rTixEISJ25jg08HEZ/KzesO1SKodRznQ1VWR73rOElw1c7
         0ySq1EdXMaActQ1JssXY9wIBQTPFh2JRyeJ3Dh0+04HSKOrC84487SjCcb53GoPzFI
         RyMfPU9YNpjgclTb7A6PlMwcOydm0hhJb16RYp8kwgaCGGb+kBRCSrwa2wIrcqh06p
         EEbb6fqmRJ2Dg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH 1/9] mt76: connac: set 6G phymode in mt76_connac_get_phy_mode{,v2}
Date:   Tue, 24 Aug 2021 12:22:19 +0200
Message-Id: <5d645888e6b881d08ee6a99eb96f6086427f2051.1629799385.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629799385.git.lorenzo@kernel.org>
References: <cover.1629799385.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to support 6GHz band on mt7921 devices.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 9c0f86eefd75..8b72ed77881c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -691,7 +691,7 @@ mt76_connac_get_phy_mode_v2(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 
 		if (he_cap->has_he)
 			mode |= PHY_TYPE_BIT_HE;
-	} else if (band == NL80211_BAND_5GHZ) {
+	} else if (band == NL80211_BAND_5GHZ || band == NL80211_BAND_6GHZ) {
 		mode |= PHY_TYPE_BIT_OFDM;
 
 		if (ht_cap->ht_supported)
@@ -1154,7 +1154,7 @@ mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
 
 		if (he_cap->has_he)
 			mode |= PHY_MODE_AX_24G;
-	} else if (band == NL80211_BAND_5GHZ) {
+	} else if (band == NL80211_BAND_5GHZ || band == NL80211_BAND_6GHZ) {
 		mode |= PHY_MODE_A;
 
 		if (ht_cap->ht_supported)
@@ -1163,8 +1163,12 @@ mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		if (vht_cap->vht_supported)
 			mode |= PHY_MODE_AC;
 
-		if (he_cap->has_he)
-			mode |= PHY_MODE_AX_5G;
+		if (he_cap->has_he) {
+			if (band == NL80211_BAND_6GHZ)
+				mode |= PHY_MODE_AX_6G;
+			else
+				mode |= PHY_MODE_AX_5G;
+		}
 	}
 
 	return mode;
-- 
2.31.1


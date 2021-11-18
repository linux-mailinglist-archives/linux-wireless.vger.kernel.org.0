Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD39455BF6
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 13:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344962AbhKRMyu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 07:54:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:49566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344982AbhKRMws (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 07:52:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0617611C9;
        Thu, 18 Nov 2021 12:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637239787;
        bh=DgnvOsUkC6Eazz7y9v8eajh5h6nnkw3rk3XdIQUDom0=;
        h=From:To:Cc:Subject:Date:From;
        b=oHWHp2F9ocJ5eOEKCOFKV7kVVJFSsF4KoB4+aj3cfjoPlY2Eej59HechlbSeoAELd
         viEZ6KNEZge2XIEWv5pT/dAse94sVKdY7gjGXD6tkwbaBqYue12GxOd9o1nKKlfbco
         m6g3fRjPNo+BkewOr6g4M/zTY7+nEIlKqP9pgJd0/EwpDO8vCc20NZFlGiQuflcu6c
         fCvlB9WEpLAqf0GtGTG0om9eclR6GzJwZfkKG//1UXlSf2jYx+dc61AGJVheXvQoDs
         VTZ9JrwpGx26lLDjR1uMcMflrx0/1gxGucg746LfiuRpHn7U0IMQ8PuwdHqmz+uinG
         +UBoWmTLq1bag==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: connac: fix a theoretical NULL pointer dereference in mt76_connac_get_phy_mode
Date:   Thu, 18 Nov 2021 13:49:41 +0100
Message-Id: <d163b59d6628215f8f5889ef2c21a91c4d50d398.1637239699.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Even if it is not a real bug since mt76_connac_get_phy_mode runs just
for mt7921 where only STA is supported, fix a theoretical NULL pointer
dereference if new added modes do not support HE

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 26b4b875dcc0..bcb596664b3e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1179,7 +1179,7 @@ mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		if (ht_cap->ht_supported)
 			mode |= PHY_MODE_GN;
 
-		if (he_cap->has_he)
+		if (he_cap && he_cap->has_he)
 			mode |= PHY_MODE_AX_24G;
 	} else if (band == NL80211_BAND_5GHZ || band == NL80211_BAND_6GHZ) {
 		mode |= PHY_MODE_A;
@@ -1190,7 +1190,7 @@ mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		if (vht_cap->vht_supported)
 			mode |= PHY_MODE_AC;
 
-		if (he_cap->has_he) {
+		if (he_cap && he_cap->has_he) {
 			if (band == NL80211_BAND_6GHZ)
 				mode |= PHY_MODE_AX_6G;
 			else
-- 
2.31.1


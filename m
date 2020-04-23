Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DB81B5CDD
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 15:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgDWNsO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 09:48:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbgDWNsM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 09:48:12 -0400
Received: from localhost.localdomain.com (unknown [151.66.196.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 960C920728;
        Thu, 23 Apr 2020 13:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587649691;
        bh=fSfWetT74Z4M041uIe4Vb6wBZ2aM0SIZwjC2Z9OYQao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4cZOSNd2lICtYmOPP8LxfX999rAomGrOnL8tVSXzYmdZU5ZFSpCM6vse7b/QrWYP
         /UEJWUMSuZuUaYk/6uaG/ewgEhauJDrNbsmsItgXQIo3+zyYGPXsWxFcXMpJjpWeMT
         9vdDCkjfgCjkbKK2xYjUKaXG4VrGzQ9Gcsj0kNiw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] mt76: mt7663: fix up BMC entry indicated to unicmd firmware
Date:   Thu, 23 Apr 2020 15:47:54 +0200
Message-Id: <25460e45eb01272e690acf93f24645152da33efc.1587649519.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <cover.1587649519.git.lorenzo@kernel.org>
References: <cover.1587649519.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

BMC entry for MT7663 unicmd firmware should be a broadcast/multicast entry,
not a unicast entry, that is GTK rekey offload would rely on.

Fixes: 138860679b2a ("mt76: mt7615: add more uni mcu commands")
Cc: Soul Huang <Soul.Huang@mediatek.com>
Suggested-by: YF Luo <Yf.Luo@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
--
v1->v2:
mt7615_mcu_uni_add_bss is only called on mt7663 with the offload firmware,
so remove the entire unnecessary if code section.
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 22 +++----------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 14e20169e1e0..5064f7c45a44 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1403,8 +1403,8 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy,
 			.short_st = true,
 		},
 	};
-	u8 idx, tx_wlan_idx = 0;
 	int err;
+	u8 idx;
 
 	idx = mvif->omac_idx > EXT_BSSID_START ? HW_BSSID_0 : mvif->omac_idx;
 	basic_req.basic.hw_bss_idx = idx;
@@ -1413,24 +1413,8 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy,
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_AP:
 		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_AP);
-		tx_wlan_idx = mvif->sta.wcid.idx;
 		break;
 	case NL80211_IFTYPE_STATION:
-		if (enable) {
-			struct ieee80211_sta *sta;
-			struct mt7615_sta *msta;
-
-			rcu_read_lock();
-			sta = ieee80211_find_sta(vif, vif->bss_conf.bssid);
-			if (!sta) {
-				rcu_read_unlock();
-				return -EINVAL;
-			}
-
-			msta = (struct mt7615_sta *)sta->drv_priv;
-			tx_wlan_idx = msta->wcid.idx;
-			rcu_read_unlock();
-		}
 		basic_req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_STA);
 		break;
 	default:
@@ -1439,8 +1423,8 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy,
 	}
 
 	memcpy(basic_req.basic.bssid, vif->bss_conf.bssid, ETH_ALEN);
-	basic_req.basic.bmc_tx_wlan_idx = cpu_to_le16(tx_wlan_idx);
-	basic_req.basic.sta_idx = cpu_to_le16(tx_wlan_idx);
+	basic_req.basic.bmc_tx_wlan_idx = cpu_to_le16(mvif->sta.wcid.idx);
+	basic_req.basic.sta_idx = cpu_to_le16(mvif->sta.wcid.idx);
 	basic_req.basic.conn_state = !enable;
 
 	err = __mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
-- 
2.25.3


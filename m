Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C12EB41A9D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 05:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408564AbfFLDNB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 23:13:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:28867 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406872AbfFLDNA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 23:13:00 -0400
X-UUID: dfb021c722e34194afb53bd68c7cfd93-20190612
X-UUID: dfb021c722e34194afb53bd68c7cfd93-20190612
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 174732528; Wed, 12 Jun 2019 11:12:47 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Jun 2019 11:12:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Jun 2019 11:12:40 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/2] mt76: mt7615: update peer's bssid when state transition changes
Date:   Wed, 12 Jun 2019 11:12:34 +0800
Message-ID: <449fee28c558b6f02b62275f9beefaab02b47efc.1560221172.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <3065a01998dfa04a5d2d680e820a17cb5c110d0f.1560221172.git.ryder.lee@mediatek.com>
References: <3065a01998dfa04a5d2d680e820a17cb5c110d0f.1560221172.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3F5B734C7013F11341551BE8410EA107F2318531696F13E719DF083F3416BACF2000:8
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Driver should update peer's bssid and bss information when
state transition changes.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  5 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 49 ++++++++++---------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index d21407ddda31..e0824392c019 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -283,9 +283,8 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 
 	mutex_lock(&dev->mt76.mutex);
 
-	/* TODO: sta mode connect/disconnect
-	 * BSS_CHANGED_ASSOC | BSS_CHANGED_BSSID
-	 */
+	if (changed & BSS_CHANGED_ASSOC)
+		mt7615_mcu_set_bss_info(dev, vif, info->assoc);
 
 	/* TODO: update beacon content
 	 * BSS_CHANGED_BEACON
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index e82086eb8aa4..8fc12cd37906 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -741,17 +741,6 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
 	u8 *buf, *data, tx_wlan_idx = 0;
 	struct req_hdr *hdr;
 
-	if (en) {
-		len += sizeof(struct bss_info_omac);
-		features |= BIT(BSS_INFO_OMAC);
-		if (mvif->omac_idx > EXT_BSSID_START) {
-			len += sizeof(struct bss_info_ext_bss);
-			features |= BIT(BSS_INFO_EXT_BSS);
-			ntlv++;
-		}
-		ntlv++;
-	}
-
 	switch (vif->type) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_MESH_POINT:
@@ -759,22 +748,23 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
 		conn_type = CONNECTION_INFRA_AP;
 		break;
 	case NL80211_IFTYPE_STATION: {
-		struct ieee80211_sta *sta;
-		struct mt7615_sta *msta;
-
-		rcu_read_lock();
-
-		sta = ieee80211_find_sta(vif, vif->bss_conf.bssid);
-		if (!sta) {
+		/* TODO: enable BSS_INFO_UAPSD & BSS_INFO_PM */
+		if (en) {
+			struct ieee80211_sta *sta;
+			struct mt7615_sta *msta;
+
+			rcu_read_lock();
+			sta = ieee80211_find_sta(vif, vif->bss_conf.bssid);
+			if (!sta) {
+				rcu_read_unlock();
+				return -EINVAL;
+			}
+
+			msta = (struct mt7615_sta *)sta->drv_priv;
+			tx_wlan_idx = msta->wcid.idx;
 			rcu_read_unlock();
-			return -EINVAL;
 		}
-
-		msta = (struct mt7615_sta *)sta->drv_priv;
-		tx_wlan_idx = msta->wcid.idx;
 		conn_type = CONNECTION_INFRA_STA;
-
-		rcu_read_unlock();
 		break;
 	}
 	default:
@@ -782,6 +772,17 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
 		break;
 	}
 
+	if (en) {
+		len += sizeof(struct bss_info_omac);
+		features |= BIT(BSS_INFO_OMAC);
+		if (mvif->omac_idx > EXT_BSSID_START) {
+			len += sizeof(struct bss_info_ext_bss);
+			features |= BIT(BSS_INFO_EXT_BSS);
+			ntlv++;
+		}
+		ntlv++;
+	}
+
 	buf = kzalloc(len, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-- 
2.18.0


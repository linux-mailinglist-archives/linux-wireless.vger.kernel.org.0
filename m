Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61D1B30FAA
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2019 16:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfEaOKH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 May 2019 10:10:07 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:7183 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726515AbfEaOKG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 May 2019 10:10:06 -0400
X-UUID: 758994cb5cf640039e40131c28830073-20190531
X-UUID: 758994cb5cf640039e40131c28830073-20190531
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 344690065; Fri, 31 May 2019 22:09:59 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 31 May 2019 22:09:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 31 May 2019 22:09:58 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Chih-Min Chen <chih-min.Chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 1/2] mt76: mt7615: enable support for mesh
Date:   Fri, 31 May 2019 22:09:56 +0800
Message-ID: <e459fbc79154da9e0e6e098d2c49a9b17e842f47.1559301203.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable NL80211_IFTYPE_MESH_POINT and update its path.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
Changes since v2 - remove unused definitions
---
 drivers/net/wireless/mediatek/mt76/mt7615/init.c | 6 ++++++
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 1 +
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c  | 5 ++++-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h  | 6 ------
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 59f604f3161f..f860af6a42da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -133,6 +133,9 @@ static const struct ieee80211_iface_limit if_limits[] = {
 	{
 		.max = MT7615_MAX_INTERFACES,
 		.types = BIT(NL80211_IFTYPE_AP) |
+#ifdef CONFIG_MAC80211_MESH
+			 BIT(NL80211_IFTYPE_MESH_POINT) |
+#endif
 			 BIT(NL80211_IFTYPE_STATION)
 	}
 };
@@ -195,6 +198,9 @@ int mt7615_register_device(struct mt7615_dev *dev)
 	dev->mt76.antenna_mask = 0xf;
 
 	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
+#ifdef CONFIG_MAC80211_MESH
+				 BIT(NL80211_IFTYPE_MESH_POINT) |
+#endif
 				 BIT(NL80211_IFTYPE_AP);
 
 	ret = mt76_register_device(&dev->mt76, true, mt7615_rates,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index b0bb7cc12385..585e67fa2728 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -37,6 +37,7 @@ static int get_omac_idx(enum nl80211_iftype type, u32 mask)
 
 	switch (type) {
 	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_MESH_POINT:
 		/* ap use hw bssid 0 and ext bssid */
 		if (~mask & BIT(HW_BSSID_0))
 			return HW_BSSID_0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 43f70195244c..8b8db526cb16 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -754,6 +754,7 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_MESH_POINT:
 		tx_wlan_idx = mvif->sta.wcid.idx;
 		conn_type = CONNECTION_INFRA_AP;
 		break;
@@ -968,7 +969,8 @@ int mt7615_mcu_add_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		.rx_wtbl = {
 			.tag = cpu_to_le16(WTBL_RX),
 			.len = cpu_to_le16(sizeof(struct wtbl_rx)),
-			.rca1 = vif->type != NL80211_IFTYPE_AP,
+			.rca1 = vif->type != (NL80211_IFTYPE_AP ||
+					      NL80211_IFTYPE_MESH_POINT),
 			.rca2 = 1,
 			.rv = 1,
 		},
@@ -1042,6 +1044,7 @@ static void sta_rec_convert_vif_type(enum nl80211_iftype type, u32 *conn_type)
 {
 	switch (type) {
 	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_MESH_POINT:
 		if (conn_type)
 			*conn_type = CONNECTION_INFRA_STA;
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index e96efb13fa4d..0915cb735699 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -105,25 +105,19 @@ enum {
 #define STA_TYPE_STA		BIT(0)
 #define STA_TYPE_AP		BIT(1)
 #define STA_TYPE_ADHOC		BIT(2)
-#define STA_TYPE_TDLS		BIT(3)
 #define STA_TYPE_WDS		BIT(4)
 #define STA_TYPE_BC		BIT(5)
 
 #define NETWORK_INFRA		BIT(16)
 #define NETWORK_P2P		BIT(17)
 #define NETWORK_IBSS		BIT(18)
-#define NETWORK_MESH		BIT(19)
-#define NETWORK_BOW		BIT(20)
 #define NETWORK_WDS		BIT(21)
 
 #define CONNECTION_INFRA_STA	(STA_TYPE_STA | NETWORK_INFRA)
 #define CONNECTION_INFRA_AP	(STA_TYPE_AP | NETWORK_INFRA)
 #define CONNECTION_P2P_GC	(STA_TYPE_STA | NETWORK_P2P)
 #define CONNECTION_P2P_GO	(STA_TYPE_AP | NETWORK_P2P)
-#define CONNECTION_MESH_STA	(STA_TYPE_STA | NETWORK_MESH)
-#define CONNECTION_MESH_AP	(STA_TYPE_AP | NETWORK_MESH)
 #define CONNECTION_IBSS_ADHOC	(STA_TYPE_ADHOC | NETWORK_IBSS)
-#define CONNECTION_TDLS		(STA_TYPE_STA | NETWORK_INFRA | STA_TYPE_TDLS)
 #define CONNECTION_WDS		(STA_TYPE_WDS | NETWORK_WDS)
 #define CONNECTION_INFRA_BC	(STA_TYPE_BC | NETWORK_INFRA)
 
-- 
2.18.0


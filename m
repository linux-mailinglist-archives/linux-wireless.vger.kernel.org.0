Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166483636AA
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhDRQgs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:36:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36998 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231728AbhDRQgm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:36:42 -0400
X-UUID: 93a4eec4266b4a5982079a50f72c00ab-20210419
X-UUID: 93a4eec4266b4a5982079a50f72c00ab-20210419
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1245416768; Mon, 19 Apr 2021 00:36:10 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Apr 2021 00:36:09 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Apr 2021 00:36:09 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Leon Yen <leon.yen@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH 5/6] mt76: connac: introduce mt76_connac_mcu_set_deep_sleep utility
Date:   Mon, 19 Apr 2021 00:36:06 +0800
Message-ID: <1618763767-1292-6-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1618763767-1292-1-git-send-email-sean.wang@mediatek.com>
References: <1618763767-1292-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Introduce mt76_connac_mcu_set_deep_sleep to enable deep sleep mode
and will be activated immediately when the host returns the ownership
to the device.

Co-developed-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Co-developed-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 22 ++++++++++++-------
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 10 +++++++++
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 860406a53cb6..7578855099e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1528,14 +1528,7 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_sched_scan_enable);
 
 int mt76_connac_mcu_chip_config(struct mt76_dev *dev)
 {
-	struct {
-		__le16 id;
-		u8 type;
-		u8 resp_type;
-		__le16 data_size;
-		__le16 resv;
-		u8 data[320];
-	} req = {
+	struct mt76_connac_config req = {
 		.resp_type = 0,
 	};
 
@@ -1546,6 +1539,19 @@ int mt76_connac_mcu_chip_config(struct mt76_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_chip_config);
 
+int mt76_connac_mcu_set_deep_sleep(struct mt76_dev *dev, bool enable)
+{
+	struct mt76_connac_config req = {
+		.resp_type = 0,
+	};
+
+	snprintf(req.data, sizeof(req.data), "KeepFullPwr %d", !enable);
+
+	return mt76_mcu_send_msg(dev, MCU_CMD_CHIP_CONFIG, &req, sizeof(req),
+				 false);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_deep_sleep);
+
 void mt76_connac_mcu_coredump_event(struct mt76_dev *dev, struct sk_buff *skb,
 				    struct mt76_connac_coredump *coredump)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index ff9fca52f344..e943b89fda75 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -918,6 +918,15 @@ struct mt76_connac_tx_power_limit_tlv {
 	u8 pad2[32];
 } __packed;
 
+struct mt76_connac_config {
+	__le16 id;
+	u8 type;
+	u8 resp_type;
+	__le16 data_size;
+	__le16 resv;
+	u8 data[320];
+} __packed;
+
 #define to_wcid_lo(id)		FIELD_GET(GENMASK(7, 0), (u16)id)
 #define to_wcid_hi(id)		FIELD_GET(GENMASK(9, 8), (u16)id)
 
@@ -1017,6 +1026,7 @@ int mt76_connac_mcu_set_hif_suspend(struct mt76_dev *dev, bool suspend);
 void mt76_connac_mcu_set_suspend_iter(void *priv, u8 *mac,
 				      struct ieee80211_vif *vif);
 int mt76_connac_mcu_chip_config(struct mt76_dev *dev);
+int mt76_connac_mcu_set_deep_sleep(struct mt76_dev *dev, bool enable);
 void mt76_connac_mcu_coredump_event(struct mt76_dev *dev, struct sk_buff *skb,
 				    struct mt76_connac_coredump *coredump);
 int mt76_connac_mcu_set_rate_txpower(struct mt76_phy *phy);
-- 
2.25.1


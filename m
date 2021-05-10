Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB39379253
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 17:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbhEJPRO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 11:17:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56336 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237277AbhEJPQJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 11:16:09 -0400
X-UUID: 2aae4b1b1ea94b9180be372c5e267ece-20210510
X-UUID: 2aae4b1b1ea94b9180be372c5e267ece-20210510
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1958911763; Mon, 10 May 2021 23:14:59 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 10 May 2021 23:14:59 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 May 2021 23:14:59 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        YN Chen <yn.chen@mediatek.com>
Subject: [PATCH 6/9] mt76: connac: fix WoW with disconnetion and bitmap pattern
Date:   Mon, 10 May 2021 23:14:54 +0800
Message-ID: <1620659697-12048-6-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1620659697-12048-1-git-send-email-sean.wang@mediatek.com>
References: <1620659697-12048-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: YN Chen <yn.chen@mediatek.com>

Update MCU command usage to fix WoW configuration with disconnection
and bitmap pattern and to avoid magic number.

Fixes: ffa1bf97425 ("mt76: mt7921: introduce PM support")
Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: YN Chen <yn.chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 11 +++++++----
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  8 ++++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 542d7d9f1f52..6ffe4b91d567 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1999,7 +1999,7 @@ mt76_connac_mcu_set_wow_pattern(struct mt76_dev *dev,
 	ptlv->index = index;
 
 	memcpy(ptlv->pattern, pattern->pattern, pattern->pattern_len);
-	memcpy(ptlv->mask, pattern->mask, pattern->pattern_len / 8);
+	memcpy(ptlv->mask, pattern->mask, DIV_ROUND_UP(pattern->pattern_len, 8));
 
 	return mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD_SUSPEND, true);
 }
@@ -2034,14 +2034,17 @@ mt76_connac_mcu_set_wow_ctrl(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	};
 
 	if (wowlan->magic_pkt)
-		req.wow_ctrl_tlv.trigger |= BIT(0);
+		req.wow_ctrl_tlv.trigger |= UNI_WOW_DETECT_TYPE_MAGIC;
 	if (wowlan->disconnect)
-		req.wow_ctrl_tlv.trigger |= BIT(2);
+		req.wow_ctrl_tlv.trigger |= (UNI_WOW_DETECT_TYPE_DISCONNECT |
+					     UNI_WOW_DETECT_TYPE_BCN_LOST);
 	if (wowlan->nd_config) {
 		mt76_connac_mcu_sched_scan_req(phy, vif, wowlan->nd_config);
-		req.wow_ctrl_tlv.trigger |= BIT(5);
+		req.wow_ctrl_tlv.trigger |= UNI_WOW_DETECT_TYPE_SCH_SCAN_HIT;
 		mt76_connac_mcu_sched_scan_enable(phy, vif, suspend);
 	}
+	if (wowlan->n_patterns)
+		req.wow_ctrl_tlv.trigger |= UNI_WOW_DETECT_TYPE_BITMAP;
 
 	if (mt76_is_mmio(dev))
 		req.wow_ctrl_tlv.wakeup_hif = WOW_PCIE;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 3ed2fb5e1389..8f4d85b148fb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -590,6 +590,14 @@ enum {
 	UNI_OFFLOAD_OFFLOAD_BMC_RPY_DETECT,
 };
 
+#define UNI_WOW_DETECT_TYPE_MAGIC		BIT(0)
+#define UNI_WOW_DETECT_TYPE_ANY			BIT(1)
+#define UNI_WOW_DETECT_TYPE_DISCONNECT		BIT(2)
+#define UNI_WOW_DETECT_TYPE_GTK_REKEY_FAIL	BIT(3)
+#define UNI_WOW_DETECT_TYPE_BCN_LOST		BIT(4)
+#define UNI_WOW_DETECT_TYPE_SCH_SCAN_HIT	BIT(5)
+#define UNI_WOW_DETECT_TYPE_BITMAP		BIT(6)
+
 enum {
 	UNI_SUSPEND_MODE_SETTING,
 	UNI_SUSPEND_WOW_CTRL,
-- 
2.25.1


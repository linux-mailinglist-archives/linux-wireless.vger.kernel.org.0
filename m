Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F11425B51
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Oct 2021 21:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243883AbhJGTJW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Oct 2021 15:09:22 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:48368 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243799AbhJGTJQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Oct 2021 15:09:16 -0400
X-UUID: eed2dd1c72cc4584af6dfb4ba13583b9-20211007
X-UUID: eed2dd1c72cc4584af6dfb4ba13583b9-20211007
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1307402486; Thu, 07 Oct 2021 12:07:20 -0700
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 7 Oct 2021 11:57:18 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Oct 2021 02:57:12 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <jemele@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mt76: mt7921: add MU EDCA cmd support
Date:   Fri, 8 Oct 2021 02:57:11 +0800
Message-ID: <181a8f619a55c5a509c838d2ea5ec64641d4aa19.1633632336.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add MU EDCA MCU command support to update MU AC parameter record field
from the access point.

Co-developed-by: Eric-SY Chang <Eric-SY.Chang@mediatek.com>
Signed-off-by: Eric-SY Chang <Eric-SY.Chang@mediatek.com>
Tested-by: Eric-SY Chang <Eric-SY.Chang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 56 ++++++++++++++++++-
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index cb36dd39221c..0ce670d65673 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -563,6 +563,7 @@ enum {
 	MCU_CMD_SCHED_SCAN_ENABLE = MCU_CE_PREFIX | 0x61,
 	MCU_CMD_SCHED_SCAN_REQ = MCU_CE_PREFIX | 0x62,
 	MCU_CMD_GET_NIC_CAPAB = MCU_CE_PREFIX | 0x8a,
+	MCU_CMD_SET_MU_EDCA_PARMS = MCU_CE_PREFIX | 0xb0,
 	MCU_CMD_REG_WRITE = MCU_CE_PREFIX | 0xc0,
 	MCU_CMD_REG_READ = MCU_CE_PREFIX | MCU_QUERY_MASK | 0xc0,
 	MCU_CMD_CHIP_CONFIG = MCU_CE_PREFIX | 0xca,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 56fb7e54e283..53b2eaad2af7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -974,7 +974,31 @@ int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 		.total = IEEE80211_NUM_ACS,
 	};
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
-	int ac;
+
+	struct mu_edca {
+		u8 cw_min;
+		u8 cw_max;
+		u8 aifsn;
+		u8 acm;
+		u8 timer;
+		u8 padding[3];
+	};
+	struct mt7921_mcu_mu_tx {
+		u8 ver;
+		u8 pad0;
+		u16 len;
+		u8 bss_idx;
+		u8 qos;
+		u8 wmm_idx;
+		u8 pad1;
+		struct mu_edca edca[IEEE80211_NUM_ACS];
+		u8 pad3[32];
+	} __packed req_mu = {
+		.bss_idx = mvif->mt76.idx,
+		.qos = vif->bss_conf.qos,
+		.wmm_idx = mvif->mt76.wmm_idx,
+	};
+	int ac, ret;
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
 		struct ieee80211_tx_queue_params *q = &mvif->queue_params[ac];
@@ -995,8 +1019,34 @@ int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 		else
 			e->cw_max = cpu_to_le16(10);
 	}
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE, &req,
-				 sizeof(req), true);
+
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE, &req,
+				sizeof(req), true);
+	if (ret)
+		return ret;
+
+	if (!vif->bss_conf.he_support)
+		return 0;
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		struct ieee80211_he_mu_edca_param_ac_rec *q;
+		struct mu_edca *e;
+		int to_aci[] = {1, 0, 2, 3};
+
+		if (!mvif->queue_params[ac].mu_edca)
+			break;
+
+		q = &mvif->queue_params[ac].mu_edca_param_rec;
+		e = &(req_mu.edca[to_aci[ac]]);
+
+		e->cw_min = q->ecw_min_max & 0xf;
+		e->cw_max = (q->ecw_min_max & 0xf0) >> 4;
+		e->aifsn = q->aifsn;
+		e->timer = q->mu_edca_timer;
+	}
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_MU_EDCA_PARMS, &req_mu,
+				 sizeof(req_mu), false);
 }
 
 int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd)
-- 
2.25.1


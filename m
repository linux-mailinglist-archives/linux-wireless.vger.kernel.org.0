Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1B540BD07
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 03:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhIOBRP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 21:17:15 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:43938 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhIOBRO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 21:17:14 -0400
X-UUID: 9487fd7751e448ecae90e6315b535d06-20210914
X-UUID: 9487fd7751e448ecae90e6315b535d06-20210914
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 343346203; Tue, 14 Sep 2021 18:15:48 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 18:15:46 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Sep 2021 09:15:45 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <steve.lee@mediatek.com>, <jemele@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v1 12/16] mt76: connac: extend mcu_get_nic_capability
Date:   Wed, 15 Sep 2021 09:14:45 +0800
Message-ID: <37e505a9ff2f24b594ab1162e6eb7f0aa30be1d1.1631667941.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1631667941.git.objelf@gmail.com>
References: <cover.1631667941.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Extend mcu_get_nic_capability to obtain tx resource for SDIO device,
MAC address, and PHY capability.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 66 +++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 58fd0c7831f4..3062cda2e770 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -512,6 +512,7 @@ struct mt76_sdio {
 		int pse_data_quota;
 		int ple_data_quota;
 		int pse_mcu_quota;
+		int pse_page_size;
 		int deficit;
 	} sched;
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index a53f6344a184..cee17b48b296 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1716,6 +1716,61 @@ void mt76_connac_mcu_coredump_event(struct mt76_dev *dev, struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_coredump_event);
 
+static void mt76_connac_mcu_parse_tx_resource(struct mt76_dev *dev,
+					      struct sk_buff *skb)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+	struct mt76_connac_tx_resource {
+		__le32 version;
+		__le32 pse_data_quota;
+		__le32 pse_mcu_quota;
+		__le32 ple_data_quota;
+		__le32 ple_mcu_quota;
+		__le16 pse_page_size;
+		__le16 ple_page_size;
+		u8 pp_padding;
+		u8 pad[3];
+	} __packed * tx_res;
+
+	tx_res = (struct mt76_connac_tx_resource *)skb->data;
+	sdio->sched.pse_data_quota = le32_to_cpu(tx_res->pse_data_quota);
+	sdio->sched.pse_mcu_quota = le32_to_cpu(tx_res->pse_mcu_quota);
+	sdio->sched.ple_data_quota = le32_to_cpu(tx_res->ple_data_quota);
+	sdio->sched.pse_page_size = le32_to_cpu(tx_res->pse_page_size);
+	sdio->sched.deficit = tx_res->pp_padding;
+}
+
+static void mt76_connac_mcu_parse_phy_cap(struct mt76_dev *dev,
+					  struct sk_buff *skb)
+{
+	struct mt76_connac_phy_cap {
+		u8 ht;
+		u8 vht;
+		u8 _5g;
+		u8 max_bw;
+		u8 nss;
+		u8 dbdc;
+		u8 tx_ldpc;
+		u8 rx_ldpc;
+		u8 tx_stbc;
+		u8 rx_stbc;
+		u8 hw_path;
+		u8 he;
+	} __packed * cap;
+
+	enum {
+		WF0_24G,
+		WF0_5G
+	};
+
+	cap = (struct mt76_connac_phy_cap *)skb->data;
+
+	dev->phy.antenna_mask = BIT(cap->nss) - 1;
+	dev->phy.chainmask = dev->phy.antenna_mask;
+	dev->phy.cap.has_2ghz = cap->hw_path & BIT(WF0_24G);
+	dev->phy.cap.has_5ghz = cap->hw_path & BIT(WF0_5G);
+}
+
 int mt76_connac_mcu_get_nic_capability(struct mt76_phy *phy)
 {
 	struct mt76_connac_cap_hdr {
@@ -1758,6 +1813,17 @@ int mt76_connac_mcu_get_nic_capability(struct mt76_phy *phy)
 		case MT_NIC_CAP_6G:
 			phy->cap.has_6ghz = skb->data[0];
 			break;
+		case MT_NIC_CAP_MAC_ADDR:
+			memcpy(phy->macaddr, (void *)skb->data, ETH_ALEN);
+			break;
+		case MT_NIC_CAP_PHY:
+			mt76_connac_mcu_parse_phy_cap(phy->dev, skb);
+			break;
+		case MT_NIC_CAP_TX_RESOURCE:
+			if (mt76_is_sdio(phy->dev))
+				mt76_connac_mcu_parse_tx_resource(phy->dev,
+								  skb);
+			break;
 		default:
 			break;
 		}
-- 
2.25.1


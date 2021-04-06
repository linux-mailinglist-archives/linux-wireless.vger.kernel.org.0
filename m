Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EFB354B43
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Apr 2021 05:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242381AbhDFDey (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Apr 2021 23:34:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48671 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S242346AbhDFDey (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Apr 2021 23:34:54 -0400
X-UUID: 4a1b37d4d7564eb2ba5d9d4276334b46-20210406
X-UUID: 4a1b37d4d7564eb2ba5d9d4276334b46-20210406
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 826307092; Tue, 06 Apr 2021 11:34:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 6 Apr 2021 11:34:41 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Apr 2021 11:34:41 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 6/6] mt76: mt7921: reduce the data latency during hw scan
Date:   Tue, 6 Apr 2021 11:34:39 +0800
Message-ID: <2a90d50ed8f1f423d84d02c2d32e9e0686873525.1617679693.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <4c5666ad0683e467f11ca4a4abb5be335be25696.1617679693.git.objelf@gmail.com>
References: <4c5666ad0683e467f11ca4a4abb5be335be25696.1617679693.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Reduce the data latency during hw_scan by the split scan which would switch
back to operational channel right after scanning each channel done.

Suggested-by: Asda Wen <Asda.Wen@mediatek.com>
Suggested-by: Soul Huang <Soul.Huang@mediatek.com>
Co-developed-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 5 ++++-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 1bd6294042b6..4892728ad9bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1395,11 +1395,14 @@ int mt76_connac_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		req->ies_len = cpu_to_le16(sreq->ie_len);
 	}
 
+	if (is_mt7921(phy->dev))
+		req->scan_func |= SCAN_FUNC_SPLIT_SCAN;
+
 	memcpy(req->bssid, sreq->bssid, ETH_ALEN);
 	if (sreq->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
 		get_random_mask_addr(req->random_mac, sreq->mac_addr,
 				     sreq->mac_addr_mask);
-		req->scan_func = 1;
+		req->scan_func |= SCAN_FUNC_RANDOM_MAC;
 	}
 
 	err = mt76_mcu_skb_send_msg(mdev, skb, MCU_CMD_START_HW_SCAN, false);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 5a3efd744546..6f9b7807305a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -362,6 +362,9 @@ enum {
 #define NETWORK_IBSS			BIT(18)
 #define NETWORK_WDS			BIT(21)
 
+#define SCAN_FUNC_RANDOM_MAC		BIT(0)
+#define SCAN_FUNC_SPLIT_SCAN		BIT(5)
+
 #define CONNECTION_INFRA_STA		(STA_TYPE_STA | NETWORK_INFRA)
 #define CONNECTION_INFRA_AP		(STA_TYPE_AP | NETWORK_INFRA)
 #define CONNECTION_P2P_GC		(STA_TYPE_STA | NETWORK_P2P)
-- 
2.25.1


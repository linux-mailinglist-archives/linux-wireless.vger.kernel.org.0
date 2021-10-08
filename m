Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDD8426DFF
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Oct 2021 17:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhJHPsL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Oct 2021 11:48:11 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:58914 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhJHPsJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Oct 2021 11:48:09 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Oct 2021 11:48:09 EDT
X-UUID: bf02149a884a4fc3b13cdbbfe2c33f25-20211008
X-UUID: bf02149a884a4fc3b13cdbbfe2c33f25-20211008
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1842756440; Fri, 08 Oct 2021 08:41:06 -0700
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Oct 2021 08:41:04 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Oct 2021 23:41:04 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] mt76: mt7921: add delay config for sched scan
Date:   Fri, 8 Oct 2021 23:40:50 +0800
Message-ID: <be717a2f0272ab8d339f4bc658fdde855eb78f0d.1633705676.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

Add a delay parameter for firmware to support delay scheduled scan.

Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 4 +++-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 9c0f86eefd75..1f4fdb470578 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1540,8 +1540,10 @@ int mt76_connac_mcu_sched_scan_req(struct mt76_phy *phy,
 		get_random_mask_addr(addr, sreq->mac_addr,
 				     sreq->mac_addr_mask);
 	}
-	if (is_mt7921(phy->dev))
+	if (is_mt7921(phy->dev)) {
 		req->mt7921.bss_idx = mvif->idx;
+		req->mt7921.delay = cpu_to_le32(sreq->delay);
+	}
 
 	req->ssids_num = sreq->n_ssids;
 	for (i = 0; i < req->ssids_num; i++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index cb36dd39221c..5b75465bc05a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -805,7 +805,9 @@ struct mt76_connac_sched_scan_req {
 		} mt7663;
 		struct {
 			u8 bss_idx;
-			u8 pad2[19];
+			u8 pad1[3];
+			__le32 delay;
+			u8 pad2[12];
 			u8 random_mac[ETH_ALEN];
 			u8 pad3[38];
 		} mt7921;
-- 
2.18.0


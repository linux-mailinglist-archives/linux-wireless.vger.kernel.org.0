Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA92F389EDB
	for <lists+linux-wireless@lfdr.de>; Thu, 20 May 2021 09:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhETHYH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 May 2021 03:24:07 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:40870 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230102AbhETHYH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 May 2021 03:24:07 -0400
X-UUID: db89d2bdd08c45feac49c9359cd45b3b-20210520
X-UUID: db89d2bdd08c45feac49c9359cd45b3b-20210520
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 884026645; Thu, 20 May 2021 15:22:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 May 2021 15:22:35 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 May 2021 15:22:34 +0800
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
        Deren Wu <deren.wu@mediatek.com>,
        YN Chen <yn.chen@mediatek.com>
Subject: [PATCH] mt76: mt7921: fix UC entry is being overwritten
Date:   Thu, 20 May 2021 15:22:34 +0800
Message-ID: <1621495354-4130-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

Fix UC entry is being overwritten by BC entry

Fixes: 36fcc8cff592 ("mt76: mt7921: introduce mt7921_mcu_sta_add routine")
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: YN Chen <yn.chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 73359defa176..f3decc59a6fe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -875,10 +875,13 @@ int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	mt76_connac_mcu_sta_basic_tlv(skb, info->vif, info->sta, info->enable);
-	if (info->enable && info->sta)
-		mt76_connac_mcu_sta_tlv(phy, skb, info->sta, info->vif,
-					info->rcpi);
+	if (info->sta) {
+		mt76_connac_mcu_sta_basic_tlv(skb, info->vif, info->sta,
+					      info->enable);
+		if (info->enable)
+			mt76_connac_mcu_sta_tlv(phy, skb, info->sta,
+						info->vif, info->rcpi);
+	}
 
 	sta_wtbl = mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL,
 					   sizeof(struct tlv));
-- 
2.25.1


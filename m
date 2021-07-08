Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E723BF4C1
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jul 2021 06:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhGHEcF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jul 2021 00:32:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42118 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229554AbhGHEcE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jul 2021 00:32:04 -0400
X-UUID: 38969052e99e4c708f91889f424589a7-20210708
X-UUID: 38969052e99e4c708f91889f424589a7-20210708
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1190033055; Thu, 08 Jul 2021 12:29:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 8 Jul 2021 12:29:12 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Jul 2021 12:29:12 +0800
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
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/2] mt76: connac: fix mt76_connac_gtk_rekey_tlv usage
Date:   Thu, 8 Jul 2021 12:29:06 +0800
Message-ID: <1625718546-14969-2-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1625718546-14969-1-git-send-email-sean.wang@mediatek.com>
References: <1625718546-14969-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Leon Yen <Leon.Yen@mediatek.com>

The mistaken structure is introduced since we added the GTK rekey offload
to mt7663. The patch fixes mt76_connac_gtk_rekey_tlv structure according
to the MT7663 and MT7921 firmware we have submitted into
linux-firmware.git.

Fixes: b47e21e75c80 ("mt76: mt7615: add gtk rekey offload support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Leon Yen <Leon.Yen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 1c73beb22677..4bcd728ff97c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -844,14 +844,14 @@ struct mt76_connac_gtk_rekey_tlv {
 			* 2: rekey update
 			*/
 	u8 keyid;
-	u8 pad[2];
+	u8 option; /* 1: rekey data update without enabling offload */
+	u8 pad[1];
 	__le32 proto; /* WPA-RSN-WAPI-OPSN */
 	__le32 pairwise_cipher;
 	__le32 group_cipher;
 	__le32 key_mgmt; /* NONE-PSK-IEEE802.1X */
 	__le32 mgmt_group_cipher;
-	u8 option; /* 1: rekey data update without enabling offload */
-	u8 reserverd[3];
+	u8 reserverd[4];
 } __packed;
 
 #define MT76_CONNAC_WOW_MASK_MAX_LEN			16
-- 
2.25.1


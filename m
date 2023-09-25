Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AFA7AD2CB
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 10:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjIYILQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 04:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjIYILM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 04:11:12 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45C5A9
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 01:11:04 -0700 (PDT)
X-UUID: 0dfc81125b7b11ee8051498923ad61e6-20230925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NzSqdi5Tb3UZ0TX2Ha5X2sq+Y2e788eONic1GxwcJ9E=;
        b=c8aGUaKwlW6QQqCTu3h3RLJbolVE42xGwXaO4pQLo4nU32cBZtd+iDZPIT4puHyHokA6wZHVb8liUNKiGBXQ2jNuiehYXspxcVIIKTkK8cTMs4x1mfKviDCYwFEdsfT1DTIyQ2H4q78Bt0x+s2L1vvWKcziwywKzBoJQHnELISY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:2c4679bd-13e7-475e-b9db-47d195f0c1ba,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:99173dbf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0dfc81125b7b11ee8051498923ad61e6-20230925
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1568780376; Mon, 25 Sep 2023 16:10:56 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 25 Sep 2023 16:10:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 25 Sep 2023 16:10:55 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 4/6] wifi: mt76: mt7921: get regulatory information from the clc event
Date:   Mon, 25 Sep 2023 16:10:36 +0800
Message-ID: <91eefb04b95c5aef63d1f25ee2bef25f7daf34de.1695627867.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1695627867.git.deren.wu@mediatek.com>
References: <cover.1695627867.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.409000-8.000000
X-TMASE-MatchedRID: chvA8lDZYvB3jyG1lXn0RKwxbZnudyr7P9lbOpiWOGatj24Xqh0yXFnN
        uOyuafqaxMIfhQQLLkE+zJdigxeeCAtrOhDKumbSfFMOK/HqfAZMkOX0UoduuQCGaccd4ae9cNi
        oSkggDzn0p6fAAwu4MqRIz4oXrpFwQkfxbJAyTm7J5W6OZe5hhU1+P1DCPaJ9MT+isX6MhSknui
        +WQ9elLaz6Q4QzIn0zOhQHRNrk2f8E7MuQrZP2o7RtO1RC1Ep0nrdrM99CmmBu4FknyqyshCYM7
        vl6iI1V1jdwn2H9AvJtkfvwyItc5T7Geun57v0ckDpLRKO9xhR9LQinZ4QefPcjNeVeWlqY+gtH
        j7OwNO0gCYMnfcK3PKwrStCy/NXBDelie4gRZ3dOFj//J6vGPWf3GVF2Neym/o4l/fFCcW0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.409000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 9582C808B1EB897093650F0CA89DBC51DB5D8935A867A25E85B12E6E59A645462000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

The clc event can report the radio configuration for the corresponding
country and the driver would take it as regulatory information of a
certain platform device.

This patch would change the clc commnad from no-waiting to waiting for
event. For backward compatible, we also add a new nic capability tag
to indicate the firmware did support this new clc event from now on.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 26 ++++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   | 13 ++++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  4 +++
 5 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index b73dbe1dbf3a..35f008492a6b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1340,6 +1340,7 @@ enum {
 	MT_NIC_CAP_ANTSWP = 0x16,
 	MT_NIC_CAP_WFDMA_REALLOC,
 	MT_NIC_CAP_6G,
+	MT_NIC_CAP_CHIP_CAP = 0x20,
 };
 
 #define UNI_WOW_DETECT_TYPE_MAGIC		BIT(0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 8c76ef92e14f..4f66e27aa43a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -557,6 +557,9 @@ static int mt7921_mcu_get_nic_capability(struct mt792x_phy *mphy)
 				mt7921_mcu_parse_tx_resource(phy->dev,
 							     skb);
 			break;
+		case MT_NIC_CAP_CHIP_CAP:
+			memcpy(&mphy->chip_cap, (void *)skb->data, sizeof(u64));
+			break;
 		default:
 			break;
 		}
@@ -1243,7 +1246,8 @@ int __mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 			 struct mt7921_clc *clc,
 			 u8 idx)
 {
-	struct sk_buff *skb;
+#define CLC_CAP_EVT_EN BIT(0)
+	struct sk_buff *skb, *ret_skb = NULL;
 	struct {
 		u8 ver;
 		u8 pad0;
@@ -1251,7 +1255,7 @@ int __mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		u8 idx;
 		u8 env;
 		u8 acpi_conf;
-		u8 pad1;
+		u8 cap;
 		u8 alpha2[2];
 		u8 type[2];
 		u8 env_6g;
@@ -1268,6 +1272,9 @@ int __mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 	if (!clc)
 		return 0;
 
+	if (dev->phy.chip_cap & MT792x_CHIP_CAP_CLC_EVT_EN)
+		req.cap |= CLC_CAP_EVT_EN;
+
 	pos = clc->data;
 	for (i = 0; i < clc->nr_country; i++) {
 		struct mt7921_clc_rule *rule = (struct mt7921_clc_rule *)pos;
@@ -1289,10 +1296,21 @@ int __mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 			return -ENOMEM;
 		skb_put_data(skb, rule->data, len);
 
-		ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
-					    MCU_CE_CMD(SET_CLC), false);
+		ret = mt76_mcu_skb_send_and_get_msg(&dev->mt76, skb,
+						    MCU_CE_CMD(SET_CLC),
+						    !!(req.cap & CLC_CAP_EVT_EN),
+						    &ret_skb);
 		if (ret < 0)
 			return ret;
+
+		if (ret_skb) {
+			struct mt7921_clc_info_tlv *info;
+
+			info = (struct mt7921_clc_info_tlv *)(ret_skb->data + 4);
+			dev->phy.clc_chan_conf = info->chan_conf;
+			dev_kfree_skb(ret_skb);
+		}
+
 		valid_cnt++;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index 9b0aa3b70f0e..f9a259ee6b82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -99,4 +99,17 @@ struct mt7921_rftest_evt {
 	__le32 param0;
 	__le32 param1;
 } __packed;
+
+struct mt7921_clc_info_tlv {
+	__le16 tag;
+	__le16 len;
+
+	u8 chan_conf; /* BIT(0) : Enable UNII-4
+		       * BIT(1) : Enable UNII-5
+		       * BIT(2) : Enable UNII-6
+		       * BIT(3) : Enable UNII-7
+		       * BIT(4) : Enable UNII-8
+		       */
+	u8 rsv[63];
+} __packed;
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 87dd06855f68..ba3f9d9aacad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -27,6 +27,7 @@
 #define MT7921_SDIO_HDR_PKT_TYPE	GENMASK(17, 16)
 
 #define MCU_UNI_EVENT_ROC  0x27
+#define MCU_UNI_EVENT_CLC  0x80
 
 enum {
 	UNI_ROC_ACQUIRE,
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 8b1dbddf4582..34380d1eb9f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -25,6 +25,8 @@
 #define MT792x_FW_TAG_FEATURE	4
 #define MT792x_FW_CAP_CNM	BIT(7)
 
+#define MT792x_CHIP_CAP_CLC_EVT_EN BIT(0)
+
 /* NOTE: used to map mt76_rates. idx may change if firmware expands table */
 #define MT792x_BASIC_RATES_TBL	11
 
@@ -122,6 +124,7 @@ struct mt792x_phy {
 	struct mt76_mib_stats mib;
 
 	u8 sta_work_count;
+	u8 clc_chan_conf;
 	enum mt792x_reg_power_type power_type;
 
 	struct sk_buff_head scan_event_list;
@@ -130,6 +133,7 @@ struct mt792x_phy {
 	void *acpisar;
 #endif
 	void *clc[MT792x_CLC_MAX_NUM];
+	u64 chip_cap;
 
 	struct work_struct roc_work;
 	struct timer_list roc_timer;
-- 
2.18.0


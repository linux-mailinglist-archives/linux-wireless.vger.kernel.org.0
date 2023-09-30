Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6F27B3D9C
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Sep 2023 04:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbjI3CZi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Sep 2023 22:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjI3CZg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Sep 2023 22:25:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A921B2
        for <linux-wireless@vger.kernel.org>; Fri, 29 Sep 2023 19:25:27 -0700 (PDT)
X-UUID: 9a8600705f3811eea33bb35ae8d461a2-20230930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=aJTpnXuNUyYxFQxaLTywEBmMeu5lkW5KD0n38e8Uv0I=;
        b=av8yGH2pnsSHfJz+fqFVPgQJR8IUMydFkG9jZOi5lcvgjJllBFEaSmUIiKj1GemvUOhKo/wnjH2YtSg0sFsdU5aYMg7+46otlDkB/rarBSS34l2fERNhURkjN1FrhWA3rKoJXjIKKFQsJWVHtIK2kcrmtwCAA1w6mPDN0mH4fdk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:2786c5b1-ed97-462f-b03d-deb5f511b801,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:0de548f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9a8600705f3811eea33bb35ae8d461a2-20230930
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 162622822; Sat, 30 Sep 2023 10:25:21 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 30 Sep 2023 10:25:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 30 Sep 2023 10:25:19 +0800
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
Subject: [PATCH v2 1/6] wifi: mt76: mt7921: move connac nic capability handling to mt7921
Date:   Sat, 30 Sep 2023 10:25:05 +0800
Message-ID: <5d35532f0b8435f89d824cccedb2a62b75b8d149.1696039301.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1696039301.git.deren.wu@mediatek.com>
References: <cover.1696039301.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt76_connac_mcu_get_nic_capability() is used by mt7921 only. It
would be better to put the code in chip folder. And we can provide
more chip capability information in mt792x_phy without making
mt76_phy much bigger.

The three functions would be moved to mt7921 folder and renamed.
mt76_connac_mcu_parse_tx_resource()
mt76_connac_mcu_parse_phy_cap()
mt76_connac_mcu_get_nic_capability()

Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 120 -----------------
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   1 -
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 122 +++++++++++++++++-
 3 files changed, 121 insertions(+), 122 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index bcd6c20f37ad..83cf2e2b2868 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1941,126 +1941,6 @@ void mt76_connac_mcu_coredump_event(struct mt76_dev *dev, struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_coredump_event);
 
-static void mt76_connac_mcu_parse_tx_resource(struct mt76_dev *dev,
-					      struct sk_buff *skb)
-{
-	struct mt76_sdio *sdio = &dev->sdio;
-	struct mt76_connac_tx_resource {
-		__le32 version;
-		__le32 pse_data_quota;
-		__le32 pse_mcu_quota;
-		__le32 ple_data_quota;
-		__le32 ple_mcu_quota;
-		__le16 pse_page_size;
-		__le16 ple_page_size;
-		u8 pp_padding;
-		u8 pad[3];
-	} __packed * tx_res;
-
-	tx_res = (struct mt76_connac_tx_resource *)skb->data;
-	sdio->sched.pse_data_quota = le32_to_cpu(tx_res->pse_data_quota);
-	sdio->sched.pse_mcu_quota = le32_to_cpu(tx_res->pse_mcu_quota);
-	sdio->sched.ple_data_quota = le32_to_cpu(tx_res->ple_data_quota);
-	sdio->sched.pse_page_size = le16_to_cpu(tx_res->pse_page_size);
-	sdio->sched.deficit = tx_res->pp_padding;
-}
-
-static void mt76_connac_mcu_parse_phy_cap(struct mt76_dev *dev,
-					  struct sk_buff *skb)
-{
-	struct mt76_connac_phy_cap {
-		u8 ht;
-		u8 vht;
-		u8 _5g;
-		u8 max_bw;
-		u8 nss;
-		u8 dbdc;
-		u8 tx_ldpc;
-		u8 rx_ldpc;
-		u8 tx_stbc;
-		u8 rx_stbc;
-		u8 hw_path;
-		u8 he;
-	} __packed * cap;
-
-	enum {
-		WF0_24G,
-		WF0_5G
-	};
-
-	cap = (struct mt76_connac_phy_cap *)skb->data;
-
-	dev->phy.antenna_mask = BIT(cap->nss) - 1;
-	dev->phy.chainmask = dev->phy.antenna_mask;
-	dev->phy.cap.has_2ghz = cap->hw_path & BIT(WF0_24G);
-	dev->phy.cap.has_5ghz = cap->hw_path & BIT(WF0_5G);
-}
-
-int mt76_connac_mcu_get_nic_capability(struct mt76_phy *phy)
-{
-	struct mt76_connac_cap_hdr {
-		__le16 n_element;
-		u8 rsv[2];
-	} __packed * hdr;
-	struct sk_buff *skb;
-	int ret, i;
-
-	ret = mt76_mcu_send_and_get_msg(phy->dev, MCU_CE_CMD(GET_NIC_CAPAB),
-					NULL, 0, true, &skb);
-	if (ret)
-		return ret;
-
-	hdr = (struct mt76_connac_cap_hdr *)skb->data;
-	if (skb->len < sizeof(*hdr)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	skb_pull(skb, sizeof(*hdr));
-
-	for (i = 0; i < le16_to_cpu(hdr->n_element); i++) {
-		struct tlv_hdr {
-			__le32 type;
-			__le32 len;
-		} __packed * tlv = (struct tlv_hdr *)skb->data;
-		int len;
-
-		if (skb->len < sizeof(*tlv))
-			break;
-
-		skb_pull(skb, sizeof(*tlv));
-
-		len = le32_to_cpu(tlv->len);
-		if (skb->len < len)
-			break;
-
-		switch (le32_to_cpu(tlv->type)) {
-		case MT_NIC_CAP_6G:
-			phy->cap.has_6ghz = skb->data[0];
-			break;
-		case MT_NIC_CAP_MAC_ADDR:
-			memcpy(phy->macaddr, (void *)skb->data, ETH_ALEN);
-			break;
-		case MT_NIC_CAP_PHY:
-			mt76_connac_mcu_parse_phy_cap(phy->dev, skb);
-			break;
-		case MT_NIC_CAP_TX_RESOURCE:
-			if (mt76_is_sdio(phy->dev))
-				mt76_connac_mcu_parse_tx_resource(phy->dev,
-								  skb);
-			break;
-		default:
-			break;
-		}
-		skb_pull(skb, len);
-	}
-out:
-	dev_kfree_skb(skb);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(mt76_connac_mcu_get_nic_capability);
-
 static void
 mt76_connac_mcu_build_sku(struct mt76_dev *dev, s8 *sku,
 			  struct mt76_power_limits *limits,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 9bc97a35fc1d..b73dbe1dbf3a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1881,7 +1881,6 @@ int mt76_connac_mcu_init_download(struct mt76_dev *dev, u32 addr, u32 len,
 int mt76_connac_mcu_start_patch(struct mt76_dev *dev);
 int mt76_connac_mcu_patch_sem_ctrl(struct mt76_dev *dev, bool get);
 int mt76_connac_mcu_start_firmware(struct mt76_dev *dev, u32 addr, u32 option);
-int mt76_connac_mcu_get_nic_capability(struct mt76_phy *phy);
 
 int mt76_connac_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 			    struct ieee80211_scan_request *scan_req);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 90c93970acab..8d9ebe34816a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -448,6 +448,126 @@ static int mt7921_load_clc(struct mt792x_dev *dev, const char *fw_name)
 	return ret;
 }
 
+static void mt7921_mcu_parse_tx_resource(struct mt76_dev *dev,
+					 struct sk_buff *skb)
+{
+	struct mt76_sdio *sdio = &dev->sdio;
+	struct mt7921_tx_resource {
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
+	tx_res = (struct mt7921_tx_resource *)skb->data;
+	sdio->sched.pse_data_quota = le32_to_cpu(tx_res->pse_data_quota);
+	sdio->sched.pse_mcu_quota = le32_to_cpu(tx_res->pse_mcu_quota);
+	sdio->sched.ple_data_quota = le32_to_cpu(tx_res->ple_data_quota);
+	sdio->sched.pse_page_size = le16_to_cpu(tx_res->pse_page_size);
+	sdio->sched.deficit = tx_res->pp_padding;
+}
+
+static void mt7921_mcu_parse_phy_cap(struct mt76_dev *dev,
+				     struct sk_buff *skb)
+{
+	struct mt7921_phy_cap {
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
+	cap = (struct mt7921_phy_cap *)skb->data;
+
+	dev->phy.antenna_mask = BIT(cap->nss) - 1;
+	dev->phy.chainmask = dev->phy.antenna_mask;
+	dev->phy.cap.has_2ghz = cap->hw_path & BIT(WF0_24G);
+	dev->phy.cap.has_5ghz = cap->hw_path & BIT(WF0_5G);
+}
+
+static int mt7921_mcu_get_nic_capability(struct mt792x_phy *mphy)
+{
+	struct mt76_connac_cap_hdr {
+		__le16 n_element;
+		u8 rsv[2];
+	} __packed * hdr;
+	struct sk_buff *skb;
+	struct mt76_phy *phy = mphy->mt76;
+	int ret, i;
+
+	ret = mt76_mcu_send_and_get_msg(phy->dev, MCU_CE_CMD(GET_NIC_CAPAB),
+					NULL, 0, true, &skb);
+	if (ret)
+		return ret;
+
+	hdr = (struct mt76_connac_cap_hdr *)skb->data;
+	if (skb->len < sizeof(*hdr)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	skb_pull(skb, sizeof(*hdr));
+
+	for (i = 0; i < le16_to_cpu(hdr->n_element); i++) {
+		struct tlv_hdr {
+			__le32 type;
+			__le32 len;
+		} __packed * tlv = (struct tlv_hdr *)skb->data;
+		int len;
+
+		if (skb->len < sizeof(*tlv))
+			break;
+
+		skb_pull(skb, sizeof(*tlv));
+
+		len = le32_to_cpu(tlv->len);
+		if (skb->len < len)
+			break;
+
+		switch (le32_to_cpu(tlv->type)) {
+		case MT_NIC_CAP_6G:
+			phy->cap.has_6ghz = skb->data[0];
+			break;
+		case MT_NIC_CAP_MAC_ADDR:
+			memcpy(phy->macaddr, (void *)skb->data, ETH_ALEN);
+			break;
+		case MT_NIC_CAP_PHY:
+			mt7921_mcu_parse_phy_cap(phy->dev, skb);
+			break;
+		case MT_NIC_CAP_TX_RESOURCE:
+			if (mt76_is_sdio(phy->dev))
+				mt7921_mcu_parse_tx_resource(phy->dev,
+							     skb);
+			break;
+		default:
+			break;
+		}
+		skb_pull(skb, len);
+	}
+out:
+	dev_kfree_skb(skb);
+
+	return ret;
+}
+
 int mt7921_mcu_fw_log_2_host(struct mt792x_dev *dev, u8 ctrl)
 {
 	struct {
@@ -469,7 +589,7 @@ int mt7921_run_firmware(struct mt792x_dev *dev)
 	if (err)
 		return err;
 
-	err = mt76_connac_mcu_get_nic_capability(&dev->mphy);
+	err = mt7921_mcu_get_nic_capability(&dev->phy);
 	if (err)
 		return err;
 
-- 
2.18.0


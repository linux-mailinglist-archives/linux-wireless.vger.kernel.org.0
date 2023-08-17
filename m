Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B5677F1B5
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 10:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348699AbjHQICf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 04:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348731AbjHQIC3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 04:02:29 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E662D78
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 01:02:20 -0700 (PDT)
X-UUID: 5e9338703cd411eeb20a276fd37b9834-20230817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=9ATIZpJ2w3N3sucx0S1V3QUJsvXOXomP4YLguTKBHGM=;
        b=D0BSsREPppvg0gEZzrOEGqrtVvx4Kxr7Yc3ZGg5WtzkSPS26nS6tmZLxzoIxEmj++LFl+UWsqIT2g9EnM5MsYMgFgltM1HbBVs6OdDFGwe+u+9f8oj8NqNT3So34tbuUgJ4HDwpaxw4VOHvDwjpzejWBDfUbVl06/4gonO0jfFM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:fd5ce1a8-e584-4269-af19-a024ad827077,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.31,REQID:fd5ce1a8-e584-4269-af19-a024ad827077,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:0ad78a4,CLOUDID:e14cdf12-4929-4845-9571-38c601e9c3c9,B
        ulkID:230817160211GDCU45EO,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,
        TF_CID_SPAM_SDM
X-UUID: 5e9338703cd411eeb20a276fd37b9834-20230817
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 314671696; Thu, 17 Aug 2023 16:02:11 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 17 Aug 2023 16:02:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 17 Aug 2023 16:02:10 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Michael-CY Lee <michael-cy.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 1/9] wifi: mt76: mt7996: set correct wcid in txp
Date:   Thu, 17 Aug 2023 16:01:46 +0800
Message-ID: <20230817080154.16475-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Set correct wcid in txp to let the SDO hw module look into the correct
wtbl, otherwise the tx descriptor may be wrongly fiiled. This patch also
fixed the issue that driver could not correctly report sta statistics,
especially in WDS mode, which misled AQL.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Co-developed-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c       | 8 +++-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
index 68ca0844cbbf..87bfa441a937 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
@@ -257,6 +257,8 @@ enum tx_mgnt_type {
 #define MT_TXD7_UDP_TCP_SUM		BIT(15)
 #define MT_TXD7_TX_TIME			GENMASK(9, 0)
 
+#define MT_TXD9_WLAN_IDX		GENMASK(23, 8)
+
 #define MT_TX_RATE_STBC			BIT(14)
 #define MT_TX_RATE_NSS			GENMASK(13, 10)
 #define MT_TX_RATE_MODE			GENMASK(9, 6)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index ac8759febe48..9e866ee13c85 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -991,10 +991,8 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	}
 
 	txp->fw.token = cpu_to_le16(id);
-	if (test_bit(MT_WCID_FLAG_4ADDR, &wcid->flags))
-		txp->fw.rept_wds_wcid = cpu_to_le16(wcid->idx);
-	else
-		txp->fw.rept_wds_wcid = cpu_to_le16(0xfff);
+	txp->fw.rept_wds_wcid = cpu_to_le16(sta ? wcid->idx : 0xfff);
+
 	tx_info->skb = DMA_DUMMY_DATA;
 
 	/* pass partial skb header to fw */
@@ -1051,7 +1049,7 @@ mt7996_txwi_free(struct mt7996_dev *dev, struct mt76_txwi_cache *t,
 		if (likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
 			mt7996_tx_check_aggr(sta, txwi);
 	} else {
-		wcid_idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
+		wcid_idx = le32_get_bits(txwi[9], MT_TXD9_WLAN_IDX);
 	}
 
 	__mt76_tx_complete_skb(mdev, wcid_idx, t->skb, free_list);
-- 
2.39.2


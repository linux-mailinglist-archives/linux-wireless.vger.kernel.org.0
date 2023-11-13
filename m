Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B51B7E96E9
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 08:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjKMHHn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 02:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjKMHHl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 02:07:41 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E600E10FD
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 23:07:36 -0800 (PST)
X-UUID: 50afe2da81f311eea33bb35ae8d461a2-20231113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uyG05mE6RnhLnMn3cge95AIPXGfaD4SF7Jbusk7F+ek=;
        b=ZJZ9H16Ew/HP55YtkQHiCCbxuV/5DnglZnLZpBoi/AgEcn4YNfINplPztF8So7LQq2T3hlbeAXaDoXx6b/7SchTkdG8w29htL+SY+CW6FVKoHQZB58w1fPMzSPk0Ri9zhTJqYThbP3wYMn4Seas2iCPFWXLzVjRyW2geCG6s5iA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:5ae204b0-9bcc-4ae9-aeba-cf85b7cfd1ed,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:aeb1fd5f-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 50afe2da81f311eea33bb35ae8d461a2-20231113
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 59694520; Mon, 13 Nov 2023 15:07:32 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 13 Nov 2023 15:07:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 13 Nov 2023 15:07:31 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 6/8] wifi: mt76: mt7996: adjust interface num and wtbl size for mt7992
Date:   Mon, 13 Nov 2023 15:06:17 +0800
Message-ID: <20231113070619.19964-7-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231113070619.19964-1-shayne.chen@mediatek.com>
References: <20231113070619.19964-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

MT7992 chipsets support up to 32 interfaces (with maximum 19 per-band)
and 512 station entries.
This is a preliminary patch for mt7992 chipsets support.

Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 8 +++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
index 9c3735bed50c..fc6a0c8efa42 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
@@ -112,7 +112,8 @@ static int mt7996_eeprom_parse_efuse_hw_cap(struct mt7996_dev *dev)
 		dev->wtbl_size_group = u32_get_bits(cap, WTBL_SIZE_GROUP);
 	}
 
-	if (dev->wtbl_size_group < 2 || dev->wtbl_size_group > 4)
+	if (dev->wtbl_size_group < 2 || dev->wtbl_size_group > 4 ||
+	    is_mt7992(&dev->mt76))
 		dev->wtbl_size_group = 2; /* set default */
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 5cdde28ce83f..bc73bcb47bf0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -13,6 +13,7 @@
 
 #define MT7996_MAX_INTERFACES		19	/* per-band */
 #define MT7996_MAX_WMM_SETS		4
+#define MT7996_WTBL_BMC_SIZE		(is_mt7992(&dev->mt76) ? 32 : 64)
 #define MT7996_WTBL_RESERVED		(mt7996_wtbl_size(dev) - 1)
 #define MT7996_WTBL_STA			(MT7996_WTBL_RESERVED - \
 					 mt7996_max_interface_num(dev))
@@ -512,13 +513,14 @@ int mt7996_mcu_wed_rro_reset_sessions(struct mt7996_dev *dev, u16 id);
 
 static inline u8 mt7996_max_interface_num(struct mt7996_dev *dev)
 {
-	return MT7996_MAX_INTERFACES * (1 + mt7996_band_valid(dev, MT_BAND1) +
-					mt7996_band_valid(dev, MT_BAND2));
+	return min(MT7996_MAX_INTERFACES * (1 + mt7996_band_valid(dev, MT_BAND1) +
+					    mt7996_band_valid(dev, MT_BAND2)),
+		   MT7996_WTBL_BMC_SIZE);
 }
 
 static inline u16 mt7996_wtbl_size(struct mt7996_dev *dev)
 {
-	return (dev->wtbl_size_group << 8) + 64;
+	return (dev->wtbl_size_group << 8) + MT7996_WTBL_BMC_SIZE;
 }
 
 void mt7996_dual_hif_set_irq_mask(struct mt7996_dev *dev, bool write_reg,
-- 
2.39.2


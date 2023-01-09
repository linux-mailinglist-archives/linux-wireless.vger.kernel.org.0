Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A8E662C32
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 18:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbjAIRGw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 12:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237313AbjAIQ6R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 11:58:17 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9959E12634
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 08:58:13 -0800 (PST)
X-UUID: f7c0c6d1a1e145539a67cba90c64bbb9-20230110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OVPGB0cO9lzZxQqdNU6cdCHWvpa/kh+fhSMQf9MJ5HE=;
        b=YqQNH34caFF3HlihHiJFgt/lEhmh9dlQEoP2ibBn1Wv8xQN7BDAp3+bEh9QNgbJX8VpcG89HEEy21lHGWhJmIWEFwX9zTTsQUVjD3pEuI+0dkV+yIhnykCEkF2Nugl7YWYxjbX8hOeoFMSE4aUYfxtidxm1HCA8GRneDpFaCb08=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:8ce3cd04-5035-4a6a-b8ab-81e60ef9b7b4,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.17,REQID:8ce3cd04-5035-4a6a-b8ab-81e60ef9b7b4,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:543e81c,CLOUDID:ccc84af5-ff42-4fb0-b929-626456a83c14,B
        ulkID:230110005809Y0KR62DJ,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0
X-CID-BVR: 0
X-UUID: f7c0c6d1a1e145539a67cba90c64bbb9-20230110
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 488545325; Tue, 10 Jan 2023 00:58:06 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 10 Jan 2023 00:58:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 10 Jan 2023 00:58:05 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 05/13] wifi: mt76: increase wcid size to 1088
Date:   Tue, 10 Jan 2023 00:57:23 +0800
Message-ID: <20230109165731.682-6-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230109165731.682-1-shayne.chen@mediatek.com>
References: <20230109165731.682-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Increase wcid size to support up to 1024 station hw entries and
64 bcast/mcast hw entries.
This is the preliminary patch to add EHT support for mt7996.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h            | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 9fa8c5f63801..b3fd3abfdd9f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -294,7 +294,7 @@ enum mt76_wcid_flags {
 	MT_WCID_FLAG_HDR_TRANS,
 };
 
-#define MT76_N_WCIDS 544
+#define MT76_N_WCIDS 1088
 
 /* stored in ieee80211_tx_info::hw_queue */
 #define MT_TX_HW_QUEUE_PHY		GENMASK(3, 2)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index e26c4e4a2a16..8926d1785c92 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1736,7 +1736,7 @@ mt76_connac_mcu_gen_dl_mode(struct mt76_dev *dev, u8 feature_set, bool is_wa)
 }
 
 #define to_wcid_lo(id)		FIELD_GET(GENMASK(7, 0), (u16)id)
-#define to_wcid_hi(id)		FIELD_GET(GENMASK(9, 8), (u16)id)
+#define to_wcid_hi(id)		FIELD_GET(GENMASK(10, 8), (u16)id)
 
 static inline void
 mt76_connac_mcu_get_wlan_idx(struct mt76_dev *dev, struct mt76_wcid *wcid,
-- 
2.25.1


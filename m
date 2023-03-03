Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6025F6A9310
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Mar 2023 09:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjCCIvs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Mar 2023 03:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCCIvr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Mar 2023 03:51:47 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A904DBF3
        for <linux-wireless@vger.kernel.org>; Fri,  3 Mar 2023 00:51:45 -0800 (PST)
X-UUID: 7fac3714b99e11eda06fc9ecc4dadd91-20230303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=mgia7VViLxui5gr7OI+uQVwVASC4GNy0KtzO7smAnZU=;
        b=JJA0zbh3gpeUKBdxrgxNx+6q4ChW35b/7JGQOeFi4zLQnESZzXHaIa6iW3zHulrsj8LW4KePJh3rgVoxdXLfqek6z7gVD2aK5EbHaeFdHNxULDoP1GZ32JoZ9i0G9DjQ85vPvoYeuc/yJP3fPgvdCTKM3Xjq3Gi52pXeA9VfHaw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:727a751e-1543-4e4d-a527-8e9de06fa79a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:25b5999,CLOUDID:ad95a9f4-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 7fac3714b99e11eda06fc9ecc4dadd91-20230303
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1766292571; Fri, 03 Mar 2023 16:36:31 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 3 Mar 2023 16:36:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 3 Mar 2023 16:36:30 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 1/7] wifi: mt76: mt7996: add eht rx rate support
Date:   Fri, 3 Mar 2023 16:35:52 +0800
Message-ID: <20230303083558.3586-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

Add support to report eht rx rate.
Note that extended fields for eht in mt76_rx_status will make the struct
size exceed the cb size, so make nss and band share the same u8.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c  | 11 ++++++++---
 drivers/net/wireless/mediatek/mt76/mt76.h      | 18 ++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7996/mac.c    |  9 +++++----
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 5ebadf8367ae..d2f522812c3e 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1059,9 +1059,14 @@ mt76_rx_convert(struct mt76_dev *dev, struct sk_buff *skb,
 	status->enc_flags = mstat.enc_flags;
 	status->encoding = mstat.encoding;
 	status->bw = mstat.bw;
-	status->he_ru = mstat.he_ru;
-	status->he_gi = mstat.he_gi;
-	status->he_dcm = mstat.he_dcm;
+	if (status->encoding == RX_ENC_EHT) {
+		status->eht.ru = mstat.eht.ru;
+		status->eht.gi = mstat.eht.gi;
+	} else {
+		status->he_ru = mstat.he_ru;
+		status->he_gi = mstat.he_gi;
+		status->he_dcm = mstat.he_dcm;
+	}
 	status->rate_idx = mstat.rate_idx;
 	status->nss = mstat.nss;
 	status->band = mstat.band;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index ccca0162c8f8..cca7447eea89 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -620,12 +620,22 @@ struct mt76_rx_status {
 	u16 freq;
 	u32 flag;
 	u8 enc_flags;
-	u8 encoding:2, bw:3, he_ru:3;
-	u8 he_gi:2, he_dcm:1;
+	u8 encoding:3, bw:4;
+	union {
+		struct {
+			u8 he_ru:3;
+			u8 he_gi:2;
+			u8 he_dcm:1;
+		};
+		struct {
+			u8 ru:4;
+			u8 gi:2;
+		} eht;
+	};
+
 	u8 amsdu:1, first_amsdu:1, last_amsdu:1;
 	u8 rate_idx;
-	u8 nss;
-	u8 band;
+	u8 nss:5, band:3;
 	s8 signal;
 	u8 chains;
 	s8 chain_signal[IEEE80211_MAX_CHAINS];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 3c3506c7c87a..d811b4e01800 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -572,11 +572,12 @@ mt7996_mac_fill_rx_rate(struct mt7996_dev *dev,
 	case MT_PHY_TYPE_EHT_SU:
 	case MT_PHY_TYPE_EHT_TRIG:
 	case MT_PHY_TYPE_EHT_MU:
-		/* TODO: currently report rx rate with HE rate */
 		status->nss = nss;
-		status->encoding = RX_ENC_HE;
-		bw = min_t(int, bw, IEEE80211_STA_RX_BW_160);
-		i = min_t(int, i & 0xf, 11);
+		status->encoding = RX_ENC_EHT;
+		i &= GENMASK(3, 0);
+
+		if (gi <= NL80211_RATE_INFO_EHT_GI_3_2)
+			status->eht.gi = gi;
 		break;
 	default:
 		return -EINVAL;
-- 
2.39.2


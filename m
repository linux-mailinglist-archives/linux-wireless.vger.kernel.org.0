Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5DF7AA3C3
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 23:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjIUV5l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 17:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjIUV53 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 17:57:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E323741C6
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 14:04:24 -0700 (PDT)
X-UUID: 6e4f9bf058c211eea33bb35ae8d461a2-20230922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Vwyy3Yxmaicnbmda91e2YwqDKMMX0W2HPT33lkRcdI8=;
        b=aS/5Vfzh6d+zWWnyi1Mz+a/Vcdlh7VOzaDjK4D85Yd5MtYMC6jAE6piMYYkKcenxlYm0EwG0nPxFlnOJA6XYWGn9NA9aqYlYuX6gCC0Cg9QcWg3Gqzo+5sBRjlekc3Ci8pjTVyfN5OdhLVw+Hkc0IGoFWPfBoCNq1Yrm87w1+wA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:bea7ddf6-8e70-4758-8d4a-4de829b0b17b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:db8e3814-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6e4f9bf058c211eea33bb35ae8d461a2-20230922
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yi-chia.hsieh@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1981583647; Fri, 22 Sep 2023 05:04:19 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Sep 2023 05:04:17 +0800
Received: from mussdccf250.mussds.eus.mediatek.inc (10.73.250.250) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Sep 2023 05:04:14 +0800
From:   Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Benjamin Lin <benjamin-jw.lin@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>
Subject: [PATCH v3 1/4] wifi: mt76: mt7996: get tx_retries and tx_failed from txfree
Date:   Thu, 21 Sep 2023 14:04:00 -0700
Message-ID: <d698600dc16fc3880e75dd24e2338ac21d51a45a.1695329286.git.yi-chia.hsieh@mediatek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.436100-8.000000
X-TMASE-MatchedRID: hBPcN6g5NxXi9mOUjCQGLxUuRQtxMyQBUK80YYUAl4sXdhT0BAdFznf6
        Lj8RU1GvgfONumQ1QfdfxhAzc2dPJhLmJd2F/yFu9UVHiwLx0/JPn74Ug5EKECz+5QCTrE/svkE
        SpfBKzZSd+hadbvZSHMh3ymsKdHdu0ywZEqbRuQSiAZ3zAhQYglmLvTysL4PPTUobVis5Bb91V+
        LIUmKTyHmd/bhGlF1I3m2M6A2xWxxPXYdz0WFWNeKXavbHY/C1zjhG4bTm6hKbKItl61J/yZ+in
        TK0bC9eKrauXd3MZDX371moSn0VOIS0P2RhP4PyO4AtpkPwvvzVg50E4H/jkQtPWsP8JaiDzxJp
        yqZmdl9b4ZZQJ/B3fGcbgAb+RLrnXprqe3vYrk55HCv4Lr/VGRdGg+ZY7eN6THB2Q+oKru8MTI3
        4nyF36MJL1aANdU8Knqg/VrSZEiM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.436100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 58813013783525298B8935956AF9C4D1A45164F07018A8C25A34BB870F6FA4B22000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Retrieve tx retries/failed counts from 'txfree done' events and report
them via mt7996_sta_statistics().

Signed-off-by: Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
Signed-off-by: Money Wang <Money.Wang@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v2: split series
---
v3: rebase and update Signed-off-by
---
 .../wireless/mediatek/mt76/mt76_connac3_mac.h |  4 ++--
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 21 ++++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  6 ++++++
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
index 87bfa441a937..d49fe24851be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
@@ -271,11 +271,11 @@ enum tx_mgnt_type {
 #define MT_TXFREE0_MSDU_CNT		GENMASK(25, 16)
 #define MT_TXFREE0_RX_BYTE		GENMASK(15, 0)
 
-#define MT_TXFREE1_VER			GENMASK(18, 16)
+#define MT_TXFREE1_VER			GENMASK(19, 16)
 
 #define MT_TXFREE_INFO_PAIR		BIT(31)
 #define MT_TXFREE_INFO_HEADER		BIT(30)
-#define MT_TXFREE_INFO_WLAN_ID		GENMASK(23, 12)
+#define MT_TXFREE_INFO_MLD_ID		GENMASK(23, 12)
 #define MT_TXFREE_INFO_MSDU_ID		GENMASK(14, 0)
 #define MT_TXFREE_INFO_COUNT		GENMASK(27, 24)
 #define MT_TXFREE_INFO_STAT		GENMASK(29, 28)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index c43839a20508..d442746c8d96 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1070,6 +1070,7 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 	struct mt76_phy *phy3 = mdev->phys[MT_BAND2];
 	struct mt76_txwi_cache *txwi;
 	struct ieee80211_sta *sta = NULL;
+	struct mt76_wcid *wcid;
 	LIST_HEAD(free_list);
 	struct sk_buff *skb, *tmp;
 	void *end = data + len;
@@ -1088,7 +1089,7 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 		mt76_queue_tx_cleanup(dev, phy3->q_tx[MT_TXQ_BE], false);
 	}
 
-	if (WARN_ON_ONCE(le32_get_bits(tx_free[1], MT_TXFREE1_VER) < 4))
+	if (WARN_ON_ONCE(le32_get_bits(tx_free[1], MT_TXFREE1_VER) < 5))
 		return;
 
 	total = le32_get_bits(tx_free[0], MT_TXFREE0_MSDU_CNT);
@@ -1104,10 +1105,9 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 		info = le32_to_cpu(*cur_info);
 		if (info & MT_TXFREE_INFO_PAIR) {
 			struct mt7996_sta *msta;
-			struct mt76_wcid *wcid;
 			u16 idx;
 
-			idx = FIELD_GET(MT_TXFREE_INFO_WLAN_ID, info);
+			idx = FIELD_GET(MT_TXFREE_INFO_MLD_ID, info);
 			wcid = rcu_dereference(dev->mt76.wcid[idx]);
 			sta = wcid_to_sta(wcid);
 			if (!sta)
@@ -1120,10 +1120,21 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 					      &mdev->sta_poll_list);
 			spin_unlock_bh(&mdev->sta_poll_lock);
 			continue;
-		}
+		} else if (info & MT_TXFREE_INFO_HEADER) {
+			u32 tx_retries = 0, tx_failed = 0;
+
+			if (!wcid)
+				continue;
+
+			tx_retries =
+				FIELD_GET(MT_TXFREE_INFO_COUNT, info) - 1;
+			tx_failed = tx_retries +
+				!!FIELD_GET(MT_TXFREE_INFO_STAT, info);
 
-		if (info & MT_TXFREE_INFO_HEADER)
+			wcid->stats.tx_retries += tx_retries;
+			wcid->stats.tx_failed += tx_failed;
 			continue;
+		}
 
 		for (i = 0; i < 2; i++) {
 			msdu = (info >> (15 * i)) & MT_TXFREE_INFO_MSDU_ID;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index a2ab668a3b0f..0072809ae617 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -989,6 +989,12 @@ static void mt7996_sta_statistics(struct ieee80211_hw *hw,
 	sinfo->txrate.flags = txrate->flags;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 
+	sinfo->tx_failed = msta->wcid.stats.tx_failed;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+
+	sinfo->tx_retries = msta->wcid.stats.tx_retries;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+
 	sinfo->ack_signal = (s8)msta->ack_signal;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL);
 
-- 
2.39.0


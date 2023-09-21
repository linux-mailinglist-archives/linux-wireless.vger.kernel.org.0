Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002977AA2B4
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 23:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjIUVcB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 17:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjIUV31 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 17:29:27 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC19883F6C
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 14:04:27 -0700 (PDT)
X-UUID: 71061d0658c211eea33bb35ae8d461a2-20230922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=h6uORFXHzjhkzWM4MLlPmU/ldOOGcbD19laNDaCS618=;
        b=eDMaDQbMlvM62v8yELZDpeCJ/+699Eh2TIpNFB58cKZDIS7DG+nAyUmwHwW+uE3FePWDoYSuyuX/IQsC/6cpqqR8mToQWF/xH653lGb0aDwyu+D3VcIloKvDvoGMaIERWm498paQ+cbnNSFkvV2+cIxOGtnKoHXMrDR19nQ1UDc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:dde708b5-03ac-4cb2-96ed-1cc95c6ea255,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:395e1ebf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 71061d0658c211eea33bb35ae8d461a2-20230922
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <yi-chia.hsieh@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1482382961; Fri, 22 Sep 2023 05:04:23 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Sep 2023 05:04:22 +0800
Received: from mussdccf250.mussds.eus.mediatek.inc (10.73.250.250) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Sep 2023 05:04:20 +0800
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
Subject: [PATCH v3 3/4] wifi: mt76: mt7996: enable PPDU-TxS to host
Date:   Thu, 21 Sep 2023 14:04:02 -0700
Message-ID: <4a9b7b746d650b0b4408fd8d1cf9d39c6b754260.1695329286.git.yi-chia.hsieh@mediatek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <d698600dc16fc3880e75dd24e2338ac21d51a45a.1695329286.git.yi-chia.hsieh@mediatek.com>
References: <d698600dc16fc3880e75dd24e2338ac21d51a45a.1695329286.git.yi-chia.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.277600-8.000000
X-TMASE-MatchedRID: 6iwSCiOWMv1oAILruplAqm3NvezwBrVmojQrbrPpzzrMSJVVqDHzVvc8
        ycnD6i3Bp85gxBv3LfahL1gZH1RBjRUApFoweqMOuHNkj91+t05XLUapz6y7gd9RlPzeVuQQ+r4
        ksoUQ8wXDNUH3WlCsBBiEyzmuDcnxJnCBXxGDu1zil2r2x2PwtTGZtPrBBPZrv8D7QPW2jo+Dtx
        8lDD0Wx5CyeoerVGh4WulnZSBX95Im5AOvWP9uBAwfhKwa9GwDfS0Ip2eEHnz3IzXlXlpamPoLR
        4+zsDTtgUicvJ4MChkdKf3oPxd+K0OyS6OILOS59rBZIsPbzRyBAO8Di6lHtxYzt7DFjEwy
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.277600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 806FC96BEBA2DFC42AF49B813A6785FD45E66A507FF8DA8434F557001C52086C2000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable PPDU TxS by default. This makes the driver able to get Tx rate
information from TxS. The driver will also refresh BA session timer
on receive of PPDU TxS when WED is on.

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
 .../wireless/mediatek/mt76/mt76_connac3_mac.h | 16 +++++++-
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  5 +++
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 41 +++++++++++--------
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |  7 ++++
 4 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
index d49fe24851be..89e4685e931e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
@@ -305,7 +305,7 @@ enum tx_mgnt_type {
 
 #define MT_TXS2_BF_STATUS		GENMASK(31, 30)
 #define MT_TXS2_BAND			GENMASK(29, 28)
-#define MT_TXS2_WCID			GENMASK(27, 16)
+#define MT_TXS2_MLD_ID			GENMASK(27, 16)
 #define MT_TXS2_TX_DELAY		GENMASK(15, 0)
 
 #define MT_TXS3_PID			GENMASK(31, 24)
@@ -317,6 +317,7 @@ enum tx_mgnt_type {
 
 #define MT_TXS4_TIMESTAMP		GENMASK(31, 0)
 
+/* MPDU based TXS */
 #define MT_TXS5_F0_FINAL_MPDU		BIT(31)
 #define MT_TXS5_F0_QOS			BIT(30)
 #define MT_TXS5_F0_TX_COUNT		GENMASK(29, 25)
@@ -338,4 +339,17 @@ enum tx_mgnt_type {
 #define MT_TXS7_F1_MPDU_RETRY_COUNT	GENMASK(31, 24)
 #define MT_TXS7_F1_MPDU_RETRY_BYTES	GENMASK(23, 0)
 
+/* PPDU based TXS */
+#define MT_TXS5_MPDU_TX_CNT		GENMASK(30, 20)
+#define MT_TXS5_MPDU_TX_BYTE_SCALE	BIT(15)
+#define MT_TXS5_MPDU_TX_BYTE		GENMASK(14, 0)
+
+#define MT_TXS6_MPDU_FAIL_CNT		GENMASK(30, 20)
+#define MT_TXS6_MPDU_FAIL_BYTE_SCALE	BIT(15)
+#define MT_TXS6_MPDU_FAIL_BYTE		GENMASK(14, 0)
+
+#define MT_TXS7_MPDU_RETRY_CNT		GENMASK(30, 20)
+#define MT_TXS7_MPDU_RETRY_BYTE_SCALE	BIT(15)
+#define MT_TXS7_MPDU_RETRY_BYTE		GENMASK(14, 0)
+
 #endif /* __MT76_CONNAC3_MAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index e4bb22b84159..55cb1770fa34 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -274,6 +274,11 @@ mt7996_mac_init_band(struct mt7996_dev *dev, u8 band)
 	set = FIELD_PREP(MT_WTBLOFF_RSCR_RCPI_MODE, 0) |
 	      FIELD_PREP(MT_WTBLOFF_RSCR_RCPI_PARAM, 0x3);
 	mt76_rmw(dev, MT_WTBLOFF_RSCR(band), mask, set);
+
+	/* MT_TXD5_TX_STATUS_HOST (MPDU format) has higher priority than
+	 * MT_AGG_ACR_PPDU_TXS2H (PPDU format) even though ACR bit is set.
+	 */
+	mt76_set(dev, MT_AGG_ACR4(band), MT_AGG_ACR_PPDU_TXS2H);
 }
 
 static void mt7996_mac_init_basic_rates(struct mt7996_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index c792b5e0f6f8..a0aa592fbe4b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1178,22 +1178,31 @@ mt7996_mac_add_txs_skb(struct mt7996_dev *dev, struct mt76_wcid *wcid,
 	bool cck = false;
 	u32 txrate, txs, mode, stbc;
 
+	txs = le32_to_cpu(txs_data[0]);
+
 	mt76_tx_status_lock(mdev, &list);
 	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
-	if (!skb)
-		goto out_no_skb;
 
-	txs = le32_to_cpu(txs_data[0]);
+	if (skb) {
+		info = IEEE80211_SKB_CB(skb);
+		if (!(txs & MT_TXS0_ACK_ERROR_MASK))
+			info->flags |= IEEE80211_TX_STAT_ACK;
 
-	info = IEEE80211_SKB_CB(skb);
-	if (!(txs & MT_TXS0_ACK_ERROR_MASK))
-		info->flags |= IEEE80211_TX_STAT_ACK;
+		info->status.ampdu_len = 1;
+		info->status.ampdu_ack_len =
+			!!(info->flags & IEEE80211_TX_STAT_ACK);
 
-	info->status.ampdu_len = 1;
-	info->status.ampdu_ack_len = !!(info->flags &
-					IEEE80211_TX_STAT_ACK);
+		info->status.rates[0].idx = -1;
+	}
 
-	info->status.rates[0].idx = -1;
+	if (mtk_wed_device_active(&dev->mt76.mmio.wed) && wcid->sta) {
+		struct ieee80211_sta *sta;
+		u8 tid;
+
+		sta = container_of((void *)wcid, struct ieee80211_sta, drv_priv);
+		tid = FIELD_GET(MT_TXS0_TID, txs);
+		ieee80211_refresh_tx_agg_session_timer(sta, tid);
+	}
 
 	txrate = FIELD_GET(MT_TXS0_TX_RATE, txs);
 
@@ -1293,9 +1302,8 @@ mt7996_mac_add_txs_skb(struct mt7996_dev *dev, struct mt76_wcid *wcid,
 	wcid->rate = rate;
 
 out:
-	mt76_tx_status_skb_done(mdev, skb, &list);
-
-out_no_skb:
+	if (skb)
+		mt76_tx_status_skb_done(mdev, skb, &list);
 	mt76_tx_status_unlock(mdev, &list);
 
 	return !!skb;
@@ -1309,13 +1317,10 @@ static void mt7996_mac_add_txs(struct mt7996_dev *dev, void *data)
 	u16 wcidx;
 	u8 pid;
 
-	if (le32_get_bits(txs_data[0], MT_TXS0_TXS_FORMAT) > 1)
-		return;
-
-	wcidx = le32_get_bits(txs_data[2], MT_TXS2_WCID);
+	wcidx = le32_get_bits(txs_data[2], MT_TXS2_MLD_ID);
 	pid = le32_get_bits(txs_data[3], MT_TXS3_PID);
 
-	if (pid < MT_PACKET_ID_FIRST)
+	if (pid < MT_PACKET_ID_WED)
 		return;
 
 	if (wcidx >= mt7996_wtbl_size(dev))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index 57022906216c..0086a7866657 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -243,6 +243,13 @@ enum base_rev {
 						 FIELD_PREP(MT_WTBL_LMAC_ID, _id) | \
 						 FIELD_PREP(MT_WTBL_LMAC_DW, _dw))
 
+/* AGG: band 0(0x820e2000), band 1(0x820f2000), band 2(0x830e2000) */
+#define MT_WF_AGG_BASE(_band)			__BASE(WF_AGG_BASE, (_band))
+#define MT_WF_AGG(_band, ofs)			(MT_WF_AGG_BASE(_band) + (ofs))
+
+#define MT_AGG_ACR4(_band)			MT_WF_AGG(_band, 0x3c)
+#define MT_AGG_ACR_PPDU_TXS2H			BIT(1)
+
 /* ARB: band 0(0x820e3000), band 1(0x820f3000), band 2(0x830e3000) */
 #define MT_WF_ARB_BASE(_band)			__BASE(WF_ARB_BASE, (_band))
 #define MT_WF_ARB(_band, ofs)			(MT_WF_ARB_BASE(_band) + (ofs))
-- 
2.39.0


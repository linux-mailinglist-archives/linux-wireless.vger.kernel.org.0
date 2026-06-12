Return-Path: <linux-wireless+bounces-37715-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aNbqOCu8K2oEEAQAu9opvQ
	(envelope-from <linux-wireless+bounces-37715-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 09:58:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 548816778DC
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 09:58:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=k8ieDteC;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37715-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37715-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D41F331CADC7
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 07:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56963DD86A;
	Fri, 12 Jun 2026 07:53:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C52F175A7D
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 07:53:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250828; cv=none; b=mo0d27qv0g36a1XiT2fedg91htAwVFuaHkI+n/dY2MYR9AjtK0tjs4jK5B0NBWcYoNAhDMS38T1IIRF391lLTdoftoUgJs5XsHtmC2IfLdqQC+OzUkQcdN9rcoeG+a6CIETfpGVkhIxhe2Xa+0AmTPiRMUZry9yrK7KcX7kwL4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250828; c=relaxed/simple;
	bh=WIia+7u2ZQkMJtL6QpwlZtJRE4k2+r7Ss6Z2WSE5H7c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zm3Kp8YtXzhl8VrE57zHqLI92lz0tzdosYxFAiC5f9M4VwWhZT04tWZI7C9i3e1en+oKHpAtre1LYczaHzF6YvSIWg7MkG4g1bAf6G0RWFuMRA1qqwqXSCJhefdIRRsRuDypSWxyDbs8UDv9aLa+AsRP/G+7Kofd9H5jMv/lqcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=k8ieDteC; arc=none smtp.client-ip=210.61.82.184
X-UUID: d4331858663311f18dc8c9802ae25ab1-20260612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Zu5+lgG1lSQDeEGMLIemVp/Tnwajv9NSNAL97fAz68k=;
	b=k8ieDteCvyTvDPT0t+MfZC+CWDzz8YNXDAXekutRB7JsFWrLww1XBPeS+LqSabM6VpsAnPRkyZH4CXFP6ec5mcbGRf9di/IwNQ5QUD1r4BDagZE30UWgtgopWcgj9wCe+Wn6rrm8XnqHTPSupi1xKQPq9lHFSI5gMkCJfH6A4B8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:955996c3-3c0c-43b6-bb5a-9e3114891dbb,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e276073,CLOUDID:7fba9d7c-6afb-429f-b343-75c21528ad77,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|136|836|865|888|898,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d4331858663311f18dc8c9802ae25ab1-20260612
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1316601216; Fri, 12 Jun 2026 15:53:41 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Jun 2026 15:53:40 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 12 Jun 2026 15:53:40 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Deren.Wu@mediatek.com>, <Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>,
	<Ryder.Lee@mediatek.com>, <Leon.Yen@mediatek.com>,
	<litien.chang@mediatek.com>, <emery.hsin@mediatek.com>,
	<jb.tsai@mediatek.com>, Xiong <xiong.huang@mediatek.com>
Subject: [PATCH 16/20] wifi: mt76: mt7925: add MT7928 TXD/TXS/TX_DONE support
Date: Fri, 12 Jun 2026 15:53:35 +0800
Message-ID: <20260612075339.2578327-1-jb.tsai@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-37715-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:Deren.Wu@mediatek.com,m:Sean.Wang@mediatek.com,m:Quan.Zhou@mediatek.com,m:Ryder.Lee@mediatek.com,m:Leon.Yen@mediatek.com,m:litien.chang@mediatek.com,m:emery.hsin@mediatek.com,m:jb.tsai@mediatek.com,m:xiong.huang@mediatek.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[mediatek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 548816778DC

From: Emery Hsin <emery.hsin@mediatek.com>

Add MT7928 TXD v2 fields, per-chip WTBL register addresses, UNI
TxDone event parsing, and TXS format acceptance for MPDU/PPDU.
Suppress HW AMSDU on management frames for MT7928.

Signed-off-by: Xiong <xiong.huang@mediatek.com>
Signed-off-by: Emery Hsin <emery.hsin@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |   1 +
 .../wireless/mediatek/mt76/mt76_connac3_mac.h |  42 ++++
 .../net/wireless/mediatek/mt76/mt7925/mac.c   | 219 +++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7925/mac.h   |   9 +-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  25 ++
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |   1 +
 .../net/wireless/mediatek/mt76/mt7925/regs.h  |   6 +
 7 files changed, 291 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index e21c393bb26d..f99a512145c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -300,6 +300,7 @@ static inline bool is_mt76_fw_txp(struct mt76_dev *dev)
 	case 0x7902:
 	case 0x7925:
 	case 0x7927:
+	case 0x7928:
 	case 0x7663:
 	case 0x7622:
 		return false;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
index 247e2e7a47d8..d2d63767bfd0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
@@ -18,6 +18,11 @@ enum {
 	MT_LMAC_PSMP0,
 };
 
+enum {
+	TXS_FM_MPDU = 0,
+	TXS_FM_PPDU = 2,
+};
+
 #define MT_CT_PARSE_LEN			72
 #define MT_CT_DMA_BUF_NUM		2
 
@@ -236,7 +241,9 @@ enum tx_frag_idx {
 #define MT_TXD2_HDR_PAD			GENMASK(11, 10)
 #define MT_TXD2_RTS			BIT(9)
 #define MT_TXD2_OWN_MAC_MAP		BIT(8)
+#define MT_TXD2_OWN_MAC_MAP_V2		BIT(9)
 #define MT_TXD2_BF_TYPE			GENMASK(6, 7)
+#define MT_TXD2_BF_TYPE_V2		GENMASK(6, 8)
 #define MT_TXD2_FRAME_TYPE		GENMASK(5, 4)
 #define MT_TXD2_SUB_TYPE		GENMASK(3, 0)
 
@@ -261,6 +268,7 @@ enum tx_frag_idx {
 #define MT_TXD5_BYPASS_TBB		BIT(14)
 #define MT_TXD5_BYPASS_RBB		BIT(13)
 #define MT_TXD5_BSS_COLOR_ZERO		BIT(12)
+#define MT_TXD5_OCUP_BY_OTHER_LNK	BIT(11)
 #define MT_TXD5_TX_STATUS_HOST		BIT(10)
 #define MT_TXD5_TX_STATUS_MCU		BIT(9)
 #define MT_TXD5_TX_STATUS_FMT		BIT(8)
@@ -270,15 +278,19 @@ enum tx_frag_idx {
 #define MT_TXD6_VTA			BIT(28)
 #define MT_TXD6_FIXED_BW		BIT(25)
 #define MT_TXD6_BW			GENMASK(24, 22)
+#define MT_TXD6_BW_V2			GENMASK(25, 22)
 #define MT_TXD6_TX_RATE			GENMASK(21, 16)
 #define MT_TXD6_TIMESTAMP_OFS_EN	BIT(15)
+#define MT_TXD6_TIMESTAMP_OFS_EN_V2	GENMASK(15, 13)
 #define MT_TXD6_TIMESTAMP_OFS_IDX	GENMASK(14, 10)
+#define MT_TXD6_TIMESTAMP_OFS_IDX_V2	GENMASK(12, 8)
 #define MT_TXD6_TID_ADDBA		GENMASK(10, 8)
 #define MT_TXD6_MSDU_CNT		GENMASK(9, 4)
 #define MT_TXD6_MSDU_CNT_V2		GENMASK(15, 10)
 #define MT_TXD6_DIS_MAT			BIT(3)
 #define MT_TXD6_DAS			BIT(2)
 #define MT_TXD6_AMSDU_CAP		BIT(1)
+#define MT_TXD6_MLD			BIT(0)
 
 #define MT_TXD7_TXD_LEN			GENMASK(31, 30)
 #define MT_TXD7_IP_SUM			BIT(29)
@@ -287,6 +299,9 @@ enum tx_frag_idx {
 #define MT_TXD7_CTXD			BIT(26)
 #define MT_TXD7_CTXD_CNT		GENMASK(25, 22)
 #define MT_TXD7_UDP_TCP_SUM		BIT(15)
+#define MT_TXD7_IMMEDIATE_TX		BIT(14)
+#define MT_TXD7_FORCE_RTS_CTS		BIT(13)
+#define MT_TXD7_ENABLE_ICI		BIT(12)
 #define MT_TXD7_TX_TIME			GENMASK(9, 0)
 
 #define MT_TXD9_WLAN_IDX		GENMASK(23, 8)
@@ -397,4 +412,31 @@ enum tx_frag_idx {
 #define MT_TXS7_MPDU_RETRY_BYTE_SCALE	BIT(15)
 #define MT_TXS7_MPDU_RETRY_BYTE		GENMASK(14, 0)
 
+struct mt7928_uni_txdone_event {
+	__le16  tag;
+	__le16  len;
+
+	u8      pid;            /* HW packet ID */
+	u8      status;         /* TX_RESULT_xx */
+	__le16  seq;            /* packet sequence number */
+
+	u8      wcid;           /* WLAN index (WTBL) */
+	u8      tx_count;       /* TX attempts including retries */
+	__le16  tx_rate;
+
+	u8      flag;           /* TXS_WITH_ADVANCED_INFO or TXS_IS_EXIST */
+	u8      tid;
+	u8      rsp_rate;
+	u8      rate_tbl_idx;   /* last TX rate index from WLAN table */
+
+	u8      bw;             /* bandwidth used for this PPDU */
+	u8      tx_pwr;         /* dBm */
+	u8      flush_reason;
+	u8      rsv[1];
+
+	__le32  tx_delay;       /* unit: 32us, UMAC TX to TX status */
+	__le32  timestamp;      /* local TSF at first bit of MAC header */
+	__le32  applied_flags;
+} __packed;
+
 #endif /* __MT76_CONNAC3_MAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 44d5a1e7e415..b7038bfa12c3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -12,10 +12,17 @@
 
 bool mt7925_mac_wtbl_update(struct mt792x_dev *dev, int idx, u32 mask)
 {
-	mt76_rmw(dev, MT7925_WTBL_UPDATE, MT_WTBL_UPDATE_WLAN_IDX,
+	u32 wtbl_update;
+
+	if (is_mt7928(&dev->mt76))
+		wtbl_update = MT7928_WTBL_UPDATE;
+	else
+		wtbl_update = MT7925_WTBL_UPDATE;
+
+	mt76_rmw(dev, wtbl_update, MT_WTBL_UPDATE_WLAN_IDX,
 		 FIELD_PREP(MT_WTBL_UPDATE_WLAN_IDX, idx) | mask);
 
-	return mt76_poll(dev, MT7925_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY,
+	return mt76_poll(dev, wtbl_update, MT_WTBL_UPDATE_BUSY,
 			 0, 5000);
 }
 
@@ -159,10 +166,17 @@ void mt7925_mac_set_fixed_rate_table(struct mt792x_dev *dev,
 {
 	u32 ctrl = MT_WTBL_ITCR_WR | MT_WTBL_ITCR_EXEC | tbl_idx;
 
-	mt76_wr(dev, MT_WTBL_ITDR0, rate_idx);
-	/* use wtbl spe idx */
-	mt76_wr(dev, MT_WTBL_ITDR1, MT_WTBL_SPE_IDX_SEL);
-	mt76_wr(dev, MT_WTBL_ITCR, ctrl);
+	if (is_mt7928(&dev->mt76)) {
+		mt76_wr(dev, MT7928_WTBL_ITDR0, rate_idx);
+		/* use wtbl spe idx */
+		mt76_wr(dev, MT7928_WTBL_ITDR1, MT_WTBL_SPE_IDX_SEL);
+		mt76_wr(dev, MT7928_WTBL_ITCR, ctrl);
+	} else {
+		mt76_wr(dev, MT_WTBL_ITDR0, rate_idx);
+		/* use wtbl spe idx */
+		mt76_wr(dev, MT_WTBL_ITDR1, MT_WTBL_SPE_IDX_SEL);
+		mt76_wr(dev, MT_WTBL_ITCR, ctrl);
+	}
 }
 
 /* The HW does not translate the mac header to 802.3 for mesh point */
@@ -705,6 +719,9 @@ mt7925_mac_write_txwi_80211(struct mt76_dev *dev, __le32 *txwi,
 
 	txwi[2] |= cpu_to_le32(val);
 
+	if (is_mt7928(dev) && ieee80211_is_mgmt(hdr->frame_control))
+		txwi[3] &= ~cpu_to_le32(MT_TXD3_HW_AMSDU);
+
 	txwi[3] |= cpu_to_le32(FIELD_PREP(MT_TXD3_BCM, multicast));
 	if (ieee80211_is_beacon(fc))
 		txwi[3] |= cpu_to_le32(MT_TXD3_REM_TX_COUNT);
@@ -808,7 +825,11 @@ mt7925_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 
 	txwi[5] = cpu_to_le32(val);
 
-	val = MT_TXD6_DAS | FIELD_PREP(MT_TXD6_MSDU_CNT, 1);
+	if (is_mt7928(dev))
+		val = MT_TXD6_DAS | FIELD_PREP(MT_TXD6_MSDU_CNT_V2, 1);
+	else
+		val = MT_TXD6_DAS | FIELD_PREP(MT_TXD6_MSDU_CNT, 1);
+
 	if (vif && (!ieee80211_vif_is_mld(vif) ||
 	    (q_idx >= MT_LMAC_ALTX0 && q_idx <= MT_LMAC_BCN0)))
 		val |= MT_TXD6_DIS_MAT;
@@ -836,6 +857,10 @@ mt7925_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 		}
 
 		txwi[6] |= cpu_to_le32(FIELD_PREP(MT_TXD6_TX_RATE, idx));
+
+		if (is_mt7928(dev))
+			txwi[6] |= cpu_to_le32(FIELD_PREP(MT_TXD6_BW_V2, 8));
+
 		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
 	}
 }
@@ -916,7 +941,6 @@ mt7925_mac_add_txs_skb(struct mt792x_dev *dev, struct mt76_wcid *wcid,
 		goto out_no_skb;
 
 	txs = le32_to_cpu(txs_data[0]);
-
 	info = IEEE80211_SKB_CB(skb);
 	if (!(txs & MT_TXS0_ACK_ERROR_MASK))
 		info->flags |= IEEE80211_TX_STAT_ACK;
@@ -1033,15 +1057,188 @@ mt7925_mac_add_txs_skb(struct mt792x_dev *dev, struct mt76_wcid *wcid,
 	return !!skb;
 }
 
-void mt7925_mac_add_txs(struct mt792x_dev *dev, void *data)
+static bool
+mt7928_mac_add_txs_skb_msg(struct mt792x_dev *dev, struct mt76_wcid *wcid,
+			   int pid, struct mt7928_uni_txdone_event *pevt)
 {
+	struct mt76_sta_stats *stats = &wcid->stats;
+	struct ieee80211_supported_band *sband;
+	struct mt76_dev *mdev = &dev->mt76;
+	struct ieee80211_tx_info *info;
+	struct sk_buff_head list;
+	u32 txrate, mode, stbc;
+	struct rate_info rate;
+	struct mt76_phy *mphy;
+	struct sk_buff *skb;
+	bool cck = false;
+
+	mt76_tx_status_lock(mdev, &list);
+	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
+	if (!skb)
+		goto out_no_skb;
+
+	info = IEEE80211_SKB_CB(skb);
+	if (!pevt->status)
+		info->flags |= IEEE80211_TX_STAT_ACK;
+
+	info->status.ampdu_len = 1;
+	info->status.ampdu_ack_len = !!(info->flags &
+					IEEE80211_TX_STAT_ACK);
+
+	info->status.rates[0].idx = -1;
+
+	txrate = pevt->tx_rate;
+
+	rate.mcs = FIELD_GET(MT_TX_RATE_IDX, txrate);
+	rate.nss = FIELD_GET(MT_TX_RATE_NSS, txrate) + 1;
+	stbc = FIELD_GET(MT_TX_RATE_STBC, txrate);
+
+	if (stbc && rate.nss > 1)
+		rate.nss >>= 1;
+
+	if (rate.nss - 1 < ARRAY_SIZE(stats->tx_nss))
+		stats->tx_nss[rate.nss - 1]++;
+	if (rate.mcs < ARRAY_SIZE(stats->tx_mcs))
+		stats->tx_mcs[rate.mcs]++;
+
+	mode = FIELD_GET(MT_TX_RATE_MODE, txrate);
+	switch (mode) {
+	case MT_PHY_TYPE_CCK:
+		cck = true;
+		fallthrough;
+	case MT_PHY_TYPE_OFDM:
+		mphy = mt76_dev_phy(mdev, wcid->phy_idx);
+
+		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
+			sband = &mphy->sband_5g.sband;
+		else if (mphy->chandef.chan->band == NL80211_BAND_6GHZ)
+			sband = &mphy->sband_6g.sband;
+		else
+			sband = &mphy->sband_2g.sband;
+
+		rate.mcs = mt76_get_rate(mphy->dev, sband, rate.mcs, cck);
+		rate.legacy = sband->bitrates[rate.mcs].bitrate;
+		break;
+	case MT_PHY_TYPE_HT:
+	case MT_PHY_TYPE_HT_GF:
+		if (rate.mcs > 31)
+			goto out;
+
+		rate.flags = RATE_INFO_FLAGS_MCS;
+		if (wcid->rate.flags & RATE_INFO_FLAGS_SHORT_GI)
+			rate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case MT_PHY_TYPE_VHT:
+		if (rate.mcs > 9)
+			goto out;
+
+		rate.flags = RATE_INFO_FLAGS_VHT_MCS;
+		break;
+	case MT_PHY_TYPE_HE_SU:
+	case MT_PHY_TYPE_HE_EXT_SU:
+	case MT_PHY_TYPE_HE_TB:
+	case MT_PHY_TYPE_HE_MU:
+		if (rate.mcs > 11)
+			goto out;
+
+		rate.he_gi = wcid->rate.he_gi;
+		rate.he_dcm = FIELD_GET(MT_TX_RATE_DCM, txrate);
+		rate.flags = RATE_INFO_FLAGS_HE_MCS;
+		break;
+	case MT_PHY_TYPE_EHT_SU:
+	case MT_PHY_TYPE_EHT_TRIG:
+	case MT_PHY_TYPE_EHT_MU:
+		if (rate.mcs > 13)
+			goto out;
+
+		rate.eht_gi = wcid->rate.eht_gi;
+		rate.flags = RATE_INFO_FLAGS_EHT_MCS;
+		break;
+	default:
+		goto out;
+	}
+
+	stats->tx_mode[mode]++;
+
+	switch (pevt->bw) {
+	case IEEE80211_STA_RX_BW_160:
+		rate.bw = RATE_INFO_BW_160;
+		stats->tx_bw[3]++;
+		break;
+	case IEEE80211_STA_RX_BW_80:
+		rate.bw = RATE_INFO_BW_80;
+		stats->tx_bw[2]++;
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		rate.bw = RATE_INFO_BW_40;
+		stats->tx_bw[1]++;
+		break;
+	default:
+		rate.bw = RATE_INFO_BW_20;
+		stats->tx_bw[0]++;
+		break;
+	}
+	wcid->rate = rate;
+
+out:
+	mt76_tx_status_skb_done(mdev, skb, &list);
+
+out_no_skb:
+	mt76_tx_status_unlock(mdev, &list);
+
+	return !!skb;
+}
+
+void mt7928_mac_add_txs_msg(struct mt792x_dev *dev,
+			    void *evt)
+{
+	struct mt7928_uni_txdone_event *done_evt;
 	struct mt792x_link_sta *mlink = NULL;
 	struct mt76_wcid *wcid;
-	__le32 *txs_data = data;
 	u16 wcidx;
 	u8 pid;
 
-	if (le32_get_bits(txs_data[0], MT_TXS0_TXS_FORMAT) > 1)
+	done_evt = (struct mt7928_uni_txdone_event *)evt;
+	wcidx = done_evt->wcid;
+	pid = done_evt->pid;
+
+	if (pid < MT_PACKET_ID_FIRST)
+		return;
+
+	if (wcidx >= MT792x_WTBL_SIZE)
+		return;
+
+	rcu_read_lock();
+
+	wcid = mt76_wcid_ptr(dev, wcidx);
+	if (!wcid)
+		goto out;
+
+	mlink = container_of(wcid, struct mt792x_link_sta, wcid);
+
+	mt7928_mac_add_txs_skb_msg(dev, wcid, pid, done_evt);
+	if (!wcid->sta)
+		goto out;
+
+	mt76_wcid_add_poll(&dev->mt76, &mlink->wcid);
+
+out:
+	rcu_read_unlock();
+}
+
+void mt7925_mac_add_txs(struct mt792x_dev *dev, void *data)
+{
+	struct mt792x_link_sta *mlink = NULL;
+	__le32 *txs_data = data;
+	struct mt76_wcid *wcid;
+	u8 pid, txs_fm;
+	u16 wcidx;
+
+	txs_fm = le32_get_bits(txs_data[0], MT_TXS0_TXS_FORMAT);
+
+	if (is_mt7928(&dev->mt76) && txs_fm != TXS_FM_MPDU && txs_fm != TXS_FM_PPDU)
+		return;
+	else if (txs_fm > 1)
 		return;
 
 	wcidx = le32_get_bits(txs_data[2], MT_TXS2_WCID);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.h b/drivers/net/wireless/mediatek/mt76/mt7925/mac.h
index 67148c87de76..567d072cba02 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.h
@@ -14,7 +14,14 @@
 
 static inline u32 mt7925_mac_wtbl_lmac_addr(struct mt792x_dev *dev, u16 wcid, u8 dw)
 {
-	mt76_wr(dev, MT7925_WTBLON_TOP_WDUCR,
+	u32 wdu_cr;
+
+	if (is_mt7928(&dev->mt76))
+		wdu_cr = MT7928_WTBLON_TOP_WDUCR;
+	else
+		wdu_cr = MT7925_WTBLON_TOP_WDUCR;
+
+	mt76_wr(dev, wdu_cr,
 		FIELD_PREP(MT_WTBLON_TOP_WDUCR_GROUP, (wcid >> 7)));
 
 	return MT_WTBL_LMAC_OFFS(wcid, dw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 0b4ca5cf5734..ffe687afcf6e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -446,6 +446,31 @@ mt7925_mcu_tx_done_event(struct mt792x_dev *dev, struct sk_buff *skb)
 
 	while (tlv_len > 0 && le16_to_cpu(tlv->len) <= tlv_len) {
 		switch (le16_to_cpu(tlv->tag)) {
+		case UNI_EVENT_TX_DONE_MSG:
+			struct mt7928_uni_txdone_event *evt;
+
+			if (!is_mt7928(&dev->mt76))
+				break;
+
+			evt = (struct mt7928_uni_txdone_event *)tlv;
+			if (evt->status) {
+				dev_info(dev->mt76.dev,
+					 "TxDone: pid=%u status=%#x sn=%#x wcid=%u "
+					 "cnt=%u rate=%#x flag=%#x tid=%u pwr=%u "
+					 "rsp_rate=%#x rate_idx=%u bw=%u flush=%#x "
+					 "delay=%#x ts=%#x flags=%#x\n",
+					 evt->pid, evt->status,
+					 le16_to_cpu(evt->seq), evt->wcid,
+					 evt->tx_count, le16_to_cpu(evt->tx_rate),
+					 evt->flag, evt->tid, evt->tx_pwr,
+					 evt->rsp_rate, evt->rate_tbl_idx,
+					 evt->bw, evt->flush_reason,
+					 le32_to_cpu(evt->tx_delay),
+					 le32_to_cpu(evt->timestamp),
+					 le32_to_cpu(evt->applied_flags));
+			}
+			mt7928_mac_add_txs_msg(dev, evt);
+			break;
 		case UNI_EVENT_TX_DONE_RAW:
 			txs = (struct mt7925_mcu_txs_event *)tlv->data;
 			mt7925_mac_add_txs(dev, txs->data);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index a5414fa2736f..321e732347f2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -354,6 +354,7 @@ int mt7925_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 int mt7925e_mac_reset(struct mt792x_dev *dev);
 int mt7925e_mcu_init(struct mt792x_dev *dev);
 void mt7925_mac_add_txs(struct mt792x_dev *dev, void *data);
+void mt7928_mac_add_txs_msg(struct mt792x_dev *dev, void *evt);
 void mt7925_set_runtime_pm(struct mt792x_dev *dev);
 void mt7925_mcu_set_suspend_iter(void *priv, u8 *mac,
 				 struct ieee80211_vif *vif);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
index 253ba72310ec..af6291fc53cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regs.h
@@ -97,12 +97,18 @@
 #define MT_WFSYS_SW_RST_B		0x7c000140
 
 #define MT7925_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(0x370)
+#define MT7928_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(0x400)
 #define MT_WTBLON_TOP_WDUCR_GROUP	GENMASK(4, 0)
 
 #define MT7925_WTBL_UPDATE		MT_WTBLON_TOP(0x380)
+#define MT7928_WTBL_UPDATE		MT_WTBLON_TOP(0x410)
 #define MT_WTBL_UPDATE_WLAN_IDX		GENMASK(11, 0)
 #define MT_WTBL_UPDATE_ADM_COUNT_CLEAR	BIT(14)
 
+#define MT7928_WTBL_ITCR		MT_WTBLON_TOP(0x440)
+#define MT7928_WTBL_ITDR0		MT_WTBLON_TOP(0x448)
+#define MT7928_WTBL_ITDR1		MT_WTBLON_TOP(0x44c)
+
 #define MT7925_PCIE_MAC_BASE		0x10000
 #define MT7925_PCIE_MAC(ofs)		(MT7925_PCIE_MAC_BASE + (ofs))
 #define MT7925_PCIE_MAC_INT_ENABLE	MT7925_PCIE_MAC(0x188)
-- 
2.45.2



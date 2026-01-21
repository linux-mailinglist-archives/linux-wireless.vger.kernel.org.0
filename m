Return-Path: <linux-wireless+bounces-31047-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LsEFrkmcWmqewAAu9opvQ
	(envelope-from <linux-wireless+bounces-31047-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 20:19:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF325BFEF
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 20:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AE888655FB
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 17:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D352367DC;
	Wed, 21 Jan 2026 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PUo7N1ix"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0721A256B
	for <linux-wireless@vger.kernel.org>; Wed, 21 Jan 2026 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769017341; cv=none; b=UjUaZgchJYa7WWxC5uUEkjo/4inc+bq9VsuQiIeqm6rHFthMGbLWDKbO74M1i8YLfczuBOsmu1U8ZE/OshCjuakXDRNnxG69jFx1RElTKCElwRLBABTvMgaJD4r/HWCASAJmzTRdfe6dRse5n/4pTFnaJ1bFYFAGXhZUU3Fol7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769017341; c=relaxed/simple;
	bh=UJjmcT76pFWCuGDzwFIvSijRrUqlsqXotM7fdJef1Jo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i53ZHB4aymu4DhBpuZ4bhJ8Kq0n7UWSIh3JdyhG+G0QEjO/qBTwFbijTgC5Z3AwtoHIRWFRObGSnvw4ELXzYrAzIxUX655AmwX8RxqmxyEL3SqFJyoQAZ+GCKO63iBhuOfZEx5UfnJA6QRFQt9OZgL5/5fH8632WErhX3diqAiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PUo7N1ix; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 83738a0ef6f011f085319dbc3099e8fb-20260122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OcbxGcY//RjmScQmafj01a9J13mGhcggikZW07HIDow=;
	b=PUo7N1ixvJ1tg+d/jEPys1T2erpNZmzmBFBT9tedRhzV7Y0iXEgV76wNZ6JxykJ2/4E5I+VyHqd4S/xJqRc3oOqG5yz2sKxBQWUvjZMcYbdGlEiqr44t4YVPWFBvPZHqdDjU5ZfsXCRciSFRCsyMiRzGg3Zp6lKJYt4JuvKA+fk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:d728625e-e40e-4d48-b602-723eea98d2d0,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:89c9d04,CLOUDID:186ec7e8-ef90-4382-9c6f-55f2a0689a6b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 83738a0ef6f011f085319dbc3099e8fb-20260122
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1418165199; Thu, 22 Jan 2026 01:42:10 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 22 Jan 2026 01:42:09 +0800
Received: from mussdccf250.eus.mediatek.inc (10.73.250.250) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 22 Jan 2026 01:42:08 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/3] wifi: mt76: mt7915: fix use_cts_prot support
Date: Wed, 21 Jan 2026 09:41:57 -0800
Message-ID: <eb8db4d0bf1c89b7486e89facb788ae3e510dd8b.1768879119.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <edb87088b0111b32fafc6c4179f54a5286dd37d8.1768879119.git.ryder.lee@mediatek.com>
References: <edb87088b0111b32fafc6c4179f54a5286dd37d8.1768879119.git.ryder.lee@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31047-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ryder.lee@mediatek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[mediatek.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DMARC_POLICY_ALLOW(0.00)[mediatek.com,quarantine];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1BF325BFEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With this fix, when driver needs to adjust its behavior for compatibility,
especially concerning older 11g/n devices, by enabling or disabling CTS
protection frames, often for hidden SSIDs or to manage legacy clients.

Fixes: 150b91419d3d ("wifi: mt76: mt7915: enable use_cts_prot support")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 13 ----
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  7 ++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 62 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 11 ++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 ++
 5 files changed, 81 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index cefe56c05..cec2c4208 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -232,19 +232,6 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 	rcu_read_unlock();
 }
 
-void mt7915_mac_enable_rtscts(struct mt7915_dev *dev,
-			      struct ieee80211_vif *vif, bool enable)
-{
-	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	u32 addr;
-
-	addr = mt7915_mac_wtbl_lmac_addr(dev, mvif->sta.wcid.idx, 5);
-	if (enable)
-		mt76_set(dev, addr, BIT(5));
-	else
-		mt76_clear(dev, addr, BIT(5));
-}
-
 static void
 mt7915_wed_check_ppe(struct mt7915_dev *dev, struct mt76_queue *q,
 		     struct mt7915_sta *msta, struct sk_buff *skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 90d5e79fb..089229161 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -68,7 +68,7 @@ int mt7915_run(struct ieee80211_hw *hw)
 	if (ret)
 		goto out;
 
-	ret = mt76_connac_mcu_set_rts_thresh(&dev->mt76, 0x92b,
+	ret = mt76_connac_mcu_set_rts_thresh(&dev->mt76, MT7915_RTS_LEN_THRES,
 					     phy->mt76->band_idx);
 	if (ret)
 		goto out;
@@ -633,8 +633,9 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 	if (set_sta == 1)
 		mt7915_mcu_add_sta(dev, vif, NULL, CONN_STATE_PORT_SECURE, false);
 
-	if (changed & BSS_CHANGED_ERP_CTS_PROT)
-		mt7915_mac_enable_rtscts(dev, vif, info->use_cts_prot);
+	if (changed & BSS_CHANGED_HT || changed & BSS_CHANGED_ERP_CTS_PROT)
+		mt7915_mcu_set_protection(phy, vif, info->ht_operation_mode,
+					  info->use_cts_prot);
 
 	if (changed & BSS_CHANGED_ERP_SLOT) {
 		int slottime = 9;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 00bff4d3a..95b8f34a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3954,6 +3954,68 @@ int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 	return ret;
 }
 
+int mt7915_mcu_set_protection(struct mt7915_phy *phy, struct ieee80211_vif *vif,
+			      u8 ht_mode, bool use_cts_prot)
+{
+	struct mt7915_dev *dev = phy->dev;
+	int len = sizeof(struct sta_req_hdr) + sizeof(struct bss_info_prot);
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct bss_info_prot *prot;
+	struct sk_buff *skb;
+	struct tlv *tlv;
+	enum {
+		PROT_NONMEMBER	 = BIT(1),
+		PROT_20MHZ	 = BIT(2),
+		PROT_NONHT_MIXED = BIT(3),
+		PROT_LEGACY_ERP	 = BIT(5),
+		PROT_NONGF_STA	 = BIT(7),
+	};
+	u32 rts_threshold;
+
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+					      NULL, len);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_PROTECT_INFO,
+				      sizeof(*prot));
+	prot = (struct bss_info_prot *)tlv;
+
+	switch (ht_mode & IEEE80211_HT_OP_MODE_PROTECTION) {
+	case IEEE80211_HT_OP_MODE_PROTECTION_NONMEMBER:
+		prot->prot_mode = cpu_to_le32(PROT_NONMEMBER);
+		break;
+	case IEEE80211_HT_OP_MODE_PROTECTION_20MHZ:
+		prot->prot_mode = cpu_to_le32(PROT_20MHZ);
+		break;
+	case IEEE80211_HT_OP_MODE_PROTECTION_NONHT_MIXED:
+		prot->prot_mode = cpu_to_le32(PROT_NONHT_MIXED);
+		break;
+	}
+
+	if (ht_mode & IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT)
+		prot->prot_mode |= cpu_to_le32(PROT_NONGF_STA);
+
+	if (use_cts_prot)
+		prot->prot_mode |= cpu_to_le32(PROT_LEGACY_ERP);
+
+	/* reuse current RTS setting */
+	rts_threshold = phy->mt76->hw->wiphy->rts_threshold;
+	if (rts_threshold == (u32)-1)
+		prot->rts_len_thres = cpu_to_le32(MT7915_RTS_LEN_THRES);
+	else
+		prot->rts_len_thres = cpu_to_le32(rts_threshold);
+
+	prot->rts_pkt_thres = 0x2;
+
+	prot->he_rts_thres = cpu_to_le16(vif->bss_conf.frame_time_rts_th);
+	if (!prot->he_rts_thres)
+		prot->he_rts_thres = cpu_to_le16(DEFAULT_HE_DURATION_RTS_THRES);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_EXT_CMD(BSS_INFO_UPDATE), true);
+}
+
 int mt7915_mcu_update_bss_color(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 				struct cfg80211_he_bss_color *he_bss_color)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 3af11a075..22f73a5ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -399,6 +399,17 @@ struct bss_info_inband_discovery {
 	__le16 prob_rsp_len;
 } __packed __aligned(4);
 
+struct bss_info_prot {
+	__le16 tag;
+	__le16 len;
+	__le32 prot_type;
+	__le32 prot_mode;
+	__le32 rts_len_thres;
+	__le16 he_rts_thres;
+	u8 rts_pkt_thres;
+	u8 rsv[5];
+} __packed;
+
 enum {
 	BSS_INFO_BCN_CSA,
 	BSS_INFO_BCN_BCC,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index b5c06201b..bf1d915a3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -84,6 +84,8 @@
 #define MT7915_CRIT_TEMP		110
 #define MT7915_MAX_TEMP			120
 
+#define MT7915_RTS_LEN_THRES		0x92b
+
 struct mt7915_vif;
 struct mt7915_sta;
 struct mt7915_dfs_pulse;
@@ -473,6 +475,8 @@ int mt7915_mcu_add_inband_discov(struct mt7915_dev *dev, struct ieee80211_vif *v
 				 u32 changed);
 int mt7915_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			  int enable, u32 changed);
+int mt7915_mcu_set_protection(struct mt7915_phy *phy, struct ieee80211_vif *vif,
+			      u8 ht_mode, bool use_cts_prot);
 int mt7915_mcu_add_obss_spr(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			    struct ieee80211_he_obss_pd *he_obss_pd);
 int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-- 
2.45.2



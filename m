Return-Path: <linux-wireless+bounces-28659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFFAC394B1
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 07:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C60E35018E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 06:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E3D2DCBE0;
	Thu,  6 Nov 2025 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="k/UIXxkw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CABE2DEA70
	for <linux-wireless@vger.kernel.org>; Thu,  6 Nov 2025 06:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762411398; cv=none; b=BSFyNcUA3CXrys0wB5NmyFN9RareXl1a9p8mZv70vbPnAeF4Srb5k8bxbTIuyTFrf+v0a5F4ZDmpqM0Tb84YmR0T2y0hDo5KDmFdDFNdGSWaPpjWcDgtHQKikiJWQ8JNuWbUJqK0pLnwMOiHAIfvOKrcDd7J1l6djtEhCRnFJIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762411398; c=relaxed/simple;
	bh=R9WTHyQMu3Og4fU995V81JKCZjGULmqtgrVQBXZbsYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dip8xGguIzGImr4pKbtYncdsh8AQlmCnHX0U27qY+TJbrPK7YD0ub8lxtn6IxKiOKp9DIKwWWuhgrIixw8ZhASCpHm22BdhTh9EXEZaUcKGOq8mu+igpSCMEpDvwGQCiA6ieUljWdNaisZTn6UkNddIYMa3KOyIYSWcUkMe4D+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=k/UIXxkw; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d782f0febadb11f0b33aeb1e7f16c2b6-20251106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6EtKvnQkpDHMvmNvDnUiDFEAi/MUDPrcgwJVc5f9/Oc=;
	b=k/UIXxkwttBDMYMck/yPclaf5INn4XIqJwFfl+FocYHlSxLRZWrArXwA4m+u50apQGgoBccmndpA18o4R7UptKhXfiWxm7UruJC1jNMe2ROBgyuILfekrNT6Coe2YAKfsz/Fg8HSvuGao0dbeTHxKflifuB3tcw2PoXZNch2/RA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:d5bb71eb-4dda-4bb1-9a4b-8b5b91b61c1b,IP:0,UR
	L:0,TC:0,Content:-25,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-45
X-CID-META: VersionHash:a9d874c,CLOUDID:8ffdfa18-3399-4579-97ab-008f994989ea,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:1,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d782f0febadb11f0b33aeb1e7f16c2b6-20251106
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 217090886; Thu, 06 Nov 2025 14:43:02 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 6 Nov 2025 14:43:00 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 6 Nov 2025 14:43:00 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Shayne Chen <shayne.chen@mediatek.com>,
	Allen Ye <allen.ye@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH mt76 v2 10/12] wifi: mt76: mt7996: fix MLO set key and group key issues
Date: Thu, 6 Nov 2025 14:42:01 +0800
Message-ID: <20251106064203.1000505-10-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251106064203.1000505-1-shayne.chen@mediatek.com>
References: <20251106064203.1000505-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

This patch fixes the following key issues:
- Pass correct link BSS to mt7996_mcu_add_key(), and use HW beacon
  protection mode for mt7990 chipset
- Do not do group key deletion for GTK and IGTK due to FW design, the
  delete key command will delete all group keys of a link BSS
- For deleting BIGTK, FW adds a new flow, but the "sec->add" field
  should be filled with "SET_KEY". Note that if BIGTK is not deleted, it
  will cause beacon decryption issue when switching from an AP interface
  to a station interface

Fixes: 0c45d52276fd ("wifi: mt76: mt7996: fix setting beacon protection keys")
Co-developed-by: Allen Ye <allen.ye@mediatek.com>
Signed-off-by: Allen Ye <allen.ye@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  7 +++-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  5 +--
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 35 +++++++++++++------
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  2 +-
 4 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 579084cbb30f..c1f2938d1f21 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -795,6 +795,7 @@ mt7996_mac_write_txwi_80211(struct mt7996_dev *dev, __le32 *txwi,
 	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
 	__le16 fc = hdr->frame_control, sc = hdr->seq_ctrl;
 	u16 seqno = le16_to_cpu(sc);
+	bool hw_bigtk = false;
 	u8 fc_type, fc_stype;
 	u32 val;
 
@@ -820,7 +821,11 @@ mt7996_mac_write_txwi_80211(struct mt7996_dev *dev, __le32 *txwi,
 	    info->flags & IEEE80211_TX_CTL_USE_MINRATE)
 		val |= MT_TXD1_FIXED_RATE;
 
-	if (key && multicast && ieee80211_is_robust_mgmt_frame(skb)) {
+	if (is_mt7990(&dev->mt76) && ieee80211_is_beacon(fc) &&
+	    (wcid->hw_key_idx2 == 6 || wcid->hw_key_idx2 == 7))
+		hw_bigtk = true;
+
+	if ((key && multicast && ieee80211_is_robust_mgmt_frame(skb)) || hw_bigtk) {
 		val |= MT_TXD1_BIP;
 		txwi[3] &= ~cpu_to_le32(MT_TXD3_PROTECT_FRAME);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 66e22f5576f8..68ce6f96348b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -249,12 +249,13 @@ mt7996_set_hw_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	else if (idx == *wcid_keyidx)
 		*wcid_keyidx = -1;
 
-	if (cmd != SET_KEY && sta)
+	/* only do remove key for BIGTK */
+	if (cmd != SET_KEY && !is_bigtk)
 		return 0;
 
 	mt76_wcid_key_setup(&dev->mt76, &msta_link->wcid, key);
 
-	err = mt7996_mcu_add_key(&dev->mt76, vif, key,
+	err = mt7996_mcu_add_key(&dev->mt76, link, key,
 				 MCU_WMWA_UNI_CMD(STA_REC_UPDATE),
 				 &msta_link->wcid, cmd);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 2bb98df317a6..14a88ef79b6c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2530,7 +2530,7 @@ int mt7996_mcu_teardown_mld_sta(struct mt7996_dev *dev,
 }
 
 static int
-mt7996_mcu_sta_key_tlv(struct mt76_wcid *wcid,
+mt7996_mcu_sta_key_tlv(struct mt76_dev *dev, struct mt76_wcid *wcid,
 		       struct sk_buff *skb,
 		       struct ieee80211_key_conf *key,
 		       enum set_key_cmd cmd)
@@ -2542,7 +2542,10 @@ mt7996_mcu_sta_key_tlv(struct mt76_wcid *wcid,
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_KEY_V2, sizeof(*sec));
 	sec = (struct sta_rec_sec_uni *)tlv;
-	sec->add = 0;
+	/* due to connac3 FW design, we only do remove key for BIGTK; even for
+	 * removal, the field should be filled with SET_KEY
+	 */
+	sec->add = SET_KEY;
 	sec->n_cipher = 1;
 	sec_key = &sec->key[0];
 	sec_key->wlan_idx = cpu_to_le16(wcid->idx);
@@ -2582,29 +2585,33 @@ mt7996_mcu_sta_key_tlv(struct mt76_wcid *wcid,
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
 		sec_key->cipher_id = MCU_CIPHER_BCN_PROT_GMAC_256;
 		break;
+	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
+		if (!is_mt7990(dev))
+			return -EOPNOTSUPP;
+		sec_key->cipher_id = MCU_CIPHER_BCN_PROT_CMAC_256;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
 
-	sec_key->bcn_mode = BP_SW_MODE;
+	sec_key->bcn_mode = is_mt7990(dev) ? BP_HW_MODE : BP_SW_MODE;
 
 	return 0;
 }
 
-int mt7996_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
+int mt7996_mcu_add_key(struct mt76_dev *dev, struct mt7996_vif_link *link,
 		       struct ieee80211_key_conf *key, int mcu_cmd,
 		       struct mt76_wcid *wcid, enum set_key_cmd cmd)
 {
-	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
 	struct sk_buff *skb;
 	int ret;
 
-	skb = __mt76_connac_mcu_alloc_sta_req(dev, mvif, wcid,
-					      MT7996_STA_UPDATE_MAX_SIZE);
+	skb = __mt76_connac_mcu_alloc_sta_req(dev, (struct mt76_vif_link *)link,
+					      wcid, MT7996_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	ret = mt7996_mcu_sta_key_tlv(wcid, skb, key, cmd);
+	ret = mt7996_mcu_sta_key_tlv(dev, wcid, skb, key, cmd);
 	if (ret) {
 		dev_kfree_skb(skb);
 		return ret;
@@ -2724,12 +2731,18 @@ mt7996_mcu_beacon_mbss(struct sk_buff *rskb, struct sk_buff *skb,
 static void
 mt7996_mcu_beacon_cont(struct mt7996_dev *dev,
 		       struct ieee80211_bss_conf *link_conf,
+		       struct mt7996_vif_link *link,
 		       struct sk_buff *rskb, struct sk_buff *skb,
 		       struct bss_bcn_content_tlv *bcn,
 		       struct ieee80211_mutable_offsets *offs)
 {
-	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
-	u8 *buf;
+	u8 *buf, keyidx = link->msta_link.wcid.hw_key_idx2;
+	struct mt76_wcid *wcid;
+
+	if (is_mt7990(&dev->mt76) && (keyidx == 6 || keyidx == 7))
+		wcid = &link->msta_link.wcid;
+	else
+		wcid = &dev->mt76.global_wcid;
 
 	bcn->pkt_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
 	bcn->tim_ie_pos = cpu_to_le16(offs->tim_offset);
@@ -2804,7 +2817,7 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	info = IEEE80211_SKB_CB(skb);
 	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, mlink->band_idx);
 
-	mt7996_mcu_beacon_cont(dev, link_conf, rskb, skb, bcn, &offs);
+	mt7996_mcu_beacon_cont(dev, link_conf, link, rskb, skb, bcn, &offs);
 	if (link_conf->bssid_indicator)
 		mt7996_mcu_beacon_mbss(rskb, skb, bcn, &offs);
 	mt7996_mcu_beacon_cntdwn(rskb, skb, &offs, link_conf->csa_active);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index c47820699ec8..7a884311800e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -849,7 +849,7 @@ void mt7996_update_channel(struct mt76_phy *mphy);
 int mt7996_init_debugfs(struct mt7996_dev *dev);
 void mt7996_debugfs_rx_fw_monitor(struct mt7996_dev *dev, const void *data, int len);
 bool mt7996_debugfs_rx_log(struct mt7996_dev *dev, const void *data, int len);
-int mt7996_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
+int mt7996_mcu_add_key(struct mt76_dev *dev, struct mt7996_vif_link *link,
 		       struct ieee80211_key_conf *key, int mcu_cmd,
 		       struct mt76_wcid *wcid, enum set_key_cmd cmd);
 int mt7996_mcu_bcn_prot_enable(struct mt7996_dev *dev,
-- 
2.51.0



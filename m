Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA7EB174D5E
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Mar 2020 13:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgCAMrQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Mar 2020 07:47:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgCAMrQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Mar 2020 07:47:16 -0500
Received: from localhost.localdomain (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A3B221775;
        Sun,  1 Mar 2020 12:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583066835;
        bh=1VFMe2cOABm7fKq5Sel9b0fnhfhhEEgWlFdnMR8810Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HV3BNH2JryM1SawPhFKfPHhhgI3Vx1Fq0zQ1hRJ/qhoHXjtlMB4ENmHdgNIaUXXTw
         NHkpisAFIpqVQFnVUT2Axxj+rxDX3CEFgpbLYgSAMC/KwUPsGmAhG5/83hJsO3sG04
         DTliLf53o0q76QAiBWPFyCdz5mWC2qiznSo2xVUA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 3/4] mt76: mt7615: use proper size for mcu msg in mt7615_mcu_set_sta
Date:   Sun,  1 Mar 2020 13:46:53 +0100
Message-Id: <d11cec7f11de493783fae7f8bf5d111b5c6d2f3d.1583066508.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1583066508.git.lorenzo@kernel.org>
References: <cover.1583066508.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use proper buffer size for mcu messages in mt7615_mcu_set_sta since
MT7615_WTBL_UPDATE_MAX_SIZE takes into account just wtbl headers while
the mcu message contains even sta related headers. This is not a real
issue at the moment since the message size is less than
MT7615_WTBL_UPDATE_MAX_SIZE but it is not formally correct.
Allocate the mcu buffer relying on kmalloc instead of the putting it
on the stack.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 118 +++++++++---------
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |   7 ++
 2 files changed, 69 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 70bf84b31772..27dd0c13e43e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1234,44 +1234,46 @@ int mt7615_mcu_set_sta(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
-
-	struct {
-		struct sta_req_hdr hdr;
-		struct sta_rec_basic basic;
-		u8 buf[MT7615_WTBL_UPDATE_MAX_SIZE];
-	} __packed req = {
-		.hdr = {
-			.bss_idx = mvif->idx,
-			.wlan_idx = msta->wcid.idx,
-			.is_tlv_append = 1,
-			.muar_idx = mvif->omac_idx,
-		},
-		.basic = {
-			.tag = cpu_to_le16(STA_REC_BASIC),
-			.len = cpu_to_le16(sizeof(struct sta_rec_basic)),
-			.qos = sta->wme,
-			.aid = cpu_to_le16(sta->aid),
-		},
-	};
+	u8 wtlv = 0, stlv = 1, *data, *buf;
 	struct sta_rec_wtbl *wtbl = NULL;
+	struct sta_rec_basic *sta_basic;
 	struct wtbl_req_hdr *wtbl_hdr;
 	struct wtbl_generic *wtbl_g;
+	struct sta_req_hdr *sta_hdr;
 	struct wtbl_rx *wtbl_rx;
-	u8 *buf = req.buf;
-	u8 wtlv = 0, stlv = 1;
+	int err, wtbl_len;
+
+	buf = kzalloc(MT7615_MCU_STA_BUF_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	data = buf;
+	sta_hdr = (struct sta_req_hdr *)data;
+	data += sizeof(*sta_hdr);
+	sta_hdr->bss_idx = mvif->idx;
+	sta_hdr->wlan_idx = msta->wcid.idx;
+	sta_hdr->is_tlv_append = 1;
+	sta_hdr->muar_idx = mvif->omac_idx;
+
+	sta_basic = (struct sta_rec_basic *)data;
+	data += sizeof(*sta_basic);
+	sta_basic->tag = cpu_to_le16(STA_REC_BASIC);
+	sta_basic->len = cpu_to_le16(sizeof(*sta_basic));
+	sta_basic->qos = sta->wme;
+	sta_basic->aid = cpu_to_le16(sta->aid);
 
-	memcpy(req.basic.peer_addr, sta->addr, ETH_ALEN);
+	memcpy(sta_basic->peer_addr, sta->addr, ETH_ALEN);
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_MESH_POINT:
-		req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_STA);
+		sta_basic->conn_type = cpu_to_le32(CONNECTION_INFRA_STA);
 		break;
 	case NL80211_IFTYPE_STATION:
-		req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_AP);
+		sta_basic->conn_type = cpu_to_le32(CONNECTION_INFRA_AP);
 		break;
 	case NL80211_IFTYPE_ADHOC:
-		req.basic.conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
+		sta_basic->conn_type = cpu_to_le32(CONNECTION_IBSS_ADHOC);
 		break;
 	default:
 		WARN_ON(1);
@@ -1279,16 +1281,15 @@ int mt7615_mcu_set_sta(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	}
 
 	if (en) {
-		req.basic.conn_state = CONN_STATE_PORT_SECURE;
-		req.basic.extra_info = cpu_to_le16(EXTRA_INFO_VER |
-						   EXTRA_INFO_NEW);
-
+		sta_basic->conn_state = CONN_STATE_PORT_SECURE;
+		sta_basic->extra_info = cpu_to_le16(EXTRA_INFO_VER |
+						    EXTRA_INFO_NEW);
 		/* sta_rec ht */
 		if (sta->ht_cap.ht_supported) {
 			struct sta_rec_ht *sta_ht;
 
-			sta_ht = (struct sta_rec_ht *)buf;
-			buf += sizeof(*sta_ht);
+			sta_ht = (struct sta_rec_ht *)data;
+			data += sizeof(*sta_ht);
 			sta_ht->tag = cpu_to_le16(STA_REC_HT);
 			sta_ht->len = cpu_to_le16(sizeof(*sta_ht));
 			sta_ht->ht_cap = cpu_to_le16(sta->ht_cap.cap);
@@ -1298,8 +1299,8 @@ int mt7615_mcu_set_sta(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			if (sta->vht_cap.vht_supported) {
 				struct sta_rec_vht *sta_vht;
 
-				sta_vht = (struct sta_rec_vht *)buf;
-				buf += sizeof(*sta_vht);
+				sta_vht = (struct sta_rec_vht *)data;
+				data += sizeof(*sta_vht);
 				sta_vht->tag = cpu_to_le16(STA_REC_VHT);
 				sta_vht->len = cpu_to_le16(sizeof(*sta_vht));
 				sta_vht->vht_cap =
@@ -1312,28 +1313,28 @@ int mt7615_mcu_set_sta(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			}
 		}
 	} else {
-		req.basic.conn_state = CONN_STATE_DISCONNECT;
-		req.basic.extra_info = cpu_to_le16(EXTRA_INFO_VER);
+		sta_basic->conn_state = CONN_STATE_DISCONNECT;
+		sta_basic->extra_info = cpu_to_le16(EXTRA_INFO_VER);
 	}
 
 	/* wtbl */
 	if (dev->fw_ver > MT7615_FIRMWARE_V1) {
-		wtbl = (struct sta_rec_wtbl *)buf;
+		wtbl = (struct sta_rec_wtbl *)data;
 		wtbl->tag = cpu_to_le16(STA_REC_WTBL);
-		buf += sizeof(*wtbl);
+		data += sizeof(*wtbl);
 		stlv++;
 	}
 
-	wtbl_hdr = (struct wtbl_req_hdr *)buf;
-	buf += sizeof(*wtbl_hdr);
+	wtbl_hdr = (struct wtbl_req_hdr *)data;
+	data += sizeof(*wtbl_hdr);
 	wtbl_hdr->wlan_idx = msta->wcid.idx;
 	wtbl_hdr->operation = WTBL_RESET_AND_SET;
 
 	if (!en)
 		goto out;
 
-	wtbl_g = (struct wtbl_generic *)buf;
-	buf += sizeof(*wtbl_g);
+	wtbl_g = (struct wtbl_generic *)data;
+	data += sizeof(*wtbl_g);
 	wtbl_g->tag = cpu_to_le16(WTBL_GENERIC);
 	wtbl_g->len = cpu_to_le16(sizeof(*wtbl_g));
 	wtbl_g->muar_idx = mvif->omac_idx;
@@ -1342,8 +1343,8 @@ int mt7615_mcu_set_sta(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	memcpy(wtbl_g->peer_addr, sta->addr, ETH_ALEN);
 	wtlv++;
 
-	wtbl_rx = (struct wtbl_rx *)buf;
-	buf += sizeof(*wtbl_rx);
+	wtbl_rx = (struct wtbl_rx *)data;
+	data += sizeof(*wtbl_rx);
 	wtbl_rx->tag = cpu_to_le16(WTBL_RX);
 	wtbl_rx->len = cpu_to_le16(sizeof(*wtbl_rx));
 	wtbl_rx->rv = 1;
@@ -1357,8 +1358,8 @@ int mt7615_mcu_set_sta(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		struct wtbl_raw *wtbl_raw;
 		u32 val = 0, msk;
 
-		wtbl_ht = (struct wtbl_ht *)buf;
-		buf += sizeof(*wtbl_ht);
+		wtbl_ht = (struct wtbl_ht *)data;
+		data += sizeof(*wtbl_ht);
 		wtbl_ht->tag = cpu_to_le16(WTBL_HT);
 		wtbl_ht->len = cpu_to_le16(sizeof(*wtbl_ht));
 		wtbl_ht->ht = 1;
@@ -1371,27 +1372,28 @@ int mt7615_mcu_set_sta(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		if (sta->vht_cap.vht_supported) {
 			struct wtbl_vht *wtbl_vht;
 
-			wtbl_vht = (struct wtbl_vht *)buf;
-			buf += sizeof(*wtbl_vht);
+			wtbl_vht = (struct wtbl_vht *)data;
+			data += sizeof(*wtbl_vht);
 			wtbl_vht->tag = cpu_to_le16(WTBL_VHT);
 			wtbl_vht->len = cpu_to_le16(sizeof(*wtbl_vht));
 			wtbl_vht->vht = 1;
 			wtbl_vht->ldpc = sta->vht_cap.cap &
 					 IEEE80211_VHT_CAP_RXLDPC;
-			wtlv++;
 
 			if (sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80)
 				val |= MT_WTBL_W5_SHORT_GI_80;
 			if (sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_160)
 				val |= MT_WTBL_W5_SHORT_GI_160;
+
+			wtlv++;
 		}
 
 		/* wtbl smps */
 		if (sta->smps_mode == IEEE80211_SMPS_DYNAMIC) {
 			struct wtbl_smps *wtbl_smps;
 
-			wtbl_smps = (struct wtbl_smps *)buf;
-			buf += sizeof(*wtbl_smps);
+			wtbl_smps = (struct wtbl_smps *)data;
+			data += sizeof(*wtbl_smps);
 			wtbl_smps->tag = cpu_to_le16(WTBL_SMPS);
 			wtbl_smps->len = cpu_to_le16(sizeof(*wtbl_smps));
 			wtbl_smps->smps = 1;
@@ -1407,8 +1409,8 @@ int mt7615_mcu_set_sta(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		if (sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_40)
 			val |= MT_WTBL_W5_SHORT_GI_40;
 
-		wtbl_raw = (struct wtbl_raw *)buf;
-		buf += sizeof(*wtbl_raw);
+		wtbl_raw = (struct wtbl_raw *)data;
+		data += sizeof(*wtbl_raw);
 		wtbl_raw->tag = cpu_to_le16(WTBL_RAW_DATA);
 		wtbl_raw->len = cpu_to_le16(sizeof(*wtbl_raw));
 		wtbl_raw->wtbl_idx = 1;
@@ -1419,14 +1421,18 @@ int mt7615_mcu_set_sta(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	}
 
 out:
+	wtbl_len = data - (u8 *)wtbl_hdr;
 	if (wtbl)
-		wtbl->len = cpu_to_le16(buf - (u8 *)wtbl_hdr);
+		wtbl->len = cpu_to_le16(wtbl_len);
 
 	wtbl_hdr->tlv_num = cpu_to_le16(wtlv);
-	req.hdr.tlv_num = cpu_to_le16(stlv);
+	sta_hdr->tlv_num = cpu_to_le16(stlv);
 
-	return mt7615_mcu_send_sta_rec(dev, (u8 *)&req, (u8 *)wtbl_hdr,
-				       buf - (u8 *)wtbl_hdr, en);
+	err = mt7615_mcu_send_sta_rec(dev, buf, (u8 *)wtbl_hdr, wtbl_len, en);
+
+	kfree(buf);
+
+	return err;
 }
 
 int mt7615_mcu_set_bcn(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 62da62981138..bddfe69de752 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -502,6 +502,13 @@ struct wtbl_raw {
 				 sizeof(struct wtbl_req_hdr) +	\
 				 sizeof(struct wtbl_ba))
 
+#define MT7615_MCU_STA_BUF_SIZE	(sizeof(struct sta_req_hdr) +	\
+				 sizeof(struct sta_rec_basic) +	\
+				 sizeof(struct sta_rec_ht) +	\
+				 sizeof(struct sta_rec_vht) +	\
+				 sizeof(struct sta_rec_wtbl) +	\
+				 MT7615_WTBL_UPDATE_MAX_SIZE)
+
 enum {
 	WTBL_GENERIC,
 	WTBL_RX,
-- 
2.24.1


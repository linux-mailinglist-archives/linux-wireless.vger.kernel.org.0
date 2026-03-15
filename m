Return-Path: <linux-wireless+bounces-33241-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IjADo+JtmlmDAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33241-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 11:27:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AECF5290672
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 11:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1B323019453
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 10:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0791727281E;
	Sun, 15 Mar 2026 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwrBULg7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D857C26ED41
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773570444; cv=none; b=twwGLvnCgPbklqNN0s6z2zVAnyTtjzuEGE9mvyq+YkItD/2fPVe4uVobq3wLldGZgI4Oodq3JP2961YYDzBdSkLp+tka3N7Clr6myiy4trngzpDLFIo06cKC0g2n71iFyXULlIHhK+mKHDzonvIM8vdztpLw2+lf5yTp2ZfOAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773570444; c=relaxed/simple;
	bh=nhfDnKIuW/cKtZjyAdzNDiXFZF4/Ufi3K9Niafg6Guk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CzZpZiQU5mZztA/8IlF7PrgpWZv20XGznYtJ11xJ/PWZx7p8jUsNEWwZAbc6jCcRoREyhieRth4dq0Il4JeG08dfJ+52XWGUZ9a5Vg2x+nX2SlQOicYnXMh+3eXUVzSP/9994YhnNLaV3tKEcI68l0iMtWT0+6ZVIsYcJELjwGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwrBULg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AD7C4CEF7;
	Sun, 15 Mar 2026 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773570444;
	bh=nhfDnKIuW/cKtZjyAdzNDiXFZF4/Ufi3K9Niafg6Guk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iwrBULg7RzjLZD9QSjgxeX9TLiVvrlGvbAx56j8P2E5mWvn5nPKVVYmuKr2xlW+kO
	 m1lqZv1ztbXWVMYvg4lBZ8P4prkorsD1rn8uzVAh/aT+tGwhqG8GVbp5B/FL5v5CSI
	 YoglrFCP2H9Fgwc0IgPrbCxNahd4nHKZE5iz20K70DCoVy5cBOWesKsTW4Jd4/Ihid
	 ykY44dqaJnsrGSE6CGza5lIcPpDlX3aLPmS4W5ie7779ufmuy+uKXt0RGfTj9JGMTY
	 +dow1uNPqhB4CxvIRqgZWwi+3uHtRuyt3L+UhV22OuB7iRbGYHLFAjmZOcJCIHfQHF
	 2AJSrxYE3MiCg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 15 Mar 2026 11:26:28 +0100
Subject: [PATCH mt76 5/6] wifi: mt76: mt7996: Add mcu APIs to
 enable/disable vif links.
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260315-mt7996-mlo-link-reconf-v1-5-a8a634fbc927@kernel.org>
References: <20260315-mt7996-mlo-link-reconf-v1-0-a8a634fbc927@kernel.org>
In-Reply-To: <20260315-mt7996-mlo-link-reconf-v1-0-a8a634fbc927@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33241-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AECF5290672
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shayne Chen <shayne.chen@mediatek.com>

Introduce mt7996_mcu_mld_reconf_stop_link and mt7996_mcu_mld_link_oper
utility routines in order to communicate to the mcu fw to disable/enable
a specific vif link. Please note these APIs are currently supported by
the MT7996 firmware only in AP mode.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |  2 +
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 50 +++++++++-------
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 66 ++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    | 34 +++++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  6 ++
 5 files changed, 139 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index fd9cf9c0c32fee5a661bcde99111b9942be3fbcb..ac5126ab68ff83ccc1fffc6da04d6fb7b264f60d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1319,6 +1319,7 @@ enum {
 	MCU_UNI_CMD_ASSERT_DUMP = 0x6f,
 	MCU_UNI_CMD_EXT_EEPROM_CTRL = 0x74,
 	MCU_UNI_CMD_RADIO_STATUS = 0x80,
+	MCU_UNI_CMD_MLD = 0x82,
 	MCU_UNI_CMD_SDO = 0x88,
 };
 
@@ -1394,6 +1395,7 @@ enum {
 	UNI_BSS_INFO_MLD = 26,
 	UNI_BSS_INFO_PM_DISABLE = 27,
 	UNI_BSS_INFO_EHT = 30,
+	UNI_BSS_INFO_MLD_LINK_OP = 36,
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index d8ef41c39a7f3d8801e05bfa6e2d22ed9d0371b7..ac82ea3f066a618d4a91c0a88922cf77bd0533da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -307,8 +307,12 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	int mld_idx, idx, ret;
 
 	if ((mvif->mt76.valid_links & BIT(link_conf->link_id)) &&
-	    !mlink->offchannel)
+	    !mlink->offchannel) {
+		if (vif->type == NL80211_IFTYPE_AP)
+			return mt7996_mcu_mld_link_oper(dev, link_conf, link,
+							true);
 		return 0;
+	}
 
 	mlink->idx = __ffs64(~dev->mt76.vif_mask);
 	if (mlink->idx >= mt7996_max_interface_num(dev))
@@ -453,6 +457,7 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	struct mt7996_vif_link *link = container_of(mlink, struct mt7996_vif_link, mt76);
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_sta_link *msta_link = &link->msta_link;
+	unsigned int link_id = msta_link->wcid.link_id;
 	struct mt7996_phy *phy = mphy->priv;
 
 	/* Hw requires to destroy active links tearing down the interface, so
@@ -460,26 +465,33 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	 */
 	if (mlink->wcid->offchannel) {
 		mt7996_vif_link_destroy(phy, link, vif, link_conf);
-	} else if (vif->txq &&
-		   mvif->mt76.deflink_id == msta_link->wcid.link_id) {
-		struct ieee80211_bss_conf *iter;
-		struct mt76_txq *mtxq;
-		unsigned int link_id;
-
-		mvif->mt76.deflink_id = IEEE80211_LINK_UNSPECIFIED;
-		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
-		/* Primary link will be removed, look for a new one */
-		for_each_vif_active_link(vif, iter, link_id) {
-			if (link_id == msta_link->wcid.link_id)
-				continue;
+	} else {
+		if (vif->type == NL80211_IFTYPE_AP) {
+			mt7996_mcu_mld_reconf_stop_link(phy->dev, vif,
+							BIT(link_id));
+			mt7996_mcu_mld_link_oper(phy->dev, link_conf, link,
+						 false);
+		}
 
-			link = mt7996_vif_link(phy->dev, vif, link_id);
-			if (!link)
-				continue;
+		if (vif->txq && mvif->mt76.deflink_id == link_id) {
+			struct ieee80211_bss_conf *iter;
+			struct mt76_txq *mtxq;
 
-			mtxq->wcid = link->msta_link.wcid.idx;
-			mvif->mt76.deflink_id = link_id;
-			break;
+			mvif->mt76.deflink_id = IEEE80211_LINK_UNSPECIFIED;
+			mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+			/* Primary link will be removed, look for a new one */
+			for_each_vif_active_link(vif, iter, link_id) {
+				if (link_id == msta_link->wcid.link_id)
+					continue;
+
+				link = mt7996_vif_link(phy->dev, vif, link_id);
+				if (!link)
+					continue;
+
+				mtxq->wcid = link->msta_link.wcid.idx;
+				mvif->mt76.deflink_id = link_id;
+				break;
+			}
 		}
 	}
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 4bf22318396f82e705693a52693486628c4c88e1..16420375112d1ee0c0d26470d03b90eb51354823 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2583,6 +2583,72 @@ mt7996_mcu_add_group(struct mt7996_dev *dev, struct mt7996_vif_link *link,
 				 sizeof(req), true);
 }
 
+int mt7996_mcu_mld_reconf_stop_link(struct mt7996_dev *dev,
+				    struct ieee80211_vif *vif,
+				    u16 removed_links)
+{
+	unsigned long rem_links = removed_links;
+	struct mld_reconf_stop_link *sl;
+	struct mld_req_hdr hdr = {};
+	unsigned int link_id;
+	struct sk_buff *skb;
+	struct tlv *tlv;
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, sizeof(hdr) + sizeof(*sl));
+	if (!skb)
+		return -ENOMEM;
+
+	memcpy(hdr.mld_addr, vif->addr, ETH_ALEN);
+	skb_put_data(skb, &hdr, sizeof(hdr));
+
+	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_CMD_MLD_RECONF_STOP_LINK,
+				     sizeof(*sl));
+	sl = (struct mld_reconf_stop_link *)tlv;
+	sl->link_bitmap = cpu_to_le16(removed_links);
+
+	for_each_set_bit(link_id, &rem_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct mt7996_vif_link *link;
+
+		link = mt7996_vif_link(dev, vif, link_id);
+		if (!link)
+			continue;
+
+		sl->bss_idx[link_id] = link->mt76.idx;
+	}
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_WM_UNI_CMD(MLD),
+				     true);
+}
+
+int mt7996_mcu_mld_link_oper(struct mt7996_dev *dev,
+			     struct ieee80211_bss_conf *link_conf,
+			     struct mt7996_vif_link *link, bool add)
+{
+	struct ieee80211_vif *vif = link_conf->vif;
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct bss_mld_link_op_tlv *mld_op;
+	struct sk_buff *skb;
+	struct tlv *tlv;
+
+	skb = __mt7996_mcu_alloc_bss_req(&dev->mt76, &link->mt76,
+					 MT7996_BSS_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	tlv = mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_MLD_LINK_OP,
+				     sizeof(*mld_op));
+	mld_op = (struct bss_mld_link_op_tlv *)tlv;
+	mld_op->link_operation = add;
+	mld_op->own_mld_id = link->mld_idx;
+	mld_op->link_id = link_conf->link_id;
+	mld_op->group_mld_id = add ? mvif->mld_group_idx : 0xff;
+	mld_op->remap_idx = add ? mvif->mld_remap_idx : 0xff;
+	memcpy(mld_op->mac_addr, vif->addr, ETH_ALEN);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_WMWA_UNI_CMD(BSS_INFO_UPDATE), true);
+}
+
 static void
 mt7996_mcu_sta_mld_setup_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 			     struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index 39df1367977954e2afb86b479ddaf77b3cf210cd..8902e16508b75e96fe74cbc6fca284478d7f0eb3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -524,6 +524,18 @@ struct bss_prot_tlv {
 	__le32 prot_mode;
 } __packed;
 
+struct bss_mld_link_op_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 group_mld_id;
+	u8 own_mld_id;
+	u8 mac_addr[ETH_ALEN];
+	u8 remap_idx;
+	u8 link_operation;
+	u8 link_id;
+	u8 rsv[2];
+} __packed;
+
 struct sta_rec_ht_uni {
 	__le16 tag;
 	__le16 len;
@@ -697,6 +709,28 @@ struct mld_setup_link {
 	u8 __rsv;
 } __packed;
 
+struct mld_req_hdr {
+	u8 ver;
+	u8 mld_addr[ETH_ALEN];
+	u8 mld_idx;
+	u8 flag;
+	u8 rsv[3];
+	u8 buf[];
+} __packed;
+
+struct mld_reconf_stop_link {
+	__le16 tag;
+	__le16 len;
+	__le16 link_bitmap;
+	u8 rsv[2];
+	u8 bss_idx[16];
+} __packed;
+
+enum {
+	UNI_CMD_MLD_RECONF_AP_REM_TIMER = 0x03,
+	UNI_CMD_MLD_RECONF_STOP_LINK = 0x04,
+};
+
 struct hdr_trans_en {
 	__le16 tag;
 	__le16 len;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index d18f8794351eca4e3d3b3a314d0ac2fe7a6d8249..e0a5c4eeb5165f2b789bbbf7d731a8ff3aaab49f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -776,6 +776,12 @@ int mt7996_mcu_get_all_sta_info(struct mt7996_phy *phy, u16 tag);
 int mt7996_mcu_wed_rro_reset_sessions(struct mt7996_dev *dev, u16 id);
 int mt7996_mcu_set_sniffer_mode(struct mt7996_phy *phy, bool enabled);
 int mt7996_mcu_set_dup_wtbl(struct mt7996_dev *dev);
+int mt7996_mcu_mld_reconf_stop_link(struct mt7996_dev *dev,
+				    struct ieee80211_vif *vif,
+				    u16 removed_links);
+int mt7996_mcu_mld_link_oper(struct mt7996_dev *dev,
+			     struct ieee80211_bss_conf *link_conf,
+			     struct mt7996_vif_link *link, bool add);
 
 static inline bool mt7996_has_hwrro(struct mt7996_dev *dev)
 {

-- 
2.53.0



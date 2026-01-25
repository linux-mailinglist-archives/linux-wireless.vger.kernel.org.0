Return-Path: <linux-wireless+bounces-31142-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GblLuL1dWkXKAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31142-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 11:52:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51797801FA
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 11:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E14E6300956E
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 10:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38FE281530;
	Sun, 25 Jan 2026 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2Hdw2XT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07711DDA18
	for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769338329; cv=none; b=PecA7vxZbsCORdbfdc9Sej/auOnttLe7iiuUc+8uko1ybMjBx8ZoME57Z/6JXKBCPNydy9gMxJidYqVVpM733vNbDIbRU8Lx8qpdg9b8AtiMqaTMzGsgUy6rdbisPNGH4s5O8nSViNlakE3VZflDfe7XnPIGBia/t/qtHdQAsIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769338329; c=relaxed/simple;
	bh=cbLIkxfmrx+qyRG8eF8Ce0iiYleWQvkJNJoETgItHB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aUpKUABk1I2PCKhM3M5Fi4IVjAlvo1vRsXS2/uJ1QLOIZME5yMe1y+blyQDbQ+Dgpuv4WzrRi+GsnhadEI8uTX0sWzgJD6q3Axszdi6uKhU7JxRL/1IBBZA93sF8/ZsN4HU4nFVqUZZfno4L1ERVDj1bz9F+n4hAH8uOjqZevM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2Hdw2XT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D742BC4CEF1;
	Sun, 25 Jan 2026 10:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769338329;
	bh=cbLIkxfmrx+qyRG8eF8Ce0iiYleWQvkJNJoETgItHB0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H2Hdw2XTWINXs8LunHmB7peR9kYx6C9C9slhT4XicXT7QeIgGQ2d4ohj2OGsaVJiY
	 xgsf3R8uRSV2CdlelNz//FjhSt7LMan2DsmPU74krVfU6FioRUWXZh81QaY4Ye222u
	 Ym2DfvS7uT+1HnqmnXrlV9I+++jnOWbT2AM06JU7UBkD0KqyGT068bXSBTPMHgvdWT
	 1bINvKXOVVL2QFj07ICICDn/EFHdqRkWhoVGieSoX+XOWs/mKXWjuyQNp2xv+72GtN
	 st1gECMvQsh3CMBsDLCz4QURwF5T12EL8Py3Nt3rzyFH7bLqfG1LTyTNv97rHxKrgi
	 nxugVHEWgxUgQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 25 Jan 2026 11:51:31 +0100
Subject: [PATCH wireless-next v2 2/2] wifi: mt76: mt7996: Add eMLSR support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260125-mac80211-emlsr-v2-2-466329d61c88@kernel.org>
References: <20260125-mac80211-emlsr-v2-0-466329d61c88@kernel.org>
In-Reply-To: <20260125-mac80211-emlsr-v2-0-466329d61c88@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>, 
 Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
 Shayne Chen <shayne.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 MeiChia Chiu <MeiChia.Chiu@mediatek.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31142-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[sipsolutions.net,mediatek.com,gmail.com,collabora.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,mediatek.com,kernel.org,gmail.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 51797801FA
X-Rspamd-Action: no action

From: MeiChia Chiu <MeiChia.Chiu@mediatek.com>

Implement set_eml_op_mode mac80211 callback in order to introduce eMLSR
support.

Signed-off-by: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |  9 ++++
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 16 +++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 54 ++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  5 ++
 4 files changed, 84 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 8d59cf43f0e2dc8d8e42d6b2ec7565ad69a79ff8..44697498b38a5b9eff92627b63c383ca8f48a760 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -628,6 +628,13 @@ struct sta_rec_tx_proc {
 	__le32 flag;
 } __packed;
 
+struct sta_rec_eml_op {
+	__le16 tag;
+	__le16 len;
+	u8 link_bitmap;
+	u8 link_ant_num[3];
+} __packed;
+
 /* wtbl_rec */
 
 struct wtbl_req_hdr {
@@ -796,6 +803,7 @@ struct wtbl_raw {
 					 sizeof(struct sta_rec_he_6g_capa) + \
 					 sizeof(struct sta_rec_pn_info) + \
 					 sizeof(struct sta_rec_tx_proc) + \
+					 sizeof(struct sta_rec_eml_op) + \
 					 sizeof(struct tlv) +		\
 					 MT76_CONNAC_WTBL_UPDATE_MAX_SIZE)
 
@@ -832,6 +840,7 @@ enum {
 	STA_REC_PN_INFO = 0x26,
 	STA_REC_KEY_V3 = 0x27,
 	STA_REC_HDRT = 0x28,
+	STA_REC_EML_OP = 0x29,
 	STA_REC_HDR_TRANS = 0x2B,
 	STA_REC_MAX_NUM
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index beed795edb24c67e1b7b44fe87fd5de125a21d94..d5b88687ba1801a1e50e81e5c27f1f67fa455ce1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -2275,6 +2275,21 @@ mt7996_reconfig_complete(struct ieee80211_hw *hw,
 					     MT7996_WATCHDOG_TIME);
 }
 
+static int
+mt7996_set_eml_op_mode(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta, unsigned int link_id,
+		       struct ieee80211_eml_params *eml_params)
+{
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	int ret;
+
+	mutex_lock(&dev->mt76.mutex);
+	ret = mt7996_mcu_set_emlsr_mode(dev, vif, sta, link_id, eml_params);
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+
 const struct ieee80211_ops mt7996_ops = {
 	.add_chanctx = mt76_add_chanctx,
 	.remove_chanctx = mt76_remove_chanctx,
@@ -2337,4 +2352,5 @@ const struct ieee80211_ops mt7996_ops = {
 	.change_vif_links = mt7996_change_vif_links,
 	.change_sta_links = mt7996_mac_sta_change_links,
 	.reconfig_complete = mt7996_reconfig_complete,
+	.set_eml_op_mode = mt7996_set_eml_op_mode,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 14a88ef79b6cb9ee60e62d695af4a90ab1d89846..54d6a41281841c3a86e5308971b1e456da8e0e73 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1170,6 +1170,60 @@ int mt7996_mcu_add_bss_info(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 				     MCU_WMWA_UNI_CMD(BSS_INFO_UPDATE), true);
 }
 
+int mt7996_mcu_set_emlsr_mode(struct mt7996_dev *dev,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta,
+			      unsigned int link_id,
+			      struct ieee80211_eml_params *eml_params)
+{
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_sta_link *msta_link;
+	struct sta_rec_eml_op *eml_op;
+	struct mt7996_vif_link *link;
+	struct sk_buff *skb;
+	struct tlv *tlv;
+
+	msta_link = mt76_dereference(msta->link[link_id], &dev->mt76);
+	if (!msta_link)
+		return -EINVAL;
+
+	link = mt7996_vif_link(dev, vif, link_id);
+	if (!link)
+		return -EINVAL;
+
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &link->mt76,
+					      &msta_link->wcid,
+					      MT7996_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_EML_OP, sizeof(*eml_op));
+	eml_op = (struct sta_rec_eml_op *)tlv;
+	eml_op->link_bitmap = 0;
+
+	if (eml_params->control & IEEE80211_EML_CTRL_EMLSR_MODE) {
+		unsigned long link_bitmap = eml_params->link_bitmap;
+
+		for_each_set_bit(link_id, &link_bitmap,
+				 IEEE80211_MLD_MAX_NUM_LINKS) {
+			struct mt76_phy *mphy;
+
+			link = mt7996_vif_link(dev, vif, link_id);
+			if (!link)
+				continue;
+
+			mphy = mt76_vif_link_phy(&link->mt76);
+			if (!mphy)
+				continue;
+
+			eml_op->link_bitmap |= BIT(mphy->band_idx);
+		}
+	}
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
+}
+
 int mt7996_mcu_set_timing(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 			  struct ieee80211_bss_conf *link_conf)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 7a884311800ea8cfc0e302b2a140a4072ce18b69..da8688e01c1502cbd895ea40561f77e929c6ee38 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -861,6 +861,11 @@ int mt7996_mcu_wtbl_update_hdr_trans(struct mt7996_dev *dev,
 				     struct mt7996_vif_link *link,
 				     struct mt7996_sta_link *msta_link);
 int mt7996_mcu_cp_support(struct mt7996_dev *dev, u8 mode);
+int mt7996_mcu_set_emlsr_mode(struct mt7996_dev *dev,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta,
+			      unsigned int link_id,
+			      struct ieee80211_eml_params *eml_params);
 #ifdef CONFIG_MAC80211_DEBUGFS
 void mt7996_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta, struct dentry *dir);

-- 
2.52.0



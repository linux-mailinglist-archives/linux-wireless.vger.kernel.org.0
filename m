Return-Path: <linux-wireless+bounces-31495-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHB3NQu0gWnNIwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31495-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 09:38:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DC9D649C
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 09:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38AAF309F88D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Feb 2026 08:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4434E395249;
	Tue,  3 Feb 2026 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRuQmNY7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F4393DF1
	for <linux-wireless@vger.kernel.org>; Tue,  3 Feb 2026 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770107552; cv=none; b=WLwHAzxLSCPMOP+AdPR1kpR0UU8ds6e4QoJC5pIKN4PcIsuNt96vpgOshjUWYIKKba3uj63WchVcQTQrn2qwAMAxjxWHkLJ+iCOTQqkY96Up3aGWHmlQEPBji68lzU4JLwMKbzR772u2LDeeaDHP0V+QHbqlYAIQ6Q2wZ0WyHPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770107552; c=relaxed/simple;
	bh=Rxqd6CZwBn18DO82HK4+2RYTRznPltmfeG6JDWGATF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KNR/SdCPEl1oR5BJZPXu4RelhWbgK28Vpa9b31+o8Yrzb8Pj4VrEcUOACQLXakRaBryxMAZgZxcHEtAmITqWDyo6io2FkAXgxfMvrYTNY3aIOgj6u18TPuRA/+HszPxa/WBBEaWzwv3+eMrqhEKkmgINEXWje0Kaf2daUW4D8rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRuQmNY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160B1C116D0;
	Tue,  3 Feb 2026 08:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770107551;
	bh=Rxqd6CZwBn18DO82HK4+2RYTRznPltmfeG6JDWGATF8=;
	h=From:Date:Subject:To:Cc:From;
	b=nRuQmNY7tHHkXXX3CEDKDi3qX9Bc9CY+8ueHn7ndQ+m2AIyj6XNX+hj7l6W4xN5XZ
	 svPYoNCZ+OGWSgb/GUklF5Zy1pbOwkCSuuqDEcSk0JXlxmhWEdLXtbG+YbVu+9DFLI
	 Mny2S3v533zHOwz6Vyed4SCRAQ1DpsZ5jAGV/g6ypnNQS9FFLkdFb/cX3UGTDLtqlr
	 Dju9Sb+Ww5xQ3QlGIKmiKanQl7eJFwJL66m9VKiabaVuil53hq2y6M0frODPdXTrVa
	 gcLzyhgXkMk/opPJX3nGTF1CiOS2B/sOEMVHaTkRVhcefC7gaaFk4IHHqSPX94oeqk
	 qz8NjpcU9PjdQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 03 Feb 2026 09:32:02 +0100
Subject: [PATCH mt76] wifi: mt76: mt7996: Add eMLSR support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-mt7996-emlsr-v1-1-38ffb3d5110c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIwNj3dwSc0tLM93U3JziIl3L5GSLRDMLk+TkpEQloJaCotS0zAqwcdG
 xtbUA6rvh0l4AAAA=
X-Change-ID: 20260203-mt7996-emlsr-9cc8a684ccba
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 MeiChia Chiu <MeiChia.Chiu@mediatek.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31495-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,mediatek.com,gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Queue-Id: 31DC9D649C
X-Rspamd-Action: no action

From: MeiChia Chiu <MeiChia.Chiu@mediatek.com>

Implement set_eml_op_mode mac80211 callback in order to introduce eMLSR
support.

Tested-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |  9 ++++
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 16 +++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 55 ++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  4 ++
 4 files changed, 84 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index f44977f9093da76a9f5e2b4d7ce147de28c5b18e..b8629c0a1639b3f55d2133bdea28fa6cae552cac 100644
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
index 7046bf26d8ed6776ea114592f8b89c8b2a605339..48e4cd5af9293cedb9018fd9148dceac67bc4653 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -2368,6 +2368,21 @@ mt7996_reconfig_complete(struct ieee80211_hw *hw,
 					     MT7996_WATCHDOG_TIME);
 }
 
+static int
+mt7996_set_eml_op_mode(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta,
+		       struct ieee80211_eml_params *eml_params)
+{
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	int ret;
+
+	mutex_lock(&dev->mt76.mutex);
+	ret = mt7996_mcu_set_emlsr_mode(dev, vif, sta, eml_params);
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+
 const struct ieee80211_ops mt7996_ops = {
 	.add_chanctx = mt76_add_chanctx,
 	.remove_chanctx = mt76_remove_chanctx,
@@ -2431,4 +2446,5 @@ const struct ieee80211_ops mt7996_ops = {
 	.change_vif_links = mt7996_change_vif_links,
 	.change_sta_links = mt7996_mac_sta_change_links,
 	.reconfig_complete = mt7996_reconfig_complete,
+	.set_eml_op_mode = mt7996_set_eml_op_mode,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 8e1c8e1d6a99f093a2b7d7dc3a0c56f3a4bc220b..3098bddc5f6d6d33433bc653d5ef63bbe5c740fb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1302,6 +1302,61 @@ int mt7996_mcu_set_protection(struct mt7996_phy *phy, struct mt7996_vif_link *li
 				     MCU_WM_UNI_CMD(BSS_INFO_UPDATE), true);
 }
 
+int mt7996_mcu_set_emlsr_mode(struct mt7996_dev *dev,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta,
+			      struct ieee80211_eml_params *eml_params)
+{
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_sta_link *msta_link;
+	struct sta_rec_eml_op *eml_op;
+	struct mt7996_vif_link *link;
+	struct sk_buff *skb;
+	struct tlv *tlv;
+
+	msta_link = mt76_dereference(msta->link[eml_params->link_id],
+				     &dev->mt76);
+	if (!msta_link)
+		return -EINVAL;
+
+	link = mt7996_vif_link(dev, vif, eml_params->link_id);
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
+		unsigned int link_id;
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
index 3ff730e36fa60830cc9ba5311643b008860cec22..c5d60c273cf8e15e3d54e2d851acbd83ce69719d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -875,6 +875,10 @@ int mt7996_mcu_wtbl_update_hdr_trans(struct mt7996_dev *dev,
 				     struct mt7996_vif_link *link,
 				     struct mt7996_sta_link *msta_link);
 int mt7996_mcu_cp_support(struct mt7996_dev *dev, u8 mode);
+int mt7996_mcu_set_emlsr_mode(struct mt7996_dev *dev,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta,
+			      struct ieee80211_eml_params *eml_params);
 #ifdef CONFIG_MAC80211_DEBUGFS
 void mt7996_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta, struct dentry *dir);

---
base-commit: 4eefc435c985f4dfdba9afb1c705f0e17377c084
change-id: 20260203-mt7996-emlsr-9cc8a684ccba

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>



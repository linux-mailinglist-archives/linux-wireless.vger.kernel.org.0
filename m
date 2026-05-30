Return-Path: <linux-wireless+bounces-37174-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xzinNnYBG2rL+QgAu9opvQ
	(envelope-from <linux-wireless+bounces-37174-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 17:25:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CEE60DB69
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 17:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7AE2301570B
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 15:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0290D2D3750;
	Sat, 30 May 2026 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTE9Cz4C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EFF27B32C
	for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780154739; cv=none; b=ouFJ3M64klymi+a4g8Og4lUHYM3OyObf7nipdwQCepFzuCQX+jiuaCVhzJSxw0yX/agxaDTLSuZ4x4TP2rSY4g4o8MyrmHRRtCW7UjFK6L88cC7lNHH6xkIV9mK25zlHeeEAmb+4PjENQQSSNYlBzys3889s8HgCdSRUQpGOFmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780154739; c=relaxed/simple;
	bh=+ODU18piNym2rm1K9uSelFt+iNDp/0MqUsJvcURV8ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V942znymrKaLQD57CELg5+V32vDyP75EDepSd4EZJOwC02E1W/hMlgjHp6vbM3qqjtw6jPQYtUS6dCHaG7RZfIuc0qcCZeIpU3N1LXxQg5S5l3Xgise+UB7X9ZhjpoUkGV4UEgVUmeSSQi2ETX1O1s3ymeq5u9zBs00zI6MSzRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTE9Cz4C; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF681F00893;
	Sat, 30 May 2026 15:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780154738;
	bh=iecpMyBy5MTB0RQzT2oRMj4VPEdKJVOMMF3dhEPLQ5A=;
	h=From:Date:Subject:To:Cc;
	b=CTE9Cz4CnOBOBMH4lbuzHJRRx6S4pJAjmaSczNC8VC5sRDnJTx7I7837TS5Bpm46U
	 ll9yL07TMB9RYVEB0+CTM0dh9GMY00t240I1pkPMa89qgY/onkSXA9jy2nqwKhctYL
	 GAcPfvF9iUiobumycm/nNMbZGKoCVc7Vi4tAoL4pvvKmTEB8fLaTuKo3JBA+C4mXWD
	 Vh9UtzQAQa/a6WgmcSkgQYUyTyJbd6Kua0aIcC6DbgAoLv9pyPEjcHj6GzRDw8BXrt
	 L6Mt1+AUoXAUEiTexw5RK8LqXAVr2R0SxFgtfHYavFeviFSmdBFNg24RQIj4NbXb8S
	 pPJh+KOTDcCmQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 30 May 2026 17:25:22 +0200
Subject: [PATCH] wifi: mt76: mt7996: fix reading zeroed info->control.flags
 after mt76_tx_status_skb_add()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-mt76_tx_status_skb_add-overwrite-fix-v1-1-e2c3151c391a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2N0QrCMAwAf2Xk2UC7sVn9FZHS2kyDuEkS52Ds3
 y0+3j3cbaAkTArnZgOhhZXnqYI/NHB7pOlOyKUytK4dXN85fNlxiLZGtWQfjfrMMZWC80LyFTb
 CkVcMffAhnXLu/Ag19Raq+r+5XPf9B00r8Lh2AAAA
X-Change-ID: 20260530-mt76_tx_status_skb_add-overwrite-fix-85818a9bb31f
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Roy Luo <roy-ch.luo@mediatek.com>, linux-wireless@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-37174-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 30CEE60DB69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mt76_tx_status_skb_add() zeroes the mt76_tx_cb struct stored at
info->status.status_driver_data via memset(). Since info->control and
info->status are members of the same union in ieee80211_tx_info,
this overwrites info->control.flags.
In mt7996_tx_prepare_skb(), mt76_tx_status_skb_add() is called before
mt7996_mac_write_txwi(), which re-reads info->control.flags to extract
IEEE80211_TX_CTRL_MLO_LINK. Because the field has been zeroed, the
link_id always resolves to 0 for frames using global_wcid, leading to
incorrect TXWI configuration.
Fix this by passing link_id as an explicit parameter to
mt7996_mac_write_txwi(). In mt7996_tx_prepare_skb(), the link_id is
already extracted from info->control.flags before the destructive
mt76_tx_status_skb_add() call. For the beacon and inband discovery
callers in mcu.c, use link_conf->link_id directly.

Fixes: f0b0b239b8f36 ("wifi: mt76: mt7996: rework mt7996_mac_write_txwi() for MLO support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 9 +++------
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 5 +++--
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h | 3 ++-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index c98446057282..2d3f80b3e41a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -856,7 +856,8 @@ mt7996_mac_write_txwi_80211(struct mt7996_dev *dev, __le32 *txwi,
 void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid,
 			   struct ieee80211_key_conf *key, int pid,
-			   enum mt76_txq_id qid, u32 changed)
+			   enum mt76_txq_id qid, u32 changed,
+			   unsigned int link_id)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
@@ -866,7 +867,6 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
 	struct mt76_vif_link *mlink = NULL;
 	struct mt7996_vif *mvif;
-	unsigned int link_id;
 	u16 tx_count = 15;
 	u32 val;
 	bool inband_disc = !!(changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
@@ -876,9 +876,6 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 
 	if (wcid != &dev->mt76.global_wcid)
 		link_id = wcid->link_id;
-	else
-		link_id = u32_get_bits(info->control.flags,
-				       IEEE80211_TX_CTRL_MLO_LINK);
 
 	mvif = vif ? (struct mt7996_vif *)vif->drv_priv : NULL;
 	if (mvif) {
@@ -1096,7 +1093,7 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	/* Transmit non qos data by 802.11 header and need to fill txd by host*/
 	if (!is_8023 || pid >= MT_PACKET_ID_FIRST)
 		mt7996_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
-				      pid, qid, 0);
+				      pid, qid, 0, link_id);
 
 	/* MT7996 and MT7992 require driver to provide the MAC TXP for AddBA
 	 * req
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 8be40d60ad29..a14c63438923 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3103,7 +3103,7 @@ mt7996_mcu_beacon_cont(struct mt7996_dev *dev,
 
 	buf = (u8 *)bcn + sizeof(*bcn);
 	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, NULL, 0, 0,
-			      BSS_CHANGED_BEACON);
+			      BSS_CHANGED_BEACON, link_conf->link_id);
 
 	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
 }
@@ -3249,7 +3249,8 @@ int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 
 	buf = (u8 *)tlv + sizeof(*discov);
 
-	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, NULL, 0, 0, changed);
+	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, NULL, 0, 0,
+			      changed, link_conf->link_id);
 
 	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 0dc4198fcf8b..0d6488522ba7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -874,7 +874,8 @@ void mt7996_mac_enable_nf(struct mt7996_dev *dev, u8 band);
 void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid,
 			   struct ieee80211_key_conf *key, int pid,
-			   enum mt76_txq_id qid, u32 changed);
+			   enum mt76_txq_id qid, u32 changed,
+			   unsigned int link_id);
 void mt7996_mac_update_beacons(struct mt7996_phy *phy);
 void mt7996_mac_set_coverage_class(struct mt7996_phy *phy);
 void mt7996_mac_work(struct work_struct *work);

---
base-commit: 4913f44167cf35a9536e9eec7352e15b2de0c573
change-id: 20260530-mt76_tx_status_skb_add-overwrite-fix-85818a9bb31f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>



Return-Path: <linux-wireless+bounces-37190-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CUfEYz3G2oNHwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37190-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 10:55:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAFB615378
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 10:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0E753004D2D
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 08:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6537377ED9;
	Sun, 31 May 2026 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kH8qN1cb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A333783AE;
	Sun, 31 May 2026 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780217732; cv=none; b=H7wBisIlrt8bEi+YstRmd23JTZ+sGkQ9sENbpSivzEFjIx+qyI3p1qKnnHw6q5vcTXMb5V1vPiTxI1k3SOAivisdBP87uHCko3hc+p7OBw/Zj1ruJ2mvy9OQUQKjEv+5Htgh+cHYaAxc37Jcfkhdq+vRGj6d5/zm1xBZHCNiv+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780217732; c=relaxed/simple;
	bh=zz2jg+uKo8pXrKJAN95ppTP0wmRVdaF/i8DIeaQQUyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ONpNnVc9znK0SowrJe564sK2swGDhozJpaEf6ILK96ysm1VbQrvB645HdCnTvvfKrq+b+DeKLdvOGJajAwAeIqPDSLrkBfKHucRdII4ppqUT2G0ZXqSGg/G33vbwu3LuLnLTzfS0dh2FYpus2Pkgf7MR8jNSUN/GUw9gnXhqc5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kH8qN1cb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB131F00893;
	Sun, 31 May 2026 08:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780217731;
	bh=0vlPUZLJ6qFSfJi2KHBKAuBKAbgSeUs6MvoKLHrh2ec=;
	h=From:Date:Subject:To:Cc;
	b=kH8qN1cbP4KP/vCQ13fR5Rebqcy0ezYw5dV1VP2w+7fzgEcrrEjdaaMelFeHKOw7q
	 zPx14egOaT22ib9OvJzJnpx/ydGVnn0KUYi5Vz4mxJ/R5m3JRU0G5VBWOkw2jvo7FO
	 uhzI0RPoaXS9yPJrvbPU4J9fOYG4nHEWJMXffhbWDagX7hxe5BxrrSHzR5KNo1m0MI
	 pYnvlQZh6TeTuiTdaJW1C0m1xa0Qoefneb+tWWNuUuEWk3U4aQ/LE/JgopYwzV1vzy
	 UUQL63RbGK96DSGz1XgoKMWn5UwsCR+03t4y+OYsIXYf58w4vGjZflLzvVgorJNad7
	 WfBp0vS46vHLA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 31 May 2026 10:55:04 +0200
Subject: [PATCH v2] wifi: mt76: mt7996: fix reading zeroed
 info->control.flags after mt76_tx_status_skb_add()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-mt76_tx_status_skb_add-overwrite-fix-v2-1-b73c4b4a9798@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WNQQ6CMBAAv2J6toZtA4In/2FIU2CBDUrNtlYM4
 e9WfuBx5jCzCo9M6MXlsArGSJ7cnEAdD6Id7TygpC6xUJkqslxn8hHOhQmL8cGGlzd+aoztOuk
 i8pspoOxpkWVeQmmrptHQi5R6Mia9b2514pF8cPzZrxF+9s9BBAkSVashh1ZXYK8T8oz3k+NB1
 Nu2fQFM2BBi2QAAAA==
X-Change-ID: 20260530-mt76_tx_status_skb_add-overwrite-fix-85818a9bb31f
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Roy Luo <roy-ch.luo@mediatek.com>, linux-wireless@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37190-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4CAFB615378
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
Changes in v2:
- Do not use link_id in mt7996_mac_write_txwi if it is IEEE80211_LINK_UNSPECIFIED
- In mt7996_mac_write_txwi() rely on link_id calculated in
  mt7996_tx_prepare_skb().
- Link to v1: https://lore.kernel.org/r/20260530-mt76_tx_status_skb_add-overwrite-fix-v1-1-e2c3151c391a@kernel.org
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 14 ++++----------
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  5 +++--
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  3 ++-
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index c98446057282..95b3078d9667 100644
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
@@ -874,17 +874,11 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 	bool beacon = !!(changed & (BSS_CHANGED_BEACON |
 				    BSS_CHANGED_BEACON_ENABLED)) && (!inband_disc);
 
-	if (wcid != &dev->mt76.global_wcid)
-		link_id = wcid->link_id;
-	else
-		link_id = u32_get_bits(info->control.flags,
-				       IEEE80211_TX_CTRL_MLO_LINK);
-
 	mvif = vif ? (struct mt7996_vif *)vif->drv_priv : NULL;
 	if (mvif) {
 		if (wcid->offchannel)
 			mlink = rcu_dereference(mvif->mt76.offchannel_link);
-		if (!mlink)
+		if (!mlink && link_id != IEEE80211_LINK_UNSPECIFIED)
 			mlink = rcu_dereference(mvif->mt76.link[link_id]);
 	}
 
@@ -1096,7 +1090,7 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
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



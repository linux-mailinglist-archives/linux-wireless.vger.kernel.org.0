Return-Path: <linux-wireless+bounces-33237-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIZ8HISJtmlmDAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33237-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 11:27:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D3D290664
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 11:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C5473019CBB
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 10:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB9026ED41;
	Sun, 15 Mar 2026 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4fXPru/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF81922068D
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773570434; cv=none; b=cC4yQb5uF2IptWYqBGBPtR/0U2rShHPo6l8qdYj5BP8aHl2IV3WfDTH6EkrfN9EobtIzu1dJZV6+X5yx2Ql8z5WHrQQOcCuxnVX0ZBHUMfio8TnuSm/rEsDsI3kSOaRCK7rYxqie0vGNK4Dq9SKx3thoWys0/4OLocun8OQSHJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773570434; c=relaxed/simple;
	bh=Yk5aZX4HYMGAQBKmnXgiQoyzfn2nipKRDLJoOYEKA80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nNaI4T1tDMqA4Lbyu/Orjsz7iTXOrYHA5sHQ1ILbfxsU8OLE8d//gKs337tpkHQC9AqD5CymekRX+eEbJd4TSEuCjEKq9/9N/mR7pIVEmh7HRdOQLJDDdHih73ti/O0DGppSw7m5c3opZfjJh1muaZjwiNMBt7jDme7wYP8TsU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4fXPru/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BDBC19424;
	Sun, 15 Mar 2026 10:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773570433;
	bh=Yk5aZX4HYMGAQBKmnXgiQoyzfn2nipKRDLJoOYEKA80=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B4fXPru/rNezggcTwvAaQ4Um8IoJZBv8orPpuAXNpQHDHsZDQutPOZn+hUSv41L9r
	 jDoJoBSheKH//xDraG1uHTGct1tXvFKPBSCtL0AmHicreRR78vldm8Zui628i3t2oj
	 Ymm+SnFdvWK/TzBn5kpUHAa+JwjKhRObwFlORJtPda0x65Dq6T2W9cs4kwurps2c8z
	 8Lw+mA8D6AdXIFRlccBfOXdNrRQQD+s/QoCRU5e8uXoBWAnWYXH/Xdi7WUqjUxyilj
	 H0WxnlQz8Rkwcf2ou8/aTb8zZ75caPIs2IUG1DsCSFXt8dRlp68RDcw3A+jqd/6DRA
	 kSWnjx4JLcQ3Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 15 Mar 2026 11:26:24 +0100
Subject: [PATCH mt76 1/6] wifi: mt76: mt7996: Rely on msta_link link_id in
 mt7996_vif_link_remove()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260315-mt7996-mlo-link-reconf-v1-1-a8a634fbc927@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-33237-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: E2D3D290664
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rely on msta_link link_id value in mt7996_vif_link_remove routine
instead of using link_conf pointer. This assumption is correct since
msta_link link_id is set to link_conf link_id value in mt7996_vif_link_add
routine.
Moreover, fallback to default ieee80211_bss_conf struct if the link_conf
pointer in mt7996_vif_link_remove() is NULL.
MT7996 hw requires to remove AP MLD links from MCU configuration during
AP tear-down process (e.g. running mt7996_remove_interface()). Doing so,
we can't assume link_conf pointer is always non-NULL running
mt7996_vif_link_remove routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 834edd31458d57a21fc2e02d429ea139057aa60b..21a240f0c8c275b9fb5532ff74bbf76b741dac84 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -396,17 +396,21 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	struct mt7996_vif_link *link = container_of(mlink, struct mt7996_vif_link, mt76);
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_sta_link *msta_link = &link->msta_link;
+	unsigned int link_id = msta_link->wcid.link_id;
 	struct mt7996_phy *phy = mphy->priv;
 	struct mt7996_dev *dev = phy->dev;
 	struct mt7996_key_iter_data it = {
 		.cmd = SET_KEY,
-		.link_id = link_conf->link_id,
+		.link_id = link_id,
 	};
 	int idx = msta_link->wcid.idx;
 
 	if (!mlink->wcid->offchannel)
 		ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, &it);
 
+	if (!link_conf)
+		link_conf = &vif->bss_conf;
+
 	mt7996_mcu_add_sta(dev, link_conf, NULL, link, NULL,
 			   CONN_STATE_DISCONNECT, false);
 	mt7996_mcu_add_bss_info(phy, vif, link_conf, mlink, msta_link, false);
@@ -416,10 +420,9 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
 	if (vif->txq && !mlink->wcid->offchannel &&
-	    mvif->mt76.deflink_id == link_conf->link_id) {
+	    mvif->mt76.deflink_id == link_id) {
 		struct ieee80211_bss_conf *iter;
 		struct mt76_txq *mtxq;
-		unsigned int link_id;
 
 		mvif->mt76.deflink_id = IEEE80211_LINK_UNSPECIFIED;
 		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
@@ -427,7 +430,7 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 		for_each_vif_active_link(vif, iter, link_id) {
 			struct mt7996_vif_link *link;
 
-			if (link_id == link_conf->link_id)
+			if (link_id == msta_link->wcid.link_id)
 				continue;
 
 			link = mt7996_vif_link(dev, vif, link_id);

-- 
2.53.0



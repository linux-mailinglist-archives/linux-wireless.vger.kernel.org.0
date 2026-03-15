Return-Path: <linux-wireless+bounces-33238-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA1uFY6JtmlmDAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33238-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 11:27:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB9C29066B
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 11:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A98403017028
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 10:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D024A27281E;
	Sun, 15 Mar 2026 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GznWEAom"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2DC26ED41
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773570436; cv=none; b=OFxR1ZPZEt/0lfopDZLPAU4qWjr7oCAEahNMGZhho21dPi1MY5TIfG2212EYxpmdTxaPaAWBv/oXg/BqFwfQOAoH6svR3noaAjkE0V/ihRBDD2QD5ruuFyDRuQmqYQi9hujvmvLyWeUp4txtE7IuH0k1r7SEx+mxeRIcH1u7kb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773570436; c=relaxed/simple;
	bh=F+PGCaeu94wkXm0/Jhhmcj95zbnwqbnLVrkRX5Zg6Q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QxdyvBSQKZXiFo7pNbs3iphajJOdGqFXWvgeeDGBUgpK6lJ0o8NBf0uShcfoS+ADNgSevZAr1s7QUoQcNxDHAbrAqxgpgTZrYiVcSdPgkqyxTCLWg0cP/ZgRsjhCk3J7pNmUsyP7SYXoyQxsun1Ba/kriIbpMgk+yhWCYiNY4x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GznWEAom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BA3C2BC9E;
	Sun, 15 Mar 2026 10:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773570436;
	bh=F+PGCaeu94wkXm0/Jhhmcj95zbnwqbnLVrkRX5Zg6Q0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GznWEAomdnMu1fJPW3iRbpXgKfryRc7LAXNPLr700OxSlqEzouYO5/nZo4/Ifek+F
	 oMW3IWolBe5wms/sO4hxNUaXA3cefzq2FtQv1LzebC33yiXAVeSO+QWz406Jo4lUPm
	 Fn2Ir+g8PXJDI86qPzqik/R4S0xW2AqqUQs8R4lYnmxjf/0fUJgvdm1QSBEE5CuRJo
	 5IOUpNLaXjqHpjRSCVCKgS+t3Dw70UTQIOvoTGIUkjSuVehStQfpzWNbOdMWukeCFy
	 lw4lhNtCUTivcFMxxAj5jYGIpes3XMm4JWFKhLiI5+3MV1qMsKW5H0YJuDWgpQ003k
	 KuFtGCSi1G55Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 15 Mar 2026 11:26:25 +0100
Subject: [PATCH mt76 2/6] wifi: mt76: mt7996: Account active links in
 valid_links fields
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260315-mt7996-mlo-link-reconf-v1-2-a8a634fbc927@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33238-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACB9C29066B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shayne Chen <shayne.chen@mediatek.com>

Track active vif links in mt7996_vif_link_add and mt7996_vif_link_remove
routines.
This is a preliminary patch in order to remove AP MLD links from MCU
configuration during AP tear-down process and to support MLO link
reconfiguration in MT7996 driver.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 52 +++++++++++++-----------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 21a240f0c8c275b9fb5532ff74bbf76b741dac84..07a266f7670c1d6b050e3790ce91cba014b18eab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -367,12 +367,16 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 
 	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, &it);
 
-	if (vif->txq && !mlink->wcid->offchannel &&
-	    mvif->mt76.deflink_id == IEEE80211_LINK_UNSPECIFIED) {
-		struct mt76_txq *mtxq = (struct mt76_txq *)vif->txq->drv_priv;
-
-		mvif->mt76.deflink_id = link_conf->link_id;
-		mtxq->wcid = idx;
+	if (!mlink->wcid->offchannel) {
+		if (vif->txq &&
+		    mvif->mt76.deflink_id == IEEE80211_LINK_UNSPECIFIED) {
+			struct mt76_txq *mtxq;
+
+			mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+			mvif->mt76.deflink_id = link_conf->link_id;
+			mtxq->wcid = idx;
+		}
+		mvif->mt76.valid_links |= BIT(link_conf->link_id);
 	}
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
@@ -419,28 +423,30 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
-	if (vif->txq && !mlink->wcid->offchannel &&
-	    mvif->mt76.deflink_id == link_id) {
-		struct ieee80211_bss_conf *iter;
-		struct mt76_txq *mtxq;
+	if (!mlink->wcid->offchannel) {
+		if (vif->txq && mvif->mt76.deflink_id == link_id) {
+			struct ieee80211_bss_conf *iter;
+			struct mt76_txq *mtxq;
 
-		mvif->mt76.deflink_id = IEEE80211_LINK_UNSPECIFIED;
-		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
-		/* Primary link will be removed, look for a new one */
-		for_each_vif_active_link(vif, iter, link_id) {
-			struct mt7996_vif_link *link;
+			mvif->mt76.deflink_id = IEEE80211_LINK_UNSPECIFIED;
+			mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+			/* Primary link will be removed, look for a new one */
+			for_each_vif_active_link(vif, iter, link_id) {
+				struct mt7996_vif_link *link;
 
-			if (link_id == msta_link->wcid.link_id)
-				continue;
+				if (link_id == msta_link->wcid.link_id)
+					continue;
 
-			link = mt7996_vif_link(dev, vif, link_id);
-			if (!link)
-				continue;
+				link = mt7996_vif_link(dev, vif, link_id);
+				if (!link)
+					continue;
 
-			mtxq->wcid = link->msta_link.wcid.idx;
-			mvif->mt76.deflink_id = link_id;
-			break;
+				mtxq->wcid = link->msta_link.wcid.idx;
+				mvif->mt76.deflink_id = link_id;
+				break;
+			}
 		}
+		mvif->mt76.valid_links &= ~BIT(link_id);
 	}
 
 	dev->mt76.vif_mask &= ~BIT_ULL(mlink->idx);

-- 
2.53.0



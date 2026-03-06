Return-Path: <linux-wireless+bounces-32625-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBVqOy2tqmlTVQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32625-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 11:32:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 693B221EC8D
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 11:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE4C130F9B6E
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 10:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DCB37C0F6;
	Fri,  6 Mar 2026 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtfEIRU+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4483637BE77
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792892; cv=none; b=ndjqFuck7+V1PbpIGL3kbu1l+6z5rCewC1vldkLn7W0n2yUeMHiVBoksafyLox1t+EUK71DIOJL/wXNqM9dLgB1PNfNNed4zQ4Zu+ENTtL39ciHMlax7d3N1Z73BiRKqF6j8cIcqaiAWL7wk+exAILIhtaDA/A2sItPBzzrj/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792892; c=relaxed/simple;
	bh=UX9LotaCII1gNgWF6VT0FK2LBe6LuscZygpKe1U4P9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A2BJMhLIc+8+FIck1hPzvJDKPSULD1epIcgCqgEbWkyCz/5rRdV9pWvAXyUQne2nHrmxO5FzYDsoAoKWIBmuNuiB5y3piFDR4Wzpl4vK23f5QBhFC+5Er+TSt7aoHTQNYXhsqBNPzIEsDc/xIi5l6N1B6ps7ac0WmQgVcOck4hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtfEIRU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE11C2BCB1;
	Fri,  6 Mar 2026 10:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772792891;
	bh=UX9LotaCII1gNgWF6VT0FK2LBe6LuscZygpKe1U4P9o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jtfEIRU+Oa7aPZpI2yKHto/RoaDuZe+on+y4m2sd0FwoxdLGYbK+YXCZz9pNKoSvA
	 E6qGiW44VjTiwvxFmbvFbaJ7FV4n73HLdUb7SFAgSvScN3uTMTRTjk6esBuElpWqbH
	 x/dSftm+owyRqjZMLC4MhqyEBVaz8SUs9S4PMqPW7EiXJJYkPyT9XGs6tjhrUuKfF8
	 lnG5FtGtpKMMaPYfMv1hqDeR3pXFzUOzfnE/qSQlDVUO9/X3VWSjAS9AZSUUWZVyWH
	 aKbuX/sHlVKoFYPm3pn/PxmsOyhzKNqaQLHkvFludMHpScx3YJjY4t87wdG3LFrruU
	 GmFWLENw4aKWw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 06 Mar 2026 11:27:53 +0100
Subject: [PATCH mt76 2/4] wifi: mt76: mt7996: Fix deflink lookup removing
 links
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-mt7996-deflink-lookup-link-remove-v1-2-7162b332873c@kernel.org>
References: <20260306-mt7996-deflink-lookup-link-remove-v1-0-7162b332873c@kernel.org>
In-Reply-To: <20260306-mt7996-deflink-lookup-link-remove-v1-0-7162b332873c@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 693B221EC8D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com];
	TAGGED_FROM(0.00)[bounces-32625-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Do not set vif deflink in mt7996_vif_link_remove routine if the vif txq
pointer is NULL in order to not miss the mtxq wcid field update adding
a new link with a valid vif txq pointer.

Fixes: 2e6bdd40e1d01 ("wifi: mt76: mt7996: Reset mtxq->idx if primary link is removed in mt7996_vif_link_remove()")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 8b1924778cbd6a5f6a516a689a379fb715cc3097..e76643b8234b6323fa53f1f5958e23b5adc99c72 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -405,26 +405,26 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
 
-	if (!mlink->wcid->offchannel &&
+	if (vif->txq && !mlink->wcid->offchannel &&
 	    mvif->mt76.deflink_id == link_conf->link_id) {
 		struct ieee80211_bss_conf *iter;
+		struct mt76_txq *mtxq;
 		unsigned int link_id;
 
-		/* Primary link will be removed, look for a new one */
 		mvif->mt76.deflink_id = IEEE80211_LINK_UNSPECIFIED;
+		mtxq = (struct mt76_txq *)vif->txq->drv_priv;
+		/* Primary link will be removed, look for a new one */
 		for_each_vif_active_link(vif, iter, link_id) {
 			struct mt7996_vif_link *link;
 
+			if (link_id == link_conf->link_id)
+				continue;
+
 			link = mt7996_vif_link(dev, vif, link_id);
 			if (!link)
 				continue;
 
-			if (vif->txq) {
-				struct mt76_txq *mtxq;
-
-				mtxq = (struct mt76_txq *)vif->txq->drv_priv;
-				mtxq->wcid = link->msta_link.wcid.idx;
-			}
+			mtxq->wcid = link->msta_link.wcid.idx;
 			mvif->mt76.deflink_id = link_id;
 			break;
 		}

-- 
2.53.0



Return-Path: <linux-wireless+bounces-32626-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO3zF1CsqmnjVAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32626-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 11:28:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1885621EB2D
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 11:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C15513037D77
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 10:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E1E37C0FF;
	Fri,  6 Mar 2026 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhItWIQY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF9637CD21
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792894; cv=none; b=s44wpd4XN195YjBZaOtLPg2ApatVadN2IhxjjJUeSYooAIHjDyBqHf+yWI/5lsNYZQUSDuYIOS+e2bJfhkI2Nq2cxhByxCF/en1/GSUAOnQqujwfvEPrrUPw1BNA9HsOtKO06038yrIRKsmn2qjJTnThYM81AqyjtjHxpdN/6Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792894; c=relaxed/simple;
	bh=vtJahmgdlmSsLBAyraoFWgIJCZdL41zKKCGfsFhC39U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FbPv855GIQz+NqZ4kitG9NYux62XkcJbhb97vEbA8jqKgjg2fiDxgoDsGt2flMyq8GMTrWAsp+gmrrqHPm4ozVKQAosVNiFqd6cIjI5F5ucFEG0c4P+mqdLoDWrJ3BeRqfm+vNgmCxtP774jPapQPginrMAIJQH95YiAg/U2wA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhItWIQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081FFC4CEF7;
	Fri,  6 Mar 2026 10:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772792894;
	bh=vtJahmgdlmSsLBAyraoFWgIJCZdL41zKKCGfsFhC39U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KhItWIQYBrQBGK9rvdDy62BEDEJ5JBax4GjKo8Rf/VSMy3V9DB0V8FwXG/END8llW
	 ngi6Lt0GeDDgZOkjTVB2les+/F4/YjEOesdhfbZmEyoXjFNVXR1U+342Y4wAyWRikk
	 lS6Xb595gPOrF1oIN653eKaLfsCAhTp8oBLlvkOMn2lV4WCTdi1PGHe8iXW0E+1Xvt
	 tBLHW3kHjddvNRj3eFndQtzrY0uYYVH67oUbyODIEGSGvxf0QmbtcTLWXomCtjh+gi
	 F+jzH/icqqOyWADJJEZYVnjTXRuLKrRk+QtMjOQSqMAnamdC3ydYh+EpEAUEUlmdv2
	 oLQtKk4jE3T2w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 06 Mar 2026 11:27:54 +0100
Subject: [PATCH mt76 3/4] wifi: mt76: mt7996: Fix deflink lookup adding
 links
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-mt7996-deflink-lookup-link-remove-v1-3-7162b332873c@kernel.org>
References: <20260306-mt7996-deflink-lookup-link-remove-v1-0-7162b332873c@kernel.org>
In-Reply-To: <20260306-mt7996-deflink-lookup-link-remove-v1-0-7162b332873c@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 1885621EB2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com];
	TAGGED_FROM(0.00)[bounces-32626-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Do not set vif deflink in mt7996_vif_link_add routine if the vif txq
pointer is NULL in order to not miss the mtxq wcid field update adding
a new link with a valid vif txq pointer.

Fixes: b25fd88d7133d ("wifi: mt76: mt7996: Set mtxq->wcid just for primary link")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index e76643b8234b6323fa53f1f5958e23b5adc99c72..b659d173268981f25344be4b3176a1e7636db7a4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -365,15 +365,12 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 
 	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, &it);
 
-	if (!mlink->wcid->offchannel &&
+	if (vif->txq && !mlink->wcid->offchannel &&
 	    mvif->mt76.deflink_id == IEEE80211_LINK_UNSPECIFIED) {
-		if (vif->txq) {
-			struct mt76_txq *mtxq;
+		struct mt76_txq *mtxq = (struct mt76_txq *)vif->txq->drv_priv;
 
-			mtxq = (struct mt76_txq *)vif->txq->drv_priv;
-			mtxq->wcid = idx;
-		}
 		mvif->mt76.deflink_id = link_conf->link_id;
+		mtxq->wcid = idx;
 	}
 
 	return 0;

-- 
2.53.0



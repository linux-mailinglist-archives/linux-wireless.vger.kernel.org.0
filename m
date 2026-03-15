Return-Path: <linux-wireless+bounces-33239-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAuUEZSJtmlmDAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33239-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 11:27:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB80329067A
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 11:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0181A301B921
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 10:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D5326ED41;
	Sun, 15 Mar 2026 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="co/+Xtx7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D4422068D
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773570439; cv=none; b=Tu1YaR065lN+DnPOlfyg1Ou+T9NLML1jptsJB5a+eYyHB/FFJuvwjIN6HceWGYyTkNtitnoXdEP40bWKWgRUwX9mk4rx/AUgALKTpVQxVQF5rDvwAxNhtKuCwiPagF4F5LcWFuSzybLxde9FsTfH3j9c6zc7M2P13+uoCoECxTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773570439; c=relaxed/simple;
	bh=QxnZNiTp0ScmumG7Zz7nuHt9/R4db5LB3gmyfj4jlho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oix4LsgSqmc3Z6kGGqmuiPeePf+aDKSMOB+BUzIs5bBo2tnthz2BfCu7aM0MxHL24uLN9sPzaMK9leePcZKlrrR59AP6pFZpogYnv2llih/k7UZVHkQV+ntBTjiVgs4fi2vhCVsnqxkFjf7i4TA6Pn3iwvPpoWcZJhvp5Kkttcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=co/+Xtx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44D4C2BCB0;
	Sun, 15 Mar 2026 10:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773570439;
	bh=QxnZNiTp0ScmumG7Zz7nuHt9/R4db5LB3gmyfj4jlho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=co/+Xtx7Z4CZOv7BHwB/J2/Jk/CHJjP+EEiS5fau8qkfnwdesoXuCcrX6dY68ivZg
	 v21XzDRF2oIU7F6Rm7EuBgZaK9wZEjo1qAghK4W1qmdw+foXZC4Pdg4/1rcHYeHSrA
	 B7V/EUfzvFfE7QqX3nMtBMlHTgYhpJTUA0d1WCUZQxdIOyVnjtwBeLvVvXV5j+OA1t
	 e7BG4OWXj6I91Lldc72QssnGJMOn+qRVDn+SLyTYaxuTS8y7wD5X0lkutt3cXU2cn5
	 2gGjknjwkEJpQd5adLbv+WeqrO73hWJjfsaP0RQpFamCZFKi4Y83iPzD2kdIEJF/DY
	 1bxxemwwZPBFw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 15 Mar 2026 11:26:26 +0100
Subject: [PATCH mt76 3/6] wifi: mt76: mt7996: Move mlink deallocation in
 mt7996_vif_link_remove()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260315-mt7996-mlo-link-reconf-v1-3-a8a634fbc927@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-33239-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: DB80329067A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shayne Chen <shayne.chen@mediatek.com>

Destroy mt76_vif_link struct in mt7996_vif_link_remove routine and not
in mt76_unassign_vif_chanctx(). This is necessary since, in order to
properly support MLO link reconfiguration, we will destroy mt76_vif_link
struct during AP tear-down process and not running unassign_vif_chanctx
mac80211 callback.
This patch does not introduce any regression since
mt76_assign_vif_chanctx/mt76_unassign_vif_chanctx APIs are currently
used just by MT7996 driver.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/channel.c     | 9 ---------
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 6 ++++++
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/channel.c b/drivers/net/wireless/mediatek/mt76/channel.c
index cf3fc09e5d5a87c8c67b7694f986180964c72799..05eee64706ea87f9f19acc103354939c66b767cb 100644
--- a/drivers/net/wireless/mediatek/mt76/channel.c
+++ b/drivers/net/wireless/mediatek/mt76/channel.c
@@ -158,8 +158,6 @@ void mt76_unassign_vif_chanctx(struct ieee80211_hw *hw,
 {
 	struct mt76_chanctx *ctx = (struct mt76_chanctx *)conf->drv_priv;
 	struct mt76_vif_link *mlink = (struct mt76_vif_link *)vif->drv_priv;
-	struct mt76_vif_data *mvif = mlink->mvif;
-	int link_id = link_conf->link_id;
 	struct mt76_phy *phy = ctx->phy;
 	struct mt76_dev *dev = phy->dev;
 
@@ -176,15 +174,8 @@ void mt76_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	if (!mlink)
 		goto out;
 
-	if (mlink != (struct mt76_vif_link *)vif->drv_priv)
-		rcu_assign_pointer(mvif->link[link_id], NULL);
-
 	dev->drv->vif_link_remove(phy, vif, link_conf, mlink);
 	mlink->ctx = NULL;
-
-	if (mlink != (struct mt76_vif_link *)vif->drv_priv)
-		kfree_rcu(mlink, rcu_head);
-
 out:
 	mutex_unlock(&dev->mutex);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 07a266f7670c1d6b050e3790ce91cba014b18eab..feee93340a6c691d38858230a5f05627aac1c07f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -459,6 +459,12 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
 	mt76_wcid_cleanup(&dev->mt76, &msta_link->wcid);
+
+	if (mlink != (struct mt76_vif_link *)vif->drv_priv &&
+	    !mlink->wcid->offchannel) {
+		rcu_assign_pointer(mlink->mvif->link[link_id], NULL);
+		kfree_rcu(mlink, rcu_head);
+	}
 }
 
 static void mt7996_phy_set_rxfilter(struct mt7996_phy *phy)

-- 
2.53.0



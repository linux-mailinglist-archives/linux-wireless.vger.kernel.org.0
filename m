Return-Path: <linux-wireless+bounces-32718-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNGSONd4rWlj3QEAu9opvQ
	(envelope-from <linux-wireless+bounces-32718-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 08 Mar 2026 14:25:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 838EC2306A7
	for <lists+linux-wireless@lfdr.de>; Sun, 08 Mar 2026 14:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D867B300612C
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2026 13:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B808A26A1AF;
	Sun,  8 Mar 2026 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asPYyX08"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CFC17A2F6
	for <linux-wireless@vger.kernel.org>; Sun,  8 Mar 2026 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772976338; cv=none; b=uod4ozNIclfLWL7KQUu1O7oDwWDkxqlDBnwIWRIPikyMTY6c3NDbTRMXV35bF8KG9CAfAUgZEpWvpkFlBZzJbP3P35tHyoKAXRDo5pugBaSKx9ZRnuA/S4Vgvjq+5sOPEvn4MslZ09N5TtXXTFcTvh8klwzbULKLxJbxxvS4n3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772976338; c=relaxed/simple;
	bh=td/5Za+N+HHAJ/2WojWGJFdEXrRuLM/SqKZCZyaAjA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jxPBB/v9ComI2Fm7q4L6FWrG+ZJQYTaBviCyLrBj8mIOl9+A74Z3VKXUZoDM55/VhjCF9TpqFgpHUkGgIR4jrsk4gipqxf4xWRGruu6XwfHKMJoG1RGWRQn3PqdqFb9PTzMD3lwbbPKC+ZSNQWz22Mrr0zCqP3mNRr/lk+tc4S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asPYyX08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A154C116C6;
	Sun,  8 Mar 2026 13:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772976338;
	bh=td/5Za+N+HHAJ/2WojWGJFdEXrRuLM/SqKZCZyaAjA0=;
	h=From:Date:Subject:To:Cc:From;
	b=asPYyX08YKLuNZTvEcOL++nLkGAONi5kqwbfiyxe2ifrdpTmGMyx84HqVn8UF32nR
	 KqivguLOWTL7z7VHWFMce9QVeMcYmVjAP2ksRUm0/PHOw3y8hQ05KoSe6Yz3cZt/L4
	 e4wO3L/dsP4xN4aMhmf3QtJlOie4x/PXQy57qleJ68ThbuW3djKP2oGkNl60rDB8+w
	 fZ+XMR8mDWVgEgAzmfRnQtcMxYvdsWhl5lp+qQ2I+7vxzS6tGdonYsidpiWFsZGKc2
	 wQxBwzJ4JIVabLwtiyvwO9YZXC4hwXnyF8AE/jAWTWpvntVAB5F89k4Zq6rs9KBSe1
	 7rS1L32N2U8+g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 08 Mar 2026 14:25:20 +0100
Subject: [PATCH mt76] wifi: mmt76: mt7996: Decrement sta counter removing
 the link in mt7996_mac_reset_sta_iter()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260308-mt7996_mac_reset_vif_iter-fix-v1-1-57f640aa2dcf@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrBuIU9CkVyklBP2js4gtkyCCe
 PcGl99bvJMKVFDo1Z2k2KXId2voHx1Na9wWGJmbiS0P9mmdyXX0fgg5TkFRUMMuKUiFmiSHYQc
 eObrUW1B7/BQt3//357r+IcBLiG8AAAA=
X-Change-ID: 20260308-mt7996_mac_reset_vif_iter-fix-28e272a8f10e
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 838EC2306A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com];
	TAGGED_FROM(0.00)[bounces-32718-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.959];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Decrement the phy station counter  in mt7996_mac_reset_sta_iter routine
destroying the station link.

Fixes: ace5d3b6b49e8 ("wifi: mt76: mt7996: improve hardware restart reliability")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index a415cc610eeec8cb160aeac8219f421742d75bad..6591c07a147a5fdce7a8f7ff13da7f9eb136b002 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2361,6 +2361,7 @@ mt7996_mac_reset_sta_iter(void *data, struct ieee80211_sta *sta)
 
 	for (i = 0; i < ARRAY_SIZE(msta->link); i++) {
 		struct mt7996_sta_link *msta_link = NULL;
+		struct mt7996_phy *phy;
 
 		msta_link = rcu_replace_pointer(msta->link[i], msta_link,
 						lockdep_is_held(&dev->mt76.mutex));
@@ -2368,6 +2369,10 @@ mt7996_mac_reset_sta_iter(void *data, struct ieee80211_sta *sta)
 			continue;
 
 		mt7996_mac_sta_deinit_link(dev, msta_link);
+		phy = __mt7996_phy(dev, msta_link->wcid.phy_idx);
+		if (phy)
+			phy->mt76->num_sta--;
+
 		if (msta_link != &msta->deflink)
 			kfree_rcu(msta_link, rcu_head);
 	}

---
base-commit: 030eea77accf40477be540445fc5a5be52d810a3
change-id: 20260308-mt7996_mac_reset_vif_iter-fix-28e272a8f10e

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>



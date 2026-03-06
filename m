Return-Path: <linux-wireless+bounces-32624-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLgJICGtqmlTVQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32624-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 11:32:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC3D21EC7D
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 11:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 673C730F05CE
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 10:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B709037C0F6;
	Fri,  6 Mar 2026 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPoW2XPf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942FB37CD38
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792889; cv=none; b=HId11odqFSvJ0DozQXI2fijTnkDVKw25UQ1+jd9RdS19qjN4OkUXq6ZOh3Ig6CvzjjKIaCQv+xFwVtQhCE2Bu6BgGugUn7AUTC5tdAs0YoR6GkOceXtgP/gx8Ix8svPS3tkp5OTaQgJja0zmWt6o153PssnBktMGc7XJnM1z5TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792889; c=relaxed/simple;
	bh=DfxFRRvPfhsfQekJ9GLERkWUaEHye6HnGlGQsfd+/V8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aIytWqigmQ5wJrih09+k6YUI/TXeMyok/afyHKfqKLsMCJjFMDCc2lZR8Tobbo0IiAoA2wj/fqoBrFRrHs3EEO5uWIEkpWOZGLvuCwZFPEanNQRyeti77qrGd+7yyH4OApyupcvW1/ikkc+B2rCFRokCfIuxTHG0uj2+GyAxOZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPoW2XPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB75C2BCB1;
	Fri,  6 Mar 2026 10:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772792889;
	bh=DfxFRRvPfhsfQekJ9GLERkWUaEHye6HnGlGQsfd+/V8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YPoW2XPf8zryedbEvnXEY1z3Rkui1Mq76bYQ2+IMZQcDKEsiJVJamhfm21QsVf38/
	 t8kg4XbI7a0Syith6574h3OK5YDJEZlDy701+OBzVb+L3ONBO4g8vWelMY1+EdUk6z
	 WgzSUC1TCN4nFbYwzSGIoX7N9TsEiMXyxrLF5jy7lNeh1L0Jsq5xIuOHpmC83Qt11r
	 5dwv3iL8bKC1Cb89I4vqxsUH7jL6pIyD9Cd0b2PcnqQTwoansUOf8Cg8M2mSVW+P7Z
	 bQql6RKqsP6Sbhb43I2bTgDzcs2E5OqKwH1ZzHRa8HuMke2Ia+3Gcx8zNpfvlPNB87
	 WqVj3jCMKWgLg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 06 Mar 2026 11:27:52 +0100
Subject: [PATCH mt76 1/4] wifi: mt76: mt7996: Remove link pointer
 dependency in mt7996_mac_sta_remove_links()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-mt7996-deflink-lookup-link-remove-v1-1-7162b332873c@kernel.org>
References: <20260306-mt7996-deflink-lookup-link-remove-v1-0-7162b332873c@kernel.org>
In-Reply-To: <20260306-mt7996-deflink-lookup-link-remove-v1-0-7162b332873c@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 1FC3D21EC7D
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
	TAGGED_FROM(0.00)[bounces-32624-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Remove link pointer dependency in mt7996_mac_sta_remove_links routine to
get the mt7996_phy pointer since the link can be already offchannel
running mt7996_mac_sta_remove_links(). Rely on __mt7996_phy routine
instead.

Fixes: 344dd6a4c919 ("wifi: mt76: mt7996: Move num_sta accounting in mt7996_mac_sta_{add,remove}_links")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index e1e51c9a0767be5a15dae48d627fb45b6f12af21..8b1924778cbd6a5f6a516a689a379fb715cc3097 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1100,8 +1100,7 @@ mt7996_mac_sta_remove_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 
 	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct mt7996_sta_link *msta_link = NULL;
-		struct mt7996_vif_link *link;
-		struct mt76_phy *mphy;
+		struct mt7996_phy *phy;
 
 		msta_link = rcu_replace_pointer(msta->link[link_id], msta_link,
 						lockdep_is_held(&mdev->mutex));
@@ -1110,17 +1109,12 @@ mt7996_mac_sta_remove_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 
 		mt7996_mac_wtbl_update(dev, msta_link->wcid.idx,
 				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
-
 		mt7996_mac_sta_deinit_link(dev, msta_link);
-		link = mt7996_vif_link(dev, vif, link_id);
-		if (!link)
-			continue;
 
-		mphy = mt76_vif_link_phy(&link->mt76);
-		if (!mphy)
-			continue;
+		phy = __mt7996_phy(dev, msta_link->wcid.phy_idx);
+		if (phy)
+			phy->mt76->num_sta--;
 
-		mphy->num_sta--;
 		if (msta->deflink_id == link_id) {
 			if (msta->seclink_id == msta->deflink_id) {
 				/* no secondary link available */

-- 
2.53.0



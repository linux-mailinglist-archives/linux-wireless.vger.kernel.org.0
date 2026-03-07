Return-Path: <linux-wireless+bounces-32712-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EGVKz0vrGlUmgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32712-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 14:59:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FB822C028
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 14:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DE523014C0A
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2026 13:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02BA2D4813;
	Sat,  7 Mar 2026 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0DsEfh7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD513280CE5
	for <linux-wireless@vger.kernel.org>; Sat,  7 Mar 2026 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772891962; cv=none; b=Tx0a9W4/+cbMteNcLtUMGC9cgPnJG3kR7P56gVmkbbBh3Kn8J+lOl+H8Z1er94BBkqJutG/5uk5riQqYWzxsG8bJ+whMf2h53YCtJLDZEjyo7v45LA1I3pjoWrwhtSAOomqqF8VxFpOQI2hjQsP9lOLpONngXO4zPcugK/N41SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772891962; c=relaxed/simple;
	bh=17VMiHgUST28gqV1LVY05XoOYBeoqqpg16VhStBb1bQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=K5fs4bp2QUoj9IRuCnYs6s3qG5UZUtFL6Y/3jKHr1siL5//h3Y0XIbN+f83B58+9WhFVw8H0TnWLusH6JyL0l90QaRTDF3JSeXOYQT/t1leTFC+iMQscpxZbIiPSxGKeqWKG0zG9TIF8iodjOI5I4I8uHwmA0lhTvsW6TiT2jfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0DsEfh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A85C19422;
	Sat,  7 Mar 2026 13:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772891962;
	bh=17VMiHgUST28gqV1LVY05XoOYBeoqqpg16VhStBb1bQ=;
	h=From:Date:Subject:To:Cc:From;
	b=V0DsEfh7iMNnVVZG5fBUfZPwhwBeo2F7G9lKiy9lspZa2n/Lm1VGVTGp8bg5fmK2t
	 h1KMOwpjzdmlaWQiY7zDW5gc1wjmeXZCw2viVCsU23nxdUwnQVb2qWyY2vxkc8fA7k
	 4NGVCu26Qoz67WVzjk4oqODuvkgRWU9FQ0y2iY3oMksvB0M6sIBOqLBqMZmgOd41/o
	 t+Vp5iNyv2sPbT2QX88JS+FGlqgISYAeM/+sdYet2ZJJWsFT1hpBjajVRrfhoAujPK
	 I7aInXZ7QUsufmG+cbbh6C0X82N6v67TaP7hwAnthn0+TxayNmjEEGtGHwF1PVchaA
	 w+gNxl8LwMrTA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 07 Mar 2026 14:59:12 +0100
Subject: [PATCH mt76] wifi: mt76: mt7996: Switch deflink to seclink only if
 link lookup does not fail
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260307-mt7996-sta-sec-link-fix-v1-1-d9c4ed7a85d8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAvyI5G6hbS/2KeFAbNahVGhFB/LvF4
 wzMPCAUmATq5IFAFwvvPkKWJjDMnZ8I2UWGXOVaFcrgdhprNcrZodCAK/sFR77ROO1KS5WmvoR
 YH4Gi/s9N+74fZkvNxWkAAAA=
X-Change-ID: 20260307-mt7996-sta-sec-link-fix-7d6d49e56eb4
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 04FB822C028
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32712-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Do not switch default link to the secondary link in
mt7996_mac_sta_remove_links routine if the lookup for the secondary
msta_link fails.

Fixes: d7e5444f9eb02 ("wifi: mt76: mt7996: Switch to the secondary link if the default one is removed")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index e1e51c9a0767be5a15dae48d627fb45b6f12af21..00e0e5915afe32b70205f1128f32a07ac02223e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1122,21 +1122,22 @@ mt7996_mac_sta_remove_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 
 		mphy->num_sta--;
 		if (msta->deflink_id == link_id) {
-			if (msta->seclink_id == msta->deflink_id) {
+			msta->deflink_id = IEEE80211_LINK_UNSPECIFIED;
+			if (msta->seclink_id == link_id) {
 				/* no secondary link available */
-				msta->deflink_id = IEEE80211_LINK_UNSPECIFIED;
 				msta->seclink_id = msta->deflink_id;
 			} else {
 				struct mt7996_sta_link *msta_seclink;
 
 				/* switch to the secondary link */
-				msta->deflink_id = msta->seclink_id;
 				msta_seclink = mt76_dereference(
 						msta->link[msta->seclink_id],
 						mdev);
-				if (msta_seclink)
+				if (msta_seclink) {
+					msta->deflink_id = msta->seclink_id;
 					mt7996_sta_init_txq_wcid(sta,
 						msta_seclink->wcid.idx);
+				}
 			}
 		} else if (msta->seclink_id == link_id) {
 			msta->seclink_id = msta->deflink_id;

---
base-commit: 030eea77accf40477be540445fc5a5be52d810a3
change-id: 20260307-mt7996-sta-sec-link-fix-7d6d49e56eb4

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>



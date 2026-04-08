Return-Path: <linux-wireless+bounces-34526-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIdbDGdr1mnlFAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34526-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 16:51:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ADF3BDDFF
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 16:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DABAF3010159
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBC03D3D03;
	Wed,  8 Apr 2026 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="QX5ySKON"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D4B3B0ADF
	for <linux-wireless@vger.kernel.org>; Wed,  8 Apr 2026 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775659876; cv=none; b=mVthRLeig1GiB+CBVJmPkxca7Y5AEscQj55NkThMrmfGROWpjf5tBKQ+3dOSg6kKMvaZt+feETLSETpI8bKU11MX0UhEhfC8YqxtbTsMtfrnedsF/1emF1DW6cOUk2nLp8lDCrP+nfDILlu38WMVU8LebCU+vpdcJ9dSCdz1zdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775659876; c=relaxed/simple;
	bh=p6+WR1yRP1bBZ0J922wW9hnqgkIK9VdJ6RdpHjKvhlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YUXx8UW7pSalyWAnA7CA/qwfKHOmYctAUe3/JQ6ZEwocOj/v+d/t/LC6QOCr67leiL0GC6z7NQSRIGbRN+q9gYM5AYslnIwg807Cmg/1ZHZfCfSUyj6z2Y55n8NIFFQtaaO/BPdZ0HpeE0cjeG/nSWP6NzThwYeXIXcmXDw+byU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=QX5ySKON; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7F3BFAC0070;
	Wed,  8 Apr 2026 14:51:10 +0000 (UTC)
Received: from pk3.candelatech.com (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id DBBEA13C2B0;
	Wed,  8 Apr 2026 07:51:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com DBBEA13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1775659868;
	bh=p6+WR1yRP1bBZ0J922wW9hnqgkIK9VdJ6RdpHjKvhlU=;
	h=From:To:Cc:Subject:Date:From;
	b=QX5ySKONDleBZsI0AI9lJrnt+fcJk32LJa/M3EAK2LVriQ31njxdvfnJDs4XdQmzF
	 Umgofa4NIivj0FGlv5bgbq1FoMEPieUmXDpv5tBpb0ZIX6BQZnLzk9JoarlRhoLZXw
	 2DfSUrdTXNbYoya/m3ELi9Wy3UWAOKJqAwDzQyRI=
From: dylan.eskew@candelatech.com
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: linux-wireless@vger.kernel.org,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	Dylan Eskew <dylan.eskew@candelatech.com>
Subject: [PATCH mt76 v2] wifi: mt76: mt7996: limit work in set_bitrate_mask
Date: Wed,  8 Apr 2026 07:50:58 -0700
Message-ID: <20260408145057.2356878-2-dylan.eskew@candelatech.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1775659871-kLMHfdP9ZwGg
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1775659871;kLMHfdP9ZwGg;<dylan.eskew@candelatech.com>;f49eb8a899f4a60c9b856bf22a60d609
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dylan.eskew@candelatech.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34526-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,candelatech.com:dkim,candelatech.com:email,candelatech.com:mid]
X-Rspamd-Queue-Id: 82ADF3BDDFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dylan Eskew <dylan.eskew@candelatech.com>

Calls to mt7996_set_bitrate_mask() would propagate work for all stations
on the ieee80211_hw regardless of the vif specified in the call. To
prevent unnecessary work in FW, limit setting the sta_rate to only the
specified vif in mt7996_sta_rate_ctrl_update().

Fixes: afff4325548f0 ("wifi: mt76: mt7996: Use proper link_id in link_sta_rc_update callback")
Signed-off-by: Dylan Eskew <dylan.eskew@candelatech.com>
---
v2:
  - Assign to correct tree
  - Fix spelling error in commit message
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index a8a6552d49f6..26b8c91db0a8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1959,7 +1959,11 @@ static void mt7996_sta_rate_ctrl_update(void *data, struct ieee80211_sta *sta)
 {
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct mt7996_sta_link *msta_link;
-	u32 *changed = data;
+	struct mt7996_vif *mvif = data;
+	u32 changed = IEEE80211_RC_SUPP_RATES_CHANGED;
+
+	if (msta->vif != mvif)
+		return;
 
 	msta_link = rcu_dereference(msta->link[msta->deflink_id]);
 	if (msta_link)
@@ -1972,7 +1976,6 @@ mt7996_set_bitrate_mask(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	u32 changed = IEEE80211_RC_SUPP_RATES_CHANGED;
 
 	mvif->deflink.bitrate_mask = *mask;
 
@@ -1985,7 +1988,7 @@ mt7996_set_bitrate_mask(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	 * then multiple MCS setting (MCS 4,5,6) is not supported.
 	 */
 	ieee80211_iterate_stations_atomic(hw, mt7996_sta_rate_ctrl_update,
-					  &changed);
+					  mvif);
 	ieee80211_queue_work(hw, &dev->rc_work);
 
 	return 0;
-- 
2.52.0



Return-Path: <linux-wireless+bounces-35291-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZaiPNR/i7GlvdQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35291-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 17:47:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 132B5466C94
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 17:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24C3D3009F94
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 15:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD5914F70;
	Sat, 25 Apr 2026 15:47:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6936282F2F
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777132060; cv=none; b=dBIJmCiWgjU+SPlOEGIXhwEKrUTHFwKPIJw8nwWMmFMPrxFLkwcpLXHe7Bqp0ysLn42alu7z6kmO67ZdjDg9zvF4j1R9vkIvswdGBTQxG5BkSD9zcJcq24XZWRgiXgpT8AdiUrMBVKHM7TVYr2tL6WuE/62VtLpr5UPZa5aXZBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777132060; c=relaxed/simple;
	bh=1fS5zOSqKqHJ7UBAiNDcq4TooscAKVkwKkoemvIqAmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KKm3yodp4SWJECWzAi+I6paXme8Dh9G0+4rwNYr5OVv1I6rs6JSkOO8sz611f3DAISdQ1FY5tn85WklDLYCXvXS123IM9VXWnZHSf8MHynUxGE+VYGvE+jlZ29JnaCmO8Mw0D65WJVSarEhSF8pXMHJiUQ45bLexjYhDRSLf5+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6948b5b1c53so3810326eaf.1
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 08:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777132058; x=1777736858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6d/GYUeSuSfXW+Ex6x7Idrw1Ep1oXeXemdte9T+WrE=;
        b=CY0yTnhL33oLQqy5RarU2/Kg6u1i7+M3s86+h9uPpPb+WIA6HKMv0nAoIoOpUyWX3Y
         2qGvSQ3aySMYFg5xi4fkovOPrUvz5jn/3/65cFp0bbr0ecqQbHOjDBvEw0GNjvYwyicb
         0Jkb6sVlYa+eis5fbk2JDuj0w9RreAzjVR+AL069Aexfdw0+jQFvv3TJJY4za7IFR2EA
         bPzK+NpHM4SFxwQ7TpukOaU3mUPVW8qlylDDBSM9ACMJkEegHf1/JGwfRYIhRXMLkHjA
         HZbzrkw3MMMM4bdAfKEDmr8GeK2FaiK5+YM5PagE0LDlbXAdQNJ1LfZSET23Q/4gYivK
         HVhg==
X-Gm-Message-State: AOJu0Yz38SnxThn+VPALY8tFoT/r21ayBPTQizt62l+kaSJsCuFeBEnf
	yUvubWycNZToPGoN/s8DdR7CT2S3jRY731z49P1gPHv4FXjkBifHNc13
X-Gm-Gg: AeBDieucpMd3eXpxzRTNb6IZlgng+j8Syvgj5sEOccZNJZzaxWy2Whi1i1/b1iDp158
	OmGlBqzKMWt2IcFXuA5lCW6WCqaAbM398O2SaKjiTfNR2UzMJdv1HnqcNR8X+6eQVcOWzwhWN+7
	3l0T6dOpQFKWEbjEu1n1Fucvj8LHMFb9Z5W2VOydzlSol/wiGvv1lczd6VQYy+K4DO96RQ8F5xh
	dFJjzkxP+rkJmuXmvbiOkRiobVh2J3NK/nzLVG9zeopoZ0IoEy8LeHS0+HDliF7bqJButDAiVwg
	Cgh2G451yLNKz/xnhwTT9fAIGLrzEYMdt/KKU4IL2UtzYloOb+AXfbJvp7EXhy9s8jh4gfmO8bl
	7pqK+CMcjHgTWou9JvsXR8Hdu06iM1EgMvEHUX3c+JMJVJ+/9avN7Icd7joFYTXTfZq9634Zddr
	B0p5Q/MqXQNiturTOaTTax3lQIdnytfNHqX8oxelMZEOddlStv6lHXO1MODvPH78d70A6BtrC1i
	w==
X-Received: by 2002:a05:6820:189a:b0:694:8f18:ccd3 with SMTP id 006d021491bc7-6948f18cf50mr14123914eaf.3.1777132057826;
        Sat, 25 Apr 2026 08:47:37 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:9f96:11d3:5f6c:5582])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69493183021sm10094808eaf.13.2026.04.25.08.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 08:47:36 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	Yao Ting Hsieh <yao-ting.hsieh@mediatek.com>
Subject: [PATCH 1/3] wifi: mt76: mt7925: keep TX BA state in the primary WCID
Date: Sat, 25 Apr 2026 10:47:19 -0500
Message-ID: <20260425154721.738101-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 132B5466C94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-35291-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org]

From: Sean Wang <sean.wang@mediatek.com>

For MLO, the same TID can run over different links. Keeping TX BA state in
a link WCID makes the state depend on which link starts aggregation first.

Store it in the primary WCID instead, so the BA state stays stable across
links.

Fixes: 44eb173bdd4f ("wifi: mt76: mt7925: add link handling in mt7925_txwi_free")
Tested-by: Yao Ting Hsieh <yao-ting.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index c47bd812b66b..f025c0efeda2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -841,7 +841,6 @@ static void mt7925_tx_check_aggr(struct ieee80211_sta *sta, struct sk_buff *skb,
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_link_sta *link_sta;
-	struct mt792x_link_sta *mlink;
 	struct mt792x_sta *msta;
 	bool is_8023;
 	u16 fc, tid;
@@ -880,14 +879,14 @@ static void mt7925_tx_check_aggr(struct ieee80211_sta *sta, struct sk_buff *skb,
 
 	msta = (struct mt792x_sta *)sta->drv_priv;
 
-	if (sta->mlo && msta->deflink_id != IEEE80211_LINK_UNSPECIFIED)
-		mlink = rcu_dereference(msta->link[msta->deflink_id]);
-	else
-		mlink = &msta->deflink;
-
-	if (!test_and_set_bit(tid, &mlink->wcid.ampdu_state)) {
+	/* Packets belonging to the same TID can be transmitted over multiple
+	 * links. Keep the TX BA session state in the primary link so all links
+	 * share the same AMPDU bookkeeping.
+	 */
+	if (!test_and_set_bit(tid, &msta->deflink.wcid.ampdu_state)) {
 		if (ieee80211_start_tx_ba_session(sta, tid, 0))
-			clear_bit(tid, &mlink->wcid.ampdu_state);
+			clear_bit(tid, &msta->deflink.wcid.ampdu_state);
+
 	}
 }
 

base-commit: e8c819df02436f2c2379766946735e1f06a7c923
-- 
2.43.0



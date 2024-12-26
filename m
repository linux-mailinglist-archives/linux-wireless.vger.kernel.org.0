Return-Path: <linux-wireless+bounces-16821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB559FCC19
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 18:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD73162B06
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 17:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7B2136347;
	Thu, 26 Dec 2024 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="UXvT/JNF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C3442AAB;
	Thu, 26 Dec 2024 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735232484; cv=none; b=GkKKVVgS0oLzGurM9hQKBljCCBNON21UHr7mPQfvwovTuxchWB/XOnCEaN/FyU52ab9BcWK6SdKLepSKgdlhmmN9fLwaaZWWjwKC7KkcgMTgXeHxv+XurkV7WqN3iYGR/veD25nvCK+czf+P9Lo+ccviNd6DQyZKw7+MpSxODKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735232484; c=relaxed/simple;
	bh=MjmgGObpmg9indjvYQ8v7pO1rUcXreLr97S5dlVM6Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BcZZqnsB9KkhVZI3oJ8bRzU0Q74JUZ0S0HU74fcdjhdvOrwNDp3FtZ0PB7W2KZSETnug/fSB+qIF7xxUNPKrWXzEdJHy7RMlg6jrFiGyifz3GiwgqqdfBpka1sPPh/xS0CnFXOZ4dxbwAxkZB6PMnRHEnMudawefKWkcNSbb9EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=UXvT/JNF; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=DgOoS1t4iGpMVUlhKRY8SEJEpaN05HzuLviTJNUC8yk=; b=UXvT/JNF28yDvNGr
	/5H5kJJGCdqx5yg/Xha+QRSyq7qMqc3BNq6Z5oCrA3V6rqdC3euzaIboTC1S0IyB0ugFSWzgmn6z0
	grJN2KayxRqjkyn1Cui9/83wd6CVXUu7+Nj92/vpMB2be0VSGCqnMxso4bLTmTMVaMUThFXXTWf/u
	Y9hCPByYSoy81I95q5E0uN7aKCeA0sNSYgGzKTX/fYjaaOW6PPfBZ3tqiontyZiz/3OzvE0x7XxO8
	6ZIQNneqyeAsjQgau8cV3oRBfndPS2f00UfkcO4AcYrnWHs5Jz2LrKvfWvLV/1ky8UvhGvH1AkLC2
	C27DYV4IlbtnEE1SFg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tQrEe-007Igh-0x;
	Thu, 26 Dec 2024 17:01:20 +0000
From: linux@treblig.org
To: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] wifi: mac80211: Remove unused ieee80211_smps_is_restrictive
Date: Thu, 26 Dec 2024 17:01:19 +0000
Message-ID: <20241226170119.108947-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of ieee80211_smps_is_restrictive() was removed in 2020 by
commit 52b4810bed83 ("mac80211: Remove support for changing AP SMPS mode")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---

Note: this is ontop of the pair of mac80211 I sent a couple of days
ago.

 net/mac80211/ieee80211_i.h |  2 --
 net/mac80211/util.c        | 25 -------------------------
 2 files changed, 27 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9f0db39b28ff..7b9aeec22a93 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2109,8 +2109,6 @@ void ieee80211_send_delba(struct ieee80211_sub_if_data *sdata,
 int ieee80211_send_smps_action(struct ieee80211_sub_if_data *sdata,
 			       enum ieee80211_smps_mode smps, const u8 *da,
 			       const u8 *bssid, int link_id);
-bool ieee80211_smps_is_restrictive(enum ieee80211_smps_mode smps_mode_old,
-				   enum ieee80211_smps_mode smps_mode_new);
 void ieee80211_add_addbaext(struct sk_buff *skb,
 			    const u8 req_addba_ext_data,
 			    u16 buf_size);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index dc0b74443c8d..1321562f305d 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3647,31 +3647,6 @@ void ieee80211_chandef_downgrade(struct cfg80211_chan_def *c,
 	WARN_ON_ONCE(!cfg80211_chandef_valid(c));
 }
 
-/*
- * Returns true if smps_mode_new is strictly more restrictive than
- * smps_mode_old.
- */
-bool ieee80211_smps_is_restrictive(enum ieee80211_smps_mode smps_mode_old,
-				   enum ieee80211_smps_mode smps_mode_new)
-{
-	if (WARN_ON_ONCE(smps_mode_old == IEEE80211_SMPS_AUTOMATIC ||
-			 smps_mode_new == IEEE80211_SMPS_AUTOMATIC))
-		return false;
-
-	switch (smps_mode_old) {
-	case IEEE80211_SMPS_STATIC:
-		return false;
-	case IEEE80211_SMPS_DYNAMIC:
-		return smps_mode_new == IEEE80211_SMPS_STATIC;
-	case IEEE80211_SMPS_OFF:
-		return smps_mode_new != IEEE80211_SMPS_OFF;
-	default:
-		WARN_ON(1);
-	}
-
-	return false;
-}
-
 int ieee80211_send_action_csa(struct ieee80211_sub_if_data *sdata,
 			      struct cfg80211_csa_settings *csa_settings)
 {
-- 
2.47.1



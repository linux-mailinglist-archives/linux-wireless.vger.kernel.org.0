Return-Path: <linux-wireless+bounces-8004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B60C08CD011
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 12:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71828280EA2
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 10:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EF513DDD0;
	Thu, 23 May 2024 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VOB52uFy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393B813D517
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716459106; cv=none; b=V1bjkS0HPQYrcAuQYZ0OaUg2dP8S/2u1jbwc3Hy7swpswQm/yNL6ROLwSICtoCA9Y0ErEJGzNZ2epKw4Mp9/KWJcfOP8k1qz4P5ZuFm8JlbGzobzj/3eVAFjz7r0gtVjx3Jab1f2GJR2TmnKBFJn98yUiC3Z5J/0q6qgV7rWPmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716459106; c=relaxed/simple;
	bh=VwQctpmXpmlCHaOGyedhnSYZQP28cn4Gnos6S8r5XFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fBTTmL7JIylQoemtzcWJH64I5opNP4o3jbAzIzazHtfDX/HGunHeY48xk3d93Snu8b0NzWr7jTxJk4WM+5wMBK7Ot/2ZBVLmnzwU6Fe0TFzviDCCg6RIMK7KH4FoYwBvzd3YQwDV5rv6xK+mZwqWdLr9IoUQlCmlpjOVfDKvN0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VOB52uFy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=emb9O0bL4ON80lMKqGGBusSWBIxuaglul3bAs17muIc=; t=1716459105; x=1717668705; 
	b=VOB52uFybK0MgRSO9t1PGBjYh21i3YSfIwSF4R5KKfR8iK7/jzfXzOYQT2gBc4+yYLkbkorOksX
	U2jcDMJV/ZzP9t6ZjAVwAMDH2EMHWORU9iofjVrx7KsEi61Dh06DVcMlKvU1vtMJDdCBIQiM07hSa
	weFSmKN4ubVifuPb9JPUZui+H9x7nMbFwgfWTUjAVJy2Vr+EMhpuyON0o3DxVLsp8hFiplgo/PoyP
	HgzSKq7Rhe9rMCG78iYKH+xc3GSvPnVsBh0QWlQi4xx2lJHzqYp8wDHF+CZlRnFI1KYCJKS/kC8JF
	/XdFxWdJjD+05Gh29Hu54VQwyeizzVI7f7pQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sA5QE-00000005xHs-3z38;
	Thu, 23 May 2024 12:11:43 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: mac80211: check ieee80211_bss_info_change_notify() against MLD
Date: Thu, 23 May 2024 12:11:40 +0200
Message-ID: <20240523121140.97a589b13d24.I61988788d81fb3cf97a490dfd3167f67a141d1fd@changeid>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

It's not valid to call ieee80211_bss_info_change_notify() with
an sdata that's an MLD, remove the FIXME comment (it's not true)
and add a warning.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 4eaea0a9975b..40fbf397ce74 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -337,6 +337,8 @@ void ieee80211_bss_info_change_notify(struct ieee80211_sub_if_data *sdata,
 
 	might_sleep();
 
+	WARN_ON_ONCE(ieee80211_vif_is_mld(&sdata->vif));
+
 	if (!changed || sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		return;
 
@@ -369,7 +371,6 @@ void ieee80211_bss_info_change_notify(struct ieee80211_sub_if_data *sdata,
 	if (changed & ~BSS_CHANGED_VIF_CFG_FLAGS) {
 		u64 ch = changed & ~BSS_CHANGED_VIF_CFG_FLAGS;
 
-		/* FIXME: should be for each link */
 		trace_drv_link_info_changed(local, sdata, &sdata->vif.bss_conf,
 					    changed);
 		if (local->ops->link_info_changed)
-- 
2.45.1



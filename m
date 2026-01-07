Return-Path: <linux-wireless+bounces-30483-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AC8CFFBEB
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 20:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EB073035CC0
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 19:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1315E33EAED;
	Wed,  7 Jan 2026 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HXz6Vq8X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1860D33E352
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795836; cv=none; b=N5CsFDsAd5eNSwCHab3KKeDoQTEHy/5NuR2DvBMGYoh4KtcYZwddDJK35GPCsIHmCCsIfcUULiuCk4u149kmGt8MBF3GFJ1+mhHlrG0ktktLyQmi/5WMPV+u4miUUAVHdo/31jeero8BH4IHuhSR6dVCEn2Qr2U/vXCG1t9PbvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795836; c=relaxed/simple;
	bh=irWL20dI3GVB3Zff2WhaptA4MA2iourwEy/nfmJ+EJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ux6z0guRaTwGvv/R6f9WVamJmMR9xIhJ7ckZ+YXIR8yERAdJALwBEIfpTvKci+k0N3CzXmmV+O7iQMNe5RJQq+UOQs+IiLA+5OG29lKxIUd7nfoF+S7Cjm9vlI5DiBHy43pRatkZtT1IP9Rk7clbp4DRzde7XGHoo0AtxKvULA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HXz6Vq8X; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VnmUZX2zdQxq+0ciubHHlNy1sDm6luuDVaCERIpahhw=;
	t=1767795834; x=1769005434; b=HXz6Vq8XA3IuCXQ2siXZXWd/LUqKxAet3NIj/Uwdfw4CGNN
	OeimVjQ0idFkGnVxh4nFyl56sKLTN+Mm+WerHt3083Vr1ub8wssdHIgr6aL+y9Iorkm3LpvUPcljD
	HVC15euLx/Hn56OBrhsLjA4vLNDACg+ZSTw9YVystAGT7CPLRP++dtyw85dauQLvazHi/MWkxwbog
	VbuDHIPXf/4pCHi6ILJyPAiZLhJ3qQyj5YyGLgQMXsaytNt3vnvS41EoAetYLxONDaBepZH7uf9d7
	PA5h4y7pZtoxaC2JFUleqhOn52YR11f17Md7/48S9ESJ5t+WYOexZ73x4ATXoqTw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdURz-00000005agF-3Zsc;
	Wed, 07 Jan 2026 15:23:52 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 21/46] wifi: mac80211: extract channel logic from link logic
Date: Wed,  7 Jan 2026 15:22:20 +0100
Message-ID: <20260107152325.37bf332b1bf2.Id24934d14f240f8d38a23f3b1786235bac0b3e60@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

The logic that tries to reuse an existing chanctx or create a new one if
such doesn't exist will be used for other types of chanctx users.
Extract this logic from _ieee80211_link_use_channel.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c | 52 +++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 0605350471ce..758d0dc1a94c 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -2008,6 +2008,36 @@ void __ieee80211_link_release_channel(struct ieee80211_link_data *link,
 		ieee80211_vif_use_reserved_switch(local);
 }
 
+static struct ieee80211_chanctx *
+ieee80211_find_or_create_chanctx(struct ieee80211_sub_if_data *sdata,
+				 const struct ieee80211_chan_req *chanreq,
+				 enum ieee80211_chanctx_mode mode,
+				 bool assign_on_failure,
+				 bool *reused_ctx)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_chanctx *ctx;
+	int radio_idx;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	ctx = ieee80211_find_chanctx(local, chanreq, mode);
+	if (ctx) {
+		*reused_ctx = true;
+		return ctx;
+	}
+
+	*reused_ctx = false;
+
+	if (!ieee80211_find_available_radio(local, chanreq,
+					    sdata->wdev.radio_mask,
+					    &radio_idx))
+		return ERR_PTR(-EBUSY);
+
+	return ieee80211_new_chanctx(local, chanreq, mode,
+				     assign_on_failure, radio_idx);
+}
+
 int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 				const struct ieee80211_chan_req *chanreq,
 				enum ieee80211_chanctx_mode mode,
@@ -2017,8 +2047,7 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx *ctx;
 	u8 radar_detect_width = 0;
-	bool reserved = false;
-	int radio_idx;
+	bool reused_ctx = false;
 	int ret;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -2046,17 +2075,8 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	if (!local->in_reconfig)
 		__ieee80211_link_release_channel(link, false);
 
-	ctx = ieee80211_find_chanctx(local, chanreq, mode);
-	/* Note: context will_be_used flag is now set */
-	if (ctx)
-		reserved = true;
-	else if (!ieee80211_find_available_radio(local, chanreq,
-						 sdata->wdev.radio_mask,
-						 &radio_idx))
-		ctx = ERR_PTR(-EBUSY);
-	else
-		ctx = ieee80211_new_chanctx(local, chanreq, mode,
-					    assign_on_failure, radio_idx);
+	ctx = ieee80211_find_or_create_chanctx(sdata, chanreq, mode,
+					       assign_on_failure, &reused_ctx);
 	if (IS_ERR(ctx)) {
 		ret = PTR_ERR(ctx);
 		goto out;
@@ -2066,7 +2086,11 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 
 	ret = ieee80211_assign_link_chanctx(link, ctx, assign_on_failure);
 
-	if (reserved) {
+	/*
+	 * In case an existing channel context is being used, we marked it as
+	 * will_be_used, now that it is assigned - clear this indication
+	 */
+	if (reused_ctx) {
 		WARN_ON(!ctx->will_be_used);
 		ctx->will_be_used = false;
 	}
-- 
2.52.0



Return-Path: <linux-wireless+bounces-30481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39690CFF6C7
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 19:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 958E8304485E
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 18:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB9B33E376;
	Wed,  7 Jan 2026 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jhHYqMTR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAAE33DEE5
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795835; cv=none; b=dP8Zhq9AtG1Cy5ElKIcGaFoV7JJrTr7jOhd8pcB2D6965GMZU+hjm4+oMvS2z+ZbbwS3WnGb57yixyKSpPLsxMAKTIbyzyLTIJJfdBcgwrtCJW31ShB/rKshWhUAZ/TP+FvvQ5XTKZ+YLlpDOTYvBfpecTIU4OkqcNU22w/6o1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795835; c=relaxed/simple;
	bh=ZC5hfmZZqcsPzuaSMaU9vv6uJE46tdUAU3eo0DSuTmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYpq16i0Dxz+prQyr6LKo+LG+hIXAre3zBWcUkt6eyrLu1pJtFlwE2GA9LJOF/6L/7IqNgbpE64F6H0R03IzkzcNHW3dwiqTWsmPot72H8RLmzgEv7yKsngv6U8YQDE7gAteBc8+LCv4oeO3E5O8kNAklj/NZObEvwYrYuMcpTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jhHYqMTR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QM2ZeQu4vSXcNlI+zk8m58DNDINgiMpAdRGLcso7jG4=;
	t=1767795833; x=1769005433; b=jhHYqMTRTSymiAX3XSi72le8SaMnseL6nC0DsnN6t7M90RZ
	feVJcZWwBAAkCwEccpaRqx37hH0sRt2j7kPVpKjxKgp8/v6hg5pHZK0Qv9YjwdR1XwPvGwL9vPcGu
	uN16ue1CchSNCpJmraxkSc01RYJb/J/CrPzl2ZFzEIoKQ7do2Uw4nMLo70HKp9LdJw+6RyaumX6I9
	83lVYhVqUcaCJoK7ClMMii7KMdQVC475qMDvGJ9EQhvfofFANGaHxaYVuBE30/e3+umURg6xznLpJ
	vdf0ctNKcSVD9fON826JRRkNJ4vrlNyagRVVTxA/HOevM/VmHgiu80Wkrsf3HuRw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdURz-00000005agF-017S;
	Wed, 07 Jan 2026 15:23:51 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 20/46] wifi: mac80211: make ieee80211_find_chanctx link-unaware
Date: Wed,  7 Jan 2026 15:22:19 +0100
Message-ID: <20260107152325.94f3504f7037.I0b735a607e1ec7aa5749ab01c794ef99dbe82b7f@changeid>
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

Currently we have only one user for a channel context: the link.
With NAN, a new type of the channel context user will be added - the NAN
channel.
To prepare for this, we need to separate the channel context code from
the link code.

Removes the link argument from ieee80211_find_chanctx. Since the issue that led
to commit 5e0c422d12b5 ("wifi: mac80211: reserve chanctx during find") - that
added the link argument - is relevant for any user of the channel context, add
a boolean to the chanctx itself, indicating that the chanctx is in the process
of getting used.

When this indication is set, the reference count of the channel context
will be incremented by one, so even if it is getting released from a link
(or another user) it won't be freed.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c        | 26 ++++++++++++++------------
 net/mac80211/ieee80211_i.h |  3 +++
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 5059f52a7d9f..0605350471ce 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -163,6 +163,13 @@ int ieee80211_chanctx_refcount(struct ieee80211_local *local,
 	for_each_chanctx_user_all(local, ctx, &iter)
 		num++;
 
+	/*
+	 * This ctx is in the process of getting used,
+	 * take it into consideration
+	 */
+	if (ctx->will_be_used)
+		num++;
+
 	return num;
 }
 
@@ -746,10 +753,9 @@ static void ieee80211_change_chanctx(struct ieee80211_local *local,
 	_ieee80211_change_chanctx(local, ctx, old_ctx, chanreq, NULL);
 }
 
-/* Note: if successful, the returned chanctx is reserved for the link */
+/* Note: if successful, the returned chanctx will_be_used flag is set */
 static struct ieee80211_chanctx *
 ieee80211_find_chanctx(struct ieee80211_local *local,
-		       struct ieee80211_link_data *link,
 		       const struct ieee80211_chan_req *chanreq,
 		       enum ieee80211_chanctx_mode mode)
 {
@@ -761,9 +767,6 @@ ieee80211_find_chanctx(struct ieee80211_local *local,
 	if (mode == IEEE80211_CHANCTX_EXCLUSIVE)
 		return NULL;
 
-	if (WARN_ON(link->reserved_chanctx))
-		return NULL;
-
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
 		const struct ieee80211_chan_req *compat;
 
@@ -783,12 +786,12 @@ ieee80211_find_chanctx(struct ieee80211_local *local,
 			continue;
 
 		/*
-		 * Reserve the chanctx temporarily, as the driver might change
+		 * Mark the chanctx as will be used, as the driver might change
 		 * active links during callbacks we make into it below and/or
 		 * later during assignment, which could (otherwise) cause the
 		 * context to actually be removed.
 		 */
-		link->reserved_chanctx = ctx;
+		ctx->will_be_used = true;
 
 		ieee80211_change_chanctx(local, ctx, ctx, compat);
 
@@ -2043,8 +2046,8 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	if (!local->in_reconfig)
 		__ieee80211_link_release_channel(link, false);
 
-	ctx = ieee80211_find_chanctx(local, link, chanreq, mode);
-	/* Note: context is now reserved */
+	ctx = ieee80211_find_chanctx(local, chanreq, mode);
+	/* Note: context will_be_used flag is now set */
 	if (ctx)
 		reserved = true;
 	else if (!ieee80211_find_available_radio(local, chanreq,
@@ -2064,9 +2067,8 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	ret = ieee80211_assign_link_chanctx(link, ctx, assign_on_failure);
 
 	if (reserved) {
-		/* remove reservation */
-		WARN_ON(link->reserved_chanctx != ctx);
-		link->reserved_chanctx = NULL;
+		WARN_ON(!ctx->will_be_used);
+		ctx->will_be_used = false;
 	}
 
 	if (ret) {
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 7083718e52d5..1e60597f032c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -927,6 +927,9 @@ struct ieee80211_chanctx {
 
 	bool radar_detected;
 
+	/* This chanctx is in process of getting used */
+	bool will_be_used;
+
 	/* MUST be last - ends in a flexible-array member. */
 	struct ieee80211_chanctx_conf conf;
 };
-- 
2.52.0



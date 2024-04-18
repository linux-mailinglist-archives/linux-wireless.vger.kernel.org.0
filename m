Return-Path: <linux-wireless+bounces-6516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389588A96B8
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 11:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E946C282C98
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 09:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5161A15B157;
	Thu, 18 Apr 2024 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jg8ISTSZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5748715B13A
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433948; cv=none; b=lb1sgib8SqjXErxFph88la4q/Ai5kugu8UFLRshQjaT2nVpIbqGw6q3lwuazzG7Lk7NMbfK0biUFX7lsP8R6zxy7leIumECcZOQyDZTfK6ELg2tiPQLSNYr6bhWII65/WOOtJE/BmkaumvO9eXUUK1RZxVvNs+Yu3p/Y7BlD16Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433948; c=relaxed/simple;
	bh=y0E/XH/beM4W1Lq+ROyL0RRrLz52zl3EjQfFc+22CKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SSWTDzYj7fNeSzS8dA8XR/8QQSPPw5UWBu1CvOH3WtbFpCCAW34S9mgB04ZKe1YwN4kblhApAUB5saoW/V/yvsTLCn1yKbZy3wpGq02/RIkssj/qBup2Wg5qzNGUzYjICvu7MSlGYMAEBkguIv4K3kSG7dfNsZfdnzGsaBL0orA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jg8ISTSZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=m9/z3tJCZh8Mj88/v5Ebby07LUtRPK+nJ0OiyEm+F08=; t=1713433946; x=1714643546; 
	b=jg8ISTSZrRruj44NCEAcWKZA8CajNHrV1jTNQP1z9mKmR4SzWsvcTei8JyTgjK8qr8lfbW+liek
	WIxqUg6KPakjIhdNA19a5hP03Gqpy9KEipuHnrX+FD7OD0BH3U2ApBV6XJdNiwTIp3eo7FxTA0Rpj
	lkk5nLSudWQouo4XsUv4r0ghfJqxrFtruXTqvpX6SxqqNlolVAqnIO4xty9z8UyXdMlEH3nb03EmW
	1LivwNvoyVQ6JWkSEFX9YNeggwYhSTYuSXACrBkVh0r/V16OaowaDBDwyEK6f+6FWj/v/l0HwxGGl
	jl/oPPWxR4WEpUj///Fk5sswWNwPFwGEgosw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rxORL-0000000CM0y-2YnK;
	Thu, 18 Apr 2024 11:52:23 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless-next 1/3] wifi: mac80211: reserve chanctx during find
Date: Thu, 18 Apr 2024 11:52:19 +0200
Message-ID: <20240418115219.94ea84c8ee1e.I0b247dbc0cd937ae6367bc0fc7e8d156b5d5f9b1@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When searching for a chanctx for re-use, it's later adjusted and
assigned. It may also be that another one is already assigned to
the link in question, so unassign can also happen. In short, the
driver is called multiple times. During these callbacks, it may
thus change active links (on another interface), which then can
in turn cause the found chanctx (that's going to be reused) to
get removed and freed.

To avoid this, temporarily assign it to the reserved chanctx and
track the link that wants to use it in the reserved_links list.
This causes the ieee80211_chanctx_refcount() to be increased by
one during these operations, thus avoiding the free.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 5a7fb0e4f89d..6d0148dea126 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -547,8 +547,10 @@ static void ieee80211_change_chanctx(struct ieee80211_local *local,
 	_ieee80211_change_chanctx(local, ctx, old_ctx, chanreq, NULL);
 }
 
+/* Note: if successful, the returned chanctx is reserved for the link */
 static struct ieee80211_chanctx *
 ieee80211_find_chanctx(struct ieee80211_local *local,
+		       struct ieee80211_link_data *link,
 		       const struct ieee80211_chan_req *chanreq,
 		       enum ieee80211_chanctx_mode mode)
 {
@@ -560,6 +562,9 @@ ieee80211_find_chanctx(struct ieee80211_local *local,
 	if (mode == IEEE80211_CHANCTX_EXCLUSIVE)
 		return NULL;
 
+	if (WARN_ON(link->reserved_chanctx))
+		return NULL;
+
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
 		const struct ieee80211_chan_req *compat;
 
@@ -578,6 +583,16 @@ ieee80211_find_chanctx(struct ieee80211_local *local,
 		if (!compat)
 			continue;
 
+		/*
+		 * Reserve the chanctx temporarily, as the driver might change
+		 * active links during callbacks we make into it below and/or
+		 * later during assignment, which could (otherwise) cause the
+		 * context to actually be removed.
+		 */
+		link->reserved_chanctx = ctx;
+		list_add(&link->reserved_chanctx_list,
+			 &ctx->reserved_links);
+
 		ieee80211_change_chanctx(local, ctx, ctx, compat);
 
 		return ctx;
@@ -1701,6 +1716,7 @@ int ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx *ctx;
 	u8 radar_detect_width = 0;
+	bool reserved = false;
 	int ret;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -1727,8 +1743,11 @@ int ieee80211_link_use_channel(struct ieee80211_link_data *link,
 
 	__ieee80211_link_release_channel(link, false);
 
-	ctx = ieee80211_find_chanctx(local, chanreq, mode);
-	if (!ctx)
+	ctx = ieee80211_find_chanctx(local, link, chanreq, mode);
+	/* Note: context is now reserved */
+	if (ctx)
+		reserved = true;
+	else
 		ctx = ieee80211_new_chanctx(local, chanreq, mode);
 	if (IS_ERR(ctx)) {
 		ret = PTR_ERR(ctx);
@@ -1738,6 +1757,14 @@ int ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	ieee80211_link_update_chanreq(link, chanreq);
 
 	ret = ieee80211_assign_link_chanctx(link, ctx);
+
+	if (reserved) {
+		/* remove reservation */
+		WARN_ON(link->reserved_chanctx != ctx);
+		link->reserved_chanctx = NULL;
+		list_del(&link->reserved_chanctx_list);
+	}
+
 	if (ret) {
 		/* if assign fails refcount stays the same */
 		if (ieee80211_chanctx_refcount(local, ctx) == 0)
-- 
2.44.0



Return-Path: <linux-wireless+bounces-7240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A652C8BD542
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C4D283A39
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4712F6BFBC;
	Mon,  6 May 2024 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NkE3ZgWq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDFE41C73
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022868; cv=none; b=RireZBMNX62D/jVid5NAofmNPqMzcYrnj7wC6XG/G/3JxCNo1TC50Skyq1cLCJ72IIVMqQchlFpfTt5QMplTrskxaBWJjWxLdLv3HZrmJJHmi3zlkSjhSjgJ9M6BU8byd4RkzOBrJzaBuwEuzgzJRPCxQ7r7iYS1PqKMegdR8ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022868; c=relaxed/simple;
	bh=2e9UIvejBJHivrya8U5nqzY1Rh3Yo0IgBGTz7CitXlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S3p10UUOTFlxTNUilgy2K5slsTrM/MUdDnVtvHrYPABP8hcYwIipa8uxaMtMUj4DaJGHyTjslPeuqWP2Klhg7cLq+vQ27HHuQv4qLPE889pfH+cgfY2GAGtkxxNCurNqTIQwpqJrGLbR135QQ1kPeCmsGvdAntRQhwqnfGqpnYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NkE3ZgWq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=3kDuyyS0yHbZFIS8DLXAhpXzBAgaWKhjGYKfn2VQc3E=; t=1715022866; x=1716232466; 
	b=NkE3ZgWqJ49eTYBCVUNwsMvv5O84lSjMtmqd80MLEsNyXlmH4fhNQ6CjkEt7mYSLs69ErPBRfOJ
	Ixnj+yeMSVW9gG43V5FsM+m1Z7pGQiwyNgjip3FJOPEG0NKCtLG0nOoAGxwSm+pULIst3+SPtSwYB
	ax6gWfUvGItujPTIQT1HKlMUv6ZxCID7q6/HUEtUEm7p5Dp19ZaDOGc7p6LrZClx6OzZJgiHbqaiH
	Uj2nGwq0WIpy81PzTC9yebEn/4NtK/ZY+mCFu0utJzX9kGbTcswhtinGSYlqS80J9OIVEaIfEE/0I
	wNv3xCUnfAqc63VgmYSbmavxLKJCod6D/qbA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s43n6-00000008A2V-02i1;
	Mon, 06 May 2024 21:14:24 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: mac80211: remove outdated comments
Date: Mon,  6 May 2024 21:14:22 +0200
Message-ID: <20240506211422.68bc10efbd8a.If80f43f4c8b9db1f5266f70d93a805f8c7463fe2@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

These comments are no longer correct, it's a wiphy work now
so it will go away immediately when canceled.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c  | 4 ----
 net/mac80211/util.c | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 76c26de5da13..bbb07ba8793b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3482,10 +3482,6 @@ static void ieee80211_end_cac(struct wiphy *wiphy,
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry(sdata, &local->interfaces, list) {
-		/* it might be waiting for the local->mtx, but then
-		 * by the time it gets it, sdata->wdev.cac_started
-		 * will no longer be true
-		 */
 		wiphy_delayed_work_cancel(wiphy,
 					  &sdata->dfs_cac_timer_work);
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 30d3efedaa8e..9d4e1ab6d843 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3456,10 +3456,6 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	list_for_each_entry(sdata, &local->interfaces, list) {
-		/* it might be waiting for the local->mtx, but then
-		 * by the time it gets it, sdata->wdev.cac_started
-		 * will no longer be true
-		 */
 		wiphy_delayed_work_cancel(local->hw.wiphy,
 					  &sdata->dfs_cac_timer_work);
 
-- 
2.44.0



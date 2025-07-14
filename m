Return-Path: <linux-wireless+bounces-25415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1487AB04BE3
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 01:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82D9E7B59E9
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 23:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA0D28FA85;
	Mon, 14 Jul 2025 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2UeT4Iy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87F528F533;
	Mon, 14 Jul 2025 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752534440; cv=none; b=ZTydGthdvpOVrOBHe9BbwRIfIPTpztVS4SKAhRV1cuqmAmX+4qdI2f4xS/kGcq9bCvmkkz8vwAYw0zPucDADAffYkBwx8lChWQl9Aa33rgqUcINr7P1mbu4VHHzp7rO1BImUyL5HeWGdBeGIOWurRkjdJfbRt2DVMl+yPxJK4+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752534440; c=relaxed/simple;
	bh=BszdfQb86N5o8gOZU3QPEvtEPUnfJJPU+QZJXfnxgRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pexeh1Av80C0sQdJ0te3s/d/X2n9N7IuWBt18wQmM3jn3xjRduX6OQhl6+/r0G30h44QoT/AqV4qigHMgAc3uyPDP1LG7qtH1un2jzLcSmxjQsGvWyFSPkxwjo+5VZH7kZQgXiDyj7DQrtdoMk//h0y5YkAQvdrI80rPjwaAPf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2UeT4Iy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B402C4CEED;
	Mon, 14 Jul 2025 23:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752534440;
	bh=BszdfQb86N5o8gOZU3QPEvtEPUnfJJPU+QZJXfnxgRU=;
	h=From:To:Cc:Subject:Date:From;
	b=b2UeT4IyziSmm2GlLv84zUsqQDLrRujMF6899LKoo2m6+ty+5sxTEra9tiCjFHTEU
	 /QUhLm3wChXI0GolKoVcoh+24CyYggsrRDmp5PhtH3D6N0wJGHpCVIEPdHY0VaViqU
	 PoXyHH6y5kty5wBc6RvIu/EP5YdBLF9gG6jT+6J/5xcxfwpL4pX2oxJQdKpzo/jQsz
	 ndSjNcXoeQV75P7PW3jraK57jMDbxgLWHdJmE03cN16vIFq4hKx0BCiY0ZtjBrnnLe
	 rTKySm6nfsH875lVtCL5Ifm424UioMq4utmxN1hZVZoek+xClDmAnQefwyuuL/MBis
	 6qSP5wjkQ/rvA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 01/12] wifi: mac80211: always initialize sdata::key_list
Date: Mon, 14 Jul 2025 19:07:04 -0400
Message-Id: <20250714230715.3710039-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.38
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit d7a54d02db41f72f0581a3c77c75b0993ed3f6e2 ]

This is currently not initialized for a virtual monitor, leading to a
NULL pointer dereference when - for example - iterating over all the
keys of all the vifs.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250709233400.8dcefe578497.I4c90a00ae3256520e063199d7f6f2580d5451acf@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my analysis of the commit and the code changes, here is my
assessment:

**YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Critical NULL Pointer Dereference Fix**: The commit fixes a NULL
   pointer dereference that occurs when iterating over the key_list of
   virtual monitor interfaces. This is a crash-inducing bug that affects
   system stability.

2. **Clear Bug with Simple Fix**: The issue is straightforward - the
   `key_list` was not initialized for virtual monitor interfaces created
   via `ieee80211_add_virtual_monitor()`. The fix is minimal and
   contained - it simply moves the `INIT_LIST_HEAD(&sdata->key_list)`
   initialization from `ieee80211_if_add()` into
   `ieee80211_sdata_init()`, ensuring all sdata structures have their
   key_list properly initialized.

3. **Real-World Impact**: The bug can be triggered when any code
   iterates over all interfaces and their keys. Looking at the code,
   functions like `ieee80211_iter_keys()` and
   `ieee80211_iter_keys_rcu()` iterate through all interfaces when
   called without a specific vif parameter:
  ```c
  list_for_each_entry(sdata, &local->interfaces, list)
  list_for_each_entry_safe(key, tmp, &sdata->key_list, list)
  ```
  This would cause a NULL pointer dereference when it encounters a
  virtual monitor interface.

4. **Minimal Risk**: The change is extremely low risk - it only adds
   initialization of a list head that should have been initialized all
   along. There are no architectural changes or feature additions.

5. **Follows Stable Rules**: This perfectly fits the stable kernel
   criteria:
   - Fixes a real bug (NULL pointer dereference/crash)
   - Small and contained change (2 lines moved)
   - Obviously correct fix
   - No new features or behaviors introduced

The commit is similar in nature to commit #5 in the reference list which
was marked as suitable for backporting - both fix NULL pointer
dereferences in the wifi/mac80211 subsystem with minimal, targeted
changes.

 net/mac80211/iface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 209d6ffa8e426..adfdc14bd91ac 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1121,6 +1121,8 @@ static void ieee80211_sdata_init(struct ieee80211_local *local,
 {
 	sdata->local = local;
 
+	INIT_LIST_HEAD(&sdata->key_list);
+
 	/*
 	 * Initialize the default link, so we can use link_id 0 for non-MLD,
 	 * and that continues to work for non-MLD-aware drivers that use just
@@ -2162,8 +2164,6 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 
 	ieee80211_init_frag_cache(&sdata->frags);
 
-	INIT_LIST_HEAD(&sdata->key_list);
-
 	wiphy_delayed_work_init(&sdata->dec_tailroom_needed_wk,
 				ieee80211_delayed_tailroom_dec);
 
-- 
2.39.5



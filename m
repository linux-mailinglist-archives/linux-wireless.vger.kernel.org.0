Return-Path: <linux-wireless+bounces-13202-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32B7985EE3
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 15:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3501F2501F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420EF1865F6;
	Wed, 25 Sep 2024 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpeAIOfL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1220321891F;
	Wed, 25 Sep 2024 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266399; cv=none; b=hzkC0F9duUkkH98WUTrFv/9Xbuf/q7HJlOinUna8gdyiRHbVvNbM5gvJgx0CxESkQ6mLAxKm78j0JpdA4Eczd8J9lc04f8mZiFwXHgKtSpGySOGVKk+wkQd28bLxyFjjvFDMqLjfjBVWfcSmjEE1I6vdgvhl6CrYUgF8d1SHEto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266399; c=relaxed/simple;
	bh=quONDP1PgDCsYhaL8Fa2b6bc8N4D7K966aocxPuPG9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhZYWKVFLcpYc2HE5I17kxWmzWhkSdlTbFacZVkt399omNsXDCHq4OTD6Wv8ibVB0rJ8NFOHZdTnd0GUXCZhSLoX49cZs48oFSAtGX8y98VvyjRrQulP4cgrj+FX1zSnWtEFzTww9sA9vrKR5wd10gShlDnua5qycGLAyEl1hzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpeAIOfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D426C4CEC3;
	Wed, 25 Sep 2024 12:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266397;
	bh=quONDP1PgDCsYhaL8Fa2b6bc8N4D7K966aocxPuPG9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FpeAIOfLK5PmKRdXaVLo8xM6NcBIHDjeC5NPKR13H4W1dJChqBMtdXTk2KoSFQa9h
	 2I5Smv2Ag04FZTc1ILTH454zBOZ/4P83WOrZulM7Stp0JbwwyeCGaqgBGi/4PQn6cL
	 vKzTM4iGJ8gAfhHZ6LrsKqo3Fqqw+cFD9AOTQ0PBpiqGScjM80jfGLmgLfCME+NcNB
	 QdSlGWBjPGncwspEXAiuMK/woBg9iNOosruWevRJYJKIFi3GHxIz6EwkTEgt5I1tjK
	 8H22URf+4Z+Lr8Ztj4tuiNe6fmpQh0Y9bjgmb7S5cVAKXcHTFVzO8y5vPGfSnjO62M
	 NXKaXRZuhBguQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 046/139] wifi: mac80211: fix RCU list iterations
Date: Wed, 25 Sep 2024 08:07:46 -0400
Message-ID: <20240925121137.1307574-46-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit ac35180032fbc5d80b29af00ba4881815ceefcb6 ]

There are a number of places where RCU list iteration is
used, but that aren't (always) called with RCU held. Use
just list_for_each_entry() in most, and annotate iface
iteration with the required locks.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20240827094939.ed8ac0b2f897.I8443c9c3c0f8051841353491dae758021b53115e@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/chan.c | 4 +++-
 net/mac80211/mlme.c | 2 +-
 net/mac80211/scan.c | 2 +-
 net/mac80211/util.c | 4 +++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 68952752b5990..c09aed6a3cfcc 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -245,7 +245,9 @@ ieee80211_get_max_required_bw(struct ieee80211_sub_if_data *sdata,
 	enum nl80211_chan_width max_bw = NL80211_CHAN_WIDTH_20_NOHT;
 	struct sta_info *sta;
 
-	list_for_each_entry_rcu(sta, &sdata->local->sta_list, list) {
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
+	list_for_each_entry(sta, &sdata->local->sta_list, list) {
 		if (sdata != sta->sdata &&
 		    !(sta->sdata->bss && sta->sdata->bss == sdata->bss))
 			continue;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 42e2c84ed2484..b14c809bcdea3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -732,7 +732,7 @@ static bool ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 		bool disable_mu_mimo = false;
 		struct ieee80211_sub_if_data *other;
 
-		list_for_each_entry_rcu(other, &local->interfaces, list) {
+		list_for_each_entry(other, &local->interfaces, list) {
 			if (other->vif.bss_conf.mu_mimo_owner) {
 				disable_mu_mimo = true;
 				break;
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 3d68db738cde4..ea554e21e7a19 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -489,7 +489,7 @@ static void __ieee80211_scan_completed(struct ieee80211_hw *hw, bool aborted)
 	 * the scan was in progress; if there was none this will
 	 * just be a no-op for the particular interface.
 	 */
-	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
+	list_for_each_entry(sdata, &local->interfaces, list) {
 		if (ieee80211_sdata_running(sdata))
 			wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 	}
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index d682c32821a11..02b5aaad2a155 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -745,7 +745,9 @@ static void __iterate_interfaces(struct ieee80211_local *local,
 	struct ieee80211_sub_if_data *sdata;
 	bool active_only = iter_flags & IEEE80211_IFACE_ITER_ACTIVE;
 
-	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
+	list_for_each_entry_rcu(sdata, &local->interfaces, list,
+				lockdep_is_held(&local->iflist_mtx) ||
+				lockdep_is_held(&local->hw.wiphy->mtx)) {
 		switch (sdata->vif.type) {
 		case NL80211_IFTYPE_MONITOR:
 			if (!(sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE))
-- 
2.43.0



Return-Path: <linux-wireless+bounces-13163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A46985976
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7611F24503
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 11:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DDB1A0BFA;
	Wed, 25 Sep 2024 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VC3hMn/m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3561714CD;
	Wed, 25 Sep 2024 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264347; cv=none; b=SAPz6zHe+Ij0lcfaWmMfC38mURxRhYZejMNwXtqYeTXp82u7XERYfb+LM2lfF4l3h2KbbQT6zARBqeA+0X9mV//N+6ezQknm1nLRo0uyZ6Q61bZHUv8noRIxC9HAU9INJMpsvdkOKfmNJsZaNK/uerPs30SiE5i6gyYkkxnjioM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264347; c=relaxed/simple;
	bh=jF0abiIBhipUZJz2L6J7yK+HxKzqN7eourDEO/NO2Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjo+HlcVanGYhJ4dPfww6KqgpCoi1s57KGeTQJb9M0H9eDvdxtr7QKs8uloga4PWl/rCvEZPqIw1An7pGrgTRr/2TjctDwFYNDu5zMwd5YVNlgYhfqLpHpFB5XjZUgrqs8ICTSvY0ygRF31l9QYsrcV/MweF1IYOlS/oqZ23KQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VC3hMn/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CCBC4AF0B;
	Wed, 25 Sep 2024 11:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264347;
	bh=jF0abiIBhipUZJz2L6J7yK+HxKzqN7eourDEO/NO2Wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VC3hMn/mHJK50XH73K0LkQJ1YKn4F5zBrv+B5hEdHm0GUuQudVbUE7JVLBngL72ob
	 v7uZ3zM9/LCYq/P41ddK1SP/cGD1WDSQScJzMsan+j16iuWqzafQjOaE167rWA/8cS
	 RHPNMfibeCKgqF6JzPikjzBRGGh3yZPwl1ryiJCtuoWlnLiypwjrGgBr2FKo2dk2Q6
	 DhQQVne5wzWMsykAN32u86comZPHm3LcyYNM6KMex9cpFsagTHdPmzzZN2BYYJmf/5
	 Uwa4iZ3qCHuHLD+Q4KTxP+XMOEfHhYXNjkAxi5nxfShdD9wRFPWvOQSmpAGE7xpLv4
	 QdqaQ70noyF+w==
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
Subject: [PATCH AUTOSEL 6.11 062/244] wifi: mac80211: fix RCU list iterations
Date: Wed, 25 Sep 2024 07:24:43 -0400
Message-ID: <20240925113641.1297102-62-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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
index e8567723e94d5..b72e4036526bf 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -286,7 +286,9 @@ ieee80211_get_max_required_bw(struct ieee80211_link_data *link)
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
index f9526bbc36337..3a0433e088906 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1231,7 +1231,7 @@ static bool ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 		bool disable_mu_mimo = false;
 		struct ieee80211_sub_if_data *other;
 
-		list_for_each_entry_rcu(other, &local->interfaces, list) {
+		list_for_each_entry(other, &local->interfaces, list) {
 			if (other->vif.bss_conf.mu_mimo_owner) {
 				disable_mu_mimo = true;
 				break;
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index b5f2df61c7f67..2dd84fc542b2a 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -504,7 +504,7 @@ static void __ieee80211_scan_completed(struct ieee80211_hw *hw, bool aborted)
 	 * the scan was in progress; if there was none this will
 	 * just be a no-op for the particular interface.
 	 */
-	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
+	list_for_each_entry(sdata, &local->interfaces, list) {
 		if (ieee80211_sdata_running(sdata))
 			wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 	}
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index c7ad9bc5973a0..aed72794d9fe3 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -751,7 +751,9 @@ static void __iterate_interfaces(struct ieee80211_local *local,
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



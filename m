Return-Path: <linux-wireless+bounces-13184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D749E985CD3
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 14:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 901FBB273FE
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 12:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FBB1D3621;
	Wed, 25 Sep 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfaWsXV2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2A61D31BB;
	Wed, 25 Sep 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265628; cv=none; b=H3SX+cwL289Ue67xDl9nl9j0gx7gnCngMklkNRIygfRjapVO3RKArdG/AQdpJwsczIprD4Np+Lma/kQv3vTIfoYPXpWywuZrgz8QkdTqL1tUG2KEQf0+MmY34TXFVXQpOIwuPy+RgCVJGbV/8VdYdJOX/gvy5X3NPsDk6b3W/R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265628; c=relaxed/simple;
	bh=cVlSdnQ0W/ArDPRxl12+eqYtiU9aGW2ynXI/UjZqr2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZaj/4Eh60mhp88d96uDoDhps4zj0YxrXUCnwMNKETgf1gu51ywzJGrsofyBHWtKqoET7Ne1sAfDjUh7uezFOh7iwHlFWi7BNLW3DU5q3jXubsl7Y7kWMJ0huJ47kYeBnIbAhNhC0oImLEtA2ZJDoUqqVdcXmtUeLmtjF614Lxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfaWsXV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E4CC4CECD;
	Wed, 25 Sep 2024 12:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265628;
	bh=cVlSdnQ0W/ArDPRxl12+eqYtiU9aGW2ynXI/UjZqr2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QfaWsXV2k92tV2GffO0aQYft/oBrLYS5nmg/sp9Aj5Nb+5sqFYYwzm0FW4yA0Dkje
	 qhwFMOZdEiix6PDZE+2YZv9tnRfEfXD1/fCobilh9QHUeqGo3/kDpXdN3MYwPxJxWO
	 31QkiCLHn/JangFcqiai5bIknIg7MWKu3K0JEkm6o8I7da/cgi1KjIkk3i45AtfzG3
	 +x8qEMLcwZSwp08goLvflmL+R1AIsVfX08B2G7u4p3KiV1/I2BJU66Ry3+8AbbkBwF
	 IWkxMkFu6krE/+oT9gtiC+DxstBikyZs//rVsVexlWr/3aTLEbhBCFUtgmke/WWxTO
	 AZi7p2Kf0KWBg==
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
Subject: [PATCH AUTOSEL 6.10 052/197] wifi: mac80211: fix RCU list iterations
Date: Wed, 25 Sep 2024 07:51:11 -0400
Message-ID: <20240925115823.1303019-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index e6a7ff6ca6797..db5675d24e488 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -281,7 +281,9 @@ ieee80211_get_max_required_bw(struct ieee80211_link_data *link)
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
index ad2ce9c92ba8a..eb6b5024ac264 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1020,7 +1020,7 @@ static bool ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
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
index c11dbe82ae1b3..d10e0c528c1bf 100644
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



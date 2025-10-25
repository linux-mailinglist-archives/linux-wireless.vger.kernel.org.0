Return-Path: <linux-wireless+bounces-28253-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B8384C09551
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DA5734DEA8
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184E73081D9;
	Sat, 25 Oct 2025 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5eUkcqO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4203305E10;
	Sat, 25 Oct 2025 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409036; cv=none; b=J20Dk8LyWFolC/YvLGZ3CcBZCHhhUIR2pHrMJaUCw/lIMPRj+L7yCsvBZD6yOnq5EaCMquKM/2r3KPMexgTlXqs7bla6Rhn35fY0BKoQ7rlzcE8cL/XAebnRjxZd4Cpaj8sDmZw7LicrKZQSVlFltFQiPd7Wt2Kd4bzjusLWnJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409036; c=relaxed/simple;
	bh=pvN19703bNvkmA0yQvWz2S+zOJr0Tt1lfGN5/ZdHBPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGCqJzEdIonNx2YjEGVZRhqd0K7pL6AzgkDunRGydAioQUKDcPTjMVs9mG6xL9DV2YCGaaNztFXmT9HXre0kRYApJmBtZQvZ/Y7c3LS+rmtcd/EfL0N0V0cOB+8VfT7m56giOlhix7xne0xFUW6gS1gDulYfXgLEnR3BGWkCd4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5eUkcqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74575C4CEF5;
	Sat, 25 Oct 2025 16:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409035;
	bh=pvN19703bNvkmA0yQvWz2S+zOJr0Tt1lfGN5/ZdHBPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5eUkcqOs/3XDs1pYskfSo7k+Px8k70hWub9kB3118Z8HDzfJpSkTdcYGVTxTwfMI
	 xG64YqpKAdzr9W6M0sJhsweH1wa0wvPENofbGuL45zFjzAFbqo7NvdAMAAdLhnGxbz
	 wnbJF9cuEfi+3Bjeb/gzPpP+1pNa6MpuxX1wnLFnsf2o4xm7qbtp0aJhwTL0VVqR1I
	 gCNKh3ei5sCGg73o3nHCu2N66RG152rBlfFjw+PC2XRhOeJXkYBahzGV32pc8hx5SV
	 baN2JOP20iKstOTctjVFIQoXCangCXqoFJ7gxesbM+fHuXZAkniQbRDu2Xkx4eAqsc
	 wVMtW7ZtFudlQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] wifi: mac80211: Get the correct interface for non-netdev skb status
Date: Sat, 25 Oct 2025 11:56:51 -0400
Message-ID: <20251025160905.3857885-180-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit c7b5355b37a59c927b2374e9f783acd004d00960 ]

The function ieee80211_sdata_from_skb() always returned the P2P Device
interface in case the skb was not associated with a netdev and didn't
consider the possibility that an NAN Device interface is also enabled.

To support configurations where both P2P Device and a NAN Device
interface are active, extend the function to match the correct
interface based on address 2 in the 802.11 MAC header.

Since the 'p2p_sdata' field in struct ieee80211_local is no longer
needed, remove it.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250908140015.5252d2579a49.Id4576531c6b2ad83c9498b708dc0ade6b0214fa8@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES – this fixes a real mac80211 bug that breaks NAN status reporting
when a P2P device is also present.

- **Correct interface lookup**: non-netdev TX status frames now walk the
  interface list and only accept P2P or started NAN vifs whose MAC
  matches `addr2` (net/mac80211/status.c:572-605). This replaces the
  hard-wired `local->p2p_sdata` pointer so NAN frames are associated
  with their own interface rather than the P2P device.
- **User-visible impact**: the status path feeds cfg80211 callbacks such
  as `cfg80211_control_port_tx_status()` and
  `cfg80211_mgmt_tx_status_ext()` (net/mac80211/status.c:624-666).
  Without the fix, NAN transmissions delivered through these hooks are
  reported on the wrong wdev, so user space never sees acknowledgements
  for NAN operations when P2P is enabled—causing functional failures.
- **Safe cleanup**: removing the now-unused `p2p_sdata` field from
  `struct ieee80211_local` eliminates stale pointer handling
  (net/mac80211/ieee80211_i.h:1675-1680), and the monitor bookkeeping
  that used to live in the same switch is preserved by moving the list
  insertion into the monitor case (net/mac80211/iface.c:1405-1414). No
  driver interfaces or data layouts change.
- **Risk assessment**: the new logic still runs under the existing RCU
  read-side locks, touches only status-path book-keeping, and degrades
  gracefully by returning NULL when no match is found. It has no
  prerequisites beyond current stable code, so it is a low-risk, self-
  contained bug fix suitable for stable backporting.

You may want to run a quick P2P+NAN tx-status test to confirm the
corrected reporting path after backporting.

 net/mac80211/ieee80211_i.h |  2 --
 net/mac80211/iface.c       | 16 +---------------
 net/mac80211/status.c      | 21 +++++++++++++++++++--
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8afa2404eaa8e..140dc7e32d4aa 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1665,8 +1665,6 @@ struct ieee80211_local {
 	struct idr ack_status_frames;
 	spinlock_t ack_status_lock;
 
-	struct ieee80211_sub_if_data __rcu *p2p_sdata;
-
 	/* virtual monitor interface */
 	struct ieee80211_sub_if_data __rcu *monitor_sdata;
 	struct ieee80211_chan_req monitor_chanreq;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 07ba68f7cd817..abc8cca54f4e1 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -611,10 +611,6 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 
 		spin_unlock_bh(&sdata->u.nan.func_lock);
 		break;
-	case NL80211_IFTYPE_P2P_DEVICE:
-		/* relies on synchronize_rcu() below */
-		RCU_INIT_POINTER(local->p2p_sdata, NULL);
-		fallthrough;
 	default:
 		wiphy_work_cancel(sdata->local->hw.wiphy, &sdata->work);
 		/*
@@ -1405,6 +1401,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		ieee80211_recalc_idle(local);
 
 		netif_carrier_on(dev);
+		list_add_tail_rcu(&sdata->u.mntr.list, &local->mon_list);
 		break;
 	default:
 		if (coming_up) {
@@ -1468,17 +1465,6 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 			sdata->vif.type != NL80211_IFTYPE_STATION);
 	}
 
-	switch (sdata->vif.type) {
-	case NL80211_IFTYPE_P2P_DEVICE:
-		rcu_assign_pointer(local->p2p_sdata, sdata);
-		break;
-	case NL80211_IFTYPE_MONITOR:
-		list_add_tail_rcu(&sdata->u.mntr.list, &local->mon_list);
-		break;
-	default:
-		break;
-	}
-
 	/*
 	 * set_multicast_list will be invoked by the networking core
 	 * which will check whether any increments here were done in
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index a362254b310cd..4b38aa0e902a8 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2008-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright 2021-2024  Intel Corporation
+ * Copyright 2021-2025  Intel Corporation
  */
 
 #include <linux/export.h>
@@ -572,6 +572,7 @@ static struct ieee80211_sub_if_data *
 ieee80211_sdata_from_skb(struct ieee80211_local *local, struct sk_buff *skb)
 {
 	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_hdr *hdr = (void *)skb->data;
 
 	if (skb->dev) {
 		list_for_each_entry_rcu(sdata, &local->interfaces, list) {
@@ -585,7 +586,23 @@ ieee80211_sdata_from_skb(struct ieee80211_local *local, struct sk_buff *skb)
 		return NULL;
 	}
 
-	return rcu_dereference(local->p2p_sdata);
+	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
+		switch (sdata->vif.type) {
+		case NL80211_IFTYPE_P2P_DEVICE:
+			break;
+		case NL80211_IFTYPE_NAN:
+			if (sdata->u.nan.started)
+				break;
+			fallthrough;
+		default:
+			continue;
+		}
+
+		if (ether_addr_equal(sdata->vif.addr, hdr->addr2))
+			return sdata;
+	}
+
+	return NULL;
 }
 
 static void ieee80211_report_ack_skb(struct ieee80211_local *local,
-- 
2.51.0



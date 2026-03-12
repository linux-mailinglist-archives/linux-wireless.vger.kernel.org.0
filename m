Return-Path: <linux-wireless+bounces-33148-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIm8OHHysmmLRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33148-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:05:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B6B276585
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70A65302295E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA3C3FE350;
	Thu, 12 Mar 2026 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="EfDvwdlV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50DB3D88FA
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334871; cv=none; b=bW1Vwdn3jjou16iTVEni+LFTwU8MGSS9KI6nB+jdSmGLnNcu2A+ygPJ0VvsSjO/8Kip0riVjcLgBcUh/mzGYz5seLH75Qa3rQoNHN18BYam2iLuEuR4jMjmmmwLrbB7JMMtCW+/8f2XmJgWyQjUkqAyjGbx/zEPCINuU4TzYB8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334871; c=relaxed/simple;
	bh=uDr9ACmA42e7vs6+u5VWzCciVNMoUr5KcIXIezdh68A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvg6/scbZlnFfhT6ODsscurm9f6Ln8NVqZ8EfB0KiLDE4Sl3R2vQJ1CyI1v9pMjPB48VCRM6sDK2k2SAS93hOZb3Y/haWyRzB7ODKnvRXWzh5q4yiSyOf69UPfzo/PhF1gMfYw7Up+xXlLTfKwk+hXipP8pK7yON+sTdjrp9G4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=EfDvwdlV; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8BC7628008E
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:06 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 3898113C2B3;
	Thu, 12 Mar 2026 10:01:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3898113C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773334864;
	bh=uDr9ACmA42e7vs6+u5VWzCciVNMoUr5KcIXIezdh68A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EfDvwdlVm11YdP9HKL8I6YE9i+FxX8ArBgmKMcefud2vy81IpqgNbKMh6ASn3EKR4
	 1n/uM4K4xE8+xKZLchj5rPXyv0KnQp88aQhJdjBdi0MiIyDJlpNG6x3UWqs0Bih4DG
	 zvjPXphjv7U5VxrGs4WBw7zhVFBj+9UefU0yKHXc=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next v2 26/28] wifi: mac80211: Ensure link work-items are only initialized once.
Date: Thu, 12 Mar 2026 10:00:24 -0700
Message-ID: <20260312170026.285494-27-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260312170026.285494-1-greearb@candelatech.com>
References: <20260312170026.285494-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1773334867-y9DLraJss0S5
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1773334867;y9DLraJss0S5;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33148-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,candelatech.com:dkim,candelatech.com:email,candelatech.com:mid]
X-Rspamd-Queue-Id: 47B6B276585
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

Re-initialization could cause corruption in work queues in case
links were not properly stopped for some reason.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/link.c        | 28 ++++++++++++++++++++--------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index d71e0c6d2165..ac4e10f16cd9 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1079,6 +1079,7 @@ struct ieee80211_link_data {
 
 
 	bool operating_11g_mode;
+	bool already_initialized; /* has ieee80211_link_init been called? */
 
 	struct {
 		struct wiphy_work finalize_work;
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 03bfca27d205..6125e79f67c9 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -110,14 +110,25 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 	link->user_power_level = sdata->local->user_power_level;
 	link_conf->txpower = INT_MIN;
 
-	wiphy_work_init(&link->csa.finalize_work,
-			ieee80211_csa_finalize_work);
-	wiphy_work_init(&link->color_change_finalize_work,
-			ieee80211_color_change_finalize_work);
-	wiphy_delayed_work_init(&link->color_collision_detect_work,
-				ieee80211_color_collision_detection_work);
-	wiphy_hrtimer_work_init(&link->dfs_cac_timer_work,
-				ieee80211_dfs_cac_timer_work);
+	if (link->already_initialized) {
+		wiphy_delayed_work_cancel(link->sdata->local->hw.wiphy,
+					  &link->color_collision_detect_work);
+		wiphy_work_cancel(link->sdata->local->hw.wiphy,
+				  &link->color_change_finalize_work);
+		wiphy_work_cancel(link->sdata->local->hw.wiphy,
+				  &link->csa.finalize_work);
+		wiphy_hrtimer_work_cancel(link->sdata->local->hw.wiphy,
+					  &link->dfs_cac_timer_work);
+	} else {
+		wiphy_work_init(&link->csa.finalize_work,
+				ieee80211_csa_finalize_work);
+		wiphy_work_init(&link->color_change_finalize_work,
+				ieee80211_color_change_finalize_work);
+		wiphy_delayed_work_init(&link->color_collision_detect_work,
+					ieee80211_color_collision_detection_work);
+		wiphy_hrtimer_work_init(&link->dfs_cac_timer_work,
+					ieee80211_dfs_cac_timer_work);
+	}
 
 	if (!deflink) {
 		switch (sdata->vif.type) {
@@ -138,6 +149,7 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 		ieee80211_link_debugfs_add(link);
 	}
 
+	link->already_initialized = true;
 	rcu_assign_pointer(sdata->vif.link_conf[link_id], link_conf);
 	rcu_assign_pointer(sdata->link[link_id], link);
 }
-- 
2.42.0



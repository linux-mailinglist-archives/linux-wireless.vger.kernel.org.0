Return-Path: <linux-wireless+bounces-33026-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOplBNz1sWkeHgAAu9opvQ
	(envelope-from <linux-wireless+bounces-33026-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:08:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B8626B28D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F03F3027965
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 23:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAF73A545F;
	Wed, 11 Mar 2026 23:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="AByu8fuj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA6A391832
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270471; cv=none; b=KGh1SwtuLky9X0XS5QV3w9wnpr/OHqkmC2nw080MdWlOg0bX7qTJY3tzxDza+VQ5gQmNWw208f2dP5qbkgRAsMTpkVG4fNeoyH2VSOmfJb9W24NGz/7YIYGIyVOExZrKWSNlN2uzIykG1i9utdDfrIYpavToC5pz/UoCGuzRRzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270471; c=relaxed/simple;
	bh=uDr9ACmA42e7vs6+u5VWzCciVNMoUr5KcIXIezdh68A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IC2YFrk2S+Ohet5m6/44IVxKkPGLMAzRgl0+0fRlIwdBFih7oQMvG88A7lJPATpHCF0yDWGCTYL+shoSpgxS5hbsY7XiK1rPm0P2bT5Vv30dv/JHEr8PCpC+ze60RCnLrOekDKImI6UXOV8jBn7sqN+QimXmLoupSlDvISISsfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=AByu8fuj; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D4CB744007C
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:44 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 8080413C2B1;
	Wed, 11 Mar 2026 16:07:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8080413C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773270462;
	bh=uDr9ACmA42e7vs6+u5VWzCciVNMoUr5KcIXIezdh68A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AByu8fuj4kj5ym2vk9PWdFVUdYPwzozo/yIXnD3jv2ff5iluk3Xx04/TWzg6vHzvX
	 YHFdHiK+5feYX7eGXF1jJ04qYec8Snr8WtPWaLJTisa1WVxScU4Q/f0j+PQ7jqZ7K4
	 6pUlXHnwwwue8uNVpQN/gZ2eeKYNtF4sBQ5A9x40=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next 26/28] wifi: mac80211: Ensure link work-items are only initialized once.
Date: Wed, 11 Mar 2026 16:07:28 -0700
Message-ID: <20260311230730.163348-27-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260311230730.163348-1-greearb@candelatech.com>
References: <20260311230730.163348-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1773270465-4oFx-99T3AhR
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1773270465;4oFx-99T3AhR;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33026-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[candelatech.com:dkim,candelatech.com:email,candelatech.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3B8626B28D
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



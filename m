Return-Path: <linux-wireless+bounces-33008-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AAQGND1sWl7HQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33008-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:08:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A27E026B259
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7C9A3013FC1
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 23:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EFC3A3807;
	Wed, 11 Mar 2026 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="PudD9YeT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491DD39FCB4
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270468; cv=none; b=VMEgY70lYJBwJnDbsxCpmYFnzquWuClF0Vpl7T627sgWUC22b3Px5qmzaBAvH+mL5+9qyAvwlNLghnaG0sIfEzr/JZHYB1ceOMHRjdQlxxt9idyuEqvI7rgSgrlI0MWT94KThN743OIJc1UN8VSmmbZ/H1j6SzF61mGDf1YSfOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270468; c=relaxed/simple;
	bh=u9jo3LH2VMp0W8K1yVLpQ//2ZcC6fGh5SutxF/BLckw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JY1XsPjp3TVhgjtH+uEp+qgn063hl6P4gc69tUTpqo3tAGQAH2amjdmWNi4O6sZPIx7nwjmgWX5stgFFOeKGC+fM5UuqrX+r5gAzg5hVXTKW98HQc5iG5tvELDOohEcvKSIU6049a8HnITmizalYwPlVoz4NRw3tQodzS/Z/edo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=PudD9YeT; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id AE9BF50A56C
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:46 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9239E2C006D
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:39 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 15CAD13C2B5;
	Wed, 11 Mar 2026 16:07:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 15CAD13C2B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773270457;
	bh=u9jo3LH2VMp0W8K1yVLpQ//2ZcC6fGh5SutxF/BLckw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PudD9YeTWon/79TOlql4f68B1wgvp39T4htZrEslzgsowTOLohLXcc+9He7PgtPk3
	 NJLOqOoH8jaG4eoKmAPWz/qXqikgJE91tzIrPCCE6/tyzJFH6fXg3R8I62gA6zcKk3
	 dSwRY50+1+qVmG9TPNLQw3tlIOPw8uCIDKfHn9Vg=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next 04/28] wifi: mac80211:  Check debugfs creation return values.
Date: Wed, 11 Mar 2026 16:07:06 -0700
Message-ID: <20260311230730.163348-5-greearb@candelatech.com>
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
X-MDID: 1773270460-hMaySuF2G5bR
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1773270460;hMaySuF2G5bR;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33008-lists,linux-wireless=lfdr.de];
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
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[candelatech.com:dkim,candelatech.com:email,candelatech.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A27E026B259
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

Add return error checking for the debugfs directory create
calls.  Assign error pointers to NULL instead of potential error
codes that the create logic may return.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/debugfs.c        | 11 +++++++++++
 net/mac80211/debugfs_key.c    |  6 ++++++
 net/mac80211/debugfs_netdev.c | 33 +++++++++++++++++++++++++++++++++
 net/mac80211/debugfs_sta.c    | 15 +++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index e8d0a8b71d59..1f428f8a7633 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -680,6 +680,12 @@ void debugfs_hw_add(struct ieee80211_local *local)
 		return;
 
 	local->debugfs.keys = debugfs_create_dir("keys", phyd);
+	if (IS_ERR(local->debugfs.keys)) {
+		pr_err("Failed to create local keys debugfs dir, rv: %ld phyd: 0x%px\n",
+		       (long)(local->debugfs.keys), phyd);
+		local->debugfs.keys = NULL;
+		return;
+	}
 
 	DEBUGFS_ADD(total_ps_buffered);
 	DEBUGFS_ADD(wep_iv);
@@ -705,6 +711,11 @@ void debugfs_hw_add(struct ieee80211_local *local)
 			   phyd, &local->aql_threshold);
 
 	statsd = debugfs_create_dir("statistics", phyd);
+	if (IS_ERR(statsd)) {
+		pr_err("Failed to create local stats debugfs dir, rv: %ld phyd: 0x%px\n",
+		       (long)(statsd), phyd);
+		return;
+	}
 
 #ifdef CONFIG_MAC80211_DEBUG_COUNTERS
 	DEBUGFS_STATS_ADD(dot11TransmittedFragmentCount);
diff --git a/net/mac80211/debugfs_key.c b/net/mac80211/debugfs_key.c
index 117f58af5ff9..670bcfa8c4ed 100644
--- a/net/mac80211/debugfs_key.c
+++ b/net/mac80211/debugfs_key.c
@@ -335,6 +335,12 @@ void ieee80211_debugfs_key_add(struct ieee80211_key *key)
 	keycount++;
 	key->debugfs.dir = debugfs_create_dir(buf,
 					key->local->debugfs.keys);
+	if (IS_ERR(key->debugfs.dir)) {
+		pr_err("Failed to create key debugfs dir, rv: %ld phyd: 0x%px\n",
+		       (long)(key->debugfs.dir), key->local->debugfs.keys);
+		key->debugfs.dir = NULL;
+		return;
+	}
 
 	sta = key->sta;
 	if (sta) {
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index f3c6a41e4911..51d2ae232a85 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -882,6 +882,11 @@ static void add_mesh_stats(struct ieee80211_sub_if_data *sdata)
 {
 	struct dentry *dir = debugfs_create_dir("mesh_stats",
 						sdata->vif.debugfs_dir);
+	if (IS_ERR(dir)) {
+		sdata_err(sdata, "Failed to create mesh stats dir, rv: %ld vif dir: 0x%px\n",
+			  (long)(dir), sdata->vif.debugfs_dir);
+		return;
+	}
 #define MESHSTATS_ADD(name)\
 	debugfs_create_file(#name, 0400, dir, sdata, &name##_ops)
 
@@ -897,6 +902,11 @@ static void add_mesh_config(struct ieee80211_sub_if_data *sdata)
 {
 	struct dentry *dir = debugfs_create_dir("mesh_config",
 						sdata->vif.debugfs_dir);
+	if (IS_ERR(dir)) {
+		sdata_err(sdata, "Failed to create mesh config dir, rv: %ld vif dir: 0x%px\n",
+			  (long)(dir), sdata->vif.debugfs_dir);
+		return;
+	}
 
 #define MESHPARAMS_ADD(name) \
 	debugfs_create_file(#name, 0600, dir, sdata, &name##_ops)
@@ -1003,10 +1013,25 @@ static void ieee80211_debugfs_add_netdev(struct ieee80211_sub_if_data *sdata,
 	sprintf(buf, "netdev:%s", sdata->name);
 	sdata->vif.debugfs_dir = debugfs_create_dir(buf,
 		sdata->local->hw.wiphy->debugfsdir);
+
+	if (IS_ERR(sdata->vif.debugfs_dir)) {
+		sdata_err(sdata, "Failed to create netdev dir, rv: %ld name: %s wiphy dir: 0x%px\n",
+			  (long)(sdata->vif.debugfs_dir), buf, sdata->local->hw.wiphy->debugfsdir);
+		sdata->vif.debugfs_dir = NULL;
+		return;
+	}
+
 	/* deflink also has this */
 	sdata->deflink.debugfs_dir = sdata->vif.debugfs_dir;
+
 	sdata->debugfs.subdir_stations = debugfs_create_dir("stations",
 							sdata->vif.debugfs_dir);
+	if (IS_ERR(sdata->debugfs.subdir_stations)) {
+		sdata_err(sdata, "Failed to create netdev subdir-stations dir, rv: %ld wiphy dir: 0x%px\n",
+			  (long)(sdata->debugfs.subdir_stations), sdata->vif.debugfs_dir);
+		sdata->debugfs.subdir_stations = NULL;
+		return;
+	}
 	add_files(sdata);
 	if (!mld_vif)
 		add_link_files(&sdata->deflink, sdata->vif.debugfs_dir);
@@ -1058,6 +1083,14 @@ void ieee80211_link_debugfs_add(struct ieee80211_link_data *link)
 		debugfs_create_dir(link_dir_name,
 				   link->sdata->vif.debugfs_dir);
 
+	if (IS_ERR(link->debugfs_dir)) {
+		sdata_err(link->sdata, "Failed to create debugfs dir, rv: %ld  link-dir-name: %s vif dir: 0x%px\n",
+			  (long)(link->debugfs_dir), link_dir_name,
+			  link->sdata->vif.debugfs_dir);
+		link->debugfs_dir = NULL;
+		return;
+	}
+
 	DEBUGFS_ADD(link->debugfs_dir, addr);
 	add_link_files(link, link->debugfs_dir);
 }
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index ef75255d47d5..23cb2099e3b3 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -1250,6 +1250,12 @@ void ieee80211_sta_debugfs_add(struct sta_info *sta)
 	 * dir might still be around.
 	 */
 	sta->debugfs_dir = debugfs_create_dir(mac, stations_dir);
+	if (IS_ERR(sta->debugfs_dir)) {
+		sdata_err(sdata, "Failed to create sta debugfs dir, rv: %ld name: %s stations dir: 0x%px\n",
+			  (long)(sta->debugfs_dir), mac, stations_dir);
+		sta->debugfs_dir = NULL;
+		return;
+	}
 
 	DEBUGFS_ADD(flags);
 	DEBUGFS_ADD(aid);
@@ -1303,6 +1309,15 @@ void ieee80211_link_sta_debugfs_add(struct link_sta_info *link_sta)
 			debugfs_create_dir(link_dir_name,
 					   link_sta->sta->debugfs_dir);
 
+		if (IS_ERR(link_sta->debugfs_dir)) {
+			sdata_err(link_sta->sta->sdata,
+				  "Failed to create link-sta debugfs dir, rv: %ld name: %s stations dir: 0x%px\n",
+				  (long)(link_sta->debugfs_dir), link_dir_name,
+				  link_sta->sta->debugfs_dir);
+			link_sta->debugfs_dir = NULL;
+			return;
+		}
+
 		DEBUGFS_ADD(addr);
 	} else {
 		if (WARN_ON(link_sta != &link_sta->sta->deflink))
-- 
2.42.0



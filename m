Return-Path: <linux-wireless+bounces-33136-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOsLKSnysmmLRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33136-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:04:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0882D27653B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FEED30743EA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007823FCB1F;
	Thu, 12 Mar 2026 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="bR83WpbM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F12C3FBEA9
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334868; cv=none; b=XJ7k6VJWgbgVbHfENjzrQQzfrBJNOc0jZ3MCt0tgtgzFfxiwi+eN56pQ7jo7u86PyRSfLbum4lludQqB2QLRxlRYqmPM/rIAaHD0eGw4dYuXc2CnDgHzNf8E/XYCGUUYNX81HnxYN5ut0omLSYiN7saDpZZDxA5/cNhLPHljx+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334868; c=relaxed/simple;
	bh=LTrp6PkpKYEg4BoWNckuFEuP3G5zXUwriDEvZarByNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQXIX+h6BiYkXgG7y8eV/4vawG7whtvjcjY4g3REDPoHHFKBY16tGiRMYYBomt3VLXpfO5gZZOOzkaQndGVf38dbl0/qwB87vivVnVLxDe+h2p1Rbki9E0qTZE6H4lcv2Gmwoj0IQ1otNc4kD0qwnibw9T+E3EvWce5nwKqVwx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=bR83WpbM; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 115CD8008B
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:03 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id AD51D13C2B9;
	Thu, 12 Mar 2026 10:00:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com AD51D13C2B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773334859;
	bh=LTrp6PkpKYEg4BoWNckuFEuP3G5zXUwriDEvZarByNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bR83WpbM8Yb8Bn+kjZ+6VZdkV8q8Tc6M6hWJPGHbWz5atejqkeZ253pbZNeTG4uQ5
	 2kb4oDv3J40JaUv2aautxiFa3uQBGqmpJtYI+HVjfBcv6g4IWHqdWUqZDdFZm44g8t
	 B5ix+nzrMTqsFfNQeEihJus1lnY77z9pa4KKNNWM=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next v2 08/28] wifi: mac80211: Debugfs safety checks.
Date: Thu, 12 Mar 2026 10:00:06 -0700
Message-ID: <20260312170026.285494-9-greearb@candelatech.com>
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
X-MDID: 1773334863-JQcm6c5ul9v0
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1773334863;JQcm6c5ul9v0;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
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
	TAGGED_FROM(0.00)[bounces-33136-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[candelatech.com:dkim,candelatech.com:email,candelatech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0882D27653B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

Safety checks in case links are not be properly cleaned up at
the time we are removing netdev debugfs.  Since link debugfs
is child of netdev debugfs, and we are about to recursively clean
up the netdev tree, be sure to null out any debugfs inode pointers
in the child links.

Root cause of the inode use-after-free is something
different, but this patch may also make system more resiliant.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/debugfs_netdev.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index bc2da35db4ae..000859b8c005 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -1037,9 +1037,33 @@ static void ieee80211_debugfs_add_netdev(struct ieee80211_sub_if_data *sdata,
 		add_link_files(&sdata->deflink, sdata->vif.debugfs_dir);
 }
 
+static void
+ieee80211_debugfs_clear_link_ptr(struct ieee80211_sub_if_data *sdata,
+				 struct dentry *dir)
+{
+	struct ieee80211_link_data *link;
+	int i;
+
+	rcu_read_lock();
+
+	if (sdata->vif.debugfs_dir == dir)
+		sdata->vif.debugfs_dir = NULL;
+
+	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
+		link = rcu_access_pointer(sdata->link[i]);
+		if (!link)
+			continue;
+
+		if (dir == link->debugfs_dir)
+			link->debugfs_dir = NULL;
+	}
+	rcu_read_unlock();
+}
+
 void ieee80211_debugfs_remove_netdev(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_link_data *link;
+	struct dentry *dir;
 	int i;
 
 	if (!sdata->vif.debugfs_dir)
@@ -1061,8 +1085,10 @@ void ieee80211_debugfs_remove_netdev(struct ieee80211_sub_if_data *sdata)
 	}
 	rcu_read_unlock();
 
-	debugfs_remove_recursive(sdata->vif.debugfs_dir);
+	dir = sdata->vif.debugfs_dir;
+	debugfs_remove_recursive(dir);
 	sdata->vif.debugfs_dir = NULL;
+	ieee80211_debugfs_clear_link_ptr(sdata, dir);
 	sdata->debugfs.subdir_stations = NULL;
 }
 
@@ -1151,7 +1177,7 @@ void ieee80211_link_debugfs_drv_remove(struct ieee80211_link_data *link)
 
 	/* Recreate the directory excluding the driver data */
 	debugfs_remove_recursive(link->debugfs_dir);
-	link->debugfs_dir = NULL;
+	ieee80211_debugfs_clear_link_ptr(link->sdata, link->debugfs_dir);
 
 	ieee80211_link_debugfs_add(link);
 }
-- 
2.42.0



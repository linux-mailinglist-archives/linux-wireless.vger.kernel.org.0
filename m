Return-Path: <linux-wireless+bounces-33024-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEj+BvP1sWl7HQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33024-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:08:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1766526B2AB
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43DEA3025EEF
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 23:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB863A16BB;
	Wed, 11 Mar 2026 23:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="pIvrzHu+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FEF3A1A2D
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270471; cv=none; b=UXlr67LdWOGontu56hWWI5abU/yt7yeP+WAmt85ul+o3MX02X4jSjqBhpucYJB5fuc9VlCYnGvpZRCehCjg0+h2I/QBBEKXXKJXWjR2MRp8YZNEIjjEqkMHZ0iqjOA4xlDz+viblvrY6s0F26dri3SBno7aR7SmMdFd1PMbKhow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270471; c=relaxed/simple;
	bh=0R5jJAHhP/WQiv0zD1p71ycvy1fv2ZNCg71PCADX6zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dckM/7qT4QXNgYt7nEDTVvQPPNeyB0ru+O+nuKF+BgQwK/3/ovTPgXCrtpNi6FnJo9M0Rghe20n61dyV+VGQwWS/gtOSPHdkM6RayipB3h4iwX2jeLpr8dcGjWuA4HZ6/2/JpocSHOW+1UcxYcesrEN470mDNMgj9lHxEyF0PoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=pIvrzHu+; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8CE7F44008D
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:41 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 78CE513C2BB;
	Wed, 11 Mar 2026 16:07:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 78CE513C2BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773270458;
	bh=0R5jJAHhP/WQiv0zD1p71ycvy1fv2ZNCg71PCADX6zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pIvrzHu+nvjLMLxxPctdjEswvgrnbe2l5jJyzoAxJ8FfTis0eyRMDYmqODQjPCj5P
	 NftSDUlGyjUGWXoZuhQ3doSOOmVB62clAKP5cTeJbgH4gPw4knRyDXwHUymtaeDBV7
	 QNz/EpCP6a/6uJ7fb4MpkxsXnqU6OlBKtlhSDkqQ=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next 10/28] wifi: mac80211: Ensure sta debugfs is not double-freed.
Date: Wed, 11 Mar 2026 16:07:12 -0700
Message-ID: <20260311230730.163348-11-greearb@candelatech.com>
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
X-MDID: 1773270462-juZ2Wdixar-G
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1773270462;juZ2Wdixar-G;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33024-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[candelatech.com:dkim,candelatech.com:email,candelatech.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1766526B2AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

I saw an instance where use-after-free was found when attempting to
delete sta's debugfs.  Add check to netdev debugfs free logic to ensure
any sta's that still exist have nulled out debugfs entries since
netdev is going to do a recursive debugfs delete.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/debugfs_netdev.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 000859b8c005..2e4bc34e6c5c 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -1063,6 +1063,8 @@ ieee80211_debugfs_clear_link_ptr(struct ieee80211_sub_if_data *sdata,
 void ieee80211_debugfs_remove_netdev(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_link_data *link;
+	struct rhashtable_iter hti;
+	struct sta_info *sta;
 	struct dentry *dir;
 	int i;
 
@@ -1083,6 +1085,28 @@ void ieee80211_debugfs_remove_netdev(struct ieee80211_sub_if_data *sdata)
 
 		link->debugfs_dir = NULL;
 	}
+
+	/* And, same for all stations.  See ieee80211_sta_debugfs_add where
+	 * they are added to the sdata->debugfs.subdir_stations directory
+	 */
+	rhashtable_walk_enter(&sdata->local->sta_hash.ht, &hti);
+	rhashtable_walk_start(&hti);
+
+	while ((sta = rhashtable_walk_next(&hti))) {
+		if (IS_ERR(sta)) {
+			if (PTR_ERR(sta) != -EAGAIN)
+				break;
+			continue;
+		}
+		if (sta->sdata != sdata)
+			continue;
+
+		sta->debugfs_dir = NULL;
+	}
+
+	rhashtable_walk_stop(&hti);
+	rhashtable_walk_exit(&hti);
+
 	rcu_read_unlock();
 
 	dir = sdata->vif.debugfs_dir;
-- 
2.42.0



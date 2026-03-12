Return-Path: <linux-wireless+bounces-33128-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNiUASjzsmmLRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33128-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:08:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75526276661
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D796C30B3DB6
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF703FBEAD;
	Thu, 12 Mar 2026 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="K2GjFR4r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D43CCFB5
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334866; cv=none; b=NzWSVIoNeVYSOIWm8QQy8l6wE3aLRJDwwOqMzknxdb14aXvRysqlb9WECEWQYPInO1lhZIkMzGaFPGXsxQ0VHEP4NCSF6GpMVW1BWajEQTQh3Mgg6kKvyEil26jtimkqF/QLl1k5X/2CT1ExnONJVD+UBB95yI1xSSIyoKvG8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334866; c=relaxed/simple;
	bh=Z+bL97X10ttZavUDhVPw3Ahdpno1vHwhYxGt+bBZ1d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKggfuVB1Kg23KpgbKvK+4BG1HZKy1+XfCRfHOASVROOErYgyKV5+1OlS+8+kGSy6SD8sIowPPWA9RZGAxtdDKi08zDIg0556j+4PSK8mbZvdtu5PP6JM61zgq59YlFnOiEE1uGGirLO5z+jPvXhPF80zffb+kUiUHMPcwEIqVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=K2GjFR4r; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id F375A340061
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:02 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 7A88C13C2B8;
	Thu, 12 Mar 2026 10:00:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7A88C13C2B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773334859;
	bh=Z+bL97X10ttZavUDhVPw3Ahdpno1vHwhYxGt+bBZ1d8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K2GjFR4roZqE8vdmq66zHv6B1kSj2ee8JjHIjpEGzIn5AFR4DqtDRFJXrlO00x9Fp
	 +vP6xrdxG+ICw0QtQBHJF40XI3qcjKAiHUBmKaKSwMJZWx54ByZljgRAPW3XljHZkX
	 reFnqS41qbIBVGMQ2Qu40tg0dEOCTsjUpqLYyjpY=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next v2 07/28] wifi: mac80211:  Fix use-after-free of debugfs inodes.
Date: Thu, 12 Mar 2026 10:00:05 -0700
Message-ID: <20260312170026.285494-8-greearb@candelatech.com>
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
X-MDID: 1773334863-W2vTJVaSkiAE
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1773334863;W2vTJVaSkiAE;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33128-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,candelatech.com:dkim,candelatech.com:email,candelatech.com:mid]
X-Rspamd-Queue-Id: 75526276661
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

When recursively removing debugfs files, clean up child link
debugfs pointers since the recursive removal will have deleted
their memory.  This fixes use-after-free problem when those child
links are eventually cleaned up.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/debugfs_netdev.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 51d2ae232a85..bc2da35db4ae 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -1039,9 +1039,28 @@ static void ieee80211_debugfs_add_netdev(struct ieee80211_sub_if_data *sdata,
 
 void ieee80211_debugfs_remove_netdev(struct ieee80211_sub_if_data *sdata)
 {
+	struct ieee80211_link_data *link;
+	int i;
+
 	if (!sdata->vif.debugfs_dir)
 		return;
 
+	/* In case where there were errors on station creation and maybe
+	 * teardown, we may get here with some links still active.  We are
+	 * about to recursively delete debugfs, so remove any pointers the
+	 * links may have.
+	 */
+	rcu_read_lock();
+
+	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
+		link = rcu_access_pointer(sdata->link[i]);
+		if (!link)
+			continue;
+
+		link->debugfs_dir = NULL;
+	}
+	rcu_read_unlock();
+
 	debugfs_remove_recursive(sdata->vif.debugfs_dir);
 	sdata->vif.debugfs_dir = NULL;
 	sdata->debugfs.subdir_stations = NULL;
-- 
2.42.0



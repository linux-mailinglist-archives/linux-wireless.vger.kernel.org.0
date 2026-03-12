Return-Path: <linux-wireless+bounces-33134-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NvVIwnzsmmLRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33134-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:08:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DE5276644
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EF7A30D0F4F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE103FCB07;
	Thu, 12 Mar 2026 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="KdD1z02M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1353FB7F8
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334867; cv=none; b=hBJcC0oABxhMTNwU357l4RzU214HcZkbzzTRBKb1oD+OEJB+3+0in+5uZJlHuyNOf27h4eSR4rEohrOMk04CNWSHYHuGtHiawR7AKqLRDyA5X/Qfih8lD/H/imU395k9jHiyc1nm/kmFKtucWHCQSg2w9A0DuISD12S27wq098o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334867; c=relaxed/simple;
	bh=0R5jJAHhP/WQiv0zD1p71ycvy1fv2ZNCg71PCADX6zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAx8Jfs3FBZNzRUJyFQmTETRlCHtjuoEJXs8S2mSpR8pwexbvFTWbmyxpb2+KCjUmBM1pngb6p+p+W89t9Dn8f2Cvrl1c+qePj5qyrr6kHSWBaABxraB3/d1/ZUWIfAXzUcVloJ9uMPnZVazvF33IALl5DKnDtx8WONHmZtHiSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=KdD1z02M; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5A4BAC00FC
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:03 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 32F6913C2BB;
	Thu, 12 Mar 2026 10:01:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 32F6913C2BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773334860;
	bh=0R5jJAHhP/WQiv0zD1p71ycvy1fv2ZNCg71PCADX6zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KdD1z02MGC0nCgg2gydXg6YPa++sV+v4qcA2xFVCkoKeb+dUCNeoE6I8BXgOu1gTT
	 xsU6SkzFCoiMML0qtlVxU2mdKaXcUV15Je/S+xA2HI6VtnDSR1RXJA7rxH4SIo8a3o
	 uXUJMjHCyPYcL8t6rVaJrbdvSt6oY17QoTa0vVCo=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next v2 10/28] wifi: mac80211: Ensure sta debugfs is not double-freed.
Date: Thu, 12 Mar 2026 10:00:08 -0700
Message-ID: <20260312170026.285494-11-greearb@candelatech.com>
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
X-MDID: 1773334864-2x0lt6njx9r0
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1773334864;2x0lt6njx9r0;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33134-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,candelatech.com:dkim,candelatech.com:email,candelatech.com:mid]
X-Rspamd-Queue-Id: 07DE5276644
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



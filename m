Return-Path: <linux-wireless+bounces-32391-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPBHGcbrpmnjZgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32391-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:10:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 081911F11BC
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C793C3065FF7
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 14:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178A334F495;
	Tue,  3 Mar 2026 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WFDoAUlA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD3E37186E
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546629; cv=none; b=d/szmLZD6Ls1vLm30E6ye7TzJpzKUF1pIDrQH0FCQb28eA5wVehJ8ZS3co56ahIby0VGzBKKqtOqzhzh9QYe4DyCxBmPoEaY9IqpvR1rkQvff0abu/sVUnR62A8IK5IynwCKtuN0s/xtNQS+C3JMntZ0TeWENKby4zgJ1iIvb4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546629; c=relaxed/simple;
	bh=Re2AUIi4Nhh7dylvkd0YqKAoBVB5T2HUVH5aeeQ3SrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PNZ905g7GR3KRE+d0OHb2WHDJ+KX6WUhHfp1z2nkwYyqMTKl3tl2mtxpDlo59cEXF5QM0H7yGsFHlvBccL54V9VGH5//cLV3kJjFxgbVWjxGOQRsiBXY2FQCQRbIX7KqxJLGm+Y7/LYX22YEkob6CLLOfakT19Jn9qPfTVBf/C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WFDoAUlA; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=DTBllASnm3jspjLyUNMEKpecLBFvKsK1FBVhkE+DmxI=; t=1772546627; x=1773756227; 
	b=WFDoAUlAuk56HjY5TagGcHKWNObILWsLRhpaJA/llcOSYDx1Ip5EvyYfDkIvPrShvG4+QNsE/se
	P3MqMzm7TJ6EInUaDd1o/rtA/I8P84JuYoVpNFW99or7vtiMjXsDeC8A2d7tMl/zFRvnNQgmpylpA
	yiT58WDaGeX/qYCClvgP/GoyCuVgPNH5Oa6Rj0CM2q2bh5EUPWPYdrUOZat45d58yNe3WNPFCxCYv
	/GQYJIy+XOeXLTI+B3aXbYL+7oJZ0nv6f/C12grX3Pa/ihligW2Mg0SpFwEa8jgRxhPXR2XNpVYlt
	TINqfLAnNvctmv2tbDJBJg9nmwgQSmrN0KIQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxQLe-000000078uQ-05iU;
	Tue, 03 Mar 2026 15:03:43 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless] wifi: mac80211: remove keys after disabling beaconing
Date: Tue,  3 Mar 2026 15:03:39 +0100
Message-ID: <20260303150339.574e7887b3ab.I50d708f5aa22584506a91d0da7f8a73ba39fceac@changeid>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 081911F11BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-32391-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

We shouldn't remove keys before disable beaconing, at least when
beacon protection is used, since that would remove keys that are
still used for beacon transmission at the same time. Stop before
removing keys so there's no race.

Fixes: af2d14b01c32 ("mac80211: Beacon protection using the new BIGTK (STA)")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b92b4a5c2636..b85375ceb575 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1904,12 +1904,6 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 
 	__sta_info_flush(sdata, true, link_id, NULL);
 
-	ieee80211_remove_link_keys(link, &keys);
-	if (!list_empty(&keys)) {
-		synchronize_net();
-		ieee80211_free_key_list(local, &keys);
-	}
-
 	ieee80211_stop_mbssid(sdata);
 	RCU_INIT_POINTER(link_conf->tx_bss_conf, NULL);
 
@@ -1921,6 +1915,12 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	ieee80211_link_info_change_notify(sdata, link,
 					  BSS_CHANGED_BEACON_ENABLED);
 
+	ieee80211_remove_link_keys(link, &keys);
+	if (!list_empty(&keys)) {
+		synchronize_net();
+		ieee80211_free_key_list(local, &keys);
+	}
+
 	if (sdata->wdev.links[link_id].cac_started) {
 		chandef = link_conf->chanreq.oper;
 		wiphy_hrtimer_work_cancel(wiphy, &link->dfs_cac_timer_work);
-- 
2.53.0



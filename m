Return-Path: <linux-wireless+bounces-32415-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFMhN60Up2ncdQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32415-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 18:04:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4387D1F4610
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 18:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ECE1301D6BB
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 16:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E8734F46E;
	Tue,  3 Mar 2026 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="nwPKoyHI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DD03BD622
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772557168; cv=none; b=GWaKahnH+9b9vaCNg7FLZSbtzJoH8ojRt7P4w7Fr3vA8UF10HE4jVUDWV4jMgXwIOFlOMbmVxGxt3jXv1YEk+rwlI0dszOwF6wxxunHSYvzJJb4GkSjFFy8siDwtQg7uDDO8nAJeFWfQ7PXp1ZM2L90sCmYhj/L+bTK2jrCOkt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772557168; c=relaxed/simple;
	bh=vJq+WbDR8OrsJV5qyfCb43XT9E2w9Xr0/w+Ah23ZH4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQpVJIkUCgU4j2rpVr2zKVwAnv9RAnU/uQXGhvwDFK02NGMRbi1UPpBogrFwgtaBbwZw4GAXpGJ4HnZExrSYd98aPbsBWKTMt3pdc+ihxVeUoswrIwPLjuZu6bAbhQEGNx89LoYArHlD51/smtf5PC62ZmVNIJGhpqF5ST3l1ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=nwPKoyHI; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 51bc0c39-1722-11f1-969b-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 51bc0c39-1722-11f1-969b-005056abbe64;
	Tue, 03 Mar 2026 17:59:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=pq8fyeoRZOgQL3KQm3S8JZ0D+k426q1CN95l7TG/gKU=;
	b=nwPKoyHIRUjpbXDteJ7cePphGKM6hyDQTWrhrX59uqxOVCl7gdtuTCE5dQR8ELk4Cr8i8TMdQOWxw
	 cOl0t31CVcoYpc+mn2TAZ+2P4iOie6IICMorOyr1BxNsKfRfmRtzHYRfcebyTuDSO/u3pquxt2PBd6
	 bwp3j7zN6bxNJ/GbPUep5IXGqgvaW32T3mdBPXWi0DccoNGkrp70ssh5b6g6fGXsx9jozSr8aZpHrQ
	 Fv1b7fikFZh6K2NbatMlVALSDUJcHvs70YM3Iy9XFA77NpfESeZ4rGTMaNhKfb4QDeD2HWp9+eYyqy
	 775mVOs8Cv7BiZo1j53zR13lGjVfVTA==
X-KPN-MID: 33|iB3+2Alen2yo2BvGDXaoS0csobFlWVulyAcRTKJgXZibVSlhhH3Iv5yIigrxWQD
 p2+0Wm3t6Fo3xbU/C2tU1abWuGhhlbxTzPKDqHwd6S4o=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|aFAbJlvvW1Wf+JTBf2ux0S6Q2QYZUfCmdAPFSR0hgxK0waU7z4EDOny8mXT0rzY
 pal45Sa5qwtkTj80eGMR+/A==
Received: from daedalus.home (unknown [178.230.196.166])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 4f08e9f5-1722-11f1-b8e2-005056ab7584;
	Tue, 03 Mar 2026 17:59:19 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-wireless@vger.kernel.org (open list:MAC80211),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mac80211_hwsim: change hwsim_class to a const struct
Date: Tue,  3 Mar 2026 17:59:37 +0100
Message-ID: <20260303165938.3773998-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4387D1F4610
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	FREEMAIL_CC(0.00)[xs4all.nl,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-32415-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,xs4all.nl:dkim,xs4all.nl:email,xs4all.nl:mid]
X-Rspamd-Action: no action

The class_create() call has been deprecated in favor of class_register()
as the driver core now allows for a struct class to be in read-only
memory. Change hwsim_class to be a const struct class and drop the
class_create() call.

Link: https://lore.kernel.org/all/2023040244-duffel-pushpin-f738@gregkh/

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index e89173f91637..506f865075b1 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -337,7 +337,9 @@ static inline void hwsim_net_set_wmediumd(struct net *net, u32 portid)
 	hwsim_net->wmediumd = portid;
 }
 
-static struct class *hwsim_class;
+static const struct class hwsim_class = {
+	.name	= "mac80211_hwsim"
+};
 
 static struct net_device *hwsim_mon; /* global monitor netdev */
 
@@ -5424,7 +5426,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	data = hw->priv;
 	data->hw = hw;
 
-	data->dev = device_create(hwsim_class, NULL, 0, hw, "hwsim%d", idx);
+	data->dev = device_create(&hwsim_class, NULL, 0, hw, "hwsim%d", idx);
 	if (IS_ERR(data->dev)) {
 		printk(KERN_DEBUG
 		       "mac80211_hwsim: device_create failed (%ld)\n",
@@ -5978,7 +5980,7 @@ static void mac80211_hwsim_free(void)
 		spin_lock_bh(&hwsim_radio_lock);
 	}
 	spin_unlock_bh(&hwsim_radio_lock);
-	class_destroy(hwsim_class);
+	class_unregister(&hwsim_class);
 }
 
 static const struct net_device_ops hwsim_netdev_ops = {
@@ -7083,11 +7085,9 @@ static int __init init_mac80211_hwsim(void)
 	if (err)
 		goto out_exit_netlink;
 
-	hwsim_class = class_create("mac80211_hwsim");
-	if (IS_ERR(hwsim_class)) {
-		err = PTR_ERR(hwsim_class);
+	err = class_register(&hwsim_class);
+	if (err)
 		goto out_exit_virtio;
-	}
 
 	hwsim_init_s1g_channels(hwsim_channels_s1g);
 

base-commit: d466c332e106fe666d1e2f5a24d08e308bebbfa1
-- 
2.53.0



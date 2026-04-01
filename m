Return-Path: <linux-wireless+bounces-34280-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P2VIaxSzWmnbwYAu9opvQ
	(envelope-from <linux-wireless+bounces-34280-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 19:15:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E69E637E7F1
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Apr 2026 19:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6688F3180AC5
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2026 17:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7D336AB54;
	Wed,  1 Apr 2026 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="L3b+W/rL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C2343E9D6
	for <linux-wireless@vger.kernel.org>; Wed,  1 Apr 2026 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062844; cv=none; b=N804tgZ7YOLorBI8XmODRU3PTHgZFa62iX657jWf2+6VrcDhZLlswCxErGSC+II28Z2CfxaLYyG68DzFPaIZFNh3J99USr1Bd7CiphPSNKhGoUS+1dVIeVRM4uzEP9ptFrIdkPldQCZxm+SN+O03wwQc5Jiv8Zgn7Pun3ZGqhCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062844; c=relaxed/simple;
	bh=vJq+WbDR8OrsJV5qyfCb43XT9E2w9Xr0/w+Ah23ZH4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AhLJgmtESSGk0ZuzSlQ7si6rQ20Z5iwWJsypja+/0QWW1NRTPRdt16x69YHuFIOAqKb/bLU4y+u7Y3pFSjlBwB3+8DU8iJYo2LFkQ8UwCUGXzQrRzffdTpndRSV6vmHgvj9JT5qzemelJJLUBnXDcW+F81hnZ2+S1f8i14BaDBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=L3b+W/rL; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 28c13c06-2dec-11f1-b185-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 28c13c06-2dec-11f1-b185-005056abad63;
	Wed, 01 Apr 2026 18:59:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=pq8fyeoRZOgQL3KQm3S8JZ0D+k426q1CN95l7TG/gKU=;
	b=L3b+W/rLb+2WLT5DbWuK/P8oBSbyFesW/CN13heZO1tq6k5ZWkpR6gs+woTQXi0G7I0DmIPQau6wN
	 LvX5L9Xr4uNlKMFHtIB81hWXmFvf1jAAPqVIQnL0krASqiraVYQDyYcBT67KPT1/AaeNaMZJN+MEeY
	 CyIy8s8oTsfVLYXTHaYm8IUxUpFi9AdfVs5GdhPqwje31hpBV04Hx/wfyTA336hhS2HJRklrkQWImP
	 iGtyhZvSBo0iGaqEhycRC2Im9vXp1lOxriWaZq8EqMkO59Eii+TLVeL8LqQ0pVXqby+euzPin4WIm1
	 AchW7Xnv9Lx0ByNCq+Q+/ZjlUTLrurQ==
X-KPN-MID: 33|LSD0yulFrQa9lcJoWehBYU19fU7DBHXDohtTuutw6UFyPWkHLnltD1b8JduCR0R
 efUIeLXgPqRsqL2cEEUxM5Q==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|qQ9ibsLMa+AouB7DlQ9uxspn7eFCF09e1kMqs9nDBfk8+JQBpQhfEIocNNUTW/K
 JoSeKUxdQTTV/xPjPlbFDiw==
Received: from daedalus.home (unknown [178.227.141.37])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 25fcbae0-2dec-11f1-a6cc-005056abf0db;
	Wed, 01 Apr 2026 18:59:34 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-wireless@vger.kernel.org (open list:MAC80211),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mac80211_hwsim: change hwsim_class to a const struct
Date: Wed,  1 Apr 2026 18:59:37 +0200
Message-ID: <20260401165938.3843784-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-34280-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xs4all.nl:dkim,xs4all.nl:email,xs4all.nl:mid]
X-Rspamd-Queue-Id: E69E637E7F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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



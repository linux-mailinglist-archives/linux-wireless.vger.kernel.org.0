Return-Path: <linux-wireless+bounces-38701-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /lPSDgPLS2praQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38701-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 17:34:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F2B712A53
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 17:34:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bluw3o8d;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38701-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38701-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC3953042BAE
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2203876DE;
	Mon,  6 Jul 2026 15:24:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB743803C4
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 15:24:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351468; cv=none; b=D4D4prTcs7y0KmRg8ciY7pjUIAZ6iNC3uiBKDTY+d6T5dMVi237I6gPHCBzNuap9bgGJs0CiJjExd0hT9gwzyITHXEuxF64D4o4qen3nrAVSY9Dxh/e7tuoUdREp5tIxlcxj2J6Cw1yLRqSekgaJ+KeCfOpvOP/Ds2L5rpM3iug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351468; c=relaxed/simple;
	bh=WAZyh8iTwhnsZaoAC/QftPEu8NMQFMip181JBFbQpjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hW9aE0PogtZKMOgga/cspf3Z8urq8whieFqI8PodIu9EDCGTGok8XgwdPzmQRZ4H4f7JGHZ278qpLkOn28Jr9OKNKAK17iEsan4T5yWqZ+EDXJTr7xHudKaPXZVbzC6FO9ot+qA77EDUA84AEZKqj/cHjETZHGPW6l3+fPncQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bluw3o8d; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cad8076b01so41042015ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 08:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783351466; x=1783956266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IP0fMjDVbSttpn2ImHSgGtkbct1faOHVV/jYyyvxQ5c=;
        b=bluw3o8dC8Okpg8AyNZhR2vfLywcTJNSGDxc+L08TT7JhUpMPoem1UdZ7/RU/t2oJw
         79T0Va/xPlB5NL1kyFJiKR5STTfkutD0JrG5FnserbKEtSt9/4+0LpR64o39brKfYGov
         ney/5D5O6bbF5RiUn/Ih9nywVUJwZw/FvUtKEBalDXouC1pk0Xv9fBPBSl7FfrB0tTjH
         ZYoQQBmeVVRZrOgDXFKRHpip6aj7as840T8hWm4aMIeO3oWm+6kEWO3Zv3Vl0DTLpv7r
         nVuBQU12ZcdwX8Le8F3A/fX+DIinpgUyP7iDOyygt3GRmTO7aW23TtDNsUkRP+03pLW2
         cWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783351466; x=1783956266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IP0fMjDVbSttpn2ImHSgGtkbct1faOHVV/jYyyvxQ5c=;
        b=hCjfslGDd2bmvca7zHhvCbQ0oZq5mk1WYpFkLjGRvpTDsv3L31NSR07ks6+es+OfO9
         KSjTdSyOKp/p0J/TxXQiZBdXv7ozwh0fw9MRb1szIVxCylya6NM4XbOgt8uJ34iLWwmN
         SVS9ODMwyewCSyJVxBnwsET1G/bb51IcA6TuYC5IEJptwtcgkwSiR/gRLNr9n0GRmmKe
         1TGZqAPlfGMZFVbqHHfpzb5IVrpq8iRRfDm9VrQ2KqycCw2tQSuheTaj2XlScBD1Z5G3
         gLt2OgeMQHKsqaZEWXekpPLWvaY90dTbTZB+CYV99a6K37JFdcIemkT8vrelaRCLD8tj
         c+3g==
X-Gm-Message-State: AOJu0YyE6bndhwY/E3Ct08huDgszI8KJCTraul1lVGUW/LSg08onw7aG
	MqVdiDCos2tIh0tMniWCap0HDH/aI4p9mpg/ErHqK4kvttLs32herZlq
X-Gm-Gg: AfdE7cl5kx9b6FeHjPV6SjlVh6vdtek19XtSEh3ujVCws7K6m107XZhzVkAmy2XLixY
	EnxCZApjWehk9AQgkIG7kSqLXEfRk1NvOhtEHmCF3y9gSUBoIMI7MQ1VuEZ5ogsrjZXrijWecEE
	j0Yd8YLWy5lLHdOdqqbiwDBiAMyCLjby/oKgFzg7mgHKbeSc+jQbhIEHdb3oQmk3hk7K9hhr8q7
	PRJUYJWi813b8QzmOqp1cwrsHYcxr6/t7tXbuc5rcWSYUiSvWFZrgZ2ajtoL7ZBnRzWMshLgJ6R
	5MIJXUCiINnO9PHFjIrOpnwdJiUFFlbFGC5z47wK3l+3qrfXpSslFWUPvG+xzgIsPEPRilQFF3f
	1kp1C6+Zhfg4L2PEfKFMWaqdimKVhusy33U9ZWHnAyrP7H51NiCJCRzb9aE1tAY6aatMjsbgwHL
	bDu2skdy9xlpn/aRopNA==
X-Received: by 2002:a17:903:198e:b0:2ca:10fe:a30 with SMTP id d9443c01a7336-2ccbf2c086amr10717565ad.47.1783351466237;
        Mon, 06 Jul 2026 08:24:26 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7875d54sm52586995ad.69.2026.07.06.08.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:24:25 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zzzccc427@gmail.com,
	baijiaju1990@gmail.com
Subject: [PATCH v2] wifi: cfg80211: use wiphy work for socket owner autodisconnect
Date: Mon,  6 Jul 2026 23:24:18 +0800
Message-Id: <20260706152418.779226-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-38701-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zzzccc427@gmail.com,m:baijiaju1990@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2F2B712A53

nl80211_netlink_notify() walks the cfg80211 wireless device list when a
NETLINK_GENERIC socket is released. If the socket owns a connection, the
notifier queues the embedded wdev->disconnect_wk work item.

That work is a plain work_struct today. NETDEV_GOING_DOWN cancels it, but a
NETLINK_URELEASE notifier that already observed conn_owner_nlportid can
queue it after that cancel returns. _cfg80211_unregister_wdev() then
removes the wdev from the list and waits for RCU readers, but
synchronize_net() does not drain work queued by such a reader.

Make the autodisconnect work a wiphy_work instead. The callback already
needs the wiphy mutex, and wiphy_work runs under that mutex. This lets
teardown cancel pending autodisconnect work while holding the mutex,
without a cancel_work_sync() vs. worker locking concern.

Also cancel the wiphy work after list_del_rcu() and synchronize_net(). Any
NETLINK_URELEASE notifier that had already reached the wdev list has then
either queued the work and it is removed, or can no longer find the wdev.

Fixes: bd2522b16884 ("cfg80211: NL80211_ATTR_SOCKET_OWNER support for CMD_CONNECT")
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
v2:
- Convert the autodisconnect work to wiphy_work instead of taking RTNL in
  nl80211_netlink_notify().
- Add a final wiphy_work_cancel() after list_del_rcu()/synchronize_net().

 include/net/cfg80211.h |  2 +-
 net/wireless/core.c    | 10 ++++++----
 net/wireless/core.h    |  2 +-
 net/wireless/nl80211.c |  3 ++-
 net/wireless/sme.c     |  6 ++----
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8188ad200de5..76827c965f41 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7228,7 +7228,7 @@ struct wireless_dev {
 	enum ieee80211_bss_type conn_bss_type;
 	u32 conn_owner_nlportid;
 
-	struct work_struct disconnect_wk;
+	struct wiphy_work disconnect_wk;
 	u8 disconnect_bssid[ETH_ALEN];
 
 	struct list_head event_list;
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 3dcf63b04c41..de86464695ba 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1424,6 +1424,7 @@ static void _cfg80211_unregister_wdev(struct wireless_dev *wdev,
 	list_del_rcu(&wdev->list);
 	synchronize_net();
 	rdev->devlist_generation++;
+	wiphy_work_cancel(wdev->wiphy, &wdev->disconnect_wk);
 
 	cfg80211_mlme_purge_registrations(wdev);
 
@@ -1637,7 +1638,7 @@ void cfg80211_init_wdev(struct wireless_dev *wdev)
 	     wdev->iftype == NL80211_IFTYPE_ADHOC) && !wdev->use_4addr)
 		wdev->netdev->priv_flags |= IFF_DONT_BRIDGE;
 
-	INIT_WORK(&wdev->disconnect_wk, cfg80211_autodisconnect_wk);
+	wiphy_work_init(&wdev->disconnect_wk, cfg80211_autodisconnect_wk);
 }
 
 void cfg80211_register_wdev(struct cfg80211_registered_device *rdev,
@@ -1743,10 +1744,11 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		break;
 	case NETDEV_GOING_DOWN:
 		cfg80211_leave(rdev, wdev, -1);
-		scoped_guard(wiphy, &rdev->wiphy)
+		scoped_guard(wiphy, &rdev->wiphy) {
 			cfg80211_remove_links(wdev);
-		/* since we just did cfg80211_leave() nothing to do there */
-		cancel_work_sync(&wdev->disconnect_wk);
+			/* since we just did cfg80211_leave() nothing to do there */
+			wiphy_work_cancel(wdev->wiphy, &wdev->disconnect_wk);
+		}
 		cancel_work_sync(&wdev->pmsr_free_wk);
 		break;
 	case NETDEV_DOWN:
diff --git a/net/wireless/core.h b/net/wireless/core.h
index df47ed6208a5..f343d1074ace 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -428,7 +428,7 @@ void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *peer_addr,
 				const u8 *td_bitmap, u8 td_bitmap_len);
 int cfg80211_mgd_wext_connect(struct cfg80211_registered_device *rdev,
 			      struct wireless_dev *wdev);
-void cfg80211_autodisconnect_wk(struct work_struct *work);
+void cfg80211_autodisconnect_wk(struct wiphy *wiphy, struct wiphy_work *work);
 
 /* SME implementation */
 void cfg80211_conn_work(struct work_struct *work);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 53b4b3f76697..153a9e8f35eb 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -22942,7 +22942,8 @@ static int nl80211_netlink_notify(struct notifier_block * nb,
 				wdev->nl_owner_dead = true;
 				schedule_work(&rdev->destroy_work);
 			} else if (wdev->conn_owner_nlportid == notify->portid) {
-				schedule_work(&wdev->disconnect_wk);
+				wiphy_work_queue(wdev->wiphy,
+						 &wdev->disconnect_wk);
 			}
 
 			cfg80211_release_pmsr(wdev, notify->portid);
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index b451df3096dd..2a719b5c487e 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1578,13 +1578,11 @@ int cfg80211_disconnect(struct cfg80211_registered_device *rdev,
  * Used to clean up after the connection / connection attempt owner socket
  * disconnects
  */
-void cfg80211_autodisconnect_wk(struct work_struct *work)
+void cfg80211_autodisconnect_wk(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct wireless_dev *wdev =
 		container_of(work, struct wireless_dev, disconnect_wk);
-	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
-
-	guard(wiphy)(wdev->wiphy);
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
 	if (wdev->conn_owner_nlportid) {
 		switch (wdev->iftype) {
-- 
2.43.0


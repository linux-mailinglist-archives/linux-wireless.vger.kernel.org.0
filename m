Return-Path: <linux-wireless+bounces-13125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5C6984B8A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 21:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0DFD1C2310E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 19:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5621B85F1;
	Tue, 24 Sep 2024 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="ydr1nkcq";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="ga++934y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i110.smtp2go.com (e3i110.smtp2go.com [158.120.84.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7D1A4F0C
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727206048; cv=none; b=AdhkY3CIZg/LZQw+62GxuwwHnyL7RaREX2YR5U+QueCEoAwWNgP6RGD5WAJRalTMbp56qwVI2NVRLCLnpe+4cZw+riW7i/6OkbbdK0c28GjhoccLVKQNTyqcCdhRMppsyZFCcAQbjBdsHkEvKlmQCJNVlK+rT08qNbV70PEHEoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727206048; c=relaxed/simple;
	bh=9gCvAmkQ+McMEqsM1XwBcX6PfPT1TaDQAb9TmK5M5vA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kQmLAQa0YvODdXUEeYKm58WHeIgGULrr/F/wp3ww1Bsn0FnI4o8CcX+vWQYPlxjQ9yANs8ZETAMsZuxdKAA4CGBUemuROy/WogUSTPYxqF12XIqDQHtLUtM49K+MRX//Ut+FkOicYuuQlFDyEef9J1A//7MEHtETd38BnsojrG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=ydr1nkcq; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=ga++934y; arc=none smtp.client-ip=158.120.84.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1727206039; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=r7mBfgbkSHPGjlsNaa8FSid+n6LiX6fLZWRk2WuEUPE=;
 b=ydr1nkcqmYqIlG8qlYfNHpdDrfgYvNstOb58GO+lCgzA6BEymXhZ3JKqEvbJlB+cF9TY+
 Dc7ubGwzAfBSvAqy1S8Ry032EBwn4dmLlzzwu/oEslZeullE4bxffyeET+s1mi4c2QKc85I
 h3Ve1VESTKC7nRgBFl2CVOy12FDovDul2I04tU4p8bJhuuHOZwNAVjBxoGF3a/RhIvvwrA+
 SKGjao1gwld6GMHgS9RCtMFcFX95lQaPTcCFr71qOO3OypWlvKH0msbQRUnmIzj7Goq0wiF
 /Cs7Wa7rw4q0yL5SF93vfDM8kwux7VubPVQ+4HZsLH4CcD0vkt5WbIXLumnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1727206039; h=from : subject
 : to : message-id : date;
 bh=r7mBfgbkSHPGjlsNaa8FSid+n6LiX6fLZWRk2WuEUPE=;
 b=ga++934ywl8PpQ7kK9wvykDn6g3lvV7ldGiqy+sUJ12Jn/YiC0G1PD+TIPq/E97Uw/2/8
 JeBS44fJS1Nw+Mr6eGri0V6t4u27kPcRuRan3cb0wP04pSGMBFJoz0ccLtkUyYFNj6ON/Pr
 eZlHqJR+FHgzOiE+1U6yF7wIM4OXOA1LMBj3DDlQRvNA8VtvemPeyt+NbgwuSVIvWmGr5rs
 FiYasX9DzWFC0h6C+RS5a10xhfXFShJcPfbf6oQawVYdoQ8XobAw7BnAPNbQrL8GeCFN6ve
 GmgTi5noveVwmQrdUSYbbcHzoc+ZII7p0lAcL59dfpcXhRmZMdemJVMEkgMA==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1stBBs-4o5NDgruoYJ-mxiC;
	Tue, 24 Sep 2024 19:27:16 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>,
	Nicolas Escande <nescande@freebox.fr>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 2/2] wifi: mac80211: Convert color collision detection to wiphy work
Date: Tue, 24 Sep 2024 21:28:05 +0200
Message-Id: <20240924192805.13859-3-repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20240924192805.13859-1-repk@triplefau.lt>
References: <20240924192805.13859-1-repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616seT2XkfLmR
X-smtpcorp-track: NyqcqcWION9C.YbycEVi8QH6j.yY45yQ4zncR

Call to ieee80211_color_collision_detection_work() needs wiphy lock to
be held (see lockdep assert in cfg80211_bss_color_notify()). Not locking
wiphy causes the following lockdep error:

  WARNING: CPU: 2 PID: 42 at net/wireless/nl80211.c:19505 cfg80211_bss_color_notify+0x1a4/0x25c
  Modules linked in:
  CPU: 2 PID: 42 Comm: kworker/u8:3 Tainted: G        W          6.4.0-02327-g36c6cb260481 #1048
  Hardware name:
  Workqueue: phy1 ieee80211_color_collision_detection_work
  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : cfg80211_bss_color_notify+0x1a4/0x25c
  lr : cfg80211_bss_color_notify+0x1a0/0x25c
  sp : ffff000002947d00
  x29: ffff000002947d00 x28: ffff800008e1a000 x27: ffff000002bd4705
  x26: ffff00000d034000 x25: ffff80000903cf40 x24: 0000000000000000
  x23: ffff00000cb70720 x22: 0000000000800000 x21: ffff800008dfb008
  x20: 000000000000008d x19: ffff00000d035fa8 x18: 0000000000000010
  x17: 0000000000000001 x16: 000003564b1ce96a x15: 000d69696d057970
  x14: 000000000000003b x13: 0000000000000001 x12: 0000000000040000
  x11: 0000000000000001 x10: ffff80000978f9c0 x9 : ffff0000028d3174
  x8 : ffff800008e30000 x7 : 0000000000000000 x6 : 0000000000000028
  x5 : 000000000002f498 x4 : ffff00000d034a80 x3 : 0000000000800000
  x2 : ffff800016143000 x1 : 0000000000000000 x0 : 0000000000000000
  Call trace:
   cfg80211_bss_color_notify+0x1a4/0x25c
   ieee80211_color_collision_detection_work+0x20/0x118
   process_one_work+0x294/0x554
   worker_thread+0x70/0x440
   kthread+0xf4/0xf8
   ret_from_fork+0x10/0x20
  irq event stamp: 77372
  hardirqs last  enabled at (77371): [<ffff800008a346fc>] _raw_spin_unlock_irq+0x2c/0x4c
  hardirqs last disabled at (77372): [<ffff800008a28754>] el1_dbg+0x20/0x48
  softirqs last  enabled at (77350): [<ffff8000089e120c>] batadv_send_outstanding_bcast_packet+0xb8/0x120
  softirqs last disabled at (77348): [<ffff8000089e11d4>] batadv_send_outstanding_bcast_packet+0x80/0x120

The wiphy lock cannot be taken directly from color collision detection
delayed work (ieee80211_color_collision_detection_work()) because this
work is cancel_delayed_work_sync() under this wiphy lock causing a
potential deadlock( see [0] for details).

To fix that ieee80211_color_collision_detection_work() could be
converted to a wiphy work and cancel_delayed_work_sync() can be simply
replaced by wiphy_delayed_work_cancel() serving the same purpose under
wiphy lock.

This could potentially fix [1].

[0]: https://lore.kernel.org/linux-wireless/D4A40Q44OAY2.W3SIF6UEPBUN@freebox.fr/
[1]: https://lore.kernel.org/lkml/000000000000612f290618eee3e5@google.com/

Reported-by: Nicolas Escande <nescande@freebox.fr>
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/mac80211/cfg.c         | 17 +++++++++--------
 net/mac80211/ieee80211_i.h |  5 +++--
 net/mac80211/link.c        |  7 ++++---
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b02b84ce2130..09025d59cdbe 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4819,12 +4819,12 @@ void ieee80211_color_change_finalize_work(struct wiphy *wiphy,
 	ieee80211_color_change_finalize(link);
 }
 
-void ieee80211_color_collision_detection_work(struct work_struct *work)
+void ieee80211_color_collision_detection_work(struct wiphy *wiphy,
+					      struct wiphy_work *work)
 {
-	struct delayed_work *delayed_work = to_delayed_work(work);
 	struct ieee80211_link_data *link =
-		container_of(delayed_work, struct ieee80211_link_data,
-			     color_collision_detect_work);
+		container_of(work, struct ieee80211_link_data,
+			     color_collision_detect_work.work);
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 
 	cfg80211_obss_color_collision_notify(sdata->dev, link->color_bitmap,
@@ -4877,7 +4877,8 @@ ieee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
 		return;
 	}
 
-	if (delayed_work_pending(&link->color_collision_detect_work)) {
+	if (wiphy_delayed_work_pending(sdata->local->hw.wiphy,
+				       &link->color_collision_detect_work)) {
 		rcu_read_unlock();
 		return;
 	}
@@ -4886,9 +4887,9 @@ ieee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
 	/* queue the color collision detection event every 500 ms in order to
 	 * avoid sending too much netlink messages to userspace.
 	 */
-	ieee80211_queue_delayed_work(&sdata->local->hw,
-				     &link->color_collision_detect_work,
-				     msecs_to_jiffies(500));
+	wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+				 &link->color_collision_detect_work,
+				 msecs_to_jiffies(500));
 
 	rcu_read_unlock();
 }
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a3485e4c6132..8650b3e8f1a9 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1051,7 +1051,7 @@ struct ieee80211_link_data {
 	} csa;
 
 	struct wiphy_work color_change_finalize_work;
-	struct delayed_work color_collision_detect_work;
+	struct wiphy_delayed_work color_collision_detect_work;
 	u64 color_bitmap;
 
 	/* context reservation -- protected with wiphy mutex */
@@ -2004,7 +2004,8 @@ int ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 /* color change handling */
 void ieee80211_color_change_finalize_work(struct wiphy *wiphy,
 					  struct wiphy_work *work);
-void ieee80211_color_collision_detection_work(struct work_struct *work);
+void ieee80211_color_collision_detection_work(struct wiphy *wiphy,
+					      struct wiphy_work *work);
 
 /* interface handling */
 #define MAC80211_SUPPORTED_FEATURES_TX	(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | \
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 1a211b8d4057..67f65ff79a71 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -41,8 +41,8 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 			ieee80211_csa_finalize_work);
 	wiphy_work_init(&link->color_change_finalize_work,
 			ieee80211_color_change_finalize_work);
-	INIT_DELAYED_WORK(&link->color_collision_detect_work,
-			  ieee80211_color_collision_detection_work);
+	wiphy_delayed_work_init(&link->color_collision_detect_work,
+				ieee80211_color_collision_detection_work);
 	INIT_LIST_HEAD(&link->assigned_chanctx_list);
 	INIT_LIST_HEAD(&link->reserved_chanctx_list);
 
@@ -70,7 +70,8 @@ void ieee80211_link_stop(struct ieee80211_link_data *link)
 	if (link->sdata->vif.type == NL80211_IFTYPE_STATION)
 		ieee80211_mgd_stop_link(link);
 
-	cancel_delayed_work_sync(&link->color_collision_detect_work);
+	wiphy_delayed_work_cancel(link->sdata->local->hw.wiphy,
+				  &link->color_collision_detect_work);
 	wiphy_work_cancel(link->sdata->local->hw.wiphy,
 			  &link->color_change_finalize_work);
 	wiphy_work_cancel(link->sdata->local->hw.wiphy,
-- 
2.46.0



Return-Path: <linux-wireless+bounces-14860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A19DD9BB192
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 11:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D83283F02
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 10:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0221B4F0C;
	Mon,  4 Nov 2024 10:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV4HLTha"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E63F1B4F08;
	Mon,  4 Nov 2024 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717454; cv=none; b=V0MNvNCyCl0SUPXiOb9p3kaNdGbuRdFa/zdzyUJK3CtYVsNKov3Xy6Vq5YxFNquAR+mKVeQIlq09aNds7mQF61yVaHhFkRGi+sUyJKOA9jtEMjspqojVgje1/J3VslWWJZzpAZwIPqHNLMnYrFStVfCaiO/wc/rO4TE6GhywHoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717454; c=relaxed/simple;
	bh=yg78Aovvt6CDk/KuidlXlT/LKDHynKGvzg+rLkvHDaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K67qkHXdfelzCtLqanhythsFPqo8QBDLwfgzQ+R42sxfWO+YIz7oQ+2QWfQxzAGjcCp2qKg/D5/WSeCgwEcPYONXmOa17GM+SNm9QHsDuERP7Dc8jV2VCvET1+PU22SSBctJvqzX64dg2RPnx9J74DEKbU4Jgv10XHb8zXpCUmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VV4HLTha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FF0C4AF09;
	Mon,  4 Nov 2024 10:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717453;
	bh=yg78Aovvt6CDk/KuidlXlT/LKDHynKGvzg+rLkvHDaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VV4HLThaNPUyKejcEIjQpt4Pz12p2mwoepBP0BqB79A5VdsXzfVtJoQwsvX5HvGbB
	 EGjXeTGGXMzI4KsMGX/f1jAeB3dJTNF5ZYXBndvzccm2GmsUhZTCoCthSYidNWBYIF
	 AVbbPgMo32WSMTsf/EZFEKHi8ST+44TBtefxJmIJDnR2SGXIobwG5O3LO4JGN4looH
	 VYotnJLlOhpGfIwz/+xWHStnQ11AT68Rz0IobyVzSlS2u/W0pLOHj+2QvbXf4pjS/L
	 DBtiWt6Wwv/ONAoHl27h8EKt8EROdTPf+74LLM+HPYRZypEfUtgLbzejHqdFAyG8H9
	 G0BihnbTnP8AQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Remi Pommarel <repk@triplefau.lt>,
	Nicolas Escande <nescande@freebox.fr>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 03/21] wifi: mac80211: Convert color collision detection to wiphy work
Date: Mon,  4 Nov 2024 05:49:39 -0500
Message-ID: <20241104105048.96444-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105048.96444-1-sashal@kernel.org>
References: <20241104105048.96444-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.6
Content-Transfer-Encoding: 8bit

From: Remi Pommarel <repk@triplefau.lt>

[ Upstream commit 4cc6f3e5e5765abad9c091989970d67d8c1d2204 ]

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
Link: https://patch.msgid.link/20240924192805.13859-3-repk@triplefau.lt
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c         | 17 +++++++++--------
 net/mac80211/ieee80211_i.h |  5 +++--
 net/mac80211/link.c        |  7 ++++---
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c4f4300c81c16..70f9f2f4e6f84 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4824,12 +4824,12 @@ void ieee80211_color_change_finalize_work(struct wiphy *wiphy,
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
@@ -4882,7 +4882,8 @@ ieee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
 		return;
 	}
 
-	if (delayed_work_pending(&link->color_collision_detect_work)) {
+	if (wiphy_delayed_work_pending(sdata->local->hw.wiphy,
+				       &link->color_collision_detect_work)) {
 		rcu_read_unlock();
 		return;
 	}
@@ -4891,9 +4892,9 @@ ieee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
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
index a3485e4c6132f..8650b3e8f1a9f 100644
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
index 1a211b8d40573..67f65ff79a711 100644
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
2.43.0



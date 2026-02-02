Return-Path: <linux-wireless+bounces-31468-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODQNNl3WgGmFBwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31468-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 17:52:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41579CF31C
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 17:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45729301413D
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 16:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D6E37E310;
	Mon,  2 Feb 2026 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNxgHPH+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D993D37FF45
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050980; cv=none; b=BkZRDULynPq7m65SV0Or9Mr4li5RSaxu7zaoU9YTHPJe2/ra1LajbDqF3x2rufKcDtyQDvDoRnPLkYqcsj+PfzVZtIwNqH58c2v1ZOrwjyK6hmNNRC7+nJgp+6009YlFCC7y7MjJAVxAv8NwNs33ODKrcB7gmsuD1I9ZTwRmK6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050980; c=relaxed/simple;
	bh=9FQTQ5XT23vi3SldL4OO7E66I3J0aHUZ/Dkp1I60gNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dcdy0L0oLZ/WA5W7tWPGRQn7dWmVG80JlYVspwFwpG1zk4utFbbcr5dfpKJL0G0uirq570QpFrq6hVnSbw2uzjhy29OiLW7V/caP1gyRzSGkLYqgJGV1fJ0pv/6Xy3Krjh6xSaXSEf7FB/2zjAqSwXs48Scl+TlnEZKSHBahV8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNxgHPH+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b7c2614f7so4306425e87.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 08:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770050977; x=1770655777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Zy8cbAPvmMp4/nsRe8+Q1FLj4E5T7eqUSyhIhSY+EY=;
        b=KNxgHPH+dNiCDDvXiiIPL2TbXROt4ck/OfHxEESvAsfX9Hdlhqd5gHvBo6g7t1kSHv
         WYtsjJLZMJhF4mmCPBVi+6rJugCKUg3fkkb4pV2JsuBJmilnOxE7eyVXqHmpNW6wTB6L
         hPjGkZQ5dM26clpFg1b4O18N0opUWZGiI0tAwwEMXBBnUSNEvvSTp80LoWYSJ0R8jJtt
         jyPgsCK0fg76Y/584Z0Qgt9tyVx4dadKDqRgAgild3Y+zA7J7tZ7NkzmqT21K8PR7WuS
         F1vL4fDEPE8Xdi5P/qj929oRX5luqaQfoKb3vvGOcRCfZDODMIr/3bosfQKMQvF73HfP
         XS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770050977; x=1770655777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Zy8cbAPvmMp4/nsRe8+Q1FLj4E5T7eqUSyhIhSY+EY=;
        b=saFCYJ2bpXn6Fc6TXKLIxtJWzDFKVn671bK2O/+H69LUOxEPO7jS6i7CuLOhCxogRK
         RfyYJwwLqokQV5mBt2t4tbsS3PS5N5R4P/464iY3doY4LDyXMzz1Tl/9xNlGmo5M5zfj
         4g+X3sQOcpuCp9ih5gLbPDVyapmBoJs1RU8mIcdHIxZQY9cJLSXdlPHhA6XZ+FuGaIAU
         scP0pMjCpifmDV+4dHgHQWN2/HxjfMMRckFtetDyFEkaAghXuD2iLHiM1yA1iu7qruI0
         cO8QQqb7JSaWQkb/VCX0naXRQ8/ijw1oaUup15VtngrAY73ZRCh+388oN6NSh8v7RB93
         VpIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWKT6xEJ+FATSRXnHvLe/bxarVEL4M95FErlaGnHFjASr7qRc4kVEStpfRbuuTjrEsDf7YgR7E5t83VZIGrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzzXDQRlj+tKKOMi54jEoC/bSabxQNQPkmranzYC7jzMaeqFkv
	MVHSwh7+/LvQ1Zez4MA47qG6o5NrmyP6XY7b5aXykpUBeCeIh5QL2xId5Jd1j6EK
X-Gm-Gg: AZuq6aJs4dIGgjL948qCYL/f9CdrXn9UwqggKCeDvgEP64ZobdD0GmneaCyoT1ODMVR
	UBQTy/jjfNWHd6WwCJ1zNmaVPvJ19pFNk4Qyyi32sEUt1Y2BkUh8YbmQTmLr1nFhriNcygiRQ+K
	dMPfUlctpJmA6W7JKIVnBYz/XGRA0RqEAvkGffJKjbPYOJFUdIvaN6O72AnmxihPAKvUum8QClT
	h2Kq6i1eSCteT2qhdZ9XXNgjBqUpP0PPcAyW6cc2M7BV7j5rCWSqKUQKMzikIXmVI8/hF3zFoY4
	qTtIwzHAT+YpwJrl1Ib/ouBlV7sGAQJn9jYjKeMX8dPF9L4Md81eWhImV/AXGgK5B+q9oJld1UY
	Aoi6CgF29LoL9mBQ5WehWzHb6xlTSX5ynzuLczi5D1vFH7IfL1/BnuybTC8H1sujr9UVI4xAJtL
	88Rphzv0XzgVtmqR/AQSRGhFItyLG/iJuONOPfSRMdaoUf5YbsvluJOnWhdCRHQoRnxEtAmqcP8
	JfqoPT9dwj7n270lnOo
X-Received: by 2002:ac2:4bc8:0:b0:59e:2f86:1a50 with SMTP id 2adb3069b0e04-59e2f861c51mr414539e87.38.1770050976819;
        Mon, 02 Feb 2026 08:49:36 -0800 (PST)
Received: from uuba.fritz.box (2001-14ba-6e-3100-2ef5-59d5-c9b3-566.rev.dnainternet.fi. [2001:14ba:6e:3100:2ef5:59d5:c9b3:566])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074b7092sm3598268e87.71.2026.02.02.08.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:49:36 -0800 (PST)
From: =?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
To: stable@vger.kernel.org
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	=?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
Subject: [PATCH 6.1.y 1/2] wifi: mac80211: use wiphy work for sdata->work
Date: Mon,  2 Feb 2026 18:49:23 +0200
Message-ID: <20260202164924.215621-1-hannelotta@gmail.com>
X-Mailer: git-send-email 2.53.0.rc2.2.g2258446484
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.28 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.88)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31468-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[sipsolutions.net,vger.kernel.org,intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hannelotta@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,intel.com:email,cozybit.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41579CF31C
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 16114496d684a3df4ce09f7c6b7557a8b2922795 ]

We'll need this later to convert other works that might
be cancelled from here, so convert this one first.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
(cherry picked from commit 16114496d684a3df4ce09f7c6b7557a8b2922795)
Signed-off-by: Hanne-Lotta Mäenpää <hannelotta@gmail.com>
---
 net/mac80211/ibss.c        |  8 ++++----
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/iface.c       | 10 +++++-----
 net/mac80211/mesh.c        | 10 +++++-----
 net/mac80211/mesh_hwmp.c   |  6 +++---
 net/mac80211/mlme.c        |  6 +++---
 net/mac80211/ocb.c         |  6 +++---
 net/mac80211/rx.c          |  2 +-
 net/mac80211/scan.c        |  2 +-
 net/mac80211/status.c      |  6 +++---
 net/mac80211/util.c        |  2 +-
 11 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 79d2c5505289..363e7e4fdd02 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -741,7 +741,7 @@ static void ieee80211_csa_connection_drop_work(struct work_struct *work)
 	skb_queue_purge(&sdata->skb_queue);
 
 	/* trigger a scan to find another IBSS network to join */
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 
 	sdata_unlock(sdata);
 }
@@ -1242,7 +1242,7 @@ void ieee80211_ibss_rx_no_sta(struct ieee80211_sub_if_data *sdata,
 	spin_lock(&ifibss->incomplete_lock);
 	list_add(&sta->list, &ifibss->incomplete_stations);
 	spin_unlock(&ifibss->incomplete_lock);
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->work);
 }
 
 static void ieee80211_ibss_sta_expire(struct ieee80211_sub_if_data *sdata)
@@ -1721,7 +1721,7 @@ static void ieee80211_ibss_timer(struct timer_list *t)
 	struct ieee80211_sub_if_data *sdata =
 		from_timer(sdata, t, u.ibss.timer);
 
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 }
 
 void ieee80211_ibss_setup_sdata(struct ieee80211_sub_if_data *sdata)
@@ -1856,7 +1856,7 @@ int ieee80211_ibss_join(struct ieee80211_sub_if_data *sdata,
 	sdata->deflink.needed_rx_chains = local->rx_chains;
 	sdata->control_port_over_nl80211 = params->control_port_over_nl80211;
 
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->work);
 
 	return 0;
 }
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 64f8d8f2b799..6cc5bba2ba52 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1046,7 +1046,7 @@ struct ieee80211_sub_if_data {
 	/* used to reconfigure hardware SM PS */
 	struct work_struct recalc_smps;
 
-	struct work_struct work;
+	struct wiphy_work work;
 	struct sk_buff_head skb_queue;
 	struct sk_buff_head status_queue;
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index e691ecdd2ad5..6818c9d852e8 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -43,7 +43,7 @@
  * by either the RTNL, the iflist_mtx or RCU.
  */
 
-static void ieee80211_iface_work(struct work_struct *work);
+static void ieee80211_iface_work(struct wiphy *wiphy, struct wiphy_work *work);
 
 bool __ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata)
 {
@@ -650,7 +650,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		RCU_INIT_POINTER(local->p2p_sdata, NULL);
 		fallthrough;
 	default:
-		cancel_work_sync(&sdata->work);
+		wiphy_work_cancel(sdata->local->hw.wiphy, &sdata->work);
 		/*
 		 * When we get here, the interface is marked down.
 		 * Free the remaining keys, if there are any
@@ -1224,7 +1224,7 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 
 	skb_queue_head_init(&sdata->skb_queue);
 	skb_queue_head_init(&sdata->status_queue);
-	INIT_WORK(&sdata->work, ieee80211_iface_work);
+	wiphy_work_init(&sdata->work, ieee80211_iface_work);
 
 	return 0;
 }
@@ -1707,7 +1707,7 @@ static void ieee80211_iface_process_status(struct ieee80211_sub_if_data *sdata,
 	}
 }
 
-static void ieee80211_iface_work(struct work_struct *work)
+static void ieee80211_iface_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct ieee80211_sub_if_data *sdata =
 		container_of(work, struct ieee80211_sub_if_data, work);
@@ -1819,7 +1819,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 
 	skb_queue_head_init(&sdata->skb_queue);
 	skb_queue_head_init(&sdata->status_queue);
-	INIT_WORK(&sdata->work, ieee80211_iface_work);
+	wiphy_work_init(&sdata->work, ieee80211_iface_work);
 	INIT_WORK(&sdata->recalc_smps, ieee80211_recalc_smps_work);
 	INIT_WORK(&sdata->activate_links_work, ieee80211_activate_links_work);
 
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 9c9b47d153c2..434efb30c75f 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -44,7 +44,7 @@ static void ieee80211_mesh_housekeeping_timer(struct timer_list *t)
 
 	set_bit(MESH_WORK_HOUSEKEEPING, &ifmsh->wrkq_flags);
 
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->work);
 }
 
 /**
@@ -643,7 +643,7 @@ static void ieee80211_mesh_path_timer(struct timer_list *t)
 	struct ieee80211_sub_if_data *sdata =
 		from_timer(sdata, t, u.mesh.mesh_path_timer);
 
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 }
 
 static void ieee80211_mesh_path_root_timer(struct timer_list *t)
@@ -654,7 +654,7 @@ static void ieee80211_mesh_path_root_timer(struct timer_list *t)
 
 	set_bit(MESH_WORK_ROOT, &ifmsh->wrkq_flags);
 
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 }
 
 void ieee80211_mesh_root_setup(struct ieee80211_if_mesh *ifmsh)
@@ -1018,7 +1018,7 @@ void ieee80211_mbss_info_change_notify(struct ieee80211_sub_if_data *sdata,
 	for_each_set_bit(bit, &bits, sizeof(changed) * BITS_PER_BYTE)
 		set_bit(bit, &ifmsh->mbss_changed);
 	set_bit(MESH_WORK_MBSS_CHANGED, &ifmsh->wrkq_flags);
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 }
 
 int ieee80211_start_mesh(struct ieee80211_sub_if_data *sdata)
@@ -1043,7 +1043,7 @@ int ieee80211_start_mesh(struct ieee80211_sub_if_data *sdata)
 	ifmsh->sync_offset_clockdrift_max = 0;
 	set_bit(MESH_WORK_HOUSEKEEPING, &ifmsh->wrkq_flags);
 	ieee80211_mesh_root_setup(ifmsh);
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->work);
 	sdata->vif.bss_conf.ht_operation_mode =
 				ifmsh->mshcfg.ht_opmode;
 	sdata->vif.bss_conf.enable_beacon = true;
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index da9e152a7aab..50dba479246b 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
- * Copyright (C) 2019, 2021-2022 Intel Corporation
+ * Copyright (C) 2019, 2021-2023 Intel Corporation
  * Author:     Luis Carlos Cobo <luisca@cozybit.com>
  */
 
@@ -1025,14 +1025,14 @@ static void mesh_queue_preq(struct mesh_path *mpath, u8 flags)
 	spin_unlock_bh(&ifmsh->mesh_preq_queue_lock);
 
 	if (time_after(jiffies, ifmsh->last_preq + min_preq_int_jiff(sdata)))
-		ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+		wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 
 	else if (time_before(jiffies, ifmsh->last_preq)) {
 		/* avoid long wait if did not send preqs for a long time
 		 * and jiffies wrapped around
 		 */
 		ifmsh->last_preq = jiffies - min_preq_int_jiff(sdata) - 1;
-		ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+		wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 	} else
 		mod_timer(&ifmsh->mesh_path_timer, ifmsh->last_preq +
 						min_preq_int_jiff(sdata));
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1fb41e5cc577..8824460a2060 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3168,7 +3168,7 @@ void ieee80211_sta_tx_notify(struct ieee80211_sub_if_data *sdata,
 		sdata->u.mgd.probe_send_count = 0;
 	else
 		sdata->u.mgd.nullfunc_failed = true;
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 }
 
 static void ieee80211_mlme_send_probe_req(struct ieee80211_sub_if_data *sdata,
@@ -6031,7 +6031,7 @@ static void ieee80211_sta_timer(struct timer_list *t)
 	struct ieee80211_sub_if_data *sdata =
 		from_timer(sdata, t, u.mgd.timer);
 
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 }
 
 void ieee80211_sta_connection_lost(struct ieee80211_sub_if_data *sdata,
@@ -6175,7 +6175,7 @@ void ieee80211_mgd_conn_tx_status(struct ieee80211_sub_if_data *sdata,
 	sdata->u.mgd.status_acked = acked;
 	sdata->u.mgd.status_received = true;
 
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->work);
 }
 
 void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata)
diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index a57dcbe99a0d..fcc326913391 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -81,7 +81,7 @@ void ieee80211_ocb_rx_no_sta(struct ieee80211_sub_if_data *sdata,
 	spin_lock(&ifocb->incomplete_lock);
 	list_add(&sta->list, &ifocb->incomplete_stations);
 	spin_unlock(&ifocb->incomplete_lock);
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->work);
 }
 
 static struct sta_info *ieee80211_ocb_finish_sta(struct sta_info *sta)
@@ -157,7 +157,7 @@ static void ieee80211_ocb_housekeeping_timer(struct timer_list *t)
 
 	set_bit(OCB_WORK_HOUSEKEEPING, &ifocb->wrkq_flags);
 
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->work);
 }
 
 void ieee80211_ocb_setup_sdata(struct ieee80211_sub_if_data *sdata)
@@ -197,7 +197,7 @@ int ieee80211_ocb_join(struct ieee80211_sub_if_data *sdata,
 	ifocb->joined = true;
 
 	set_bit(OCB_WORK_HOUSEKEEPING, &ifocb->wrkq_flags);
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->work);
 
 	netif_carrier_on(sdata->dev);
 	return 0;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 42dd7d1dda39..a6636e9f5c08 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -229,7 +229,7 @@ static void __ieee80211_queue_skb_to_iface(struct ieee80211_sub_if_data *sdata,
 	}
 
 	skb_queue_tail(&sdata->skb_queue, skb);
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 	if (sta)
 		sta->deflink.rx_stats.packets++;
 }
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index f1147d156c1f..58da59836884 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -503,7 +503,7 @@ static void __ieee80211_scan_completed(struct ieee80211_hw *hw, bool aborted)
 	 */
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
 		if (ieee80211_sdata_running(sdata))
-			ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+			wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 	}
 
 	if (was_scanning)
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 3a96aa306616..9a8fca897d9f 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2008-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright 2021-2022  Intel Corporation
+ * Copyright 2021-2023  Intel Corporation
  */
 
 #include <linux/export.h>
@@ -747,8 +747,8 @@ static void ieee80211_report_used_skb(struct ieee80211_local *local,
 					if (qskb) {
 						skb_queue_tail(&sdata->status_queue,
 							       qskb);
-						ieee80211_queue_work(&local->hw,
-								     &sdata->work);
+						wiphy_work_queue(local->hw.wiphy,
+								 &sdata->work);
 					}
 				}
 			} else {
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index e60c8607e4b6..116a3e70582b 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2751,7 +2751,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 
 		/* Requeue all works */
 		list_for_each_entry(sdata, &local->interfaces, list)
-			ieee80211_queue_work(&local->hw, &sdata->work);
+			wiphy_work_queue(local->hw.wiphy, &sdata->work);
 	}
 
 	ieee80211_wake_queues_by_reason(hw, IEEE80211_MAX_QUEUE_MAP,
-- 
2.53.0.rc2.2.g2258446484



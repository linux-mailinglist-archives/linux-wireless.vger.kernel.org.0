Return-Path: <linux-wireless+bounces-31471-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMJgLQjXgGnMBwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31471-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 17:55:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46396CF3AA
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 17:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFC1F30488E1
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 16:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28AF3803F8;
	Mon,  2 Feb 2026 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWv6ZvfK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359323803FA
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051072; cv=none; b=tIcLY/JnMXmk4KXkImDnJiPuzNjMCvR2yx3FUtNI5AHIWlK40yuE1GfEghdvPdi/B20hmRdI22vWlRxfSowXAPjZ85L4KTmVMgfIZDEtBAGlhCs4bTqDCIFki/Ej6VXIut/pS8U67Dd1Bx16UdujEYQZ7tl7scaUsLICU43zD4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051072; c=relaxed/simple;
	bh=ZeoQbTT583uenicIJr0OElWGa94O7y/1eLZ+sd2bedE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cB+FB8i0IQXiGcQA2hquBtQE4t5nztOttvgZrUArppw2LJ2Gk8sbokkNMd3KJUe9jgCRYX/qFrypc7xrT/nFKVKJ6EM+QCH4v2yPdnO/6W1Vyln2VDWPLA0C/OuEtTXIM60UKnMN66bAUbXi6i70egOUM/Mso9pH+vmKYsGpsVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWv6ZvfK; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59dd4bec4ecso5274110e87.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 08:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770051065; x=1770655865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPTTmnORma5/Xcdv/Rqh5mCTn4VPCMVw77PzoYwtG90=;
        b=BWv6ZvfKmcH+jVolN4SrnoEq6+7BL/6pSzHGm3kXBel1ujtrm7oWGlv5RyeHShJNOi
         RrSFv067as7ON4Gnv8M5KA3mwthEyl9gI1INvk91az9Oq1LQUzTCpJ9La/zdKSyillLE
         CnPUq01kHeEq1/ymJAu5bH206tm0seklv8ymEGhIZYlx8tmHyf7QwRh0Mqs6G9BEKn/n
         HoO923/AFLquu3mb4KCTvB3MqVv0/6Vz41jM2talhbHanZm1q6fv0hn2lPiUwqU7oKlt
         XPlWfU9HxX21A5dzVOhHxamOqnqwb80lKJurPM//rL6HlZKHFMZk0w/HmklltOkbdwTn
         +Ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770051065; x=1770655865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GPTTmnORma5/Xcdv/Rqh5mCTn4VPCMVw77PzoYwtG90=;
        b=K594FWs2ur69HDl+kC3GqJy+zT5PKco87uwyf6kUcoMuKbRrM3oTWKjrYKW+c6w3jC
         8U4lTUhzz82Hmq5mzuw8LqOnts1m6HLasgI8LBpPZO6lOWdqMaffQguE7YVFTQn2QXfF
         S/BXFkNonyxFneTVUCX5KgA/hFTpL7pXpoZifkk8MKiST+gCVN0mUXbMooPppwf7ekA+
         807yNCa8sL4AXnZKSqDAtT9OlSazKtDib3I5cXf8u1nv/8alKZWzS+W8jlgGQUuCqZ9a
         VC5KGSjtwkFzijOZ7ijDEaAhDmxmoowhkl4n6SYGyZKlpQlXUGUszupX6xTplI2+zOik
         6vPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkhrIpTuqr46dGFaDQPHbvW0Z0UXODmifFTYzEKsCmr8Cv3pBrH5xK8B4Hw+sYvYTNIJ3bjHeiiVCSlyokEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWeyLpd4AaG3QkGD8XAyXM6JDxPbV4m0bZceZE4vdFNMTQJSSS
	n7wX/AF9PpbfRUPa+2bWAhHBKGAxhJtw9DOKarWKA6npXWBKja6YG7yH
X-Gm-Gg: AZuq6aKsNmIoAGnq6Odn0GqARVZl8ezV3EHlWlpcCPQkmw4vFIno1ceDv/Kej1fvJ15
	Vk652rhJevmCB8FSABOXaJJgG1iKaeEXNjQ9NGDebRvSTueDmXe0RS+ZwOHZ0N1uQvF2MhDAhXw
	XRcXPdR/4edtZYge4O9kmKjdWi5wO/DC05nuTt66IuCUElRBm4N3mD1bzvUp7QjsEbEFVqMSG12
	6cmBYIfGmccT5kMPgW2Jonnbkywu/8T7PWfvh8EaZT7H3YAQXyYlMwat5aQrV4kz6ylAZQNzpzg
	RKBdrtHypAm282fh7/h9HlXIRRJDthXYYRoeLILOE3oBt/lFXk3QGGBFHo/5xV1XpWTh7CqMr40
	iVzS58Qitj4I9YGU341cENgz6Fa74moq5QhPu7IADCC/dkJVogEcGugobsLMZMrL5N0w3FBYRpC
	Md6ACjujf0qbIvurnvYPkvHdCupwTAk1+S+dq0RSithoxVeDgyXGZzwFi/sjberRsEouX1Q7glm
	y6kqoGgrw==
X-Received: by 2002:ac2:4c4f:0:b0:59e:2156:4ffe with SMTP id 2adb3069b0e04-59e21565003mr2555312e87.30.1770051064548;
        Mon, 02 Feb 2026 08:51:04 -0800 (PST)
Received: from uuba.fritz.box (2001-14ba-6e-3100-2ef5-59d5-c9b3-566.rev.dnainternet.fi. [2001:14ba:6e:3100:2ef5:59d5:c9b3:566])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38625ad8ae0sm31718571fa.0.2026.02.02.08.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:51:04 -0800 (PST)
From: =?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
To: stable@vger.kernel.org
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	=?UTF-8?q?Hanne-Lotta=20M=C3=A4enp=C3=A4=C3=A4?= <hannelotta@gmail.com>
Subject: [PATCH 5.15.y 2/3] wifi: mac80211: use wiphy work for sdata->work
Date: Mon,  2 Feb 2026 18:50:37 +0200
Message-ID: <20260202165038.215693-2-hannelotta@gmail.com>
X-Mailer: git-send-email 2.53.0.rc2.2.g2258446484
In-Reply-To: <20260202165038.215693-1-hannelotta@gmail.com>
References: <20260202165038.215693-1-hannelotta@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31471-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[sipsolutions.net,vger.kernel.org,intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hannelotta@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:email,intel.com:email,cozybit.com:email]
X-Rspamd-Queue-Id: 46396CF3AA
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 16114496d684a3df4ce09f7c6b7557a8b2922795 ]

We'll need this later to convert other works that might
be cancelled from here, so convert this one first.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
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
 net/mac80211/status.c      |  5 +++--
 net/mac80211/util.c        |  2 +-
 11 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 48e0260f3424..ce927c16a915 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -746,7 +746,7 @@ static void ieee80211_csa_connection_drop_work(struct work_struct *work)
 	skb_queue_purge(&sdata->skb_queue);
 
 	/* trigger a scan to find another IBSS network to join */
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 
 	sdata_unlock(sdata);
 }
@@ -1245,7 +1245,7 @@ void ieee80211_ibss_rx_no_sta(struct ieee80211_sub_if_data *sdata,
 	spin_lock(&ifibss->incomplete_lock);
 	list_add(&sta->list, &ifibss->incomplete_stations);
 	spin_unlock(&ifibss->incomplete_lock);
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->work);
 }
 
 static void ieee80211_ibss_sta_expire(struct ieee80211_sub_if_data *sdata)
@@ -1726,7 +1726,7 @@ static void ieee80211_ibss_timer(struct timer_list *t)
 	struct ieee80211_sub_if_data *sdata =
 		from_timer(sdata, t, u.ibss.timer);
 
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 }
 
 void ieee80211_ibss_setup_sdata(struct ieee80211_sub_if_data *sdata)
@@ -1861,7 +1861,7 @@ int ieee80211_ibss_join(struct ieee80211_sub_if_data *sdata,
 	sdata->needed_rx_chains = local->rx_chains;
 	sdata->control_port_over_nl80211 = params->control_port_over_nl80211;
 
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->work);
 
 	return 0;
 }
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 3b5350cfc0ee..8d6616f646e7 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -966,7 +966,7 @@ struct ieee80211_sub_if_data {
 	/* used to reconfigure hardware SM PS */
 	struct work_struct recalc_smps;
 
-	struct work_struct work;
+	struct wiphy_work work;
 	struct sk_buff_head skb_queue;
 	struct sk_buff_head status_queue;
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index e437bcadf4a2..eb7de2d455e1 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -43,7 +43,7 @@
  * by either the RTNL, the iflist_mtx or RCU.
  */
 
-static void ieee80211_iface_work(struct work_struct *work);
+static void ieee80211_iface_work(struct wiphy *wiphy, struct wiphy_work *work);
 
 bool __ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata)
 {
@@ -539,7 +539,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		RCU_INIT_POINTER(local->p2p_sdata, NULL);
 		fallthrough;
 	default:
-		cancel_work_sync(&sdata->work);
+		wiphy_work_cancel(sdata->local->hw.wiphy, &sdata->work);
 		/*
 		 * When we get here, the interface is marked down.
 		 * Free the remaining keys, if there are any
@@ -1005,7 +1005,7 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 
 	skb_queue_head_init(&sdata->skb_queue);
 	skb_queue_head_init(&sdata->status_queue);
-	INIT_WORK(&sdata->work, ieee80211_iface_work);
+	wiphy_work_init(&sdata->work, ieee80211_iface_work);
 
 	return 0;
 }
@@ -1487,7 +1487,7 @@ static void ieee80211_iface_process_status(struct ieee80211_sub_if_data *sdata,
 	}
 }
 
-static void ieee80211_iface_work(struct work_struct *work)
+static void ieee80211_iface_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct ieee80211_sub_if_data *sdata =
 		container_of(work, struct ieee80211_sub_if_data, work);
@@ -1590,7 +1590,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 
 	skb_queue_head_init(&sdata->skb_queue);
 	skb_queue_head_init(&sdata->status_queue);
-	INIT_WORK(&sdata->work, ieee80211_iface_work);
+	wiphy_work_init(&sdata->work, ieee80211_iface_work);
 	INIT_WORK(&sdata->recalc_smps, ieee80211_recalc_smps_work);
 	INIT_WORK(&sdata->csa_finalize_work, ieee80211_csa_finalize_work);
 	INIT_WORK(&sdata->color_change_finalize_work, ieee80211_color_change_finalize_work);
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 6202157f467b..2f888cbe6e2b 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -44,7 +44,7 @@ static void ieee80211_mesh_housekeeping_timer(struct timer_list *t)
 
 	set_bit(MESH_WORK_HOUSEKEEPING, &ifmsh->wrkq_flags);
 
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->work);
 }
 
 /**
@@ -642,7 +642,7 @@ static void ieee80211_mesh_path_timer(struct timer_list *t)
 	struct ieee80211_sub_if_data *sdata =
 		from_timer(sdata, t, u.mesh.mesh_path_timer);
 
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 }
 
 static void ieee80211_mesh_path_root_timer(struct timer_list *t)
@@ -653,7 +653,7 @@ static void ieee80211_mesh_path_root_timer(struct timer_list *t)
 
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
index 8bf238afb544..a3522b21803f 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
- * Copyright (C) 2019, 2021 Intel Corporation
+ * Copyright (C) 2019, 2021-2023 Intel Corporation
  * Author:     Luis Carlos Cobo <luisca@cozybit.com>
  */
 
@@ -1020,14 +1020,14 @@ static void mesh_queue_preq(struct mesh_path *mpath, u8 flags)
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
index 6e86a23c647d..d147760e8389 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2509,7 +2509,7 @@ void ieee80211_sta_tx_notify(struct ieee80211_sub_if_data *sdata,
 		sdata->u.mgd.probe_send_count = 0;
 	else
 		sdata->u.mgd.nullfunc_failed = true;
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 }
 
 static void ieee80211_mlme_send_probe_req(struct ieee80211_sub_if_data *sdata,
@@ -4415,7 +4415,7 @@ static void ieee80211_sta_timer(struct timer_list *t)
 	struct ieee80211_sub_if_data *sdata =
 		from_timer(sdata, t, u.mgd.timer);
 
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 }
 
 void ieee80211_sta_connection_lost(struct ieee80211_sub_if_data *sdata,
@@ -4559,7 +4559,7 @@ void ieee80211_mgd_conn_tx_status(struct ieee80211_sub_if_data *sdata,
 	sdata->u.mgd.status_acked = acked;
 	sdata->u.mgd.status_received = true;
 
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->work);
 }
 
 void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata)
diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index 7c1a735b9eee..9713e53f11b1 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -80,7 +80,7 @@ void ieee80211_ocb_rx_no_sta(struct ieee80211_sub_if_data *sdata,
 	spin_lock(&ifocb->incomplete_lock);
 	list_add(&sta->list, &ifocb->incomplete_stations);
 	spin_unlock(&ifocb->incomplete_lock);
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->work);
 }
 
 static struct sta_info *ieee80211_ocb_finish_sta(struct sta_info *sta)
@@ -156,7 +156,7 @@ static void ieee80211_ocb_housekeeping_timer(struct timer_list *t)
 
 	set_bit(OCB_WORK_HOUSEKEEPING, &ifocb->wrkq_flags);
 
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->work);
 }
 
 void ieee80211_ocb_setup_sdata(struct ieee80211_sub_if_data *sdata)
@@ -196,7 +196,7 @@ int ieee80211_ocb_join(struct ieee80211_sub_if_data *sdata,
 	ifocb->joined = true;
 
 	set_bit(OCB_WORK_HOUSEKEEPING, &ifocb->wrkq_flags);
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->work);
 
 	netif_carrier_on(sdata->dev);
 	return 0;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 1c1660160787..15933e9abc9b 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -219,7 +219,7 @@ static void __ieee80211_queue_skb_to_iface(struct ieee80211_sub_if_data *sdata,
 					   struct sk_buff *skb)
 {
 	skb_queue_tail(&sdata->skb_queue, skb);
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 	if (sta)
 		sta->rx_stats.packets++;
 }
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 3bf3dd4bafa5..fd77c707e65c 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -498,7 +498,7 @@ static void __ieee80211_scan_completed(struct ieee80211_hw *hw, bool aborted)
 	 */
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
 		if (ieee80211_sdata_running(sdata))
-			ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+			wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 	}
 
 	if (was_scanning)
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index f6f63a0b1b72..017ea2d2f36f 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -5,6 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2008-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
+ * Copyright 2021-2023  Intel Corporation
  */
 
 #include <linux/export.h>
@@ -716,8 +717,8 @@ static void ieee80211_report_used_skb(struct ieee80211_local *local,
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
index 07512f0d5576..5b1799dfa675 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2679,7 +2679,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 
 		/* Requeue all works */
 		list_for_each_entry(sdata, &local->interfaces, list)
-			ieee80211_queue_work(&local->hw, &sdata->work);
+			wiphy_work_queue(local->hw.wiphy, &sdata->work);
 	}
 
 	ieee80211_wake_queues_by_reason(hw, IEEE80211_MAX_QUEUE_MAP,
-- 
2.53.0.rc2.2.g2258446484



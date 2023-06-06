Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB21724305
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 14:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbjFFMuN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 08:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237503AbjFFMuH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 08:50:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401B71712
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 05:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=sikd8GjhPyFxwB1dWvjPkSHNpeFn+yDcCi5PGsqo8Pc=;
        t=1686055782; x=1687265382; b=nNOUfPFAuysofh94dnlQqvKDe0rdDaa+8rXstUFD34N0qS9
        MVtOhui8mzrIzDMdTTOqtGR6174Sg+KTEm6nCJlR0LU5YTIbYBSOjuVzqeEIfKrI265qorr/kriWz
        4g9Iga2FQoiu6dYWSNWflysfFFQpZcUA15/h9l+2KQJbPCuAEIK/Vf9lK70voSFdI4m8ZmTMlhbnB
        +ZrCJt+AwZYSAjuvm1M/dQrAFuZw04MC40Ys9tUkeUZtDoquDDcMfSQiZZTQFSyG+RywuDMULLoN8
        lsOFZlIYxCbU8VRe6P7A2z4emyPgsHbVnR5CwL4GqcHU3k//NLef1ViNC/7jLTgg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6W83-00FZDP-11;
        Tue, 06 Jun 2023 14:49:39 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/14] wifi: mac80211: use wiphy work for sdata->work
Date:   Tue,  6 Jun 2023 14:49:26 +0200
Message-Id: <20230606144753.89e5fe4948eb.Iad50f5a8fe16979c230459b3c0fd73910a755068@changeid>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606124933.181107-1-johannes@sipsolutions.net>
References: <20230606124933.181107-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We'll need this later to convert other works that might
be cancelled from here, so convert this one first.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
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
index faa01ee11d32..19017810024b 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -743,7 +743,7 @@ static void ieee80211_csa_connection_drop_work(struct work_struct *work)
 	skb_queue_purge(&sdata->skb_queue);
 
 	/* trigger a scan to find another IBSS network to join */
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 
 	sdata_unlock(sdata);
 }
@@ -1244,7 +1244,7 @@ void ieee80211_ibss_rx_no_sta(struct ieee80211_sub_if_data *sdata,
 	spin_lock(&ifibss->incomplete_lock);
 	list_add(&sta->list, &ifibss->incomplete_stations);
 	spin_unlock(&ifibss->incomplete_lock);
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->work);
 }
 
 static void ieee80211_ibss_sta_expire(struct ieee80211_sub_if_data *sdata)
@@ -1723,7 +1723,7 @@ static void ieee80211_ibss_timer(struct timer_list *t)
 	struct ieee80211_sub_if_data *sdata =
 		from_timer(sdata, t, u.ibss.timer);
 
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 }
 
 void ieee80211_ibss_setup_sdata(struct ieee80211_sub_if_data *sdata)
@@ -1858,7 +1858,7 @@ int ieee80211_ibss_join(struct ieee80211_sub_if_data *sdata,
 	sdata->deflink.needed_rx_chains = local->rx_chains;
 	sdata->control_port_over_nl80211 = params->control_port_over_nl80211;
 
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->work);
 
 	return 0;
 }
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 865210726d54..91bc4982d6b9 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1061,7 +1061,7 @@ struct ieee80211_sub_if_data {
 	/* used to reconfigure hardware SM PS */
 	struct work_struct recalc_smps;
 
-	struct work_struct work;
+	struct wiphy_work work;
 	struct sk_buff_head skb_queue;
 	struct sk_buff_head status_queue;
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 2e2115af38f5..f820098e6a70 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -43,7 +43,7 @@
  * by either the RTNL, the iflist_mtx or RCU.
  */
 
-static void ieee80211_iface_work(struct work_struct *work);
+static void ieee80211_iface_work(struct wiphy *wiphy, struct wiphy_work *work);
 
 bool __ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata)
 {
@@ -614,7 +614,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		RCU_INIT_POINTER(local->p2p_sdata, NULL);
 		fallthrough;
 	default:
-		cancel_work_sync(&sdata->work);
+		wiphy_work_cancel(sdata->local->hw.wiphy, &sdata->work);
 		/*
 		 * When we get here, the interface is marked down.
 		 * Free the remaining keys, if there are any
@@ -1173,7 +1173,7 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 
 	skb_queue_head_init(&sdata->skb_queue);
 	skb_queue_head_init(&sdata->status_queue);
-	INIT_WORK(&sdata->work, ieee80211_iface_work);
+	wiphy_work_init(&sdata->work, ieee80211_iface_work);
 
 	return 0;
 }
@@ -1625,7 +1625,7 @@ static void ieee80211_iface_process_status(struct ieee80211_sub_if_data *sdata,
 	}
 }
 
-static void ieee80211_iface_work(struct work_struct *work)
+static void ieee80211_iface_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct ieee80211_sub_if_data *sdata =
 		container_of(work, struct ieee80211_sub_if_data, work);
@@ -1737,7 +1737,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 
 	skb_queue_head_init(&sdata->skb_queue);
 	skb_queue_head_init(&sdata->status_queue);
-	INIT_WORK(&sdata->work, ieee80211_iface_work);
+	wiphy_work_init(&sdata->work, ieee80211_iface_work);
 	INIT_WORK(&sdata->recalc_smps, ieee80211_recalc_smps_work);
 	INIT_WORK(&sdata->activate_links_work, ieee80211_activate_links_work);
 
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index a4d8764073bf..af8c5fc2db14 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -45,7 +45,7 @@ static void ieee80211_mesh_housekeeping_timer(struct timer_list *t)
 
 	set_bit(MESH_WORK_HOUSEKEEPING, &ifmsh->wrkq_flags);
 
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->work);
 }
 
 /**
@@ -703,7 +703,7 @@ static void ieee80211_mesh_path_timer(struct timer_list *t)
 	struct ieee80211_sub_if_data *sdata =
 		from_timer(sdata, t, u.mesh.mesh_path_timer);
 
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 }
 
 static void ieee80211_mesh_path_root_timer(struct timer_list *t)
@@ -714,7 +714,7 @@ static void ieee80211_mesh_path_root_timer(struct timer_list *t)
 
 	set_bit(MESH_WORK_ROOT, &ifmsh->wrkq_flags);
 
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 }
 
 void ieee80211_mesh_root_setup(struct ieee80211_if_mesh *ifmsh)
@@ -1177,7 +1177,7 @@ void ieee80211_mbss_info_change_notify(struct ieee80211_sub_if_data *sdata,
 	for_each_set_bit(bit, &bits, sizeof(changed) * BITS_PER_BYTE)
 		set_bit(bit, &ifmsh->mbss_changed);
 	set_bit(MESH_WORK_MBSS_CHANGED, &ifmsh->wrkq_flags);
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 }
 
 int ieee80211_start_mesh(struct ieee80211_sub_if_data *sdata)
@@ -1202,7 +1202,7 @@ int ieee80211_start_mesh(struct ieee80211_sub_if_data *sdata)
 	ifmsh->sync_offset_clockdrift_max = 0;
 	set_bit(MESH_WORK_HOUSEKEEPING, &ifmsh->wrkq_flags);
 	ieee80211_mesh_root_setup(ifmsh);
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->work);
 	sdata->vif.bss_conf.ht_operation_mode =
 				ifmsh->mshcfg.ht_opmode;
 	sdata->vif.bss_conf.enable_beacon = true;
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 5217e1d97dd6..51369072984e 100644
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
 
@@ -1026,14 +1026,14 @@ static void mesh_queue_preq(struct mesh_path *mpath, u8 flags)
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
index 9af755388171..6c659609abee 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3155,7 +3155,7 @@ void ieee80211_sta_tx_notify(struct ieee80211_sub_if_data *sdata,
 		sdata->u.mgd.probe_send_count = 0;
 	else
 		sdata->u.mgd.nullfunc_failed = true;
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 }
 
 static void ieee80211_mlme_send_probe_req(struct ieee80211_sub_if_data *sdata,
@@ -6068,7 +6068,7 @@ static void ieee80211_sta_timer(struct timer_list *t)
 	struct ieee80211_sub_if_data *sdata =
 		from_timer(sdata, t, u.mgd.timer);
 
-	ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 }
 
 void ieee80211_sta_connection_lost(struct ieee80211_sub_if_data *sdata,
@@ -6212,7 +6212,7 @@ void ieee80211_mgd_conn_tx_status(struct ieee80211_sub_if_data *sdata,
 	sdata->u.mgd.status_acked = acked;
 	sdata->u.mgd.status_received = true;
 
-	ieee80211_queue_work(&local->hw, &sdata->work);
+	wiphy_work_queue(local->hw.wiphy, &sdata->work);
 }
 
 void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata)
diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index cf205762ab96..b44896e14522 100644
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
index 58222c077898..035e3cb28a1e 100644
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
index 32fa8aca7005..ea5383136fff 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -502,7 +502,7 @@ static void __ieee80211_scan_completed(struct ieee80211_hw *hw, bool aborted)
 	 */
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
 		if (ieee80211_sdata_running(sdata))
-			ieee80211_queue_work(&sdata->local->hw, &sdata->work);
+			wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 	}
 
 	if (was_scanning)
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 2b13a52ce96c..44d83da60aee 100644
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
index a027b9e24160..755fd85dd552 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2942,7 +2942,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 
 		/* Requeue all works */
 		list_for_each_entry(sdata, &local->interfaces, list)
-			ieee80211_queue_work(&local->hw, &sdata->work);
+			wiphy_work_queue(local->hw.wiphy, &sdata->work);
 	}
 
 	ieee80211_wake_queues_by_reason(hw, IEEE80211_MAX_QUEUE_MAP,
-- 
2.40.1


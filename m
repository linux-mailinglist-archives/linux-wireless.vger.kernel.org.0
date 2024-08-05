Return-Path: <linux-wireless+bounces-10972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F004F948240
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 21:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AACF5283829
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 19:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3668416BE0E;
	Mon,  5 Aug 2024 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="JVVqFNI4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC971684AC
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885821; cv=none; b=bku4xPVd0jZ6pn6gl1z7sdGRvn3C9By9Kg6RspiVUaJARSwBw8e5F9Tsyz+dktBHfC7kOzjVgUFtYr0b13YxE4nE7klIBuuof0XqwiC7FOwy5pY0uO+sFkNN7VEEqfSJQCy8yyqwX4dxBBhfXeI4UbjShq/ZJjM5yRHoHrbHRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885821; c=relaxed/simple;
	bh=r/0Ny4atf7ieDmGQxpk2/z3xO4AUAX5g0mCAP+y3oAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwJ4ryYpKnV2/wfp665ugAwFBn7yk9iYCzqy2CYFKL2jsoJmyx/2EpVkHzvd73DRHAOWGvs9dlW64bPNG6NxULvlLbIkSrD4XkVvEsbUIVQ+8KAvosBVumvl/TEE53xuQl0UXixBnFSxxKm5EZsTPh96RHsp3qbMAzihiIjQT6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=JVVqFNI4; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yje/7W4F7Ip6QJYdGgtFLLYwMDfGj8qX5NBZe9fA8gk=; b=JVVqFNI4TgyRwOjLb2H2fN1yQd
	lfXSfmfLijDLVI3fU8Gcod5g1vz+NrZvnvrZRvGG3Yup9ID7ejXSmhEtpp61PCGh3gGUugC7Puudq
	F36qRuAT529QCBqW/Lx38UE3Avqc9feaVdl/BOof63etegBy7lFgszeMZw6bfZgJSJvE=;
Received: from p54ae9b72.dip0.t-ipconnect.de ([84.174.155.114] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sb3Iu-00EHlS-2g;
	Mon, 05 Aug 2024 21:23:36 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [RFC 5/6] wifi: mac80211: support per-radio filter flags
Date: Mon,  5 Aug 2024 21:23:33 +0200
Message-ID: <7a871d4d2ce7adafb14cf971c1fdeb9cd01a4169.1722885720.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
References: <cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows drivers to improve filtering of unwanted packets when using
different combinations of filter/monitor settings on radios.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/mac80211.h     |  8 +++-
 net/mac80211/driver-ops.h  | 18 +++++++-
 net/mac80211/ieee80211_i.h | 21 ++++++---
 net/mac80211/iface.c       | 95 ++++++++++++++++++++++++---------------
 net/mac80211/main.c        | 60 +++++++++++++++++--------
 net/mac80211/mesh.c        | 33 ++++++++++----
 net/mac80211/trace.h       | 28 +++++++++++-
 7 files changed, 196 insertions(+), 67 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d0dcd66e565e..7a5418713dfc 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3921,6 +3921,10 @@ struct ieee80211_prep_tx_info {
  *	See the section "Frame filtering" for more information.
  *	This callback must be implemented and can sleep.
  *
+ * @config_radio_filter: Configure the radio's RX filter.
+ *	See the section "Frame filtering" for more information.
+ *	This callback is optional and can sleep.
+ *
  * @config_iface_filter: Configure the interface's RX filter.
  *	This callback is optional and is used to configure which frames
  *	should be passed to mac80211. The filter_flags is the combination
@@ -4489,6 +4493,10 @@ struct ieee80211_ops {
 				 unsigned int changed_flags,
 				 unsigned int *total_flags,
 				 u64 multicast);
+	void (*config_radio_filter)(struct ieee80211_hw *hw,
+				    unsigned int radio_idx,
+				    unsigned int changed_flags,
+				    unsigned int *total_flags);
 	void (*config_iface_filter)(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    unsigned int filter_flags,
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index cedc12b98bbb..4ee1d78b91c1 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -242,6 +242,24 @@ static inline void drv_configure_filter(struct ieee80211_local *local,
 	trace_drv_return_void(local);
 }
 
+static inline void drv_config_radio_filter(struct ieee80211_local *local,
+					   unsigned int radio_idx,
+					   unsigned int changed_flags,
+					   unsigned int *total_flags)
+{
+	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	if (!local->ops->config_radio_filter)
+	    return;
+
+	trace_drv_config_radio_filter(local, radio_idx, changed_flags,
+				      total_flags);
+	local->ops->config_radio_filter(&local->hw, radio_idx, changed_flags,
+					total_flags);
+	trace_drv_return_void(local);
+}
+
 static inline void drv_config_iface_filter(struct ieee80211_local *local,
 					   struct ieee80211_sub_if_data *sdata,
 					   unsigned int filter_flags,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index acc1a2d0f30f..55bb328b9c70 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1330,7 +1330,19 @@ enum mac80211_scan_state {
 
 DECLARE_STATIC_KEY_FALSE(aql_disable);
 
+struct ieee80211_radio_filter {
+	/* number of interfaces with corresponding FIF_ flags */
+	int fif_fcsfail, fif_plcpfail, fif_control, fif_other_bss, fif_pspoll,
+	    fif_probe_req;
+
+	/* number of interfaces with allmulti RX */
+	atomic_t iff_allmultis;
+
+	unsigned int filter_flags; /* FIF_* */
+};
+
 struct ieee80211_radio_data {
+	struct ieee80211_radio_filter filter;
 	u32 monitors;
 	u32 open_count;
 	bool started;
@@ -1378,12 +1390,10 @@ struct ieee80211_local {
 
 	int open_count;
 	int monitors, cooked_mntrs;
-	/* number of interfaces with corresponding FIF_ flags */
-	int fif_fcsfail, fif_plcpfail, fif_control, fif_other_bss, fif_pspoll,
-	    fif_probe_req;
+	struct ieee80211_radio_filter filter;
+
 	bool probe_req_reg;
 	bool rx_mcast_action_reg;
-	unsigned int filter_flags; /* FIF_* */
 
 	bool wiphy_ciphers_allocated;
 
@@ -1478,9 +1488,6 @@ struct ieee80211_local {
 
 	atomic_t agg_queue_stop[IEEE80211_MAX_QUEUES];
 
-	/* number of interfaces with allmulti RX */
-	atomic_t iff_allmultis;
-
 	struct rate_control_ref *rate_ctrl;
 
 	struct arc4_ctx wep_tx_ctx;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 20a4a19c8ba1..b7617f98cef6 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -458,6 +458,39 @@ static int ieee80211_open(struct net_device *dev)
 	return err;
 }
 
+static bool
+__ieee80211_sdata_set_filter(struct ieee80211_radio_filter *filter,
+			     struct ieee80211_sub_if_data *sdata, int ofs)
+{
+	if (sdata->flags & IEEE80211_SDATA_ALLMULTI)
+		atomic_add(ofs, &filter->iff_allmultis);
+
+	if (sdata->vif.type == NL80211_IFTYPE_AP) {
+		filter->fif_pspoll += ofs;
+		filter->fif_probe_req += ofs;
+	} else if (sdata->vif.type == NL80211_IFTYPE_ADHOC) {
+		filter->fif_probe_req += ofs;
+	} else {
+		return false;
+	}
+
+	return true;
+}
+
+static bool
+ieee80211_sdata_set_filter(struct ieee80211_sub_if_data *sdata, int ofs)
+{
+	struct ieee80211_local *local = sdata->local;
+	int i;
+
+	for (i = 0; i < local->hw.wiphy->n_radio; i++)
+		if (sdata->wdev.radio_mask & BIT(i))
+			__ieee80211_sdata_set_filter(&local->radio_data[i].filter,
+						     sdata, ofs);
+
+	return __ieee80211_sdata_set_filter(&local->filter, sdata, ofs);
+}
+
 static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_down)
 {
 	struct ieee80211_local *local = sdata->local;
@@ -514,16 +547,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	flushed = sta_info_flush(sdata, -1);
 	WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_AP_VLAN && flushed > 0);
 
-	/* don't count this interface for allmulti while it is down */
-	if (sdata->flags & IEEE80211_SDATA_ALLMULTI)
-		atomic_dec(&local->iff_allmultis);
-
-	if (sdata->vif.type == NL80211_IFTYPE_AP) {
-		local->fif_pspoll--;
-		local->fif_probe_req--;
-	} else if (sdata->vif.type == NL80211_IFTYPE_ADHOC) {
-		local->fif_probe_req--;
-	}
+	ieee80211_sdata_set_filter(sdata, -1);
 
 	if (sdata->dev) {
 		netif_addr_lock_bh(sdata->dev);
@@ -796,16 +820,22 @@ static void ieee80211_set_multicast_list(struct net_device *dev)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_radio_filter *filter = &local->filter;
 	int allmulti, sdata_allmulti;
+	int i, ofs;
 
 	allmulti = !!(dev->flags & IFF_ALLMULTI);
 	sdata_allmulti = !!(sdata->flags & IEEE80211_SDATA_ALLMULTI);
 
 	if (allmulti != sdata_allmulti) {
-		if (dev->flags & IFF_ALLMULTI)
-			atomic_inc(&local->iff_allmultis);
-		else
-			atomic_dec(&local->iff_allmultis);
+		ofs = (dev->flags & IFF_ALLMULTI) ? 1 : -1;
+		atomic_add(ofs, &filter->iff_allmultis);
+		for (i = 0; i < local->hw.wiphy->n_radio; i++) {
+			if (!(sdata->wdev.radio_mask & BIT(i)))
+				continue;
+			filter = &local->radio_data[i].filter;
+			atomic_add(ofs, &filter->iff_allmultis);
+		}
 		sdata->flags ^= IEEE80211_SDATA_ALLMULTI;
 	}
 
@@ -1080,15 +1110,16 @@ void ieee80211_recalc_offload(struct ieee80211_local *local)
 	}
 }
 
-void ieee80211_adjust_monitor_flags(struct ieee80211_sub_if_data *sdata,
-				    const int offset)
+static void
+__ieee80211_adjust_monitor_flags(struct ieee80211_radio_filter *filter,
+				 struct ieee80211_sub_if_data *sdata,
+				 const int offset)
 {
-	struct ieee80211_local *local = sdata->local;
 	u32 flags = sdata->u.mntr.flags;
 
 #define ADJUST(_f, _s)	do {					\
 	if (flags & MONITOR_FLAG_##_f)				\
-		local->fif_##_s += offset;			\
+		filter->fif_##_s += offset;			\
 	} while (0)
 
 	ADJUST(FCSFAIL, fcsfail);
@@ -1100,6 +1131,14 @@ void ieee80211_adjust_monitor_flags(struct ieee80211_sub_if_data *sdata,
 #undef ADJUST
 }
 
+void ieee80211_adjust_monitor_flags(struct ieee80211_sub_if_data *sdata,
+				    const int offset)
+{
+	struct ieee80211_local *local = sdata->local;
+
+	__ieee80211_adjust_monitor_flags(&local->filter, sdata, offset);
+}
+
 static void ieee80211_set_default_queues(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
@@ -1399,15 +1438,6 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 				goto err_del_interface;
 		}
 
-		if (sdata->vif.type == NL80211_IFTYPE_AP) {
-			local->fif_pspoll++;
-			local->fif_probe_req++;
-
-			ieee80211_configure_filter(local);
-		} else if (sdata->vif.type == NL80211_IFTYPE_ADHOC) {
-			local->fif_probe_req++;
-		}
-
 		if (sdata->vif.probe_req_reg)
 			drv_config_iface_filter(local, sdata,
 						FIF_PROBE_REQ,
@@ -1445,6 +1475,9 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 			sdata->vif.type != NL80211_IFTYPE_STATION);
 	}
 
+	if (ieee80211_sdata_set_filter(sdata, 1))
+		ieee80211_configure_filter(local);
+
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_P2P_DEVICE:
 		rcu_assign_pointer(local->p2p_sdata, sdata);
@@ -1458,14 +1491,6 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		break;
 	}
 
-	/*
-	 * set_multicast_list will be invoked by the networking core
-	 * which will check whether any increments here were done in
-	 * error and sync them down to the hardware as filter flags.
-	 */
-	if (sdata->flags & IEEE80211_SDATA_ALLMULTI)
-		atomic_inc(&local->iff_allmultis);
-
 	if (coming_up) {
 		local->open_count++;
 		for (i = 0; i < local->hw.wiphy->n_radio; i++) {
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 2ce771744ea8..ce2ed4c06a8c 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -34,54 +34,80 @@
 #include "led.h"
 #include "debugfs.h"
 
-void ieee80211_configure_filter(struct ieee80211_local *local)
+static void
+__ieee80211_configure_filter(struct ieee80211_local *local,
+			   int radio_idx)
 {
-	u64 mc;
+	struct ieee80211_radio_filter *filter;
 	unsigned int changed_flags;
 	unsigned int new_flags = 0;
+	u32 monitors;
+	u64 mc;
 
-	if (atomic_read(&local->iff_allmultis))
+	if (radio_idx >= 0) {
+		filter = &local->radio_data[radio_idx].filter;
+		monitors = local->radio_data[radio_idx].monitors;
+	} else {
+		filter = &local->filter;
+		monitors = local->monitors;
+	}
+
+	if (atomic_read(&filter->iff_allmultis))
 		new_flags |= FIF_ALLMULTI;
 
-	if (local->monitors || test_bit(SCAN_SW_SCANNING, &local->scanning) ||
+	if (monitors || test_bit(SCAN_SW_SCANNING, &local->scanning) ||
 	    test_bit(SCAN_ONCHANNEL_SCANNING, &local->scanning))
 		new_flags |= FIF_BCN_PRBRESP_PROMISC;
 
-	if (local->fif_probe_req || local->probe_req_reg)
+	if (filter->fif_probe_req || local->probe_req_reg)
 		new_flags |= FIF_PROBE_REQ;
 
-	if (local->fif_fcsfail)
+	if (filter->fif_fcsfail)
 		new_flags |= FIF_FCSFAIL;
 
-	if (local->fif_plcpfail)
+	if (filter->fif_plcpfail)
 		new_flags |= FIF_PLCPFAIL;
 
-	if (local->fif_control)
+	if (filter->fif_control)
 		new_flags |= FIF_CONTROL;
 
-	if (local->fif_other_bss)
+	if (filter->fif_other_bss)
 		new_flags |= FIF_OTHER_BSS;
 
-	if (local->fif_pspoll)
+	if (filter->fif_pspoll)
 		new_flags |= FIF_PSPOLL;
 
 	if (local->rx_mcast_action_reg)
 		new_flags |= FIF_MCAST_ACTION;
 
 	spin_lock_bh(&local->filter_lock);
-	changed_flags = local->filter_flags ^ new_flags;
+	changed_flags = filter->filter_flags ^ new_flags;
 
-	mc = drv_prepare_multicast(local, &local->mc_list);
+	if (radio_idx < 0)
+		mc = drv_prepare_multicast(local, &local->mc_list);
 	spin_unlock_bh(&local->filter_lock);
 
-	/* be a bit nasty */
-	new_flags |= (1<<31);
 
-	drv_configure_filter(local, changed_flags, &new_flags, mc);
+	if (radio_idx < 0) {
+		/* be a bit nasty */
+		new_flags |= (1<<31);
+
+		drv_configure_filter(local, changed_flags, &new_flags, mc);
 
-	WARN_ON(new_flags & (1<<31));
+		WARN_ON(new_flags & (1<<31));
+	} else {
+		drv_config_radio_filter(local, radio_idx, changed_flags, &new_flags);
+	}
+
+	filter->filter_flags = new_flags & ~(1<<31);
+}
+
+void ieee80211_configure_filter(struct ieee80211_local *local)
+{
+	int i;
 
-	local->filter_flags = new_flags & ~(1<<31);
+	for (i = -1; i < local->hw.wiphy->n_radio; i++)
+		__ieee80211_configure_filter(local, i);
 }
 
 static void ieee80211_reconfig_filter(struct wiphy *wiphy,
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index f94e4be0be12..db4e6028074f 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1170,6 +1170,29 @@ void ieee80211_mbss_info_change_notify(struct ieee80211_sub_if_data *sdata,
 	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 }
 
+static void
+__ieee80211_mesh_set_filter(struct ieee80211_radio_filter *filter, int ofs)
+{
+	filter->fif_other_bss += ofs;
+
+	/* mesh ifaces must set allmulti to forward mcast traffic */
+	atomic_add(ofs, &filter->iff_allmultis);
+}
+
+static void
+ieee80211_mesh_set_filter(struct ieee80211_sub_if_data *sdata, int ofs)
+{
+	struct ieee80211_local *local = sdata->local;
+	int i;
+
+	__ieee80211_mesh_set_filter(&local->filter, ofs);
+	for (i = 0; i < local->hw.wiphy->n_radio; i++)
+		if (sdata->wdev.radio_mask & BIT(i))
+			__ieee80211_mesh_set_filter(&local->radio_data[i].filter,
+						    ofs);
+	ieee80211_configure_filter(local);
+}
+
 int ieee80211_start_mesh(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
@@ -1181,11 +1204,7 @@ int ieee80211_start_mesh(struct ieee80211_sub_if_data *sdata)
 		      BSS_CHANGED_BEACON_INT |
 		      BSS_CHANGED_MCAST_RATE;
 
-	local->fif_other_bss++;
-	/* mesh ifaces must set allmulti to forward mcast traffic */
-	atomic_inc(&local->iff_allmultis);
-	ieee80211_configure_filter(local);
-
+	ieee80211_mesh_set_filter(sdata, 1);
 	ifmsh->mesh_cc_id = 0;	/* Disabled */
 	/* register sync ops from extensible synchronization framework */
 	ifmsh->sync_ops = ieee80211_mesh_sync_ops_get(ifmsh->mesh_sp_id);
@@ -1249,9 +1268,7 @@ void ieee80211_stop_mesh(struct ieee80211_sub_if_data *sdata)
 	ifmsh->wrkq_flags = 0;
 	memset(ifmsh->mbss_changed, 0, sizeof(ifmsh->mbss_changed));
 
-	local->fif_other_bss--;
-	atomic_dec(&local->iff_allmultis);
-	ieee80211_configure_filter(local);
+	ieee80211_mesh_set_filter(sdata, -1);
 }
 
 static void ieee80211_mesh_csa_mark_radar(struct ieee80211_sub_if_data *sdata)
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 0b6b4ebc681a..6504935b11e3 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -610,6 +610,34 @@ TRACE_EVENT(drv_configure_filter,
 	)
 );
 
+TRACE_EVENT(drv_config_radio_filter,
+	TP_PROTO(struct ieee80211_local *local,
+		 unsigned int radio,
+		 unsigned int changed_flags,
+		 unsigned int *total_flags),
+
+	TP_ARGS(local, radio, changed_flags, total_flags),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(unsigned int, radio)
+		__field(unsigned int, changed)
+		__field(unsigned int, total)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		__entry->radio = radio;
+		__entry->changed = changed_flags;
+		__entry->total = *total_flags;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT " radio:%d, changed:%#x total:%#x",
+		LOCAL_PR_ARG, __entry->radio, __entry->changed, __entry->total
+	)
+);
+
 TRACE_EVENT(drv_config_iface_filter,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
-- 
git-series 0.9.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3B35374AB
	for <lists+linux-wireless@lfdr.de>; Mon, 30 May 2022 09:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiE3Gsk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 02:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiE3Gsj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 02:48:39 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341CD4ECEE
        for <linux-wireless@vger.kernel.org>; Sun, 29 May 2022 23:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653893318; x=1685429318;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=vuBf2vhvt1gnkzZHnIfo3JxvuUhaWO5evclFnU7fxdw=;
  b=Bce1JJkFRvn8SRQycBBlqc5/7WhTfzkD1uDMDoyaITwwgZVD1gQuvbOr
   KYdqbKp45RGKTv9VVQcOnDjaD1XxuKoWGlDMnUF+7tQ0FMutYSG8Xg8kt
   5CkS+DZ+LtoYcbfHMqku2LREV6stQOJFAPVRtBydBV6S93dNuxpbFvSNz
   w=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 29 May 2022 23:48:38 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 23:48:37 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 29 May 2022 23:48:37 -0700
Received: from haric-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 29 May 2022 23:48:35 -0700
From:   <quic_haric@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Hari Chandrakanthan <quic_haric@quicinc.com>
Subject: [PATCH] mac80211 : Add support to track mesh peer beacon miss event
Date:   Mon, 30 May 2022 12:18:12 +0530
Message-ID: <1653893292-11092-1-git-send-email-quic_haric@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Hari Chandrakanthan <quic_haric@quicinc.com>

Mesh peer beacon miss log helps in debugging mesh connectivity
related issues.

Set dbg_mask to track the mesh peer beacon miss event
cmd to set dbg_mask :
echo 0xN > /sys/kernel/debug/ieee80211/phyX/dbg_mask
N - 0,1

Set the timer period using bmiss_threshold.
cmd to set bmiss_threshold:
echo N > /sys/kernel/debug/ieee80211/phyX/netdev\:wlanX/bmiss_threshold
N - 1 to 255

Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
---
 include/net/mac80211.h        | 20 ++++++++++++
 net/mac80211/debugfs.c        | 36 ++++++++++++++++++++++
 net/mac80211/debugfs_netdev.c | 28 +++++++++++++++++
 net/mac80211/mesh.c           |  5 +++
 net/mac80211/mesh.h           |  4 +++
 net/mac80211/mesh_plink.c     | 71 +++++++++++++++++++++++++++++++++++++++++++
 net/mac80211/sta_info.c       |  1 +
 net/mac80211/sta_info.h       |  7 +++++
 8 files changed, 172 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index b8e8c82..5ce5f7a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1732,6 +1732,9 @@ enum ieee80211_offload_flags {
  *	for read access.
  * @color_change_color: the bss color that will be used after the change.
  * @mbssid_tx_vif: Pointer to the transmitting interface if MBSSID is enabled.
+ * @bmiss_threshold: beacon miss threshold that is used to change the beacon miss
+ * timer value
+ *
  */
 struct ieee80211_vif {
 	enum nl80211_iftype type;
@@ -1764,6 +1767,7 @@ struct ieee80211_vif {
 	u8 color_change_color;
 
 	struct ieee80211_vif *mbssid_tx_vif;
+	u8 bmiss_threshold;
 
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
@@ -2495,6 +2499,19 @@ enum ieee80211_hw_flags {
 };
 
 /**
+ * enum ieee80211_dbg_mask - Debug mask to enable and disable logs
+ * in runtime
+ *
+ * @IEEE80211_HW_DBG_BMISS_LOG - To enable/disable mesh beacon miss logs
+ *
+ * @IEEE80211_HW_MAX_DBG_MASK - Max debug mask value
+ */
+enum ieee80211_dbg_mask {
+	IEEE80211_HW_DBG_BMISS_LOG = BIT(0),
+	IEEE80211_HW_MAX_DBG_MASK = BIT(1)
+};
+
+/**
  * struct ieee80211_hw - hardware information and state
  *
  * This structure contains the configuration and hardware
@@ -2618,6 +2635,8 @@ enum ieee80211_hw_flags {
  *	refilling deficit of each TXQ.
  *
  * @max_mtu: the max mtu could be set.
+ *
+ * @dbg_mask: debug mask
  */
 struct ieee80211_hw {
 	struct ieee80211_conf conf;
@@ -2656,6 +2675,7 @@ struct ieee80211_hw {
 	u8 tx_sk_pacing_shift;
 	u8 weight_multiplier;
 	u32 max_mtu;
+	u32 dbg_mask;
 };
 
 static inline bool _ieee80211_hw_check(struct ieee80211_hw *hw,
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index f4c9a92..17470f3 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -422,6 +422,41 @@ static const struct file_operations airtime_ops = {
 	.llseek = default_llseek,
 };
 
+static ssize_t dbg_mask_read(struct file *file, char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	struct ieee80211_local *local = file->private_data;
+	char buf[128];
+	int len;
+
+	len = scnprintf(buf, sizeof(buf), "0x%x\n", local->hw.dbg_mask);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static ssize_t dbg_mask_write(struct file *file, const char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	struct ieee80211_local *local = file->private_data;
+	int ret;
+	u32 mask;
+
+	ret = kstrtou32_from_user(user_buf, count, 0, &mask);
+	if (ret || mask >= IEEE80211_HW_MAX_DBG_MASK)
+		return -EINVAL;
+
+	local->hw.dbg_mask = mask;
+
+	return count;
+}
+
+static const struct file_operations dbg_mask_ops = {
+	.write = dbg_mask_write,
+	.read = dbg_mask_read,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
 #ifdef CONFIG_PM
 static ssize_t reset_write(struct file *file, const char __user *user_buf,
 			   size_t count, loff_t *ppos)
@@ -670,6 +705,7 @@ void debugfs_hw_add(struct ieee80211_local *local)
 	DEBUGFS_ADD(hw_conf);
 	DEBUGFS_ADD_MODE(force_tx_status, 0600);
 	DEBUGFS_ADD_MODE(aql_enable, 0600);
+	DEBUGFS_ADD_MODE(dbg_mask, 0600);
 
 	if (local->ops->wake_tx_queue)
 		DEBUGFS_ADD_MODE(aqm, 0600);
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index e490c3d..51cc7b0 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -297,6 +297,32 @@ static ssize_t ieee80211_if_parse_smps(struct ieee80211_sub_if_data *sdata,
 }
 IEEE80211_IF_FILE_RW(smps);
 
+static ssize_t ieee80211_if_fmt_bmiss_threshold(const struct ieee80211_sub_if_data *sdata,
+						char *buf, int buflen)
+{
+	return snprintf(buf, buflen, "%u\n", sdata->vif.bmiss_threshold);
+}
+
+static ssize_t ieee80211_if_parse_bmiss_threshold(struct ieee80211_sub_if_data *sdata,
+						  const char *buf, int buflen)
+{
+	int ret;
+	u8 val;
+
+	ret = kstrtou8(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	if (!val)
+		return -EINVAL;
+
+	sdata->vif.bmiss_threshold = val;
+
+	return buflen;
+}
+
+IEEE80211_IF_FILE_RW(bmiss_threshold);
+
 static ssize_t ieee80211_if_parse_tkip_mic_test(
 	struct ieee80211_sub_if_data *sdata, const char *buf, int buflen)
 {
@@ -711,6 +737,7 @@ static void add_ap_files(struct ieee80211_sub_if_data *sdata)
 	DEBUGFS_ADD(num_buffered_multicast);
 	DEBUGFS_ADD_MODE(tkip_mic_test, 0200);
 	DEBUGFS_ADD_MODE(multicast_to_unicast, 0600);
+	DEBUGFS_ADD_MODE(bmiss_threshold, 0600);
 }
 
 static void add_vlan_files(struct ieee80211_sub_if_data *sdata)
@@ -731,6 +758,7 @@ static void add_mesh_files(struct ieee80211_sub_if_data *sdata)
 {
 	DEBUGFS_ADD_MODE(tsf, 0600);
 	DEBUGFS_ADD_MODE(estab_plinks, 0400);
+	DEBUGFS_ADD_MODE(bmiss_threshold, 0600);
 }
 
 static void add_mesh_stats(struct ieee80211_sub_if_data *sdata)
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 5275f4f..5e54e6f 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -163,6 +163,8 @@ void mesh_sta_cleanup(struct sta_info *sta)
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	u32 changed = mesh_plink_deactivate(sta);
 
+	del_timer_sync(&sta->mesh->bmiss_timer);
+
 	if (changed)
 		ieee80211_mbss_info_change_notify(sdata, changed);
 }
@@ -1359,6 +1361,9 @@ static void ieee80211_mesh_rx_bcn_presp(struct ieee80211_sub_if_data *sdata,
 		if (ifmsh->csa_role != IEEE80211_MESH_CSA_ROLE_INIT &&
 		    !sdata->vif.csa_active)
 			ieee80211_mesh_process_chnswitch(sdata, elems, true);
+
+		if (stype != IEEE80211_STYPE_PROBE_RESP)
+			mesh_bmiss_update(sdata, mgmt, elems, rx_status);
 	}
 
 	if (ifmsh->sync_ops)
diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index b2b717a..2c2240d 100644
--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -263,6 +263,9 @@ int mesh_path_send_to_gates(struct mesh_path *mpath);
 int mesh_gate_num(struct ieee80211_sub_if_data *sdata);
 u32 airtime_link_metric_get(struct ieee80211_local *local,
 			    struct sta_info *sta);
+void mesh_bmiss_update(struct ieee80211_sub_if_data *sdata,
+		       struct ieee80211_mgmt *mgmt, struct ieee802_11_elems *ie,
+		       struct ieee80211_rx_status *rx_status);
 
 /* Mesh plinks */
 void mesh_neighbour_update(struct ieee80211_sub_if_data *sdata,
@@ -298,6 +301,7 @@ void mesh_path_discard_frame(struct ieee80211_sub_if_data *sdata,
 void mesh_path_tx_root_frame(struct ieee80211_sub_if_data *sdata);
 
 bool mesh_action_is_path_sel(struct ieee80211_mgmt *mgmt);
+void mesh_bmiss_event(struct timer_list *t);
 
 #ifdef CONFIG_MAC80211_MESH
 static inline
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index a829470..ac693c4 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -594,6 +594,77 @@ mesh_sta_info_get(struct ieee80211_sub_if_data *sdata,
 }
 
 /*
+ * mesh_bmiss_update - update beacon miss parameters such as
+ * beacon count, beacon interval and timeout of beacon miss
+ * timer
+ *
+ * @sdata: local meshif
+ * @mgmt: mgmt frame info
+ * @elems: IEs from beacon or mesh peering frame.
+ * @rx_status: rx status for the frame for signal reporting
+ *
+ */
+
+void mesh_bmiss_update(struct ieee80211_sub_if_data *sdata,
+		       struct ieee80211_mgmt *mgmt,
+		       struct ieee802_11_elems *elems,
+		       struct ieee80211_rx_status *rx_status)
+{
+	struct sta_info *sta;
+	u32 timeout;
+
+	/* mesh_sta_info_get api returns with rcu_read_lock */
+	sta = mesh_sta_info_get(sdata, mgmt->sa, elems, rx_status);
+	if (!sta)
+		goto unlock_rcu;
+
+	if (!(sta->local->hw.dbg_mask & IEEE80211_HW_DBG_BMISS_LOG) ||
+	    !sta->sdata->vif.bmiss_threshold)
+		goto unlock_rcu;
+
+	sta->mesh->bmiss_count = 0;
+	sta->mesh->beacon_int = mgmt->u.beacon.beacon_int;
+	timeout = sta->mesh->beacon_int * sta->sdata->vif.bmiss_threshold;
+
+	mod_timer(&sta->mesh->bmiss_timer, (jiffies + msecs_to_jiffies(timeout)));
+
+unlock_rcu:
+	rcu_read_unlock();
+}
+
+/*
+ * mesh_bmiss_event - counts the beacon miss events and updates
+ * beacon miss timer
+ * @timer - beacon miss timer
+ *
+ */
+
+void mesh_bmiss_event(struct timer_list *timer)
+{
+	struct mesh_sta *mesh = from_timer(mesh, timer, bmiss_timer);
+	struct sta_info *sta;
+	u32 timeout;
+
+	rcu_read_lock();
+	sta = mesh->plink_sta;
+
+	if (!(sta->local->hw.dbg_mask & IEEE80211_HW_DBG_BMISS_LOG) ||
+	    !sta->sdata->vif.bmiss_threshold)
+		goto unlock_rcu;
+
+	mesh->bmiss_count++;
+	sdata_info(sta->sdata, "Beacon miss count %u from %pM\n",
+		   mesh->bmiss_count, sta->sta.addr);
+
+	timeout = sta->mesh->beacon_int * sta->sdata->vif.bmiss_threshold;
+
+	mod_timer(&sta->mesh->bmiss_timer, (jiffies + msecs_to_jiffies(timeout)));
+
+unlock_rcu:
+	rcu_read_unlock();
+}
+
+/*
  * mesh_neighbour_update - update or initialize new mesh neighbor.
  *
  * @sdata: local meshif
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 91fbb1e..66ea62c 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -367,6 +367,7 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 		if (!sdata->u.mesh.user_mpm)
 			timer_setup(&sta->mesh->plink_timer, mesh_plink_timer,
 				    0);
+		timer_setup(&sta->mesh->bmiss_timer, mesh_bmiss_event, 0);
 		sta->mesh->nonpeer_pm = NL80211_MESH_POWER_ACTIVE;
 	}
 #endif
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 379fd36..c95d03eb 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -397,6 +397,9 @@ DECLARE_EWMA(mesh_tx_rate_avg, 8, 16)
  * @connected_to_as: true if mesh STA has a path to a authentication server
  * @fail_avg: moving percentage of failed MSDUs
  * @tx_rate_avg: moving average of tx bitrate
+ * @bmiss_count: beacon miss count
+ * @bmiss_timer: timer to capture missed beacons
+ * @beacon_int: beacon interval
  */
 struct mesh_sta {
 	struct timer_list plink_timer;
@@ -424,6 +427,10 @@ struct mesh_sta {
 	enum nl80211_mesh_power_mode peer_pm;
 	enum nl80211_mesh_power_mode nonpeer_pm;
 
+	struct timer_list bmiss_timer;
+	u32 bmiss_count;
+	u32 beacon_int;
+
 	/* moving percentage of failed MSDUs */
 	struct ewma_mesh_fail_avg fail_avg;
 	/* moving average of tx bitrate */
-- 
2.7.4


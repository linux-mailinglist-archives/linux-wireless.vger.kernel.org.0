Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530476F4AB7
	for <lists+linux-wireless@lfdr.de>; Tue,  2 May 2023 22:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjEBUAW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 May 2023 16:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjEBUAV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 May 2023 16:00:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6C892
        for <linux-wireless@vger.kernel.org>; Tue,  2 May 2023 13:00:18 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342JuraC014564;
        Tue, 2 May 2023 20:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=FKXx/yf4H/FmPapAIvp0oKbxH2FHQPJOydLZ1piGLEI=;
 b=fsP9DHEliv8pd2D/RjSGxDjM+uMJB20oiWi5dQfMOU5ESFYoK1lqItURaQmD7IOTLdIZ
 77NGFNI2CNGPAmQMP6EHtqk6oITS6Qo6X32SQ5HgLSt034Yztkx6SJs3gT5dybFALmcE
 wBtCwsCHpARTF0fMleCL6EXJ3g5l8JAnX9TX5tLEdIe5lO8pFsOXpfVzAzTK9tnK+nYf
 hRsjVyZILWD2Oxys5EecrtjAgUCoMdOKd08kJsf/IRV4W1oQN9AxlT4VI0KzY555YkF3
 TgLi2753j3nC5LRCuHJN+FYx1Yo15CgL9NIKq1Bj00y7KNRFB5uUdMG8ZFYeXnnRFUUL PA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qawcb9sjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 20:00:14 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 342K0E9K022256
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 May 2023 20:00:14 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 2 May 2023 13:00:12 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Hari Chandrakanthan <quic_haric@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v2] wifi: mac80211: Add support to track mesh peer beacon miss event
Date:   Wed, 3 May 2023 01:29:53 +0530
Message-ID: <20230502195953.30156-1-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cUAwiVkrXGBj-TBwnBsUhtGfTHnPjOL4
X-Proofpoint-ORIG-GUID: cUAwiVkrXGBj-TBwnBsUhtGfTHnPjOL4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_11,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305020170
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
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
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
v2: * u8 bmiss_threshold moved to sdata from ieee80211_vif
    * u32 dbg_mask moved to ieee80211_local from ieee80211_hw
    * enum ieee80211_dbg_mask moved to file ieee80211_i.h
---
 net/mac80211/debugfs.c        | 36 +++++++++++++++++
 net/mac80211/debugfs_netdev.c | 30 ++++++++++++++
 net/mac80211/ieee80211_i.h    | 20 ++++++++++
 net/mac80211/mesh.c           |  5 +++
 net/mac80211/mesh.h           |  4 ++
 net/mac80211/mesh_plink.c     | 74 +++++++++++++++++++++++++++++++++++
 net/mac80211/sta_info.c       |  1 +
 net/mac80211/sta_info.h       |  7 ++++
 8 files changed, 177 insertions(+)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index dfb9f55e2685..8fa39f1ce4bd 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -412,6 +412,41 @@ static const struct file_operations force_tx_status_ops = {
 	.llseek = default_llseek,
 };
 
+static ssize_t dbg_mask_read(struct file *file, char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	struct ieee80211_local *local = file->private_data;
+	char buf[128];
+	int len;
+
+	len = scnprintf(buf, sizeof(buf), "0x%x\n", local->dbg_mask);
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
+	local->dbg_mask = mask;
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
@@ -663,6 +698,7 @@ void debugfs_hw_add(struct ieee80211_local *local)
 	DEBUGFS_ADD_MODE(force_tx_status, 0600);
 	DEBUGFS_ADD_MODE(aql_enable, 0600);
 	DEBUGFS_ADD(aql_pending);
+	DEBUGFS_ADD_MODE(dbg_mask, 0600);
 	DEBUGFS_ADD_MODE(aqm, 0600);
 
 	DEBUGFS_ADD_MODE(airtime_flags, 0600);
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 0bac9af3ca96..0f6e2afa826b 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -297,6 +297,34 @@ static ssize_t ieee80211_if_parse_smps(struct ieee80211_sub_if_data *sdata,
 }
 IEEE80211_IF_FILE_RW(smps);
 
+static ssize_t
+	ieee80211_if_fmt_bmiss_threshold(const struct ieee80211_sub_if_data *sdata,
+					 char *buf, int buflen)
+{
+	return snprintf(buf, buflen, "%u\n", sdata->bmiss_threshold);
+}
+
+static ssize_t
+	ieee80211_if_parse_bmiss_threshold(struct ieee80211_sub_if_data *sdata,
+					   const char *buf, int buflen)
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
+	sdata->bmiss_threshold = val;
+
+	return buflen;
+}
+
+IEEE80211_IF_FILE_RW(bmiss_threshold);
+
 static ssize_t ieee80211_if_parse_tkip_mic_test(
 	struct ieee80211_sub_if_data *sdata, const char *buf, int buflen)
 {
@@ -704,6 +732,7 @@ static void add_ap_files(struct ieee80211_sub_if_data *sdata)
 	DEBUGFS_ADD(num_buffered_multicast);
 	DEBUGFS_ADD_MODE(tkip_mic_test, 0200);
 	DEBUGFS_ADD_MODE(multicast_to_unicast, 0600);
+	DEBUGFS_ADD_MODE(bmiss_threshold, 0600);
 }
 
 static void add_vlan_files(struct ieee80211_sub_if_data *sdata)
@@ -724,6 +753,7 @@ static void add_mesh_files(struct ieee80211_sub_if_data *sdata)
 {
 	DEBUGFS_ADD_MODE(tsf, 0600);
 	DEBUGFS_ADD_MODE(estab_plinks, 0400);
+	DEBUGFS_ADD_MODE(bmiss_threshold, 0600);
 }
 
 static void add_mesh_stats(struct ieee80211_sub_if_data *sdata)
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e082582e0aa2..86e2757a8b2e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1098,6 +1098,10 @@ struct ieee80211_sub_if_data {
 		struct dentry *default_beacon_key;
 	} debugfs;
 #endif
+	/* beacon miss threshold that is used to change the beacon miss
+	 * timer value
+	 */
+	u8 bmiss_threshold;
 
 	/* must be last, dynamically sized area in this! */
 	struct ieee80211_vif vif;
@@ -1269,6 +1273,19 @@ enum mac80211_scan_state {
 
 DECLARE_STATIC_KEY_FALSE(aql_disable);
 
+/**
+ * enum ieee80211_dbg_mask - Debug mask to enable and disable logs
+ * in runtime
+ *
+ * @IEEE80211_HW_DBG_BMISS_LOG: To enable/disable mesh beacon miss logs
+ *
+ * @IEEE80211_HW_MAX_DBG_MASK: Max debug mask value
+ */
+enum ieee80211_dbg_mask {
+	IEEE80211_HW_DBG_BMISS_LOG = BIT(0),
+	IEEE80211_HW_MAX_DBG_MASK = BIT(1)
+};
+
 struct ieee80211_local {
 	/* embed the driver visible part.
 	 * don't cast (use the static inlines below), but we keep
@@ -1559,6 +1576,9 @@ struct ieee80211_local {
 
 	/* extended capabilities provided by mac80211 */
 	u8 ext_capa[8];
+
+	/* debug mask */
+	u32 dbg_mask;
 };
 
 static inline struct ieee80211_sub_if_data *
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 5a99b8f6e465..03b9d4272093 100644
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
@@ -1357,6 +1359,9 @@ static void ieee80211_mesh_rx_bcn_presp(struct ieee80211_sub_if_data *sdata,
 		if (ifmsh->csa_role != IEEE80211_MESH_CSA_ROLE_INIT &&
 		    !sdata->vif.bss_conf.csa_active)
 			ieee80211_mesh_process_chnswitch(sdata, elems, true);
+
+		if (stype != IEEE80211_STYPE_PROBE_RESP)
+			mesh_bmiss_update(sdata, mgmt, elems, rx_status);
 	}
 
 	if (ifmsh->sync_ops)
diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index b2b717a78114..2c2240db1747 100644
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
index ddfe5102b9a4..ad5bb2fc1cfd 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -594,6 +594,80 @@ mesh_sta_info_get(struct ieee80211_sub_if_data *sdata,
 	return sta;
 }
 
+/**
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
+	if (!(sta->local->dbg_mask & IEEE80211_HW_DBG_BMISS_LOG) ||
+	    !sta->sdata->bmiss_threshold)
+		goto unlock_rcu;
+
+	sta->mesh->bmiss_count = 0;
+	sta->mesh->beacon_int = le16_to_cpu(mgmt->u.beacon.beacon_int);
+	timeout = sta->mesh->beacon_int * sta->sdata->bmiss_threshold;
+
+	mod_timer(&sta->mesh->bmiss_timer,
+		  (jiffies + msecs_to_jiffies(timeout)));
+
+unlock_rcu:
+	rcu_read_unlock();
+}
+
+/**
+ * mesh_bmiss_event - counts the beacon miss events and updates
+ * beacon miss timer
+ *
+ * @timer: beacon miss timer
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
+	if (!(sta->local->dbg_mask & IEEE80211_HW_DBG_BMISS_LOG) ||
+	    !sta->sdata->bmiss_threshold)
+		goto unlock_rcu;
+
+	mesh->bmiss_count++;
+	sdata_info(sta->sdata, "Beacon miss count %u from %pM\n",
+		   mesh->bmiss_count, sta->sta.addr);
+
+	timeout = sta->mesh->beacon_int * sta->sdata->bmiss_threshold;
+
+	mod_timer(&sta->mesh->bmiss_timer,
+		  (jiffies + msecs_to_jiffies(timeout)));
+
+unlock_rcu:
+	rcu_read_unlock();
+}
+
 /*
  * mesh_neighbour_update - update or initialize new mesh neighbor.
  *
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 941bda9141fa..875ebf4355af 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -567,6 +567,7 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 		if (!sdata->u.mesh.user_mpm)
 			timer_setup(&sta->mesh->plink_timer, mesh_plink_timer,
 				    0);
+		timer_setup(&sta->mesh->bmiss_timer, mesh_bmiss_event, 0);
 		sta->mesh->nonpeer_pm = NL80211_MESH_POWER_ACTIVE;
 	}
 #endif
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index e8e482a82d77..ed140c7a1795 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -391,6 +391,9 @@ DECLARE_EWMA(mesh_tx_rate_avg, 8, 16)
  * @connected_to_as: true if mesh STA has a path to a authentication server
  * @fail_avg: moving percentage of failed MSDUs
  * @tx_rate_avg: moving average of tx bitrate
+ * @bmiss_count: beacon miss count
+ * @bmiss_timer: timer to capture missed beacons
+ * @beacon_int: beacon interval
  */
 struct mesh_sta {
 	struct timer_list plink_timer;
@@ -418,6 +421,10 @@ struct mesh_sta {
 	enum nl80211_mesh_power_mode peer_pm;
 	enum nl80211_mesh_power_mode nonpeer_pm;
 
+	struct timer_list bmiss_timer;
+	u32 bmiss_count;
+	u16 beacon_int;
+
 	/* moving percentage of failed MSDUs */
 	struct ewma_mesh_fail_avg fail_avg;
 	/* moving average of tx bitrate */

base-commit: 50749f2dd6854a41830996ad302aef2ffaf011d8
-- 
2.17.1


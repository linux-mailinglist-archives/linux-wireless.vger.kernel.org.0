Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAC857F91B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jul 2022 07:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiGYFqZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jul 2022 01:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGYFqY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jul 2022 01:46:24 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7FCB7FE
        for <linux-wireless@vger.kernel.org>; Sun, 24 Jul 2022 22:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658727982; x=1690263982;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=yK/tPRqdDN3yTwURYHNz+WiqX9tTDHzNrYUYZMeC//0=;
  b=NP5tD9Yex7ma1Y6cVilshreLWVeDPZt5OYtFG9xFALIxRV+oNVyY0759
   AHq2xJXWyPNO1OWtk/DquLMWAlHEO6XXP0lKxRrxlU2fvzl3wAEbhPjVV
   hkXYGm+IzNVjAC71iFPuuyUyNoD6U5wgl0pPA7zsOsOU5cpIESDl+dxLY
   Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 Jul 2022 22:46:22 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 22:46:22 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 24 Jul 2022 22:46:22 -0700
Received: from tamizhr-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 24 Jul 2022 22:46:19 -0700
From:   Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Subject: [PATCH] ath11k: Add support to get power save duration for each client
Date:   Mon, 25 Jul 2022 11:16:01 +0530
Message-ID: <20220725054601.14719-1-quic_tamizhr@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>

Add support to get the following power save information through debugfs interface,

 * Current ps state of the peer
 * Time duration since the peer is in power save
 * Total duration of the peer spent in power save

Above information is helpful in debugging the issues with power save clients.

This patch also add trace log support for PS timekeeper to track the PS state
change of the peers alongs with the peer MAC address and timestamp.

Use the below commands to get the above power save information,

To know the time_since_station_in_power_save:
cat /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/stations/
XX:XX:XX:XX:XX:XX/current_ps_duration

To know power_save_duration:
cat /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/stations/
XX:XX:XX:XX:XX:XX/total_ps_duration

To reset the power_save_duration of all stations connected to AP:
echo 1 > /sys/kernel/debug/ieee80211/phyX/ath11k/reset_ps_duration

To enable/disable the ps_timekeeper:
echo Y > /sys/kernel/debug/ieee80211/phyX/ath11k/ps_timekeeper_enable
Y = 1 to enable and Y = 0 to disable.

To record PS timekeeer logs after enabling ps_timekeeper:
trace-cmd record -e ath11k_ps_timekeeper

Tested-on: Tested-on: IPQ8074 WLAN.HK.2.5.0.1-00991-QCAHKSWPL_SILICONZ-1

Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h        |  10 +
 drivers/net/wireless/ath/ath11k/debugfs.c     | 201 ++++++++++++++++++
 drivers/net/wireless/ath/ath11k/debugfs_sta.c | 107 ++++++++++
 drivers/net/wireless/ath/ath11k/mac.c         |   1 +
 drivers/net/wireless/ath/ath11k/trace.h       |  28 +++
 drivers/net/wireless/ath/ath11k/wmi.c         | 105 +++++++++
 drivers/net/wireless/ath/ath11k/wmi.h         |  21 ++
 7 files changed, 473 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 2bd5eb9df4d4..6a21e9a4994f 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -498,6 +498,13 @@ struct ath11k_sta {
 
 	bool use_4addr_set;
 	u16 tcl_metadata;
+
+	/* Protected with ar->data_lock */
+	enum ath11k_wmi_peer_ps_state peer_ps_state;
+	u64 ps_start_time;
+	u64 ps_start_jiffies;
+	u64 ps_total_duration;
+	bool peer_current_ps_valid;
 };
 
 #define ATH11K_MIN_5G_FREQ 4150
@@ -710,6 +717,9 @@ struct ath11k {
 	u8 twt_enabled;
 	bool nlo_enabled;
 	u8 alpha2[REG_ALPHA2_LEN + 1];
+	/* protected by conf_mutex */
+	bool ps_state_enable;
+	bool ps_timekeeper_enable;
 };
 
 struct ath11k_band_cap {
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 9648e0017393..f6333d89d15d 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -1382,6 +1382,193 @@ static const struct file_operations fops_dbr_debug = {
 	.llseek = default_llseek,
 };
 
+static ssize_t ath11k_write_ps_timekeeper_enable(struct file *file,
+						 const char __user *user_buf,
+						 size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	ssize_t ret;
+	u8 ps_timekeeper_enable;
+
+	if (kstrtou8_from_user(user_buf, count, 0, &ps_timekeeper_enable))
+		return -EINVAL;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state != ATH11K_STATE_ON) {
+		ret = -ENETDOWN;
+		goto exit;
+	}
+
+	if (!ar->ps_state_enable) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	ar->ps_timekeeper_enable = !!ps_timekeeper_enable;
+	ret = count;
+exit:
+	mutex_unlock(&ar->conf_mutex);
+
+	return ret;
+}
+
+static ssize_t ath11k_read_ps_timekeeper_enable(struct file *file,
+						char __user *user_buf,
+						size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	char buf[32];
+	int len;
+
+	mutex_lock(&ar->conf_mutex);
+	len = scnprintf(buf, sizeof(buf), "%d\n", ar->ps_timekeeper_enable);
+	mutex_unlock(&ar->conf_mutex);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static const struct file_operations fops_ps_timekeeper_enable = {
+	.read = ath11k_read_ps_timekeeper_enable,
+	.write = ath11k_write_ps_timekeeper_enable,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static void ath11k_reset_peer_ps_duration(void *data,
+					  struct ieee80211_sta *sta)
+{
+	struct ath11k *ar = data;
+	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+
+	spin_lock_bh(&ar->data_lock);
+	arsta->ps_total_duration = 0;
+	spin_unlock_bh(&ar->data_lock);
+}
+
+static ssize_t ath11k_write_reset_ps_duration(struct file *file,
+					      const  char __user *user_buf,
+					      size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	int ret;
+	u8 reset_ps_duration;
+
+	if (kstrtou8_from_user(user_buf, count, 0, &reset_ps_duration))
+		return -EINVAL;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state != ATH11K_STATE_ON) {
+		ret = -ENETDOWN;
+		goto exit;
+	}
+
+	if (!ar->ps_state_enable) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	ieee80211_iterate_stations_atomic(ar->hw,
+					  ath11k_reset_peer_ps_duration,
+					  ar);
+
+	ret = count;
+exit:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+static const struct file_operations fops_reset_ps_duration = {
+	.write = ath11k_write_reset_ps_duration,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static void ath11k_peer_ps_state_disable(void *data,
+					 struct ieee80211_sta *sta)
+{
+	struct ath11k *ar = data;
+	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+
+	spin_lock_bh(&ar->data_lock);
+	arsta->peer_ps_state = WMI_PEER_PS_STATE_DISABLED;
+	arsta->ps_start_time = 0;
+	arsta->ps_total_duration = 0;
+	spin_unlock_bh(&ar->data_lock);
+}
+
+static ssize_t ath11k_write_ps_state_enable(struct file *file,
+					    const char __user *user_buf,
+					    size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	struct ath11k_pdev *pdev = ar->pdev;
+	int ret;
+	u32 param;
+	u8 ps_state_enable;
+
+	if (kstrtou8_from_user(user_buf, count, 0, &ps_state_enable))
+		return -EINVAL;
+
+	mutex_lock(&ar->conf_mutex);
+
+	ps_state_enable = !!ps_state_enable;
+
+	if (ar->ps_state_enable == ps_state_enable) {
+		ret = count;
+		goto exit;
+	}
+
+	param = WMI_PDEV_PEER_STA_PS_STATECHG_ENABLE;
+	ret = ath11k_wmi_pdev_set_param(ar, param, ps_state_enable, pdev->pdev_id);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to enable ps_state_enable: %d\n",
+			    ret);
+		goto exit;
+	}
+	ar->ps_state_enable = ps_state_enable;
+
+	if (!ar->ps_state_enable) {
+		ar->ps_timekeeper_enable = false;
+		ieee80211_iterate_stations_atomic(ar->hw,
+						  ath11k_peer_ps_state_disable,
+						  ar);
+	}
+
+	ret = count;
+
+exit:
+	mutex_unlock(&ar->conf_mutex);
+
+	return ret;
+}
+
+static ssize_t ath11k_read_ps_state_enable(struct file *file,
+					   char __user *user_buf,
+					   size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	char buf[32];
+	int len;
+
+	mutex_lock(&ar->conf_mutex);
+	len = scnprintf(buf, sizeof(buf), "%d\n", ar->ps_state_enable);
+	mutex_unlock(&ar->conf_mutex);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static const struct file_operations fops_ps_state_enable = {
+	.read = ath11k_read_ps_state_enable,
+	.write = ath11k_write_ps_state_enable,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
 int ath11k_debugfs_register(struct ath11k *ar)
 {
 	struct ath11k_base *ab = ar->ab;
@@ -1428,6 +1615,20 @@ int ath11k_debugfs_register(struct ath11k *ar)
 		debugfs_create_file("enable_dbr_debug", 0200, ar->debug.debugfs_pdev,
 				    ar, &fops_dbr_debug);
 
+	debugfs_create_file("ps_state_enable", 0600, ar->debug.debugfs_pdev, ar,
+			    &fops_ps_state_enable);
+
+	if (test_bit(WMI_TLV_SERVICE_PEER_POWER_SAVE_DURATION_SUPPORT,
+		     ar->ab->wmi_ab.svc_map)) {
+		debugfs_create_file("ps_timekeeper_enable", 0600,
+				    ar->debug.debugfs_pdev, ar,
+				    &fops_ps_timekeeper_enable);
+
+		debugfs_create_file("reset_ps_duration", 0200,
+				    ar->debug.debugfs_pdev, ar,
+				    &fops_reset_ps_duration);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
index 1b1acbdf837a..9cc4ef28e751 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -751,6 +751,102 @@ static const struct file_operations fops_htt_peer_stats_reset = {
 	.llseek = default_llseek,
 };
 
+static ssize_t ath11k_dbg_sta_read_peer_ps_state(struct file *file,
+						 char __user *user_buf,
+						 size_t count, loff_t *ppos)
+{
+	struct ieee80211_sta *sta = file->private_data;
+	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k *ar = arsta->arvif->ar;
+	char buf[20];
+	int len;
+
+	spin_lock_bh(&ar->data_lock);
+
+	len = scnprintf(buf, sizeof(buf), "%d\n", arsta->peer_ps_state);
+
+	spin_unlock_bh(&ar->data_lock);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static const struct file_operations fops_peer_ps_state = {
+	.open = simple_open,
+	.read = ath11k_dbg_sta_read_peer_ps_state,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static ssize_t ath11k_dbg_sta_read_current_ps_duration(struct file *file,
+						       char __user *user_buf,
+						       size_t count,
+						       loff_t *ppos)
+{
+	struct ieee80211_sta *sta = file->private_data;
+	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k *ar = arsta->arvif->ar;
+	u64 time_since_station_in_power_save;
+	char buf[20];
+	int len;
+
+	spin_lock_bh(&ar->data_lock);
+
+	if (arsta->peer_ps_state == WMI_PEER_PS_STATE_ON &&
+	    arsta->peer_current_ps_valid)
+		time_since_station_in_power_save = jiffies_to_msecs(jiffies
+						- arsta->ps_start_jiffies);
+	else
+		time_since_station_in_power_save = 0;
+
+	len = scnprintf(buf, sizeof(buf), "%llu\n",
+			time_since_station_in_power_save);
+	spin_unlock_bh(&ar->data_lock);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static const struct file_operations fops_current_ps_duration = {
+	.open = simple_open,
+	.read = ath11k_dbg_sta_read_current_ps_duration,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static ssize_t ath11k_dbg_sta_read_total_ps_duration(struct file *file,
+						     char __user *user_buf,
+						     size_t count, loff_t *ppos)
+{
+	struct ieee80211_sta *sta = file->private_data;
+	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k *ar = arsta->arvif->ar;
+	char buf[20];
+	u64 power_save_duration;
+	int len;
+
+	spin_lock_bh(&ar->data_lock);
+
+	if (arsta->peer_ps_state == WMI_PEER_PS_STATE_ON &&
+	    arsta->peer_current_ps_valid)
+		power_save_duration = jiffies_to_msecs(jiffies
+						- arsta->ps_start_jiffies)
+						+ arsta->ps_total_duration;
+	else
+		power_save_duration = arsta->ps_total_duration;
+
+	len = scnprintf(buf, sizeof(buf), "%llu\n", power_save_duration);
+
+	spin_unlock_bh(&ar->data_lock);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static const struct file_operations fops_total_ps_duration = {
+	.open = simple_open,
+	.read = ath11k_dbg_sta_read_total_ps_duration,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
 void ath11k_debugfs_sta_op_add(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			       struct ieee80211_sta *sta, struct dentry *dir)
 {
@@ -778,4 +874,15 @@ void ath11k_debugfs_sta_op_add(struct ieee80211_hw *hw, struct ieee80211_vif *vi
 		     ar->ab->wmi_ab.svc_map))
 		debugfs_create_file("htt_peer_stats_reset", 0600, dir, sta,
 				    &fops_htt_peer_stats_reset);
+
+	debugfs_create_file("peer_ps_state", 0400, dir, sta,
+			    &fops_peer_ps_state);
+
+	if (test_bit(WMI_TLV_SERVICE_PEER_POWER_SAVE_DURATION_SUPPORT,
+		     ar->ab->wmi_ab.svc_map)) {
+		debugfs_create_file("current_ps_duration", 0440, dir, sta,
+				    &fops_current_ps_duration);
+		debugfs_create_file("total_ps_duration", 0440, dir, sta,
+				    &fops_total_ps_duration);
+	}
 }
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 17dbc7d9cf29..fb7f27a28302 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4523,6 +4523,7 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 	    new_state == IEEE80211_STA_NONE) {
 		memset(arsta, 0, sizeof(*arsta));
 		arsta->arvif = arvif;
+		arsta->peer_ps_state = WMI_PEER_PS_STATE_DISABLED;
 		INIT_WORK(&arsta->update_wk, ath11k_sta_rc_update_wk);
 		INIT_WORK(&arsta->set_4addr_wk, ath11k_sta_set_4addr_wk);
 
diff --git a/drivers/net/wireless/ath/ath11k/trace.h b/drivers/net/wireless/ath/ath11k/trace.h
index a02e54735e88..d7fe24e0391e 100644
--- a/drivers/net/wireless/ath/ath11k/trace.h
+++ b/drivers/net/wireless/ath/ath11k/trace.h
@@ -308,6 +308,34 @@ TRACE_EVENT(ath11k_wmi_diag,
 	)
 );
 
+TRACE_EVENT(ath11k_ps_timekeeper,
+	    TP_PROTO(struct ath11k *ar, const void *peer_addr,
+		     u32 peer_ps_timestamp, u8 peer_ps_state),
+	TP_ARGS(ar, peer_addr, peer_ps_timestamp, peer_ps_state),
+
+	TP_STRUCT__entry(__string(device, dev_name(ar->ab->dev))
+			 __string(driver, dev_driver_string(ar->ab->dev))
+			 __dynamic_array(u8, peer_addr, ETH_ALEN)
+			 __field(u8, peer_ps_state)
+			 __field(u32, peer_ps_timestamp)
+	),
+
+	TP_fast_assign(__assign_str(device, dev_name(ar->ab->dev));
+		       __assign_str(driver, dev_driver_string(ar->ab->dev));
+		       memcpy(__get_dynamic_array(peer_addr), peer_addr,
+			      ETH_ALEN);
+		       __entry->peer_ps_state = peer_ps_state;
+		       __entry->peer_ps_timestamp = peer_ps_timestamp;
+	),
+
+	TP_printk("%s %s %u %u",
+		  __get_str(driver),
+		  __get_str(device),
+		  __entry->peer_ps_state,
+		  __entry->peer_ps_timestamp
+	)
+);
+
 #endif /* _TRACE_H_ || TRACE_HEADER_MULTI_READ*/
 
 /* we don't want to use include/trace/events */
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 5d9437ea92cf..b8c36714ec12 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -6771,6 +6771,108 @@ static void ath11k_bcn_tx_status_event(struct ath11k_base *ab, struct sk_buff *s
 	rcu_read_unlock();
 }
 
+void
+ath11k_wmi_event_peer_sta_ps_state_chg(struct ath11k_base *ab,
+				       struct sk_buff *skb)
+{
+	const struct wmi_peer_sta_ps_state_chg_event *ev;
+	struct ieee80211_sta *sta;
+	struct ath11k_peer *peer;
+	struct ath11k *ar;
+	struct ath11k_sta *arsta;
+	const void **tb;
+	enum ath11k_wmi_peer_ps_state peer_previous_ps_state;
+	int ret;
+
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
+		return;
+	}
+
+	ev = tb[WMI_TAG_PEER_STA_PS_STATECHANGE_EVENT];
+	if (!ev) {
+		ath11k_warn(ab, "failed to fetch sta ps change ev");
+		kfree(tb);
+		return;
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "peer sta ps chnange ev addr %pM state %u sup_bitmap %x ps_valid %u ts %u\n",
+		   ev->peer_macaddr.addr, ev->peer_ps_state,
+		   ev->ps_supported_bitmap, ev->peer_ps_valid,
+		   ev->peer_ps_timestamp);
+
+	rcu_read_lock();
+
+	spin_lock_bh(&ab->base_lock);
+
+	peer = ath11k_peer_find_by_addr(ab, ev->peer_macaddr.addr);
+
+	if (!peer) {
+		spin_unlock_bh(&ab->base_lock);
+		ath11k_warn(ab, "peer not found %pM\n", ev->peer_macaddr.addr);
+		goto exit;
+	}
+
+	ar = ath11k_mac_get_ar_by_vdev_id(ab, peer->vdev_id);
+
+	if (!ar) {
+		spin_unlock_bh(&ab->base_lock);
+		ath11k_warn(ab, "invalid vdev id in peer sta ps state change ev %d",
+			    peer->vdev_id);
+
+		goto exit;
+	}
+
+	sta = peer->sta;
+
+	spin_unlock_bh(&ab->base_lock);
+
+	if (!sta) {
+		ath11k_warn(ab, "failed to find station entry %pM\n",
+			    ev->peer_macaddr.addr);
+		goto exit;
+	}
+
+	arsta = (struct ath11k_sta *)sta->drv_priv;
+
+	spin_lock_bh(&ar->data_lock);
+
+	peer_previous_ps_state = arsta->peer_ps_state;
+	arsta->peer_ps_state = ev->peer_ps_state;
+	arsta->peer_current_ps_valid = !!ev->peer_ps_valid;
+
+	if (test_bit(WMI_TLV_SERVICE_PEER_POWER_SAVE_DURATION_SUPPORT,
+		     ar->ab->wmi_ab.svc_map)) {
+		if (!(ev->ps_supported_bitmap & WMI_PEER_PS_VALID) ||
+		    !(ev->ps_supported_bitmap & WMI_PEER_PS_STATE_TIMESTAMP) ||
+		    !ev->peer_ps_valid)
+			goto out;
+
+		if (arsta->peer_ps_state == WMI_PEER_PS_STATE_ON) {
+			arsta->ps_start_time = ev->peer_ps_timestamp;
+			arsta->ps_start_jiffies = jiffies;
+		} else if (arsta->peer_ps_state == WMI_PEER_PS_STATE_OFF &&
+			   peer_previous_ps_state == WMI_PEER_PS_STATE_ON) {
+			arsta->ps_total_duration = arsta->ps_total_duration +
+					(ev->peer_ps_timestamp - arsta->ps_start_time);
+		}
+
+		if (ar->ps_timekeeper_enable)
+			trace_ath11k_ps_timekeeper(ar, ev->peer_macaddr.addr,
+						   ev->peer_ps_timestamp,
+						   arsta->peer_ps_state);
+	}
+
+out:
+	spin_unlock_bh(&ar->data_lock);
+exit:
+	rcu_read_unlock();
+	kfree(tb);
+}
+
 static void ath11k_vdev_stopped_event(struct ath11k_base *ab, struct sk_buff *skb)
 {
 	struct ath11k *ar;
@@ -8001,6 +8103,9 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_DIAG_EVENTID:
 		ath11k_wmi_diag_event(ab, skb);
 		break;
+	case WMI_PEER_STA_PS_STATECHG_EVENTID:
+		ath11k_wmi_event_peer_sta_ps_state_chg(ab, skb);
+		break;
 	case WMI_GTK_OFFLOAD_STATUS_EVENTID:
 		ath11k_wmi_gtk_offload_status_event(ab, skb);
 		break;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index b1fad4707dc6..1f9032a6e56c 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2090,6 +2090,7 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_PER_PEER_HTT_STATS_RESET = 213,
 	WMI_TLV_SERVICE_FREQINFO_IN_METADATA = 219,
 	WMI_TLV_SERVICE_EXT2_MSG = 220,
+	WMI_TLV_SERVICE_PEER_POWER_SAVE_DURATION_SUPPORT = 246,
 	WMI_TLV_SERVICE_SRG_SRP_SPATIAL_REUSE_SUPPORT = 249,
 
 	/* The second 128 bits */
@@ -5375,6 +5376,26 @@ struct wmi_debug_log_config_cmd_fixed_param {
 #define WMI_SERVICE_READY_TIMEOUT_HZ (5 * HZ)
 #define WMI_SEND_TIMEOUT_HZ (3 * HZ)
 
+enum ath11k_wmi_peer_ps_state {
+	WMI_PEER_PS_STATE_OFF,
+	WMI_PEER_PS_STATE_ON,
+	WMI_PEER_PS_STATE_DISABLED,
+};
+
+enum wmi_peer_ps_supported_bitmap {
+	/* Used to indicate that power save state change is valid */
+	WMI_PEER_PS_VALID = 0x1,
+	WMI_PEER_PS_STATE_TIMESTAMP = 0x2,
+};
+
+struct wmi_peer_sta_ps_state_chg_event {
+	struct wmi_mac_addr peer_macaddr;
+	u32 peer_ps_state;
+	u32 ps_supported_bitmap;
+	u32 peer_ps_valid;
+	u32 peer_ps_timestamp;
+} __packed;
+
 struct ath11k_wmi_base {
 	struct ath11k_base *ab;
 	struct ath11k_pdev_wmi wmi[MAX_RADIOS];
-- 
2.17.1


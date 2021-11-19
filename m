Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1457456C21
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 10:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhKSJLf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 04:11:35 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:56019 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230526AbhKSJLe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 04:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637312913; x=1668848913;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=qpvFPKdFx7/RSURMYVflG/IdXhbXa6VKgTlkMSI9q+M=;
  b=AbM+EGwo2lhY5iy9WE1pGouMpWhU5jUbrqyzY1Wh2JdSMYV1jCbsBggm
   bex8zT6stDd6jc23yilSbyewKat38fZfKGX8VPOyaQQhWTE/Uvr158+7K
   NKHP17WEVl0/4BF2sCAm0UghZpczA13LoD4qqz0fcUqbpmYlI6S/Jvuri
   c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Nov 2021 01:08:33 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 01:08:33 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 19 Nov 2021 01:08:32 -0800
Received: from vnaralas-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 19 Nov 2021 01:08:30 -0800
From:   Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Subject: [PATCHv2 1/2] ath11k: add dbring debug support
Date:   Fri, 19 Nov 2021 14:38:20 +0530
Message-ID: <1637312901-10279-1-git-send-email-quic_vnaralas@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Target copies spectral report and CFR report through dbring to
host for further processing. This mechanism involves ring and
buffer management in the Host, FW, and uCode, where improper
tail pointer update issues are seen.

This dbring debug support help to debug such issues by tracking
head and tail pointer movement along with the timestamp at which
each buffer is received and replenished.

Usage:

echo <module_id> <val> > /sys/kernel/debug/ath11k/ipq8074_2/
mac0/enable_dbr_debug

module_id: 0 for spectral and 1 for CFR
val: 0 - disable, 1 - enable.

Tested-on: IPQ8074 WLAN.HK.2.4.0.1-01467-QCAHKSWPL_SILICONZ-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
---
v2:
 * Rebased on TOT

 drivers/net/wireless/ath/ath11k/core.h    |   1 +
 drivers/net/wireless/ath/ath11k/dbring.c  |  19 ++-
 drivers/net/wireless/ath/ath11k/debugfs.c | 217 ++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/debugfs.h |  41 ++++++
 4 files changed, 272 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index bbfc10f..0d0fa830 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -442,6 +442,7 @@ struct ath11k_debug {
 	u32 pktlog_peer_valid;
 	u8 pktlog_peer_addr[ETH_ALEN];
 	u32 rx_filter;
+	struct ath11k_db_module_debug *module_debug[WMI_DIRECT_BUF_MAX];
 };
 
 struct ath11k_per_peer_tx_stats {
diff --git a/drivers/net/wireless/ath/ath11k/dbring.c b/drivers/net/wireless/ath/ath11k/dbring.c
index de220a1..31cf7ac 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.c
+++ b/drivers/net/wireless/ath/ath11k/dbring.c
@@ -8,7 +8,8 @@
 
 static int ath11k_dbring_bufs_replenish(struct ath11k *ar,
 					struct ath11k_dbring *ring,
-					struct ath11k_dbring_element *buff)
+					struct ath11k_dbring_element *buff,
+					enum wmi_direct_buffer_module id)
 {
 	struct ath11k_base *ab = ar->ab;
 	struct hal_srng *srng;
@@ -54,6 +55,7 @@ static int ath11k_dbring_bufs_replenish(struct ath11k *ar,
 
 	ath11k_hal_rx_buf_addr_info_set(desc, paddr, cookie, 0);
 
+	ath11k_dbring_add_debug_entry(ar, id, DBR_RING_DEBUG_EVENT_REPLENISH, srng);
 	ath11k_hal_srng_access_end(ab, srng);
 
 	return 0;
@@ -71,7 +73,8 @@ static int ath11k_dbring_bufs_replenish(struct ath11k *ar,
 }
 
 static int ath11k_dbring_fill_bufs(struct ath11k *ar,
-				   struct ath11k_dbring *ring)
+				   struct ath11k_dbring *ring,
+				   enum wmi_direct_buffer_module id)
 {
 	struct ath11k_dbring_element *buff;
 	struct hal_srng *srng;
@@ -99,7 +102,7 @@ static int ath11k_dbring_fill_bufs(struct ath11k *ar,
 			kfree(buff);
 			break;
 		}
-		ret = ath11k_dbring_bufs_replenish(ar, ring, buff);
+		ret = ath11k_dbring_bufs_replenish(ar, ring, buff, id);
 		if (ret) {
 			ath11k_warn(ar->ab, "failed to replenish db ring num_remain %d req_ent %d\n",
 				    num_remain, req_entries);
@@ -180,7 +183,7 @@ int ath11k_dbring_buf_setup(struct ath11k *ar,
 	ring->hp_addr = ath11k_hal_srng_get_hp_addr(ar->ab, srng);
 	ring->tp_addr = ath11k_hal_srng_get_tp_addr(ar->ab, srng);
 
-	ret = ath11k_dbring_fill_bufs(ar, ring);
+	ret = ath11k_dbring_fill_bufs(ar, ring, db_cap->id);
 
 	return ret;
 }
@@ -240,7 +243,7 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 	struct ath11k_buffer_addr desc;
 	u8 *vaddr_unalign;
 	u32 num_entry, num_buff_reaped;
-	u8 pdev_idx, rbm;
+	u8 pdev_idx, rbm, module_id;
 	u32 cookie;
 	int buf_id;
 	int size;
@@ -248,6 +251,7 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 	int ret = 0;
 
 	pdev_idx = ev->fixed.pdev_id;
+	module_id = ev->fixed.module_id;
 
 	if (pdev_idx >= ab->num_radios) {
 		ath11k_warn(ab, "Invalid pdev id %d\n", pdev_idx);
@@ -316,6 +320,9 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 		dma_unmap_single(ab->dev, buff->paddr, ring->buf_sz,
 				 DMA_FROM_DEVICE);
 
+		ath11k_dbring_add_debug_entry(ar, module_id,
+					      DBR_RING_DEBUG_EVENT_RX, srng);
+
 		if (ring->handler) {
 			vaddr_unalign = buff->payload;
 			handler_data.data = PTR_ALIGN(vaddr_unalign,
@@ -327,7 +334,7 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 
 		buff->paddr = 0;
 		memset(buff->payload, 0, size);
-		ath11k_dbring_bufs_replenish(ar, ring, buff);
+		ath11k_dbring_bufs_replenish(ar, ring, buff, module_id);
 	}
 
 	spin_unlock_bh(&srng->lock);
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index dba055d..76e4a20 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -50,6 +50,45 @@ static const char *htt_bp_lmac_ring[HTT_SW_LMAC_RING_IDX_MAX] = {
 	"MONITOR_DEST_RING",
 };
 
+void ath11k_dbring_add_debug_entry(struct ath11k *ar,
+				   enum wmi_direct_buffer_module id,
+				   enum ath11k_db_ring_dbg_event event,
+				   struct hal_srng *srng)
+{
+	struct ath11k_db_module_debug *db_module_debug;
+	struct ath11k_db_ring_debug *db_ring_debug;
+	struct ath11k_db_ring_debug_entry *entry;
+
+	if (id >= WMI_DIRECT_BUF_MAX || event >= DBR_RING_DEBUG_EVENT_MAX)
+		return;
+
+	db_module_debug = ar->debug.module_debug[id];
+	if (!db_module_debug)
+		return;
+
+	if (!db_module_debug->db_ring_debug_enabled)
+		return;
+
+	db_ring_debug = &db_module_debug->db_ring_debug;
+
+	spin_lock_bh(&db_ring_debug->lock);
+
+	if (db_ring_debug->entries) {
+		entry = &db_ring_debug->entries[db_ring_debug->db_ring_debug_idx];
+		entry->hp = srng->u.src_ring.hp;
+		entry->tp = *srng->u.src_ring.tp_addr;
+		entry->timestamp = jiffies;
+		entry->event = event;
+
+		db_ring_debug->db_ring_debug_idx++;
+		if (db_ring_debug->db_ring_debug_idx ==
+		    db_ring_debug->num_ring_debug_entries)
+			db_ring_debug->db_ring_debug_idx = 0;
+	}
+
+	spin_unlock_bh(&db_ring_debug->lock);
+}
+
 static void ath11k_fw_stats_pdevs_free(struct list_head *head)
 {
 	struct ath11k_fw_stats_pdev *i, *tmp;
@@ -1068,6 +1107,166 @@ static const struct file_operations fops_simulate_radar = {
 	.open = simple_open
 };
 
+static ssize_t ath11k_dbr_dump_debug_entries(struct file *file,
+					     char __user *user_buf,
+					     size_t count, loff_t *ppos)
+{
+	struct ath11k_db_ring_debug *db_ring_debug = file->private_data;
+	static const char * const event_id_to_string[] = {"empty", "Rx", "Replenish"};
+	int size = ATH11K_DBR_DEBUG_ENTRIES_MAX * 100;
+	char *buf;
+	int i, ret;
+	int len = 0;
+
+	buf = kzalloc(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	len += scnprintf(buf + len, size - len, "------------------------------------\n");
+	len += scnprintf(buf + len, size - len, "| idx | hp | tp | timestamp | event|\n");
+	len += scnprintf(buf + len, size - len, "------------------------------------\n");
+
+	spin_lock_bh(&db_ring_debug->lock);
+
+	for (i = 0; i < db_ring_debug->num_ring_debug_entries; i++) {
+		len += scnprintf(buf + len, size - len,
+				 "|%4u|%8u|%8u|%11llu|%8s|\n", i,
+				 db_ring_debug->entries[i].hp,
+				 db_ring_debug->entries[i].tp,
+				 db_ring_debug->entries[i].timestamp,
+				 event_id_to_string[db_ring_debug->entries[i].event]);
+	}
+
+	spin_unlock_bh(&db_ring_debug->lock);
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	kfree(buf);
+
+	return ret;
+}
+
+static const struct file_operations fops_dump_dbr_debug_entries = {
+	.read = ath11k_dbr_dump_debug_entries,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static void ath11k_db_module_debugfs_destroy(struct ath11k *ar, int module_id)
+{
+	struct ath11k_db_module_debug *module_debug;
+	struct ath11k_db_ring_debug *db_ring_debug;
+
+	if (!ar->debug.module_debug[module_id])
+		return;
+
+	module_debug = ar->debug.module_debug[module_id];
+	db_ring_debug = &module_debug->db_ring_debug;
+
+	debugfs_remove_recursive(module_debug->module_debugfs);
+	kfree(db_ring_debug->entries);
+	kfree(module_debug);
+	ar->debug.module_debug[module_id] = NULL;
+}
+
+static int ath11k_db_module_debugfs_init(struct ath11k *ar, int module_id)
+{
+	struct ath11k_db_module_debug *module_debug;
+	struct ath11k_db_ring_debug *db_ring_debug;
+	static const char * const module_id_to_str[] = {"spectral", "CFR"};
+
+	if (ar->debug.module_debug[module_id])
+		return 0;
+
+	ar->debug.module_debug[module_id] = kzalloc(sizeof(*module_debug),
+						    GFP_KERNEL);
+
+	if (!ar->debug.module_debug[module_id])
+		return -ENOMEM;
+
+	module_debug = ar->debug.module_debug[module_id];
+	db_ring_debug = &module_debug->db_ring_debug;
+
+	if (module_debug->module_debugfs)
+		return 0;
+
+	module_debug->module_debugfs = debugfs_create_dir(module_id_to_str[module_id],
+							  ar->debug.debugfs_pdev);
+	if (IS_ERR_OR_NULL(module_debug->module_debugfs)) {
+		if (IS_ERR(module_debug->module_debugfs))
+			return PTR_ERR(module_debug->module_debugfs);
+		return -ENOMEM;
+	}
+
+	module_debug->db_ring_debug_enabled = true;
+	db_ring_debug->num_ring_debug_entries = ATH11K_DBR_DEBUG_ENTRIES_MAX;
+	db_ring_debug->db_ring_debug_idx = 0;
+	db_ring_debug->entries = kcalloc(ATH11K_DBR_DEBUG_ENTRIES_MAX,
+					 sizeof(struct ath11k_db_ring_debug_entry),
+					 GFP_KERNEL);
+	if (!db_ring_debug->entries)
+		return -ENOMEM;
+
+	spin_lock_init(&db_ring_debug->lock);
+
+	debugfs_create_file("dump_db_ring_debug", 0444, module_debug->module_debugfs,
+			    db_ring_debug, &fops_dump_dbr_debug_entries);
+
+	return 0;
+}
+
+static ssize_t ath11k_write_enable_dbr_debug(struct file *file,
+					     const char __user *ubuf,
+					     size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	char buf[32] = {0};
+	u32 module_id, enable;
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state != ATH11K_STATE_ON) {
+		ret = -ENETDOWN;
+		goto out;
+	}
+
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
+	if (ret < 0)
+		goto out;
+
+	buf[ret] = '\0';
+	ret = sscanf(buf, "%u %u", &module_id, &enable);
+	if (ret != 2 || module_id > 1 || enable > 1) {
+		ret = -EINVAL;
+		ath11k_warn(ar->ab, "usage: echo <module_id> <val> module_id:0-Spectral 1-CFR val:0-disable 1-enable\n");
+		goto out;
+	}
+
+	if (enable) {
+		ret = ath11k_db_module_debugfs_init(ar, module_id);
+		if (ret) {
+			ath11k_warn(ar->ab, "db ring module debugfs init failed: %d\n",
+				    ret);
+			goto out;
+		}
+	} else {
+		ath11k_db_module_debugfs_destroy(ar, module_id);
+	}
+
+	ret = count;
+out:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+static const struct file_operations fops_dbr_debug = {
+	.write = ath11k_write_enable_dbr_debug,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
 int ath11k_debugfs_register(struct ath11k *ar)
 {
 	struct ath11k_base *ab = ar->ab;
@@ -1107,9 +1306,27 @@ int ath11k_debugfs_register(struct ath11k *ar)
 				    &ar->dfs_block_radar_events);
 	}
 
+	debugfs_create_file("enable_dbr_debug", 0200, ar->debug.debugfs_pdev,
+			    ar, &fops_dbr_debug);
+
 	return 0;
 }
 
 void ath11k_debugfs_unregister(struct ath11k *ar)
 {
+	struct ath11k_db_module_debug *module_debug;
+	struct ath11k_db_ring_debug *db_ring_debug;
+	int i;
+
+	for (i = 0; i < WMI_DIRECT_BUF_MAX; i++) {
+		module_debug = ar->debug.module_debug[i];
+		if (!module_debug)
+			continue;
+
+		db_ring_debug = &module_debug->db_ring_debug;
+		kfree(db_ring_debug->entries);
+		debugfs_remove_recursive(module_debug->module_debugfs);
+		kfree(module_debug);
+		ar->debug.module_debug[i] = NULL;
+	}
 }
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
index ec743a0..7739915 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -47,6 +47,36 @@ enum ath11k_dbg_htt_ext_stats_type {
 	ATH11K_DBG_HTT_NUM_EXT_STATS,
 };
 
+#define ATH11K_DBR_DEBUG_ENTRIES_MAX 512
+
+enum ath11k_db_ring_dbg_event {
+	DBR_RING_DEBUG_EVENT_INVALID,
+	DBR_RING_DEBUG_EVENT_RX,
+	DBR_RING_DEBUG_EVENT_REPLENISH,
+	DBR_RING_DEBUG_EVENT_MAX,
+};
+
+struct ath11k_db_ring_debug_entry {
+	u32 hp;
+	u32 tp;
+	u64 timestamp;
+	enum ath11k_db_ring_dbg_event event;
+};
+
+struct ath11k_db_ring_debug {
+	/* protects ath11k_db_ring_debug data */
+	spinlock_t lock;
+	struct ath11k_db_ring_debug_entry *entries;
+	u32 db_ring_debug_idx;
+	u32 num_ring_debug_entries;
+};
+
+struct ath11k_db_module_debug {
+	struct ath11k_db_ring_debug db_ring_debug;
+	struct dentry *module_debugfs;
+	bool db_ring_debug_enabled;
+};
+
 struct debug_htt_stats_req {
 	bool done;
 	u8 pdev_id;
@@ -149,6 +179,10 @@ static inline int ath11k_debugfs_rx_filter(struct ath11k *ar)
 	return ar->debug.rx_filter;
 }
 
+void ath11k_dbring_add_debug_entry(struct ath11k *ar,
+				   enum wmi_direct_buffer_module id,
+				   enum ath11k_db_ring_dbg_event event,
+				   struct hal_srng *srng);
 #else
 static inline int ath11k_debugfs_soc_create(struct ath11k_base *ab)
 {
@@ -216,6 +250,13 @@ static inline int ath11k_debugfs_rx_filter(struct ath11k *ar)
 	return 0;
 }
 
+static inline void
+ath11k_dbring_add_debug_entry(struct ath11k *ar,
+			      enum wmi_direct_buffer_module id,
+			      enum ath11k_db_ring_dbg_event event,
+			      struct hal_srng *srng)
+{
+}
 #endif /* CONFIG_MAC80211_DEBUGFS*/
 
 #endif /* _ATH11K_DEBUGFS_H_ */
-- 
2.7.4


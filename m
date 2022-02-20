Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D984BCEEC
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Feb 2022 15:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbiBTOJG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Feb 2022 09:09:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiBTOJF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Feb 2022 09:09:05 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39F24B40F
        for <linux-wireless@vger.kernel.org>; Sun, 20 Feb 2022 06:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645366124; x=1676902124;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=cQOFiPMiy4OQerlBTtiWTW67eOvCNkUDI4AWfZhWKdA=;
  b=toWZRSchJx/GN8t9WdmybkIYBGKXrTOry6U7RlcrYckCcjoK5mjoPnhb
   hTNmP3s4ochVz/OpHdOQKUMWVc+rxhXbOo1GFT707y5OTfrSIue4JqNGv
   zZ72olPlJNJPZDN3qHy3CWRIoUJsL6wslD41bU2V2EY4+/+jpZc2OqObQ
   o=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 20 Feb 2022 06:08:43 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 06:08:13 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 20 Feb 2022 06:07:52 -0800
Received: from vnaralas-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 20 Feb 2022 06:07:50 -0800
From:   Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Subject: [PATCHv3] ath11k: add dbring debug support
Date:   Sun, 20 Feb 2022 19:37:39 +0530
Message-ID: <1645366059-11798-1-git-send-email-quic_vnaralas@quicinc.com>
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

Target copies spectral report and CFR report through dbring to
host for further processing. This mechanism involves ring and
buffer management in the Host, FW, and uCode, where improper
tail pointer update issues are seen.

This dbring debug support help to debug such issues by tracking
head and tail pointer movement along with the timestamp at which
each buffer is received and replenished.

Provide a debugfs interface to enalbe/disable dbring debug
support and dump the dbring debug entries.

Also introduced a new hardware param to add dbring debugfs support
for few hardwares which are using dbings.

Usage:

echo <dbr_id> <val> > /sys/kernel/debug/ath11k/ipq8074_2/
mac0/enable_dbr_debug

dbr_id: 0 for spectral and 1 for CFR
val: 0 - disable, 1 - enable.

Tested-on: IPQ8074 WLAN.HK.2.4.0.1-01467-QCAHKSWPL_SILICONZ-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
---
v3:
 * Changed API and structure names.
 * Updated commit log.

v2:
 * Rebased on TOT

 drivers/net/wireless/ath/ath11k/core.c    |   6 +
 drivers/net/wireless/ath/ath11k/core.h    |   1 +
 drivers/net/wireless/ath/ath11k/dbring.c  |  19 ++-
 drivers/net/wireless/ath/ath11k/debugfs.c | 221 ++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/debugfs.h |  41 ++++++
 drivers/net/wireless/ath/ath11k/hw.h      |   1 +
 6 files changed, 283 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 7c508e9..5d570a2 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -99,6 +99,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_rssi_stats = false,
 		.fw_wmi_diag_event = false,
 		.current_cc_support = false,
+		.dbr_debug_support = true,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -164,6 +165,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_rssi_stats = false,
 		.fw_wmi_diag_event = false,
 		.current_cc_support = false,
+		.dbr_debug_support = true,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -228,6 +230,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_rssi_stats = true,
 		.fw_wmi_diag_event = true,
 		.current_cc_support = true,
+		.dbr_debug_support = false,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -292,6 +295,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_rssi_stats = false,
 		.fw_wmi_diag_event = false,
 		.current_cc_support = false,
+		.dbr_debug_support = true,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -356,6 +360,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_rssi_stats = true,
 		.fw_wmi_diag_event = true,
 		.current_cc_support = true,
+		.dbr_debug_support = false,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -419,6 +424,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_rssi_stats = true,
 		.fw_wmi_diag_event = true,
 		.current_cc_support = true,
+		.dbr_debug_support = false,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 10846e9..e453475 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -461,6 +461,7 @@ struct ath11k_debug {
 	u32 rx_filter;
 	u32 mem_offset;
 	u32 module_id_bitmap[MAX_MODULE_ID_BITMAP_WORDS];
+	struct ath11k_debug_dbr *dbr_debug[WMI_DIRECT_BUF_MAX];
 };
 
 struct ath11k_per_peer_tx_stats {
diff --git a/drivers/net/wireless/ath/ath11k/dbring.c b/drivers/net/wireless/ath/ath11k/dbring.c
index eda67eb..2107ec0 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.c
+++ b/drivers/net/wireless/ath/ath11k/dbring.c
@@ -37,7 +37,8 @@ static void ath11k_dbring_fill_magic_value(struct ath11k *ar,
 
 static int ath11k_dbring_bufs_replenish(struct ath11k *ar,
 					struct ath11k_dbring *ring,
-					struct ath11k_dbring_element *buff)
+					struct ath11k_dbring_element *buff,
+					enum wmi_direct_buffer_module id)
 {
 	struct ath11k_base *ab = ar->ab;
 	struct hal_srng *srng;
@@ -84,6 +85,7 @@ static int ath11k_dbring_bufs_replenish(struct ath11k *ar,
 
 	ath11k_hal_rx_buf_addr_info_set(desc, paddr, cookie, 0);
 
+	ath11k_debugfs_add_dbring_entry(ar, id, ATH11K_DBG_DBR_EVENT_REPLENISH, srng);
 	ath11k_hal_srng_access_end(ab, srng);
 
 	return 0;
@@ -101,7 +103,8 @@ static int ath11k_dbring_bufs_replenish(struct ath11k *ar,
 }
 
 static int ath11k_dbring_fill_bufs(struct ath11k *ar,
-				   struct ath11k_dbring *ring)
+				   struct ath11k_dbring *ring,
+				   enum wmi_direct_buffer_module id)
 {
 	struct ath11k_dbring_element *buff;
 	struct hal_srng *srng;
@@ -129,7 +132,7 @@ static int ath11k_dbring_fill_bufs(struct ath11k *ar,
 			kfree(buff);
 			break;
 		}
-		ret = ath11k_dbring_bufs_replenish(ar, ring, buff);
+		ret = ath11k_dbring_bufs_replenish(ar, ring, buff, id);
 		if (ret) {
 			ath11k_warn(ar->ab, "failed to replenish db ring num_remain %d req_ent %d\n",
 				    num_remain, req_entries);
@@ -210,7 +213,7 @@ int ath11k_dbring_buf_setup(struct ath11k *ar,
 	ring->hp_addr = ath11k_hal_srng_get_hp_addr(ar->ab, srng);
 	ring->tp_addr = ath11k_hal_srng_get_tp_addr(ar->ab, srng);
 
-	ret = ath11k_dbring_fill_bufs(ar, ring);
+	ret = ath11k_dbring_fill_bufs(ar, ring, db_cap->id);
 
 	return ret;
 }
@@ -270,7 +273,7 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 	struct ath11k_buffer_addr desc;
 	u8 *vaddr_unalign;
 	u32 num_entry, num_buff_reaped;
-	u8 pdev_idx, rbm;
+	u8 pdev_idx, rbm, module_id;
 	u32 cookie;
 	int buf_id;
 	int size;
@@ -278,6 +281,7 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 	int ret = 0;
 
 	pdev_idx = ev->fixed.pdev_id;
+	module_id = ev->fixed.module_id;
 
 	if (pdev_idx >= ab->num_radios) {
 		ath11k_warn(ab, "Invalid pdev id %d\n", pdev_idx);
@@ -346,6 +350,9 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 		dma_unmap_single(ab->dev, buff->paddr, ring->buf_sz,
 				 DMA_FROM_DEVICE);
 
+		ath11k_debugfs_add_dbring_entry(ar, module_id,
+						ATH11K_DBG_DBR_EVENT_RX, srng);
+
 		if (ring->handler) {
 			vaddr_unalign = buff->payload;
 			handler_data.data = PTR_ALIGN(vaddr_unalign,
@@ -357,7 +364,7 @@ int ath11k_dbring_buffer_release_event(struct ath11k_base *ab,
 
 		buff->paddr = 0;
 		memset(buff->payload, 0, size);
-		ath11k_dbring_bufs_replenish(ar, ring, buff);
+		ath11k_dbring_bufs_replenish(ar, ring, buff, module_id);
 	}
 
 	spin_unlock_bh(&srng->lock);
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index c0ebdb1..a82266c 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -52,6 +52,45 @@ static const char *htt_bp_lmac_ring[HTT_SW_LMAC_RING_IDX_MAX] = {
 	"MONITOR_DEST_RING",
 };
 
+void ath11k_debugfs_add_dbring_entry(struct ath11k *ar,
+				     enum wmi_direct_buffer_module id,
+				     enum ath11k_dbg_dbr_event event,
+				     struct hal_srng *srng)
+{
+	struct ath11k_debug_dbr *dbr_debug;
+	struct ath11k_dbg_dbr_data *dbr_data;
+	struct ath11k_dbg_dbr_entry *entry;
+
+	if (id >= WMI_DIRECT_BUF_MAX || event >= ATH11K_DBG_DBR_EVENT_MAX)
+		return;
+
+	dbr_debug = ar->debug.dbr_debug[id];
+	if (!dbr_debug)
+		return;
+
+	if (!dbr_debug->dbr_debug_enabled)
+		return;
+
+	dbr_data = &dbr_debug->dbr_dbg_data;
+
+	spin_lock_bh(&dbr_data->lock);
+
+	if (dbr_data->entries) {
+		entry = &dbr_data->entries[dbr_data->dbr_debug_idx];
+		entry->hp = srng->u.src_ring.hp;
+		entry->tp = *srng->u.src_ring.tp_addr;
+		entry->timestamp = jiffies;
+		entry->event = event;
+
+		dbr_data->dbr_debug_idx++;
+		if (dbr_data->dbr_debug_idx ==
+		    dbr_data->num_ring_debug_entries)
+			dbr_data->dbr_debug_idx = 0;
+	}
+
+	spin_unlock_bh(&dbr_data->lock);
+}
+
 static void ath11k_fw_stats_pdevs_free(struct list_head *head)
 {
 	struct ath11k_fw_stats_pdev *i, *tmp;
@@ -1176,6 +1215,169 @@ static const struct file_operations fops_simulate_radar = {
 	.open = simple_open
 };
 
+static ssize_t ath11k_debug_dump_dbr_entries(struct file *file,
+					     char __user *user_buf,
+					     size_t count, loff_t *ppos)
+{
+	struct ath11k_dbg_dbr_data *dbr_dbg_data = file->private_data;
+	static const char * const event_id_to_string[] = {"empty", "Rx", "Replenish"};
+	int size = ATH11K_DEBUG_DBR_ENTRIES_MAX * 100;
+	char *buf;
+	int i, ret;
+	int len = 0;
+
+	buf = kzalloc(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	len += scnprintf(buf + len, size - len,
+			 "-----------------------------------------\n");
+	len += scnprintf(buf + len, size - len,
+			 "| idx |  hp  |  tp  | timestamp |  event |\n");
+	len += scnprintf(buf + len, size - len,
+			 "-----------------------------------------\n");
+
+	spin_lock_bh(&dbr_dbg_data->lock);
+
+	for (i = 0; i < dbr_dbg_data->num_ring_debug_entries; i++) {
+		len += scnprintf(buf + len, size - len,
+				 "|%4u|%8u|%8u|%11llu|%8s|\n", i,
+				 dbr_dbg_data->entries[i].hp,
+				 dbr_dbg_data->entries[i].tp,
+				 dbr_dbg_data->entries[i].timestamp,
+				 event_id_to_string[dbr_dbg_data->entries[i].event]);
+	}
+
+	spin_unlock_bh(&dbr_dbg_data->lock);
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	kfree(buf);
+
+	return ret;
+}
+
+static const struct file_operations fops_debug_dump_dbr_entries = {
+	.read = ath11k_debug_dump_dbr_entries,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static void ath11k_debugfs_dbr_dbg_destroy(struct ath11k *ar, int dbr_id)
+{
+	struct ath11k_debug_dbr *dbr_debug;
+	struct ath11k_dbg_dbr_data *dbr_dbg_data;
+
+	if (!ar->debug.dbr_debug[dbr_id])
+		return;
+
+	dbr_debug = ar->debug.dbr_debug[dbr_id];
+	dbr_dbg_data = &dbr_debug->dbr_dbg_data;
+
+	debugfs_remove_recursive(dbr_debug->dbr_debugfs);
+	kfree(dbr_dbg_data->entries);
+	kfree(dbr_debug);
+	ar->debug.dbr_debug[dbr_id] = NULL;
+}
+
+static int ath11k_debugfs_dbr_dbg_init(struct ath11k *ar, int dbr_id)
+{
+	struct ath11k_debug_dbr *dbr_debug;
+	struct ath11k_dbg_dbr_data *dbr_dbg_data;
+	static const char * const dbr_id_to_str[] = {"spectral", "CFR"};
+
+	if (ar->debug.dbr_debug[dbr_id])
+		return 0;
+
+	ar->debug.dbr_debug[dbr_id] = kzalloc(sizeof(*dbr_debug),
+					      GFP_KERNEL);
+
+	if (!ar->debug.dbr_debug[dbr_id])
+		return -ENOMEM;
+
+	dbr_debug = ar->debug.dbr_debug[dbr_id];
+	dbr_dbg_data = &dbr_debug->dbr_dbg_data;
+
+	if (dbr_debug->dbr_debugfs)
+		return 0;
+
+	dbr_debug->dbr_debugfs = debugfs_create_dir(dbr_id_to_str[dbr_id],
+						    ar->debug.debugfs_pdev);
+	if (IS_ERR_OR_NULL(dbr_debug->dbr_debugfs)) {
+		if (IS_ERR(dbr_debug->dbr_debugfs))
+			return PTR_ERR(dbr_debug->dbr_debugfs);
+		return -ENOMEM;
+	}
+
+	dbr_debug->dbr_debug_enabled = true;
+	dbr_dbg_data->num_ring_debug_entries = ATH11K_DEBUG_DBR_ENTRIES_MAX;
+	dbr_dbg_data->dbr_debug_idx = 0;
+	dbr_dbg_data->entries = kcalloc(ATH11K_DEBUG_DBR_ENTRIES_MAX,
+					sizeof(struct ath11k_dbg_dbr_entry),
+					GFP_KERNEL);
+	if (!dbr_dbg_data->entries)
+		return -ENOMEM;
+
+	spin_lock_init(&dbr_dbg_data->lock);
+
+	debugfs_create_file("dump_dbr_debug", 0444, dbr_debug->dbr_debugfs,
+			    dbr_dbg_data, &fops_debug_dump_dbr_entries);
+
+	return 0;
+}
+
+static ssize_t ath11k_debugfs_write_enable_dbr_dbg(struct file *file,
+						   const char __user *ubuf,
+						   size_t count, loff_t *ppos)
+{
+	struct ath11k *ar = file->private_data;
+	char buf[32] = {0};
+	u32 dbr_id, enable;
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
+	ret = sscanf(buf, "%u %u", &dbr_id, &enable);
+	if (ret != 2 || dbr_id > 1 || enable > 1) {
+		ret = -EINVAL;
+		ath11k_warn(ar->ab, "usage: echo <dbr_id> <val> dbr_id:0-Spectral 1-CFR val:0-disable 1-enable\n");
+		goto out;
+	}
+
+	if (enable) {
+		ret = ath11k_debugfs_dbr_dbg_init(ar, dbr_id);
+		if (ret) {
+			ath11k_warn(ar->ab, "db ring module debugfs init failed: %d\n",
+				    ret);
+			goto out;
+		}
+	} else {
+		ath11k_debugfs_dbr_dbg_destroy(ar, dbr_id);
+	}
+
+	ret = count;
+out:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+static const struct file_operations fops_dbr_debug = {
+	.write = ath11k_debugfs_write_enable_dbr_dbg,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
 int ath11k_debugfs_register(struct ath11k *ar)
 {
 	struct ath11k_base *ab = ar->ab;
@@ -1218,11 +1420,30 @@ int ath11k_debugfs_register(struct ath11k *ar)
 				    &ar->dfs_block_radar_events);
 	}
 
+	if (ab->hw_params.dbr_debug_support)
+		debugfs_create_file("enable_dbr_debug", 0200, ar->debug.debugfs_pdev,
+				    ar, &fops_dbr_debug);
+
 	return 0;
 }
 
 void ath11k_debugfs_unregister(struct ath11k *ar)
 {
+	struct ath11k_debug_dbr *dbr_debug;
+	struct ath11k_dbg_dbr_data *dbr_dbg_data;
+	int i;
+
+	for (i = 0; i < WMI_DIRECT_BUF_MAX; i++) {
+		dbr_debug = ar->debug.dbr_debug[i];
+		if (!dbr_debug)
+			continue;
+
+		dbr_dbg_data = &dbr_debug->dbr_dbg_data;
+		kfree(dbr_dbg_data->entries);
+		debugfs_remove_recursive(dbr_debug->dbr_debugfs);
+		kfree(dbr_debug);
+		ar->debug.dbr_debug[i] = NULL;
+	}
 }
 
 static ssize_t ath11k_write_twt_add_dialog(struct file *file,
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
index ef8ed57b..30c00cb 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -47,6 +47,36 @@ enum ath11k_dbg_htt_ext_stats_type {
 	ATH11K_DBG_HTT_NUM_EXT_STATS,
 };
 
+#define ATH11K_DEBUG_DBR_ENTRIES_MAX 512
+
+enum ath11k_dbg_dbr_event {
+	ATH11K_DBG_DBR_EVENT_INVALID,
+	ATH11K_DBG_DBR_EVENT_RX,
+	ATH11K_DBG_DBR_EVENT_REPLENISH,
+	ATH11K_DBG_DBR_EVENT_MAX,
+};
+
+struct ath11k_dbg_dbr_entry {
+	u32 hp;
+	u32 tp;
+	u64 timestamp;
+	enum ath11k_dbg_dbr_event event;
+};
+
+struct ath11k_dbg_dbr_data {
+	/* protects ath11k_db_ring_debug data */
+	spinlock_t lock;
+	struct ath11k_dbg_dbr_entry *entries;
+	u32 dbr_debug_idx;
+	u32 num_ring_debug_entries;
+};
+
+struct ath11k_debug_dbr {
+	struct ath11k_dbg_dbr_data dbr_dbg_data;
+	struct dentry *dbr_debugfs;
+	bool dbr_debug_enabled;
+};
+
 struct debug_htt_stats_req {
 	bool done;
 	u8 pdev_id;
@@ -278,6 +308,10 @@ static inline int ath11k_debugfs_rx_filter(struct ath11k *ar)
 
 int ath11k_debugfs_add_interface(struct ath11k_vif *arvif);
 void ath11k_debugfs_remove_interface(struct ath11k_vif *arvif);
+void ath11k_debugfs_add_dbring_entry(struct ath11k *ar,
+				     enum wmi_direct_buffer_module id,
+				     enum ath11k_dbg_dbr_event event,
+				     struct hal_srng *srng);
 
 #else
 static inline int ath11k_debugfs_soc_create(struct ath11k_base *ab)
@@ -361,6 +395,13 @@ static inline void ath11k_debugfs_remove_interface(struct ath11k_vif *arvif)
 {
 }
 
+static inline void
+ath11k_debugfs_add_dbring_entry(struct ath11k *ar,
+				enum wmi_direct_buffer_module id,
+				enum ath11k_dbg_dbr_event event,
+				struct hal_srng *srng)
+{
+}
 #endif /* CONFIG_ATH11K_DEBUGFS*/
 
 #endif /* _ATH11K_DEBUGFS_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index c10e1a0..27ca4a9 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -193,6 +193,7 @@ struct ath11k_hw_params {
 	bool supports_rssi_stats;
 	bool fw_wmi_diag_event;
 	bool current_cc_support;
+	bool dbr_debug_support;
 };
 
 struct ath11k_hw_ops {
-- 
2.7.4


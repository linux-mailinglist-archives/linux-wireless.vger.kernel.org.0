Return-Path: <linux-wireless+bounces-17917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39397A1BC7E
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 19:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49D73ACB9C
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 18:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E201D54D8;
	Fri, 24 Jan 2025 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xlvene2o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6CA2248AE
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737744826; cv=none; b=dp7hnaCuy8yJdFCgQBW1Ill4V797EyvowygM/esp9CSiXmRzLOMnkPfuLzky0hc1D15Wckf5IC+9zEnK1uYGwYoPebkK5kDGc2i+cvIfcq6tQn9GY9MVKpPgp0RmtI8cL5H2rhPviJhbfG5/56N3Q3dEVGvUjaNpoR13GKrdSCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737744826; c=relaxed/simple;
	bh=tCteBnn5d9j974unBYbudW+fKeM3KqXy6/h44zACM20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t4CsBxctXhO9SXf6U4eVdCZ6YWUStZ95Uf2SjknpUODAVMrj2XhgD4SpqbMagfbEfm3tboaSSma0XoCIjLdSLHoMulMOtuAHzhCX7xLdV3xqcGacY91/YKp+Xy2Npzu81GcOxTjp0zTREFKIPduhLwuJDsmf8uoMAQA09wX+ARI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xlvene2o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OFsaVt022500;
	Fri, 24 Jan 2025 18:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VW+sMQ/lq4P
	6LuNZE7/yYWWQ+cTuxOP6W7FB54purAY=; b=Xlvene2oVILW50zaiglbC0jMq1K
	5qSFHhemQXxceGXTrDuwOcGBZVNdqu/7YFSydLZf3SU2oNcgSL1oX6SRS6DH8zVh
	+dmwQTyepxWS+Ulsgfh4n0vgB08NoQ9zfQhQkdoTbykF4Vn4enkmuReCM6afPeln
	4UMtUmuIrBrXRhsreAaQrt98LAr1fVmWsbt8DgJyajDY4VNPYGXu43wU5HZ5Ou9b
	mcvlvxymn5bRXqJvBaM7qh2rH7hj15sPkNF3Itk75baoPfkVyNmAoXSVLaRnejty
	/zZUoW4YyTY4iZEm3dXjZAHohAoCwBovsD8mvNCw8gDSVKYthyjwPeh9wkQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cdwvgbsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 18:53:37 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIrYm3013039;
	Fri, 24 Jan 2025 18:53:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4485cmbfnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 18:53:34 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50OIrYlO013029;
	Fri, 24 Jan 2025 18:53:34 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 50OIrYKQ013027
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 18:53:34 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id 9278B41188; Sat, 25 Jan 2025 00:23:33 +0530 (+0530)
From: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
Subject: [PATCH 1/3] wifi: ath12k: Request vdev stats from firmware
Date: Sat, 25 Jan 2025 00:23:28 +0530
Message-Id: <20250124185330.1244585-2-ramya.gnanasekar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124185330.1244585-1-ramya.gnanasekar@oss.qualcomm.com>
References: <20250124185330.1244585-1-ramya.gnanasekar@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ykIop3YhjZoCM627JDX2tUzVNifZ7BLI
X-Proofpoint-ORIG-GUID: ykIop3YhjZoCM627JDX2tUzVNifZ7BLI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501240130

Add support to request and print vdev stats from firmware through WMI.

Sample output:
-------------
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/fw_stats/vdev_stats

             ath12k VDEV stats
             =================

                       VDEV ID 0
              VDEV MAC address 00:03:7f:6c:9c:1a
                    beacon snr 96
                      data snr 255
                 num rx frames 0
                  num rts fail 0
               num rts success 0
                    num rx err 0
                num rx discard 0
              num tx not acked 0
            num tx frames [00] 0
            num tx frames [01] 0
            num tx frames [02] 0
            num tx frames [03] 2
    num tx frames retries [00] 0
    num tx frames retries [01] 0
    num tx frames retries [02] 0
    num tx frames retries [03] 0
   num tx frames failures [00] 0
   num tx frames failures [01] 0
   num tx frames failures [02] 0
   num tx frames failures [03] 0
          tx rate history [00] 0x00000000
          tx rate history [01] 0x00000000
          tx rate history [02] 0x00000000
          tx rate history [03] 0x00000000
          tx rate history [04] 0x00000000
          tx rate history [05] 0x00000000
          tx rate history [06] 0x00000000
          tx rate history [07] 0x00000000
          tx rate history [08] 0x00000000
          tx rate history [09] 0x00000000
      beacon rssi history [00] 0
      beacon rssi history [01] 0
      beacon rssi history [02] 0
      beacon rssi history [03] 0
      beacon rssi history [04] 0
      beacon rssi history [05] 0
      beacon rssi history [06] 0
      beacon rssi history [07] 0
      beacon rssi history [08] 0
      beacon rssi history [09] 0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h    |  21 +++
 drivers/net/wireless/ath/ath12k/debugfs.c | 197 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/debugfs.h |  13 +-
 drivers/net/wireless/ath/ath12k/wmi.c     | 155 +++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h     |  10 ++
 5 files changed, 394 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 81fd87def2da..fffdf17fcb1c 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -558,6 +558,7 @@ struct ath12k_fw_stats {
 	struct list_head pdevs;
 	struct list_head vdevs;
 	struct list_head bcn;
+	bool fw_stats_done;
 };
 
 struct ath12k_dbg_htt_stats {
@@ -729,6 +730,7 @@ struct ath12k {
 	struct completion mlo_setup_done;
 	u32 mlo_setup_status;
 	u8 ftm_msgref;
+	struct ath12k_fw_stats fw_stats;
 };
 
 struct ath12k_hw {
@@ -1079,6 +1081,25 @@ struct ath12k_pdev_map {
 	u8 pdev_idx;
 };
 
+struct ath12k_fw_stats_vdev {
+	struct list_head list;
+
+	u32 vdev_id;
+	u32 beacon_snr;
+	u32 data_snr;
+	u32 num_tx_frames[WLAN_MAX_AC];
+	u32 num_rx_frames;
+	u32 num_tx_frames_retries[WLAN_MAX_AC];
+	u32 num_tx_frames_failures[WLAN_MAX_AC];
+	u32 num_rts_fail;
+	u32 num_rts_success;
+	u32 num_rx_err;
+	u32 num_rx_discard;
+	u32 num_tx_not_acked;
+	u32 tx_rate_history[MAX_TX_RATE_VALUES];
+	u32 beacon_rssi_history[MAX_TX_RATE_VALUES];
+};
+
 int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab);
 int ath12k_core_pre_init(struct ath12k_base *ab);
 int ath12k_core_init(struct ath12k_base *ath12k);
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index d4b32d1a431c..1ee9a3e00514 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "core.h"
+#include "debug.h"
 #include "debugfs.h"
 #include "debugfs_htt_stats.h"
 
@@ -68,6 +69,199 @@ void ath12k_debugfs_soc_destroy(struct ath12k_base *ab)
 	 */
 }
 
+static void ath12k_fw_stats_vdevs_free(struct list_head *head)
+{
+	struct ath12k_fw_stats_vdev *i, *tmp;
+
+	list_for_each_entry_safe(i, tmp, head, list) {
+		list_del(&i->list);
+		kfree(i);
+	}
+}
+
+void ath12k_debugfs_fw_stats_reset(struct ath12k *ar)
+{
+	spin_lock_bh(&ar->data_lock);
+	ar->fw_stats.fw_stats_done = false;
+	ath12k_fw_stats_vdevs_free(&ar->fw_stats.vdevs);
+	spin_unlock_bh(&ar->data_lock);
+}
+
+static int ath12k_debugfs_fw_stats_request(struct ath12k *ar,
+					   struct ath12k_fw_stats_req_params *param)
+{
+	struct ath12k_base *ab = ar->ab;
+	unsigned long timeout, time_left;
+	int ret;
+
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	/* FW stats can get split when exceeding the stats data buffer limit.
+	 * In that case, since there is no end marking for the back-to-back
+	 * received 'update stats' event, we keep a 3 seconds timeout in case,
+	 * fw_stats_done is not marked yet
+	 */
+	timeout = jiffies + msecs_to_jiffies(3 * 1000);
+
+	ath12k_debugfs_fw_stats_reset(ar);
+
+	reinit_completion(&ar->fw_stats_complete);
+
+	ret = ath12k_wmi_send_stats_request_cmd(ar, param->stats_id,
+						param->vdev_id, param->pdev_id);
+
+	if (ret) {
+		ath12k_warn(ab, "could not request fw stats (%d)\n",
+			    ret);
+		return ret;
+	}
+
+	time_left = wait_for_completion_timeout(&ar->fw_stats_complete,
+						1 * HZ);
+	/* If the wait timed out, return -ETIMEDOUT */
+	if (!time_left)
+		return -ETIMEDOUT;
+
+	/* Firmware sends WMI_UPDATE_STATS_EVENTID back-to-back
+	 * when stats data buffer limit is reached. fw_stats_complete
+	 * is completed once host receives first event from firmware, but
+	 * still end might not be marked in the TLV.
+	 * Below loop is to confirm that firmware completed sending all the event
+	 * and fw_stats_done is marked true when end is marked in the TLV
+	 */
+	for (;;) {
+		if (time_after(jiffies, timeout))
+			break;
+
+		spin_lock_bh(&ar->data_lock);
+		if (ar->fw_stats.fw_stats_done) {
+			spin_unlock_bh(&ar->data_lock);
+			break;
+		}
+		spin_unlock_bh(&ar->data_lock);
+	}
+	return 0;
+}
+
+void
+ath12k_debugfs_fw_stats_process(struct ath12k *ar,
+				struct ath12k_fw_stats *stats)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_pdev *pdev;
+	bool is_end;
+	static unsigned int num_vdev;
+	size_t total_vdevs_started = 0;
+	int i;
+
+	if (stats->stats_id == WMI_REQUEST_VDEV_STAT) {
+		if (list_empty(&stats->vdevs)) {
+			ath12k_warn(ab, "empty vdev stats");
+			return;
+		}
+		/* FW sends all the active VDEV stats irrespective of PDEV,
+		 * hence limit until the count of all VDEVs started
+		 */
+		rcu_read_lock();
+		for (i = 0; i < ab->num_radios; i++) {
+			pdev = rcu_dereference(ab->pdevs_active[i]);
+			if (pdev && pdev->ar)
+				total_vdevs_started += pdev->ar->num_started_vdevs;
+		}
+		rcu_read_unlock();
+
+		is_end = ((++num_vdev) == total_vdevs_started);
+
+		list_splice_tail_init(&stats->vdevs,
+				      &ar->fw_stats.vdevs);
+
+		if (is_end) {
+			ar->fw_stats.fw_stats_done = true;
+			num_vdev = 0;
+		}
+		return;
+	}
+}
+
+static int ath12k_open_vdev_stats(struct inode *inode, struct file *file)
+{
+	struct ath12k *ar = inode->i_private;
+	struct ath12k_fw_stats_req_params param;
+	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
+	int ret;
+
+	guard(wiphy)(ath12k_ar_to_hw(ar)->wiphy);
+
+	if (!ah)
+		return -ENETDOWN;
+
+	if (ah->state != ATH12K_HW_STATE_ON)
+		return -ENETDOWN;
+
+	void *buf __free(kfree) = kzalloc(ATH12K_FW_STATS_BUF_SIZE, GFP_ATOMIC);
+	if (!buf)
+		return -ENOMEM;
+
+	param.pdev_id = ath12k_mac_get_target_pdev_id(ar);
+	/* VDEV stats is always sent for all active VDEVs from FW */
+	param.vdev_id = 0;
+	param.stats_id = WMI_REQUEST_VDEV_STAT;
+
+	ret = ath12k_debugfs_fw_stats_request(ar, &param);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to request fw vdev stats: %d\n", ret);
+		return ret;
+	}
+
+	ath12k_wmi_fw_stats_dump(ar, &ar->fw_stats, param.stats_id,
+				 buf);
+
+	file->private_data = no_free_ptr(buf);
+
+	return 0;
+}
+
+static int ath12k_release_vdev_stats(struct inode *inode, struct file *file)
+{
+	kfree(file->private_data);
+
+	return 0;
+}
+
+static ssize_t ath12k_read_vdev_stats(struct file *file,
+				      char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	const char *buf = file->private_data;
+	size_t len = strlen(buf);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static const struct file_operations fops_vdev_stats = {
+	.open = ath12k_open_vdev_stats,
+	.release = ath12k_release_vdev_stats,
+	.read = ath12k_read_vdev_stats,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static
+void ath12k_debugfs_fw_stats_register(struct ath12k *ar)
+{
+	struct dentry *fwstats_dir = debugfs_create_dir("fw_stats",
+							ar->debug.debugfs_pdev);
+
+	/* all stats debugfs files created are under "fw_stats" directory
+	 * created per PDEV
+	 */
+	debugfs_create_file("vdev_stats", 0600, fwstats_dir, ar,
+			    &fops_vdev_stats);
+
+	INIT_LIST_HEAD(&ar->fw_stats.vdevs);
+	init_completion(&ar->fw_stats_complete);
+}
+
 void ath12k_debugfs_register(struct ath12k *ar)
 {
 	struct ath12k_base *ab = ar->ab;
@@ -92,6 +286,7 @@ void ath12k_debugfs_register(struct ath12k *ar)
 	}
 
 	ath12k_debugfs_htt_stats_register(ar);
+	ath12k_debugfs_fw_stats_register(ar);
 }
 
 void ath12k_debugfs_unregister(struct ath12k *ar)
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.h b/drivers/net/wireless/ath/ath12k/debugfs.h
index 8d64ba03aa9a..1c30745ee415 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _ATH12K_DEBUGFS_H_
@@ -12,6 +12,9 @@ void ath12k_debugfs_soc_create(struct ath12k_base *ab);
 void ath12k_debugfs_soc_destroy(struct ath12k_base *ab);
 void ath12k_debugfs_register(struct ath12k *ar);
 void ath12k_debugfs_unregister(struct ath12k *ar);
+void ath12k_debugfs_fw_stats_process(struct ath12k *ar,
+				     struct ath12k_fw_stats *stats);
+void ath12k_debugfs_fw_stats_reset(struct ath12k *ar);
 #else
 static inline void ath12k_debugfs_soc_create(struct ath12k_base *ab)
 {
@@ -29,6 +32,14 @@ static inline void ath12k_debugfs_unregister(struct ath12k *ar)
 {
 }
 
+static inline void ath12k_debugfs_fw_stats_process(struct ath12k *ar,
+						   struct ath12k_fw_stats *stats)
+{
+}
+
+static inline void ath12k_debugfs_fw_stats_reset(struct ath12k *ar)
+{
+}
 #endif /* CONFIG_ATH12K_DEBUGFS */
 
 #endif /* _ATH12K_DEBUGFS_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ba6f5afd81e3..b91b4767515a 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -15,6 +15,7 @@
 #include <linux/time.h>
 #include <linux/of.h>
 #include "core.h"
+#include "debugfs.h"
 #include "debug.h"
 #include "mac.h"
 #include "hw.h"
@@ -6882,12 +6883,156 @@ static void ath12k_peer_assoc_conf_event(struct ath12k_base *ab, struct sk_buff
 	rcu_read_unlock();
 }
 
+static void
+ath12k_wmi_fw_vdev_stats_dump(struct ath12k *ar,
+			      struct ath12k_fw_stats *fw_stats,
+			      char *buf, u32 *length)
+{
+	const struct ath12k_fw_stats_vdev *vdev;
+	u32 buf_len = ATH12K_FW_STATS_BUF_SIZE;
+	struct ath12k_link_vif *arvif;
+	u32 len = *length;
+	u8 *vif_macaddr;
+	int i;
+
+	len += scnprintf(buf + len, buf_len - len, "\n");
+	len += scnprintf(buf + len, buf_len - len, "%30s\n",
+			 "ath12k VDEV stats");
+	len += scnprintf(buf + len, buf_len - len, "%30s\n\n",
+			 "=================");
+
+	list_for_each_entry(vdev, &fw_stats->vdevs, list) {
+		arvif = ath12k_mac_get_arvif(ar, vdev->vdev_id);
+		if (!arvif)
+			continue;
+		vif_macaddr = arvif->ahvif->vif->addr;
+
+		len += scnprintf(buf + len, buf_len - len, "%30s %u\n",
+				 "VDEV ID", vdev->vdev_id);
+		len += scnprintf(buf + len, buf_len - len, "%30s %pM\n",
+				 "VDEV MAC address", vif_macaddr);
+		len += scnprintf(buf + len, buf_len - len, "%30s %u\n",
+				 "beacon snr", vdev->beacon_snr);
+		len += scnprintf(buf + len, buf_len - len, "%30s %u\n",
+				 "data snr", vdev->data_snr);
+		len += scnprintf(buf + len, buf_len - len, "%30s %u\n",
+				 "num rx frames", vdev->num_rx_frames);
+		len += scnprintf(buf + len, buf_len - len, "%30s %u\n",
+				 "num rts fail", vdev->num_rts_fail);
+		len += scnprintf(buf + len, buf_len - len, "%30s %u\n",
+				 "num rts success", vdev->num_rts_success);
+		len += scnprintf(buf + len, buf_len - len, "%30s %u\n",
+				 "num rx err", vdev->num_rx_err);
+		len += scnprintf(buf + len, buf_len - len, "%30s %u\n",
+				 "num rx discard", vdev->num_rx_discard);
+		len += scnprintf(buf + len, buf_len - len, "%30s %u\n",
+				 "num tx not acked", vdev->num_tx_not_acked);
+
+		for (i = 0 ; i < WLAN_MAX_AC; i++)
+			len += scnprintf(buf + len, buf_len - len,
+					"%25s [%02d] %u\n",
+					"num tx frames", i,
+					vdev->num_tx_frames[i]);
+
+		for (i = 0 ; i < WLAN_MAX_AC; i++)
+			len += scnprintf(buf + len, buf_len - len,
+					"%25s [%02d] %u\n",
+					"num tx frames retries", i,
+					vdev->num_tx_frames_retries[i]);
+
+		for (i = 0 ; i < WLAN_MAX_AC; i++)
+			len += scnprintf(buf + len, buf_len - len,
+					"%25s [%02d] %u\n",
+					"num tx frames failures", i,
+					vdev->num_tx_frames_failures[i]);
+
+		for (i = 0 ; i < MAX_TX_RATE_VALUES; i++)
+			len += scnprintf(buf + len, buf_len - len,
+					"%25s [%02d] 0x%08x\n",
+					"tx rate history", i,
+					vdev->tx_rate_history[i]);
+		for (i = 0 ; i < MAX_TX_RATE_VALUES; i++)
+			len += scnprintf(buf + len, buf_len - len,
+					"%25s [%02d] %u\n",
+					"beacon rssi history", i,
+					vdev->beacon_rssi_history[i]);
+
+		len += scnprintf(buf + len, buf_len - len, "\n");
+		*length = len;
+	}
+}
+
+void ath12k_wmi_fw_stats_dump(struct ath12k *ar,
+			      struct ath12k_fw_stats *fw_stats,
+			      u32 stats_id, char *buf)
+{
+	u32 len = 0;
+	u32 buf_len = ATH12K_FW_STATS_BUF_SIZE;
+
+	spin_lock_bh(&ar->data_lock);
+
+	switch (stats_id) {
+	case WMI_REQUEST_VDEV_STAT:
+		ath12k_wmi_fw_vdev_stats_dump(ar, fw_stats, buf, &len);
+		break;
+	default:
+		break;
+	}
+
+	spin_unlock_bh(&ar->data_lock);
+
+	if (len >= buf_len)
+		buf[len - 1] = 0;
+	else
+		buf[len] = 0;
+
+	ath12k_debugfs_fw_stats_reset(ar);
+}
+
+static void
+ath12k_wmi_pull_vdev_stats(const struct wmi_vdev_stats_params *src,
+			   struct ath12k_fw_stats_vdev *dst)
+{
+	int i;
+
+	dst->vdev_id = le32_to_cpu(src->vdev_id);
+	dst->beacon_snr = le32_to_cpu(src->beacon_snr);
+	dst->data_snr = le32_to_cpu(src->data_snr);
+	dst->num_rx_frames = le32_to_cpu(src->num_rx_frames);
+	dst->num_rts_fail = le32_to_cpu(src->num_rts_fail);
+	dst->num_rts_success = le32_to_cpu(src->num_rts_success);
+	dst->num_rx_err = le32_to_cpu(src->num_rx_err);
+	dst->num_rx_discard = le32_to_cpu(src->num_rx_discard);
+	dst->num_tx_not_acked = le32_to_cpu(src->num_tx_not_acked);
+
+	for (i = 0; i < WLAN_MAX_AC; i++)
+		dst->num_tx_frames[i] =
+			le32_to_cpu(src->num_tx_frames[i]);
+
+	for (i = 0; i < WLAN_MAX_AC; i++)
+		dst->num_tx_frames_retries[i] =
+			le32_to_cpu(src->num_tx_frames_retries[i]);
+
+	for (i = 0; i < WLAN_MAX_AC; i++)
+		dst->num_tx_frames_failures[i] =
+			le32_to_cpu(src->num_tx_frames_failures[i]);
+
+	for (i = 0; i < MAX_TX_RATE_VALUES; i++)
+		dst->tx_rate_history[i] =
+			le32_to_cpu(src->tx_rate_history[i]);
+
+	for (i = 0; i < MAX_TX_RATE_VALUES; i++)
+		dst->beacon_rssi_history[i] =
+			le32_to_cpu(src->beacon_rssi_history[i]);
+}
+
 static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 					      struct wmi_tlv_fw_stats_parse *parse,
 					      const void *ptr,
 					      u16 len)
 {
 	const struct wmi_stats_event *ev = parse->ev;
+	struct ath12k_fw_stats stats = {0};
 	struct ath12k *ar;
 	struct ath12k_link_vif *arvif;
 	struct ieee80211_sta *sta;
@@ -6896,6 +7041,8 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 	int i, ret = 0;
 	const void *data = ptr;
 
+	INIT_LIST_HEAD(&stats.vdevs);
+
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch update stats ev");
 		return -EPROTO;
@@ -6913,6 +7060,7 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 
 	for (i = 0; i < le32_to_cpu(ev->num_vdev_stats); i++) {
 		const struct wmi_vdev_stats_params *src;
+		struct ath12k_fw_stats_vdev *dst;
 
 		src = data;
 		if (len < sizeof(*src)) {
@@ -6941,9 +7089,16 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 
 		data += sizeof(*src);
 		len -= sizeof(*src);
+		dst = kzalloc(sizeof(*dst), GFP_ATOMIC);
+		if (!dst)
+			continue;
+		ath12k_wmi_pull_vdev_stats(src, dst);
+		stats.stats_id = WMI_REQUEST_VDEV_STAT;
+		list_add_tail(&dst->list, &stats.vdevs);
 	}
 
 	complete(&ar->fw_stats_complete);
+	ath12k_debugfs_fw_stats_process(ar, &stats);
 exit:
 	rcu_read_unlock();
 	return ret;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index afa2832ba282..1c9500594f1d 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -25,6 +25,7 @@
 struct ath12k_base;
 struct ath12k;
 struct ath12k_link_vif;
+struct ath12k_fw_stats;
 
 /* There is no signed version of __le32, so for a temporary solution come
  * up with our own version. The idea is from fs/ntfs/endian.h.
@@ -5694,6 +5695,12 @@ struct wmi_vdev_stats_params {
 	__le32 beacon_rssi_history[MAX_TX_RATE_VALUES];
 } __packed;
 
+struct ath12k_fw_stats_req_params {
+	u32 stats_id;
+	u32 vdev_id;
+	u32 pdev_id;
+};
+
 void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
 			     struct ath12k_wmi_resource_config_arg *config);
 void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
@@ -5875,5 +5882,8 @@ int ath12k_wmi_sta_keepalive(struct ath12k *ar,
 int ath12k_wmi_mlo_setup(struct ath12k *ar, struct wmi_mlo_setup_arg *mlo_params);
 int ath12k_wmi_mlo_ready(struct ath12k *ar);
 int ath12k_wmi_mlo_teardown(struct ath12k *ar);
+void ath12k_wmi_fw_stats_dump(struct ath12k *ar,
+			      struct ath12k_fw_stats *fw_stats, u32 stats_id,
+			      char *buf);
 
 #endif
-- 
2.34.1



Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3FC439604
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 14:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhJYMVI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 08:21:08 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:34130 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhJYMVH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 08:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635164325; x=1666700325;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=v913O6TZg9mjOWfV0M9rxJlvONiHOMOkvmcQ0L/hh0Y=;
  b=MphbLwvg7aHFLnULnmv7iLrEyICOR09AJ5l8x73Bzsr9XM6QAeDUCi/a
   eutb5XjUu3/wUuX6TrEGVceF419g67cC69vbh1fLkl5/AaY8fmhbfWz3w
   bIz9zNfl5LouSO0I4aFzyfrr7197fb8pZE3PCrzSSPCCUK130pLWO5FME
   k=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 25 Oct 2021 05:18:45 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 05:18:45 -0700
Received: from ppranees-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 25 Oct 2021 05:18:43 -0700
From:   P Praneesh <quic_ppranees@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH] ath11k: Add provision to configure rx hashmap
Date:   Mon, 25 Oct 2021 17:48:36 +0530
Message-ID: <1635164316-27055-1-git-send-email-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently the hashmap is set to default during REO setup and all REO
rings are equally distributed across 32 hash values.

In multiple radio cases, 40MHz+80MHz+160MHz, distributing received
packets across all the CPU will cause CPU overhead. In this case,
during runtime we can span 40MHz and 80MHz among 2 cores and remaining
2 cores are equally distributed for 160MHz by using register mapping.

Add provision to configure the hashmap during runtime through debugfs
for improving flexibility to control the destination HW rx queues/rings,
so that affinity could be used to assign those interrupts to specific
rings. Setting 0 will disable hash based steering.

echo "hashmap" > /sys/kernel/debug/ath11k/ipq8074\ hw2.0/rx_hash

Developers who are aware of hardware register mapping can leverage
this rx_hash debugfs.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01695-QCAHKSWPL_SILICONZ-1

Co-developed-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h    |  4 ++
 drivers/net/wireless/ath/ath11k/debugfs.c | 64 +++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hal.h     |  1 +
 drivers/net/wireless/ath/ath11k/hal_rx.c  | 10 +++++
 drivers/net/wireless/ath/ath11k/hw.c      | 18 +--------
 5 files changed, 81 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 31d234a..81867ac 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -36,6 +36,9 @@
 #define ATH11K_INVALID_HW_MAC_ID	0xFF
 #define ATH11K_CONNECTION_LOSS_HZ	(3 * HZ)
 
+/* Shift value to set the dest rings hash map to the dest control register */
+#define HAL_REO_DEST_RING_CTRL_HASH_RING_SHIFT 8
+
 extern unsigned int ath11k_frame_mode;
 
 #define ATH11K_MON_TIMER_INTERVAL  10
@@ -759,6 +762,7 @@ struct ath11k_base {
 
 	struct completion htc_suspend;
 
+	u32 rx_hash;
 	/* must be last */
 	u8 drv_priv[0] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 80afd35..7c2d49c 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -831,6 +831,67 @@ static const struct file_operations fops_soc_dp_stats = {
 	.llseek = default_llseek,
 };
 
+static ssize_t ath11k_write_rx_hash(struct file *file,
+				    const char __user *ubuf,
+				    size_t count, loff_t *ppos)
+{
+	struct ath11k_base *ab = file->private_data;
+	struct ath11k_pdev *pdev;
+	u32 rx_hash;
+	u8 buf[128] = {0};
+	int ret, i;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		if (pdev && pdev->ar)
+			break;
+	}
+
+	if (i == ab->num_radios) {
+		ath11k_err(ab, "radio is not up\n");
+		ret = -ENETDOWN;
+		goto exit;
+	}
+
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
+	if (ret < 0)
+		goto exit;
+
+	buf[ret] = '\0';
+	ret = kstrtou32(buf, 0, &rx_hash);
+	if (ret) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (rx_hash != ab->rx_hash) {
+		ab->rx_hash = rx_hash;
+		if (rx_hash)
+			ath11k_hal_reo_hash_setup(ab, rx_hash);
+	}
+	ret = count;
+exit:
+	return ret;
+}
+
+static ssize_t ath11k_read_rx_hash(struct file *file,
+				   char __user *ubuf,
+				   size_t count, loff_t *ppos)
+{
+	struct ath11k_base *ab = file->private_data;
+	int len = 0;
+	char buf[32];
+
+	len = scnprintf(buf, sizeof(buf) - len, "0x%x\n", ab->rx_hash);
+	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+}
+
+static const struct file_operations fops_soc_rx_hash = {
+	.read = ath11k_read_rx_hash,
+	.write = ath11k_write_rx_hash,
+	.open = simple_open,
+};
+
 int ath11k_debugfs_pdev_create(struct ath11k_base *ab)
 {
 	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
@@ -846,6 +907,9 @@ int ath11k_debugfs_pdev_create(struct ath11k_base *ab)
 	debugfs_create_file("soc_dp_stats", 0600, ab->debugfs_soc, ab,
 			    &fops_soc_dp_stats);
 
+	debugfs_create_file("rx_hash", 0600, ab->debugfs_soc, ab,
+			    &fops_soc_rx_hash);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 35ed3a1..bc9b321 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -908,6 +908,7 @@ void ath11k_hal_reo_qdesc_setup(void *vaddr, int tid, u32 ba_window_size,
 				u32 start_seq, enum hal_pn_type type);
 void ath11k_hal_reo_init_cmd_ring(struct ath11k_base *ab,
 				  struct hal_srng *srng);
+void ath11k_hal_reo_hash_setup(struct ath11k_base *ab, u32 ring_hash_map);
 void ath11k_hal_setup_link_idle_list(struct ath11k_base *ab,
 				     struct hal_wbm_idle_scatter_list *sbuf,
 				     u32 nsbufs, u32 tot_link_desc,
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 325055c..25d0981 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -801,6 +801,16 @@ void ath11k_hal_reo_init_cmd_ring(struct ath11k_base *ab,
 	}
 }
 
+void ath11k_hal_reo_hash_setup(struct ath11k_base *ab, u32 ring_hash_map)
+{
+	u32 reo_base = HAL_SEQ_WCSS_UMAC_REO_REG;
+
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_2,
+			   ring_hash_map << HAL_REO_DEST_RING_CTRL_HASH_RING_SHIFT);
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_3,
+			   ring_hash_map << HAL_REO_DEST_RING_CTRL_HASH_RING_SHIFT);
+}
+
 static enum hal_rx_mon_status
 ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 				   struct hal_rx_mon_ppdu_info *ppdu_info,
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 7a343db..61562e8 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -132,18 +132,7 @@ static void ath11k_hw_ipq8074_reo_setup(struct ath11k_base *ab)
 	ath11k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_3(ab),
 			   HAL_DEFAULT_REO_TIMEOUT_USEC);
 
-	ath11k_hif_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_0,
-			   FIELD_PREP(HAL_REO_DEST_RING_CTRL_HASH_RING_MAP,
-				      ring_hash_map));
-	ath11k_hif_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_1,
-			   FIELD_PREP(HAL_REO_DEST_RING_CTRL_HASH_RING_MAP,
-				      ring_hash_map));
-	ath11k_hif_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_2,
-			   FIELD_PREP(HAL_REO_DEST_RING_CTRL_HASH_RING_MAP,
-				      ring_hash_map));
-	ath11k_hif_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_3,
-			   FIELD_PREP(HAL_REO_DEST_RING_CTRL_HASH_RING_MAP,
-				      ring_hash_map));
+	ath11k_hal_reo_hash_setup(ab, ring_hash_map);
 }
 
 static void ath11k_init_wmi_config_ipq8074(struct ath11k_base *ab,
@@ -771,10 +760,7 @@ static void ath11k_hw_wcn6855_reo_setup(struct ath11k_base *ab)
 	ath11k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_3(ab),
 			   HAL_DEFAULT_REO_TIMEOUT_USEC);
 
-	ath11k_hif_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_2,
-			   ring_hash_map);
-	ath11k_hif_write32(ab, reo_base + HAL_REO1_DEST_RING_CTRL_IX_3,
-			   ring_hash_map);
+	ath11k_hal_reo_hash_setup(ab, ring_hash_map);
 }
 
 static u16 ath11k_hw_ipq8074_mpdu_info_get_peerid(u8 *tlv_data)
-- 
2.7.4


Return-Path: <linux-wireless+bounces-18042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D7FA1DB3B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 18:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478533A51F7
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 17:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5AE189F57;
	Mon, 27 Jan 2025 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H+hkLgc/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E4D1898ED
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737998549; cv=none; b=GA/C+lq9QGZSkdFpqOOWX50HxrYxtJBYEzNapW1HzBx5xMj/ARUz2Tqj52Olw2A5o7JdwfPt8ChQKuTz1ncOr78I7XLKpczK2V4nRbHzpvr53SJGR4MlPDAsQ31DG57kp1JtsA/bOLX1VHD7R/0A6BOm8/GOjJzdJt1IYZJXWdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737998549; c=relaxed/simple;
	bh=Fp6aYqw5ImqJQJqz11+FgcGdsfnohk+gm63ir2EJeUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WUPP5fiIwv+wiC0zPMkwJ+J73Q+GXkTwM45wzKVQAjIc2WJzlRu0qHjhP+l1AwRBxlAX5W7B3P6LDKTubQZ/5VU96/6TQvDwFM2v2zZKigC2O2lteMdLr9BFYaQB92/Hilz6lgQc66hq60NBDfgc6SXkHQ1QPIzr5jrBnC5/qBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H+hkLgc/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R7gi6p027509
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 17:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3jDJqWyMnbk
	xzYhungqLpMV9NhYS3FarxJ2VHX/C7Vk=; b=H+hkLgc/dBiVsbTLCnozeBn1dDP
	VCbKRYkuTigkKlW62d3OxnvlnHi7kf58JVPnsChtFvvTI1z78d8wblOq54DenUbe
	2vOretp+w1P7l479AbSa2jY3nWd9YoqZrBIL67uUMTFPZ83IECOg+XDPvYT/lz2b
	vdgv4bQy95NrDk+P9ElVJPyIWzM5p8QDyIvFn4NepvKJNQdC/HB2AHpQQ+8EZ+nt
	q5mxbljF7N3mjh87sQ9UmCCFBKIimltwwp42lQT07wT6vZ03dnU1EPZmeD3Oozlk
	Iwj7VxcTsMmATIaYdmsYBGLgFtXudUTbZlYSvpXyVbpBAvj8zSSXD17mBDg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44e60bh85a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 17:22:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2161d5b3eb5so88303375ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 09:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737998544; x=1738603344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jDJqWyMnbkxzYhungqLpMV9NhYS3FarxJ2VHX/C7Vk=;
        b=AQqndHNCQTmzDDyjGaFCTSVLfFvLLUnlitWYt7aV4J4xzag85sSYvQWRs3kJFKHRAI
         Xde/MWmwk3RgGEMFpzNtkjflnWzBqkx30mcdK+769Nv3t2C/XRz8vDKXD6l/cVcX+bOm
         TmJRjZh6eQobpydodUz2aTn0BGy2ryYhSqzk17QHOLCd73F0ANIK1shKpdNcJoT05YDf
         N/lVAImKIKhZM1qauD5N9B+dCYy1zjHGquK4kgj08rapoVXirw4lmd4OuqkyJ8YWBf1f
         O8ZMQtckcvSb0vHhSS/ke+3NUMcJAEJQGcgWuJlAMleysT+H4STSTvwPIbqp1pVN6zO0
         7uBA==
X-Gm-Message-State: AOJu0YznFFt/VeND+NtUb1M6DpHgkzOvJBQz7w+yEw6qQrLTgAUjubJM
	jGIxeBiI9awEvvnxEtaRTvtgRTNG9kOvFJegtvVJXScEMsOGWX+m2qxEjSNFuUG5LQRAvzVMvtE
	B0WIm0CmHyqZxpHodPOpmcS2KdoztMIB2uj901LhTRnAVJeFSuTAjz5gjhEuC2XFl+dym+d3LIg
	==
X-Gm-Gg: ASbGncvgbAHCFltXVVsMAIiOyhcIRYvXJNtw4sgkuqmChQn7K3z3lhQfOfDd21kp5sH
	/SfEjbkjbRG2T2GRgjhzxz+tYizbrRtvJVoaO9G+r2oiUhNihLHn49qytSc7NIgNU3XaR+E9GR1
	hffnZFzCzfK5+tyXxEkbFlsy64sT/ck2/Xm2TOFQCZ95rw09WQsGw04iHCkM5ln3sBSMRbrYPTB
	1uDZ/i8MpBYRELGziLkVCEDPbQwml1X98wXTxN+wXB43vkEb2MjwG3lQT5Z3rirtO6Lj7zS7UJY
	Fm4aqvjtjr+3Dx6ycLm2/eoKpMH58knf6L2TeuPL6zz4HKojZB7RwWKKJOSX6h5csAm7TdGuylh
	rWoRjoSdbPzwN5pGyrqSBcTuLySvxxflUcQ==
X-Received: by 2002:a05:6a20:431d:b0:1e1:ca91:b0e3 with SMTP id adf61e73a8af0-1eb215ec860mr72270821637.36.1737998544026;
        Mon, 27 Jan 2025 09:22:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhqLvvvZTSPbWXTCMDi5+AOqKGfJJ23rJUhrHDYMrUF5254RApwJV3Q6L7onuciHejeZYOug==
X-Received: by 2002:a05:6a20:431d:b0:1e1:ca91:b0e3 with SMTP id adf61e73a8af0-1eb215ec860mr72270770637.36.1737998543608;
        Mon, 27 Jan 2025 09:22:23 -0800 (PST)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6b2c07sm7464639b3a.40.2025.01.27.09.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 09:22:23 -0800 (PST)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH 1/2] wifi: ath12k: move firmware stats out of debugfs
Date: Mon, 27 Jan 2025 22:52:01 +0530
Message-Id: <20250127172202.1410429-2-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127172202.1410429-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250127172202.1410429-1-rameshkumar.sundaram@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qWNpkzxSXtGz1JgRPx2OHhuAVHF6qSWT
X-Proofpoint-ORIG-GUID: qWNpkzxSXtGz1JgRPx2OHhuAVHF6qSWT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_08,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270137

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Currently, firmware stats, comprising pdev, vdev and beacon stats are
part of debugfs. In firmware pdev stats, firmware reports the final
Tx power used to transmit each packet. If driver wants to know the
final Tx power being used at firmware level, it can leverage from
firmware pdev stats.

Move firmware stats out of debugfs context in order to leverage
the final Tx power reported in it even when debugfs is disabled.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c    | 45 +++++++++++
 drivers/net/wireless/ath/ath12k/core.h    |  3 +
 drivers/net/wireless/ath/ath12k/debugfs.c | 44 +----------
 drivers/net/wireless/ath/ath12k/wmi.c     | 94 ++++++++++++++++++-----
 4 files changed, 124 insertions(+), 62 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 2dd0666959cd..122b407cd322 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1052,6 +1052,51 @@ bool ath12k_core_hw_group_start_ready(struct ath12k_hw_group *ag)
 	return (ag->num_started == ag->num_devices);
 }
 
+static void ath12k_fw_stats_pdevs_free(struct list_head *head)
+{
+	struct ath12k_fw_stats_pdev *i, *tmp;
+
+	list_for_each_entry_safe(i, tmp, head, list) {
+		list_del(&i->list);
+		kfree(i);
+	}
+}
+
+void ath12k_fw_stats_bcn_free(struct list_head *head)
+{
+	struct ath12k_fw_stats_bcn *i, *tmp;
+
+	list_for_each_entry_safe(i, tmp, head, list) {
+		list_del(&i->list);
+		kfree(i);
+	}
+}
+
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
+void ath12k_fw_stats_init(struct ath12k *ar)
+{
+	INIT_LIST_HEAD(&ar->fw_stats.vdevs);
+	INIT_LIST_HEAD(&ar->fw_stats.pdevs);
+	INIT_LIST_HEAD(&ar->fw_stats.bcn);
+	init_completion(&ar->fw_stats_complete);
+}
+
+void ath12k_fw_stats_free(struct ath12k_fw_stats *stats)
+{
+	ath12k_fw_stats_pdevs_free(&stats->pdevs);
+	ath12k_fw_stats_vdevs_free(&stats->vdevs);
+	ath12k_fw_stats_bcn_free(&stats->bcn);
+}
+
 static void ath12k_core_trigger_partner(struct ath12k_base *ab)
 {
 	struct ath12k_hw_group *ag = ab->ag;
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 28db100cfac0..e4f51ad6a59f 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1198,6 +1198,9 @@ u32 ath12k_core_get_max_peers_per_radio(struct ath12k_base *ab);
 u32 ath12k_core_get_max_num_tids(struct ath12k_base *ab);
 
 void ath12k_core_hw_group_set_mlo_capable(struct ath12k_hw_group *ag);
+void ath12k_fw_stats_init(struct ath12k *ar);
+void ath12k_fw_stats_bcn_free(struct list_head *head);
+void ath12k_fw_stats_free(struct ath12k_fw_stats *stats);
 
 static inline const char *ath12k_scan_state_str(enum ath12k_scan_state state)
 {
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 6d6708486d14..4e4c2ef6a7ce 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -69,43 +69,11 @@ void ath12k_debugfs_soc_destroy(struct ath12k_base *ab)
 	 */
 }
 
-static void ath12k_fw_stats_pdevs_free(struct list_head *head)
-{
-	struct ath12k_fw_stats_pdev *i, *tmp;
-
-	list_for_each_entry_safe(i, tmp, head, list) {
-		list_del(&i->list);
-		kfree(i);
-	}
-}
-
-static void ath12k_fw_stats_bcn_free(struct list_head *head)
-{
-	struct ath12k_fw_stats_bcn *i, *tmp;
-
-	list_for_each_entry_safe(i, tmp, head, list) {
-		list_del(&i->list);
-		kfree(i);
-	}
-}
-
-static void ath12k_fw_stats_vdevs_free(struct list_head *head)
-{
-	struct ath12k_fw_stats_vdev *i, *tmp;
-
-	list_for_each_entry_safe(i, tmp, head, list) {
-		list_del(&i->list);
-		kfree(i);
-	}
-}
-
 void ath12k_debugfs_fw_stats_reset(struct ath12k *ar)
 {
 	spin_lock_bh(&ar->data_lock);
 	ar->fw_stats.fw_stats_done = false;
-	ath12k_fw_stats_vdevs_free(&ar->fw_stats.vdevs);
-	ath12k_fw_stats_bcn_free(&ar->fw_stats.bcn);
-	ath12k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
+	ath12k_fw_stats_free(&ar->fw_stats);
 	spin_unlock_bh(&ar->data_lock);
 }
 
@@ -221,10 +189,6 @@ ath12k_debugfs_fw_stats_process(struct ath12k *ar,
 			num_bcn = 0;
 		}
 	}
-	if (stats->stats_id == WMI_REQUEST_PDEV_STAT) {
-		list_splice_tail_init(&stats->pdevs, &ar->fw_stats.pdevs);
-		ar->fw_stats.fw_stats_done = true;
-	}
 }
 
 static int ath12k_open_vdev_stats(struct inode *inode, struct file *file)
@@ -438,11 +402,7 @@ void ath12k_debugfs_fw_stats_register(struct ath12k *ar)
 	debugfs_create_file("pdev_stats", 0600, fwstats_dir, ar,
 			    &fops_pdev_stats);
 
-	INIT_LIST_HEAD(&ar->fw_stats.vdevs);
-	INIT_LIST_HEAD(&ar->fw_stats.bcn);
-	INIT_LIST_HEAD(&ar->fw_stats.pdevs);
-
-	init_completion(&ar->fw_stats_complete);
+	ath12k_fw_stats_init(ar);
 }
 
 void ath12k_debugfs_register(struct ath12k *ar)
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 61aa5f509338..1a7af09853a4 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -29,6 +29,7 @@ struct ath12k_wmi_svc_ready_parse {
 
 struct wmi_tlv_fw_stats_parse {
 	const struct wmi_stats_event *ev;
+	struct ath12k_fw_stats *stats;
 };
 
 struct ath12k_wmi_dma_ring_caps_parse {
@@ -7314,7 +7315,7 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 					      u16 len)
 {
 	const struct wmi_stats_event *ev = parse->ev;
-	struct ath12k_fw_stats stats = {0};
+	struct ath12k_fw_stats *stats = parse->stats;
 	struct ath12k *ar;
 	struct ath12k_link_vif *arvif;
 	struct ieee80211_sta *sta;
@@ -7323,10 +7324,6 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 	int i, ret = 0;
 	const void *data = ptr;
 
-	INIT_LIST_HEAD(&stats.vdevs);
-	INIT_LIST_HEAD(&stats.bcn);
-	INIT_LIST_HEAD(&stats.pdevs);
-
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch update stats ev");
 		return -EPROTO;
@@ -7334,7 +7331,8 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 
 	rcu_read_lock();
 
-	ar = ath12k_mac_get_ar_by_pdev_id(ab, le32_to_cpu(ev->pdev_id));
+	stats->pdev_id = le32_to_cpu(ev->pdev_id);
+	ar = ath12k_mac_get_ar_by_pdev_id(ab, stats->pdev_id);
 	if (!ar) {
 		ath12k_warn(ab, "invalid pdev id %d in update stats event\n",
 			    le32_to_cpu(ev->pdev_id));
@@ -7377,8 +7375,8 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 		if (!dst)
 			continue;
 		ath12k_wmi_pull_vdev_stats(src, dst);
-		stats.stats_id = WMI_REQUEST_VDEV_STAT;
-		list_add_tail(&dst->list, &stats.vdevs);
+		stats->stats_id = WMI_REQUEST_VDEV_STAT;
+		list_add_tail(&dst->list, &stats->vdevs);
 	}
 	for (i = 0; i < le32_to_cpu(ev->num_bcn_stats); i++) {
 		const struct ath12k_wmi_bcn_stats_params *src;
@@ -7396,8 +7394,8 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 		if (!dst)
 			continue;
 		ath12k_wmi_pull_bcn_stats(src, dst);
-		stats.stats_id = WMI_REQUEST_BCN_STAT;
-		list_add_tail(&dst->list, &stats.bcn);
+		stats->stats_id = WMI_REQUEST_BCN_STAT;
+		list_add_tail(&dst->list, &stats->bcn);
 	}
 	for (i = 0; i < le32_to_cpu(ev->num_pdev_stats); i++) {
 		const struct ath12k_wmi_pdev_stats_params *src;
@@ -7409,7 +7407,7 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 			goto exit;
 		}
 
-		stats.stats_id = WMI_REQUEST_PDEV_STAT;
+		stats->stats_id = WMI_REQUEST_PDEV_STAT;
 
 		data += sizeof(*src);
 		len -= sizeof(*src);
@@ -7421,11 +7419,9 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 		ath12k_wmi_pull_pdev_stats_base(&src->base, dst);
 		ath12k_wmi_pull_pdev_stats_tx(&src->tx, dst);
 		ath12k_wmi_pull_pdev_stats_rx(&src->rx, dst);
-		list_add_tail(&dst->list, &stats.pdevs);
+		list_add_tail(&dst->list, &stats->pdevs);
 	}
 
-	complete(&ar->fw_stats_complete);
-	ath12k_debugfs_fw_stats_process(ar, &stats);
 exit:
 	rcu_read_unlock();
 	return ret;
@@ -7451,16 +7447,74 @@ static int ath12k_wmi_tlv_fw_stats_parse(struct ath12k_base *ab,
 	return ret;
 }
 
+static int ath12k_wmi_pull_fw_stats(struct ath12k_base *ab, struct sk_buff *skb,
+				    struct ath12k_fw_stats *stats)
+{
+	struct wmi_tlv_fw_stats_parse parse = {};
+
+	stats->stats_id = 0;
+	parse.stats = stats;
+
+	return ath12k_wmi_tlv_iter(ab, skb->data, skb->len,
+				   ath12k_wmi_tlv_fw_stats_parse,
+				   &parse);
+}
+
 static void ath12k_update_stats_event(struct ath12k_base *ab, struct sk_buff *skb)
 {
+	struct ath12k_fw_stats stats = {};
+	struct ath12k *ar;
 	int ret;
-	struct wmi_tlv_fw_stats_parse parse = {};
 
-	ret = ath12k_wmi_tlv_iter(ab, skb->data, skb->len,
-				  ath12k_wmi_tlv_fw_stats_parse,
-				  &parse);
-	if (ret)
-		ath12k_warn(ab, "failed to parse fw stats %d\n", ret);
+	INIT_LIST_HEAD(&stats.pdevs);
+	INIT_LIST_HEAD(&stats.vdevs);
+	INIT_LIST_HEAD(&stats.bcn);
+
+	ret = ath12k_wmi_pull_fw_stats(ab, skb, &stats);
+	if (ret) {
+		ath12k_warn(ab, "failed to pull fw stats: %d\n", ret);
+		goto free;
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_WMI, "event update stats");
+
+	rcu_read_lock();
+	ar = ath12k_mac_get_ar_by_pdev_id(ab, stats.pdev_id);
+	if (!ar) {
+		rcu_read_unlock();
+		ath12k_warn(ab, "failed to get ar for pdev_id %d: %d\n",
+			    stats.pdev_id, ret);
+		goto free;
+	}
+
+	spin_lock_bh(&ar->data_lock);
+
+	/* WMI_REQUEST_PDEV_STAT can be requested via .get_txpower mac ops or via
+	 * debugfs fw stats. Therefore, processing it separately.
+	 */
+	if (stats.stats_id == WMI_REQUEST_PDEV_STAT) {
+		list_splice_tail_init(&stats.pdevs, &ar->fw_stats.pdevs);
+		ar->fw_stats.fw_stats_done = true;
+		goto complete;
+	}
+
+	/* WMI_REQUEST_VDEV_STAT and WMI_REQUEST_BCN_STAT are currently requested only
+	 * via debugfs fw stats. Hence, processing these in debugfs context.
+	 */
+	ath12k_debugfs_fw_stats_process(ar, &stats);
+
+complete:
+	complete(&ar->fw_stats_complete);
+	spin_unlock_bh(&ar->data_lock);
+	rcu_read_unlock();
+
+	/* Since the stats's pdev, vdev and beacon list are spliced and reinitialised
+	 * at this point, no need to free the individual list.
+	 */
+	return;
+
+free:
+	ath12k_fw_stats_free(&stats);
 }
 
 /* PDEV_CTL_FAILSAFE_CHECK_EVENT is received from FW when the frequency scanned
-- 
2.34.1



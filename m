Return-Path: <linux-wireless+bounces-17916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984C4A1BC7D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 19:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D195A7A1BFF
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 18:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79C22248B8;
	Fri, 24 Jan 2025 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DSZ2Xe8X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08EF1D54D8
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737744824; cv=none; b=UuK6g2WJzGCA8C4dSf/sCUsgl8t8juItAIE+iVkWpr96RFFa4UC1WFtSP1a/XK+YrwifJoa38C/rcWTtK3mhPN1Ap18jkjGmJt9lXj/dFA0VHtwLNH5QCK2nIju5Lr8bMtRIhOjv7+ReYMR13QsyvVMc4AY3Fo/m4jobZAIXVZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737744824; c=relaxed/simple;
	bh=wyp//160qaGq0kTXwwLWzcuK91l9fcfr67ODc/ukcWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IbAQ/7LNiBrRr6qzb4pZm3ifOJKNLQAugaaASN7keHDFqrortg+2bxDglyQlZjvv6Uqwcxf2DTq8Cs/EheWxOTn6zZEdEkWRaQSOI56Ysc/8GbVQqEDofw7iScDyL7qkXm3a6gNzaITN/izXvz3ICR3SK7BytKOsxPt1pyqcIQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DSZ2Xe8X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OETO0w002247;
	Fri, 24 Jan 2025 18:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uRP3c68a82K
	O6sbGEFYPyIo5ofaGB9teq+9B33MZzZ8=; b=DSZ2Xe8X3QmRr5qJbhUpda+I7BZ
	huRswJfHPDmPEJriMcNmNiu1IxQ9ym5pYXOPwxZNUTvdPWlE8tDqRyNCrv/NeF6+
	GppP6E4Z+Jpr6i0IZtdD70iNCHfFw2rl9zhwIQIleOeT5d9+ZF4Dhqc0CgOI57UU
	W9sxlxrUgexWLbDSoZuk4uDAEZWQ69CMNaFdVitS3kzU5nwLRMDWmdEhMa5h8WbR
	tzdgzSG6t9oKOI3Ho1YgtU8AdMmbuSBKjWIkiebVMXBRceAc8dhRi9t5luG6x6Sk
	KGHSn/EBZf9boCScC8FF7omV66YqMbxN9GkYy6RB4rCAYAK4To3hGLxHcuQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ccnn8jgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 18:53:38 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIrZWh013052;
	Fri, 24 Jan 2025 18:53:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4485cmbfnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 18:53:35 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50OIrYjA013044;
	Fri, 24 Jan 2025 18:53:34 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 50OIrYMI013038
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 18:53:34 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id 0D9E84116F; Sat, 25 Jan 2025 00:23:34 +0530 (+0530)
From: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
Subject: [PATCH 2/3] wifi: ath12k: Request beacon stats from firmware
Date: Sat, 25 Jan 2025 00:23:29 +0530
Message-Id: <20250124185330.1244585-3-ramya.gnanasekar@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 76INURQR1H-e5MxF9tV7et9SSOrmCfh9
X-Proofpoint-GUID: 76INURQR1H-e5MxF9tV7et9SSOrmCfh9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240130

Add support to request and dump beacon statistics from firmware

Sample output:
-------------
cat /sys/kernel/debug/ath12k/pci-0000:06:00.0/mac0/fw_stats/beacon_stats

           ath12k Beacon stats (1)
           ===================

                       VDEV ID 0
              VDEV MAC address 00:03:7f:04:37:58
              ================

      Num of beacon tx success 20
     Num of beacon tx failures 0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h    |   8 ++
 drivers/net/wireless/ath/ath12k/debugfs.c | 106 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.c     |  71 +++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h     |   7 ++
 4 files changed, 191 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index fffdf17fcb1c..49780fe51b0b 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1100,6 +1100,14 @@ struct ath12k_fw_stats_vdev {
 	u32 beacon_rssi_history[MAX_TX_RATE_VALUES];
 };
 
+struct ath12k_fw_stats_bcn {
+	struct list_head list;
+
+	u32 vdev_id;
+	u32 tx_bcn_succ_cnt;
+	u32 tx_bcn_outage_cnt;
+};
+
 int ath12k_core_qmi_firmware_ready(struct ath12k_base *ab);
 int ath12k_core_pre_init(struct ath12k_base *ab);
 int ath12k_core_init(struct ath12k_base *ath12k);
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 1ee9a3e00514..3cb2bb9fa424 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -69,6 +69,16 @@ void ath12k_debugfs_soc_destroy(struct ath12k_base *ab)
 	 */
 }
 
+static void ath12k_fw_stats_bcn_free(struct list_head *head)
+{
+	struct ath12k_fw_stats_bcn *i, *tmp;
+
+	list_for_each_entry_safe(i, tmp, head, list) {
+		list_del(&i->list);
+		kfree(i);
+	}
+}
+
 static void ath12k_fw_stats_vdevs_free(struct list_head *head)
 {
 	struct ath12k_fw_stats_vdev *i, *tmp;
@@ -84,6 +94,7 @@ void ath12k_debugfs_fw_stats_reset(struct ath12k *ar)
 	spin_lock_bh(&ar->data_lock);
 	ar->fw_stats.fw_stats_done = false;
 	ath12k_fw_stats_vdevs_free(&ar->fw_stats.vdevs);
+	ath12k_fw_stats_bcn_free(&ar->fw_stats.bcn);
 	spin_unlock_bh(&ar->data_lock);
 }
 
@@ -150,7 +161,7 @@ ath12k_debugfs_fw_stats_process(struct ath12k *ar,
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_pdev *pdev;
 	bool is_end;
-	static unsigned int num_vdev;
+	static unsigned int num_vdev, num_bcn;
 	size_t total_vdevs_started = 0;
 	int i;
 
@@ -181,6 +192,24 @@ ath12k_debugfs_fw_stats_process(struct ath12k *ar,
 		}
 		return;
 	}
+	if (stats->stats_id == WMI_REQUEST_BCN_STAT) {
+		if (list_empty(&stats->bcn)) {
+			ath12k_warn(ab, "empty beacon stats");
+			return;
+		}
+		/* Mark end until we reached the count of all started VDEVs
+		 * within the PDEV
+		 */
+		is_end = ((++num_bcn) == ar->num_started_vdevs);
+
+		list_splice_tail_init(&stats->bcn,
+				      &ar->fw_stats.bcn);
+
+		if (is_end) {
+			ar->fw_stats.fw_stats_done = true;
+			num_bcn = 0;
+		}
+	}
 }
 
 static int ath12k_open_vdev_stats(struct inode *inode, struct file *file)
@@ -246,6 +275,78 @@ static const struct file_operations fops_vdev_stats = {
 	.llseek = default_llseek,
 };
 
+static int ath12k_open_bcn_stats(struct inode *inode, struct file *file)
+{
+	struct ath12k *ar = inode->i_private;
+	struct ath12k_link_vif *arvif;
+	struct ath12k_fw_stats_req_params param;
+	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
+	int ret;
+
+	guard(wiphy)(ath12k_ar_to_hw(ar)->wiphy);
+
+	if (ah && ah->state != ATH12K_HW_STATE_ON)
+		return -ENETDOWN;
+
+	void *buf __free(kfree) = kzalloc(ATH12K_FW_STATS_BUF_SIZE, GFP_ATOMIC);
+	if (!buf)
+		return -ENOMEM;
+
+	param.pdev_id = ath12k_mac_get_target_pdev_id(ar);
+	param.stats_id = WMI_REQUEST_BCN_STAT;
+
+	/* loop all active VDEVs for bcn stats */
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		if (!arvif->is_up)
+			continue;
+
+		param.vdev_id = arvif->vdev_id;
+		ret = ath12k_debugfs_fw_stats_request(ar, &param);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to request fw bcn stats: %d\n", ret);
+			return ret;
+		}
+	}
+
+	ath12k_wmi_fw_stats_dump(ar, &ar->fw_stats, param.stats_id,
+				 buf);
+	/* since beacon stats request is looped for all active VDEVs, saved fw
+	 * stats is not freed for each request until done for all active VDEVs
+	 */
+	spin_lock_bh(&ar->data_lock);
+	ath12k_fw_stats_bcn_free(&ar->fw_stats.bcn);
+	spin_unlock_bh(&ar->data_lock);
+
+	file->private_data = no_free_ptr(buf);
+
+	return 0;
+}
+
+static int ath12k_release_bcn_stats(struct inode *inode, struct file *file)
+{
+	kfree(file->private_data);
+
+	return 0;
+}
+
+static ssize_t ath12k_read_bcn_stats(struct file *file,
+				     char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	const char *buf = file->private_data;
+	size_t len = strlen(buf);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static const struct file_operations fops_bcn_stats = {
+	.open = ath12k_open_bcn_stats,
+	.release = ath12k_release_bcn_stats,
+	.read = ath12k_read_bcn_stats,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
 static
 void ath12k_debugfs_fw_stats_register(struct ath12k *ar)
 {
@@ -257,8 +358,11 @@ void ath12k_debugfs_fw_stats_register(struct ath12k *ar)
 	 */
 	debugfs_create_file("vdev_stats", 0600, fwstats_dir, ar,
 			    &fops_vdev_stats);
+	debugfs_create_file("beacon_stats", 0600, fwstats_dir, ar,
+			    &fops_bcn_stats);
 
 	INIT_LIST_HEAD(&ar->fw_stats.vdevs);
+	INIT_LIST_HEAD(&ar->fw_stats.bcn);
 	init_completion(&ar->fw_stats_complete);
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index b91b4767515a..f84102852438 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6962,6 +6962,45 @@ ath12k_wmi_fw_vdev_stats_dump(struct ath12k *ar,
 	}
 }
 
+static void
+ath12k_wmi_fw_bcn_stats_dump(struct ath12k *ar,
+			     struct ath12k_fw_stats *fw_stats,
+			     char *buf, u32 *length)
+{
+	const struct ath12k_fw_stats_bcn *bcn;
+	u32 buf_len = ATH12K_FW_STATS_BUF_SIZE;
+	struct ath12k_link_vif *arvif;
+	u32 len = *length;
+	size_t num_bcn;
+
+	num_bcn = list_count_nodes(&fw_stats->bcn);
+
+	len += scnprintf(buf + len, buf_len - len, "\n");
+	len += scnprintf(buf + len, buf_len - len, "%30s (%zu)\n",
+			 "ath12k Beacon stats", num_bcn);
+	len += scnprintf(buf + len, buf_len - len, "%30s\n\n",
+			 "===================");
+
+	list_for_each_entry(bcn, &fw_stats->bcn, list) {
+		arvif = ath12k_mac_get_arvif(ar, bcn->vdev_id);
+		if (!arvif)
+			continue;
+		len += scnprintf(buf + len, buf_len - len, "%30s %u\n",
+				 "VDEV ID", bcn->vdev_id);
+		len += scnprintf(buf + len, buf_len - len, "%30s %pM\n",
+				 "VDEV MAC address", arvif->ahvif->vif->addr);
+		len += scnprintf(buf + len, buf_len - len, "%30s\n\n",
+				 "================");
+		len += scnprintf(buf + len, buf_len - len, "%30s %u\n",
+				 "Num of beacon tx success", bcn->tx_bcn_succ_cnt);
+		len += scnprintf(buf + len, buf_len - len, "%30s %u\n",
+				 "Num of beacon tx failures", bcn->tx_bcn_outage_cnt);
+
+		len += scnprintf(buf + len, buf_len - len, "\n");
+		*length = len;
+	}
+}
+
 void ath12k_wmi_fw_stats_dump(struct ath12k *ar,
 			      struct ath12k_fw_stats *fw_stats,
 			      u32 stats_id, char *buf)
@@ -6975,6 +7014,9 @@ void ath12k_wmi_fw_stats_dump(struct ath12k *ar,
 	case WMI_REQUEST_VDEV_STAT:
 		ath12k_wmi_fw_vdev_stats_dump(ar, fw_stats, buf, &len);
 		break;
+	case WMI_REQUEST_BCN_STAT:
+		ath12k_wmi_fw_bcn_stats_dump(ar, fw_stats, buf, &len);
+		break;
 	default:
 		break;
 	}
@@ -7026,6 +7068,15 @@ ath12k_wmi_pull_vdev_stats(const struct wmi_vdev_stats_params *src,
 			le32_to_cpu(src->beacon_rssi_history[i]);
 }
 
+static void
+ath12k_wmi_pull_bcn_stats(const struct ath12k_wmi_bcn_stats_params *src,
+			  struct ath12k_fw_stats_bcn *dst)
+{
+	dst->vdev_id = le32_to_cpu(src->vdev_id);
+	dst->tx_bcn_succ_cnt = le32_to_cpu(src->tx_bcn_succ_cnt);
+	dst->tx_bcn_outage_cnt = le32_to_cpu(src->tx_bcn_outage_cnt);
+}
+
 static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 					      struct wmi_tlv_fw_stats_parse *parse,
 					      const void *ptr,
@@ -7042,6 +7093,7 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 	const void *data = ptr;
 
 	INIT_LIST_HEAD(&stats.vdevs);
+	INIT_LIST_HEAD(&stats.bcn);
 
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch update stats ev");
@@ -7096,6 +7148,25 @@ static int ath12k_wmi_tlv_fw_stats_data_parse(struct ath12k_base *ab,
 		stats.stats_id = WMI_REQUEST_VDEV_STAT;
 		list_add_tail(&dst->list, &stats.vdevs);
 	}
+	for (i = 0; i < le32_to_cpu(ev->num_bcn_stats); i++) {
+		const struct ath12k_wmi_bcn_stats_params *src;
+		struct ath12k_fw_stats_bcn *dst;
+
+		src = data;
+		if (len < sizeof(*src)) {
+			ret = -EPROTO;
+			goto exit;
+		}
+
+		data += sizeof(*src);
+		len -= sizeof(*src);
+		dst = kzalloc(sizeof(*dst), GFP_ATOMIC);
+		if (!dst)
+			continue;
+		ath12k_wmi_pull_bcn_stats(src, dst);
+		stats.stats_id = WMI_REQUEST_BCN_STAT;
+		list_add_tail(&dst->list, &stats.bcn);
+	}
 
 	complete(&ar->fw_stats_complete);
 	ath12k_debugfs_fw_stats_process(ar, &stats);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 1c9500594f1d..ec2664c62e53 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -5665,6 +5665,7 @@ struct wmi_stats_event {
 
 enum wmi_stats_id {
 	WMI_REQUEST_VDEV_STAT	= BIT(3),
+	WMI_REQUEST_BCN_STAT	= BIT(11),
 };
 
 struct wmi_request_stats_cmd {
@@ -5695,6 +5696,12 @@ struct wmi_vdev_stats_params {
 	__le32 beacon_rssi_history[MAX_TX_RATE_VALUES];
 } __packed;
 
+struct ath12k_wmi_bcn_stats_params {
+	__le32 vdev_id;
+	__le32 tx_bcn_succ_cnt;
+	__le32 tx_bcn_outage_cnt;
+} __packed;
+
 struct ath12k_fw_stats_req_params {
 	u32 stats_id;
 	u32 vdev_id;
-- 
2.34.1



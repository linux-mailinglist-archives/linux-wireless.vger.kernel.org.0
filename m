Return-Path: <linux-wireless+bounces-8996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D739A9083AF
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 08:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 455B4B23A9E
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 06:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFEA148311;
	Fri, 14 Jun 2024 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DicLEOgR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED00144D38
	for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2024 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718346862; cv=none; b=qf8z6/uLCS2mypAV9uWU8G6ieunaqJyfo2nQZfBWMVwJ8voqnGrCfuWtf1noIJAyZSa6gsWoO32yrLkZbiUKituKLg8tgbsGepz6rECFc8eqQhIH3LT5UBSotoE3o5qOjWKLmDyLwRy9Pd17twLB8b/0IiWK8Gsc9Nw00hA9dl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718346862; c=relaxed/simple;
	bh=rAwhKAq/i9OFv+njanY8XYvfB4mxAl1G1pJf6JA5pHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j3nGEfPIeFo8Ai2JdILfnF/p3t5lQzv/SB35iwitcapoUCaIJfL4E6AXuJQWsv+1sP69Fw8dwKz8ebw2hMw0SSIL8yDC7GvMU39Cao7UfHV/UbNvNPUsnvRWMGK1aOdhVICE67sdu+xIuprLQl8ge69qanubsHZzNqc5O/PiPQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DicLEOgR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DJGN7v024639;
	Fri, 14 Jun 2024 06:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=I6c1KFiOQL4
	8HLKny4aLvEjyO/wnXUPz2HKnJM6iV94=; b=DicLEOgRIjh0y+3TCt5q49E2Bo7
	2ih/cTT3eGRmnTjUxSrJ+JEn4TBmyp/lrgMcm0+dhWQ8LqSr7RrrzG9S1JTQpkxQ
	DCu/EHH3yoRI8WbeRwey+KiDKWfw9rIgp0c8X3WlcdamYorVl0SazOwweNPQIoZy
	bo4KESKj1aNIN+OhJW5JI/KsysGpl0tNcar5crPqTPsXX44F5eSAmiEclQ9UeF09
	IJyYBMUxFsgH5DFq45he5W4xuukC3PL+8c2NGlsq3fyetC3C4148Fe128hpuNpf6
	gVg65viWlkTZU2yuVB8DQjoWzOdstveahiL1mk2XWU3afft3AWp1sALgI0g==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yr6q4s5vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 06:34:16 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 45E6YAs9026756;
	Fri, 14 Jun 2024 06:34:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3yn1s6n07m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 06:34:12 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45E6YCmU026781;
	Fri, 14 Jun 2024 06:34:12 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 45E6YCUk026778
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 06:34:12 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id 2B4E14112C; Fri, 14 Jun 2024 12:04:11 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Dinesh Karthikeyan <quic_dinek@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH v5 2/4] wifi: ath12k: Add htt_stats_dump file ops support
Date: Fri, 14 Jun 2024 12:04:02 +0530
Message-Id: <20240614063404.2659089-3-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614063404.2659089-1-quic_rgnanase@quicinc.com>
References: <20240614063404.2659089-1-quic_rgnanase@quicinc.com>
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
X-Proofpoint-ORIG-GUID: lvqvFFOewGylQlspBqTszRMQE9VuRvQK
X-Proofpoint-GUID: lvqvFFOewGylQlspBqTszRMQE9VuRvQK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406140043

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add dump_htt_stats file operation to dump the stats value requested
for the requested stats_type.
Stats sent from firmware will be cumulative. Hence add debugfs to reset
the requested stats type.

Example with one ath12k device:

ath12k
`-- pci-0000:06:00.0
    |-- mac0
        `-- htt_stats
        |-- htt_stats_type
        |-- htt_stats_reset

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Co-developed-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h        |   2 +
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 205 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  30 +++
 drivers/net/wireless/ath/ath12k/dp_tx.c       |   4 +-
 4 files changed, 240 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index b56088043a43..4a59c702649a 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -476,6 +476,8 @@ struct ath12k_fw_stats {
 struct ath12k_dbg_htt_stats {
 	enum ath12k_dbg_htt_ext_stats_type type;
 	u32 cfg_param[4];
+	u8 reset;
+	struct debug_htt_stats_req *stats_req;
 };
 
 struct ath12k_debug {
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 3124ea345459..9349c7d17395 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -8,6 +8,7 @@
 #include "core.h"
 #include "debug.h"
 #include "debugfs_htt_stats.h"
+#include "dp_tx.h"
 
 static ssize_t ath12k_read_htt_stats_type(struct file *file,
 					  char __user *user_buf,
@@ -76,8 +77,212 @@ static const struct file_operations fops_htt_stats_type = {
 	.llseek = default_llseek,
 };
 
+static int ath12k_debugfs_htt_stats_req(struct ath12k *ar)
+{
+	struct debug_htt_stats_req *stats_req = ar->debug.htt_stats.stats_req;
+	enum ath12k_dbg_htt_ext_stats_type type = stats_req->type;
+	u64 cookie;
+	int ret, pdev_id;
+	struct htt_ext_stats_cfg_params cfg_params = { 0 };
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	init_completion(&stats_req->htt_stats_rcvd);
+
+	pdev_id = ath12k_mac_get_target_pdev_id(ar);
+	stats_req->done = false;
+	stats_req->pdev_id = pdev_id;
+
+	cookie = u64_encode_bits(ATH12K_HTT_STATS_MAGIC_VALUE,
+				 ATH12K_HTT_STATS_COOKIE_MSB);
+	cookie |= u64_encode_bits(pdev_id, ATH12K_HTT_STATS_COOKIE_LSB);
+
+	if (stats_req->override_cfg_param) {
+		cfg_params.cfg0 = stats_req->cfg_param[0];
+		cfg_params.cfg1 = stats_req->cfg_param[1];
+		cfg_params.cfg2 = stats_req->cfg_param[2];
+		cfg_params.cfg3 = stats_req->cfg_param[3];
+	}
+
+	ret = ath12k_dp_tx_htt_h2t_ext_stats_req(ar, type, &cfg_params, cookie);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to send htt stats request: %d\n", ret);
+		return ret;
+	}
+	if (!wait_for_completion_timeout(&stats_req->htt_stats_rcvd, 3 * HZ)) {
+		spin_lock_bh(&ar->data_lock);
+		if (!stats_req->done) {
+			stats_req->done = true;
+			spin_unlock_bh(&ar->data_lock);
+			ath12k_warn(ar->ab, "stats request timed out\n");
+			return -ETIMEDOUT;
+		}
+		spin_unlock_bh(&ar->data_lock);
+	}
+
+	return 0;
+}
+
+static int ath12k_open_htt_stats(struct inode *inode,
+				 struct file *file)
+{
+	struct ath12k *ar = inode->i_private;
+	struct debug_htt_stats_req *stats_req;
+	enum ath12k_dbg_htt_ext_stats_type type = ar->debug.htt_stats.type;
+	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
+	int ret;
+
+	if (type == ATH12K_DBG_HTT_EXT_STATS_RESET)
+		return -EPERM;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (ah->state != ATH12K_HW_STATE_ON) {
+		ret = -ENETDOWN;
+		goto err_unlock;
+	}
+
+	if (ar->debug.htt_stats.stats_req) {
+		ret = -EAGAIN;
+		goto err_unlock;
+	}
+
+	stats_req = kzalloc(sizeof(*stats_req) + ATH12K_HTT_STATS_BUF_SIZE, GFP_KERNEL);
+	if (!stats_req) {
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
+
+	ar->debug.htt_stats.stats_req = stats_req;
+	stats_req->type = type;
+	stats_req->cfg_param[0] = ar->debug.htt_stats.cfg_param[0];
+	stats_req->cfg_param[1] = ar->debug.htt_stats.cfg_param[1];
+	stats_req->cfg_param[2] = ar->debug.htt_stats.cfg_param[2];
+	stats_req->cfg_param[3] = ar->debug.htt_stats.cfg_param[3];
+	stats_req->override_cfg_param = !!stats_req->cfg_param[0] ||
+					!!stats_req->cfg_param[1] ||
+					!!stats_req->cfg_param[2] ||
+					!!stats_req->cfg_param[3];
+
+	ret = ath12k_debugfs_htt_stats_req(ar);
+	if (ret < 0)
+		goto out;
+
+	file->private_data = stats_req;
+
+	mutex_unlock(&ar->conf_mutex);
+
+	return 0;
+out:
+	kfree(stats_req);
+	ar->debug.htt_stats.stats_req = NULL;
+err_unlock:
+	mutex_unlock(&ar->conf_mutex);
+
+	return ret;
+}
+
+static int ath12k_release_htt_stats(struct inode *inode,
+				    struct file *file)
+{
+	struct ath12k *ar = inode->i_private;
+
+	mutex_lock(&ar->conf_mutex);
+	kfree(file->private_data);
+	ar->debug.htt_stats.stats_req = NULL;
+	mutex_unlock(&ar->conf_mutex);
+
+	return 0;
+}
+
+static ssize_t ath12k_read_htt_stats(struct file *file,
+				     char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct debug_htt_stats_req *stats_req = file->private_data;
+	char *buf;
+	u32 length;
+
+	buf = stats_req->buf;
+	length = min_t(u32, stats_req->buf_len, ATH12K_HTT_STATS_BUF_SIZE);
+	return simple_read_from_buffer(user_buf, count, ppos, buf, length);
+}
+
+static const struct file_operations fops_dump_htt_stats = {
+	.open = ath12k_open_htt_stats,
+	.release = ath12k_release_htt_stats,
+	.read = ath12k_read_htt_stats,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static ssize_t ath12k_write_htt_stats_reset(struct file *file,
+					    const char __user *user_buf,
+					    size_t count, loff_t *ppos)
+{
+	struct ath12k *ar = file->private_data;
+	enum ath12k_dbg_htt_ext_stats_type type;
+	struct htt_ext_stats_cfg_params cfg_params = { 0 };
+	u8 param_pos;
+	int ret;
+
+	ret = kstrtou32_from_user(user_buf, count, 0, &type);
+	if (ret)
+		return ret;
+
+	if (type >= ATH12K_DBG_HTT_NUM_EXT_STATS ||
+	    type == ATH12K_DBG_HTT_EXT_STATS_RESET)
+		return -E2BIG;
+
+	mutex_lock(&ar->conf_mutex);
+	cfg_params.cfg0 = HTT_STAT_DEFAULT_RESET_START_OFFSET;
+	param_pos = (type >> 5) + 1;
+
+	switch (param_pos) {
+	case ATH12K_HTT_STATS_RESET_PARAM_CFG_32_BYTES:
+		cfg_params.cfg1 = 1 << (cfg_params.cfg0 + type);
+		break;
+	case ATH12K_HTT_STATS_RESET_PARAM_CFG_64_BYTES:
+		cfg_params.cfg2 = ATH12K_HTT_STATS_RESET_BITMAP32_BIT(cfg_params.cfg0 +
+								      type);
+		break;
+	case ATH12K_HTT_STATS_RESET_PARAM_CFG_128_BYTES:
+		cfg_params.cfg3 = ATH12K_HTT_STATS_RESET_BITMAP64_BIT(cfg_params.cfg0 +
+								      type);
+		break;
+	default:
+		break;
+	}
+
+	ret = ath12k_dp_tx_htt_h2t_ext_stats_req(ar,
+						 ATH12K_DBG_HTT_EXT_STATS_RESET,
+						 &cfg_params,
+						 0ULL);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to send htt stats request: %d\n", ret);
+		mutex_unlock(&ar->conf_mutex);
+		return ret;
+	}
+
+	ar->debug.htt_stats.reset = type;
+	mutex_unlock(&ar->conf_mutex);
+
+	return count;
+}
+
+static const struct file_operations fops_htt_stats_reset = {
+	.write = ath12k_write_htt_stats_reset,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
 void ath12k_debugfs_htt_stats_register(struct ath12k *ar)
 {
 	debugfs_create_file("htt_stats_type", 0600, ar->debug.debugfs_pdev,
 			    ar, &fops_htt_stats_type);
+	debugfs_create_file("htt_stats", 0400, ar->debug.debugfs_pdev,
+			    ar, &fops_dump_htt_stats);
+	debugfs_create_file("htt_stats_reset", 0200, ar->debug.debugfs_pdev,
+			    ar, &fops_htt_stats_reset);
 }
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 8610db89289a..252c59f5eac8 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -7,6 +7,18 @@
 #ifndef DEBUG_HTT_STATS_H
 #define DEBUG_HTT_STATS_H
 
+#define ATH12K_HTT_STATS_BUF_SIZE		(1024 * 512)
+#define ATH12K_HTT_STATS_COOKIE_LSB		GENMASK_ULL(31, 0)
+#define ATH12K_HTT_STATS_COOKIE_MSB		GENMASK_ULL(63, 32)
+#define ATH12K_HTT_STATS_MAGIC_VALUE		0xF0F0F0F0
+
+#define ATH12K_HTT_STATS_RESET_BITMAP32_OFFSET(_idx)	((_idx) & 0x1f)
+#define ATH12K_HTT_STATS_RESET_BITMAP64_OFFSET(_idx)	((_idx) & 0x3f)
+#define ATH12K_HTT_STATS_RESET_BITMAP32_BIT(_idx)	(1 << \
+		ATH12K_HTT_STATS_RESET_BITMAP32_OFFSET(_idx))
+#define ATH12K_HTT_STATS_RESET_BITMAP64_BIT(_idx)	(1 << \
+		ATH12K_HTT_STATS_RESET_BITMAP64_OFFSET(_idx))
+
 void ath12k_debugfs_htt_stats_register(struct ath12k *ar);
 
 /* htt_dbg_ext_stats_type */
@@ -17,4 +29,22 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
 };
 
+enum ath12k_htt_stats_reset_cfg_param_alloc_pos {
+	ATH12K_HTT_STATS_RESET_PARAM_CFG_32_BYTES = 1,
+	ATH12K_HTT_STATS_RESET_PARAM_CFG_64_BYTES,
+	ATH12K_HTT_STATS_RESET_PARAM_CFG_128_BYTES,
+};
+
+struct debug_htt_stats_req {
+	bool done;
+	bool override_cfg_param;
+	u8 pdev_id;
+	enum ath12k_dbg_htt_ext_stats_type type;
+	u32 cfg_param[4];
+	u8 peer_addr[ETH_ALEN];
+	struct completion htt_stats_rcvd;
+	u32 buf_len;
+	u8 buf[];
+};
+
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index c4cfa7cf7cb9..d08c04343e90 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -1086,6 +1086,7 @@ ath12k_dp_tx_htt_h2t_ext_stats_req(struct ath12k *ar, u8 type,
 	struct htt_ext_stats_cfg_cmd *cmd;
 	int len = sizeof(*cmd);
 	int ret;
+	u32 pdev_id;
 
 	skb = ath12k_htc_alloc_skb(ab, len);
 	if (!skb)
@@ -1097,7 +1098,8 @@ ath12k_dp_tx_htt_h2t_ext_stats_req(struct ath12k *ar, u8 type,
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->hdr.msg_type = HTT_H2T_MSG_TYPE_EXT_STATS_CFG;
 
-	cmd->hdr.pdev_mask = 1 << ar->pdev->pdev_id;
+	pdev_id = ath12k_mac_get_target_pdev_id(ar);
+	cmd->hdr.pdev_mask = 1 << pdev_id;
 
 	cmd->hdr.stats_type = type;
 	cmd->cfg_param0 = cpu_to_le32(cfg_params->cfg0);
-- 
2.34.1



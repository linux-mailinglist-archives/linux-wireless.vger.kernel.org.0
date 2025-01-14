Return-Path: <linux-wireless+bounces-17498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04861A1083E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 14:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E15F7A3852
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 13:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5343435972;
	Tue, 14 Jan 2025 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mpZOot9C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B9B4D599
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863062; cv=none; b=HhDOKo+rTSkuv2JTvysfJwD4W9yvhkQlN2ZwynnicVMOAuJZ86LBBNKB/jew52Zj7sybhlSO1JuDEFdB9FfqmKmABERBe0udPFwjvjY2sLvG+8uuk/njm9dn4B3HmFydLu9DRKrRP321stBBoel3PR9wQnOEbEM9801L2CSqsSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863062; c=relaxed/simple;
	bh=8Po1KMS1ntq6YDzdrbq9FWNiUYWBrpoFAEG4vF7XYRI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LphZXDUwBKbsNWAAHw3iKHGFBdObGjFwd1SVCl49hutThgrZQS7fb/qF1U8iXy97w6beywK1pzV39rVww0ha2fsux42MlIa7gsMLP4FNCUHcmlZ4aLs6QB57uNJZcxsZSyCgc4pjaKIs/TSLcdHloXEeTtukcql41YWnXhMYEfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mpZOot9C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EA2Y1O005718;
	Tue, 14 Jan 2025 13:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QaSo2T6KCUGhJg6Hm1OvNRpqdmGZA3vlb0PI1G5Nesc=; b=mpZOot9CGTm/CaHr
	PesEaofPDEVI0RcGifjrv/wrPurHXDjU7Aco2e6A/JkZNO/lNfYvXT1FN8X3977K
	OrJsY2zQzd9Z8fwhIyMPYzo78jfzaOZ2U6kc0nUAWmX4UxVAduD3aS/dCmxFcLKg
	zsW4qe81P3kW7Ef1j/AkAmRm4eCQ+F/PVA2hNK0nCkfIqXgfDX/k6Xpzw1w5sjTp
	rYu433J2XLXc2cuka3fLGtAIwNpSsPEHEs2ZC4mx6Y+3fe67bRQZjGieNwJSp3us
	O5C+A+jKWlYrPrJzfb5gXInrfUBYvZnrC1OoNW5A4l+ENH965PJ5y47Ic7r+1Mzs
	BRTJ/g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 445ntx8f4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 13:57:36 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50EDvaV4001882
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 13:57:36 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 14 Jan 2025 05:57:33 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sowmiya Sree Elavalagan
	<quic_ssreeela@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v3 1/2] wifi: ath12k: Add Support to Parse TPC Event from Firmware
Date: Tue, 14 Jan 2025 19:27:07 +0530
Message-ID: <20250114135708.966170-2-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114135708.966170-1-quic_rdevanat@quicinc.com>
References: <20250114135708.966170-1-quic_rdevanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3y_que8n7N7BYpU9GLcvSW48Q_lUnRvs
X-Proofpoint-GUID: 3y_que8n7N7BYpU9GLcvSW48Q_lUnRvs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140112

From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>

Host receives four Transmit Power Control(TPC) events from firmware on
sending TPC request. Fixed param TLV is present as part of all event to
indicate the event count and end of event. TPC config parameters along
with regulatory power array comes as first event. Rates array comes as
second and third event as it cannot be packed in single event.
Conformance Test Limit (CTL) power array comes as the fourth event.
Firmware packs different sets of array params which includes array
length and type inside master TLV as different subtlvs. And the actual
content of array is packed one after the other inside a separate TLV as
single buffer.

Parse various events and save it in local structures. Create tpc_stats
file using debugfs to store these local structures. Create function to
handle TPC stats read to relay the information to the user.

Command usage:
echo 1 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/tpc_stats_type

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Co-developed-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Co-developed-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h    |   4 +
 drivers/net/wireless/ath/ath12k/debugfs.c |  97 +++++
 drivers/net/wireless/ath/ath12k/debugfs.h |   6 +
 drivers/net/wireless/ath/ath12k/wmi.c     | 458 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h     | 138 +++++++
 5 files changed, 703 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 3dd01ad100c5..8521b641fa8a 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -559,6 +559,10 @@ struct ath12k_debug {
 	struct dentry *debugfs_pdev;
 	struct dentry *debugfs_pdev_symlink;
 	struct ath12k_dbg_htt_stats htt_stats;
+	enum wmi_halphy_ctrl_path_stats_id tpc_stats_type;
+	bool tpc_request;
+	struct completion tpc_complete;
+	struct wmi_tpc_stats_info *tpc_stats;
 };
 
 struct ath12k_per_peer_tx_stats {
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index d4b32d1a431c..dcfab65053a5 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -5,6 +5,7 @@
  */
 
 #include "core.h"
+#include "debug.h"
 #include "debugfs.h"
 #include "debugfs_htt_stats.h"
 
@@ -31,6 +32,99 @@ static const struct file_operations fops_simulate_radar = {
 	.open = simple_open
 };
 
+static int ath12k_debug_tpc_stats_request(struct ath12k *ar)
+{
+	enum wmi_halphy_ctrl_path_stats_id tpc_stats_sub_id;
+	struct ath12k_base *ab = ar->ab;
+	int ret;
+
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	reinit_completion(&ar->debug.tpc_complete);
+
+	spin_lock_bh(&ar->data_lock);
+	ar->debug.tpc_request = true;
+	tpc_stats_sub_id = ar->debug.tpc_stats_type;
+	spin_unlock_bh(&ar->data_lock);
+
+	ret = ath12k_wmi_send_tpc_stats_request(ar, tpc_stats_sub_id);
+	if (ret) {
+		ath12k_warn(ab, "failed to request pdev tpc stats: %d\n", ret);
+		spin_lock_bh(&ar->data_lock);
+		ar->debug.tpc_request = false;
+		spin_unlock_bh(&ar->data_lock);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ath12k_open_tpc_stats(struct inode *inode, struct file *file)
+{
+	struct ath12k *ar = inode->i_private;
+	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
+	int ret;
+
+	guard(wiphy)(ath12k_ar_to_hw(ar)->wiphy);
+
+	if (ah->state != ATH12K_HW_STATE_ON) {
+		ath12k_warn(ar->ab, "Interface not up\n");
+		return -ENETDOWN;
+	}
+
+	void *buf __free(kfree) = kzalloc(ATH12K_TPC_STATS_BUF_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ath12k_debug_tpc_stats_request(ar);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to request tpc stats: %d\n",
+			    ret);
+		return ret;
+	}
+
+	if (!wait_for_completion_timeout(&ar->debug.tpc_complete, TPC_STATS_WAIT_TIME)) {
+		spin_lock_bh(&ar->data_lock);
+		ath12k_wmi_free_tpc_stats_mem(ar);
+		ar->debug.tpc_request = false;
+		spin_unlock_bh(&ar->data_lock);
+		return -ETIMEDOUT;
+	}
+
+	file->private_data = no_free_ptr(buf);
+
+	spin_lock_bh(&ar->data_lock);
+	ath12k_wmi_free_tpc_stats_mem(ar);
+	spin_unlock_bh(&ar->data_lock);
+
+	return 0;
+}
+
+static ssize_t ath12k_read_tpc_stats(struct file *file,
+				     char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	const char *buf = file->private_data;
+	size_t len = strlen(buf);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static int ath12k_release_tpc_stats(struct inode *inode,
+				    struct file *file)
+{
+	kfree(file->private_data);
+	return 0;
+}
+
+static const struct file_operations fops_tpc_stats = {
+	.open = ath12k_open_tpc_stats,
+	.release = ath12k_release_tpc_stats,
+	.read = ath12k_read_tpc_stats,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
 void ath12k_debugfs_soc_create(struct ath12k_base *ab)
 {
 	bool dput_needed;
@@ -91,6 +185,9 @@ void ath12k_debugfs_register(struct ath12k *ar)
 				    &fops_simulate_radar);
 	}
 
+	debugfs_create_file("tpc_stats", 0400, ar->debug.debugfs_pdev, ar,
+			    &fops_tpc_stats);
+
 	ath12k_debugfs_htt_stats_register(ar);
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.h b/drivers/net/wireless/ath/ath12k/debugfs.h
index 8d64ba03aa9a..d086dd1d5011 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs.h
@@ -12,6 +12,12 @@ void ath12k_debugfs_soc_create(struct ath12k_base *ab);
 void ath12k_debugfs_soc_destroy(struct ath12k_base *ab);
 void ath12k_debugfs_register(struct ath12k *ar);
 void ath12k_debugfs_unregister(struct ath12k *ar);
+
+#define TPC_STATS_WAIT_TIME		(1 * HZ)
+#define TPC_STATS_TOT_ROW		700
+#define TPC_STATS_TOT_COLUMN		100
+#define ATH12K_TPC_STATS_BUF_SIZE	(TPC_STATS_TOT_ROW * TPC_STATS_TOT_COLUMN)
+
 #else
 static inline void ath12k_debugfs_soc_create(struct ath12k_base *ab)
 {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 4dd6cdf84571..a0f449949aa6 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7417,6 +7417,389 @@ static void ath12k_wmi_event_teardown_complete(struct ath12k_base *ab,
 	kfree(tb);
 }
 
+#ifdef CONFIG_ATH12K_DEBUGFS
+static int ath12k_wmi_tpc_stats_copy_buffer(struct ath12k_base *ab,
+					    const void *ptr, u16 tag, u16 len,
+					    struct wmi_tpc_stats_info *tpc_stats)
+{
+	u32 len1, len2, len3, len4;
+	s16 *dst_ptr;
+	s8 *dst_ptr_ctl;
+
+	len1 = le32_to_cpu(tpc_stats->max_reg_allowed_power.tpc_reg_pwr.reg_array_len);
+	len2 = le32_to_cpu(tpc_stats->rates_array1.tpc_rates_array.rate_array_len);
+	len3 = le32_to_cpu(tpc_stats->rates_array2.tpc_rates_array.rate_array_len);
+	len4 = le32_to_cpu(tpc_stats->ctl_array.tpc_ctl_pwr.ctl_array_len);
+
+	switch (tpc_stats->event_count) {
+	case ATH12K_TPC_STATS_CONFIG_REG_PWR_EVENT:
+		if (len1 > len)
+			return -ENOBUFS;
+
+		if (tpc_stats->tlvs_rcvd & WMI_TPC_REG_PWR_ALLOWED) {
+			dst_ptr = tpc_stats->max_reg_allowed_power.reg_pwr_array;
+			memcpy(dst_ptr, ptr, len1);
+		}
+		break;
+	case ATH12K_TPC_STATS_RATES_EVENT1:
+		if (len2 > len)
+			return -ENOBUFS;
+
+		if (tpc_stats->tlvs_rcvd & WMI_TPC_RATES_ARRAY1) {
+			dst_ptr = tpc_stats->rates_array1.rate_array;
+			memcpy(dst_ptr, ptr, len2);
+		}
+		break;
+	case ATH12K_TPC_STATS_RATES_EVENT2:
+		if (len3 > len)
+			return -ENOBUFS;
+
+		if (tpc_stats->tlvs_rcvd & WMI_TPC_RATES_ARRAY2) {
+			dst_ptr = tpc_stats->rates_array2.rate_array;
+			memcpy(dst_ptr, ptr, len3);
+		}
+		break;
+	case ATH12K_TPC_STATS_CTL_TABLE_EVENT:
+		if (len4 > len)
+			return -ENOBUFS;
+
+		if (tpc_stats->tlvs_rcvd & WMI_TPC_CTL_PWR_ARRAY) {
+			dst_ptr_ctl = tpc_stats->ctl_array.ctl_pwr_table;
+			memcpy(dst_ptr_ctl, ptr, len4);
+		}
+		break;
+	}
+	return 0;
+}
+
+static int ath12k_tpc_get_reg_pwr(struct ath12k_base *ab,
+				  struct wmi_tpc_stats_info *tpc_stats,
+				  struct wmi_max_reg_power_fixed_params *ev)
+{
+	struct wmi_max_reg_power_allowed_params *reg_pwr;
+	u32 total_size;
+
+	ath12k_dbg(ab, ATH12K_DBG_WMI,
+		   "Received reg power array type %d length %d for tpc stats\n",
+		   ev->reg_power_type, ev->reg_array_len);
+
+	switch (le32_to_cpu(ev->reg_power_type)) {
+	case TPC_STATS_REG_PWR_ALLOWED_TYPE:
+		reg_pwr = &tpc_stats->max_reg_allowed_power;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Each entry is 2 byte hence multiplying the indices with 2 */
+	total_size = le32_to_cpu(ev->d1) * le32_to_cpu(ev->d2) *
+		     le32_to_cpu(ev->d3) * le32_to_cpu(ev->d4) * 2;
+	if (le32_to_cpu(ev->reg_array_len) != total_size) {
+		ath12k_warn(ab,
+			    "Total size and reg_array_len doesn't match for tpc stats\n");
+		return -EINVAL;
+	}
+
+	memcpy(&reg_pwr->tpc_reg_pwr, ev, sizeof(struct wmi_max_reg_power_fixed_params));
+
+	reg_pwr->reg_pwr_array = kzalloc(le32_to_cpu(reg_pwr->tpc_reg_pwr.reg_array_len),
+					 GFP_ATOMIC);
+	if (!reg_pwr->reg_pwr_array)
+		return -ENOMEM;
+
+	tpc_stats->tlvs_rcvd |= WMI_TPC_REG_PWR_ALLOWED;
+
+	return 0;
+}
+
+static int ath12k_tpc_get_rate_array(struct ath12k_base *ab,
+				     struct wmi_tpc_stats_info *tpc_stats,
+				     struct wmi_tpc_rates_array_fixed_params *ev)
+{
+	struct wmi_tpc_rates_array_params *rates_array;
+	u32 flag = 0, rate_array_len;
+
+	ath12k_dbg(ab, ATH12K_DBG_WMI,
+		   "Received rates array type %d length %d for tpc stats\n",
+		   ev->rate_array_type, ev->rate_array_len);
+
+	switch (le32_to_cpu(ev->rate_array_type)) {
+	case ATH12K_TPC_STATS_RATES_ARRAY1:
+		rates_array = &tpc_stats->rates_array1;
+		flag = WMI_TPC_RATES_ARRAY1;
+		break;
+	case ATH12K_TPC_STATS_RATES_ARRAY2:
+		rates_array = &tpc_stats->rates_array2;
+		flag = WMI_TPC_RATES_ARRAY2;
+		break;
+	default:
+		ath12k_warn(ab,
+			    "Received invalid type of rates array for tpc stats\n");
+		return -EINVAL;
+	}
+	memcpy(&rates_array->tpc_rates_array, ev,
+	       sizeof(struct wmi_tpc_rates_array_fixed_params));
+	rate_array_len = le32_to_cpu(rates_array->tpc_rates_array.rate_array_len);
+	rates_array->rate_array = kzalloc(rate_array_len, GFP_ATOMIC);
+	if (!rates_array->rate_array)
+		return -ENOMEM;
+
+	tpc_stats->tlvs_rcvd |= flag;
+	return 0;
+}
+
+static int ath12k_tpc_get_ctl_pwr_tbl(struct ath12k_base *ab,
+				      struct wmi_tpc_stats_info *tpc_stats,
+				      struct wmi_tpc_ctl_pwr_fixed_params *ev)
+{
+	struct wmi_tpc_ctl_pwr_table_params *ctl_array;
+	u32 total_size, ctl_array_len, flag = 0;
+
+	ath12k_dbg(ab, ATH12K_DBG_WMI,
+		   "Received ctl array type %d length %d for tpc stats\n",
+		   ev->ctl_array_type, ev->ctl_array_len);
+
+	switch (le32_to_cpu(ev->ctl_array_type)) {
+	case ATH12K_TPC_STATS_CTL_ARRAY:
+		ctl_array = &tpc_stats->ctl_array;
+		flag = WMI_TPC_CTL_PWR_ARRAY;
+		break;
+	default:
+		ath12k_warn(ab,
+			    "Received invalid type of ctl pwr table for tpc stats\n");
+		return -EINVAL;
+	}
+
+	total_size = le32_to_cpu(ev->d1) * le32_to_cpu(ev->d2) *
+		     le32_to_cpu(ev->d3) * le32_to_cpu(ev->d4);
+	if (le32_to_cpu(ev->ctl_array_len) != total_size) {
+		ath12k_warn(ab,
+			    "Total size and ctl_array_len doesn't match for tpc stats\n");
+		return -EINVAL;
+	}
+
+	memcpy(&ctl_array->tpc_ctl_pwr, ev, sizeof(struct wmi_tpc_ctl_pwr_fixed_params));
+	ctl_array_len = le32_to_cpu(ctl_array->tpc_ctl_pwr.ctl_array_len);
+	ctl_array->ctl_pwr_table = kzalloc(ctl_array_len, GFP_ATOMIC);
+	if (!ctl_array->ctl_pwr_table)
+		return -ENOMEM;
+
+	tpc_stats->tlvs_rcvd |= flag;
+	return 0;
+}
+
+static int ath12k_wmi_tpc_stats_subtlv_parser(struct ath12k_base *ab,
+					      u16 tag, u16 len,
+					      const void *ptr, void *data)
+{
+	struct wmi_tpc_rates_array_fixed_params *tpc_rates_array;
+	struct wmi_max_reg_power_fixed_params *tpc_reg_pwr;
+	struct wmi_tpc_ctl_pwr_fixed_params *tpc_ctl_pwr;
+	struct wmi_tpc_stats_info *tpc_stats = data;
+	struct wmi_tpc_config_params *tpc_config;
+	int ret = 0;
+
+	if (!tpc_stats) {
+		ath12k_warn(ab, "tpc stats memory unavailable\n");
+		return -EINVAL;
+	}
+
+	switch (tag) {
+	case WMI_TAG_TPC_STATS_CONFIG_EVENT:
+		tpc_config = (struct wmi_tpc_config_params *)ptr;
+		memcpy(&tpc_stats->tpc_config, tpc_config,
+		       sizeof(struct wmi_tpc_config_params));
+		break;
+
+	case WMI_TAG_TPC_STATS_REG_PWR_ALLOWED:
+		tpc_reg_pwr = (struct wmi_max_reg_power_fixed_params *)ptr;
+		ret = ath12k_tpc_get_reg_pwr(ab, tpc_stats, tpc_reg_pwr);
+		break;
+	case WMI_TAG_TPC_STATS_RATES_ARRAY:
+		tpc_rates_array = (struct wmi_tpc_rates_array_fixed_params *)ptr;
+		ret = ath12k_tpc_get_rate_array(ab, tpc_stats, tpc_rates_array);
+		break;
+
+	case WMI_TAG_TPC_STATS_CTL_PWR_TABLE_EVENT:
+		tpc_ctl_pwr = (struct wmi_tpc_ctl_pwr_fixed_params *)ptr;
+		ret = ath12k_tpc_get_ctl_pwr_tbl(ab, tpc_stats, tpc_ctl_pwr);
+		break;
+
+	default:
+		ath12k_warn(ab,
+			    "Received invalid tag for tpc stats in subtlvs\n");
+		return -EINVAL;
+	}
+	return ret;
+}
+
+static int ath12k_wmi_tpc_stats_event_parser(struct ath12k_base *ab,
+					     u16 tag, u16 len,
+					     const void *ptr, void *data)
+{
+	struct wmi_tpc_stats_info *tpc_stats = (struct wmi_tpc_stats_info *)data;
+	int ret;
+
+	switch (tag) {
+	case WMI_TAG_HALPHY_CTRL_PATH_EVENT_FIXED_PARAM:
+		ret = 0;
+		/* Fixed param is already processed*/
+		break;
+	case WMI_TAG_ARRAY_STRUCT:
+		/* len 0 is expected for array of struct when there
+		 * is no content of that type to pack inside that tlv
+		 */
+		if (len == 0)
+			return 0;
+		ret = ath12k_wmi_tlv_iter(ab, ptr, len,
+					  ath12k_wmi_tpc_stats_subtlv_parser,
+					  tpc_stats);
+		break;
+	case WMI_TAG_ARRAY_INT16:
+		if (len == 0)
+			return 0;
+		ret = ath12k_wmi_tpc_stats_copy_buffer(ab, ptr,
+						       WMI_TAG_ARRAY_INT16,
+						       len, tpc_stats);
+		break;
+	case WMI_TAG_ARRAY_BYTE:
+		if (len == 0)
+			return 0;
+		ret = ath12k_wmi_tpc_stats_copy_buffer(ab, ptr,
+						       WMI_TAG_ARRAY_BYTE,
+						       len, tpc_stats);
+		break;
+	default:
+		ath12k_warn(ab, "Received invalid tag for tpc stats\n");
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+void ath12k_wmi_free_tpc_stats_mem(struct ath12k *ar)
+{
+	struct wmi_tpc_stats_info *tpc_stats = ar->debug.tpc_stats;
+
+	lockdep_assert_held(&ar->data_lock);
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "tpc stats mem free\n");
+	if (tpc_stats) {
+		kfree(tpc_stats->max_reg_allowed_power.reg_pwr_array);
+		kfree(tpc_stats->rates_array1.rate_array);
+		kfree(tpc_stats->rates_array2.rate_array);
+		kfree(tpc_stats->ctl_array.ctl_pwr_table);
+		kfree(tpc_stats);
+		ar->debug.tpc_stats = NULL;
+	}
+}
+
+static void ath12k_process_tpc_stats(struct ath12k_base *ab,
+				     struct sk_buff *skb)
+{
+	struct ath12k_wmi_pdev_tpc_stats_event_fixed_params *fixed_param;
+	struct wmi_tpc_stats_info *tpc_stats;
+	const struct wmi_tlv *tlv;
+	void *ptr = skb->data;
+	struct ath12k *ar;
+	u16 tlv_tag;
+	u32 event_count;
+	int ret;
+
+	if (!skb->data) {
+		ath12k_warn(ab, "No data present in tpc stats event\n");
+		return;
+	}
+
+	if (skb->len < (sizeof(*fixed_param) + TLV_HDR_SIZE)) {
+		ath12k_warn(ab, "TPC stats event size invalid\n");
+		return;
+	}
+
+	tlv = (struct wmi_tlv *)ptr;
+	tlv_tag = le32_get_bits(tlv->header, WMI_TLV_TAG);
+	ptr += sizeof(*tlv);
+
+	if (tlv_tag != WMI_TAG_HALPHY_CTRL_PATH_EVENT_FIXED_PARAM) {
+		ath12k_warn(ab, "TPC stats without fixed param tlv at start\n");
+		return;
+	}
+
+	fixed_param = (struct ath12k_wmi_pdev_tpc_stats_event_fixed_params *)ptr;
+	rcu_read_lock();
+	ar = ath12k_mac_get_ar_by_pdev_id(ab, le32_to_cpu(fixed_param->pdev_id) + 1);
+	if (!ar) {
+		ath12k_warn(ab, "Failed to get ar for tpc stats\n");
+		rcu_read_unlock();
+		return;
+	}
+	spin_lock_bh(&ar->data_lock);
+	if (!ar->debug.tpc_request) {
+		/* Event is received either without request or the
+		 * timeout, if memory is already allocated free it
+		 */
+		if (ar->debug.tpc_stats) {
+			ath12k_warn(ab, "Freeing memory for tpc_stats\n");
+			ath12k_wmi_free_tpc_stats_mem(ar);
+		}
+		goto unlock;
+	}
+
+	event_count = le32_to_cpu(fixed_param->event_count);
+	if (event_count == 0) {
+		if (ar->debug.tpc_stats) {
+			ath12k_warn(ab,
+				    "Invalid tpc memory present\n");
+			goto unlock;
+		}
+		ar->debug.tpc_stats =
+			kzalloc(sizeof(struct wmi_tpc_stats_info),
+				GFP_ATOMIC);
+		if (!ar->debug.tpc_stats) {
+			ath12k_warn(ab,
+				    "Failed to allocate memory for tpc stats\n");
+			goto unlock;
+		}
+	}
+
+	tpc_stats = ar->debug.tpc_stats;
+
+	if (!(event_count == 0)) {
+		if (event_count != tpc_stats->event_count + 1) {
+			ath12k_warn(ab,
+				    "Invalid tpc event received\n");
+			goto unlock;
+		}
+	}
+	tpc_stats->pdev_id = le32_to_cpu(fixed_param->pdev_id);
+	tpc_stats->end_of_event = le32_to_cpu(fixed_param->end_of_event);
+	tpc_stats->event_count = le32_to_cpu(fixed_param->event_count);
+	ath12k_dbg(ab, ATH12K_DBG_WMI,
+		   "tpc stats event_count %d\n",
+		   tpc_stats->event_count);
+	ret = ath12k_wmi_tlv_iter(ab, skb->data, skb->len,
+				  ath12k_wmi_tpc_stats_event_parser,
+				  tpc_stats);
+	if (ret) {
+		if (tpc_stats)
+			ath12k_wmi_free_tpc_stats_mem(ar);
+		ath12k_warn(ab, "failed to parse tpc_stats tlv: %d\n", ret);
+		goto unlock;
+	}
+
+	if (tpc_stats && tpc_stats->end_of_event)
+		complete(&ar->debug.tpc_complete);
+
+unlock:
+	spin_unlock_bh(&ar->data_lock);
+	rcu_read_unlock();
+}
+#else
+static void ath12k_process_tpc_stats(struct ath12k_base *ab,
+				     struct sk_buff *skb)
+{
+}
+#endif
+
 static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_cmd_hdr *cmd_hdr;
@@ -7555,6 +7938,9 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 	case WMI_OBSS_COLOR_COLLISION_DETECTION_EVENTID:
 		/* debug might flood hence silently ignore (no-op) */
 		break;
+	case WMI_HALPHY_STATS_CTRL_PATH_EVENTID:
+		ath12k_process_tpc_stats(ab, skb);
+		break;
 	/* TODO: Add remaining events */
 	default:
 		ath12k_dbg(ab, ATH12K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
@@ -7692,6 +8078,78 @@ int ath12k_wmi_simulate_radar(struct ath12k *ar)
 	return ath12k_wmi_send_unit_test_cmd(ar, wmi_ut, dfs_args);
 }
 
+int ath12k_wmi_send_tpc_stats_request(struct ath12k *ar,
+				      enum wmi_halphy_ctrl_path_stats_id tpc_stats_type)
+{
+	struct wmi_request_halphy_ctrl_path_stats_cmd_fixed_params *cmd;
+	struct ath12k_wmi_pdev *wmi = ar->wmi;
+	struct sk_buff *skb;
+	struct wmi_tlv *tlv;
+	__le32 *pdev_id;
+	u32 buf_len;
+	void *ptr;
+	int ret;
+
+	buf_len = sizeof(*cmd) +
+		  TLV_HDR_SIZE +
+		  sizeof(u32) +
+		  TLV_HDR_SIZE +
+		  TLV_HDR_SIZE;
+
+	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, buf_len);
+	if (!skb)
+		return -ENOMEM;
+	cmd = (struct wmi_request_halphy_ctrl_path_stats_cmd_fixed_params *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_HALPHY_CTRL_PATH_CMD_FIXED_PARAM,
+						 sizeof(*cmd));
+
+	cmd->stats_id_mask = cpu_to_le32(WMI_REQ_CTRL_PATH_PDEV_TX_STAT);
+	cmd->action = cpu_to_le32(WMI_REQUEST_CTRL_PATH_STAT_GET);
+	cmd->subid = cpu_to_le32(tpc_stats_type);
+
+	ptr = skb->data + sizeof(*cmd);
+
+	/* The below TLV arrays optionally follow this fixed param TLV structure
+	 * 1. ARRAY_UINT32 pdev_ids[]
+	 *      If this array is present and non-zero length, stats should only
+	 *      be provided from the pdevs identified in the array.
+	 * 2. ARRAY_UNIT32 vdev_ids[]
+	 *      If this array is present and non-zero length, stats should only
+	 *      be provided from the vdevs identified in the array.
+	 * 3. ath12k_wmi_mac_addr_params peer_macaddr[];
+	 *      If this array is present and non-zero length, stats should only
+	 *      be provided from the peers with the MAC addresses specified
+	 *      in the array
+	 */
+	tlv = ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_UINT32, sizeof(u32));
+	ptr += TLV_HDR_SIZE;
+
+	pdev_id = ptr;
+	*pdev_id = cpu_to_le32(ath12k_mac_get_target_pdev_id(ar));
+	ptr += sizeof(*pdev_id);
+
+	tlv = ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_UINT32, 0);
+	ptr += TLV_HDR_SIZE;
+
+	tlv = ptr;
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_FIXED_STRUCT, 0);
+	ptr += TLV_HDR_SIZE;
+
+	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_REQUEST_HALPHY_CTRL_PATH_STATS_CMDID);
+	if (ret) {
+		ath12k_warn(ar->ab,
+			    "failed to submit WMI_REQUEST_STATS_CTRL_PATH_CMDID\n");
+		dev_kfree_skb(skb);
+		return ret;
+	}
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "WMI get TPC STATS sent on pdev %d\n",
+		   ar->pdev->pdev_id);
+
+	return ret;
+}
+
 int ath12k_wmi_connect(struct ath12k_base *ab)
 {
 	u32 i;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index b6a197389277..5193f4a7fed1 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -516,6 +516,9 @@ enum wmi_tlv_cmd_id {
 	WMI_REQUEST_RCPI_CMDID,
 	WMI_REQUEST_PEER_STATS_INFO_CMDID,
 	WMI_REQUEST_RADIO_CHAN_STATS_CMDID,
+	WMI_REQUEST_WLM_STATS_CMDID,
+	WMI_REQUEST_CTRL_PATH_STATS_CMDID,
+	WMI_REQUEST_HALPHY_CTRL_PATH_STATS_CMDID = WMI_REQUEST_CTRL_PATH_STATS_CMDID + 3,
 	WMI_SET_ARP_NS_OFFLOAD_CMDID = WMI_TLV_CMD(WMI_GRP_ARP_NS_OFL),
 	WMI_ADD_PROACTIVE_ARP_RSP_PATTERN_CMDID,
 	WMI_DEL_PROACTIVE_ARP_RSP_PATTERN_CMDID,
@@ -785,6 +788,9 @@ enum wmi_tlv_event_id {
 	WMI_UPDATE_RCPI_EVENTID,
 	WMI_PEER_STATS_INFO_EVENTID,
 	WMI_RADIO_CHAN_STATS_EVENTID,
+	WMI_WLM_STATS_EVENTID,
+	WMI_CTRL_PATH_STATS_EVENTID,
+	WMI_HALPHY_STATS_CTRL_PATH_EVENTID,
 	WMI_NLO_MATCH_EVENTID = WMI_TLV_CMD(WMI_GRP_NLO_OFL),
 	WMI_NLO_SCAN_COMPLETE_EVENTID,
 	WMI_APFIND_EVENTID,
@@ -1191,6 +1197,7 @@ enum wmi_tlv_tag {
 	WMI_TAG_ARRAY_BYTE,
 	WMI_TAG_ARRAY_STRUCT,
 	WMI_TAG_ARRAY_FIXED_STRUCT,
+	WMI_TAG_ARRAY_INT16,
 	WMI_TAG_LAST_ARRAY_ENUM = 31,
 	WMI_TAG_SERVICE_READY_EVENT,
 	WMI_TAG_HAL_REG_CAPABILITIES,
@@ -1941,6 +1948,12 @@ enum wmi_tlv_tag {
 	WMI_TAG_MAC_PHY_CAPABILITIES_EXT = 0x36F,
 	WMI_TAG_REGULATORY_RULE_EXT_STRUCT = 0x3A9,
 	WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT,
+	WMI_TAG_TPC_STATS_GET_CMD = 0x38B,
+	WMI_TAG_TPC_STATS_EVENT_FIXED_PARAM,
+	WMI_TAG_TPC_STATS_CONFIG_EVENT,
+	WMI_TAG_TPC_STATS_REG_PWR_ALLOWED,
+	WMI_TAG_TPC_STATS_RATES_ARRAY,
+	WMI_TAG_TPC_STATS_CTL_PWR_TABLE_EVENT,
 	WMI_TAG_EHT_RATE_SET = 0x3C4,
 	WMI_TAG_DCS_AWGN_INT_TYPE = 0x3C5,
 	WMI_TAG_MLO_TX_SEND_PARAMS,
@@ -1958,6 +1971,8 @@ enum wmi_tlv_tag {
 	WMI_TAG_PDEV_SET_BIOS_SAR_TABLE_CMD = 0x3D8,
 	WMI_TAG_PDEV_SET_BIOS_GEO_TABLE_CMD = 0x3D9,
 	WMI_TAG_PDEV_SET_BIOS_INTERFACE_CMD = 0x3FB,
+	WMI_TAG_HALPHY_CTRL_PATH_CMD_FIXED_PARAM = 0x442,
+	WMI_TAG_HALPHY_CTRL_PATH_EVENT_FIXED_PARAM,
 	WMI_TAG_MAX
 };
 
@@ -5629,6 +5644,126 @@ enum wmi_sta_keepalive_method {
 #define WMI_STA_KEEPALIVE_INTERVAL_DEFAULT	30
 #define WMI_STA_KEEPALIVE_INTERVAL_DISABLE	0
 
+#define WMI_REQ_CTRL_PATH_PDEV_TX_STAT		1
+#define WMI_REQUEST_CTRL_PATH_STAT_GET		1
+
+#define WMI_TPC_CONFIG			BIT(1)
+#define WMI_TPC_REG_PWR_ALLOWED		BIT(2)
+#define WMI_TPC_RATES_ARRAY1		BIT(3)
+#define WMI_TPC_RATES_ARRAY2		BIT(4)
+#define WMI_TPC_RATES_DL_OFDMA_ARRAY	BIT(5)
+#define WMI_TPC_CTL_PWR_ARRAY		BIT(6)
+#define WMI_TPC_CONFIG_PARAM		0x1
+#define ATH12K_TPC_RATE_ARRAY_MU	GENMASK(15, 8)
+#define ATH12K_TPC_RATE_ARRAY_SU	GENMASK(7, 0)
+#define TPC_STATS_REG_PWR_ALLOWED_TYPE	0
+
+enum wmi_halphy_ctrl_path_stats_id {
+	WMI_HALPHY_PDEV_TX_SU_STATS = 0,
+	WMI_HALPHY_PDEV_TX_SUTXBF_STATS,
+	WMI_HALPHY_PDEV_TX_MU_STATS,
+	WMI_HALPHY_PDEV_TX_MUTXBF_STATS,
+	WMI_HALPHY_PDEV_TX_STATS_MAX,
+};
+
+enum ath12k_wmi_tpc_stats_rates_array {
+	ATH12K_TPC_STATS_RATES_ARRAY1,
+	ATH12K_TPC_STATS_RATES_ARRAY2,
+};
+
+enum ath12k_wmi_tpc_stats_ctl_array {
+	ATH12K_TPC_STATS_CTL_ARRAY,
+	ATH12K_TPC_STATS_CTL_160ARRAY,
+};
+
+enum ath12k_wmi_tpc_stats_events {
+	ATH12K_TPC_STATS_CONFIG_REG_PWR_EVENT,
+	ATH12K_TPC_STATS_RATES_EVENT1,
+	ATH12K_TPC_STATS_RATES_EVENT2,
+	ATH12K_TPC_STATS_CTL_TABLE_EVENT
+};
+
+struct wmi_request_halphy_ctrl_path_stats_cmd_fixed_params {
+	__le32 tlv_header;
+	__le32 stats_id_mask;
+	__le32 request_id;
+	__le32 action;
+	__le32 subid;
+} __packed;
+
+struct ath12k_wmi_pdev_tpc_stats_event_fixed_params {
+	__le32 pdev_id;
+	__le32 end_of_event;
+	__le32 event_count;
+} __packed;
+
+struct wmi_tpc_config_params {
+	__le32 reg_domain;
+	__le32 chan_freq;
+	__le32 phy_mode;
+	__le32 twice_antenna_reduction;
+	__le32 twice_max_reg_power;
+	__le32 twice_antenna_gain;
+	__le32 power_limit;
+	__le32 rate_max;
+	__le32 num_tx_chain;
+	__le32 ctl;
+	__le32 flags;
+	__le32 caps;
+} __packed;
+
+struct wmi_max_reg_power_fixed_params {
+	__le32 reg_power_type;
+	__le32 reg_array_len;
+	__le32 d1;
+	__le32 d2;
+	__le32 d3;
+	__le32 d4;
+} __packed;
+
+struct wmi_max_reg_power_allowed_params {
+	struct wmi_max_reg_power_fixed_params tpc_reg_pwr;
+	s16 *reg_pwr_array;
+};
+
+struct wmi_tpc_rates_array_fixed_params {
+	__le32 rate_array_type;
+	__le32 rate_array_len;
+} __packed;
+
+struct wmi_tpc_rates_array_params {
+	struct wmi_tpc_rates_array_fixed_params tpc_rates_array;
+	s16 *rate_array;
+};
+
+struct wmi_tpc_ctl_pwr_fixed_params {
+	__le32 ctl_array_type;
+	__le32 ctl_array_len;
+	__le32 end_of_ctl_pwr;
+	__le32 ctl_pwr_count;
+	__le32 d1;
+	__le32 d2;
+	__le32 d3;
+	__le32 d4;
+} __packed;
+
+struct wmi_tpc_ctl_pwr_table_params {
+	struct wmi_tpc_ctl_pwr_fixed_params tpc_ctl_pwr;
+	s8 *ctl_pwr_table;
+};
+
+struct wmi_tpc_stats_info {
+	u32 pdev_id;
+	u32 event_count;
+	u32 end_of_event;
+	u32 tlvs_rcvd;
+	struct wmi_max_reg_power_allowed_params max_reg_allowed_power;
+	struct wmi_tpc_rates_array_params rates_array1;
+	struct wmi_tpc_rates_array_params rates_array2;
+	struct wmi_tpc_config_params tpc_config;
+	struct wmi_tpc_ctl_pwr_table_params ctl_array;
+};
+
 void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
 			     struct ath12k_wmi_resource_config_arg *config);
 void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
@@ -5754,6 +5889,9 @@ int ath12k_wmi_set_bios_cmd(struct ath12k_base *ab, u32 param_id,
 			    const u8 *buf, size_t buf_len);
 int ath12k_wmi_set_bios_sar_cmd(struct ath12k_base *ab, const u8 *psar_table);
 int ath12k_wmi_set_bios_geo_cmd(struct ath12k_base *ab, const u8 *pgeo_table);
+int ath12k_wmi_send_tpc_stats_request(struct ath12k *ar,
+				      enum wmi_halphy_ctrl_path_stats_id tpc_stats_type);
+void ath12k_wmi_free_tpc_stats_mem(struct ath12k *ar);
 
 static inline u32
 ath12k_wmi_caps_ext_get_pdev_id(const struct ath12k_wmi_caps_ext_params *param)
-- 
2.25.1



Return-Path: <linux-wireless+bounces-19177-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3895A3D31E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 09:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 483C87A9941
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 08:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544151EB1B8;
	Thu, 20 Feb 2025 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R6n3QuTM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F78A1E991B
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039909; cv=none; b=Tfmy4t2mk7XF2coLXoRGYxaMjtLT9XLdTlxjPVKbAs8ULV5HZKxk7fyT94MqMsNaqczW1/M4Lh1erpO0en7MIMYPIjK29WYat3304eK6xC5ijQGF+XPloB0SboQwNX+rl4TNy6Nz4O5eOgTKYPGKvn1eiCUE08492bewbYJpfk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039909; c=relaxed/simple;
	bh=2MeRUgHu/sIANvubOpAj38TnwVlNzFvscRBgUPQjREo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Czc7riFCpF8d6OxppV7UXvTMVzfJRZVTcF/KyMPKtrnI/oAAynMmKaOaP4d6+Mi9Grf9Y4s54Ie+9dFft6H6kTGFfBk688ER5r1+Lfl7qAzCq76Zw4On4E35ypMdxnBv7mvlOUufBkOFvdKkTZjjhAchCqfF5AepkEDtJpIVe9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R6n3QuTM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K6p3EI011673;
	Thu, 20 Feb 2025 08:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nuMNDo1NPoWcZAW45lY80j5Qm/h3VVY+xyPGuQrR3KA=; b=R6n3QuTMuoLZiVIh
	f41OpJUYxr3WjcJ/8c3LlmEDXLOZa+ZjFLUV2ycJfRN0GvBqYIfSXzDVGqhrvCW2
	0g5t7PMEoDzjOsJivELX/izk7t+H0yrRGmp/YCEz6WFDFjUNTAonenQH1aj53TJO
	cp2/LUQFYhXOcvSqlf0WdGMOBooqew6CROwmV0WF9wTXuT2x8NMusIvop5PNOATk
	LHGBQD/XMRTcDlK7wRXYN3uQ74VPwVbCNIkx/j9X7qJgDfUWVBM/9/dVbo8rLIaS
	bBTlFaa+MycrzmO2KmZP8XTSZSlaFJBI51XTGvm42u9DBai0YSbLSfLbZyw+/v4s
	Lc0mag==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3ndsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:25:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51K8P2QS030808
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:25:02 GMT
Received: from bqiang-SFF.lan (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Feb
 2025 00:25:01 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v2 2/7] wifi: ath11k: don't use static variables in ath11k_debugfs_fw_stats_process()
Date: Thu, 20 Feb 2025 16:24:43 +0800
Message-ID: <20250220082448.31039-3-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250220082448.31039-1-quic_bqiang@quicinc.com>
References: <20250220082448.31039-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DTcMDoCWVOHQ9HNCA_Jn6efJc8GUCAL9
X-Proofpoint-GUID: DTcMDoCWVOHQ9HNCA_Jn6efJc8GUCAL9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502200060

Currently ath11k_debugfs_fw_stats_process() is using static variables to count
firmware stat events. Taking num_vdev as an example, if for whatever reason (
say ar->num_started_vdevs is 0 or firmware bug etc.) the following condition

	(++num_vdev) == total_vdevs_started

is not met, is_end is not set thus num_vdev won't be cleared. Next time when
firmware stats is requested again, even if everything is working fine, we will
fail due to the condition above will never be satisfied.

The same applies to num_bcn as well.

Change to use non-static counters so that we have a chance to clear them each
time firmware stats is requested. Currently only ath11k_fw_stats_request() and
ath11k_debugfs_fw_stats_request() are requesting firmware stats, so clear
counters there.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37

Fixes: da3a9d3c1576 ("ath11k: refactor debugfs code into debugfs.c")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/ath/ath11k/core.h    |  2 ++
 drivers/net/wireless/ath/ath11k/debugfs.c | 16 +++++++---------
 drivers/net/wireless/ath/ath11k/mac.c     |  2 ++
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 6abbb29034f0..529aca4f4062 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -599,6 +599,8 @@ struct ath11k_fw_stats {
 	struct list_head pdevs;
 	struct list_head vdevs;
 	struct list_head bcn;
+	u32 num_vdev_recvd;
+	u32 num_bcn_recvd;
 };
 
 struct ath11k_dbg_htt_stats {
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 1d03e3aab011..27c93c0b4c22 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -98,6 +98,8 @@ static void ath11k_debugfs_fw_stats_reset(struct ath11k *ar)
 	spin_lock_bh(&ar->data_lock);
 	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
 	ath11k_fw_stats_vdevs_free(&ar->fw_stats.vdevs);
+	ar->fw_stats.num_vdev_recvd = 0;
+	ar->fw_stats.num_bcn_recvd = 0;
 	spin_unlock_bh(&ar->data_lock);
 }
 
@@ -106,7 +108,6 @@ void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_pdev *pdev;
 	bool is_end;
-	static unsigned int num_vdev, num_bcn;
 	size_t total_vdevs_started = 0;
 	int i;
 
@@ -131,15 +132,14 @@ void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *
 				total_vdevs_started += ar->num_started_vdevs;
 		}
 
-		is_end = ((++num_vdev) == total_vdevs_started);
+		is_end = ((++ar->fw_stats.num_vdev_recvd) == total_vdevs_started);
 
 		list_splice_tail_init(&stats->vdevs,
 				      &ar->fw_stats.vdevs);
 
-		if (is_end) {
+		if (is_end)
 			complete(&ar->fw_stats_done);
-			num_vdev = 0;
-		}
+
 		return;
 	}
 
@@ -151,15 +151,13 @@ void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *
 		/* Mark end until we reached the count of all started VDEVs
 		 * within the PDEV
 		 */
-		is_end = ((++num_bcn) == ar->num_started_vdevs);
+		is_end = ((++ar->fw_stats.num_bcn_recvd) == ar->num_started_vdevs);
 
 		list_splice_tail_init(&stats->bcn,
 				      &ar->fw_stats.bcn);
 
-		if (is_end) {
+		if (is_end)
 			complete(&ar->fw_stats_done);
-			num_bcn = 0;
-		}
 	}
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index d35250f4570d..e28dae55c802 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9386,6 +9386,8 @@ static int ath11k_fw_stats_request(struct ath11k *ar,
 
 	spin_lock_bh(&ar->data_lock);
 	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
+	ar->fw_stats.num_vdev_recvd = 0;
+	ar->fw_stats.num_bcn_recvd = 0;
 	spin_unlock_bh(&ar->data_lock);
 
 	reinit_completion(&ar->fw_stats_complete);
-- 
2.25.1



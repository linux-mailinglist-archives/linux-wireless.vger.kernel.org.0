Return-Path: <linux-wireless+bounces-19175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08E4A3D31C
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 09:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC157A9484
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 08:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884DD1EB190;
	Thu, 20 Feb 2025 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cvvfDpy+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72F01EA7D3
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039906; cv=none; b=jUFUQ6Eqg1xpw+iSCHxqKPdCW3milmE4Idm/WPEkQGvGIVoS/u0TwqN39CgaO0lm4D6HlJaZXV5cBQdm2pMAc4n66lmBiDRLzAAPh40HZLc+wtHyxHwPt9epF3+P/YfA2iOHWEo4IACrJ8C+hFhRfw7maoMDYe9hynwyVfC1/R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039906; c=relaxed/simple;
	bh=Z1VDGXBs7NlFJoWE2goS1rlg7ypidNmLDLlSQFOKjXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byBpH+71aUZTsk2o7UN4A5tLVCZ0CMaX1414cKm141z3HI3aHE8A7R9pm6xtNoIEJvoZkq+c3zhCNR7qVrs6OXXf8wX3FPz899s/lgu0f4Pc+ROLHlrd5GNm+J9WqaCROFwcSL0Rrs8/HDfqSv/9W5+En/vY6+ypWl++PsCTzVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cvvfDpy+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K6i04j001826;
	Thu, 20 Feb 2025 08:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A1iFork7j2hg7VLmFMpe/3lFQMlw/jVPX9BgSr0jDd4=; b=cvvfDpy+toMOQoVL
	oobbmK21Qx0BWTREF0NGTRSj1y+y96seAGR2Myyt+wxSbZY/yHLP8XwGZZA+bRS3
	2FrgVHudbWyyv585aTzM+7uKlkRWKz27cbtN67aKnQIaHFYb6OOCiHyar8/tgGV5
	QYr8F5VL1yg/8Qb92ZtOBRPgzpqXeJ1Ytj5MsmpVVBltBBKSm9LzCCmCNhXmMqzd
	YJQk4v6leU0eAvmSwCQS1pah2A96Ampor7bObH3v+/6JmqSqJ9x+6xkG1nDbjgwc
	SNEZDPepZ0X5rLPAg2cSgLeI8VNLIFy2I8lr3n1ZyB+Hn15jXMXXnEgNpC5r6EN3
	7oNKbg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy2deew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:25:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51K8P0Dm030679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:25:00 GMT
Received: from bqiang-SFF.lan (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Feb
 2025 00:24:59 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v2 1/7] wifi: ath11k: avoid burning CPU in ath11k_debugfs_fw_stats_request()
Date: Thu, 20 Feb 2025 16:24:42 +0800
Message-ID: <20250220082448.31039-2-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: p8fUBRvSE68Rd3kOqsqs2ZktvrUiOwlG
X-Proofpoint-GUID: p8fUBRvSE68Rd3kOqsqs2ZktvrUiOwlG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200060

We get report [1] that CPU is running a hot loop in
ath11k_debugfs_fw_stats_request():

94.60%     0.00%  i3status         [kernel.kallsyms]                 [k] do_syscall_64
        |
         --94.60%--do_syscall_64
                   |
                    --94.55%--__sys_sendmsg
                              ___sys_sendmsg
                              ____sys_sendmsg
                              netlink_sendmsg
                              netlink_unicast
                              genl_rcv
                              netlink_rcv_skb
                              genl_rcv_msg
                              |
                               --94.55%--genl_family_rcv_msg_dumpit
                                         __netlink_dump_start
                                         netlink_dump
                                         genl_dumpit
                                         nl80211_dump_station
                                         |
                                          --94.55%--ieee80211_dump_station
                                                    sta_set_sinfo
                                                    |
                                                     --94.55%--ath11k_mac_op_sta_statistics
                                                               ath11k_debugfs_get_fw_stats
                                                               |
                                                                --94.55%--ath11k_debugfs_fw_stats_request
                                                                          |
                                                                          |--41.73%--_raw_spin_lock_bh
                                                                          |
                                                                          |--22.74%--__local_bh_enable_ip
                                                                          |
                                                                          |--9.22%--_raw_spin_unlock_bh
                                                                          |
                                                                           --6.66%--srso_alias_safe_ret

This is because, if for whatever reason ar->fw_stats_done is not set by
ath11k_update_stats_event(), ath11k_debugfs_fw_stats_request() won't yield
CPU before an up to 3s timeout.

Change to completion mechanism to avoid CPU burning.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Reported-by: Yury Vostrikov <mon@unformed.ru>
Closes: https://lore.kernel.org/all/7324ac7a-8b7a-42a5-aa19-de52138ff638@app.fastmail.com/ # [1]
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c    |  1 +
 drivers/net/wireless/ath/ath11k/core.h    |  2 +-
 drivers/net/wireless/ath/ath11k/debugfs.c | 38 +++++++++--------------
 drivers/net/wireless/ath/ath11k/mac.c     |  2 +-
 drivers/net/wireless/ath/ath11k/wmi.c     |  2 +-
 5 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 65bba0ae69a9..251c20148ab2 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -951,6 +951,7 @@ void ath11k_fw_stats_init(struct ath11k *ar)
 	INIT_LIST_HEAD(&ar->fw_stats.bcn);
 
 	init_completion(&ar->fw_stats_complete);
+	init_completion(&ar->fw_stats_done);
 }
 
 void ath11k_fw_stats_free(struct ath11k_fw_stats *stats)
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 1a3d0de4afde..6abbb29034f0 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -783,7 +783,7 @@ struct ath11k {
 	u8 alpha2[REG_ALPHA2_LEN + 1];
 	struct ath11k_fw_stats fw_stats;
 	struct completion fw_stats_complete;
-	bool fw_stats_done;
+	struct completion fw_stats_done;
 
 	/* protected by conf_mutex */
 	bool ps_state_enable;
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index bf192529e3fe..1d03e3aab011 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/vmalloc.h>
@@ -96,7 +96,6 @@ void ath11k_debugfs_add_dbring_entry(struct ath11k *ar,
 static void ath11k_debugfs_fw_stats_reset(struct ath11k *ar)
 {
 	spin_lock_bh(&ar->data_lock);
-	ar->fw_stats_done = false;
 	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
 	ath11k_fw_stats_vdevs_free(&ar->fw_stats.vdevs);
 	spin_unlock_bh(&ar->data_lock);
@@ -114,7 +113,7 @@ void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *
 	/* WMI_REQUEST_PDEV_STAT request has been already processed */
 
 	if (stats->stats_id == WMI_REQUEST_RSSI_PER_CHAIN_STAT) {
-		ar->fw_stats_done = true;
+		complete(&ar->fw_stats_done);
 		return;
 	}
 
@@ -138,7 +137,7 @@ void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *
 				      &ar->fw_stats.vdevs);
 
 		if (is_end) {
-			ar->fw_stats_done = true;
+			complete(&ar->fw_stats_done);
 			num_vdev = 0;
 		}
 		return;
@@ -158,7 +157,7 @@ void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *
 				      &ar->fw_stats.bcn);
 
 		if (is_end) {
-			ar->fw_stats_done = true;
+			complete(&ar->fw_stats_done);
 			num_bcn = 0;
 		}
 	}
@@ -168,21 +167,15 @@ static int ath11k_debugfs_fw_stats_request(struct ath11k *ar,
 					   struct stats_request_params *req_param)
 {
 	struct ath11k_base *ab = ar->ab;
-	unsigned long timeout, time_left;
+	unsigned long time_left;
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
-	/* FW stats can get split when exceeding the stats data buffer limit.
-	 * In that case, since there is no end marking for the back-to-back
-	 * received 'update stats' event, we keep a 3 seconds timeout in case,
-	 * fw_stats_done is not marked yet
-	 */
-	timeout = jiffies + secs_to_jiffies(3);
-
 	ath11k_debugfs_fw_stats_reset(ar);
 
 	reinit_completion(&ar->fw_stats_complete);
+	reinit_completion(&ar->fw_stats_done);
 
 	ret = ath11k_wmi_send_stats_request_cmd(ar, req_param);
 
@@ -193,21 +186,18 @@ static int ath11k_debugfs_fw_stats_request(struct ath11k *ar,
 	}
 
 	time_left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);
-
 	if (!time_left)
 		return -ETIMEDOUT;
 
-	for (;;) {
-		if (time_after(jiffies, timeout))
-			break;
+	/* FW stats can get split when exceeding the stats data buffer limit.
+	 * In that case, since there is no end marking for the back-to-back
+	 * received 'update stats' event, we keep a 3 seconds timeout in case,
+	 * fw_stats_done is not marked yet
+	 */
+	time_left = wait_for_completion_timeout(&ar->fw_stats_done, 3 * HZ);
+	if (!time_left)
+		return -ETIMEDOUT;
 
-		spin_lock_bh(&ar->data_lock);
-		if (ar->fw_stats_done) {
-			spin_unlock_bh(&ar->data_lock);
-			break;
-		}
-		spin_unlock_bh(&ar->data_lock);
-	}
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 14ed53836589..d35250f4570d 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9385,11 +9385,11 @@ static int ath11k_fw_stats_request(struct ath11k *ar,
 	lockdep_assert_held(&ar->conf_mutex);
 
 	spin_lock_bh(&ar->data_lock);
-	ar->fw_stats_done = false;
 	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
 	spin_unlock_bh(&ar->data_lock);
 
 	reinit_completion(&ar->fw_stats_complete);
+	reinit_completion(&ar->fw_stats_done);
 
 	ret = ath11k_wmi_send_stats_request_cmd(ar, req_param);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index d7f852bebf4a..27cb0bb06b93 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8189,7 +8189,7 @@ static void ath11k_update_stats_event(struct ath11k_base *ab, struct sk_buff *sk
 	 */
 	if (stats.stats_id == WMI_REQUEST_PDEV_STAT) {
 		list_splice_tail_init(&stats.pdevs, &ar->fw_stats.pdevs);
-		ar->fw_stats_done = true;
+		complete(&ar->fw_stats_done);
 		goto complete;
 	}
 
-- 
2.25.1



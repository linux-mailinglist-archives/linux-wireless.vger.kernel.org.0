Return-Path: <linux-wireless+bounces-19181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40478A3D31D
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 09:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A8517AF4D
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 08:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C107D1EB186;
	Thu, 20 Feb 2025 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Es4uKzfW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7D51EB9ED
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039915; cv=none; b=k+fzNOth5yWnX48o8cvtJByY5VTLMaYk9oG5BT9n+e63vL1LL4UpnoEq1m1jZDakq0EscyFy7yN2uQ4Q7dvs9i1MgVVSckdIRtm3ufZ724g+rPvF2wvJ5vWkett6zlfeXacbIky4masH2AtFHAL44X2QUGdHBcR46Gd3TMBaZfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039915; c=relaxed/simple;
	bh=MJg+RlHfnaSDabv+dIyVEpjv3uYAohqxge9+3Qm38ac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LeVXSqRKjr2RG5lykEroauTKk7kIXepsfLdDLYsds70ukx3AZPr+VT0bKcrsMgMOLVEcwkDuw4HmLuZtd6La+mdc41+xt2qauc3HvJHTWwMwuCh6vrmqwJKN9kiaYwXU2sMx7P/Yz0bzYObIlG86pPUFIdPhgTso3/rpr1vz168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Es4uKzfW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K6SSFJ026275;
	Thu, 20 Feb 2025 08:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lqIiKVYS1YFt8+CblG/fCe/DL1AJ6zdydoaH0Wk2/Ak=; b=Es4uKzfWPz0g4skq
	qy51iJNk6b2zn5UxtTlABGuIyZd86ggWN8DsvNTUEulP5kWHK9FAt+tsH4QcKPln
	Wp0l5TuG2JblfRtltBQmx3zEIUPwxlIGb0vuAtRjEGuMlxi8pP7d2ZrJsn6C2CNb
	oVXUSQN6ELM2+jJ+uX79DIMgPfkEJpEgFLg8np+lpax/1fKtyNSAR8appVrgqcgP
	A9S4KBKEpiAOsrYkWjCPZJL7jWkuNAIQhJHyk/JPI3zfPVOBPukRSrQFcAt1ZBLh
	etBnzrMNQKRGozn5r+uxIz8SdDLjkbtY+rtSQNS+hoMZ7upcj/3BK1R9eNKaOb/U
	LEpgAg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy0neuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:25:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51K8PBtk003977
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:25:11 GMT
Received: from bqiang-SFF.lan (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Feb
 2025 00:25:09 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v2 7/7] wifi: ath11k: consistently use ath11k_mac_get_fw_stats()
Date: Thu, 20 Feb 2025 16:24:48 +0800
Message-ID: <20250220082448.31039-8-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: GGeqEypYO-pGmYT0DNVRncB-2jD5BtVq
X-Proofpoint-ORIG-GUID: GGeqEypYO-pGmYT0DNVRncB-2jD5BtVq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200060

Currently to get firmware stats, ath11k_mac_op_get_txpower() calls
ath11k_fw_stats_request() and ath11k_mac_op_sta_statistics() calls
ath11k_mac_get_fw_stats(). Those two helpers are basically doing
the same, except for:

1. ath11k_mac_get_fw_stats() verifies ar->state inside itself.
2. ath11k_mac_get_fw_stats() calls ath11k_mac_fw_stats_request()
   which then calls ath11k_mac_fw_stats_reset() to free pdev/vdev
   stats whereas only pdev stats are freed by ath11k_fw_stats_request().
3. ath11k_mac_get_fw_stats() waits for ar->fw_stats_complete and
   ar->fw_stats_done, whereas ath11k_fw_stats_request() only waits for
   ar->fw_stats_complete.

Change to call ath11k_mac_get_fw_stats() in ath11k_mac_op_get_txpower().
This is valid because:

1. ath11k_mac_op_get_txpower() also has the same request on ar->state.
2. it is harmless to call ath11k_fw_stats_vdevs_free() since
   ar->fw_stats.vdevs should be empty and there should be no one
   expecting it at that time.
3. ath11k_mac_op_get_txpower() only needs pdev stats. For pdev stats,
   ar->fw_stats_done is set to true whenever ar->fw_stats_complete is
   set to true in ath11k_update_stats_event(). So additional wait on
   ar->fw_stats_done does not wast any time.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 44 ++-------------------------
 1 file changed, 2 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 8a01eb6c53d0..c31cec0897d5 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9452,40 +9452,6 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static int ath11k_fw_stats_request(struct ath11k *ar,
-				   struct stats_request_params *req_param)
-{
-	struct ath11k_base *ab = ar->ab;
-	unsigned long time_left;
-	int ret;
-
-	lockdep_assert_held(&ar->conf_mutex);
-
-	spin_lock_bh(&ar->data_lock);
-	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
-	ar->fw_stats.num_vdev_recvd = 0;
-	ar->fw_stats.num_bcn_recvd = 0;
-	spin_unlock_bh(&ar->data_lock);
-
-	reinit_completion(&ar->fw_stats_complete);
-	reinit_completion(&ar->fw_stats_done);
-
-	ret = ath11k_wmi_send_stats_request_cmd(ar, req_param);
-	if (ret) {
-		ath11k_warn(ab, "could not request fw stats (%d)\n",
-			    ret);
-		return ret;
-	}
-
-	time_left = wait_for_completion_timeout(&ar->fw_stats_complete,
-						1 * HZ);
-
-	if (!time_left)
-		return -ETIMEDOUT;
-
-	return 0;
-}
-
 static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     unsigned int link_id,
@@ -9493,7 +9459,6 @@ static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
 {
 	struct ath11k *ar = hw->priv;
 	struct ath11k_base *ab = ar->ab;
-	struct stats_request_params req_param = {0};
 	struct ath11k_fw_stats_pdev *pdev;
 	int ret;
 
@@ -9505,9 +9470,6 @@ static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
 	 */
 	mutex_lock(&ar->conf_mutex);
 
-	if (ar->state != ATH11K_STATE_ON)
-		goto err_fallback;
-
 	/* Firmware doesn't provide Tx power during CAC hence no need to fetch
 	 * the stats.
 	 */
@@ -9516,10 +9478,8 @@ static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
 		return -EAGAIN;
 	}
 
-	req_param.pdev_id = ar->pdev->pdev_id;
-	req_param.stats_id = WMI_REQUEST_PDEV_STAT;
-
-	ret = ath11k_fw_stats_request(ar, &req_param);
+	ret = ath11k_mac_get_fw_stats(ar, ar->pdev->pdev_id, 0,
+				      WMI_REQUEST_PDEV_STAT);
 	if (ret) {
 		ath11k_warn(ab, "failed to request fw pdev stats: %d\n", ret);
 		goto err_fallback;
-- 
2.25.1



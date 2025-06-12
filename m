Return-Path: <linux-wireless+bounces-24023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A5EAD6525
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 03:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D0A47AD913
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 01:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E6917B421;
	Thu, 12 Jun 2025 01:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o2W4oqwM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E101632DD;
	Thu, 12 Jun 2025 01:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749691936; cv=none; b=oqygZS3mugy1KiBZcPLwfZ6s6VKcRHthY8YF7fI/FHMZjRrOFXZm74KRBQn/mIQwjzK7uA5ucW2qFZ2AIN0MSnoMiBIK7RXMOHDaQrl5mYlja4oZrf/bxdvL1LTrRLtb2GA1asQsxgZitMwCKT7FrW/1BvJnB7FyIgpfVeoqp9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749691936; c=relaxed/simple;
	bh=NeNaBOKDN4HCZe37+/9v4S7kIlAhZQyv6BaFL4yrKSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iRkCsr8xTOGXl0gtqMJgWvHu2gmkWuFGs6vUNdyHocv8VgsJlZwHkNCo4oEdXxVF5uDH8IjxdQVJ+CSutSTus/hxOIoBFxRR4nC+PUx7TfTSFcNG/4Zv8OgV/vvKG9eLEMv1gfbRsT2bgNmlnj21igBalRZaSpB07AkFxdr10GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o2W4oqwM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BMA23V002792;
	Thu, 12 Jun 2025 01:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b4DmcTjzf3Ae/K8nsQUa4j3M4XtbNzVicLcLtqjo7v0=; b=o2W4oqwMXGcrOXHj
	buca6/DZpOa0vz0OBS2J9G9LeFxp5LqLxerJhfwk8zuJNmb2HtMB/4aEpP89kPkz
	K8rTRV59lOwhjDYGByZGGCOSLqxJvi0wzLrTo5T1v40mKwsQeIQ0zUPVyxKLCuOj
	V8ftUqpu3wGCGXnFXfBBGci+bm9ORZFPLrPlTVioXpOfTx5bdW9YVdFi65vx6Mcf
	vP2lYWO3kpHD9SWjf03dKR0/8O64scdwCO8MrAA6P+0AmlSLufznDH2i6pAGmNqu
	pf4xjctAQn0S/UUniYG3Ch9NkltOQt5sUjGrAxTMiaKdw9ngDy4OKdH4R7oS7XbN
	mKgziA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 477jbpgbtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 01:32:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55C1W6Bv014910
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 01:32:06 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Jun
 2025 18:32:03 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Thu, 12 Jun 2025 09:31:50 +0800
Subject: [PATCH ath-current 2/4] wifi: ath12k: avoid burning CPU while
 waiting for firmware stats
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250612-ath12k-fw-fixes-v1-2-12f594f3b857@quicinc.com>
References: <20250612-ath12k-fw-fixes-v1-0-12f594f3b857@quicinc.com>
In-Reply-To: <20250612-ath12k-fw-fixes-v1-0-12f594f3b857@quicinc.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Ramya Gnanasekar
	<ramya.gnanasekar@oss.qualcomm.com>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>
CC: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>, g
	<gregoire.s93@live.fr>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8T_TLr6KviAYdfEozFpnwyxEbQk3X8HW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDAxMCBTYWx0ZWRfXzYX0McvvDsCH
 1aC4PlUsnnEz7tV2NPYdKRUe23+V+mkY02vPmuy/0cLw2mSW3dPjDuuTt0bsjDuEbgfDwpxqwrB
 GUdLohUU2i9ChVnp3iGyW3KNkJY78RTFS6LqC/+ibet9IrYcKYFEeJUqaYgVJAwXr+MZA5wy7Ke
 FG9m43M+N1o1REtCK1dhVLHVG+jFddEFhya9twWIYSkq3O8sJKCZnO4qF14L7yjhdgnKPm7pAqL
 4jExUm7MyDH0vkc57oTp607GLsQWXhxHPYzNph8g5BcLh3rx7QYLuhs4LHRQIMNJp0x33p4/eTi
 qaB1CpUvHx3IX3bOG8ZqKhb30bWddmKKaxDzdqKdCtZYllu8u4pVZyQPhd49TJ4jOGU2TnbXGwV
 VuyNaxZ0RYeI73EHsf+crZesuS0D+5E7HCiL+pdHcCYRu4Z0bsk0RBSqUP5w+4qsIh0EM8qW
X-Proofpoint-ORIG-GUID: 8T_TLr6KviAYdfEozFpnwyxEbQk3X8HW
X-Authority-Analysis: v=2.4 cv=OLgn3TaB c=1 sm=1 tr=0 ts=684a2e17 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=UqCG9HQmAAAA:8 a=COk6AnOGAAAA:8 a=2UbTJNZUCKH_85_BNbUA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_01,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120010

ath12k_mac_get_fw_stats() is busy polling fw_stats_done flag while waiting
firmware finishing sending all events. This is not good as CPU is
monopolized and kept burning during the wait.

Change to the completion mechanism to fix it.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Fixes: e367c924768b ("wifi: ath12k: Request vdev stats from firmware")
Reported-by: g <gregoire.s93@live.fr>
Closes: https://lore.kernel.org/ath12k/AS8P190MB120575BBB25FCE697CD7D4988763A@AS8P190MB1205.EURP190.PROD.OUTLOOK.COM/
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  2 +-
 drivers/net/wireless/ath/ath12k/core.h |  2 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 27 ++++++++-------------------
 drivers/net/wireless/ath/ath12k/wmi.c  |  7 ++++---
 4 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index ebc0560d40e3419130e4caf01c9b91bd9affb3bd..fbc62209086fe5fde007193755f6116bfa72ab77 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1216,6 +1216,7 @@ void ath12k_fw_stats_init(struct ath12k *ar)
 	INIT_LIST_HEAD(&ar->fw_stats.pdevs);
 	INIT_LIST_HEAD(&ar->fw_stats.bcn);
 	init_completion(&ar->fw_stats_complete);
+	init_completion(&ar->fw_stats_done);
 }
 
 void ath12k_fw_stats_free(struct ath12k_fw_stats *stats)
@@ -1228,7 +1229,6 @@ void ath12k_fw_stats_free(struct ath12k_fw_stats *stats)
 void ath12k_fw_stats_reset(struct ath12k *ar)
 {
 	spin_lock_bh(&ar->data_lock);
-	ar->fw_stats.fw_stats_done = false;
 	ath12k_fw_stats_free(&ar->fw_stats);
 	spin_unlock_bh(&ar->data_lock);
 }
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 941db6e49d6eaeb03783f7714d433259d887820b..c9584c4d85fd77150ff30af6d406dadbd87a8050 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -626,7 +626,6 @@ struct ath12k_fw_stats {
 	struct list_head pdevs;
 	struct list_head vdevs;
 	struct list_head bcn;
-	bool fw_stats_done;
 };
 
 struct ath12k_dbg_htt_stats {
@@ -806,6 +805,7 @@ struct ath12k {
 	bool regdom_set_by_user;
 
 	struct completion fw_stats_complete;
+	struct completion fw_stats_done;
 
 	struct completion mlo_setup_done;
 	u32 mlo_setup_status;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 15dc99992f271f3ec81ecedaf1f6a81fbeb03f79..8ad6fb358700cf06335748f885877305445b981f 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4360,7 +4360,7 @@ int ath12k_mac_get_fw_stats(struct ath12k *ar,
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
-	unsigned long timeout, time_left;
+	unsigned long time_left;
 	int ret;
 
 	guard(mutex)(&ah->hw_mutex);
@@ -4368,19 +4368,13 @@ int ath12k_mac_get_fw_stats(struct ath12k *ar,
 	if (ah->state != ATH12K_HW_STATE_ON)
 		return -ENETDOWN;
 
-	/* FW stats can get split when exceeding the stats data buffer limit.
-	 * In that case, since there is no end marking for the back-to-back
-	 * received 'update stats' event, we keep a 3 seconds timeout in case,
-	 * fw_stats_done is not marked yet
-	 */
-	timeout = jiffies + msecs_to_jiffies(3 * 1000);
 	ath12k_fw_stats_reset(ar);
 
 	reinit_completion(&ar->fw_stats_complete);
+	reinit_completion(&ar->fw_stats_done);
 
 	ret = ath12k_wmi_send_stats_request_cmd(ar, param->stats_id,
 						param->vdev_id, param->pdev_id);
-
 	if (ret) {
 		ath12k_warn(ab, "failed to request fw stats: %d\n", ret);
 		return ret;
@@ -4391,7 +4385,6 @@ int ath12k_mac_get_fw_stats(struct ath12k *ar,
 		   param->pdev_id, param->vdev_id, param->stats_id);
 
 	time_left = wait_for_completion_timeout(&ar->fw_stats_complete, 1 * HZ);
-
 	if (!time_left) {
 		ath12k_warn(ab, "time out while waiting for get fw stats\n");
 		return -ETIMEDOUT;
@@ -4400,19 +4393,15 @@ int ath12k_mac_get_fw_stats(struct ath12k *ar,
 	/* Firmware sends WMI_UPDATE_STATS_EVENTID back-to-back
 	 * when stats data buffer limit is reached. fw_stats_complete
 	 * is completed once host receives first event from firmware, but
-	 * still there could be more events following. Below loop is to wait
+	 * still there could be more events following. Below is to wait
 	 * until firmware completes sending all the events.
 	 */
-	for (;;) {
-		if (time_after(jiffies, timeout))
-			break;
-		spin_lock_bh(&ar->data_lock);
-		if (ar->fw_stats.fw_stats_done) {
-			spin_unlock_bh(&ar->data_lock);
-			break;
-		}
-		spin_unlock_bh(&ar->data_lock);
+	time_left = wait_for_completion_timeout(&ar->fw_stats_done, 3 * HZ);
+	if (!time_left) {
+		ath12k_warn(ab, "time out while waiting for fw stats done\n");
+		return -ETIMEDOUT;
 	}
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 2d2444417e2b2d9281754d113f2b073034e27739..1e6074456725f45c2bab69aa43ae4ff0b9ce5e8f 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7658,11 +7658,12 @@ static void ath12k_wmi_fw_stats_process(struct ath12k *ar,
 				      &ar->fw_stats.vdevs);
 
 		if (is_end) {
-			ar->fw_stats.fw_stats_done = true;
+			complete(&ar->fw_stats_done);
 			num_vdev = 0;
 		}
 		return;
 	}
+
 	if (stats->stats_id == WMI_REQUEST_BCN_STAT) {
 		if (list_empty(&stats->bcn)) {
 			ath12k_warn(ab, "empty beacon stats");
@@ -7677,7 +7678,7 @@ static void ath12k_wmi_fw_stats_process(struct ath12k *ar,
 				      &ar->fw_stats.bcn);
 
 		if (is_end) {
-			ar->fw_stats.fw_stats_done = true;
+			complete(&ar->fw_stats_done);
 			num_bcn = 0;
 		}
 	}
@@ -7715,7 +7716,7 @@ static void ath12k_update_stats_event(struct ath12k_base *ab, struct sk_buff *sk
 	/* Handle WMI_REQUEST_PDEV_STAT status update */
 	if (stats.stats_id == WMI_REQUEST_PDEV_STAT) {
 		list_splice_tail_init(&stats.pdevs, &ar->fw_stats.pdevs);
-		ar->fw_stats.fw_stats_done = true;
+		complete(&ar->fw_stats_done);
 		goto complete;
 	}
 

-- 
2.34.1



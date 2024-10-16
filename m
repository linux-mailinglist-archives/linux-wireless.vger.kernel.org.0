Return-Path: <linux-wireless+bounces-14054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E869A01EA
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 08:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172921F26141
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 06:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62951193408;
	Wed, 16 Oct 2024 06:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RoILlZVY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05CF1C4A28
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061866; cv=none; b=bTdifJA3ZJ+JGtDaAKo+nVokx4F4HlgSsFufJGpYD8cWpgtjJ7ddD+BMb2Gt9+1KXxO+JOGnddqJx945Wc54urETz4cdMFRVuocfyRQ8VHTKPHD1zl1tSOWgps1V+L3qkNVPO8942FPLrDuGcuxWJpiSb7q6XIOCCb/ecEAAmJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061866; c=relaxed/simple;
	bh=+8XNpU7KBqmwqRHcFwtHnfpG0GTBoOtgWbYmIEwg9Q0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QB+GqZBTcIpzZzsqGIOz2vW8IQzHtrkZeYwB4nN0ks4XAXBWokU8FYY5KFJppFr3958VrSH8JkTumdHJOGYgP/ThiPAFakp8x8JEuJb2rVGVpB6DEUoR+D7hrhF44twJ6Bxs7b9w0PLnIA4/EFqtxYvfKHucGW13kRwGZ2kcQJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RoILlZVY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G6uZ4h023612;
	Wed, 16 Oct 2024 06:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m3U6rPU3HhybJ+a7bMUlP2WqxIygpKdaBH7FlJeAR50=; b=RoILlZVY0I7IjdMp
	kxrclGcRbRc35+YCc38UjaZNgjFi7bGkf86eSa6225/mQubCM3AFvDBA8ULxolYq
	TpIyZb/OLEJtfaMwmF9FBFzI21J+aPlKqyN/YnFZUsqsFavKW7n1XSg069Hh7cM4
	ue2l7LMzVQDHfiEcbNMJSqYH+u/uxyM5RQm+sXx61bYahCECCFyoms23fgi/PkVz
	MSJtPYQGPTU6zN+OG3zcUYfZw/dPZgFLWzhgU8feY5DCZxVuRLD76/ys+QstsFn2
	467DKD9HKMQAemW7jf8TxOiUtJW7DnVRZnqiNI9yLOz/dTQTOPvWWssIGSNnBLwM
	mvmayg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42a8nq0068-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 06:57:42 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49G6vgNl019518
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 06:57:42 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 23:57:40 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v3 11/11] wifi: ath12k: delete mon reap timer
Date: Wed, 16 Oct 2024 14:57:00 +0800
Message-ID: <20241016065700.1090-12-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241016065700.1090-1-quic_kangyang@quicinc.com>
References: <20241016065700.1090-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: s4oCDWx6Ujf4ilbomcYWLAdeCWwLvf3J
X-Proofpoint-GUID: s4oCDWx6Ujf4ilbomcYWLAdeCWwLvf3J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=698 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160044

Currently mon reap timer is not used, and it is not needed anymore.

So remove related code.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  2 --
 drivers/net/wireless/ath/ath12k/dp.c   | 25 -------------------------
 2 files changed, 27 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 0c39b37d6a47..87240fb57c73 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -891,8 +891,6 @@ struct ath12k_base {
 	struct ath12k_dbring_cap *db_caps;
 	u32 num_db_cap;
 
-	struct timer_list mon_reap_timer;
-
 	struct completion htc_suspend;
 
 	u64 fw_soc_drop_count;
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 2ab2a7d45be9..099a1fcd88b4 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -974,8 +974,6 @@ void ath12k_dp_pdev_free(struct ath12k_base *ab)
 {
 	int i;
 
-	del_timer_sync(&ab->mon_reap_timer);
-
 	for (i = 0; i < ab->num_radios; i++)
 		ath12k_dp_rx_pdev_free(ab, i);
 }
@@ -1020,27 +1018,6 @@ void ath12k_dp_hal_rx_desc_init(struct ath12k_base *ab)
 		ab->hal_rx_ops->rx_desc_get_desc_size();
 }
 
-static void ath12k_dp_service_mon_ring(struct timer_list *t)
-{
-	struct ath12k_base *ab = from_timer(ab, t, mon_reap_timer);
-	int i;
-
-	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++)
-		ath12k_dp_mon_process_ring(ab, i, NULL, DP_MON_SERVICE_BUDGET,
-					   ATH12K_DP_RX_MONITOR_MODE);
-
-	mod_timer(&ab->mon_reap_timer, jiffies +
-		  msecs_to_jiffies(ATH12K_MON_TIMER_INTERVAL));
-}
-
-static void ath12k_dp_mon_reap_timer_init(struct ath12k_base *ab)
-{
-	if (ab->hw_params->rxdma1_enable)
-		return;
-
-	timer_setup(&ab->mon_reap_timer, ath12k_dp_service_mon_ring, 0);
-}
-
 int ath12k_dp_pdev_alloc(struct ath12k_base *ab)
 {
 	struct ath12k *ar;
@@ -1051,8 +1028,6 @@ int ath12k_dp_pdev_alloc(struct ath12k_base *ab)
 	if (ret)
 		goto out;
 
-	ath12k_dp_mon_reap_timer_init(ab);
-
 	/* TODO: Per-pdev rx ring unlike tx ring which is mapped to different AC's */
 	for (i = 0; i < ab->num_radios; i++) {
 		ar = ab->pdevs[i].ar;
-- 
2.34.1



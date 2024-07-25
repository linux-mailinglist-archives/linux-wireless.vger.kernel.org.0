Return-Path: <linux-wireless+bounces-10515-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF3D93C160
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 14:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875501C21DCF
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 12:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A9F199389;
	Thu, 25 Jul 2024 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CI2OTlvi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01DC19A28C
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jul 2024 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908881; cv=none; b=DKqFxZMrQcM/LWX93Iuc/22vGJtVfKmMk/IObNWTeToyDk7xIOZ+oB/FsDpJ+x8R+fP8Uu0OKqpgxKrPyvsf7TWlS2VllpFUXINjw+xRv9zdCIee7t1OvGDdZELS8zKEy7I0xTrk42yeMx7hbzB0LFqgFKspqLTSHh/ruX6djnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908881; c=relaxed/simple;
	bh=xfUjYR6wwwZZzcw4tK042j+xQl+PQcHrnlpGr0vca24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHGRUELMgIpN76MB/S0N74T2HlQuAeYlTxiiXfGgQ3r1qlxavvhEnjWtFVlEsjOjiwWpI5Oo5uw55Vlesv65lMx4LmW6jXfEOL1E2rWkqHH2pqq3hTHN/vuP3zxww3zhjBJDAnp2qhfwLubKe9h2YatS2fo1F1sQTjqiAm2GCR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CI2OTlvi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P9gY47022070;
	Thu, 25 Jul 2024 12:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UmQPkNlbITGHr9bRft3rvyOgsvQxET6g/+BxLHCImlY=; b=CI2OTlviK+gSkpNe
	/axLV6HcGBQaVqC9iCbwFJcdYZkezV1CeoQc0oX5Zx0rRrlnQ//Mos7U6lghxFDF
	eZzwoCdw8PRVbxYT0JswCvX0mYs9nXGAvSwQhQroI8YQOYBImnFdMq/Y8jcKU35y
	dXeWV8GqLqzvz0iBgzXQ9C/Q8Wyy8ly1s2wIFWEcZvtrOhdquB3EXKuB0Kk+/ef3
	OHqH4caSXXFRDKJD9Dj9FHfxNq/XgvewHeRG+u0Br+K7DSaIQhtjGu2gzKh6Yh9D
	SxHQGA9WoghFswkBTJ/36i/TxQeorTsJHtHVacnCkFYaWYhjpEl3ZNTyqK0WFDt8
	NyDjGg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g487n46a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 12:01:16 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46PC1FiD013723
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 12:01:15 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Jul 2024 05:01:13 -0700
From: kangyang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 11/11] wifi: ath12k: delete mon reap timer
Date: Thu, 25 Jul 2024 20:00:35 +0800
Message-ID: <20240725120035.493-12-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20240725120035.493-1-quic_kangyang@quicinc.com>
References: <20240725120035.493-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wp5rvB19W1JiRahJD8f7mztk0KFkV1_4
X-Proofpoint-GUID: wp5rvB19W1JiRahJD8f7mztk0KFkV1_4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_11,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=651
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407250082

From: Kang Yang <quic_kangyang@quicinc.com>

Currently mon reap timer is not used, and it is not needed anymore.

So remove related code.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  2 --
 drivers/net/wireless/ath/ath12k/dp.c   | 25 -------------------------
 2 files changed, 27 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index daf7c04bb728..83ef92ecdc39 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -888,8 +888,6 @@ struct ath12k_base {
 	struct ath12k_dbring_cap *db_caps;
 	u32 num_db_cap;
 
-	struct timer_list mon_reap_timer;
-
 	struct completion htc_suspend;
 
 	u64 fw_soc_drop_count;
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 61aa78d8bd8c..547ecb419809 100644
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



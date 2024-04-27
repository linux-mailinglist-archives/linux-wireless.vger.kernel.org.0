Return-Path: <linux-wireless+bounces-6942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB058B471B
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Apr 2024 18:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10EC1C20B8E
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Apr 2024 16:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7E421103;
	Sat, 27 Apr 2024 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hq9t4njy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABA11D554
	for <linux-wireless@vger.kernel.org>; Sat, 27 Apr 2024 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714235234; cv=none; b=Yew56Y0P4pIOIook5PG3xZ7AcOW5WU4oDPguIB1ANoCErxwx+nzvQ/YltNKM2C4uGxBRv3yeR1LyUXM0MsQFQJW3H8JSWF57o+p2h15ACXlCN1MK+pvDnl+4ea9zaSv2YVDhSBLhSrfbvX5QchONRjwhpAT9TjvVwUUow5w/YqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714235234; c=relaxed/simple;
	bh=T8YIVeYYJhZlE8zlXEKAzcyDwG7It05YF7jlYEpiLmQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iG8PPk7YyEZEM9W+xGIS5ldkdGDZ9fybveAUON+NUKv+XtkvHwPQXb98fq1fh7KLJiwMVhqrBnnUY2KuBZC4wia7pUZYAqoPDMZG09rPn7bd1Abj1p2855liZfzGmDIH67c+huAP+Zpi+uxCaWycmJ5LXYukPRMaL2LlltMPrtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hq9t4njy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43RGLtae010745;
	Sat, 27 Apr 2024 16:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=xoG6O88QwWOX2mC7RY8Vl2PhxJ61CVCdrGl5iBudFXE=; b=Hq
	9t4njyDenJL16ZMpzu7GlGlqlwcT2WRqwfQ5T7ZDihIoZJdE+JNVdEtok89VncT7
	X+lC8BQSpOQJ2nkfOLyr87XD+a0zFcxWgHV0odrlhIQ4mQsEQWMFXjhuZ0m9UmAl
	jOMg+wU14tbVh0nsBUbGD4zID4JtdIUDMS+BWpXiJg9hqRKSgoIiONXFYyPwQYbj
	5VWoa1M6YpEv9tcvbwiWxeF6cApbhXqMzwCmOko4dhN7lRGHbMrXffmpNkPB10TP
	mid1sUSLor7l08g2+Ul+kdB/oi1IzE6zXUJat4r8rSLfbkbmwLSR7O9HxtNehueS
	Y3OE6q8a7x1iCJG1iWpg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrsk78p1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 16:27:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43RGR7mL026514
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 16:27:07 GMT
Received: from hu-tamizhr-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 27 Apr 2024 09:27:05 -0700
From: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja
	<quic_tamizhr@quicinc.com>
Subject: [PATCHv2 3/3] wifi: ath12k: Remove unused tcl_*_ring configuration
Date: Sat, 27 Apr 2024 21:56:44 +0530
Message-ID: <20240427162644.2470886-4-quic_tamizhr@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240427162644.2470886-1-quic_tamizhr@quicinc.com>
References: <20240427162644.2470886-1-quic_tamizhr@quicinc.com>
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
X-Proofpoint-GUID: pMV8mSHn4oskGbxse93igWKk-3Y-oJh-
X-Proofpoint-ORIG-GUID: pMV8mSHn4oskGbxse93igWKk-3Y-oJh-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-27_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=954 bulkscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=1 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404270120

Currently memory allocation for multiple hardware rings done
in host as these memory will be used by firmware/hardware.
But in case of tcl_cmd_ring and tcl_status_ring neither firmware
nor hardware uses host allocated memory and it uses memory
allocated by firmware itself. So avoid tcl_cmd_ring and
tcl_status_ring setup in host.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c | 16 ----------------
 drivers/net/wireless/ath/ath12k/dp.h |  2 --
 2 files changed, 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 963b9ad4dc82..d91d5c308210 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -457,8 +457,6 @@ static void ath12k_dp_srng_common_cleanup(struct ath12k_base *ab)
 		ath12k_dp_srng_cleanup(ab, &dp->tx_ring[i].tcl_comp_ring);
 		ath12k_dp_srng_cleanup(ab, &dp->tx_ring[i].tcl_data_ring);
 	}
-	ath12k_dp_srng_cleanup(ab, &dp->tcl_status_ring);
-	ath12k_dp_srng_cleanup(ab, &dp->tcl_cmd_ring);
 	ath12k_dp_srng_cleanup(ab, &dp->wbm_desc_rel_ring);
 }
 
@@ -479,20 +477,6 @@ static int ath12k_dp_srng_common_setup(struct ath12k_base *ab)
 		goto err;
 	}
 
-	ret = ath12k_dp_srng_setup(ab, &dp->tcl_cmd_ring, HAL_TCL_CMD, 0, 0,
-				   DP_TCL_CMD_RING_SIZE);
-	if (ret) {
-		ath12k_warn(ab, "failed to set up tcl_cmd ring :%d\n", ret);
-		goto err;
-	}
-
-	ret = ath12k_dp_srng_setup(ab, &dp->tcl_status_ring, HAL_TCL_STATUS,
-				   0, 0, DP_TCL_STATUS_RING_SIZE);
-	if (ret) {
-		ath12k_warn(ab, "failed to set up tcl_status ring :%d\n", ret);
-		goto err;
-	}
-
 	for (i = 0; i < ab->hw_params->max_tx_ring; i++) {
 		map = ab->hw_params->hal_ops->tcl_to_wbm_rbm_map;
 		tx_comp_ring_num = map[i].wbm_ring_num;
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 5cf0d21ef184..21afdb51b6e6 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -327,8 +327,6 @@ struct ath12k_dp {
 	struct dp_link_desc_bank link_desc_banks[DP_LINK_DESC_BANKS_MAX];
 	struct dp_srng wbm_idle_ring;
 	struct dp_srng wbm_desc_rel_ring;
-	struct dp_srng tcl_cmd_ring;
-	struct dp_srng tcl_status_ring;
 	struct dp_srng reo_reinject_ring;
 	struct dp_srng rx_rel_ring;
 	struct dp_srng reo_except_ring;
-- 
2.34.1



Return-Path: <linux-wireless+bounces-6966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3EB8B523A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 09:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4531C20EF1
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 07:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421AF14003;
	Mon, 29 Apr 2024 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jzD6z5U4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A064615E85
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375277; cv=none; b=Ivrv16lQenKMukZkxNhH21QwUbZWpXEGiX/dQRttz2rJExv03hRGc2YGUiaf4+EVum4G+c2M9kFwWbI9y3HB09tH+obNGFPdHA0drLWoWs4zyMZalajKvhqPQb9wUSeILtEVQvJfSHAEJxsHF+WrEY3ggkB9Q0nNU66KA0G1k0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375277; c=relaxed/simple;
	bh=T8YIVeYYJhZlE8zlXEKAzcyDwG7It05YF7jlYEpiLmQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJHMn2M4UbMiSFwMg72sYp07K0fzTC3UlJrVMCYDW9+Iu70hfeDTEdI2yT5lUS1NOgYCmEMVDzDCC7pNdFPNT8ZTLifnYjNDcqDoMKC5s5mbvGWO3BCcQR6nkClv52lScaQGDeGSsgGRE6RqxjvD4tklZH+Rph2fKHViBNXCRm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jzD6z5U4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T3Kw9S016555;
	Mon, 29 Apr 2024 07:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=xoG6O88QwWOX2mC7RY8Vl2PhxJ61CVCdrGl5iBudFXE=; b=jz
	D6z5U4QdjFPsGQ6/a4c8H70xt+GViHiwuvt04ANCzBLlgChoPHtudKWP9fgmJHND
	jVyIIrySSo97wPfCJb0MIlNWs8vaVoxSIkHL1RjjNIfNZXiMTggORp7GR3JJ1ZLG
	obGImqXfHiGT/NGhjpBoUcL/tSzfsRJeh/EC743PweUvm8CN8J2Etr++TARO7EdE
	LJ0wj6PXDS/k5Oj7f2qTbQK41QHffZ+YWdPSHFf+fupDOh8HiTThrZPLimioXyvF
	hhgSA/IPzn9heSVWSB3JhlYzkmg9zy7ZqUcy88lwbOdemIIujLfRbVzRGn5JXghi
	HYXa0VFYHNcedP9vT9Xw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrrcck32t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 07:21:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43T7LBsp009459
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 07:21:11 GMT
Received: from hu-tamizhr-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 00:21:09 -0700
From: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja
	<quic_tamizhr@quicinc.com>
Subject: [PATCHv3 3/3] wifi: ath12k: Remove unused tcl_*_ring configuration
Date: Mon, 29 Apr 2024 12:50:39 +0530
Message-ID: <20240429072039.711706-4-quic_tamizhr@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429072039.711706-1-quic_tamizhr@quicinc.com>
References: <20240429072039.711706-1-quic_tamizhr@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DfqYTIfn-gIa52U-VYjPcS2f2dPRiYaH
X-Proofpoint-GUID: DfqYTIfn-gIa52U-VYjPcS2f2dPRiYaH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_04,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=1
 suspectscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=954 clxscore=1015 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290046

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



Return-Path: <linux-wireless+bounces-11409-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BF19517F6
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 11:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E6C281391
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 09:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE81416B391;
	Wed, 14 Aug 2024 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="knJ5OBAg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3CB16B385
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628681; cv=none; b=VM0hYXphcsdU24N2s6dRvPxK9qBpCk8cdDQYnq8pv7XXIFTLNDtBPEz1HKf1WiDu97Qad/CEzwOYmvXaZYiIFkCJoRA7XGG07xR1agJmXtWPFaZXtr5eJodjB2mHaiPyr9uJnpUCZA6TxX49MY7EtXTQR8xedKGurswALbI5z7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628681; c=relaxed/simple;
	bh=kNm0QL861+LhhixpTRwPEgzN8UpPZlLs4bz0dP/LNYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elA7uwvJUwQG4wFiYVCNTi2n6j7lcMDCoqV+k23J5b2R9ZtHmldwpckO1MqqGmKYDvL5B/EdJjTDpmbcjVHKz05X2Y23fFp+iZOzyPQAioddf3kGzl+NPOdATajcdr3AJt78y57pHwdp7GGpxbvevn4TOuT1oE5HgWUl79t0vCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=knJ5OBAg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47E0PmhT017641;
	Wed, 14 Aug 2024 09:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HI+XxlDrMvIEXXnQ9r+ZCxzc6iUN2VSJgoEkQSnsWO8=; b=knJ5OBAghaWamnfG
	t4BETzm4joSSWguw6jWOrsXBCPXMvdGwr7qjjUgMo8+r8Tb2hVXhGjYLTTKkjMd1
	qpXv7dBWu9DFoi/8mEUST82tL8MFWbY8n/wfwApDOaWJv5Aeac89xkULXY0Gz1ix
	Rs73N+Tu5R0XXMG9cAQcIcAGNIEECapTvyUB8/Xb2qmEbL1aUPKSvB0h5tPtKlWf
	EovoN0KGVbFceCIlJ8jQir5YqCxdqCe3UwLNuhE5fkLMFAbpEaS0jNXSZGdPoHu4
	vpUTLgHhx0OHJBU8s8sIjS+9MrKQCCGsxPVljEEsxHvRhSLh+2zsqE5+y7YSCdMz
	D6s3ng==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 410j1j9772-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 09:44:37 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47E9ibLI021771
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 09:44:37 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 Aug 2024 02:44:35 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Balamurugan S
	<quic_bselvara@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [RFC PATCH 08/18] wifi: ath12k: add ath12k_hw_hal_params for IPQ5332
Date: Wed, 14 Aug 2024 15:13:13 +0530
Message-ID: <20240814094323.3927603-9-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
References: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-ORIG-GUID: q-qwjoNITNWfGfOAy0ILTh_U4KPF1NHv
X-Proofpoint-GUID: q-qwjoNITNWfGfOAy0ILTh_U4KPF1NHv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=702 clxscore=1015
 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140067

From: Balamurugan S <quic_bselvara@quicinc.com>

Add ath12k_hw_hal_params for new ath12k AHB based WiFi device IPQ5332.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 7ef41524c0ce..fcf2b462263b 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1214,6 +1214,15 @@ static const struct ath12k_hw_hal_params ath12k_hw_hal_params_wcn7850 = {
 			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW4_EN,
 };
 
+static const struct ath12k_hw_hal_params ath12k_hw_hal_params_ipq5332 = {
+	.rx_buf_rbm = HAL_RX_BUF_RBM_SW3_BM,
+	.wbm2sw_cc_enable = HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW0_EN |
+			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW1_EN |
+			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW2_EN |
+			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW3_EN |
+			    HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW4_EN,
+};
+
 static const struct ath12k_hw_params ath12k_hw_params[] = {
 	{
 		.name = "qcn9274 hw1.0",
@@ -1468,7 +1477,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.svc_to_ce_map = ath12k_target_service_to_ce_map_wlan_ipq5332,
 		.svc_to_ce_map_len = 18,
 
-		.hal_params = NULL,
+		.hal_params = &ath12k_hw_hal_params_ipq5332,
 
 		.rxdma1_enable = false,
 		.num_rxdma_per_pdev = 1,
-- 
2.34.1



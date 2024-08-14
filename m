Return-Path: <linux-wireless+bounces-11407-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F579517F3
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 11:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9240AB23D3B
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 09:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D785D1684A8;
	Wed, 14 Aug 2024 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pKtdFFJN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB3016B74A
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628676; cv=none; b=jTBMcwAMpcf57hKNCMLl1K96lhp6Qf1eduZoB3AXyw83O3gn6XFD5gvFuPaEyoUbDxWy1TuY6Ymx5gr7o+cfYaXmQeHovfAm86wvLw4SU8FwlZAuoBVeoUiM/jTFVU7FdFIzuaOOFd8xmJm/mrRRYIfm4YhP+FMtDXxbpWfJGPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628676; c=relaxed/simple;
	bh=3YpeHgA0XCclxw1lXv1lj4LPaAwV5ILPAHe9lhD4gWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XK3zAQB89h4OBVRJaYTJ2bH20dbZIT6TSlTlJo+idl8sU0Nd2u9YBV2nIDT2L4xikDBsIsG+gkA+eYJOF151CI9tL19x6yG19g7IOi9NaBYdFsX470rsxCAwEIBah9U6YtygHLPV9It6cZ+Tpo8A4MQ1ne7e+3LgK0x7hRi8Fog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pKtdFFJN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47E2jNCo022989;
	Wed, 14 Aug 2024 09:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f6wlvm70J/9b9P1q4ZbNssFxXy+FAf3PMAR6oDN0LM4=; b=pKtdFFJNLtA3l2Jt
	WVQhmOXeZkb+6R8DLBneSXHA5KSq4q+bkPHT4U2mNWzRuCskRvfZiflYrWC35SAp
	iwHamiMYFmhctvLgibPc6+a03KhcG6dJZiRnp+8nGjyDpAvdyegfcw8QOYVA4VSv
	2Y/beOAjX5jcXn2253KTd/6xJyGK2g3tTYoq0B2IMJuLw825M626BaYxVePExMIv
	NPmxzcWiEN48dIc7H/g3J/PmNC0BBiemVUYtAdZ0VjEy40IiyQD8V4Sq/gUPBFXN
	+MTL3C9/LM4vu3g9UI9d1O65qNiOr2N75HeZlAFHTA8jPZVa0rynO96o6OAjMq6q
	6vN2gQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 410m290y6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 09:44:33 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47E9iWFc021531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 09:44:32 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 Aug 2024 02:44:30 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>,
        Balamurugan S <quic_bselvara@quicinc.com>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [RFC PATCH 06/18] wifi: ath12k: add ath12k_hw_ring_mask for IPQ5332
Date: Wed, 14 Aug 2024 15:13:11 +0530
Message-ID: <20240814094323.3927603-7-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: VezK95RavOvZZz1LTCyy8YgJ9bdsL5aH
X-Proofpoint-ORIG-GUID: VezK95RavOvZZz1LTCyy8YgJ9bdsL5aH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0
 impostorscore=0 phishscore=0 malwarescore=0 mlxlogscore=791
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140067

From: P Praneesh <quic_ppranees@quicinc.com>

Add ath12k_hw_ring_mask for new ath12k AHB based WiFi device IPQ5332.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Co-developed-by: Balamurugan S <quic_bselvara@quicinc.com>
Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c | 42 +++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index d1c0227cc212..25225d5c6669 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -573,6 +573,46 @@ static const struct ath12k_hw_ring_mask ath12k_hw_ring_mask_qcn9274 = {
 	},
 };
 
+static const struct ath12k_hw_ring_mask ath12k_hw_ring_mask_ipq5332 = {
+	.tx  = {
+		ATH12K_TX_RING_MASK_0,
+		ATH12K_TX_RING_MASK_1,
+		ATH12K_TX_RING_MASK_2,
+		ATH12K_TX_RING_MASK_3,
+	},
+	.rx_mon_dest = {
+		0, 0, 0, 0, 0, 0, 0, 0,
+		ATH12K_RX_MON_RING_MASK_0,
+	},
+	.rx = {
+		0, 0, 0, 0,
+		ATH12K_RX_RING_MASK_0,
+		ATH12K_RX_RING_MASK_1,
+		ATH12K_RX_RING_MASK_2,
+		ATH12K_RX_RING_MASK_3,
+	},
+	.rx_err = {
+		0, 0, 0,
+		ATH12K_RX_ERR_RING_MASK_0,
+	},
+	.rx_wbm_rel = {
+		0, 0, 0,
+		ATH12K_RX_WBM_REL_RING_MASK_0,
+	},
+	.reo_status = {
+		0, 0, 0,
+		ATH12K_REO_STATUS_RING_MASK_0,
+	},
+	.host2rxdma = {
+		0, 0, 0,
+		ATH12K_HOST2RXDMA_RING_MASK_0,
+	},
+	.tx_mon_dest = {
+		ATH12K_TX_MON_RING_MASK_0,
+		ATH12K_TX_MON_RING_MASK_1,
+	},
+};
+
 static const struct ath12k_hw_ring_mask ath12k_hw_ring_mask_wcn7850 = {
 	.tx  = {
 		ATH12K_TX_RING_MASK_0,
@@ -1208,7 +1248,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.hw_ops = &qcn9274_ops,
 		.regs = &ipq5332_regs,
-		.ring_mask = NULL,
+		.ring_mask = &ath12k_hw_ring_mask_ipq5332,
 
 		.host_ce_config = NULL,
 		.ce_count = 0,
-- 
2.34.1



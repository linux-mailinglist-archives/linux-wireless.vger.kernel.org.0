Return-Path: <linux-wireless+bounces-27904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A67BBC8B53
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 13:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D29188BD7A
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 11:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD832DF3C6;
	Thu,  9 Oct 2025 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bj3rKIKQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715BB2E093A
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008276; cv=none; b=Hz6aknxJ71wwBE0e2bxyF+hI9mL/UOIpppSRnj3j6ZZVhkeeZKKAPRextWG3PpEVeDLQqTVAs2i9oBW4pG4wBGee4rP0rjYORfubZbUyeHXs4pXCmSO/bDLceTTd/D+QDGo6ZmHdXAn9cojz6tbzp0UIojaI5Gb5xYOuW59AP3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008276; c=relaxed/simple;
	bh=e0R/KU6dwpjcnNOpyMgYmwWCbIbpaykow8n1Oqnrtc4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=af02+k85ZiH/XcAzfBAH9/uWtNzg7R+ivt5WKJOHolbfxnhM58F1splWcq64nInxjgIP2fYI5zTRO8vI7Rx7Z2ltaAGsISOVdqnb1f9W9FsKQaghoyWGhQk006+P9vv0djXDw5ozU+Ztwo6uZxjT9qiLv2TmlE1d71s2/Fy8NvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Bj3rKIKQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EgEe022541;
	Thu, 9 Oct 2025 11:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d462OtAVwzlJkjANvTb3BwAtXgr1GzRu102yV7Eu1ys=; b=Bj3rKIKQ5NGQOahG
	thoMySSLCY9Y/PoHMZDjTV4YyQiFzMQlX2FI173Yv+IntsE5XYUyMaPg5p9UDS89
	e4kRm30sMkbmuLX8GbS71eJkEiyzlotk2vRLgAE2aNqmH24hYxPi07l4DSTlov48
	yD6mpjq0SQdEAZKh9BKJ341DpfMZzvhMnx085wcvqwqy+bUYADWUZkOYVtXqbfwj
	OxGNmZvl0nNmArd5UOkd10joFM2uBuRacRNmmYFnPMwWKQ2hd0Ud1NACF5eQhr8T
	j1s32Y0jeXz55PlkTIkLUGXNMI3LzkP0YJ5oyPfsalyvbwQGV+AI1NZvN/wQr17q
	3i+jDg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4sjgr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:11:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 599BBAfe021635
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 11:11:10 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 9 Oct 2025 04:11:09 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 06/18] wifi: ath12k: Add direct HAL pointer in ath12k_dp
Date: Thu, 9 Oct 2025 16:40:33 +0530
Message-ID: <20251009111045.1763001-7-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
References: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-GUID: cbho-jUzj5rOo9MJIp59ihts5fcRI9pk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXz6RwguNxTpwz
 TsWtShFE7Abs56gQs+jbUExuZAwfJVWDjQLGUh83MnTgP9Ez1EF6l5y06j/CoZsivqH2jK4tYBL
 /U3p1uADv4eHsKIwPB0JmiptUwgrNfVBFmfy7rFZqUWelmVG5vRgWxRsJCgzxFdjvsQCnn2RrTD
 xmnmIgx3312bVBnkMnN8o2r9GtX/AT8UuxlBgAflyxeVczkf/fFSVh5scpUxzxgYlelAWq5ILyd
 wcTdiQ64gxBy1GsfDlRX1Q2viEma6mmxl2eLYCNV7juA5IGBGI31KEijyxGKnZvqfEOkUW8ae9j
 mqiCMLgyxEsL8JIGEYnULT/qBal59RXOLQZN9xr3FQUZkwhhrSG92k7qTI1EldrPV2jQxyd2JVz
 R9iTMY8uJUiw+U+qOlHF3ARysJJSHw==
X-Authority-Analysis: v=2.4 cv=SfL6t/Ru c=1 sm=1 tr=0 ts=68e7984f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=ZvKp1mPiiKzcst2GRK4A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: cbho-jUzj5rOo9MJIp59ihts5fcRI9pk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Add a direct pointer to the HAL context in ath12k_dp. Since ath12k_dp
is frequenctly used in the per-packet data path, this avoids the need
to access the HAL handle through the ab pointer, reducing indirection
in the per-packet data path.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.h       | 1 +
 drivers/net/wireless/ath/ath12k/wifi7/dp.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 284e89f7c4b8..9690e3472ab7 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -447,6 +447,7 @@ struct ath12k_dp {
 	struct ath12k_reo_q_addr_lut ml_reoq_lut;
 	const struct ath12k_hw_params *hw_params;
 	struct device *dev;
+	struct ath12k_hal *hal;
 
 	/* RCU on dp_pdevs[] provides a teardown synchronization mechanism,
 	 * ensuring in-flight data path readers complete before reclaim. Writers
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.c b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
index 4465a9e93bf8..e691d0ca0d75 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
@@ -152,6 +152,7 @@ struct ath12k_dp *ath12k_wifi7_dp_device_alloc(struct ath12k_base *ab)
 	dp->ab = ab;
 	dp->dev = ab->dev;
 	dp->hw_params = ab->hw_params;
+	dp->hal = &ab->hal;
 
 	dp->ops = &ath12k_wifi7_dp_arch_ops;
 
-- 
2.34.1



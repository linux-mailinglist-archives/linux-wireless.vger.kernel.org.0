Return-Path: <linux-wireless+bounces-12153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A52A9624F4
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 12:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1D98B2233E
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBB715445E;
	Wed, 28 Aug 2024 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m6Az41Gl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B3157490
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841109; cv=none; b=Nr8lqJu1jqPYmMhtdL3cvP/1dAG8zPFyncw8X8cSq8/wE9LNQyu29cmjXJMPAFS4EZFsAWWOAQVpXDvZbFI4EXDyTNGW5eVEvzuzzsUrpXQv+N0xpToXwskxdXFPcMu6ZYy6B3J+y9TrvAI7H9C/9ReKUxTdrBIZ1Hp6R0P9PgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841109; c=relaxed/simple;
	bh=k7A8lvQdZwiCncrzmvmZPif1DKQXI9+dxdKcHg/ol4U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r2vmFAKTg96q/kj1SOczKAepM51AkxwdR64OS5t+nLm70jgX3uKTq8DOutdBvfuGXopKQdjWLJFEw593Dm/sUngJ/W5TPk/1NtSkUEL+17FVUvP3YAUmEGEbzJamY6k5mkZwhxpcqSybMj119P8zAnFpG9uleRlsfaRSYYJb2P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m6Az41Gl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RLaJkI018472;
	Wed, 28 Aug 2024 10:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=9EeD85IakjAuYppGv5vgPSKu6GDWaXAcXSCdg/hNl18=; b=m6
	Az41GlC1QjlOT1/VsgTNEMi9hrA7FXZ7ANuumlAHfpRPuI0N+Qs1PJqjCTHoRJa4
	uXHwDRNqRwJ/V6hCb0iupQ/gvPVtHi9uqpcqqLNo8zklRnRJkBCIYZDdG+Y4wf5s
	4SzcujyoWcGW70UsO0JZwxlGm3WyYekbaEImEWif2x7Z4ZC2V4R+K0tFKstMGfFJ
	ZZafK40BPiwoWVyzUHTdrzgz7FEbdgEj90bMGuoVLcT0tdJ5NdCPb/Odh6V8zmVd
	d1V780su+bMYXgvBIviAzuFCzJS8m5OOh9ENZTOcLKZrySR3v2sqKxbNDyeRGFSY
	EyuPU9I0BVUVzPrKVX2g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419pv09f51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 10:31:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47SAVfb2010730
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 10:31:41 GMT
Received: from hu-bpothuno-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 28 Aug 2024 03:31:39 -0700
From: Balaji Pothunoori <quic_bpothuno@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Balaji Pothunoori
	<quic_bpothuno@quicinc.com>
Subject: [PATCH] wifi: ath11k: enable fw_wmi_diag_event hw param for WCN6750
Date: Wed, 28 Aug 2024 16:00:43 +0530
Message-ID: <20240828103043.2413-1-quic_bpothuno@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OMN3aDhdVyyOnRX_lvAiDf15JW1-cdJ_
X-Proofpoint-ORIG-GUID: OMN3aDhdVyyOnRX_lvAiDf15JW1-cdJ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_03,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408280075

WCN6750 firmware sends the log messages via WMI_DIAG_EVENTID only
when the host driver enables the same via QMI_WLANFW_WLAN_INI_REQ_V01
QMI message. This is further controlled via fw_wmi_diag_event.
Hence set this flag to true for the firmware to send the logs.
These logs are further collected in the user space through
the trace infrastructure.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.2.0.c2-00233-QCAMSLSWPLZ-1

Signed-off-by: Balaji Pothunoori <quic_bpothuno@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 03187df26000..6bc10cbb493e 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -616,7 +616,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_dynamic_smps_6ghz = false,
 		.alloc_cacheable_memory = false,
 		.supports_rssi_stats = true,
-		.fw_wmi_diag_event = false,
+		.fw_wmi_diag_event = true,
 		.current_cc_support = true,
 		.dbr_debug_support = false,
 		.global_reset = false,
-- 
2.17.1



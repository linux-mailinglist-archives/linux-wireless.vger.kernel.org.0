Return-Path: <linux-wireless+bounces-15477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853EE9D1C92
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 01:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E5F282C7A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 00:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD4D3B298;
	Tue, 19 Nov 2024 00:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L6B3jOl/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E3520328
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976396; cv=none; b=oys4zq9MBn0dEMBsBC7fIclHSt6X3peYtaw/I6c7ZR27QwHiLvDEb7vW87llTO7G7/lAYT2DihL6tSSwte/P0Tzav5AePvCdw7xOTliiq4ejOobSz6fEZHljX4vxQjMu65dKw0hIzyarGl9QZyEk7yeqXLI62NzW0jTS8fo4sEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976396; c=relaxed/simple;
	bh=f/GQm1+pHiHSvXziHN0r4ProvY548rRGq9G/meiiAWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lpao2WOkqWIm+e2hXa3nv8IJuFr5w0ggM8Ney4qOiji0KUti5hoNsi7CIYXT5sf6Rhv97Jcgrnovqdt5Z/W6I9K5pz45L/Kgeu64xGwp4sAeZysWUcfN2l1j7z1X0ETB1HbuRLZXszQHKVdS/iH8dAtpSvyJZGf37nnAxUPDdB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L6B3jOl/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGHW31031135;
	Tue, 19 Nov 2024 00:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3SRWvw5/ph/RzPFvkOTfbCXZUVWA6GS6nyUnGFKn/pU=; b=L6B3jOl/T3fihkOk
	dFZpd3Y2KZCf/9/0H7QZR3QvMP5A7oF4EYS94tMQbV6iAbg+iwI1Fv6df8fyBVn5
	1uNTZMXfT/SYmcqqtfT0IQNPMKl7dP4NdgM70fTx3Qe4QqzXvr2f+Ue/iHYMEu6b
	DsP4WWBRCpO4ieAv7rfxBRXTS7vwwQlH9XoQuekCe8Q1LS8eWd7pNcHnS3oAuJml
	weP6MxpOwf+tkMrYcXYRtLnj3jlIksGku1+WPvbiH5FYzvmTC0FMa9HzQUFb136W
	s4hw+N+rNDpHBsS7Ht2yL740IZRfsr4awj0S4UFJofFAGPK4ofBzzxDKFgLxoau0
	famKRw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y68y7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 00:33:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ0XCxg020655
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 00:33:12 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 18 Nov 2024 16:33:10 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 4/8] wifi: ath12k: Fix the misspelled of hal TLV tag HAL_PHYRX_GENERICHT_SIG
Date: Tue, 19 Nov 2024 06:02:44 +0530
Message-ID: <20241119003248.1579567-5-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119003248.1579567-1-quic_periyasa@quicinc.com>
References: <20241119003248.1579567-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: hgw7ASeJKAqkoj1LYkS_xlye2ZK4LVr1
X-Proofpoint-GUID: hgw7ASeJKAqkoj1LYkS_xlye2ZK4LVr1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=901 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190003

There is "HAL_PHYRX_GENERICHT_SIG" misspelled as
"HAL_PHYRX_GENERIC_EHT_SIG" in the comments. Fix the spelling.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal_desc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
index 739f73370015..76d4bb8690ea 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -522,7 +522,7 @@ enum hal_tlv_tag {
 	HAL_PHYRXHT_SIG_USR_SU					= 468 /* 0x1d4 */,
 	HAL_PHYRXHT_SIG_USR_MU_MIMO				= 469 /* 0x1d5 */,
 	HAL_PHYRX_GENERIC_U_SIG					= 470 /* 0x1d6 */,
-	HAL_PHYRX_GENERICHT_SIG					= 471 /* 0x1d7 */,
+	HAL_PHYRX_GENERIC_EHT_SIG				= 471 /* 0x1d7 */,
 	HAL_OVERWRITE_RESP_START				= 472 /* 0x1d8 */,
 	HAL_OVERWRITE_RESP_PREAMBLE_INFO			= 473 /* 0x1d9 */,
 	HAL_OVERWRITE_RESP_FRAME_INFO				= 474 /* 0x1da */,
-- 
2.34.1



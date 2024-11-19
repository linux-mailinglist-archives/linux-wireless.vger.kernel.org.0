Return-Path: <linux-wireless+bounces-15479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A88F9D1C94
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 01:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02020B22FB8
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 00:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6969CE57D;
	Tue, 19 Nov 2024 00:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T7REB4Ll"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D423AE571
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 00:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976401; cv=none; b=BcGrLOj8B2jKmWzkTkGQnM3q9DMWDdTBlGB/QbnI2C8Ah6aP9+IAiGTueH5sae9E626wlH57fxu+blVmblbH7tSi409R8lTJI4EqJrVe2LWMQgAP7EtHJSPM50vFr1ptJ+Q/1x5lN7VDcf+LYk0aOTMmDYJZuvwfhI8dLozfSuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976401; c=relaxed/simple;
	bh=A6MXMJQXE3HKZbJ4hhRQ7aAty4t9X8WGISw7KseWIOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2JeGt6rZkjHwYIRGA6wYM+/Xkt/Yeah+YVqUNcYx4eJi2yfKY8onfat5Ug1qzOmyOnk+Hsb8uwnPsjAWL+0fxb3BrtbIE6wTfwvCbxoJMFdmHKaQre4u38FP+rk9vQ2FgLXpvanlgq7udC1NbHqmpQtFXyvKaxbVsj4TTdMFB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T7REB4Ll; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGGdZA028413;
	Tue, 19 Nov 2024 00:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pNKjJpg1HaXNthmvHnu8HjZqIWFP+BKvOEKnmldqaII=; b=T7REB4LlMBd+iWen
	Le6ovSASgpFqKtzKU716HxV+J9LAiiBQwHP0FD0ww10KUGUZZSOAas+34BjJk3MI
	hH5XmmbS5MkEHLzX+FnY89yQl1EPiRy9LwdmuquhaSwJ18P6q46Zpa0K0gTFjW7F
	+hO2ESbUDHtzB40MJZQ0saiueupSvIl56Mdm/Q44Wsgn/battjeUK4Ervn1GgSUe
	EtEMffY/hxLYYXQTFnL1BZLViBtnkz8jIsIdIf45lgLrOKgEYi2UY+GHKZvKaCy5
	qT7FDJKFn0qbAlli+K+P8E0QMJ+XgnbA5s8wYO7Sm6C87xiNJoJDoD9waFIYLK+n
	RUIMiw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y5rxu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 00:33:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ0XGHD022910
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 00:33:16 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 18 Nov 2024 16:33:14 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 6/8] wifi: ath12k: Remove unused HAL Rx mask in DP monitor path
Date: Tue, 19 Nov 2024 06:02:46 +0530
Message-ID: <20241119003248.1579567-7-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: nY2NhzUmb5kBW1Wkb0NK3UWybrtAs7wj
X-Proofpoint-ORIG-GUID: nY2NhzUmb5kBW1Wkb0NK3UWybrtAs7wj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=656 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411190003

Currently, CODING and TXBF are unused masks defined in the HAL Rx monitor
status TLV parsing code path. Therefore, remove the unused masks to
prevent incorrect assumptions for code readers.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal_rx.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index 5cf3c5787ab7..b08aa2e79f41 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -398,11 +398,9 @@ struct hal_rx_he_sig_a_su_info {
 #define HAL_RX_HE_SIG_A_MU_DL_INFO0_DOPPLER_INDICATION	BIT(25)
 
 #define HAL_RX_HE_SIG_A_MU_DL_INFO1_TXOP_DURATION	GENMASK(6, 0)
-#define HAL_RX_HE_SIG_A_MU_DL_INFO1_CODING		BIT(7)
 #define HAL_RX_HE_SIG_A_MU_DL_INFO1_NUM_LTF_SYMB	GENMASK(10, 8)
 #define HAL_RX_HE_SIG_A_MU_DL_INFO1_LDPC_EXTRA		BIT(11)
 #define HAL_RX_HE_SIG_A_MU_DL_INFO1_STBC		BIT(12)
-#define HAL_RX_HE_SIG_A_MU_DL_INFO1_TXBF		BIT(10)
 #define HAL_RX_HE_SIG_A_MU_DL_INFO1_PKT_EXT_FACTOR	GENMASK(14, 13)
 #define HAL_RX_HE_SIG_A_MU_DL_INFO1_PKT_EXT_PE_DISAM	BIT(15)
 
-- 
2.34.1



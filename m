Return-Path: <linux-wireless+bounces-15478-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2225A9D1C93
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 01:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBDFE2815CB
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 00:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08513BBE5;
	Tue, 19 Nov 2024 00:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XrSu/BAB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5084A38FA3
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976396; cv=none; b=r8Wt+DcTMGVAta6+/6CjKtM8du08+ed2OEtgxfIAZOK1ki68a1n5V9LB+KEvv9jqCJQbnX3sp+x107iNCj/FyseV3UlLPGKZeelChspgx2KWeHHv+WcRzF/blxFOLMmI1TgdIE0akcrN142KryJaiXYn9nNvT8XSMebTU+5EnQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976396; c=relaxed/simple;
	bh=PcPYoULIrq5D59UwKMljCDFqyR553QEtuW3I7Du9/V8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZoMJmPNCEWM2a4TvBtKxcC33eTIckWU8zKTnCELe9bP/EQi3UC7Bzch0km9jgXr0tnFU0/mfUGW4FHTwiT+OF8tooUmksD8jaEv2bWQ7UnZizL8MR0drgwloCTL3Q41X4R9C3VX1oaBuAjXABKB4ceIKwYXj/3VSn2GtrVx/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XrSu/BAB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGGdXB004697;
	Tue, 19 Nov 2024 00:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qlheq+DYXe4f3RL8SlQ+dxyhiJJIFU/YEUK/AQ5DPzI=; b=XrSu/BAB/N8PYGzI
	1RuzuJh28yh5nbu4jAnx+Nr6X4UJczqJiAQP5PKV7fve2xvM3RnzOZSPJgTdDhl5
	e0Ip5kiQhHjF+SZBac1nOaW0VJmmwhXTqqfBeTlXUBPI0Jzlm7jlyV5RBYqU/+pP
	0CEfj6MVV2jxc3ITTmL/x+OUqSpSshMLptcCqWKZKP5sQlYfau0gNkCWxCWyy4Iu
	SWUxzWoPGzP7Pl/j3I8vXvXVJCvlxgo36EmCYvsNeogJB6xLwa4MxOFYDL0HtzvN
	BcSMxDu3tNUu0+wTBgOrqcdvM0SrAjPaAD719ayFoTURKCsn+M/J7e7ZUXS4GJjZ
	vx/v5g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y7rxjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 00:33:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ0XAjf012875
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 00:33:10 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 18 Nov 2024 16:33:08 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 3/8] wifi: ath12k: cleanup Rx peer statistics structure
Date: Tue, 19 Nov 2024 06:02:43 +0530
Message-ID: <20241119003248.1579567-4-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: oJaNs6eXFxvcaeAwIPBp1oHA6p-QULA8
X-Proofpoint-ORIG-GUID: oJaNs6eXFxvcaeAwIPBp1oHA6p-QULA8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=851 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190003

Currently, unused fields are present in the Rx peer statistics
structure. These fields are already present in the same structure
under the ath12k_rx_peer_rate_stats container structure. Therefore,
remove the unused fields from the Rx peer statistics structure.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 8dbdf6818f58..481713f7e4e5 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -372,10 +372,6 @@ struct ath12k_rx_peer_stats {
 	u64 non_ampdu_msdu_count;
 	u64 stbc_count;
 	u64 beamformed_count;
-	u64 mcs_count[HAL_RX_MAX_MCS + 1];
-	u64 nss_count[HAL_RX_MAX_NSS];
-	u64 bw_count[HAL_RX_BW_MAX];
-	u64 gi_count[HAL_RX_GI_MAX];
 	u64 coding_count[HAL_RX_SU_MU_CODING_MAX];
 	u64 tid_count[IEEE80211_NUM_TIDS + 1];
 	u64 pream_cnt[HAL_RX_PREAMBLE_MAX];
-- 
2.34.1



Return-Path: <linux-wireless+bounces-8466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 083568FAAB6
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 08:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF3C1F22B41
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 06:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F82136E2B;
	Tue,  4 Jun 2024 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QzF6EF+s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3077B65F
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 06:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717482421; cv=none; b=t82v9CDXCBNho5Tr0nJOnRrM8CPpThpLgzIE42Vnh+X67uwOOX2HZM9/NFL3F/QOayDmPAg9eeMaXV07p2Aj2bqnhA9CqiJtt7M8ljVviOj6s9ecGdRrX1gN6G363AYVSsRcGWTpq2nVYa1gYCTI0TkRVoGqqbgZLUTZvhC44Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717482421; c=relaxed/simple;
	bh=Mchl8aUb1KYJMe1CoATDEQ/A1EEj3104fYiKo0GduEo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DP+IyhlakISMuzw7MGRFlhgfwomufUuYF5MHsFoCb5ArcZFT+Nnwh4uwQnIY3IYkkt2S0ki6J6CE/esYglcxNGARCEAlKj3FoPYgasrUX9tVIRKZgosWz0AN3zDWl7rKLFNoKsNZf3nP4H+0PMpiMm0lf3OIgpUxMa1LbK+t+cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QzF6EF+s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453N13oU001552;
	Tue, 4 Jun 2024 06:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8CP5EFDC5Z1q3FYqUkR3iq
	QgAqGx8EVTHVM3KUEuD9A=; b=QzF6EF+sNGOcN7yss58h2MRxKuOegt/Jwn+lyG
	cLnA8FMANrp+421Usk0M/CC4BsA2C/7iIPBaSwsDfmMefZI1TgnkGPUWNploVHUG
	A4egnfXy74kdxXwKQMEc6HCHC8TwL8ddfMstShVp0/Dh9kZxR/A4A0H7BEYci5WC
	r0d+FsRGRtJ+AcIL2GZ1S6JzO8En068eqeU2JoEOwCsAZX7kLOw2u/KEKqdRtXTO
	2KxQTEnmiIVwX52pMVGQ/0XLoHCzua+KcP2Exnnp86+qwk4GXKoK+8Hu2/XGprpH
	Zf5hP6bdvygKPGbbicJxDM7VXIa8yHcEypEnK3rbqUQc4Ngg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw6v62p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 06:26:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4546Qtck026237
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 06:26:55 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Jun 2024 23:26:53 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH] wifi: ath12k: avoid unnecessary MSDU drop in the Rx error process
Date: Tue, 4 Jun 2024 11:56:41 +0530
Message-ID: <20240604062641.2956288-1-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: xCV4x4bBHxQJNzKRVIcsOJZ3-3_9kuck
X-Proofpoint-ORIG-GUID: xCV4x4bBHxQJNzKRVIcsOJZ3-3_9kuck
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-04_02,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 mlxlogscore=855 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406040050

Currently, in the Rx error processing handler, once an MSDU drop is
detected, the subsequent MSDUs get unintentionally dropped due to the
previous drop flag being retained across all MSDU processing, leading
to the discarding of valid MSDUs. To resolve this issue, the drop flag
should be reset to false before processing each descriptor.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index cb1f308f096b..54aea3c22311 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -3402,7 +3402,7 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 	struct ath12k *ar;
 	dma_addr_t paddr;
 	bool is_frag;
-	bool drop = false;
+	bool drop;
 	int pdev_id;
 
 	tot_n_bufs_reaped = 0;
@@ -3420,7 +3420,9 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 
 	while (budget &&
 	       (reo_desc = ath12k_hal_srng_dst_get_next_entry(ab, srng))) {
+		drop = false;
 		ab->soc_stats.err_ring_pkts++;
+
 		ret = ath12k_hal_desc_reo_parse_err(ab, reo_desc, &paddr,
 						    &desc_bank);
 		if (ret) {

base-commit: a116bf2be795eb1db75fa6a48aa85c397be001a6
-- 
2.34.1



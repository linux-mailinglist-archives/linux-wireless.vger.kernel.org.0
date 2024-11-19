Return-Path: <linux-wireless+bounces-15480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C919D1C95
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 01:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E2B7B231E8
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 00:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80635101EE;
	Tue, 19 Nov 2024 00:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dojkb6Uh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACB0DDD9
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 00:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976401; cv=none; b=LsS903uru2SZOfv8FB4/cf1qev7GkM+eVCCJJOIUhd+iypW6+X9A2ZYQcFzSRXVjEe6Od0/LXKaA6NGx0Oz5jOqx/aTJthiUB2iNfnxBEfV3PPSOxZn60Ipxm2Nq8RDdg/tQDcbEK/qc9Ou43siKJ/xcyN5aOupqC77LIF1Kh2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976401; c=relaxed/simple;
	bh=SixEKpH15K81QRxZMLeUJva6z9JLWBz04jAp8npQ7FA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ek4aC+r/o6p1hFSwCeEKA+rzV+0TN8mA2Qg9R1Jw60n6l1KRjluRL+bjCZm62ffqWFpfWMINTDsKp1m8bxpoTOpc7wsRid6L8zwDRK+q7c4HmXiB3/1kvzyVyg+jYfp9sGIjURCJzyVImCSwt1Ha/BaHadI2cFMRN8omKwxTi9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dojkb6Uh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGGe5E004702;
	Tue, 19 Nov 2024 00:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UDIDFaY7KExs1xLk46mn4am6YM0P7GmV6uJeS1m6MI4=; b=dojkb6UhELbv8o5t
	cUr2vSpD/ccAfd9CyJR4zqMvc+kNqpgIOQTPfUsG1i4Vh9Rh44R202G9cJWL4R4y
	eSjeayJWX15tQV7yJxUp17MsxnpISD2Y+9/jEcOUOxDGYGvdMEGSMj2zOI1shI9K
	aCCLa1Z2q3GFa9KpEAPOHJWy2+aC8z1MIEgRLZEnF6Z+vcPOKyZzgjsD6/fQtbd0
	7tC0JU7n510XoPw+QpfH2Sa08RZAXC6fTjJeMZ982R4dxFbtPEa5vy1hVxzI1U0G
	1bX7qjmClue840R4MCCIfTjfkEGZxS9F/m+/dglR2Y6HkKw4tQSgCufPI+ILY65Y
	rK3oeA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y7rxjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 00:33:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ0XE3H012746
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 00:33:14 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 18 Nov 2024 16:33:12 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 5/8] wifi: ath12k: fix incorrect TID updation in DP monitor status path
Date: Tue, 19 Nov 2024 06:02:45 +0530
Message-ID: <20241119003248.1579567-6-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: qAQQMNozFAVYqIG1gJ4_GtaHqHxYMFhC
X-Proofpoint-ORIG-GUID: qAQQMNozFAVYqIG1gJ4_GtaHqHxYMFhC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=629 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190003

Currently, an incorrect TID value gets populated in the monitor status Rx
path due to an incorrect bitmap value given to the ffs() built-in helper
function. Therefore, avoid the decrement and directly provide the TID
bitmap to the ffs() built-in helper function for the correct TID update
in the monitor status Rx path.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 494984133a91..37127771291f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -617,6 +617,7 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
 	case HAL_RX_PPDU_END_USER_STATS: {
 		struct hal_rx_ppdu_end_user_stats *eu_stats =
 			(struct hal_rx_ppdu_end_user_stats *)tlv_data;
+		u32 tid_bitmap;
 
 		info[0] = __le32_to_cpu(eu_stats->info0);
 		info[1] = __le32_to_cpu(eu_stats->info1);
@@ -629,10 +630,9 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
 			u32_get_bits(info[2], HAL_RX_PPDU_END_USER_STATS_INFO2_AST_INDEX);
 		ppdu_info->fc_valid =
 			u32_get_bits(info[1], HAL_RX_PPDU_END_USER_STATS_INFO1_FC_VALID);
-		ppdu_info->tid =
-			ffs(u32_get_bits(info[6],
-					 HAL_RX_PPDU_END_USER_STATS_INFO6_TID_BITMAP)
-					 - 1);
+		tid_bitmap = u32_get_bits(info[6],
+					  HAL_RX_PPDU_END_USER_STATS_INFO6_TID_BITMAP);
+		ppdu_info->tid = ffs(tid_bitmap) - 1;
 		ppdu_info->tcp_msdu_count =
 			u32_get_bits(info[4],
 				     HAL_RX_PPDU_END_USER_STATS_INFO4_TCP_MSDU_CNT);
-- 
2.34.1



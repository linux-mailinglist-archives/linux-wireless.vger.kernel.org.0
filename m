Return-Path: <linux-wireless+bounces-16678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CA39F9E46
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 05:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66B31892F07
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 04:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452101DEFE8;
	Sat, 21 Dec 2024 04:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G+cxdO8b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F391EC4C9
	for <linux-wireless@vger.kernel.org>; Sat, 21 Dec 2024 04:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734755495; cv=none; b=EbHY1qNt94z6Hjnhlg8C6PImXvochKPDHH2e9JykePZ1W8bBBvsObC1GgoxDngSfdOlbfvdtzuthqcV1hlY+3k4kb+kjzJfjUO+lqyjvL725X8W96ao2duRUEpGvt4+Pq348TmKeF+jubh3xTxocgWg3E3h8CRYjHyv9U/gtNas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734755495; c=relaxed/simple;
	bh=OxWogqG1KJ9Kn48vD41J6AMLr3hy88+WIl/yO7JxqzY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8ddvuGchfCqCIiEoFSG60buS3QtFKV/6hjMpwYitdK9sYsUd56MkWMOXw9L0pSk4AnESJXvE8POYwfj8gAiUFI+g3o4fc6WkzXw3r9s/7Ur5vT7p/pavQnCsK6FyTQRPOWoPQK4Chw0o91dxkO8VXsVXs0Y55b1S4G+iTEIxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G+cxdO8b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BL29ChH031629;
	Sat, 21 Dec 2024 04:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J5mP4p+HWYZf73Sj9F0DdpPky+siigckD53zfda/AbI=; b=G+cxdO8bpL9KkvkW
	Uj6iKffC/I9PkfpLrNOfNIcC/QDyUE4f5gJRyMSFCPVppfBmpzc6v/vk645vypHr
	wBoCgN+LuebVQdTmYpG6+G694aB7+8NNW0g35WX35sTlu8yMdv6+XBYRyNymYoH5
	SrjoI+66/czDb3z2DqI+WQ++fdcc1IS7GLpnAPbVBXFNsqYh3uwTirXPQFdbvdrP
	G3cJAKwjXqihjBjFJgnCoKhPA6tdx8+FhyP4xMG23fNetfD1BJyV4gSzxT8kLf3y
	6Z/gzKbW45KjWGXhGQGQl2gWbrqnc39oKGbIEOigNAbS7KOB371GT2SO7rePjsFJ
	2np0Fg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43nmmqg9q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 04:31:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BL4VVTj032504
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 04:31:31 GMT
Received: from hu-ppranees-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 20 Dec 2024 20:31:29 -0800
From: P Praneesh <quic_ppranees@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH 11/14] wifi: ath12k: Handle PPDU spread across multiple buffers
Date: Sat, 21 Dec 2024 10:00:11 +0530
Message-ID: <20241221043014.1252841-12-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241221043014.1252841-1-quic_ppranees@quicinc.com>
References: <20241221043014.1252841-1-quic_ppranees@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -C4Fsa_DQ8-V50H1n9Rqy0hgJ73D11zn
X-Proofpoint-ORIG-GUID: -C4Fsa_DQ8-V50H1n9Rqy0hgJ73D11zn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 spamscore=0 mlxlogscore=798 priorityscore=1501 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412210035

Each PPDU contains numerous TLV tags. HAL_RX_PPDU_START marks the start
of the PPDU, and HAL_RX_PPDU_END_STATUS_DONE marks the end. From the
monitor destination rings, the driver retrieves skb containing these
TLV tags and their corresponding data. Sometimes, one PPDU’s information
spreads across multiple skbs. The current parsing logic uses memset on
struct hal_rx_mon_ppdu_info after parsing each skb, leading to information
loss if a PPDU spans multiple skbs. Fix this by setting the
ppdu_continuation flag when the driver fails to get
HAL_RX_PPDU_END_STATUS_DONE, and do memset on struct
hal_rx_mon_ppdu_info only when the ppdu_continuation flag is not set.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 8 ++++++++
 drivers/net/wireless/ath/ath12k/hal_rx.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index a11b39ae3774..4b35dfcbdfe1 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2419,9 +2419,17 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 	if (!num_buffs_reaped)
 		return 0;
 
+	/* In some cases, one PPDU worth of data can be spread across multiple NAPI
+	 * schedules, To avoid losing existing parsed ppdu_info information, skip
+	 * the memset of the ppdu_info structure and continue processing it.
+	 */
+	if (!ppdu_info->ppdu_continuation)
+		ath12k_dp_mon_rx_memset_ppdu_info(ppdu_info);
+
 	while ((skb = __skb_dequeue(&skb_list))) {
 		hal_status = ath12k_dp_mon_parse_rx_dest(ar, pmon, skb);
 		if (hal_status != HAL_RX_MON_STATUS_PPDU_DONE) {
+			ppdu_info->ppdu_continuation = true;
 			dev_kfree_skb_any(skb);
 			continue;
 		}
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index b08aa2e79f41..294583edd7a2 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -231,6 +231,7 @@ struct hal_rx_mon_ppdu_info {
 	bool first_msdu_in_mpdu;
 	bool is_ampdu;
 	u8 medium_prot_type;
+	bool ppdu_continuation;
 };
 
 #define HAL_RX_PPDU_START_INFO0_PPDU_ID			GENMASK(15, 0)
-- 
2.34.1



Return-Path: <linux-wireless+bounces-18009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0FFA1D4BC
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 11:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CF03A2A72
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 10:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E551FDE33;
	Mon, 27 Jan 2025 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e2xZJWEr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C741FE44E
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737974893; cv=none; b=Oiz9q+wKYlNDglG6TwUwPe4dx8uccZFnKsn3SF/RMxX+h2lRImvEadtWUBhhuFI/dhXVyjHLGMzzZUPZnR2FKUyMKvBBhKKlNxcsRxaxnesDzDUk5QLWG6EKh/qYgwN3dFAZJL7hZKZ7WEQZro0NuMQOm2Es7E8Cjo0C7R0wRFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737974893; c=relaxed/simple;
	bh=pww7BNSVfrSEZVRCaIwH8nVVB/enw3HyG5KrNsKDMhI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W142/qjdOb7lzfFqxXkuzYmUyfxlmcWsqX4JmgMymG0n1dvqDlliKkyJt0JYYIzik1uciIYH+Nr/EayMtjqFLFPlvitKUinNALlExuHfOo+QHbhFWWLvF/ofyVJoR1XSQrzSfViAAACg/eknuHIYlygGMqwpvSfhw3bnmG954cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e2xZJWEr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R9ksNX026623;
	Mon, 27 Jan 2025 10:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AGxAKAgEDcrh+KwL66bI4VNMtglapOhK4V7W4mEckIs=; b=e2xZJWErxOHdNprT
	CI9z+GoJ+6VmUaxrghA0ypJdPVE8Kj3Nw0EhgYyW5rlZMMm0ggx24ytwfulW3xh1
	WKwhMSQYsHWwjoeCxg9+1MY+l439rXVGpAoKGDBvgqngH6NQa6ku2Oe1QGkfjE0z
	UV+L1TsgBdlGznPMeWqf2fpLPweSQ1PLIzTIp7IMDthMUXsoslG7Jv1Pm6Yt5OdF
	TAWIOhfBGgBK5sBhWU/Sr6UDD0flp4YarEuf+4xB4grwkLJNKV47uEdZ89W2N1fq
	XceY1gaHFSHFlaHzZi7z97c/q/i8tF3B3y9Bae31MuEpOuCntVA3LLI8S+qncqCW
	m24URg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44e7tj839m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 10:48:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50RAm70X007065
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 10:48:09 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 27 Jan 2025 02:48:06 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH v5 5/9] wifi: ath12k: Update the peer id in PPDU end user stats TLV
Date: Mon, 27 Jan 2025 16:17:34 +0530
Message-ID: <20250127104738.4174862-6-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127104738.4174862-1-quic_periyasa@quicinc.com>
References: <20250127104738.4174862-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: A6-BuX_4JV9RP3eQ7UU827xDjP0omXqV
X-Proofpoint-GUID: A6-BuX_4JV9RP3eQ7UU827xDjP0omXqV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270087

Currently, peer id get reported in the PPDU end user TLV tag. But the
monitor status handler is inherited from ath11k, but it was not updated
to incorporate the changes made to ath12k 802.11be hardware architecture.
Therefore, update the peer id from the PPDU end user TLV data to get latest
peer id update, it helps to populate accurate peer information on the
statistics data.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 8ded73d87c73..8c283e7c7dde 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1535,6 +1535,9 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
 		ppdu_info->num_mpdu_fcs_err =
 			u32_get_bits(info[0],
 				     HAL_RX_PPDU_END_USER_STATS_INFO0_MPDU_CNT_FCS_ERR);
+		ppdu_info->peer_id =
+			u32_get_bits(info[0], HAL_RX_PPDU_END_USER_STATS_INFO0_PEER_ID);
+
 		switch (ppdu_info->preamble_type) {
 		case HAL_RX_PREAMBLE_11N:
 			ppdu_info->ht_flags = 1;
-- 
2.34.1



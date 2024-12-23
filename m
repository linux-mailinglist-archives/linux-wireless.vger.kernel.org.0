Return-Path: <linux-wireless+bounces-16722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617019FAA29
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 07:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4202116755C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 06:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFE4188917;
	Mon, 23 Dec 2024 06:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jZNH72zZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E2718C03B
	for <linux-wireless@vger.kernel.org>; Mon, 23 Dec 2024 06:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734933731; cv=none; b=twgFDGv4XgMHwEFcbA4olNFVt6/qSGirwl9RFVVergLSNZLRx0Q6g7Xd9tMKGzlbV57xwtB92TtUmVQYaWD5xp+QMHHYTkGnCtUhXOf3NO1+Opk+gFwJgO51QG9J5uj0U2W3OYQnh+Fgjzy2YRIwH7hTijjUKaxKp0XJfzygRUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734933731; c=relaxed/simple;
	bh=pTp0rDuBI1f6MVGVnwqE2ilK96WFa537wQEf91rlvNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7XWVJW8P96xegQsyo6zmTEQ/6vaDGmErm2qCCXAVAkOYcfMqN+IEBLgiLf+ykFDAZQ9296yz/k5A+fTKwgE1B1ZEUKCNv75BJdB4knVc6s5ppjG/YfqaSefzSC+63M1swKczICtYlIyNBhYKFtHUrkde3tnE/2MdKjHB9/HxAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jZNH72zZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN2rU6M024172;
	Mon, 23 Dec 2024 06:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	93zzcIa73zXBCi9enOq7mvVbH7Y4Eg0x2jMsDwY1iR8=; b=jZNH72zZ3FsIxZf0
	O+O6k21Zxp6AVBjpBIhMKm9T3b9gP0pX9+jB+oXyqMJyHse4fwb9zD90Yx18OlAs
	IHcKOKXOxJUEZs6+8m3Q4cteillnBj+2MmeiwbWW28rb8buqTA2L3WvGC+4iYSne
	ac65tsYInqyj5g0v4Ncnt6PX7LH3YYUgT744w836E4JtdnTER8ybho7SPWXIZqXz
	oLcfW/Uot49w2t8gqPXBq07l/KfrBU7di/stkyGtg+W9giwYHnQ9BHyBsu5Nnh79
	uzzxGoAytQ9PU4578Pg1I7BlORV9OftEHmqM7lm2HLG6GlzCxyVmYNSl4mqfZTtA
	Tue1Iw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43pyft0k0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 06:02:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BN627Bj030641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 06:02:07 GMT
Received: from hu-ppranees-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 22 Dec 2024 22:02:05 -0800
From: P Praneesh <quic_ppranees@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH v2 10/14] wifi: ath12k: Optimize NAPI budget by adjusting PPDU processing
Date: Mon, 23 Dec 2024 11:31:28 +0530
Message-ID: <20241223060132.3506372-11-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241223060132.3506372-1-quic_ppranees@quicinc.com>
References: <20241223060132.3506372-1-quic_ppranees@quicinc.com>
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
X-Proofpoint-ORIG-GUID: EMsveb6W3kEe8UaVK6R3XQiGMp5eBwaC
X-Proofpoint-GUID: EMsveb6W3kEe8UaVK6R3XQiGMp5eBwaC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230051

In the current implementation, when PPDU spans multiple ring descriptors,
leading to inefficient use of the NAPI budget. The budget counter is
decremented for each ring descriptor, causing rapid depletion of the
budget even though the processing of a single PPDU might not be complete.

To address this issue, modify the code to decrement the budget counter
only when the driver receives HAL_MON_END_OF_PPDU as the end reason. This
change ensures that the budget is decremented only once per PPDU,
resulting in more efficient utilization of the NAPI budget and better
handling of monitor destination ring.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index dbf5afd88ad5..a11b39ae3774 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2388,6 +2388,13 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 			goto move_next;
 		}
 
+		/* Calculate the budget when the ring descriptor with the
+		 * HAL_MON_END_OF_PPDU to ensure that one PPDU worth of data is always
+		 * reaped. This helps to efficiently utilize the NAPI budget.
+		 */
+		if (end_reason == HAL_MON_END_OF_PPDU)
+			*budget -= 1;
+
 		end_offset = u32_get_bits(info0, HAL_MON_DEST_INFO0_END_OFFSET);
 		if (likely(end_offset <= DP_RX_BUFFER_SIZE)) {
 			skb_put(skb, end_offset);
-- 
2.34.1



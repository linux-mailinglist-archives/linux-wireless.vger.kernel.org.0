Return-Path: <linux-wireless+bounces-16677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BACC49F9E45
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 05:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9197C7A21D9
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 04:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCB01D9A60;
	Sat, 21 Dec 2024 04:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pl1wux1+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0949C1E9B0C
	for <linux-wireless@vger.kernel.org>; Sat, 21 Dec 2024 04:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734755492; cv=none; b=Ltixl2TXTUCMAuuMxckaMUyzKCllKBjI7JVI9r94ah3ArdGOFXDOH86VROZ0vfS3Oqsr8ACl4Hl5NIjosxBLbtV38S/McJYF6MGWYeebOf0gK73IDDjdXo6iZVZxJbjpcshm0ueT05hUpX3Uc5+c481aJRl/htNmCCxtq0ybNDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734755492; c=relaxed/simple;
	bh=pTp0rDuBI1f6MVGVnwqE2ilK96WFa537wQEf91rlvNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KncJ94eVABDb/+Xu9aknVFpDKeK0LE3xJvPwD4bCDsfErSuPDEovhQBLE0IbG2UL7Z8hYTsUQPG3FmSNELLC2hMfHkfDCcqPKZMDCfjzDW/FawmnpaxZes/RNfsYG/7jG4C0TgSDad2wArIruspTfxXczgDEHqjF1FyqZ1P1pf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Pl1wux1+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BL4Bqt7008883;
	Sat, 21 Dec 2024 04:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	93zzcIa73zXBCi9enOq7mvVbH7Y4Eg0x2jMsDwY1iR8=; b=Pl1wux1+Th4VHFhE
	iRtjewbQEgszpIqjwqaPW/pVUAfnexwVySFUwuA8Es09DUVp3pxQXXRACS4ydT5M
	efCa/QY5daaXuKLuxlLRfVBhn/Lt8EXXsqg9V8anpTfaurgWRnezpr03syON7ze6
	QH875Gos/svMygXw6CNSCFIbdTNfq1x8dFOBbxgnqJ+KiY3/gBTQqo45mxlgWEzZ
	Ucb1XWgPFD9EZn2fo1nF/qktlmXLSg0ISHSfrPL5RpyYdjav99BAKd+EGjDFx6Ad
	0rOoHAyMEMy+wzWD8XJMXLtZW+m4e+1VU38cpsApE2qctuVbPWkGmaxl2nm4YTYW
	XWaXzw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43npeh816x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 04:31:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BL4VSf0008449
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 04:31:28 GMT
Received: from hu-ppranees-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 20 Dec 2024 20:31:26 -0800
From: P Praneesh <quic_ppranees@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH 10/14] wifi: ath12k: Optimize NAPI budget by adjusting PPDU processing
Date: Sat, 21 Dec 2024 10:00:10 +0530
Message-ID: <20241221043014.1252841-11-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241221043014.1252841-1-quic_ppranees@quicinc.com>
References: <20241221043014.1252841-1-quic_ppranees@quicinc.com>
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
X-Proofpoint-GUID: NIE_hDZbFjf_elqeJyFMmStchZypZ5_j
X-Proofpoint-ORIG-GUID: NIE_hDZbFjf_elqeJyFMmStchZypZ5_j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412210035

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



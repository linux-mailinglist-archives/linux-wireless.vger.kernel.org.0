Return-Path: <linux-wireless+bounces-24022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8814AD6524
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 03:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FB9A7A4637
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 01:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0871417A2E6;
	Thu, 12 Jun 2025 01:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jZW2LfTH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9D015E5C2;
	Thu, 12 Jun 2025 01:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749691935; cv=none; b=iqyUcEovO5BYR3wNb7YjBXD+4qLTdqGIKuHAoLeu6jNsdEre1BN3R83u5HjvETzApOK6Dko65P7kqtMVOPvK8LaBM/7lYLeVyDwETTWwOIoBUo9l+H+OXTKVjbiENk36JxQ0zvrOIIlGYeV40BWIBDLsu9k9a6rRpVjkGf/gjd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749691935; c=relaxed/simple;
	bh=tu+JCfApbjm53ZuOr6EnWh3rxEnOf5j4krxKb4NrS9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=AauYW5KHuDF6ntuHcAeya84CJ/XHLNVjeob6BghbL5mq5ExNF3G+aVne53ohfzUrrK30J5wKbONpx/eaN+LmNK4XLzJXadvxZRj4oaNJx3CO7WAxU6xbu7W0IvQ0J+krxYWO+TP5n51/CwxU/YLfh0lKZf+F/lDsfV7k0SiF/O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jZW2LfTH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BJM6uh027397;
	Thu, 12 Jun 2025 01:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S9pVwJ+1y6kZ2fG9YatLdeD61USRI/vjDQt86SR00a8=; b=jZW2LfTHeir9l0WS
	wPfaiK03W67D7PZrJQQmiYMv0NGPrUU9oY2X3cQQOXyWIOHYGz3X111ZxVO8zvqg
	YP/Cno6lerCEEZTbCnYN+vQ4Iq1FQ2Pc9lequlHg/pRt9R5LPqI0pRj3fPtjBccI
	QShLh9jYvgWALZvBsJzHZy1EfRY5DUaKuTkKj2Q1BRp/HCsghwlfNAt9MzorKsvT
	evmZbCu+c6D3a/sDkRexEYoF0xCPPdVcVmjgCG3i6jOb6T6c+f5FLBrV1/keIWjY
	NVmHhUvItPGnsJckSt9dlZm+N+c1zgpYQbginchml+i23pFE2UFKgbzr+0kghaSF
	1IDf1g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 476jrhdtca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 01:32:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55C1W8BS014969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 01:32:08 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Jun
 2025 18:32:06 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Thu, 12 Jun 2025 09:31:51 +0800
Subject: [PATCH ath-current 3/4] wifi: ath12k: don't use static variables
 in ath12k_wmi_fw_stats_process()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250612-ath12k-fw-fixes-v1-3-12f594f3b857@quicinc.com>
References: <20250612-ath12k-fw-fixes-v1-0-12f594f3b857@quicinc.com>
In-Reply-To: <20250612-ath12k-fw-fixes-v1-0-12f594f3b857@quicinc.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Ramya Gnanasekar
	<ramya.gnanasekar@oss.qualcomm.com>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>
CC: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=EovSrTcA c=1 sm=1 tr=0 ts=684a2e19 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=2UppwYiRmKxTrJ6QviAA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 0Luo3K5GE9CSdmj6fF0BbttEyoPKnVey
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDAxMCBTYWx0ZWRfXwrMmy11vT2F2
 6ENLVayLXxAEv54c2ssLXFo7m5h8O4RX1gvA1mG+7naM+P/wbni+0pkBWZboNQ2qGw4l1XFEOOY
 UswO+ob76CdcgVtOn3yUwn/6JGv14doiZi/tbwf/jP/m9mFuCRxHBJ7g93tLdRN6p7WV1c0aS+V
 cd2gpX4S7sCQ8w6UT3uoy/uSAEOPQReHBlIgtJVQgzP5afjr9iWQF00rboWPmfLMGYszN8Nq+6J
 j46mVKfya4GL22QJ/zaCPEV3Orf40EU2CTDp4N0zJogvz/DDgxi8OSABnxtyEuSakwzN8Y/5WVP
 EbgQaScb0TOiNItD0f4kyV3TuzOFIcnUTx5qtILznQQoKYfbgTPrdisTA1RwHP0NI796DjHhaYU
 Hix7fQVq6/0ySX246pLZzeODLRiAkmT39LWE6+bXJLFhfbOfZw0TaElTjuw4qzNAmvSZlfgm
X-Proofpoint-GUID: 0Luo3K5GE9CSdmj6fF0BbttEyoPKnVey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_01,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 mlxscore=0 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120010

Currently ath12k_wmi_fw_stats_process() is using static variables to count
firmware stat events. Taking num_vdev as an example, if for whatever
reason (say ar->num_started_vdevs is 0 or firmware bug etc.) the following
condition

	(++num_vdev) == total_vdevs_started

is not met, is_end is not set thus num_vdev won't be cleared. Next time
when firmware stats is requested again, even if everything is working
fine, failure is expected due to the condition above will never be
satisfied.

The same applies to num_bcn as well.

Change to use non-static counters and reset them each time before firmware
stats is requested.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Fixes: e367c924768b ("wifi: ath12k: Request vdev stats from firmware")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  2 ++
 drivers/net/wireless/ath/ath12k/core.h |  2 ++
 drivers/net/wireless/ath/ath12k/wmi.c  | 14 +++++---------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index fbc62209086fe5fde007193755f6116bfa72ab77..89ae80934b3048f850939c25c160af0e2d05b8e2 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1230,6 +1230,8 @@ void ath12k_fw_stats_reset(struct ath12k *ar)
 {
 	spin_lock_bh(&ar->data_lock);
 	ath12k_fw_stats_free(&ar->fw_stats);
+	ar->fw_stats.num_vdev_recvd = 0;
+	ar->fw_stats.num_bcn_recvd = 0;
 	spin_unlock_bh(&ar->data_lock);
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index c9584c4d85fd77150ff30af6d406dadbd87a8050..df5f4a934d8da7f15107d6a4bdeb3b21a421a514 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -626,6 +626,8 @@ struct ath12k_fw_stats {
 	struct list_head pdevs;
 	struct list_head vdevs;
 	struct list_head bcn;
+	u32 num_vdev_recvd;
+	u32 num_bcn_recvd;
 };
 
 struct ath12k_dbg_htt_stats {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 1e6074456725f45c2bab69aa43ae4ff0b9ce5e8f..dc6a2ad63663d988e495b115a1fc24a6408df600 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7632,7 +7632,6 @@ static void ath12k_wmi_fw_stats_process(struct ath12k *ar,
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_pdev *pdev;
 	bool is_end;
-	static unsigned int num_vdev, num_bcn;
 	size_t total_vdevs_started = 0;
 	int i;
 
@@ -7652,15 +7651,14 @@ static void ath12k_wmi_fw_stats_process(struct ath12k *ar,
 		}
 		rcu_read_unlock();
 
-		is_end = ((++num_vdev) == total_vdevs_started);
+		is_end = ((++ar->fw_stats.num_vdev_recvd) == total_vdevs_started);
 
 		list_splice_tail_init(&stats->vdevs,
 				      &ar->fw_stats.vdevs);
 
-		if (is_end) {
+		if (is_end)
 			complete(&ar->fw_stats_done);
-			num_vdev = 0;
-		}
+
 		return;
 	}
 
@@ -7672,15 +7670,13 @@ static void ath12k_wmi_fw_stats_process(struct ath12k *ar,
 		/* Mark end until we reached the count of all started VDEVs
 		 * within the PDEV
 		 */
-		is_end = ((++num_bcn) == ar->num_started_vdevs);
+		is_end = ((++ar->fw_stats.num_bcn_recvd) == ar->num_started_vdevs);
 
 		list_splice_tail_init(&stats->bcn,
 				      &ar->fw_stats.bcn);
 
-		if (is_end) {
+		if (is_end)
 			complete(&ar->fw_stats_done);
-			num_bcn = 0;
-		}
 	}
 }
 

-- 
2.34.1



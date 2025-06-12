Return-Path: <linux-wireless+bounces-24024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEF5AD6528
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 03:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9F01BC2498
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 01:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAE018C011;
	Thu, 12 Jun 2025 01:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oqxfdpYR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA3A17A318;
	Thu, 12 Jun 2025 01:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749691937; cv=none; b=oZ5O6R0DdPS09f0wpmc6xwsP7qDyZdqQ74fe2+NBUNjB2fEs6t64iRrxyQoZPr+xsWNP1FKlHTwNzai+poLOxzY74UOXDdnjzHBIdv+YaUTtdx/QUp7lQytm19A1LQah5kt+ovlSVEZVogpFTz3iMqYQ1PJJ1uXmnvs0pb0xVys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749691937; c=relaxed/simple;
	bh=cThSd7K6kDqnRvLv9v0D7k0r1SuhKfyhgqtlJhe8gH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WA9gY33kcu15Q3J4vOP8ey5FTtGGHyNyJCnRzOdSUDC/ctHKUwGkhvAQlY1Y4RPvWFk4sm+XqdfOdjjy1uHfR2/CMPKlcGsogOAO4s0OnlHc0aJppLBzVYWz7iLbgW5gYISVkb0+pNbUmRgfDtXNU61J3bx6bl00B7NGswOg7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oqxfdpYR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BK880f002374;
	Thu, 12 Jun 2025 01:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eiLd07SJCxjZopKuS4ArzooclGq9tE02D1+OJO7qByQ=; b=oqxfdpYR3R5DvdBs
	dL7suAVTiDyUSpESYQvdH4UOe2CvIpfGeA12cbR5v0crR6wv9S+ew0L0f5Uq4yfV
	+/vliMNyYc8gU2qfSUYw5r2fQWrfrW6YMvBGd8wFhxnZ7EuYumNGsBNUyWpYWl5q
	dcXs8IshDOMKqeZ1ckqzyNNNiXu6tyZoAdUHLgH7uDJomtTfMwUTgkEqmPXQuSTZ
	m+aNs5sYSzU6ow4oLuvek0M/niZaH2b7JSYteicAObF5pDdTYhHHu+zvCZkHpPYL
	aw0WtxenpE6NgcATrm3aPD5GXVwUgtt2SVa67+NH2M6XzgdxvdgJPsPze/u2GrLx
	GI8GYg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dgxy3cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 01:32:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55C1WA77014395
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 01:32:10 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Jun
 2025 18:32:08 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Thu, 12 Jun 2025 09:31:52 +0800
Subject: [PATCH ath-current 4/4] wifi: ath12k: don't wait when there is no
 vdev started
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250612-ath12k-fw-fixes-v1-4-12f594f3b857@quicinc.com>
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
X-Proofpoint-GUID: G3xTwWwCMzPHJg20oIZc-V-RCnUtMHky
X-Authority-Analysis: v=2.4 cv=HMbDFptv c=1 sm=1 tr=0 ts=684a2e1b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zPWCEbQWmxFCawYx:21 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=COk6AnOGAAAA:8 a=LKi86vrQLEXAMEGEImwA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: G3xTwWwCMzPHJg20oIZc-V-RCnUtMHky
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDAxMCBTYWx0ZWRfX2zCZL5Opj+Zg
 PSAimMoy6ITBV+BnO1IzcNo3KGgWzaPkk0mB7hob5ALdCUC/sRGypoRWFLeRvh6+3XKetXJRHdG
 5MGiI5Mh5d2gf9tEf5Tv5GzFnhiQSoCrwEN4W3InItpZLBK6GAK7TRT6fN0/LEVnp2hB1szSgVJ
 cVOy/vWtG+A1nVRiVpmWqyr1ffrZ0P3nW+5662EpQKh8HTlt2LurOi1Am0VtD2PNNaENi1bpQCa
 TX/3eSps1ANsib0NGB1qRScmkDIVDHi3h3lkV3MgfUBqi24D4YRjpIYfdWK9MR55A8kscde+SNX
 uqElAGqMHr0QUD0TpfiC7ZxqPqbMcNvwe9MZKJHQ5bXvLOEaoVloX6uh7IW6tiC9WpDISiVO/Om
 B7zRs2uDholfwpFAqeXsNwLpN4ZnblsMzgfayyedj/VmGaL3PkBfITB4yHr276MmWtjUHbqi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_01,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506120010

For WMI_REQUEST_VDEV_STAT request, firmware might split response into
multiple events dut to buffer limit, hence currently in
ath12k_wmi_fw_stats_process() host waits until all events received. In
case there is no vdev started, this results in that below condition
would never get satisfied

	((++ar->fw_stats.num_vdev_recvd) == total_vdevs_started)

consequently the requestor would be blocked until time out.

The same applies to WMI_REQUEST_BCN_STAT request as well due to:

	((++ar->fw_stats.num_bcn_recvd) == ar->num_started_vdevs)

Change to check the number of started vdev first: if it is zero, finish
directly; if not, follow the old way.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Fixes: e367c924768b ("wifi: ath12k: Request vdev stats from firmware")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index dc6a2ad63663d988e495b115a1fc24a6408df600..bd04dd98f5f47a4a7d773d3b707a7e53b8f9b29e 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7631,7 +7631,7 @@ static void ath12k_wmi_fw_stats_process(struct ath12k *ar,
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_pdev *pdev;
-	bool is_end;
+	bool is_end = true;
 	size_t total_vdevs_started = 0;
 	int i;
 
@@ -7651,7 +7651,9 @@ static void ath12k_wmi_fw_stats_process(struct ath12k *ar,
 		}
 		rcu_read_unlock();
 
-		is_end = ((++ar->fw_stats.num_vdev_recvd) == total_vdevs_started);
+		if (total_vdevs_started)
+			is_end = ((++ar->fw_stats.num_vdev_recvd) ==
+				  total_vdevs_started);
 
 		list_splice_tail_init(&stats->vdevs,
 				      &ar->fw_stats.vdevs);
@@ -7670,7 +7672,9 @@ static void ath12k_wmi_fw_stats_process(struct ath12k *ar,
 		/* Mark end until we reached the count of all started VDEVs
 		 * within the PDEV
 		 */
-		is_end = ((++ar->fw_stats.num_bcn_recvd) == ar->num_started_vdevs);
+		if (ar->num_started_vdevs)
+			is_end = ((++ar->fw_stats.num_bcn_recvd) ==
+				  ar->num_started_vdevs);
 
 		list_splice_tail_init(&stats->bcn,
 				      &ar->fw_stats.bcn);

-- 
2.34.1



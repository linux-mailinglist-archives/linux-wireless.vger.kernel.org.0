Return-Path: <linux-wireless+bounces-20822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31322A70E7B
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 02:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201CF3AE749
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 01:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8D515DBB3;
	Wed, 26 Mar 2025 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LX6su3bt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0B414A0A8;
	Wed, 26 Mar 2025 01:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742952834; cv=none; b=e6xdN+Gfcnve5Ff9Ia+Qku4KFY7j0GE8bx6k9HeWtsHWrzSak4BEm6GnEH9TpCS/MruLGAbXTLqhSdORSLLNkIsfX5JnKIfHz3PUrhtsXdmzb+wcMTis1rne5GVsDv46G5TwVcjJ8d09cxnWfbYrAP43CnkI6AHGHI98+vUMI64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742952834; c=relaxed/simple;
	bh=36jJB6z8/TjcD2W2krounHncTpBPEiQDUuszbM34TMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ijPioHlV/xerSnh9iYpPtuppouACKhKn28I+NDNdLD5Gg5dUSQtsJUzoD6rMBwz4G6OJ/CFUH4ugFKsHQYKmBFlFdwY5C8qqQYRDZgXReIeNXc9orXa18o0/jnXFncpqtqxBUlDJGszVAGIvnTYUzpEnpwJ7LQEx9Yjeg14VYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LX6su3bt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q18VLT008415;
	Wed, 26 Mar 2025 01:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PJAHwmS0v/twUCkxjHxqH4R0AfCJfnU/mqJqg8xpwsU=; b=LX6su3btQBSas50W
	mzhrcZNANwIPySdaShe2R+XvGuGmzuNXfDxaTZr/B6TFSrCHfL8uAQ2Lzj0/x2id
	lJMbet1PqssiaZsmP5K38YJ8r5tRIHzQGuwU7cXG9pn5e4W+CGAGZJdmNF0EtKrg
	yvd+KExZq3tdmKCUYVxXiOVUWI71Ps02YCcO7hiEdUNQfVlrBT4rqq7TW6d7Mdgd
	9wGFWpeS8SKHBlaKHA5AiOX94to93Snf1FRaOEpWVfY9EhE9Z0vFIKtQJz1j392I
	bQ1J/MZPcUPnYHPOj6tK2P2Be7j1U/GReZgcmMi3IRRx6eBeSpVIZkv7G22W1TMq
	6VHaig==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45m7nf01ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 01:33:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52Q1Xh7V019772
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 01:33:43 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Mar
 2025 18:33:41 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Wed, 26 Mar 2025 09:33:10 +0800
Subject: [PATCH ath-next v2 6/6] Reapply "wifi: ath11k: restore country
 code during resume"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250326-ath11k-bring-hibernation-back-v2-6-87fdc2d6428f@quicinc.com>
References: <20250326-ath11k-bring-hibernation-back-v2-0-87fdc2d6428f@quicinc.com>
In-Reply-To: <20250326-ath11k-bring-hibernation-back-v2-0-87fdc2d6428f@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: K3GE80BqCFb35qKUQ1sRo4uBeRCxn7Mu
X-Proofpoint-GUID: K3GE80BqCFb35qKUQ1sRo4uBeRCxn7Mu
X-Authority-Analysis: v=2.4 cv=IMMCChvG c=1 sm=1 tr=0 ts=67e35977 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=QX4gbG5DAAAA:8 a=COk6AnOGAAAA:8 a=RoHt8tvvRc4mp1QopSkA:9
 a=QEXdDO2ut3YA:10 a=AbAUZ8qAyYyZVLSsDulk:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 mlxlogscore=872 adultscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260008

This reverts commit d3e154d7776ba57ab679fb816fb87b627fba21c9.

With non-WoWLAN suspend support brought back, commit 7f0343b7b871 ("wifi:
ath11k: restore country code during resume") needs to be brought back
as well.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index cde009c3bdaf1e7a4f64a10df61029ef83408cd0..3f0e8e65e8e907d70705634b62909886a09b3b70 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1185,6 +1185,7 @@ EXPORT_SYMBOL(ath11k_core_resume_early);
 
 static int ath11k_core_resume_default(struct ath11k_base *ab)
 {
+	struct ath11k *ar;
 	long time_left;
 	int ret;
 
@@ -1195,6 +1196,20 @@ static int ath11k_core_resume_default(struct ath11k_base *ab)
 		return -ETIMEDOUT;
 	}
 
+	/* So far only single_pdev_only devices can reach here,
+	 * so it is valid to handle the first, and the only, pdev.
+	 */
+	ar = ab->pdevs[0].ar;
+	if (ab->hw_params.current_cc_support &&
+	    ar->alpha2[0] != 0 && ar->alpha2[1] != 0) {
+		ret = ath11k_reg_set_cc(ar);
+		if (ret) {
+			ath11k_warn(ab, "failed to set country code during resume: %d\n",
+				    ret);
+			return ret;
+		}
+	}
+
 	ret = ath11k_dp_rx_pktlog_start(ab);
 	if (ret)
 		ath11k_warn(ab, "failed to start rx pktlog during resume: %d\n",

-- 
2.34.1



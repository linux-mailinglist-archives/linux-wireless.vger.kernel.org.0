Return-Path: <linux-wireless+bounces-20906-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 244ACA7435E
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 06:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16997189E2B7
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 05:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CB420DD74;
	Fri, 28 Mar 2025 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Aya2f6Q/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B43010C;
	Fri, 28 Mar 2025 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743139982; cv=none; b=W6RzihxkTg35HxFlX6calZxj4WG0gr/1J+9JdGCVC+KvpbqGtJt7kFc/mkGk8oxX64pFSQLnyu3hcfV28eH8pK9V3xtD1W38XQMS7CQjwGsaQPMYEtR9haNb0qzUsI6XZAgH0btO6lVTo+kExizo9UrkAz9S/NVVND+EaL3wqbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743139982; c=relaxed/simple;
	bh=qt8PY45Cl81DHqF1d3Qk1WBcDovPTn6HWvng0hm39qM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=A+cW0BibrhZZxLhh66Ua9iqrKPY6axek9swCkpJmQ7nRfcDNp3p1k1ucTFaP/iYO2IeaTaFf6bCHlsJuOU6GLhkiHAw1aWQwjwkWFmvsWRN+wKwEXmDYlkjhdGW7iQP1EbHZ84QT64DWgrbNxBpGl9O8J7AugGw4RHYzyRYCbMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Aya2f6Q/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S5STZ3022968;
	Fri, 28 Mar 2025 05:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uBSvxRPcw/xnwz8y+vImXfZ6qAVyJphQQgzEpUgpc+s=; b=Aya2f6Q/BSdpbnsA
	H+FLcODO3z5xw5aSDc9IP+t+Vf7swx/atfRAnATGHuPbdUuUF6IfIFtdX1zTt2n9
	yLKgtsG70bHg3wxtPbwTFXKoLccWAOJY2wOWbAE+r3zDsvW7iT3lw7A1A6QtwHKP
	sD76LflJfDTCdyI8iBLzHDbcHr9ML5nWCWa47aeSleGDdPOxJEsw7YPd7gATufBm
	EZ7pwuWqGW23OVh9Yb14j0AXMfNBl8Y/YlcQs3QNdf3FFEbopqBQyca9ucXMadxZ
	G435wZ44+WTGMHUQ0xMuZVU5j0UnKr2o+2vp5T3iJNJqJCxX903Bep+tIt5XdblD
	OEsq1w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45mb9my0sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 05:32:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52S5WinE032035
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Mar 2025 05:32:44 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Mar
 2025 22:32:42 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Fri, 28 Mar 2025 13:32:29 +0800
Subject: [PATCH ath-next v3 6/6] Reapply "wifi: ath11k: restore country
 code during resume"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250328-ath11k-bring-hibernation-back-v3-6-23405ae23431@quicinc.com>
References: <20250328-ath11k-bring-hibernation-back-v3-0-23405ae23431@quicinc.com>
In-Reply-To: <20250328-ath11k-bring-hibernation-back-v3-0-23405ae23431@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Takashi Iwai
	<tiwai@suse.de>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=cs+bk04i c=1 sm=1 tr=0 ts=67e6347d cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=QX4gbG5DAAAA:8 a=COk6AnOGAAAA:8 a=RoHt8tvvRc4mp1QopSkA:9
 a=QEXdDO2ut3YA:10 a=AbAUZ8qAyYyZVLSsDulk:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ZwPYu9WncyOpZ-7eai7aFP_bfbwSNi_V
X-Proofpoint-ORIG-GUID: ZwPYu9WncyOpZ-7eai7aFP_bfbwSNi_V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_02,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 mlxlogscore=847 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503280036

This reverts commit d3e154d7776ba57ab679fb816fb87b627fba21c9.

With non-WoWLAN suspend support brought back, commit 7f0343b7b871 ("wifi:
ath11k: restore country code during resume") needs to be brought back
as well.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Takashi Iwai <tiwai@suse.de>
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



Return-Path: <linux-wireless+bounces-20594-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78974A69E52
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 03:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FB21898007
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 02:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1544B1EDA1C;
	Thu, 20 Mar 2025 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VRkEaJl3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A111EB9F3
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742437829; cv=none; b=eO4AqTbeCgT3OI6X5fNifQ8JFQ3QxCjWO/JQealE27MYYRFrxZP7knVsZuKqsDxhc+y1HcDPapmfctGu39f4QikW7hfQKXVqRidkHwrL7H4Q7c2yXESgoxzCBhOfjJ+851BL2KrM/liL8ftoU0PQ0AHYg2J1swr+0CiwKy+CBSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742437829; c=relaxed/simple;
	bh=V+QWbrApXLeWzXaotm3iJF9oyy/9JKXIGIsmiDs+DHs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQE9bLYCl7oeg9X1aZ85XogqxELQjtT0on1DVbSg0tNHxy7b6vP88qaExwlNwKZdCroizol94pjt+a9ttURJu14zIw87T1TSUp4sh3BwiY0lLiiQblN4CWL2L17lCYLRATnTNh0ii7bXMYbcH3dj91DNzU+jhXvm48s8U3mbSxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VRkEaJl3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JE8Xvq016627;
	Thu, 20 Mar 2025 02:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fi/g6K7yc7e89bSfuWI7DIB430/Zwn4BvVQPY2BO1GM=; b=VRkEaJl3byChJFZB
	ZyzcgeZ2e7kY3hC5H6boktvbwJwcI5G9NqHmcMzEDyVl2T7M+TwHH4r9ZG6toKjM
	UmFKX/FVCXSGs1DHiQvJucsJEG6smIp+yXUQrZH9g21uNjrhLLv8l4/BEBbcQL3y
	gsJpYc9OKtgZTzceHMhM0jmU0WYHEtrHodDgRJVd8ZQexjjEKR80hafLarJuevXy
	bB6gW4wl1hkJ+MV9ozweL2kPK1P/f/vtj+RE15oe+axvdCblpu5AuM8HYT7IHOGq
	vK7ncD6iOqkxg0CZ9CModXA7WyO7aE058BRj5VFsxpgK6oHj3lxaQIuQLmvVmDJx
	w7vrfw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fd1dmntw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 02:30:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52K2UMH7025421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 02:30:22 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Mar 2025 19:30:21 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH ath-next 5/5] Reapply "wifi: ath11k: restore country code during resume"
Date: Thu, 20 Mar 2025 10:30:03 +0800
Message-ID: <20250320023003.65028-6-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250320023003.65028-1-quic_bqiang@quicinc.com>
References: <20250320023003.65028-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: oSDa90d7hGJRzYYOPRlkkJWoyvxA0d9E
X-Proofpoint-GUID: oSDa90d7hGJRzYYOPRlkkJWoyvxA0d9E
X-Authority-Analysis: v=2.4 cv=T52MT+KQ c=1 sm=1 tr=0 ts=67db7dbf cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=RoHt8tvvRc4mp1QopSkA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_01,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=904 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200014

This reverts commit d3e154d7776ba57ab679fb816fb87b627fba21c9.

With non-WoWLAN suspend support brought back, commit 7f0343b7b871 ("wifi:
ath11k: restore country code during resume") needs to be brought back
as well.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index b248237302ac..2fd2c24f5715 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1192,6 +1192,7 @@ EXPORT_SYMBOL(ath11k_core_resume_early);
 
 static int ath11k_core_resume_default(struct ath11k_base *ab)
 {
+	struct ath11k *ar;
 	long time_left;
 	int ret;
 
@@ -1202,6 +1203,20 @@ static int ath11k_core_resume_default(struct ath11k_base *ab)
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
2.25.1



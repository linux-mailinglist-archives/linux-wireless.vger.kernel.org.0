Return-Path: <linux-wireless+bounces-7170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E848BBDC5
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 20:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4E1282158
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 18:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9373983CDB;
	Sat,  4 May 2024 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B/N3M8TN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C881B4122C;
	Sat,  4 May 2024 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714848754; cv=none; b=VdgZM+CmEWeoyWKIulBiSG6nLypPnOzRKa/hglj4fVR9UoI5HB9NwT5edd62t8aJobObPOlCx8uLIxuR//gIX4sS6ZwwWpPKY6yRIyipyD2FwSPWaGhlxLXBTJ+DljPpijLncoqaSslIv8Xyi3tCrWQODlNglN/2pRTVONLZCLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714848754; c=relaxed/simple;
	bh=psiD1a7Aa7CSiyFzN5K/2EyBynelxKwftRjPWKbOmpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=E0H/LGV9JVCA6oGvdoKnwG1qEEFz+JnYp6nkrSWyuh8b3UHDV2i07czDBfRx0YZkAQkwzx9NV2vxnFvrVIeqj7zxIjLRy8ocfk2zeQoSNR2f5sm/YSTf4paQaGN4h1t1RY/KpClEMILW2iE/Zz3TNSgGH8wU9UdkRRtv066rGBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B/N3M8TN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 444Ho1Ox023598;
	Sat, 4 May 2024 18:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=tXqFfX4R6UCYqJBpv6ktmXUuaMSGNMfXdNIKq3qdK54
	=; b=B/N3M8TNwpumOzhy0Rr5RSooGTotKd1qF774hPhbbludcqnRd8P2gvpNuoV
	EmWqivsGxrV+3SCSPjp1btVNQ4aFonlIyN+z09KD4jOnOnp/ZeVftUgCiujp6rZy
	TwIf4nyFyc6epn3B/jFXd7uEKnptpiMm57EBz+MDCJSPr6MioyDxPl2P7GvnCqAP
	iJx1fq3lzONxjjqymlTmLsxvkMsTdY9si1ZzlTP8AqdvXhC4trePUeYfNov/xa46
	zV03UBELjg263xZyZez/rIpQOQECaoDYmO7N2k6l8xxSmXDk7mKgLtPpCglAvwlp
	omO9164qTwwQECAj4tylwR7MANQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwcbpgyew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 May 2024 18:52:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 444IqAhm017708
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 4 May 2024 18:52:10 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 4 May 2024
 11:52:09 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 4 May 2024 11:52:09 -0700
Subject: [PATCH 2/2] wifi: ath11k: initialize 'ret' in
 ath11k_qmi_load_file_target_mem()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240504-qmi_load_file_target_mem-v1-2-069fc44c45eb@quicinc.com>
References: <20240504-qmi_load_file_target_mem-v1-0-069fc44c45eb@quicinc.com>
In-Reply-To: <20240504-qmi_load_file_target_mem-v1-0-069fc44c45eb@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ath11k@lists.infradead.org>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NILcRBS6aMCbnrJnrdmYpC3_YSFJvcIb
X-Proofpoint-GUID: NILcRBS6aMCbnrJnrdmYpC3_YSFJvcIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-04_15,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 mlxlogscore=944 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405040127

smatch flagged the following issue:

drivers/net/wireless/ath/ath11k/qmi.c:2401 ath11k_qmi_load_file_target_mem() error: uninitialized symbol 'ret'.

The reality is that 'ret' is initialized in every path through
ath11k_qmi_load_file_target_mem() except one, the case where the input
'len' is 0, and hence the "while (remaining)" loop is never entered.
But to make sure this case is also handled, add an initializer to the
declaration of 'ret'.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index d4a243b64f6c..aa160e6fe24f 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2293,7 +2293,7 @@ static int ath11k_qmi_load_file_target_mem(struct ath11k_base *ab,
 	struct qmi_txn txn;
 	const u8 *temp = data;
 	void __iomem *bdf_addr = NULL;
-	int ret;
+	int ret = 0;
 	u32 remaining = len;
 
 	req = kzalloc(sizeof(*req), GFP_KERNEL);

-- 
2.42.0



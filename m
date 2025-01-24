Return-Path: <linux-wireless+bounces-17878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D8DA1AF79
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 05:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176DB16C410
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 04:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80D71D8E18;
	Fri, 24 Jan 2025 04:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IGTYkfk2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EBE1D63DE;
	Fri, 24 Jan 2025 04:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737693716; cv=none; b=u9MpzlnLLTvonJUhDYqsdsS+qOTFYq/a3R+P4Md3dfUCqv7lDnp5jjowYlZurpkvg7nQOKyglJV9HBKdCMR3XK/Q5Ff0ebw8Syj0skpRSnDeiIlieANqX8X0XIaVEREFlQNNtsy07YqpoHpn357B1B0wesgKRCpcN/UA2ziV2FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737693716; c=relaxed/simple;
	bh=rpLNvC5AairJtA4aG3t3Iqbw9K4nSxz0JllEzOgc4x8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=AFpJxKIhLHIb+tCvS6aZ7d1vqci4gV9AsIZSAUzJ0cnAjJnUV0MlKT7jxB1yhcVVmR0VhOLU7d+VLqmqJMpkasBvqztSd+D1gI51gf/W2qZVDiJxUp6Vjm43RW8cx/9yI3b+ShUTd9vBYqqSMRt9qCdKNZY5VIohq3kzKOe/xck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IGTYkfk2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NNwssK027968;
	Fri, 24 Jan 2025 04:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iBGtLWeBoyyHnv34aoMKtjC0WpCD8op6z4g8KC7EYLE=; b=IGTYkfk2Mc0tZ+hy
	gIld+XuUZNzPWTgEuhcPgzC6bpLd7pDNLPMXJSl+GPTlGASDXVbGSwmDdgb1Ywd9
	5pgbNR3Lc+zGpjXPlZYQvF91EzDXDozRzUcvEXnsBoWqXZH17yXZO6FqGilhvUqI
	K6p+gLJHkXeQD0uN43Lqz064A6dV/DdjtNIkvrtJl9qw0xAL7IU8CJWA1qrllwWJ
	q8Prp0dopha8kWC83LhH3GzrsSpNF4HMpO7k7k9/EJbMvbTyhedrdUaTpmdtT66H
	o2sCJM/b7VROeHiC1Yr7FDvU8pEGnxihdXJX6ruYfaNcVhptN2+hvIGBIRvTkhbr
	0XGrqw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bywc0fe2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 04:41:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50O4fmwk023489
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 04:41:48 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 23 Jan 2025 20:41:45 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Fri, 24 Jan 2025 10:11:24 +0530
Subject: [PATCH v3 01/10] wifi: ath12k: prevent race condition in
 ath12k_core_hw_group_destroy()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250124-fix_reboot_issues_with_hw_grouping-v3-1-329030b18d9e@quicinc.com>
References: <20250124-fix_reboot_issues_with_hw_grouping-v3-0-329030b18d9e@quicinc.com>
In-Reply-To: <20250124-fix_reboot_issues_with_hw_grouping-v3-0-329030b18d9e@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem
	<quic_hprem@quicinc.com>
CC: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Kalle Valo
	<quic_kvalo@quicinc.com>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Aditya Kumar
 Singh" <quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Zx37_k9pgWK65MTliWH2xUjTIOUPIWGI
X-Proofpoint-GUID: Zx37_k9pgWK65MTliWH2xUjTIOUPIWGI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_01,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=870 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240032

Currently, ath12k_core_hw_group_destroy() accesses its members without any
locking mechanism. This could lead to potential issues if these members are
modified by another thread concurrently.

Hence to mitigate this, use the available mutex lock.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Fixes: 6f245ea0ec6c ("wifi: ath12k: introduce device group abstraction")
Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 2dd0666959cd4fbdfc17a36b4029fe06fc575d3f..c392f94584ff21051fb05d7843d0d500b1712d69 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1731,6 +1731,7 @@ static void ath12k_core_hw_group_destroy(struct ath12k_hw_group *ag)
 	if (WARN_ON(!ag))
 		return;
 
+	mutex_lock(&ag->mutex);
 	for (i = 0; i < ag->num_devices; i++) {
 		ab = ag->ab[i];
 		if (!ab)
@@ -1738,6 +1739,7 @@ static void ath12k_core_hw_group_destroy(struct ath12k_hw_group *ag)
 
 		ath12k_core_soc_destroy(ab);
 	}
+	mutex_unlock(&ag->mutex);
 }
 
 static void ath12k_core_hw_group_cleanup(struct ath12k_hw_group *ag)

-- 
2.34.1



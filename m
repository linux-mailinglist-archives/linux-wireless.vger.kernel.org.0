Return-Path: <linux-wireless+bounces-17749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456D3A169F6
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 10:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612F63A3059
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 09:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52F71B415F;
	Mon, 20 Jan 2025 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fG+ITO3Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3D21B415C;
	Mon, 20 Jan 2025 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737366554; cv=none; b=Udr3KqPSef0qfKwxznAm0DrWwTwSajCqGBvxBiMICwaB6HG98xgDA12B9hGlXyWLhUn0+1vlgT9gKC9NGLQmvjMxuXX9D2KAGlEE7+IJL7B+I35pE82IxaS+1wCrXDAHvzLUfYjTpnBaSoeTuvgKKy0sUF6GElmc2uH0gA066A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737366554; c=relaxed/simple;
	bh=o59wnqqzNAcA5D8In0+PEJJk5uBEwp/3s1cgglMnJqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=aKF+TI1OlmGPKb1pdh6A2mJZVguAjsIDfskfbwXvkVbSFBfH12HFSPWPDl2gRLAKOlxXFjG+jDX2QYA6ld8+XCdJPinuA9Fz50JohjkbBtYIPozPZAuKZmL+SrcoZYcJMR4N4RCdFOy4Q8jzuH8jiN5AMl+vG6oYg82kccETrb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fG+ITO3Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K7HoiO011766;
	Mon, 20 Jan 2025 09:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jjWzIDnLdDzP6nA+60lb8VAIBTaNHZmYUuDJIGNqBgs=; b=fG+ITO3Q+AC4P2oW
	xq9njjE0pM/1POXh8JyAguhiqA9/5iFZMT5A0kyYU3xzQ1m22n1kvnlQlntNPnby
	uTkyKfhHAKpf5PxWjssh4jU9o4ERvTqVmSMQlBU9Dhoqg3sXimcwv4hJpvssIodM
	XSQgnH3MLpigodiajtQZHrqfleNxEPCBc969F1lDwELjoEdLKqdbu5gXFvTeP42A
	bw4ugW+Z2lDNKoIFVah83yjYzcuhBuA+sgJ/Q+Q2Z1vRyZ3/BE8CtBAmRSH6ITCS
	+zN5v/DnLGu0852SY/0o4UUUq9v+5CWEC7kbFeca2Oq8g0WPriPmbZcJB0eBu+xe
	xMt0Lw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 449hykrbxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 09:49:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50K9n7jV023774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 09:49:07 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 20 Jan 2025 01:49:02 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Mon, 20 Jan 2025 15:18:29 +0530
Subject: [PATCH v2 09/10] wifi: ath12k: handle ath12k_core_reset() with
 hardware grouping
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250120-fix_reboot_issues_with_hw_grouping-v2-9-b7d073bb2a22@quicinc.com>
References: <20250120-fix_reboot_issues_with_hw_grouping-v2-0-b7d073bb2a22@quicinc.com>
In-Reply-To: <20250120-fix_reboot_issues_with_hw_grouping-v2-0-b7d073bb2a22@quicinc.com>
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
X-Proofpoint-GUID: UOi8gEotxTB7kcWTvFymrl9k1VJe-rji
X-Proofpoint-ORIG-GUID: UOi8gEotxTB7kcWTvFymrl9k1VJe-rji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501200081

Currently, in ath12k_core_reset(), the device is powered up immediately
after a power down. However, with hardware grouping, when one device
asserts, all partner devices also asserts. If there is a delay in
processing these asserts, by the time this device powers up, other devices
might still be asserting, leading to an overall recovery failure.

To prevent this issue, ensure all asserts for a group are processed before
initiating the power-up sequence.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index aedb42a0ea85da705d213ae33871af1b5afbe21a..a7c22402dbe3e09f00dafef7d701c18ca8dceacc 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1420,7 +1420,8 @@ static void ath12k_core_restart(struct work_struct *work)
 static void ath12k_core_reset(struct work_struct *work)
 {
 	struct ath12k_base *ab = container_of(work, struct ath12k_base, reset_work);
-	int reset_count, fail_cont_count;
+	struct ath12k_hw_group *ag = ab->ag;
+	int reset_count, fail_cont_count, i;
 	long time_left;
 
 	if (!(test_bit(ATH12K_FLAG_QMI_FW_READY_COMPLETE, &ab->dev_flags))) {
@@ -1479,9 +1480,32 @@ static void ath12k_core_reset(struct work_struct *work)
 	ath12k_hif_ce_irq_disable(ab);
 
 	ath12k_hif_power_down(ab, false);
-	ath12k_hif_power_up(ab);
 
-	ath12k_dbg(ab, ATH12K_DBG_BOOT, "reset started\n");
+	/* prepare for power up */
+	ab->qmi.num_radios = U8_MAX;
+	ab->single_chip_mlo_supp = false;
+
+	mutex_lock(&ag->mutex);
+	ath12k_core_to_group_ref_put(ab);
+
+	if (ag->num_started > 0) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT,
+			   "waiting for %d partner device(s) to reset\n",
+			   ag->num_started);
+		mutex_unlock(&ag->mutex);
+		return;
+	}
+
+	for (i = 0; i < ag->num_devices; i++) {
+		ab = ag->ab[i];
+		if (!ab)
+			continue;
+
+		ath12k_hif_power_up(ab);
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "reset started\n");
+	}
+
+	mutex_unlock(&ag->mutex);
 }
 
 int ath12k_core_pre_init(struct ath12k_base *ab)

-- 
2.34.1



Return-Path: <linux-wireless+bounces-16095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 873AB9E9C5A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 18:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5B918891E2
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 17:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C94216E29;
	Mon,  9 Dec 2024 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QegjKgxx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52FE222D7F;
	Mon,  9 Dec 2024 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763477; cv=none; b=kwzrv7D5njW7oMY0yWdVVsT5Kri7+3KPTwQxz/CJrwqhiFkrs785jDov2dmwHmCQNk0+SIA2J021EXY9AtnkEEsVqMnYGkGHlQMKPtQ1sT4VgAqh74Od+FA2FGX7I7FghfBwtxTYuw8fLU+nApxU014ITwJApMYU2oWE2qkkWMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763477; c=relaxed/simple;
	bh=46cKztNvjKVzLCcfaZpSSbCkjfmUrwT92nofQHILC1U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itgXPoGHrBs/qZa9DNRgdRBCErRFQpi4YHSRKK43TRphxw6PbQ7PaUocaeP8sRWG6znG03mv6A6B35LPmM/l2klEaliRxkAKZJJQ2G1jOyiLxdjxMQknWSAlV8KlypNolyr/5Co3O0XSASGKEq40UV5ZrHqaZhKkPcqJhbN90DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QegjKgxx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9ADATk010451;
	Mon, 9 Dec 2024 16:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RNYCPST5Q7p+eNTy2KO0eHFwqslchPquuKid2rBAGZ4=; b=QegjKgxxKSYp3b8s
	qTpDqgmQBsoSZrEeiHMzyJjTk1KO0jVJ7IxJ7FNIynNz4t4vkTvP24Cs4FjrR6n7
	z0blZeML/+hJjslnZ8hNuEt418u1/D0cdNVr6VNCscrpF5DwlsZeGShrVpuAeinv
	135QgcnbRtQUR+JhumSyzKz3w4JoYpvyh/1v2ZSqIPKGAZU/9OZVtJ4dIFR6QcCF
	Bdc6BVuskW5thSCnkHLnEuXVNsGlSvPBOVtDydooJFf/dUgB8zXxUdCv49noEQBo
	qqtlXhGu1TzPyt/U8cDLPBhCes7Fz3x3lwdEAKZic+wn+BRADpZeu8LapPwZTyx4
	u3t09Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cdc6dnub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 16:57:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B9Gvnot023018
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 16:57:49 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Dec 2024 08:57:46 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <linux-kernel@vger.kernel.org>,
        Sowmiya Sree Elavalagan
	<quic_ssreeela@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v3 12/13] wifi: ath12k: Power down userPD
Date: Mon, 9 Dec 2024 22:26:43 +0530
Message-ID: <20241209165644.1680167-13-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209165644.1680167-1-quic_rajkbhag@quicinc.com>
References: <20241209165644.1680167-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZfYrnKtCPzNnLjtVI_XEVUh-IxtvxUhc
X-Proofpoint-GUID: ZfYrnKtCPzNnLjtVI_XEVUh-IxtvxUhc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090132

From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>

Set the stop bit in SMEM to power down the userPD. Wait for stop-ack IRQ
to indicate power down completion. Release the userPD firmware using its
peripheral ID.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 74d10af6591f..1015b422e263 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -477,6 +477,34 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
 	return ret;
 }
 
+static void ath12k_ahb_power_down(struct ath12k_base *ab, bool is_suspend)
+{
+	struct ath12k_ahb *ab_ahb = ath12k_ab_to_ahb(ab);
+	unsigned long time_left;
+	u32 pasid;
+	int ret;
+
+	qcom_smem_state_update_bits(ab_ahb->stop_state, BIT(ab_ahb->stop_bit),
+				    BIT(ab_ahb->stop_bit));
+
+	time_left = wait_for_completion_timeout(&ab_ahb->userpd_stopped,
+						ATH12K_USERPD_STOP_TIMEOUT);
+	if (!time_left) {
+		ath12k_err(ab, "UserPD stop wait timed out\n");
+		return;
+	}
+
+	qcom_smem_state_update_bits(ab_ahb->stop_state, BIT(ab_ahb->stop_bit), 0);
+
+	pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
+		ATH12K_AHB_UPD_SWID;
+	/* Release the firmware */
+	ret = qcom_scm_pas_shutdown(pasid);
+	if (ret)
+		ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
+			   ab_ahb->userpd_id);
+}
+
 static void ath12k_ahb_init_qmi_ce_config(struct ath12k_base *ab)
 {
 	struct ath12k_qmi_ce_cfg *cfg = &ab->qmi.ce_cfg;
@@ -695,6 +723,7 @@ static const struct ath12k_hif_ops ath12k_ahb_hif_ops_ipq5332 = {
 	.irq_disable = ath12k_ahb_ext_irq_disable,
 	.map_service_to_pipe = ath12k_ahb_map_service_to_pipe,
 	.power_up = ath12k_ahb_power_up,
+	.power_down = ath12k_ahb_power_down,
 };
 
 static irqreturn_t ath12k_userpd_irq_handler(int irq, void *data)
@@ -1173,6 +1202,7 @@ static void ath12k_ahb_remove(struct platform_device *pdev)
 	struct ath12k_base *ab = platform_get_drvdata(pdev);
 
 	if (test_bit(ATH12K_FLAG_QMI_FAIL, &ab->dev_flags)) {
+		ath12k_ahb_power_down(ab, false);
 		ath12k_qmi_deinit_service(ab);
 		goto qmi_fail;
 	}
-- 
2.34.1



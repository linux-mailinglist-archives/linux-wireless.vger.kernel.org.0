Return-Path: <linux-wireless+bounces-19562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D74A488C5
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 20:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381227A9084
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 19:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAE227182B;
	Thu, 27 Feb 2025 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KFq1OwZ4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F0E26F44D;
	Thu, 27 Feb 2025 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740683516; cv=none; b=X/o5uxcJTqVSyr1BbQcb6fX2C9btVRn+PkGGK4z0Ek24snn5YB/Ln0hA8F0HC+tfNPbVT4fqvm9dsZ7IwweenvXOJY5XK0eyosqywUaY7xoiUV+db8Xx7yKPlpbyQRh4Nt5Vchc1FeVwkFbP7wiJHw4SwoKcWOlD6Ebm3hg/i/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740683516; c=relaxed/simple;
	bh=W4YWzt8qAutPU4a+LjdGRgqbNRjWmwydQl0he2/I6ic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KX/IqOFmfHvVAs891fIXxz9GKWckiYYbQ0ABcqP+0YbYHW9cl5u0I5vukkixTCJdLoJkqN5ckBuRkZgW3S0IdbAL2m1DGFozYo+sWmMMCytOCj9CGVD1dESPKRQu13g5a5D2f7Sb9A20PLLnbml43xqp8/hVQBZc9A9VkSEkVic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KFq1OwZ4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RHedfU015559;
	Thu, 27 Feb 2025 19:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M8KgdG51XjvvUBG5Q6EnKiwzUq2eg9eLK3JCQWf+60w=; b=KFq1OwZ44dMn0sP3
	SAZUeHoQBs62kWbr89qmuQffLZEP6Q03xhqkvDk1VL2LOeFLItuqJCfi6ZyAa82e
	C9seN2oj48L8cy3vPLT6gbGKiT5arVe1fcjOBu0ljsrJmFbGbZB2d08xm7WBHgpT
	WD9zI7Xi57Vl2AQpzdkACuTHi6PM5zwWbipqNo3s3NlWqJAxu7fFRj6nOebvreAw
	jY/eZL1tGPMLdUMZOnugmGNAdxfKKZgH2zYM2PJFQGWmQM7iBHV7RLhYqJC8JpiH
	NHNq0S6dGlWrPOn9OPFBUDaNEFxIGoBVIIDwWoAYa2l7DJUrBSMw7uGsdBXojUMj
	4jp0iw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prnpt1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 19:11:47 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51RJBkJn002228
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 19:11:46 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 27 Feb 2025 11:11:42 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Sowmiya Sree
 Elavalagan" <quic_ssreeela@quicinc.com>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH v7 12/13] wifi: ath12k: Power down userPD
Date: Fri, 28 Feb 2025 00:40:33 +0530
Message-ID: <20250227191034.1949954-13-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227191034.1949954-1-quic_rajkbhag@quicinc.com>
References: <20250227191034.1949954-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: A-j9NYLCllQBQt8U-wOqPllfz-z6Ll8d
X-Proofpoint-ORIG-GUID: A-j9NYLCllQBQt8U-wOqPllfz-z6Ll8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270142

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
index 842ba9451e80..60257c4d2210 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -463,6 +463,34 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
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
+		ath12k_err(ab, "scm pas shutdown failed for userPD%d: %d\n",
+			   ab_ahb->userpd_id, ret);
+}
+
 static void ath12k_ahb_init_qmi_ce_config(struct ath12k_base *ab)
 {
 	struct ath12k_qmi_ce_cfg *cfg = &ab->qmi.ce_cfg;
@@ -679,6 +707,7 @@ static const struct ath12k_hif_ops ath12k_ahb_hif_ops_ipq5332 = {
 	.irq_disable = ath12k_ahb_ext_irq_disable,
 	.map_service_to_pipe = ath12k_ahb_map_service_to_pipe,
 	.power_up = ath12k_ahb_power_up,
+	.power_down = ath12k_ahb_power_down,
 };
 
 static irqreturn_t ath12k_userpd_irq_handler(int irq, void *data)
@@ -1094,6 +1123,7 @@ static void ath12k_ahb_remove(struct platform_device *pdev)
 	struct ath12k_base *ab = platform_get_drvdata(pdev);
 
 	if (test_bit(ATH12K_FLAG_QMI_FAIL, &ab->dev_flags)) {
+		ath12k_ahb_power_down(ab, false);
 		ath12k_qmi_deinit_service(ab);
 		goto qmi_fail;
 	}
-- 
2.34.1



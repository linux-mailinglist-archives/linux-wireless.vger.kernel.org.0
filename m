Return-Path: <linux-wireless+bounces-18188-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5B6A2283D
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 05:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603623A3FF2
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 04:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AEA1B0F27;
	Thu, 30 Jan 2025 04:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HH1Rodgx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B041AD3F6;
	Thu, 30 Jan 2025 04:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738211794; cv=none; b=Vrej3F4F5KiBOWZCz2z1po+skfkFEj7GTzU5ONtd6Me8TUUJypGlNvYUqVx3LyZMO3z4ntfeHMCRhh1NTzDg3/UseqiQed5qTT1FnvszRiqDvUTODUKJRrXt54yDRYv6fSC+a+WatINwrihFYSs6xBsgtMyvwDg7lmxMz1Tg0tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738211794; c=relaxed/simple;
	bh=Ay134KtZxc6klBplhYvdKLqIiB0xhBXqqO0rXa24C2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cSAUQOmeJGXTjtwUuY1GnGh/29VfLOxSTOZa5ISs9Za9JOUND2R6j4Brm4+EnqGP73M1+epm5RlG836TLFzEYd7AT2mKbYo02KHcigzrk3z5btX1fMhX9vcdFTQFa93LUiYkjJnAtO0fcbsilgugVMA+ac2t5SAJUZlobK+E69w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HH1Rodgx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TMkkkf012288;
	Thu, 30 Jan 2025 04:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AHjeST+t526PWpe+mYa2IRsUpuCqgHHr8VsDXKfy8PY=; b=HH1RodgxS8+obNZk
	O4XzxKbc82veVAYynoAXf47B+saDLhxMPcw46Duo485HmF/p7aznYc7YIf4BauV2
	O1ozNSJOzqYaKWIqU21jbTRFnXTJa96tBGZkNOjoxGcJOYbQkB4Qi+tYwnGUZveA
	ubDKvtBg0aDxQEwR2u0BoKvcknuPzGXXBJIBNjOsbFoJJisJvELZq3yknFu9E4u2
	Wo8dKFKgI8onA9RZKynUtikUiQRki6xPanF+mH41h9FAZ6HQwSsF3cNIgamMFOz2
	AaregheeaURbTJ4zTsM1wg/vRGLInwQWjsiQVkqPdtZ7YdhTsvZThU0zB/PrNgcS
	SyJJTg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fwe28g8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 04:36:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50U4aQLd004049
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 04:36:26 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 29 Jan 2025 20:36:23 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Sowmiya Sree
 Elavalagan" <quic_ssreeela@quicinc.com>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH v5 12/13] wifi: ath12k: Power down userPD
Date: Thu, 30 Jan 2025 10:05:07 +0530
Message-ID: <20250130043508.1885026-13-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130043508.1885026-1-quic_rajkbhag@quicinc.com>
References: <20250130043508.1885026-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QdLFSyhWt5XjyXeYOq1V_w-ALgzQRA7l
X-Proofpoint-GUID: QdLFSyhWt5XjyXeYOq1V_w-ALgzQRA7l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300033

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
index bd2180d18e8d..0dbee14fbe90 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -472,6 +472,34 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
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
@@ -688,6 +716,7 @@ static const struct ath12k_hif_ops ath12k_ahb_hif_ops_ipq5332 = {
 	.irq_disable = ath12k_ahb_ext_irq_disable,
 	.map_service_to_pipe = ath12k_ahb_map_service_to_pipe,
 	.power_up = ath12k_ahb_power_up,
+	.power_down = ath12k_ahb_power_down,
 };
 
 static irqreturn_t ath12k_userpd_irq_handler(int irq, void *data)
@@ -1153,6 +1182,7 @@ static void ath12k_ahb_remove(struct platform_device *pdev)
 	struct ath12k_base *ab = platform_get_drvdata(pdev);
 
 	if (test_bit(ATH12K_FLAG_QMI_FAIL, &ab->dev_flags)) {
+		ath12k_ahb_power_down(ab, false);
 		ath12k_qmi_deinit_service(ab);
 		goto qmi_fail;
 	}
-- 
2.34.1



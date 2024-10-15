Return-Path: <linux-wireless+bounces-13983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5FF99F53D
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 20:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBFB2843ED
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 18:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D253F227BAE;
	Tue, 15 Oct 2024 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FW1a6Pr2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A2A227B9A;
	Tue, 15 Oct 2024 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016853; cv=none; b=jnCDjuIwTeTujrHvU5vEhNiJuGTpoIv1GodJOLi+G34IspZay0XaN3oSSoC54tSsgE7wLtn7qYoiZGGHwb4whp5Au3NtyOHkdlXjNyimDo08+PAea3z07oD2BJ27ou7lK82B/2x4oD99blpITGJG7caCJRKD45uO7krEg9TSahc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016853; c=relaxed/simple;
	bh=J3uUTyIRDaRwWGT9iRStlpIppPRJMqwFAHkkg75gNOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fCTtkdz06h9WUlSRkbw4MF9DhhNKvJf3wFhhXlBbAm35lF5u2JkpOZr1K1DDVHvqmD64b9a4Dh6T55W1F8jehWCKEa6gCAzBZAsanHaKI0uzDLLHKIuxzVXDgAn/DHQ4zx4IGltj1foseRKGycS9h1qMdhWnmkwNoixHvh4dqDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FW1a6Pr2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHBcSw027858;
	Tue, 15 Oct 2024 18:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vXdN80U/uRJloAKcydRUFaE+0uIPeptnHFgeAHJ+/KY=; b=FW1a6Pr2O45JbLtZ
	hR2q7Tm5tVvR+b9R23q4qkFBhk/mEtoCkZSPBFpslAKYpyvzLHLu0G7xZP22Rk8i
	OOi18DQauGxDpAeJcfcsgw2mA90HJJGpSpdjrs2AUeeyvj3qK7Capkeygt+ejfBL
	6S2jMetzmSldm1WD6aMq+KVKEm0GyxxkGRa16CDeehv9NBd+RvA18NVg40kfjnii
	DnKSAnfMWp23DO4dojZT2tr9ITQ0BABMbSdr3fG3AsvFYL60XbeBYYFnxKxxmzS6
	334LCC6U7ivY85N94z45gd2ghXH+e94uIHckKkuKeF2DwlWUkDSGHCpWpEIIw1OV
	qnG8sw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429m0f9vrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:27:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FIRO9P012906
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:27:24 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 11:27:19 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v2 02/22] arm64: dts: qcom: add wifi node for IPQ5332 based RDP441
Date: Tue, 15 Oct 2024 23:56:17 +0530
Message-ID: <20241015182637.955753-3-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: Awhfkq3mD4ADpeCjS736dMx_0QSh21Je
X-Proofpoint-ORIG-GUID: Awhfkq3mD4ADpeCjS736dMx_0QSh21Je
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 spamscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150125

RDP441 is based on IPQ5332. It has inbuilt AHB bus based IPQ5332 WiFi
device.

Describe and add WiFi node for RDP441. Also, reserve the memory
required by IPQ5332 firmware.

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts |  59 ++++++++++-
 arch/arm64/boot/dts/qcom/ipq5332.dtsi       | 108 +++++++++++++++++++-
 2 files changed, 165 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
index 846413817e9a..699422299336 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
@@ -2,7 +2,7 @@
 /*
  * IPQ5332 AP-MI01.2 board device tree source
  *
- * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 /dts-v1/;
@@ -12,6 +12,51 @@
 / {
 	model = "Qualcomm Technologies, Inc. IPQ5332 MI01.2";
 	compatible = "qcom,ipq5332-ap-mi01.2", "qcom,ipq5332";
+
+	/*                 Default Profile
+	 * +============+==============+=====================+
+	 * |            |              |                     |
+	 * | Region     | Start Offset |       Size          |
+	 * |            |              |                     |
+	 * +------------+--------------+---------------------+
+	 * |            |              |                     |
+	 * |            |              |                     |
+	 * |            |              |                     |
+	 * | WLAN Q6    |  0x4A900000  |       43MB          |
+	 * |            |              |                     |
+	 * |            |              |                     |
+	 * +------------+--------------+---------------------+
+	 * | M3 Dump    |  0x4D400000  |       1MB           |
+	 * +============+==============+=====================+
+	 * |                                                 |
+	 * |                                                 |
+	 * |                                                 |
+	 * |            Rest of memory for Linux             |
+	 * |                                                 |
+	 * |                                                 |
+	 * |                                                 |
+	 * +=================================================+
+	 */
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		q6_region: wcss@4a900000 {
+			reg = <0x0 0x4a900000 0x0 0x02b00000>;
+			no-map;
+		};
+
+		m3_dump: m3_dump@4d400000 {
+			reg = <0x0 0x4D400000 0x0 0x100000>;
+			no-map;
+		};
+
+		/* mlo_global_mem0: The MLO global memory is not
+		 * enabled yet.
+		 */
+	};
 };
 
 &blsp1_i2c1 {
@@ -21,6 +66,18 @@ &blsp1_i2c1 {
 	status = "okay";
 };
 
+&wifi0 {
+	memory-region = <&q6_region>;
+	qcom,rproc = <&q6v5_wcss>;
+	qcom,smem-states = <&wcss_smp2p_out 8>,
+			   <&wcss_smp2p_out 9>,
+			   <&wcss_smp2p_out 10>;
+	qcom,smem-state-names = "shutdown",
+				"stop",
+				"spawn";
+	status = "okay";
+};
+
 &sdhc {
 	bus-width = <4>;
 	max-frequency = <192000000>;
diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 06fe7c94ee37..b419edfea0cd 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -2,7 +2,7 @@
 /*
  * IPQ5332 device tree source
  *
- * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <dt-bindings/clock/qcom,apss-ipq.h>
@@ -517,6 +517,112 @@ glink-edge {
 				mboxes = <&apcs_glb 8>;
 			};
 		};
+
+		wifi0: wifi@c0000000 {
+			compatible = "qcom,ipq5332-wifi";
+			reg = <0xc000000 0x1000000>;
+			clocks = <&gcc GCC_XO_CLK>;
+			clock-names = "gcc_xo_clk";
+			interrupts-extended = <&wcss_smp2p_in 9 IRQ_TYPE_NONE>,
+					      <&wcss_smp2p_in 12 IRQ_TYPE_NONE>,
+					      <&wcss_smp2p_in 11 IRQ_TYPE_NONE>,
+					      <&intc GIC_SPI 559 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 560 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 561 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 422 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 423 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 424 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 425 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 426 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 427 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 428 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 429 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 430 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 431 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 432 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 433 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 491 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 495 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 493 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 544 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 457 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 466 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 497 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 454 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 453 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 452 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 451 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 488 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 488 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 484 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 554 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 554 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 549 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 507 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 500 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 499 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 498 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 450 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 449 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 448 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 447 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 543 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 486 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 486 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 482 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 419 IRQ_TYPE_EDGE_RISING>;
+
+			interrupt-names = "ready",
+					  "spawn",
+					  "stop-ack",
+					  "misc-pulse1",
+					  "misc-latch",
+					  "sw-exception",
+					  "ce0",
+					  "ce1",
+					  "ce2",
+					  "ce3",
+					  "ce4",
+					  "ce5",
+					  "ce6",
+					  "ce7",
+					  "ce8",
+					  "ce9",
+					  "ce10",
+					  "ce11",
+					  "host2wbm-desc-feed",
+					  "host2reo-re-injection",
+					  "host2reo-command",
+					  "host2rxdma-monitor-ring1",
+					  "reo2ost-exception",
+					  "wbm2host-rx-release",
+					  "reo2host-status",
+					  "reo2host-destination-ring4",
+					  "reo2host-destination-ring3",
+					  "reo2host-destination-ring2",
+					  "reo2host-destination-ring1",
+					  "rxdma2host-monitor-destination-mac3",
+					  "rxdma2host-monitor-destination-mac2",
+					  "rxdma2host-monitor-destination-mac1",
+					  "host2rxdma-host-buf-ring-mac3",
+					  "host2rxdma-host-buf-ring-mac2",
+					  "host2rxdma-host-buf-ring-mac1",
+					  "host2tcl-input-ring4",
+					  "host2tcl-input-ring3",
+					  "host2tcl-input-ring2",
+					  "host2tcl-input-ring1",
+					  "wbm2host-tx-completions-ring4",
+					  "wbm2host-tx-completions-ring3",
+					  "wbm2host-tx-completions-ring2",
+					  "wbm2host-tx-completions-ring1",
+					  "host2tx-monitor-ring1",
+					  "txmon2host-monitor-destination-mac3",
+					  "txmon2host-monitor-destination-mac2",
+					  "txmon2host-monitor-destination-mac1",
+					  "umac_reset";
+
+			status = "disabled";
+		};
 	};
 
 	timer {
-- 
2.34.1



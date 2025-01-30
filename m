Return-Path: <linux-wireless+bounces-18190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0753EA22859
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 05:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DFA188746B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 04:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B721494D8;
	Thu, 30 Jan 2025 04:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Sa4UGcy9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BD4179BC;
	Thu, 30 Jan 2025 04:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738213172; cv=none; b=ac4j3QhwxGw7xeug0YZ8x8LNIT+BenkpdShD61qZvLphnKIEHW6TmKSCHoXqSOiltA1+jA+eqZQlKMA+JSISYwDSMyBBqIFfmtb6U7vWZoJqJykixTonH3qWU175BkHHz6Z1HjgXRBXJLhjRSKHi2EadKPfdWpYU9P9XrUdNm5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738213172; c=relaxed/simple;
	bh=GaZ1XjTNSx2/hu8Iza7BxFNn2rVO6yWgg9DEWAAnCbs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o399SWwgNuRHxrnx/xmf2L4HN4lcznjlllmgXIFDWRsuIM03UPAmDkgtXI0puU0cs05R1eXyrYt0U43X7Eeg94Y+u99aWqjbS9XbPr8Ac3LRIpTcOPdzx11umYDXjzSDhVPcINcW4TXVMJYqhUmBSDP/7lBEiynoGXucyYp249o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Sa4UGcy9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U1coJc023049;
	Thu, 30 Jan 2025 04:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=IH5/sW6f+JNVX0G8psnpK1
	RkUkDiWwRi4YJcMaueWYg=; b=Sa4UGcy9lYMxYzVfuR+dLOnLH8Re74b9+YiAwn
	irzemFL1otSfBGuHNFi42/t9GDskLVv3M4VAL7DxCZ69yiUWhGEuI98ZEaHaPNJh
	MCW3MFv8MJaJFAF1mCbsY3ITJl7WpR621eu/CAxHl/YDAGebqxHujgh7fVghtdgV
	zNfmo7tBe5xek5RcrBDanSQ4h/EK724UKBh9M3BEXL0DLVtLukmW2KEOf3UrwGmT
	x8umfMbHPjFn+D8O+6bzyb2MajyZaYYSCFrf0vaQ0LmVVDvyrjYoMCbQFfUEUKh1
	zUliH+j8c7O9gFzb5T+HAE37QnoN93r+PIsl8iuMCows2rUQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fyxnr8x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 04:59:26 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50U4xPU8002868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 04:59:25 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 29 Jan 2025 20:59:22 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH v2] arm64: dts: qcom: add wifi node for IPQ5332 based RDP441
Date: Thu, 30 Jan 2025 10:29:00 +0530
Message-ID: <20250130045900.1903927-1-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: NDRM274H4kaDuWyWqCksfiV5DisLkWCD
X-Proofpoint-GUID: NDRM274H4kaDuWyWqCksfiV5DisLkWCD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300036

RDP441 is based on IPQ5332. It has inbuilt AHB bus based IPQ5332 WiFi
device.

Describe and add WiFi node for RDP441. Also, reserve the memory
required by IPQ5332 firmware.

Depends-On: [PATCH V2 0/2] mailbox: tmel-qmp: Introduce QCOM TMEL QMP mailbox driver
Depends-On: [PATCH V3 0/8] Add new driver for WCSS secure PIL loading
Link: https://lore.kernel.org/lkml/20241231054900.2144961-1-quic_srichara@quicinc.com/
Link: https://lore.kernel.org/lkml/20250107101647.2087358-1-quic_gokulsri@quicinc.com/

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
NOTE:
The DT binding changes for this patch has been posted along with the
driver ath12k AHB series.
Link: https://lore.kernel.org/all/20250130043508.1885026-1-quic_rajkbhag@quicinc.com/

v2:
- Dropped 'dt-bindings: net: wireless: describe the ath12k AHB module'.
  This DT binding is posted along with the ath12k AHB driver changes.
- Reserved four memory regions required by IPQ5332 ath12k firmware in DTS.
  These memory regions are also referenced in the WiFi node.
- Moved 'qcom,smem-states' and 'qcom,smem-states' to the ipq5332.dtsi file.
- Used lowercase hex values for the reg property.

v1: https://lore.kernel.org/all/20250128091012.2574478-1-quic_rajkbhag@quicinc.com/
---
 arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts |  64 ++++++++++-
 arch/arm64/boot/dts/qcom/ipq5332.dtsi       | 113 ++++++++++++++++++++
 2 files changed, 176 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
index 846413817e9a..4b7a75e450ca 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
@@ -2,7 +2,7 @@
 /*
  * IPQ5332 AP-MI01.2 board device tree source
  *
- * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 /dts-v1/;
@@ -12,6 +12,61 @@
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
+	 * +------------+--------------+---------------------+
+	 * | Q6 caldb   |  0x4D500000  |       5MB           |
+	 * +------------+--------------+---------------------+
+	 * | MLO        |  0x4DB00000  |       18MB          |
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
+		m3_dump: m3-dump@4d400000 {
+			reg = <0x0 0x4d400000 0x0 0x100000>;
+			no-map;
+		};
+
+		q6_caldb: q6-caldb@4d500000 {
+			reg = <0x0 0x4d500000 0x0 0x500000>;
+			no-map;
+		};
+
+		mlo_mem: mlo-global-mem@4db00000 {
+			reg = <0x0 0x4db00000 0x0 0x01200000>;
+			no-map;
+		};
+	};
 };
 
 &blsp1_i2c1 {
@@ -63,3 +118,10 @@ data-pins {
 		};
 	};
 };
+
+&wifi0 {
+	memory-region = <&q6_region>, <&m3_dump>, <&q6_caldb>, <&mlo_mem>;
+	memory-region-names = "q6-region", "m3-dump", "q6-caldb", "mlo-global-mem";
+	qcom,rproc = <&q6v5_wcss>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 85e10b20342a..1653da89d413 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -485,6 +485,119 @@ frame@b128000 {
 			};
 		};
 
+		wifi0: wifi@c000000 {
+			compatible = "qcom,ipq5332-wifi";
+			reg = <0x0c000000 0x1000000>;
+			clocks = <&gcc GCC_XO_CLK>;
+			clock-names = "xo";
+			interrupts-extended = <&wcss_smp2p_in 8 IRQ_TYPE_NONE>,
+					      <&wcss_smp2p_in 9 IRQ_TYPE_NONE>,
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
+			interrupt-names = "fatal",
+					  "ready",
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
+					  "umac-reset";
+
+			qcom,smem-states = <&wcss_smp2p_out 8>,
+					   <&wcss_smp2p_out 9>,
+					   <&wcss_smp2p_out 10>;
+			qcom,smem-state-names = "shutdown",
+						"stop",
+						"spawn";
+			status = "disabled";
+		};
+
 		q6v5_wcss: remoteproc@d100000 {
 			compatible = "qcom,ipq5332-wcss-sec-pil";
 			reg = <0xd100000 0x4040>;
-- 
2.34.1



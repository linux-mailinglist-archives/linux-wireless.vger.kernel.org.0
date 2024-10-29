Return-Path: <linux-wireless+bounces-14682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BDB9B50FF
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 18:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5491C22C19
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 17:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9971F20BB41;
	Tue, 29 Oct 2024 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NPpSiuJI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AAC20B214;
	Tue, 29 Oct 2024 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730223116; cv=none; b=YH5ktGWt9fGJ9SGwaOTLseNMenHDrEsstqrWMdDnFC7e4XS2e1ja3m7CO1NNNQktrIchccMohvwSK6+Bi8u/ARCvEbIX9gSIXIScKMh2dbs503zEn+aDfUDjj3R6RQPTE7nMIQid7TyWFmhC5h7WmWFMV/HU57/Gsx7MQFBRuWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730223116; c=relaxed/simple;
	bh=Fcusc6fplzeYzfxqMjbeHOwKEx+ya8tu6hFlmrRZ9rw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8VW6/5EInVSHDp6XXIzgFOtXVd9By5fu0TTvQtUL/36pqgIzcfe8MAQbb8Ezi2dgCAhu9+OT67vM3kz3KndqHERbduVAVf9gyldiap7sRsYuBWyUMVef73bOUk21j4eDS2pRUhYTu51FOw0a7fV1oYl/qMjRMLd9wFazF2UJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NPpSiuJI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TAUtQN017942;
	Tue, 29 Oct 2024 17:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	65yvnD26sz+F+JIFKjIUO91u2nGvJ/8frS1l3kchIwU=; b=NPpSiuJIaa0s8R31
	WeDTmNKsXxH8vtKQeiXg1Kqjo2fBQCaEYyN8FoVPTdtMkfnNW5M6lPqjt4bYjfR2
	V+GEakN/Cp0bSYzxKhSg1Nhxz+jm+jlzbD99lHZ23TQbiAnpknYAn6vApW9o9/SD
	9pNU65HMX3BYjq/55thO/PDt6138PMNMywQX0I368nlCoEI2+JmJIcAFy1vai0TF
	Pwxoc/BOkCOCCHU0J3XHRBXcsyOEZm3jlRgUM3ld8U4b/ITBsQAiIlNTLSWgTNaj
	1OjBhrq9p5apT/NcA2q1JINrDKe22zuhVAvfRFq2DHWXFbinLj2IFE/onqaLE+ny
	wiJJMw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gqrgs47g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 17:31:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49THVliD023944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 17:31:47 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 29 Oct 2024 10:31:43 -0700
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
Subject: [RFC PATCH v2 5/5] arm64: dts: qcom: ipq9574: Add WiFi nodes for RDP433
Date: Tue, 29 Oct 2024 23:00:50 +0530
Message-ID: <20241029173050.2188150-6-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029173050.2188150-1-quic_rajkbhag@quicinc.com>
References: <20241029173050.2188150-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 6S_ot7rnr18gQr2EpBfn24eFsvZuwvnN
X-Proofpoint-GUID: 6S_ot7rnr18gQr2EpBfn24eFsvZuwvnN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=733 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290132

The RDP433 is a Qualcomm Reference Design Platform based on the
IPQ9574. It has three QCN9274 WiFi devices connected to PCIe1, PCIe2,
and PCIe3. These devices are also connected among themselves via
WSI connection. This WSI connection is essential to exchange control
information among these devices

The WSI connection in RDP433 is represented below:

          +-------+        +-------+        +-------+
          | pcie2 |        | pcie3 |        | pcie1 |
          |       |        |       |        |       |
   +----->|  wsi  |------->|  wsi  |------->|  wsi  |-----+
   |      | grp 0 |        | grp 0 |        | grp 0 |     |
   |      +-------+        +-------+        +-------+     |
   +------------------------------------------------------+

Based on the above, the WSI properties for QCN9274 at pcie2 are
(considering QCN9274 at pcie2 is WSI master):

 qcom,wsi-group-id = 0
 qcom,wsi-master
 ports:
    tx-port (port@0): endpoint at pcie3 RX port.
    rx-port (port@1): endpoint at pcie1 TX port.

Hence, add WiFi nodes with WSI properties for all three QCN9274
devices connected to RDP433.

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 116 +++++++++++++++++++-
 1 file changed, 115 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
index 165ebbb59511..d0ecaefe5b41 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
@@ -3,7 +3,7 @@
  * IPQ9574 RDP433 board device tree source
  *
  * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 /dts-v1/;
@@ -27,6 +27,44 @@ &pcie1 {
 	perst-gpios = <&tlmm 26 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 27 GPIO_ACTIVE_LOW>;
 	status = "okay";
+
+	pcie@0 {
+		device_type = "pci";
+		reg = <0x0 0x0 0x0 0x0 0x0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+
+		wifi1@0 {
+			compatible = "pci17cb,1109";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+
+			wsi {
+				qcom,wsi-group-id = <0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						wifi1_wsi_tx: endpoint {
+							remote-endpoint = <&wifi2_wsi_rx>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						wifi1_wsi_rx: endpoint {
+							remote-endpoint = <&wifi3_wsi_tx>;
+						};
+					};
+				};
+			};
+		};
+	};
 };
 
 &pcie2_phy {
@@ -40,6 +78,45 @@ &pcie2 {
 	perst-gpios = <&tlmm 29 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 30 GPIO_ACTIVE_LOW>;
 	status = "okay";
+
+	pcie@0 {
+		device_type = "pci";
+		reg = <0x0 0x0 0x0 0x0 0x0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+
+		wifi2@0 {
+			compatible = "pci17cb,1109";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+
+			wsi {
+				qcom,wsi-group-id = <0>;
+				qcom,wsi-master;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						wifi2_wsi_tx: endpoint {
+							remote-endpoint = <&wifi3_wsi_rx>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						wifi2_wsi_rx: endpoint {
+							remote-endpoint = <&wifi1_wsi_tx>;
+						};
+					};
+				};
+			};
+		};
+	};
 };
 
 &pcie3_phy {
@@ -53,6 +130,43 @@ &pcie3 {
 	perst-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 33 GPIO_ACTIVE_LOW>;
 	status = "okay";
+
+	pcie@0 {
+		device_type = "pci";
+		reg = <0x0 0x0 0x0 0x0 0x0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+
+		wifi3@0 {
+			compatible = "pci17cb,1109";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+
+			wsi {
+				qcom,wsi-group-id = <0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						wifi3_wsi_tx: endpoint {
+							remote-endpoint = <&wifi1_wsi_rx>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						wifi3_wsi_rx: endpoint {
+							remote-endpoint = <&wifi2_wsi_tx>;
+						};
+					};
+				};
+			};
+		};
+	};
 };
 
 &sdhc_1 {
-- 
2.34.1



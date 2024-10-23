Return-Path: <linux-wireless+bounces-14353-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F359ABE53
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 08:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6C41F23E72
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 06:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13B61487DD;
	Wed, 23 Oct 2024 06:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ngm3FG0t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A41146D7F;
	Wed, 23 Oct 2024 06:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729663490; cv=none; b=jTazDbtB+bbld8Ihx+23RQkOfJVks7z7UotwmqSOmXA/JjGbltfjCy4h3usJ9IHUE1R6rntejjBZqYX6geQb4ZcCnmhKSykYWE7Mg+/c01HGJuT2QsqeMYICc4nRScAg5Tfj42BfiCOdHZGJlw5CcG5hcPW7rPrHgZLuiz3w6i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729663490; c=relaxed/simple;
	bh=cnYYxvw2lVcifHIOM7/Z+dgyp96zMVBY83rJdzBzFjs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KiGNKFi8vlXaEzjRIFNGxb/bfD+U2DFQvHnwrB4FEeF7C965IBeyTfqdpyrjYfy86VQEZjqgyvO5VpU4XEZdT9K2WjI81518N5XJ/hp+rxClSwUd2Qs61B7aPgd1dfNFR3XdkjjL384g38k80WfUb86VmD8H79tv1F3AcwjoF+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ngm3FG0t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLa3g0025438;
	Wed, 23 Oct 2024 06:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IsiY7yt8JQwkr/CGYzfeuyrwP4Vfcc8zvfnje5HZERo=; b=Ngm3FG0tISNV7E8W
	QeYJG+gD9SATa0CZOpF5Z6+qs9/8b4/eImhv4fFdgVWAyEju0RA7g1sPw5NxsGoA
	I4FZff3X1PFlDm971la/64Ime9qT/2gWEb1R/Q9YHMEoGs4LcICAX38ocHy9/4ty
	HCpF80kLewszCbYx6lR9PeMvIAJyNIogxERFAupE7k+qtu9wflb/J+Orx/tP1Evi
	qXHKxGXFs6Rxgrrvt8by4hS/OjCQpWJYPVf2gQC66kMm4Etja6C2Yn7TZHS3ev6V
	qigx2wdFTtq0woiWDd7/mAKnrbC8im9aY5XsY+96HImCqnPejsQ1Xko+EeHd0OE5
	FiryRA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em4091ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:04:45 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49N64iH3018169
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:04:44 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 23:04:40 -0700
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
Subject: [RFC PATCH 6/6] arm64: dts: qcom: ipq9574: Add WiFi nodes for RDP433
Date: Wed, 23 Oct 2024 11:33:52 +0530
Message-ID: <20241023060352.605019-7-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023060352.605019-1-quic_rajkbhag@quicinc.com>
References: <20241023060352.605019-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 9PUw3ig0SLfGvau46ldcCLW5RnzmvIWJ
X-Proofpoint-GUID: 9PUw3ig0SLfGvau46ldcCLW5RnzmvIWJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=754
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230035

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
   |      | idx 0 |        | idx 1 |        | idx 2 |     |
   |      +-------+        +-------+        +-------+     |
   +------------------------------------------------------+

Based on the above, the WSI properties for QCN9274 at pcie2 are:
 qcom,wsi-group-id = 0
 qcom,wsi-index = 0
 qcom,wsi-num-devices = 3;

Hence, add WiFi nodes with WSI properties for all three QCN9274
devices connected to RDP433.

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 62 ++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
index 165ebbb59511..2241e20ad42a 100644
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
@@ -27,6 +27,26 @@ &pcie1 {
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
+			status = "okay";
+
+			wsi {
+				qcom,wsi-group-id = <0>;
+				qcom,wsi-index = <2>;
+				qcom,wsi-num-devices = <3>;
+			};
+		};
+	};
 };
 
 &pcie2_phy {
@@ -40,6 +60,26 @@ &pcie2 {
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
+			status = "okay";
+
+			wsi {
+				qcom,wsi-group-id = <0>;
+				qcom,wsi-index = <0>;
+				qcom,wsi-num-devices = <3>;
+			};
+		};
+	};
 };
 
 &pcie3_phy {
@@ -53,6 +93,26 @@ &pcie3 {
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
+			status = "okay";
+
+			wsi {
+				qcom,wsi-group-id = <0>;
+				qcom,wsi-index = <1>;
+				qcom,wsi-num-devices = <3>;
+			};
+		};
+	};
 };
 
 &sdhc_1 {
-- 
2.34.1



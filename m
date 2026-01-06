Return-Path: <linux-wireless+bounces-30373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F53CF63F6
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 02:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA39B303A943
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 01:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A4A31AF3F;
	Tue,  6 Jan 2026 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NsQ90LZW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SgQC/slc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8172D3168E3
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 01:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661304; cv=none; b=Uurk0cfKx1vBNI9Vb0fqnlCAmx7YV3LWAZnxwZTporVzze/dR2Ah8GkkEJNobLbjYmL/dwHoRD3VDrYuvv7BbDtOKKS7EsR/Tla5QVbdDJEhFdSZWA5HO3GefvKJ9CFYHAJvfF6niuH1MeyHElcCR6wt8GHipOdWSZDyK62v4/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661304; c=relaxed/simple;
	bh=OJr4yv9vJmkaC7saidnllHnC/2Dn/uant8yGpklrbes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sIQ5/W91MqQ/JPW0lCLF4HwCW7tnON/KzPzvvSwM7L7Wm8EqX5k5itlrRigAiltweV3PwpMZsif6TlK+V9qSUiNpikO4/GrsES7olSxy/aiXefTxx/rwKje2OpZxwV+2Of8Ki02lVUQtiJgn3TECeiEySC6hL01rx4ag0TcryZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NsQ90LZW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SgQC/slc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060oW6U2972299
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 01:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KvLj2ZrhI8wZXWx5+lQ/XFK1dsetMDN49y/jhkiekz4=; b=NsQ90LZWElNYoObw
	wyUFxyuvLOYFFv37MI27GJcR8wHbhww4Z0SaUMjwzeUKVcQW7MPiAi6mbjuikA2+
	kkurrsp83Cgcgln8Bi08M8sNRpDhX0K5ygbhikAaonTdVRwiubgNG+T2JDzRm1nm
	ks8KnPm/BN0wh3kSpERGi29QwHCHFz4cPJiPe+BYEtF/rTA17HyjyjPoce4PKJ1/
	mK94ijHaV4Ct9pfhNChNGaXTzXnqauqQjnWAAHBDb/eK1ML1CpSfMipP7rLw5S2U
	/B67lkAxn+Cd+fHlPhm4jpoyWQic+aiGTJVPeLpJFgy5d5iBvi3rv2gi5DVSMwxm
	OoIJWA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bggsvs7r1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 01:01:41 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f1b39d7ed2so8952381cf.2
        for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 17:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661301; x=1768266101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KvLj2ZrhI8wZXWx5+lQ/XFK1dsetMDN49y/jhkiekz4=;
        b=SgQC/slc90GS1NPzUw4WP2WFfMF5/TLruwhiggoqgN4hA745YofLuwfv+LCqlgocVI
         lSCsBBm9uMiNHUkqilV0/iSs5X07sBi3VtHltyriv5b8GlwraKEaHHdO2zYo+IXsUErC
         7Mz32YaYCTmkeKY9rSygEh8NSdmD1Eh2bUnWXjsc5+7eQfODGv+qWPIjMwfF/S0Rbx+y
         YH7jB/VAjUpO4rfKRxEIncnEHt3QbxVJ4pWnFtCG3zo/RLv8306+EZ921sJHeIlq5/je
         G9MwwB9cn40hi2Zr3+9QQes5f/184gmocSicaM1lO5mMwbVq7KsKTuj93rHapMNgd1vO
         3LZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661301; x=1768266101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KvLj2ZrhI8wZXWx5+lQ/XFK1dsetMDN49y/jhkiekz4=;
        b=Yr+PqBsV6vvcS1R4PjAOBU+ZzzAutDhd2W4hqF5qYfR3jIyXbLlSS5IopXc0EIiYNx
         eclX26q0jcf3Dv84B5yY0z97RLxwYAkKhlmiiM3v56KIJnZ3iBpn6r4CXEjgo3tVlmJZ
         N3bH4t306w+nT2NOoqPoElmUwUmzD7q9Ypxi2zNZkatenL2crwkWWJlGPPPU3UY8xq4N
         /LttAifbwiJ51QwtOcTImljsAhqh3qnzrsO/WJpOFejcgcfv4i5mXck/+frZOC2Vg0zQ
         GH9ZaALUBDKExE3OMLQkq6NYY6tOW9FnoRQCmGtuxem2ptp9MTpYf8RTedDiPbuDGeJ+
         OUvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkMsL9QAbPeVWzXhfeeFH8pUucqeU00l8fdXpd0x8aEYjNfZ/6YSEAxdcGdMSx0VwG+7c7MgUD7waEgf7ciA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMeDnFwPSQd02dyVXnNtD7PSIYnyKMglgkHVGBH5At0YQU0EDe
	8downwFQRUapEBtLEp3qxc5QOKFzF+YMoNydo5LvQ8LEG1SzN3y3gR7CupILsUqv8pPsFBpojuu
	1yaBjlEFHSoD6XqzK2wpU4Kxf8bCqaxvnSlsBKnLql4/WtlBo/WuzlYtZnyuuNHWtyma6Iw==
X-Gm-Gg: AY/fxX6/9eS3ZU8YafpgDDVq+vPzKXvR7PaP3SKbkx3NJwJxL7Ql7LhKmDU1X+8XeGZ
	zyObSuWsXtjopUBGxVfzesQ9Pj3blc5QidY8BFl2wIOyAj9ksgKWNgtfAEWf0T/eO1qT0UaL9W8
	y4HW3X8EhSW/t6umYvI7tBRDchKALcMdGvvCEKmlZ5fGntAcDKyYTzbNOvkhwM1JpmSN3Y7JYG+
	ZZG3WOFdGEL+N6aGS4FcD5lAV70xhSoqZ6cnjlkim+toD4gAMnrt5k7AU62Beob2hU4+X7W1er8
	tmXWqmYJ5sMfDOzWJDTSg0M+0dralqEzV4LbQW+zKOi9Mvdm0jbTqyvdRw1si8OrTedWOT5Tvwt
	ywG5PMN2UVkpue+3Na6UMuO4S5x49j+3O7p2H7U6+EvZirPqmq8mnWFBMZN9RmhmAKAf/2z52wz
	mmpygydTtcqJfRYkzoerq7vlY=
X-Received: by 2002:a05:622a:4209:b0:4ed:dcf0:6c42 with SMTP id d75a77b69052e-4ffa77ba644mr18752291cf.40.1767661300721;
        Mon, 05 Jan 2026 17:01:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoefOZDx2zHfaoSVi9LoeU8tZQ/pUprtXoEP2cNM6nYtY1N/LLfnxX03xQAdXCwp2mIo1UCg==
X-Received: by 2002:a05:622a:4209:b0:4ed:dcf0:6c42 with SMTP id d75a77b69052e-4ffa77ba644mr18751491cf.40.1767661300149;
        Mon, 05 Jan 2026 17:01:40 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:39 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:20 +0200
Subject: [PATCH v2 10/14] arm64: dts: qcom: qrb2210-rb1: describe WiFi/BT
 properly
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-10-0386204328be@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
In-Reply-To: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2734;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=OJr4yv9vJmkaC7saidnllHnC/2Dn/uant8yGpklrbes=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7a+AuXommsi+raf46ccQEIGL4H6RNRglLRB
 hETuM60QFyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2gAKCRCLPIo+Aiko
 1fbbB/wIur9WgLQAj85cFpCSRdmxky4RhlzO8L0F8FRtkGWU7Hfoh8M0yUWaC7FWbxm19Mc/Xha
 evzPI7A185XhJyAoZrKnTv2BVHxvrCn7i934dNXuexINmWVreXQE0enMQcEfPxex7E3BBFTSKGm
 g6oAxG6XLrRgvrP0Q+nnnyzqYvLkWElaiNzJLWT9kRKoLQUrHC89MCvYcoImPXE4Wg7xYTCpDQx
 37sVCDRuqsh659+tl0mhcrs2b3ckKwBruy1InqhrDRXnKNUZqueFSDQAZHDaKvlcSiSI/9Ju4vE
 Gev0U3ks6+2HxWLpww5yPid4KWZouTSfKxNGvuYjdzgnTBD5
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 0RJaUS8O78x7_cIWrhbK2OcMLIMoRnL0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfX6tj0gmmi1AC0
 94hESeWUKb4hrdwSPWXKY/2bFZXmuTckyKGct8fPJs+pycb/2qVLVrMdGCrVCIBClWYxalkT4w2
 W66M6lwsqrU2xZ1eiYTXdpwLD+bOV6etUVENeVVJKIJ1vD7MgikOSkpObVjHoChwjWmPmmE0gT3
 GCenE43isUpcBRPehytz9EvhRJqpZIzuenD1G4U85CY4NaoM22rC/zlhrsJWXhbwuir95IhCyvE
 snOBUq7QGxlm5+jDbw5FsDa9Icm8gEFVmQlnx5K/T3RejaaRnmPjSpirk8OV24e6BzNcQshyzmn
 mYnsD2IYQXyZ7Zn1fTZhBAGofWcYcgQjySPI45q03URICIIGpiHiY7ABmhGOeW9eVIBqo/E091f
 yHb0VqOxWHlcMe/+IYNqmF2D97j3F731s+HazxNGqNwF+oRwS6j6bu3OcHYgZ3ec+0ZvZXRr13k
 uibWYYCvLr6yHFbzVoA==
X-Proofpoint-ORIG-GUID: 0RJaUS8O78x7_cIWrhbK2OcMLIMoRnL0
X-Authority-Analysis: v=2.4 cv=Yv4ChoYX c=1 sm=1 tr=0 ts=695c5ef5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=wL7gHOWyGnUXpuUc2qQA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060007

The onboard WiFi / BT device, WCN3950, has a simple on-chip PMU, which
further spreads generated voltage. Describe the PMU in the device tree.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 60 +++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index 1b9ca957a94b..6fa2288b709c 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -235,6 +235,42 @@ platform {
 			};
 		};
 	};
+
+	wcn3950-pmu {
+		compatible = "qcom,wcn3950-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		vddio-supply = <&pm4125_l15>;
+		vddxo-supply = <&pm4125_l13>;
+		vddrf-supply = <&pm4125_l10>;
+		vddch0-supply = <&pm4125_l22>;
+
+		swctrl-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
+
+		regulators {
+			vreg_pmu_io: ldo0 {
+				regulator-name = "vreg_pmu_io";
+			};
+
+			vreg_pmu_xo: ldo1 {
+				regulator-name = "vreg_pmu_xo";
+			};
+
+			vreg_pmu_rf: ldo2 {
+				regulator-name = "vreg_pmu_rf";
+			};
+
+			vreg_pmu_ch0: ldo3 {
+				regulator-name = "vreg_pmu_ch0";
+			};
+
+			vreg_pmu_ch1: ldo4 {
+				regulator-name = "vreg_pmu_ch1";
+			};
+		};
+	};
 };
 
 &cpu_pd0 {
@@ -679,6 +715,12 @@ lt9611_irq_pin: lt9611-irq-state {
 		bias-disable;
 	};
 
+	sw_ctrl_default: sw-ctrl-default-state {
+		pins = "gpio87";
+		function = "gpio";
+		bias-pull-down;
+	};
+
 	sd_det_in_on: sd-det-in-on-state {
 		pins = "gpio88";
 		function = "gpio";
@@ -714,11 +756,10 @@ &uart3 {
 	bluetooth {
 		compatible = "qcom,wcn3950-bt";
 
-		vddio-supply = <&pm4125_l15>;
-		vddxo-supply = <&pm4125_l13>;
-		vddrf-supply = <&pm4125_l10>;
-		vddch0-supply = <&pm4125_l22>;
-		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
+		vddio-supply = <&vreg_pmu_io>;
+		vddxo-supply = <&vreg_pmu_xo>;
+		vddrf-supply = <&vreg_pmu_rf>;
+		vddch0-supply = <&vreg_pmu_ch0>;
 		max-speed = <3200000>;
 	};
 };
@@ -759,10 +800,13 @@ &venus {
 };
 
 &wifi {
+	/* SoC */
 	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
-	vdd-1.8-xo-supply = <&pm4125_l13>;
-	vdd-1.3-rfa-supply = <&pm4125_l10>;
-	vdd-3.3-ch0-supply = <&pm4125_l22>;
+
+	/* WiFi / BT PMU */
+	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
+	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
+	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
 	qcom,calibration-variant = "Thundercomm_RB1";
 	firmware-name = "qcm2290";
 	status = "okay";

-- 
2.47.3



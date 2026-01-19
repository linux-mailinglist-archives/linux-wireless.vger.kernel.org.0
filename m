Return-Path: <linux-wireless+bounces-30972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F19D3B42A
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 18:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BAC23115FDC
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 17:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C574E32B9AD;
	Mon, 19 Jan 2026 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nx/2obPU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gGuG3T77"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF7232BF26
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842493; cv=none; b=HWWIvQAapLW2Sxe4u8oa5Wr3HdjEazXmM3x5zEJXJEIPvyaI+W9lSksuK+h/9OzT55LCeei0Fk503vz8oo9dzjpkk1/cHxVWTNJTAT4w+CFk6UWPRJbfUcUSFYShRzzHPrZF48RiZ6OW576qszs50lVM6OAycrio1bII7dbkoEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842493; c=relaxed/simple;
	bh=enCKpNdnBrXZA+wiHIdAIv2kSpfxxx9vISm1ccZ1t9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tQCHDhI1rSr1lgP2a487ZUibfls8mI7bYzfni+eVxdkCmqKno0PZVfkv+uG8b28PUEjLpARimoEj6EWF2O/CeIVGjJqWGGYiQNzn77iTEsg9f1KGOP84CJUWZxGjP79jnaya5UQtx2+eEi/HIQmigdiMihEteLbLTpUsGMfdLZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nx/2obPU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gGuG3T77; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JEoVcJ2305870
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 17:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o8x59fxfdz/jGIQYFQNs+4+juRLg1OwAMr5vtnTuLy4=; b=nx/2obPUu9tYKqHU
	+rbwAW2aeKNeBerwL67DGNZoRSyjrI+dmna7UByzpWob6bR79enVJrKrAKfOwYBo
	r1nh4mw+lF3N27XKjUdtWz0iXQAIV7kYLQBmYE1Xc2tyDxXn7uN1TKikK5kppePb
	FA24QR54L5STksjkaDAC84qK9awpp24kYFK7ssPHiE3n4p4eSTxFyzz1xMuYmPyl
	Pv1ZUOx+v6bnYSB+aljz4DnC/v6DEovQRlTLiqJehLlnljhCsnhJoMxwr+WR4KC1
	vddu+RJktX+a0nHeJdynb69o/HQZDGE2jwv1vQrrPGKgD2jJSfYH9BE/7rjel8/w
	Foo7cw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bspqv8drm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 17:08:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c52f07fbd0so327785285a.2
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 09:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768842490; x=1769447290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8x59fxfdz/jGIQYFQNs+4+juRLg1OwAMr5vtnTuLy4=;
        b=gGuG3T77WlyCz+T5Xm45MvA6yzXMJTZuma0ortE8ujZ1K9mzobEl1ncKzvovlo5yCy
         sRGh0So8NkJG6xFFEsSrgicMSeKfCnilAlrpd9bPBD/dIqbyq+30cVvpB5riiFXydPAa
         PNvkDnPsrxdqa/INQRr3JunJxjEAw0JE5qjjMaKsxPtZSh54IFR8bbSrKLKYuI2EKQ4w
         /SIIUo7vIFdDJ3gOvUxNyVQ9n8pYDu78o1Nlr67Hn4l3sFxAkNVwGA4yhg7xbmI8RVy+
         BYz9NUiufLfJhFmCp7WK4lGXF8X5zUgYSzRYANM45j6AWChdbKQPhGHR9v3LYrf9bFwq
         YAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768842490; x=1769447290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o8x59fxfdz/jGIQYFQNs+4+juRLg1OwAMr5vtnTuLy4=;
        b=eSq2c8PmmGttnLbmqKdY0brYl4W1mJOnaiz5SgrRdZh6KhebYYvZv+9p8FnNX5QO+S
         tNjsiZgkUTIsCHXGZQU5XiiILDNtiMpJL2MpOS/ZsRelAfry9zdSeVZv5P0tQL6DN6Hy
         4FbU9uj6ejij89DcX3mGY6c36rOvmxZhDJoIvG+HEWTq7kewUHER4Q1T5xxF4cDSf0US
         VFGIQgOgQGFK+mEZRp0yzLgO0w6ZrsiLQd4kUpRpeoeGrRD/B7WF2TnPa8rz1SpPq6v2
         lMhGnNyHPKpCNvSgZZzcwFtdEnljDSQjdiGH7TgofdxXMEwBW3MdOaK0OzerHRqlwUrF
         4jXg==
X-Forwarded-Encrypted: i=1; AJvYcCXoA1p1iZ2wcPTI6gvUKy9LBGA6gNlyJZI3q8RgOzcEqDEpxJMzXv+FNzmqjhu8aJMFBP3YF0dSpCJXmPVhmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyILFvbKd3zRd+Ybtx/qOlB4Emj+SBof6pWfqrCeXPVjXnJ8ZdE
	MeVXGgnpFvKvk/UwZJJ2b7r5XcEvszSRYP7ghW6euM6o6gr3SHZwdb91C3RDKE8Vz72O/ut4kCv
	mAmV3/+714Y3g8SQFS2st4VU9hbaM1WzcRrwdX3A+IflsCZxIpuA64fuEtdkDqdzVjHuYWw==
X-Gm-Gg: AY/fxX5f5JB5azJMH41Zngf0k9emWEv7TpkOPbsx59pLAtE1Sh2t/8QtuMHdeudOycb
	pVFG8kLK7p3lo3FKv04csJ9YcF73U8qLivW/HhDAmnpKWOoMfw+7fXcb5tZ2tZhb+mRORow6G+e
	k7/7aKNf999glUGrdaCI7IjgkZDsGxjYZMFcOyeyP+0cV6JQCB2kezj1FGN8PjXddTy/dwWBgax
	yIu0WbncvecvJH8FPxBmnjolr38picVD4CGpYV/vSmLS0HB+dH+eXrl9k/6wwa2/BG6VMcln9RI
	w0iOONucf959JuTuX99YiD4CAA/Ua9qzXxFLhv9hA0JU6BDO4JZ7GgihSE3dVj4I5j4shja+SdE
	UAjdz+2udwrGldUUMTEhuQiJVi4eMHI6vr170b7urck1gFlEPEwu2n7TU0xZJgz7UsZMcU0/u35
	oIJc/uuw68LLd4FQRCI1TCpsM=
X-Received: by 2002:a05:620a:1909:b0:8c3:6f20:2ed2 with SMTP id af79cd13be357-8c6a6963386mr1569141785a.84.1768842490311;
        Mon, 19 Jan 2026 09:08:10 -0800 (PST)
X-Received: by 2002:a05:620a:1909:b0:8c3:6f20:2ed2 with SMTP id af79cd13be357-8c6a6963386mr1569135785a.84.1768842489685;
        Mon, 19 Jan 2026 09:08:09 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384e790a9sm32661211fa.26.2026.01.19.09.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 09:08:07 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 19:07:58 +0200
Subject: [PATCH v3 4/8] arm64: dts: qcom: qrb2210-rb1: describe WiFi/BT
 properly
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-wcn3990-pwrctl-v3-4-948df19f5ec2@oss.qualcomm.com>
References: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
In-Reply-To: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
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
 bh=enCKpNdnBrXZA+wiHIdAIv2kSpfxxx9vISm1ccZ1t9M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpbmTtilwkBClWXXgiyKcWtWRAEl+wOgQ9AElnr
 wN2H+oTvD+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaW5k7QAKCRCLPIo+Aiko
 1clcB/0bYfdqHWhPo5vtWeP35++T2K3Q9BRc7oVbgJJPq7w6Q2p4XxDPRwsC1AeWVNb0qyN+eg/
 Q/8e7v89lH3+HAgOS/ujgI2BCddyoFflPbtxvmDrXIUCMcV8tPl/1L1DzpMIdE7mURoIC3hsWsZ
 zsQidYoW/JEicp0mAfr4yQI3vEDiQA7VluDs87xUDOJLmvVtFIDN8Ayzy8T+F9klHdxVnSDPk+X
 WFb5MeuUgA7qVR5CANAJu42J4Lg2WeMs8KPpY6BuWn5imcCd/T63SgntdkGu3qZ43/g7eEgwVw9
 wQ9/2gDn7ksi/y4EjkSYhxVCn/1dPRKtbklYlWzu0IKLGJf8
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Js78bc4C c=1 sm=1 tr=0 ts=696e64fb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=GWXae9BK5adipm9ZVUoA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: XDjIOscahsVJUFT08h4738_pUdYk2LUt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0MyBTYWx0ZWRfX2utyWxCMuH+q
 hhSzwP6W6YM+zET3EpmEhIbWXAGNoBqJbYIC4KTXr0UINOYczmSU0lh5u6JdZS5/0TrRyHdwvgn
 2Ge4jkCo11kfkJS+zEBedoO9y31u7O2utSGh4ZiP2OIwLWMwgAwR+Ix7wvDarWIewESgMK9c/6u
 Fr14D0giKKfmRJwJ/mw4csPdoAv7OXjrvxdM4+56mzE9IglqOrtKOTmZOZz8JieQzRpPKvVoa71
 +k4x1KckKtsVZlwjiXz7Fr1wAX3wqWEBnUJth7STJqlD41majW1GAHplK2DxBfjTynoE7I5RHdm
 tN0aQlZrhWy0McNniKlk/2ibKTNP3ji9en8d08pWwaFAvCQlTvzfG1+UxvwYw3Ziql3/Pw1IxnO
 lUwi+96Vc5FXrAqgRwDAcpyytoDoiUfyFqvTJYVm44IbraKBz6OLzaN2OF9PNprDczRZeqxv32u
 9SEnFtiVw4FppSm+mmg==
X-Proofpoint-GUID: XDjIOscahsVJUFT08h4738_pUdYk2LUt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190143

The onboard WiFi / BT device, WCN3950, has a simple on-chip PMU, which
further spreads generated voltage. Describe the PMU in the device tree.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 60 +++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index 9814ac4896c5..737794cb8b1c 100644
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
@@ -754,6 +790,12 @@ lt9611_irq_pin: lt9611-irq-state {
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
@@ -789,11 +831,10 @@ &uart3 {
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
@@ -834,10 +875,13 @@ &venus {
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



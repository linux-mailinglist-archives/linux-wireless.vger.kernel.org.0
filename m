Return-Path: <linux-wireless+bounces-30196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 509A0CEAE98
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 00:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F25B130281AE
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 23:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C712E2E2F14;
	Tue, 30 Dec 2025 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZhUesqf1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FmUsyB+/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EEA3093D8
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137789; cv=none; b=HAKHiFYyMHLE3/hfgaN7fZEtZrCTl0gOB+XiAQwbNnDgtho1cXspei/0Y0JdeHF3an06ZfauYagPoiQzsZAj8tXG6PQIz4yepIduw2ubB24XAor2OE8yurWwBqr7ZzyqEqVAIaMHykHmkJSqATB0ZWXtjGMCKSVsySwwca4sbbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137789; c=relaxed/simple;
	bh=Xfiwra//zLSvKDun2ZbDRx+n9EwUzSsdsyZ+5gdIsp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aAbLp6oPzpUKrwH9t+K2/2XswqQbAJApyFgkP1J1X6Bow/6Kuo7ley630/8gziLHt6uT9d1HzdSUIzU8KjIHQI/dzbxD2TxqBpywQkzvqyo4iZ2VpqVnltKUsg9wUlKY1+lBoG5AP/5mvWPNaRvxdBPtlLdMj0Z0G21szu/A6qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZhUesqf1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FmUsyB+/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUB8mQa3971206
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yBwFc8aLDeICAZ3JQZO6nb8xlo5wDk574BoMUdPd5qo=; b=ZhUesqf18kpP6RJX
	FKWWrYwjgZYsqsoYdnLQwUFgjDnjQIN7uMyAEoS0bVugV8KrAlpGoz5pGP19m351
	UEesBZvChNm+2qvoASvon+BEtahJPPfGN3m2S80u4W6d+f4ix+F+yz8V9hV7Holh
	3pvVw8XASEifxXEsCq3Vkjbv0UT09pFuIDM/aDF1jzRfYlB4bi/uH5wW51Olk2mx
	MGp/Bph5N1nF1ikWJexqsVfcQLFT4aIARJicf9UWWtU90i1Z9PnZ1851h6/J3BTw
	YkS5QKYyHtVWxFBVVRg7lYvSeu7qTKDhbNrZoXY3NzneMiNNr0c/nVoQhAFUVz3x
	NVdEDg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcdky1dgb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b17194d321so1206905485a.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 15:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137781; x=1767742581; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBwFc8aLDeICAZ3JQZO6nb8xlo5wDk574BoMUdPd5qo=;
        b=FmUsyB+/NY78L3UlaTOGBti0LyncPBrHMM9o64yIvG2WyPGTdhBjkumhFfnbFniqLJ
         wCNFGFsxiAZ5uCBHUsiPKxmMRfWyy0GP2ePbW6ADkDvD/Br2UtvOFwp7uUwkpZrylvx/
         foI5mlY4uLGV/ls47udrvYxE/wlnejSlymk+P58w94+jYlojkddLtf6IqhNGsamRecXD
         QcsQATnzfAtBv+wwVSxasmib6jetTZgTl5PAExRS/JCRrwym12OQVLldobzMEwFx6i1n
         f1cncbA7pBuswQpO/l2OS33JMoir4LCGJeLeu3Kw3wUat4cM3D8aLoXJAJGLtAazD8Zi
         Ry2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137781; x=1767742581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yBwFc8aLDeICAZ3JQZO6nb8xlo5wDk574BoMUdPd5qo=;
        b=G7vTnz5blrZ15OF/xLrlxqFC8y0a0vOKyOPPrGmCa0656Eaf2amKw7FyQtTHtPOvaF
         H3DY4QXyzVTKNOVWo1UR670a4RzJ8pKMSJLypustb4VbjF1oTQ4y+BMaf1NC9LaGm7kt
         KZ2sW5lmmTdOgpgb/8Bb2Vmp5Zzpe7ewupKMlQM6DjgLZ1ogLnFk4UvXG6C8QD2ClUux
         y28CTeX5yYR7UrU+zbAMA2AcPFVf8O23c8khOV0Lnr13XEY6xYjM83LLRNVdtM0Af26v
         RqJDayqocFOw8Yx1uNJasS9SIntuCOGS8TLWu68DCmfFOrz3ZEVQipDyShQ2Gh+kW+tV
         Uhrw==
X-Forwarded-Encrypted: i=1; AJvYcCVOYwarbQQqFq/Nzoy52jEP7a6fTJCTyWuU8/g+l1FmcuOVowHrYEBpkaGxwGpoRqODHz9Da3awqxHBclqoTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyF6U4+LAwsrZIPW3jnqzdJFEIZeAwPUGBdQ7U6ABXeF1avi0Kr
	eapHl9bqn86pvEWB/bKg5DoS8Ad4VXRkgGo22tqiWuijxkLngn4ifAOfGZ3WOy8tXse3VhH9dzL
	MTbvTMG9h/cCHA3vDh2pCrY3oZUiazb8bj/h34Gj5lVC85uLP+MIBrV8LwyGe9TZBOFDyjg==
X-Gm-Gg: AY/fxX7THdFZGhpsCP00NVLl7/eo4KT+9V0p5kKSEbVOz/agyYQJblmut46x5/61kWh
	A21B93sZGYwkIZcWcGdBpATeOCYkuGdsRpnZdP3r88cE7qDUcBfRJrsm+lMFVKUGkSXuvRT+2Br
	7B3OowGYQ43luWxA5U0pMbKnT7qvCOc1UNNwddGksjqZAFI3ky8yimlUYp2n/Pokry0/Ew8nubP
	ZFGfPNK4M3a4/9FjyQM4riPN+Tidk/oNtIjzVurkQbT5fv5qa2ltZShxfP7rfDGNtQ6nZjqD7Rl
	HhB9Dfm3qoZ7YUPtXkc3LA4nV3BwlWRKEAgblbhiFgyNeyv9bfK3Z3uy63DbrleeOF1EVYZSkDr
	MSuwuPLmqgdjvVdn2G8MpbqRt837m1KxwIZ7JbpYece2/xGW9sfnSEwr8WY/DklCVGIJCuYuGpi
	FgQeNN5LRXz8n8HjHdrFeeH7s=
X-Received: by 2002:a05:622a:1b92:b0:4ee:2423:d532 with SMTP id d75a77b69052e-4f4abce0824mr471951731cf.28.1767137781178;
        Tue, 30 Dec 2025 15:36:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFx/SYKuZWVg57DqMXeIylTkSzC4dXks9ZscJcuTRysFCAH78JLjOMFVgFClApXqQcqLSoAjQ==
X-Received: by 2002:a05:622a:1b92:b0:4ee:2423:d532 with SMTP id d75a77b69052e-4f4abce0824mr471951381cf.28.1767137780699;
        Tue, 30 Dec 2025 15:36:20 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:19 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 01:36:01 +0200
Subject: [PATCH 11/14] arm64: dts: qcom: qrb4210-rb2: describe WiFi/BT
 properly
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-wcn3990-pwrctl-v1-11-1ff4d6028ad5@oss.qualcomm.com>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
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
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2688;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Xfiwra//zLSvKDun2ZbDRx+n9EwUzSsdsyZ+5gdIsp4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpVGHlGtsBv/9u+UkjlXRjLdVpGDSUR9SL9e9SH
 TaganuTQ7+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVRh5QAKCRCLPIo+Aiko
 1XQWB/0XGu4TFjAPBxjm8May0y5wOWD4HhP5IIrTPX8z3aPGnm6dR+Hk2JqDPX/llzbukU2zTMV
 ho3//Ab4h+brBn78kjakUfsTrbAuxWSVZd1YJSlEBIkuGim6mtlWo9nXGQk4QHw/f+fr2PWX3zH
 xj3kPBL25JL/xT1Y0+ZjBkbdJ7bBP5ggnhL2ZkbdZK0hnakyAQ6N/8/6K5EkTyw0zNd43EsUCHT
 sI4aFpAvNaHo/fKFq4yGdkusN/Tw16gpvqyMQf7FksQFDemRgh45OfSCdjzgRG9bebGDHfNxnjn
 9z1v2JIY48eB1zv2IJm+3bzIdmAeC/D29seb3xbnPcfxLHMm
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfX6qwOXcQ2HVyt
 swJBYaZTw0lZvv/EK4uyGSOove0GRI2CnyYvwGcEJbgiGM6SBFyf7XkZjXHtQcOt9lWokemAT5z
 jCmlyeuK/aS2UgCFmhsGyrzdbG72VfO2ztOBa0/U8ec4dX2yT7pEXm30bHCbRU60CuyGyDQ1BuH
 kN5qJcVM/mV7l1OtOPt3mvFnvZAE+SE0/mJ2tv9783rRuAfaThj9g2TddOFj80oEUXzm2W/CiRO
 R4ngT1s7Jk0vw1lyE/z8laIEOc2KQ+YgI77AAE2M/a3MhwaK+OAr1cRsSReMMVBTCZ6z1Yk7DWs
 NsLjveN8noJMLhGWhhdTglcc5GcyH/Xrme9ef48vbHxIburs7cHHWrJ3m7bBVYeZIB8nZyoFwd8
 lwj68VqzcCabYf6St+br9/fNPmFFEBT5Xc22okXhuUscg/m61Gp48Nqf93zo58dhPfH9ts+OZGp
 /DO8PDQZIniir7SP3aA==
X-Authority-Analysis: v=2.4 cv=Wskm8Nfv c=1 sm=1 tr=0 ts=695461f6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=xd9rXx9432pcEdfSjoQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 0k3DkAdWxW9ho2T_1s1ayDOrA9-ZPJm3
X-Proofpoint-ORIG-GUID: 0k3DkAdWxW9ho2T_1s1ayDOrA9-ZPJm3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512300211

The onboard WiFi / BT device, WCN3988, has a simple on-chip PMU, which
further spreads generated voltage. Describe the PMU in the device tree.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 60 +++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 5f8613150bdd..4e1b189dc9d7 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -237,6 +237,42 @@ vph_pwr: regulator-vph-pwr {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	wcn3988-pmu {
+		compatible = "qcom,wcn3988-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		vddio-supply = <&vreg_l9a_1p8>;
+		vddxo-supply = <&vreg_l16a_1p3>;
+		vddrfa1p3-supply = <&vreg_l17a_1p3>;
+		vddch0-supply = <&vreg_l23a_3p3>;
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
 
 &gpi_dma0 {
@@ -684,6 +720,12 @@ lt9611_irq_pin: lt9611-irq-state {
 		bias-disable;
 	};
 
+	sw_ctrl_default: sw-ctrl-default-state {
+		pins = "gpio87";
+		function = "gpio";
+		bias-pull-down;
+	};
+
 	sdc2_card_det_n: sd-card-det-n-state {
 		pins = "gpio88";
 		function = "gpio";
@@ -703,11 +745,10 @@ &uart3 {
 	bluetooth {
 		compatible = "qcom,wcn3988-bt";
 
-		vddio-supply = <&vreg_l9a_1p8>;
-		vddxo-supply = <&vreg_l16a_1p3>;
-		vddrf-supply = <&vreg_l17a_1p3>;
-		vddch0-supply = <&vreg_l23a_3p3>;
-		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
+		vddio-supply = <&vreg_pmu_io>;
+		vddxo-supply = <&vreg_pmu_xo>;
+		vddrf-supply = <&vreg_pmu_rf>;
+		vddch0-supply = <&vreg_pmu_ch0>;
 		max-speed = <3200000>;
 	};
 };
@@ -744,10 +785,13 @@ &usb_qmpphy_out {
 };
 
 &wifi {
+	/* SoC */
 	vdd-0.8-cx-mx-supply = <&vreg_l8a_0p664>;
-	vdd-1.8-xo-supply = <&vreg_l16a_1p3>;
-	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
-	vdd-3.3-ch0-supply = <&vreg_l23a_3p3>;
+
+	/* WiFi / BT PMU */
+	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
+	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
+	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
 	qcom,calibration-variant = "Thundercomm_RB2";
 	firmware-name = "qrb4210";
 

-- 
2.47.3



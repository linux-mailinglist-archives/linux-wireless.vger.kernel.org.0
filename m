Return-Path: <linux-wireless+bounces-30375-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1363ACF636B
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 02:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D528304D340
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 01:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC1F32277B;
	Tue,  6 Jan 2026 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SW/P6xSJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jyy9UDJn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB33131B825
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661307; cv=none; b=HgVkxQZZy8X0l8K4QWynsN7Mt10Um8JDLPdSfQVFy38AS7ofBKzk7MzO63M/a0auYllboRi15uSeODw/ajMWyswY3asHJViCfGThYFvGb2DHxoL259KYXtsM8XfCnUM8ELoBBVkBjgci7vI4UC9h2xnTDKJP7S8Zbh99T61GMWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661307; c=relaxed/simple;
	bh=JW2e3YORx1IvzyXTcxL1ItlNpE70OGRvUy5PXPZhVzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rcce5dkQEGW03mL+NZnh0J/vnEESomLZuG8pLCLwIjk5QX9pU3/4+2+uC4cDBQs6G7/CSUkNcvx5iBHsaZHqZ4rMk1cEmvNT/TCM4c37YmAiQc7t9NXDuukJSfuBlgJH/QfZT8XiH0ckTeFsUuKL5KKeLIVTYuuKid6RWRKSKNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SW/P6xSJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jyy9UDJn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nJ2c2943603
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 01:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VmEQ3DAdF2+6Wtmoo2Iw3yD7uj2xcoU63T9J/0jkrG4=; b=SW/P6xSJUlMO/1NO
	ZraLhfiNhv4Yx6uqte310eETYjc5RwwEwXrmyl/+/JbwdG8K4VDnTsrkDJ+Ns4Ap
	msBVtI33aOP2jVgapEWGBxM1sKh7ipsuKUwwhKp5B0q+4Tw/TAs+vkavge4kNibM
	GEgidc9Sr1A38p4y/P4IDbNdqcTvlP0G2Gvqb08JwyUHMalXPAP6h1L3YulOMUoJ
	mpLz6ltavU6QR/dQhi8ZRignujAFdEt9wu/GzpZvmv9d2lVjxHZsVok54pREtKJF
	Td6wuAfcOC5WfL1lAV6LwJ8ucF6/XGFTurEk7a/IIwOqmuiOpILTiu+uDsfagosS
	Ia6WhQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgfv01ey7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 01:01:44 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9412e67d171so9283090241.1
        for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 17:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661304; x=1768266104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmEQ3DAdF2+6Wtmoo2Iw3yD7uj2xcoU63T9J/0jkrG4=;
        b=Jyy9UDJn2zur+Vwe2sqbFlzs7BbEBNWJrjYM8waI7YQ1nqdVAbeB+bgM9zwMsDE1e0
         uSRq7pKYVEMl8nQSqWbJc4DBzffnroEgTXrkTp1bQ4IZjZI3ua6eSqCAKt18Daqs++6x
         es/u+STjYQxePvrdwDZ4UzKK+mvuUQ4tp/1btTCfxlp4lzaXw7AE1zck/N5eiqDzDHaI
         CeBWfJxxq9Azg8V4IlCi3RF6+J+XNvqUjBfcjVbuWgYWglTtUjYs+tqU7FLd3JYcAv9e
         Y4qxEs6C8k3dNhlStBupZr3eBs4K9MR0y9CuiBfFQdw/CoTjXAN0sJVzrnxxuuGxyJvQ
         2Q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661304; x=1768266104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VmEQ3DAdF2+6Wtmoo2Iw3yD7uj2xcoU63T9J/0jkrG4=;
        b=Zqqbpm3ncOb7q5CuLpTPDu/7+xKQsENWGGD65k4eV/7fh7k/zli/TmgV6FK2lUXtWV
         4K7kTMQa5HXueAei6s+wOhgu423jzlW3wGCKUmBdWrrcweF7hqZYPZSKpZ0njQzj47Hh
         4i5YDbSjEtHm3n+J1jyIYWqFmHL0ZTcl5anN4dfVxdpHjSj3vlUC37/8Gw3tNOZsRtua
         4ZM0siVZdnAJzVAXmVkQNNL8JRIvx0xynPiXqxzQCF3L7/ZYkEYbOP3N28zg8+GqqwJ2
         WbAlyzxkTKRKvulZKbCVDUzIuPuufIBHUJhldZQlt+E/hAmwAFK8Qdq//934x7vPqNRB
         B0Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXzj7h062THLooMuRWUvCP3Ys8e0fHrk+LcsRQypvMr297bHWSPXYB4FBf1Kzr5vNb47zwo4PRdvAOXroe59Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yycky1aPNbV9gbuRvyVxvCqk9eKJeZuGvOeKCSoWP/FJdh3KUPk
	/5gzWV3DHmRkhfMbb+mFjtxdAs3NvVjZDIxyaQDFfto8FJwCPlKWp6UE1FMTRTL++ydlENUEQ+L
	hDRBsMTHyf/t2W2bGtOjUwv1EQqNa+eIvpPprpVtlSBXnv1LxJys9OtIdiTI3NgFGh0dWeQ==
X-Gm-Gg: AY/fxX5d4YvyWocy0N15ZhsBMokgkNYB/PntWEPrmcBCxSf0NRK8UVgfX1/g/qP5kI9
	WyXnN4Tm7jpOFYpDmExk+T56mfn7ThtfSZT+7g2rf9AuBw+tu9pFyfRCRrnW6WByLjrD3MTBZtk
	p9+JtDLxtZHdZWRlheBg8pcMjSaQdPdmQ8Y+lCq1HGBx4bBecb+o2NSZA0GKtTinyPUBqSs14oR
	bSKyMllJe/uRk3QQKUVQgTCpkPcOFc3e/HwawC4I/T+ktw3MdeFpBtvgZFHfrFwCHBrraSeXJCu
	AOZqK4c4AlnVkfckV+NLRMoF0aStOzsIZ/N+ofD9i+ylBGUbmm+d6Q8zjj0KL9Hv/QtmzW4gpZg
	NEVY1rvKfNo9ebgeHDSZT0YWBMiCqDeOaOMhzw2mw9dzqhror+UkJOqHCbSGv9a7HPIjxVtzaml
	eGKq/Hq4yhyej5mpbTV7AF4Jk=
X-Received: by 2002:a05:6102:4a88:b0:5db:e32d:a3ff with SMTP id ada2fe7eead31-5ec75766a1bmr430111137.19.1767661303920;
        Mon, 05 Jan 2026 17:01:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfv4LR1s42S8DaPU2KbOxpQJdk3q7QsoDukGpuciqtoi4cKuPME3x1EvsMr6Q/jfWAk66FHQ==
X-Received: by 2002:a05:6102:4a88:b0:5db:e32d:a3ff with SMTP id ada2fe7eead31-5ec75766a1bmr430082137.19.1767661303481;
        Mon, 05 Jan 2026 17:01:43 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:41 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:21 +0200
Subject: [PATCH v2 11/14] arm64: dts: qcom: qrb4210-rb2: describe WiFi/BT
 properly
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-11-0386204328be@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2818;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=JW2e3YORx1IvzyXTcxL1ItlNpE70OGRvUy5PXPZhVzQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7aKvZwOZUhotbdnZ0pAuTyDcOntsWVWsF/p
 InOqexTSXWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2gAKCRCLPIo+Aiko
 1exdCACJMbsoAcCbACN2UqM2AdeEb9CSwAiQD0TbYdLHwQJSWOPJ1UR+RMPcIvsZsOrUFE+bVgq
 I/YMEZUtFCXMwh5g94/WO1C2MOUz0117I7aEYMVltV0WInGaJk2sZZXtQ2fE/cwrf9xHzN90Ecw
 T9zuxT+MsdY5sUrt9fs4NfQU1+e2TR9TXQ6/Kp/Khta6hWAO6DV3bt+ivvaWt8dvIvr69Boe37h
 C9oOupEUCP+oAB+hqOCa8wnWPXdQiEkXQoQrjfBGDQwvA69CRGczeHeN6lQIEt1F9OY8OmuyLwL
 pm7KYr3Uw3zF/N4XpVIkGbw+Wze7EDpv/MKgyIVfxlmHD9qI
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=e9YLiKp/ c=1 sm=1 tr=0 ts=695c5ef8 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ib3hs3rZ3KeRbPluJGkA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: JvRBJXg_4-tRJv15w8p2aPiLZi5F5lcn
X-Proofpoint-ORIG-GUID: JvRBJXg_4-tRJv15w8p2aPiLZi5F5lcn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfX4SKfPnjnWXOY
 8KYeZHyFr3em2a2RG3mwnIgf5kWnXnKpd05IkOljcGY5cMuTaGkwgK5a0auUUL6FMpL0wc+P10k
 VhrR8//urk+E+YxTReHxi9IazkpjTdG0rlyUhjvzlnGnKh7PpuKOChXokFTIKjRHmRVL2+hZQDP
 nsDRa0wjBNoG4G0xiwIqVDdeFoZ8SkcprUgd/BzJjWcplI1Uq2mXtzqAcZiMozsw6I1nohAhd7e
 3J9ofGtax8JH4jbaPr8S61WSTJhwQ1oeMzfsBYfQIq73ya4wdDY1A/uxlJjIxTGvEyZXaZInoFK
 vLd1xPx2LGlWPh69cicx1qUf9Ii+dOugJBxgqH3MhY26vFHVXQqNz/Cgk3DIVGzYh13Tl0tr3jI
 LcK1Z28FJvoHQZ1v4leH5JoqJF+aym7YXNM18/Os1yl+jVq1uGqE87nyRrqL9KpccbSvYYrwNJw
 c+B5mc0C7fNMUNIzOUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060007

The onboard WiFi / BT device, WCN3988, has a simple on-chip PMU, which
further spreads generated voltage. Describe the PMU in the device tree.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 60 +++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 5f8613150bdd..5ddf448bed8a 100644
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
+		vddrf-supply = <&vreg_l17a_1p3>;
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



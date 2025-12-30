Return-Path: <linux-wireless+bounces-30198-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 779FCCEAEC4
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 00:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD5C530517FF
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 23:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB2432ED2C;
	Tue, 30 Dec 2025 23:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N+ZrkBbE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AEHujBj9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2DE2E5B19
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137791; cv=none; b=FIfjp7RvgWUiqe/W3gwfXPPrI6bqzc0whs2LIeNhDy+QpENre6l6YcDpZbhEuaLe8HVuTqDV7CQATfW01C12q5pAfLb/pY6r3fRq9kAj7xdVr0r+c2gDE3T4F25Bd9/j1ZsbSaJR5neSCOGQSV77GRBV5TqZA0ZmxcnItUTrAMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137791; c=relaxed/simple;
	bh=/qWwJPKoLPnWdm1jyHlJq/kGeX4sTHfpI9Ptnv3sGkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jt1d576EXptYs+2tJ8tdjsqL9B99Pm2Z5Y/QTn4h6HL1/DjKXIY2K59huyWD9ax4gzUDe2SiUQ+yhHQAdrS6yQZNGLw+hd9WRW5QzbdNnoSyGaO/rBRkbVqwkWnEPFTVgauyd8fVAtL0RLlnSsQWWkCU0e/PHufhP+HkcQ8zViY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N+ZrkBbE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AEHujBj9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUCtXmk714850
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fAoSs1oY3j3/8c8jdjx6reTH0mrCMA4jyvduoT96uz8=; b=N+ZrkBbEP+N+sIq3
	WGZOMdQwbh7LAwEZbSKmbkplz3RIKgws0FYwb6W3bAI2+yato/I2yLzxB4V97pfM
	A3UhYZtlUW8Hz3iFJvFlf1SnEc96fuTx7EooWbkNDrdffjof0RcIHjOBtAJ/MhjD
	bhG5S+FaIJOiIf7+4fIyxkFbJIF7SW3UYOpGoZckvgJhbljGEw2r40M/3Oyw9Ot6
	hYPb8NHeBenQpJK59vFyAEo7V1aHA5ltSw323jIm6iXaYisRf9BvIVSDcjC0p8HX
	iYfEoUjBka9+AxQJZrBGHomGeAiKL+DhKbimOZK8oqWs1e3ux4SgmygGlSW0jTUV
	ZW0G+g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcf5ys6fq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:22 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed782d4c7dso184055501cf.2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 15:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137782; x=1767742582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fAoSs1oY3j3/8c8jdjx6reTH0mrCMA4jyvduoT96uz8=;
        b=AEHujBj9lfMaLIxOw8NTnlEsNSgGBGYPS6N6uK741lRR8b+eZRdS3gGfaWl+BiEEqz
         PGYFYCua090nV381gDunp2550zlqKsbUSskxW31/YwgugsV9oA43umszkDtQvli03VTs
         b+gpM3RnzJ3HWTog/LZn+4/Ab9G68nnKy/pvjgmHhGbp1ecfH4Iwqf/ap9iG8YwUg9vR
         6XDjO24oD3Zf8egyFDzGV/Cl/KnoKTgrQN+1nzbXwm7dKzJV2cDPxYfJYa4Vo9YNoNgU
         UctZrmwtxvJlanALPmydGOMcnTgH5CR+L2ixeTpNEoXc4HkDGRIJW6bm7kb8ixpGb4TD
         WRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137782; x=1767742582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fAoSs1oY3j3/8c8jdjx6reTH0mrCMA4jyvduoT96uz8=;
        b=f71FPk2dERqdiELU4AwvkjOEHsGNWbawcQXn+yNgsmvYadQYHx1997dTJbixjpC5eU
         4t2HBuQYaG5/0BhJeQk+xRkVa9giAFGcU7Zqz9doxMTmrRoejQ+huWwa3ZXcQgNvUiR0
         zfDpO3WfPwhIvrtr11+jvFXSjy1fNd5Oi6DVS1cBQM/mEVljVOaN7BuXIh7TmA53qVcg
         bgr5/6JQdh811jwEkHOdXpvpODBN/HBTIf/N8q8zw5k605y7ZCs1Gxe12uXcxo2D+5UP
         3dAf6Ksftu6lHL+6sTSukmiXi823Xt6anXTq0sKzu5Yj5R9A5zpfVtpmI+39DkkDyFwW
         dXkg==
X-Forwarded-Encrypted: i=1; AJvYcCUNxcvsKWPr3+AVeDEEg0sj6FlJAW7Ync3SElc2ERwDvbIv80KDKhcdsJWmRovJdsv4Itx8jJQnnvB5OV1Zvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMGqwEuDDFShdIU8GPOoaG799Bafn/dXjTOBeLu1nQStq6VD3t
	eUjItb++AtnICDXFZ6cYq4nKtQviUkPPTc7aOWc2vLDcleozGudXLJ8wfaIODk60BuufbXsDxT/
	aRCwwoXTU1i1jhmuGIkSavg8S0qaU8clxNoA3MoeHjwguAGH45m494vqny9EsDx3odUaTdA==
X-Gm-Gg: AY/fxX5gpYzcPaYcKAnmSXibCUzGjAhjTUngLiUaTDJhJvldG1lm3rcyL+1BDqcXUzB
	5ReuuuknF+PyUjtsEk0osiORwuSUoDLo/iqn2UzWGw9lFl9yNvXVcJmzR44/P1mMWXLpT14Fwfe
	Ir+Qo3ATqcImjiaAzePtpwV8+r3Y7QFNnuoMxk6w65mqX2/+9sFwCMKqNp+nXkO0E1/+cKilZXF
	2iZHV4ltGP2GqIgYsC2rL/W3k5Uv/bm9Vi3drtpZsPy5/xPdEz/6CIXHqmAMOmilLFJgeMCtB1G
	cIo3WyWzXExTHFU2gwUljAc4qEjGtjh958rYnbB7fClNNrgckzm/f74pszDgyVz2Uw6yPesyQPM
	dm33FefteEDncTpTy3A32zio1GzLz+SusEHD4XFqgmlhh3vYZkjLSbrpQcNWFv/SGCSDYwgn44U
	QTDzMqQWFglyjkoPUjeipnlx8=
X-Received: by 2002:a05:622a:1144:b0:4ee:49c9:a923 with SMTP id d75a77b69052e-4f4abdb66b6mr477095901cf.56.1767137782330;
        Tue, 30 Dec 2025 15:36:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkPqMdqJk/XCzk1e8ZyvUBpUaurMVX1soNXULfyOp66jtSt+yb9md0PSgAOZm8YQ0qjDZn3g==
X-Received: by 2002:a05:622a:1144:b0:4ee:49c9:a923 with SMTP id d75a77b69052e-4f4abdb66b6mr477095691cf.56.1767137781889;
        Tue, 30 Dec 2025 15:36:21 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:21 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 01:36:02 +0200
Subject: [PATCH 12/14] arm64: dts: qcom: sda660-ifc6560: describe WiFi/BT
 properly
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-wcn3990-pwrctl-v1-12-1ff4d6028ad5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2776;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/qWwJPKoLPnWdm1jyHlJq/kGeX4sTHfpI9Ptnv3sGkQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpVGHlCjUGMHlkqkJafwLhwLJykGktOCOjkpAY9
 wWwhzlyFAqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVRh5QAKCRCLPIo+Aiko
 1ZqOB/9GU2/Bf/2GNGunBAoAKZe+gB1ID8NoQrA09/9ZRauuaoMy+dCCtYIDBM3vRl2CFb28OcA
 pgDJEoOPyMzCEfV1gSMyuD7P7rD/eHJ2v5lclrEGHrFBeR0ki/EalU6nNTUWWN5ygcKYM//UJXd
 v8QqOiqJ8Ztktem3BId5LhT4sVp6BsXNVwpJmGyqjjRbqL23k5ccCrYi27el/uzDpcWDkUscilk
 vt2LS8i70uf65bXCvZdd8rCTUojWi/nIwwpAxYRYUcDUb6bRbNO5co2pu3jppvt0AQtvI3mzjsR
 bNWBuTR3ETPU/KTXh3R5hBqGJsBQnFzb/Jz3Mspfy7Z6S74E
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfX8ZL7k9FP2EPX
 OeDOavpSBJOxsK1ZAxHuwLnz5s7vwcs5Gd1UDH7oqnLtWnjxBCR4tXmjGUtXuR/lgHMlRTxOpE2
 R78r8hq726spjxDeQI7RMsnrbSZQEypq83ECphgir8N39h+8tCPXKokwzupvd2GbfAdiQpi8Pau
 ITPu41ux9416vbjwHLL3nlbL8WWSAUEFc8ni+4oQwQsmE5qiyFD3JWi7mH8KYQTFPELLwG4Xobo
 fLtY9e+IVG6klVpBXK7FjW6We+eN9foAPbCo+jXej4xASvGCAO/jB+D1Z/SKxYE0ZY8cL2nTAJa
 ZNgsJTcZlZC0Zj1C40b1/0mm5aludOpbz20v1HmRnmvGEsVE/Nwb/EM8BaBShO/ZrZPw634+T3y
 isf1PFWaKKrHxeo5H4+5NynipZvcA+IQKqV0BbnkjAPhB+0B8rH20Vz9AD8Ng6UUi0UPcXqh4ai
 c7GAR1ZkFRCfFhtt6Ow==
X-Proofpoint-ORIG-GUID: NWtmH65Sc9-ZLLzh69FQxDxlVTvGCwhM
X-Authority-Analysis: v=2.4 cv=KvNAGGWN c=1 sm=1 tr=0 ts=695461f6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=AhE6NyMZFPWiW_N_LacA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: NWtmH65Sc9-ZLLzh69FQxDxlVTvGCwhM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300211

The onboard WiFi / BT device, WCN3990, has a simple on-chip PMU, which
further spreads generated voltage. Describe the PMU in the device tree.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts | 66 +++++++++++++++++++---
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
index 74cb29cb7f1a..b4ea79cbcb3f 100644
--- a/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
+++ b/arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts
@@ -108,6 +108,43 @@ vreg_l10a_1p8: vreg-l10a-regulator {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	wcn3990-pmu {
+		compatible = "qcom,wcn3990-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		vddio-supply = <&vreg_l13a_1p8>;
+		vddxo-supply = <&vreg_l9a_1p8>;
+		vddrfa1p3-supply = <&vreg_l6a_1p3>;
+		vddch0-supply = <&vreg_l19a_3p3>;
+		vddch1-supply = <&vreg_l8b_3p3>;
+
+		swctrl-gpios = <&pm660_gpios 5 GPIO_ACTIVE_HIGH>;
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
 
 &adreno_gpu {
@@ -197,10 +234,10 @@ &blsp2_uart1 {
 	bluetooth {
 		compatible = "qcom,wcn3990-bt";
 
-		vddio-supply = <&vreg_l13a_1p8>;
-		vddxo-supply = <&vreg_l9a_1p8>;
-		vddrf-supply = <&vreg_l6a_1p3>;
-		vddch0-supply = <&vreg_l19a_3p3>;
+		vddio-supply = <&vreg_pmu_io>;
+		vddxo-supply = <&vreg_pmu_xo>;
+		vddrf-supply = <&vreg_pmu_rf>;
+		vddch0-supply = <&vreg_pmu_ch0>;
 		max-speed = <3200000>;
 	};
 };
@@ -238,6 +275,16 @@ &pon_resin {
 	linux,code = <KEY_VOLUMEUP>;
 };
 
+&pm660_gpios {
+	sw_ctrl_default: sw-ctrl-default-state {
+		pins = "gpio5";
+		function = "normal";
+
+		input-enable;
+		bias-pull-down;
+	};
+};
+
 &qusb2phy0 {
 	status = "okay";
 
@@ -503,11 +550,14 @@ &usb3_qmpphy {
 };
 
 &wifi {
+	/* SoC */
 	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
-	vdd-1.8-xo-supply = <&vreg_l9a_1p8>;
-	vdd-1.3-rfa-supply = <&vreg_l6a_1p3>;
-	vdd-3.3-ch0-supply = <&vreg_l19a_3p3>;
-	vdd-3.3-ch1-supply = <&vreg_l8b_3p3>;
+
+	/* WiFi / BT PMU */
+	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
+	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
+	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
+	vdd-3.3-ch1-supply = <&vreg_pmu_ch1>;
 
 	qcom,calibration-variant = "Inforce_IFC6560";
 

-- 
2.47.3



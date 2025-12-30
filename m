Return-Path: <linux-wireless+bounces-30197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A55F6CEAEBB
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 00:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0E6B30D8CBE
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 23:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7722832E12B;
	Tue, 30 Dec 2025 23:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RmCuZ46W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VeHNPjcI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7198B2E1C7C
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137791; cv=none; b=T65X9L+L6MOv7ZGclSppIgHrNWui5SsH2Ejq62znL3F5IegVZev6P1uLh2MzwOZBC07ntkyIuzkAbUIbF0TU0i5m61hpPC3PIBaV1pSjbnnJkUNKQJKogJBEnSm/LG5yjaiuPcH4vjODnt6SozilUGpb8Rs232TNqKCvRjRNCeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137791; c=relaxed/simple;
	bh=7LzbTKdhUl2NUOZfkS1Y8NaFZqr1Qnf7aC6QYgqUTZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oxmtm1WdJ4GZD0qA34pHXHdthV9tL9/hk+Kz0gM6x2QWQx3r1r8XbqJfG42FYPnmaXc6BEQamBHP+yWDT77jlHjLOPdeAIrZRRwYNC3OEoC15mYMmNKSawYQ/BGlzW9pjk4wyOLyNCQ1luBEA2Z6M6XMaVT8J/qJ7fgmWfpxZDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RmCuZ46W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VeHNPjcI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUMAxq0675745
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xXbs7DTtJpHSfn5vW2Prly0waEmm7i+yQR+ng+cWcuQ=; b=RmCuZ46Wtvxb5Jas
	PG33QwpSsYmvl5FrTf4mNQmjVYcy0c9+0qPP4IuXcmmjsW/4nfFH6RZqAsw++x5C
	2pr9CPiJ6Ai77QJypILRE3ntRQVix7DAhfBr8S9geeKyMSBs7U533tYejFRelcfw
	0Z3mqXrVuofLASkDlrmKbt7TTky2Gon/SBw6qQMf4VXRWE8rcHv3kHmUf3MOMElG
	7rfNpM1TN92Pfz7kG/9X+xrXgjD5/xIEEsBqqEFLex74f9nKGYOdcTBd1VvWnGod
	zE2q9XH2/fpX8i6hdOfXezo5SvLJ9Y+SaUuFMDlU6w4txZ+GVbdHJo9S0Qvsni+z
	sWqubg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc0sgu2da-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee16731ceaso201807301cf.2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 15:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137783; x=1767742583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXbs7DTtJpHSfn5vW2Prly0waEmm7i+yQR+ng+cWcuQ=;
        b=VeHNPjcIo/AjpEBqPgCljQhhUjtZ4QqqkTZcrBc4leVtJEExibUmUSBmSf9bnZzltR
         fj7zsGH20EMugfx89zTt656Z1JiTO4JEOcWaUtzAbSi6NMzfyX5lPP1LIfbhxA4LN/Tk
         /BZo3zDX7ZeYomUl8APpKBP6554c9ymznb8TCQUN075urY+882wppmUTYUMtNeHKpu9D
         /h1Y/20t/dzR33qbFUI5iBYJhu41qqiL25d5GCgY9PZ8gzNDuwCR2MgIDj7L3JXHxVQk
         mHbTziWRxnzme3FJePWvv3fDIb1b+c6N51kAm7Gu0Ew0swx///VXYPw95oaaH/+qX3uu
         R9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137783; x=1767742583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xXbs7DTtJpHSfn5vW2Prly0waEmm7i+yQR+ng+cWcuQ=;
        b=INwlUFzJ0QenFncSLzShFsD0k4aGPq2UqJP8ZdwBhyVpFQMOuF3x4ajUhDDTugNTf2
         chjlT92ca47/B9RJp12R6NTQ3yQdsRJow4zRzG2eWlJDBPLNU+C61AcsjoivpRKtaVof
         t+1GWqWECCeWOT6GRCOcNNvgToTYIJiKLZMqHBL3RoZvkv5qq620irSGBPeIIqGFKs2/
         tQflQXSugEeRWpQDX/5kCdNvSH7xtlgiu+EoJH4ctj3Th2lf+QOdGII6owIjjF0rf/Vs
         BhGYAiphAlcsCsZtU5NyKuCbZHBViG0uhm26MlhP3Fu2LK5T7yeM7wNOgotUKYxE1l7p
         o4+g==
X-Forwarded-Encrypted: i=1; AJvYcCVuc2cz+2v8e2NqGkLbkAKv3tFWUAMlir4FhvXn1H4pCnR4sZfAtGdlrJ3I4fsDou4AG4lQDlJbFejRicpfLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz50HhzYljQOtQk1Qrg/Yx+3fekYZtditQARM/mP1GUU2mexvPv
	hbfCRYBfkhf8rSc4y0TrqELb3TJbleC0cfSSaIJFViBMhUS3GO7Ql42vnz0+12ZMgQ+IWkYrHjm
	llDfQqLO435PRvDmRd+MJ33s1CJKhvGWs36Lfr3FgozKPnzHxtjQPbiW/wIzagmyihGs5hg==
X-Gm-Gg: AY/fxX5Zxs/mU6G8HH2dAB8vlgb0Pb0kkCRdRL84EQW6LiiB3GD+aEbwz9N4J2fVAZF
	+dXh68IJrXis7gCleiEM+nJjqnrvsDo1CcLHh3Ec9BRaQYYIFAbqxpaw/vAhn6i9jS1FY+ZZmJy
	K/WO/PzFHY7LPjqk3sTr9amEWSnDGuDfhHP9IbrHVkCMtv38OBNrTn8RLL59jbxr6uWSLz6hqT3
	Mlwxgg+je7weu0FNVyX8FZaUdiFh9z/KX51ExFLWEH8bv88KQzOArsgtWzrT/ZdNGvdIOnI5Anl
	96Pf4oeFcER6yJ3Pg5+7VsgP70uS5XgebsxsbapN1UFlPFxOrM5XcTco3RiTMEhxQgEJoQJ7GP9
	8MaWdyoC69MkPnLLuCOvQj71OhcrsyUqI+qPPmQ6t1E3dnR9z59wU7yUtQSUxk1ApXw1Z7agBp+
	rVJvQPvDBGWR3Ojb4aEJA/8Mg=
X-Received: by 2002:ac8:46c8:0:b0:4f4:c7c0:bd15 with SMTP id d75a77b69052e-4f4c7c0c07bmr350491241cf.12.1767137783388;
        Tue, 30 Dec 2025 15:36:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHgFhlkhyhLFU8i2+WJ6QjjuayQocRBFfLuWGYbFfjr/Q0s6li8Tz2KAy4EkSJhFPlWPtZLQ==
X-Received: by 2002:ac8:46c8:0:b0:4f4:c7c0:bd15 with SMTP id d75a77b69052e-4f4c7c0c07bmr350491011cf.12.1767137782979;
        Tue, 30 Dec 2025 15:36:22 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:22 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 01:36:03 +0200
Subject: [PATCH 13/14] arm64: dts: qcom: sdm845-db845c: describe WiFi/BT
 properly
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-wcn3990-pwrctl-v1-13-1ff4d6028ad5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2964;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7LzbTKdhUl2NUOZfkS1Y8NaFZqr1Qnf7aC6QYgqUTZ0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpVGHlt4z1VN+r/pPI6AU/mqS10bThi9Wip+oPh
 anrX43GDfuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVRh5QAKCRCLPIo+Aiko
 1QIqB/4z9CRzsybrVzMYR/eL+ntwoRcXl+n8IfnBasvwWl+nQzvSxZvxfwOTVOQTRK/2Hcio5MZ
 5/AGI44NEDVP5mIa+x09TC055gUH93N1KsQHGabaEW0DdLgDDKAUfv49SCVX06gI9cktKbgEoWo
 3u0jenZpnNQMPpaYo47lgDPuTfUWOnLiB932/LH5CrOG8KM8MgwTi5uGZn9pV+sadu9yBDOAxzT
 3Fjob7IKfw53bUmdEt5kv8IoipTEO4idE7dW9Rrn9xzJt3Crnafuf5SwKgM932Gy2Pts47BSW8n
 pu42ll8LsbXib3RYbHJQ67N3r6wf+9W1t+3vGlEReYye6uXv
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfX5NMMwuMwI9jP
 3qBFqP1C9Rt0zZz9JRQi91qPvQJ9V0+QY3ufxqZYNHq6fE8+dXNKpN0Gwap9st+lbKdN43/P1Zp
 NCx6I4SI4nqG7L9j/wsxlEp1iZf/m0OPTl7iyyMqVXcAj2fP5yaEKCq/tW5mwnCAR4z7HooKbtd
 kCA45Cwo7H+gtbriQ+hRN9I76hA+WRiP9cm0EPPhKzUIGpFAAegJ8jOZXdrAIO0097TGN3wcYST
 ejJkD4Mb2D7exyvuH7jma9fCooQEMZELiQQJPWbhgui2E9HOjpA5TRsIKmqm+9nQzjor47+CDc7
 FLynPqVZlq9t9ngKW6NtiYXtFivTXsWeMfrNNaTiSlFCqo2qa3eOU5sb62rM11LER1VxOMxjDO7
 gODqIGCaVb6NgULuoGPxRlZxuGXk/KkwwxorI7YINi2gPqU+/bFiV9f5WQC16RVypIL0r6Em9Y/
 ufaOH47+4Oedjavzm4Q==
X-Proofpoint-GUID: Zai-0hee9hrEZdiPW08FJSRuJU1dlgz_
X-Proofpoint-ORIG-GUID: Zai-0hee9hrEZdiPW08FJSRuJU1dlgz_
X-Authority-Analysis: v=2.4 cv=foHRpV4f c=1 sm=1 tr=0 ts=695461f8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=urIVL_JefrS1cr2SfK8A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300211

The onboard WiFi / BT device, WCN3990, has a simple on-chip PMU, which
further spreads generated voltage. Describe the PMU in the device tree.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 69 +++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 5118b776a9bb..db221d5c770d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -276,6 +276,43 @@ vph_pwr: vph-pwr-regulator {
 
 		vin-supply = <&vbat_som>;
 	};
+
+	wcn3990-pmu {
+		compatible = "qcom,wcn3990-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		vddio-supply = <&vreg_s4a_1p8>;
+		vddxo-supply = <&vreg_l7a_1p8>;
+		vddrfa1p3-supply = <&vreg_l17a_1p3>;
+		vddch0-supply = <&vreg_l25a_3p3>;
+		vddch1-supply = <&vreg_l23a_3p3>;
+
+		swctrl-gpios = <&pm8998_gpios 3 GPIO_ACTIVE_HIGH>;
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
 
 &adsp_pas {
@@ -659,6 +696,14 @@ cam0_avdd_2v8_en_default: cam0-avdd-2v8-en-state {
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
 	};
 
+	sw_ctrl_default: sw-ctrl-default-state {
+		pins = "gpio3";
+		function = "normal";
+
+		input-enable;
+		bias-pull-down;
+	};
+
 	vol_up_pin_a: vol-up-active-state {
 		pins = "gpio6";
 		function = "normal";
@@ -1038,10 +1083,11 @@ &uart6 {
 	bluetooth {
 		compatible = "qcom,wcn3990-bt";
 
-		vddio-supply = <&vreg_s4a_1p8>;
-		vddxo-supply = <&vreg_l7a_1p8>;
-		vddrf-supply = <&vreg_l17a_1p3>;
-		vddch0-supply = <&vreg_l25a_3p3>;
+		vddio-supply = <&vreg_pmu_io>;
+		vddxo-supply = <&vreg_pmu_xo>;
+		vddrf-supply = <&vreg_pmu_rf>;
+		vddch0-supply = <&vreg_pmu_ch0>;
+
 		max-speed = <3200000>;
 	};
 };
@@ -1155,16 +1201,19 @@ right_spkr: speaker@0,2 {
 };
 
 &wifi {
-	status = "okay";
-
+	/* SoC */
 	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
-	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
-	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
-	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
-	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
+
+	/* WiFi / BT PMU */
+	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
+	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
+	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
+	vdd-3.3-ch1-supply = <&vreg_pmu_ch1>;
 
 	qcom,snoc-host-cap-8bit-quirk;
 	qcom,calibration-variant = "Thundercomm_DB845C";
+
+	status = "okay";
 };
 
 /* PINCTRL - additions to nodes defined in sdm845.dtsi */

-- 
2.47.3



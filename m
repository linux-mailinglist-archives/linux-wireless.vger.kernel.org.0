Return-Path: <linux-wireless+bounces-30194-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53643CEAE83
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 00:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11853307D266
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 23:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5DB2F25EB;
	Tue, 30 Dec 2025 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W9X7mXlK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="End/AUXb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A5D2F8BD3
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137785; cv=none; b=qaDPsu6xZMLAQ7XVQ7RVVgCNakaqbTVzdVhhpWJQLKGRwptxUldKnH3ugCv35FuNeVavWPZsIu93pmVfp+ORgOJkimo5RpWMtfQzC1go+4B+YNYNAkN11kIRTKPX8bCOBTr9PKBa+TpnZftbPzHMPju16TSwBwS2/lzVE6aDk/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137785; c=relaxed/simple;
	bh=6+JOo9+e5YxLPlXZg+ZHcoNUi9rYQcA+G+nvDkHNQjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFDv6RkuceGWDiR6YFkPi0DGw8/91r6PQNGqblZvXiognHhcNHkqcbqLwGv2gfKlvfyMEVzly1zHc7qzSeSvPR8pFYk6Ml+qbMx9wCA58MeuSE4rRfnEjAQWeK+zalzg0CaaHNgt9fL9JVkHzC9H+FYw/5iKeCXndszOtTSaUuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W9X7mXlK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=End/AUXb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUB8uoT3971615
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pN0gw9rG5RdzlmEjVfv9qpWVODg21JUBSfOFUltY/P4=; b=W9X7mXlKCro0PCl6
	Rt8t8tiSX3+94XCTyqDiL2yuw1Ndi3nRrViN/hH1usZR5Cdmk2bZvZJbYJOqjYCq
	Q0QImXZz0sJTwu4gwvz5F1soWpby61KDuLZeDH7u3n2R1vtfHWyC8zQoriH37Gde
	xHmU8KoHVjMWEBdrsx3i3N0zorVJzwMh+Z2nu5bie00Z+hqwFzhhF8xqd10Kf2GX
	Riu11Wx7enP/L/d1HbSVvm82+fC2TK7xlOFZAoHmBoW/5i4KxDj433vv3HmAxmcs
	19Tv5DJyRiDkoR01jK4mMvjyVUnBKaRQoWPfZoKH4zmG943adviCKP080j86eEWa
	W09VUg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcdky1dfy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed6ceab125so274979441cf.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 15:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137777; x=1767742577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pN0gw9rG5RdzlmEjVfv9qpWVODg21JUBSfOFUltY/P4=;
        b=End/AUXbpr/nYVOblH8037S2VlGgCnT8AaShYYVzU2J82lOasEE3x+gGT19/XTCDmi
         zTJTmakLeaaJ7UAANFUiV7hbyDWVP+/iL5fEM23wGuggRfWv1BiUsPxaWV3WmWJSFrOv
         blEqqHYSvRFqLGTclTy0jZByQXM9uGwXkaD3yIMzopzOH53biCahBirKkZz0sBOBkREw
         9IkvEG8Lm1s7/keofHi6ArP5/poYL8cTba4QAIjBCzByNoPDBsxFxHAw97j59ssGv6B4
         8rpQxsj5yAReHmK+hl3QcizZsBfq1JTHadvLYiCHffrVOShQa06og52ZuJaJjp15R2Wv
         1I2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137777; x=1767742577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pN0gw9rG5RdzlmEjVfv9qpWVODg21JUBSfOFUltY/P4=;
        b=DbCiRZJMdXiEQ0agPqodo2bMrHLJRaQk2624Iu6DYxSrqXDK35Q5CpdxMncPkybf49
         vVqaY7X5eGKaimimbauA63hPiYzMttOOoisiPfAOrP2Klah1BFAqb7nqJJgfUx4gSsi4
         ne0uRqkRKd/H5eCHA4ip9vzRzV3P/sV3+rerCUdXJyTm+YGtA2GrBNZVoKgH2FnhxPQB
         8KObbZAcHX+T3+TfjgrSui7jeIro93HuDYTFouYI63u98rBBJifUBXDotm0VfyJnFWba
         /p40vk93mFj+Dpv33jZkl2DvOFRqrPqHm7XXEijUDbwlL3D5XVyiOth1wPwXr7AI1eoL
         2aTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCzBlKvT9LRGebHyTWVY/Om/raeHv1SWHVxFWEgKX57aweTKX7beGrdFi8JOJ3ArtHfITnq9S7xgp2l/V9Vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhjHmdAM+2BHJhlLILbs7sQqslBwdBDM9cqIfSt0aSxg6gwp7+
	M6MlpmfgfDQ9T/ZXmTUZJmTOcgWZukHFizgtlOdydSZLR+3tHtkF/RbT97VcTZjGPsB/TxNOyf7
	naVivklbe27UNV8xx4zmSkprXTFh+khMdk5Llm0jK3/i2rMY0PnJSc0Df49ECTxv0htE1Ug==
X-Gm-Gg: AY/fxX5rAK+3fPsrYeg23Gv8Sqg/xrk+857+huGS5QFp8MAQ0WjqlwQ/qEX6JXlJDGH
	JkkEyh/MmIlcDdV0ReSTUENiOlHB61VA/Wt8J5vtP23K4EK+fdmN5yoEjV3PJqJ7YQvnbLpfYtH
	10te+xpxb9v/tAUjIh8h0+yupR/tQ5/M9NikT++jTPR8Et2nyAxAY6SmRR4WNqmlcTcTG73U5Dt
	k+HaDhLf1CcF28Ip86SNCmDeNgaZBF+1DBFOCmwYhv1drn7jnJ/02Bvl4DTM+sUkDALlshnnjQR
	s/k4s0PfPWYxgDtCm/WeEkzDlkPJn0Guo/60cEEE3ufQ0uHJc5NRafAwsmSL+x7mgZGd48Qlh+e
	0aiGTpfey0KZfhPDjRn/RBfB0Y7tjH/IYkW0tRBE/B1nbWKDxwZ40GSzyj12PTZ0I7eocGX4Kcc
	nZ8PuSWauxiIbzg2VqEuAo/TU=
X-Received: by 2002:a05:622a:446:b0:4f1:e2a4:db39 with SMTP id d75a77b69052e-4f4abcd0629mr550480421cf.4.1767137777312;
        Tue, 30 Dec 2025 15:36:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFRv8l3gteOWWtOu6vhj4QMEJMlCDWlZhifBA6SZD+rpP0wesN7wEhHc/spA7fxWlz51/BRw==
X-Received: by 2002:a05:622a:446:b0:4f1:e2a4:db39 with SMTP id d75a77b69052e-4f4abcd0629mr550479991cf.4.1767137776837;
        Tue, 30 Dec 2025 15:36:16 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:15 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 01:35:58 +0200
Subject: [PATCH 08/14] arm64: dts: qcom: sdm845-db845c: specify power for
 WiFi CH1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-wcn3990-pwrctl-v1-8-1ff4d6028ad5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=6+JOo9+e5YxLPlXZg+ZHcoNUi9rYQcA+G+nvDkHNQjU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpVGHkqHVNQ4DBU7B16+g5tUkbTtk76iHKgCnuc
 k8IHXUM1XCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVRh5AAKCRCLPIo+Aiko
 1d3PB/9YnZoK+1dQpJIB/EYgZhmQVsNlnqchf5lDyF0QQC0qzYQA7LFWTOi2QmeI8KkfEoOLFrT
 iHX9jXwo91u+cGPXXdLH9x4ZskL/pcNObZFuCxZBl9ecKP+lQI5oZ0UuU26Q0hQDqo7C3MBtd8y
 r9+lQZYxJEDS+D9avz7Hm8rsej+hngqN79FmwHIfoCWErlVNVHWhCkGWEUpNyh4TI4bhUXMMVBl
 /boWOOy8oV3PAzN4+C7E9dsOnhfrJQ/22IQzoPHy3tAfQgAC3DkSWN8/22/22LVjK+u2SxYi6Jh
 flTMV0g6hGZNetYTQANJNDgE0/zq8QX59l9k+HZXsnpsZE/2
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfX8P5aULNwAQAT
 BymrZd0kV7s2q6ustCBEbVWx3Tv2FTtk7yFxLniPKUX4Y2HRa5AvSNrQFf+ggX9ydYOgWYptIFV
 u6N95x+JnybbO12z9JDGJ+iAae4/pesAMC+L3i2g3hSJd1chaPS3MjPvjtwQKTtsRlo3PbG7EmH
 wHKLtro6d9xHoYHA19DnQzCqOsCg9lnXNjhbLgu49u0Z0Tif9ihRZNo0/B3u0NCM5hbrU9fj/BZ
 YutHbJCezMXqqQjqsNkjXlYXlc3l70s7tJ+V+laNh/eUzfhHygcPs9KE9K0oogEwdvSFFPkUiKO
 CkAXXCezmKUUlj7v1hO+tlwiqyLUHUUw1RhqsBVV9jy5qGMKWnOBXOnAfxhy3Jbjuqf90MFMNyv
 D+J9LuaC4cm0rQ8jx0xZW+VPoPRn8coAlO5grKcrAvjq9dVTpFf8AF76zpR4/AI1CbHgabSfVCJ
 JwSaxLrI3/H0Yy4MSFA==
X-Authority-Analysis: v=2.4 cv=Wskm8Nfv c=1 sm=1 tr=0 ts=695461f2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=q_35thakA6fvWH9uoQUA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: F1x90FKswBdF6QUNxTXBG751_69Y020G
X-Proofpoint-ORIG-GUID: F1x90FKswBdF6QUNxTXBG751_69Y020G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512300211

Specify power supply for the second chain / antenna output of the
onboard WiFi chip.

Fixes: 3f72e2d3e682 ("arm64: dts: qcom: Add Dragonboard 845c")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index ad283a79bcdb..5118b776a9bb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -379,6 +379,12 @@ vreg_l21a_2p95: ldo21 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vreg_l23a_3p3: ldo23 {
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l24a_3p075: ldo24 {
 			regulator-min-microvolt = <3088000>;
 			regulator-max-microvolt = <3088000>;
@@ -1155,6 +1161,7 @@ &wifi {
 	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
 	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
 	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
+	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
 
 	qcom,snoc-host-cap-8bit-quirk;
 	qcom,calibration-variant = "Thundercomm_DB845C";

-- 
2.47.3



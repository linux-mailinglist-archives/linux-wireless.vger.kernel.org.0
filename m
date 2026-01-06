Return-Path: <linux-wireless+bounces-30377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48507CF63B0
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 02:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B203307446A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 01:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5AA327BE1;
	Tue,  6 Jan 2026 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bgv2jbDm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i38WL4qK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D6332548B
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661313; cv=none; b=AwdPvEY8YP60Ua8ua6o+ojIYOMxnbkUizpgF96+BXxZafwZkUmIgOnqq53Zik0FM95aQZGJch93818a7+XT4dNbD13/t2s9mAPxw5Tj6o3dqgtWebYTexmOcrUM+Ux3RA2fdnJXK6KEBCsQ85k+XbV1UtYW1PvUcMdhT0WuXHFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661313; c=relaxed/simple;
	bh=/u1tgrZtHEkSxPcf5pHX7xHPoerlKHblqpNDjU74XrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YM4IkS3hqdEVVMhKdlj0bgLH18HG6a5krw2EghMPEYiYr+0CbedPuhiW5WSYo4nq273eMPoVY6D9f9VGM+ezqU7KKlc16EEHaQS/cUCXAZLuv81cKA11oQYIT1FMNbUPpUUt/engCZZ3uKwEc2AwMMx70aYd4hK97Vu8r41WKoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bgv2jbDm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i38WL4qK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nFxk2745455
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 01:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ex4s+EzJxH3coe9V2sL1LMe3/CJisGmDqJf1ChODQc0=; b=Bgv2jbDmLFM9KUh+
	VrvFw18/dz95CrplfgJwl0i33Mga+JO2UPlo11IsEzKgRI+fZue1jyZr0zn2T27q
	v2UA3y8uGn5Oz+nbU2dnbJG9UHGwQeqHkutFZ2XRfeN7wm7e2RZOlFcq2mzFx4Nh
	bE5EHnliVuz9hOKlZ8L68+R8HxUKbyVhQ2D3V5EhZ8L4oKZGE8A49oyPyBtUmSXH
	ThJ8k9ZmbihobD5gu/ZqvdwXX59cKL+UW/tfJhpMHBMqzXSj5DCUcpkd51Z5uKa4
	NXf0ngtWIwjSEQfu2SsMd/yZiuM5iHgOL5vbKTkWQwvg4Yo4iRjBeKoUfpq9HdV0
	91U65Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgg9yschn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 01:01:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f1d60f037bso10256811cf.0
        for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 17:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661309; x=1768266109; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ex4s+EzJxH3coe9V2sL1LMe3/CJisGmDqJf1ChODQc0=;
        b=i38WL4qKvRJaVOFqI4fxp1ZoK0E4EAzCHOvr2cQZ0d+90hhFIcwaBsMRJnMoFMPcQ/
         zEdIubXOO7lB5sh+F6xvRKGIWU3Rc/sVnAXWsdXZJ3Cu2Rh/evxNOt61meEJkPhNvUAh
         YIm+JMc0Dmyr6rW+myetpE3/1w04UBzTIjyDrniPYxOfuN0k5UJ4EdRTVzZzGrdphEuP
         cXkjhj8wp/rRjPtdh2RmD01z39g8XFQjnTTqaSCTeAudQuIyN6wzk/CWnTJlwjqCC6BQ
         zQZG3AaIqmHlqxpN998+NAxYXyYb6AJvboXG9uQys11hxsUMh4Ym4Hqrmz3aYWX3SdzC
         vwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661309; x=1768266109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ex4s+EzJxH3coe9V2sL1LMe3/CJisGmDqJf1ChODQc0=;
        b=ggMNvi94kG0dz96buuNvOe4j5zvuAjWhgJcUwyC3sNXwUEYwWGn0EPQEIs8RuOuPqU
         4JXLiNn0FkZNtk/ZfHTqDD6whlFGcpG/xOwNkPQ3rX/042/vIZDmaZ5Ch1QP6cLbf9sF
         4N4UxG1gE5oFTqoiMSOxPGMvC+c4KOiZKHIT1gi2IRHxX2KMoPGbCwyYYPII+6gASf2j
         NHURLKyyNiZVTHpxfCMCSSG5oW+uoGgil/ThdLkTJNPAF2TWg51aX4j54Ue955+FonbE
         Vy3mlV+NMNh045clQu5MHBSD5dSwiz7StOsc1oEKCqaLDm9ZhTiBkKWpoy6wMxuUzRxR
         zc4w==
X-Forwarded-Encrypted: i=1; AJvYcCWOCtrgZusENHKFIUvP5mfke+2ojTYSqzOIQGeMTzRZsdajepuh9cpgP1/bVBcR/DVq9NRgDH96gDrT10+SpA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn/DX+8iKnW+NecpnE1URtYj5+aUTCXeLO22WHAu+O31sE0Cnf
	MR8i5SVLwuMgI+/WLq8ARbk8lOvE61Js7Z2m70Fj9oLyGHIdttysQHjg3Wj8uYG7iFaE/xwadu+
	Ig8wkPlyf+cuMwvRma8yZVh/3DVw3cM6zTSHn5YUEYAxd0Qqbx3p5fBDgBhsAkXidm5p+5g==
X-Gm-Gg: AY/fxX6kZCS0r7za37Kc2B/Uz4WNAuh8Do7oDcUMHpjZHbXWKgd1MPzDTmCE9zYzfOk
	GGxd0O4soGtc9Ec+gzcvSZz8wU/52Ormt0WNwMp7IcdsVd6aj3CuHLTUWxKqS7KL1uUJFl0VPHl
	bBN9Vm05+C3Pj55YST6zCVOV0Ulz+TuPwbpOe0PeheLujviuC6bE+ZcYto2mQnTEsBTQus0JW41
	0Z01Dn3unfwa9JTyfockKvDuzaohOsbkc8iuv9zW5gRewsg8Y94mnFZnvQIbLtpdmuIj5bKTDMD
	Gea5FWRa6pHWUh2fe7bydPVvh+NSQO1e8ocP5O3m+Q7kLTVRIu1ggwqlNf+ItVsJp0YI3gg8f1D
	4RV617lfvSXmw9EScwR5LH6FF1xrD5RUSMRMjYQloDJHejIHtekWJVlsWxhUSoe8WMygF/W6ue8
	Sc2dJsCWnisCLzinFzv3vtad8=
X-Received: by 2002:ac8:5990:0:b0:4ed:b2da:966f with SMTP id d75a77b69052e-4ffa76da34bmr21391011cf.31.1767661308650;
        Mon, 05 Jan 2026 17:01:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGmwxi9YOkYp+Kj5Bqzdrtyu54onQjj7FG99+Fq838iN1qvkxSrv+NFDDAZ7ZUD561ezIHyw==
X-Received: by 2002:ac8:5990:0:b0:4ed:b2da:966f with SMTP id d75a77b69052e-4ffa76da34bmr21390551cf.31.1767661308206;
        Mon, 05 Jan 2026 17:01:48 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:47 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:23 +0200
Subject: [PATCH v2 13/14] arm64: dts: qcom: sdm845-db845c: describe WiFi/BT
 properly
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-13-0386204328be@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3033;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/u1tgrZtHEkSxPcf5pHX7xHPoerlKHblqpNDjU74XrE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7axr2YseItmnkTg90KlXZF4jP2cDPnp+w6m
 11MJbzET+uJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2gAKCRCLPIo+Aiko
 1WmtB/95BUWWIbO40lh7AIu+2V+zI3fS1VO0vnTlojhc/1vdGj0kB/Ug+5TL5tB5Rdk6sOXAE8b
 Me5DW/hM9jhlJ6upLmROOBq7n3V/a1FP4TENKcCEmmAnn5INKtwO2nilDLbJLU+1gTmU79xM+/0
 1dov3LLjnGhFU90bR3crT9qfU6cqnxdeJ1+f/JHStf44/oCnrwsSNpNTCOivIR5V5Mb1WIAdUTN
 IaGmA+jLTQ0h9/YZBT539ZeZ+NPjUedUx6F/cJ0G1nnAVl2+Yt4v7qUWcWiBpOdGylYT6GlGRzi
 DR/Xc/f69bi0eLM+6Hb2/OuCZ4dYONd1abCQnqL8mCxdPXdE
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=M89A6iws c=1 sm=1 tr=0 ts=695c5efd cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=urIVL_JefrS1cr2SfK8A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfX8t+38s52pU2x
 xIda1hIXyex/Ue5IUDOIY4FGuFK1EJzknUiIfqA8BiLEMxQi4GMWvuM+wYEtA1HwQ0vlL/Cdjlj
 AvPYyNLDxGqDtupAiXSHp6QgdC/l5xi7KSPCXSQUZ8XHaZ1S5JEh2Jq8iMgNve97jREeSWuxRwJ
 W4QHSZP0sk7tzRzm2HoRrfUWsh5/kB21WC9eQ1KBJLJ6uQ0IB14di4QrfgPjYzNRCVWWkj84bat
 O4lb2/xs7IeZZHlhJRC1i96JttVf5lZ+ljk/CB9CccTYvALNuKTayMlNL1uhl/B/F/cCiteCWPx
 /n8cU2gC63KEDisR0kpy0tgdQEezHuo8Gv3x7aa+tWLPNNgmw1+JxmSePK3KdegY9fjHIkPg635
 giJz6dTHnwNWTtNu8kZ2iApKgB/kNsIsbCyrMNx6F3cMUuUifyCtggbnfJsB7n1d7x7mfmfr+Dd
 nVc7OqocTyihOUSgZkQ==
X-Proofpoint-ORIG-GUID: gHSn9acpPchTX912lKrcR5Ag9HArpN94
X-Proofpoint-GUID: gHSn9acpPchTX912lKrcR5Ag9HArpN94
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060007

The onboard WiFi / BT device, WCN3990, has a simple on-chip PMU, which
further spreads generated voltage. Describe the PMU in the device tree.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 69 +++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 5118b776a9bb..02416812b6a7 100644
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
+		vddrf-supply = <&vreg_l17a_1p3>;
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



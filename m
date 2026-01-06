Return-Path: <linux-wireless+bounces-30378-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFCDCF6392
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 02:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D725D30381B7
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 01:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F80D328B6C;
	Tue,  6 Jan 2026 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LNjFSgZu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ej4FV8Au"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E6632720D
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661316; cv=none; b=mHEC7Soh9fPW9yeObNVR7nrybhe0Vs+wqJx4HTJUcXsc+QDdV128Zb7Flm/9AcF8TcDh28EFxEha/VIP0Oy1ztV+B3zgEv+vlfbroDNNMMIddUDEj0/bqV1AQ73iz0xTolpIMgSbKwz9w+vlD5I6oPharjuw4soV7QSHQTEzzIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661316; c=relaxed/simple;
	bh=q9y+Dif9HlWdcnmMDM5hAVRBaWF08BPAccXmvU/QVEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BMPfieJ9W5QT0u+RdHOaektdnCSdxD1P4fpDiPE797u18uM6w/g69F7dI++h9yS2peqAX9oO6R7uN8FC3SHkzAq5eu/D7XFbUf8OJRjTV6JqEbAKt4tJ6gdGNPVVf2s1Hwo62y+AA9/G/I9ftr62hnysRlQFHFf+IPGUiy127j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LNjFSgZu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ej4FV8Au; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nTWA2528167
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 01:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JO4Pi21OVHijpMNbTgyCYWdKmobPiE/rHbiYvQZIfKM=; b=LNjFSgZub+8hN4ZM
	oZBHpZYo/6RJPJ634S+7e7ATt1GUBrOKOkAQ1dp9D1+tSSMGs3lbJfsd1W+w1uwj
	g9c8IyKAL2zU/zPkzbcKxNHf7xOztIerRw2FIz3WjCh4/tpMHIHLI15OcQtsjzDP
	k/nhrq6vObV8Mhy7C0lZ+mFrdOO0u/6wgmjAMZmZbS4tHrIBtSCdqjlqxvq6ExT8
	8mJF20NydW3iE3klTokDZUWqoHfpE1jHJnP0rPpXnqp2sD11mX2KFLvUyEAlPZzb
	c/zhj7+K0auhBmBZY+LrcGYv3ypdGKqYOC/gHi9oMflOwTE5ApOccCEWVdvmILzA
	69T/jA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgaus2bfy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 01:01:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee04f4c632so8157641cf.3
        for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 17:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661311; x=1768266111; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JO4Pi21OVHijpMNbTgyCYWdKmobPiE/rHbiYvQZIfKM=;
        b=ej4FV8Aua8BsqUl/WAimMOi4zBH1RMx/YHO6XSzXYuVXK8jJIHJ4+A4ZjRf4Y6kefc
         ptb5t9S1NcIP0M/UkG2FhV39U/any1WFq0S8inuXf/nSIVYliMNRxLqhIQCt3AuzETAw
         fkd167PEP2Bc/eAyzUD/vrsntL5K86lQHBG9iJjsF1ze/NLhN3RMupP0iwsJNULSzRSd
         6wVgA7avkw9EcyM4pJ/APcc8QeumRltSZRIcsN8Li7cZP9nuQtPYbJ2P4z/rU84bAtp/
         2FmKzhWe7DMBndTezSHK71R4XmXeJrYVnwqYeH9cPfNmOE1OYeaozk3T7bGRsvVHQJ6n
         f3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661311; x=1768266111;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JO4Pi21OVHijpMNbTgyCYWdKmobPiE/rHbiYvQZIfKM=;
        b=Z1S3IG/tjX+viSCsc5EuTgBaX5XHS+LAqiKS/1eNumiCEOAaVldc1bk0IcFj3KA/2c
         P2bDC+/aDTLZiXlNqrDvnEzoswlPyGMwfonv1dbEQiEsYnt4KP8CrAGgsjBb94nVyj9u
         TP3kbdYxQfNXDAGSsosQgiGP9puKDrluuz0MGi7OL1g8nOcd689Qy89hTGA8KsNNK3A2
         Jollk8zGibqPX/GW59sSYmYKShto0ExP3gky6Br0HS7ZJWwLGv0VW8Gga1+bDxyZUN4p
         eK6KzQCX0az8Gj5uwE/YrUryr+iw7opEAWewhXzfDHDacroW4PLI0x6ru8/2wBYlP/GW
         cYeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBd3xkHaed0dcCidKbjHeA2f0FNa/iz8Ise6VMsp24jJ1w/PSpV+khZu/BJG/89skOmFLIQ5LvAx1H5SAliA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2L7j3m5y131P6Ju63V0fetTsEuXncjzsDYZ496peZu2JZliUa
	ZI8p11bmkqcoUgIlCAucJ1xoINyng9dTUpPfJIv1CwLR2rQA3Ez5KikP/Pc2vxg3Uk1WZ11Efwf
	m+bRFivniwbM22Blr68g2FPnUmdxY2FTQfcrYsO7xZsZkliBJ05xt7HI2yCN12phMrfQ9L94edF
	WWaA==
X-Gm-Gg: AY/fxX4AN33xs/qFpgM3ku5tSgKDWoi047IJj3M8rNmx75NY/Drg5YmvaODptXy7s4l
	7KLbUeofag/69ejYD0VD5FtOwnFyvzL24y2f4lOxwaSMZI0Xa0wumxr1AxqGqTZ0HW0ZeSZc5xo
	D7iZA209S6jdg+uBhhdqB7pNHuzQ2laT4D+HrVKE+1PybJp+gek1k2cN8OTZMDuzLrvpVks3CML
	a8tTJWW/Vp1Es2t2465wculu+4pfeUdtsOajPZuY/3Mv4Zzgk880k3881oRaeSnSKpGMyHKC6ch
	6qZdrG7aebA9F0kjzTEFZdLZ7UITklaefrVOhBSb1O+lgvOGZsAxO7138KzR7GXVAoUwLLKznom
	TvUD0MlQBfnV+5SKnUzxywjyj2v8kvvOEcjWOO6DkT4MGOOYtW2XzUBcP3JxhUl5RQoFT0Y5Tzs
	5pf426/xosqS2YYqHzY/H/6ao=
X-Received: by 2002:a05:622a:1b0e:b0:4f1:bdb1:eac7 with SMTP id d75a77b69052e-4ffa77d90b5mr19653331cf.55.1767661311317;
        Mon, 05 Jan 2026 17:01:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2rfvBff9pcaENAxSLwBaEsGSjWXENSQaskdKeKTaq/4/BVsPJY11d5lKCuvFHjQ51JK1SUw==
X-Received: by 2002:a05:622a:1b0e:b0:4f1:bdb1:eac7 with SMTP id d75a77b69052e-4ffa77d90b5mr19652881cf.55.1767661310654;
        Mon, 05 Jan 2026 17:01:50 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:49 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:24 +0200
Subject: [PATCH v2 14/14] arm64: dts: qcom: sm8150-hdk: describe WiFi/BT
 properly
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-14-0386204328be@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5744;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=q9y+Dif9HlWdcnmMDM5hAVRBaWF08BPAccXmvU/QVEU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7a6K+/f+otdXC4XFp/otfrE7F6zDF5dXqGY
 p3jobuYaHqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2gAKCRCLPIo+Aiko
 1bHJCACjyBHBDSElbc7bbb1YtK2V27VbPAlZja5rFSb4UmSUGf4P+/bMIGmkzvWg7VhiwA4AfuW
 zWuGcoDN0a+9YDfIDmOt+OJ3lSpRGzwVdeGlD0lHMm+Mlj//6KiMwpznilDD/vT8m3FsZ6+G0re
 y3KdWUNWmSrYVVFmZecqidWodYLjSVCqbiOW4PDhYRkzQowyaqvQIvDwBKYCgeDY1tm/ml1mk/I
 93200dHSJdLCidy+XZhi1tNb5DmG5avsiEnsfzMenn7iAR6PfbTg4CIRw71XFqvzzLb/CYWv/iZ
 VnLE/yCXgdBZaZVJU5gkoMhco6O2jM3H/uT41/Sk8jpCgx6B
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: _i6sn5jB1kJrMeUmOGQJMLbiomiwvivr
X-Authority-Analysis: v=2.4 cv=DP6CIiNb c=1 sm=1 tr=0 ts=695c5f00 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=daeKR1c1ZtUuBhPExssA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: _i6sn5jB1kJrMeUmOGQJMLbiomiwvivr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfX9K6fe9zq7k9E
 RmcQ+y6FefTYnWhVXiFpgx2R3JtBGGcIkQvFzIFGUYAnfLcIYVOqkKaSsQ2U8GILeNDUAcS9RwD
 jpVhyrGZWZS4rblRSN37liQxdBAp2wJp73JOCNlpkzW1xjjiKMasaYaJtGBmd2vCv9Z2w/9Hdq0
 fFVuVj5IfXQFkuROz1qhrR38o6aizOo/mQucLeqYbZ8Ggfe/BcGxs0Knw5dMkriI2BHFEByeKnc
 87r1ZWXHmv9zXJYCrDAHmV5NI907poeZ9cnZFiSZCyXMUqJ9Nz/JVK8DONckW2KrkA1q1KetIna
 P1ybk4VfVJ+IPfAQJdUIQTvPhcJPlTlVO+IxiGt7GpsN6y7wqufgP6wITJfMdZgHWv2auzblugA
 r6ofxKOePHHtIcZI7MLUkOqYVk2OZWbIpZk60T2Xi4L8BEDKqKxoD6SGR7a01GVtYGGCK7exKKC
 syQaNawK3cppYXJEr1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601060007

Properly describe the PMU present as a part of the onboard WCN3998
WiFi/BT chip. Enable Bluetooth part of the chip too.

[    5.479978] Bluetooth: hci0: setting up wcn399x
[    5.633763] Bluetooth: hci0: QCA Product ID   :0x0000000a
[    5.645350] Bluetooth: hci0: QCA SOC Version  :0x40010224
[    5.650906] Bluetooth: hci0: QCA ROM Version  :0x00001001
[    5.665173] Bluetooth: hci0: QCA Patch Version:0x00006699
[    5.679356] Bluetooth: hci0: QCA controller version 0x02241001
[    5.691109] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
[    6.680102] Bluetooth: hci0: QCA Downloading qca/crnv21.bin
[    6.842948] Bluetooth: hci0: QCA setup on UART is completed

[   81.510709] ath10k_snoc 18800000.wifi: qmi chip_id 0x30224 chip_family 0x4001 board_id 0x55 soc_id 0x40060000
[   81.521713] ath10k_snoc 18800000.wifi: qmi fw_version 0x32040163 fw_build_timestamp 2019-10-08 05:42 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HL.3.2.0-00355-QCAHLSWMTPLZ-1
[   81.554143] ath10k_snoc 18800000.wifi: failed to fetch board data for bus=snoc,qmi-board-id=55,qmi-chip-id=30224,variant=Qualcomm_sm8150hdk from ath10k/WCN3990/hw1.0/board-2.bin
[   85.467464] ath10k_snoc 18800000.wifi: wcn3990 hw1.0 target 0x00000008 chip_id 0x00000000 sub 0000:0000
[   85.478132] ath10k_snoc 18800000.wifi: kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
[   85.487223] ath10k_snoc 18800000.wifi: firmware ver  api 5 features wowlan,mgmt-tx-by-reference,non-bmi crc32 b3d4b790
[   85.758168] ath10k_snoc 18800000.wifi: htt-ver 3.73 wmi-op 4 htt-op 3 cal file max-sta 32 raw 0 hwcrypto 1
[   85.901630] ath10k_snoc 18800000.wifi: invalid MAC address; choosing random

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts | 141 ++++++++++++++++++++++++++++++--
 1 file changed, 136 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
index 1eea9c5c6684..6ae6e07c37df 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
@@ -20,6 +20,7 @@ / {
 
 	aliases {
 		serial0 = &uart2;
+		serial1 = &uart13;
 	};
 
 	chosen {
@@ -66,6 +67,43 @@ hdmi_con: endpoint {
 			};
 		};
 	};
+
+	wcn3998-pmu {
+		compatible = "qcom,wcn3998-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		vddio-supply = <&vreg_s4a_1p8>;
+		vddxo-supply = <&vreg_l7a_1p8>;
+		vddrf-supply = <&vreg_l2c_1p3>;
+		vddch0-supply = <&vreg_l11c_3p3>;
+		vddch1-supply = <&vreg_l10c_3p3>;
+
+		swctrl-gpios = <&tlmm 50 GPIO_ACTIVE_HIGH>;
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
 
 &apps_rsc {
@@ -598,6 +636,10 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&qupv3_id_2 {
+	status = "okay";
+};
+
 &remoteproc_adsp {
 	status = "okay";
 
@@ -630,12 +672,97 @@ lt9611_irq_pin: lt9611-irq-state {
 		bias-disable;
 	};
 
+	qup_uart13_default: qup-uart13-default-state {
+		cts-pins {
+			pins = "gpio43";
+			function = "qup13";
+			drive-strength = <2>;
+			bias-bus-hold;
+		};
+
+		rts-pins {
+			pins = "gpio44";
+			function = "qup13";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		tx-pins {
+			pins = "gpio45";
+			function = "qup13";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		rx-pins {
+			pins = "gpio46";
+			function = "qup13";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	qup_uart13_sleep: qup-uart13-sleep-state {
+		cts-pins {
+			pins = "gpio43";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-bus-hold;
+		};
+
+		rts-pins {
+			pins = "gpio44";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		tx-pins {
+			pins = "gpio45";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		rx-pins {
+			pins = "gpio46";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	sw_ctrl_default: sw-ctrl-default-state {
+		pins = "gpio50";
+		function = "gpio";
+		bias-pull-down;
+	};
 };
 
 &uart2 {
 	status = "okay";
 };
 
+&uart13 {
+	/delete-property/ interrupts;
+	interrupts-extended = <&intc GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
+			      <&tlmm 46 IRQ_TYPE_EDGE_FALLING>;
+	pinctrl-0 = <&qup_uart13_default>;
+	pinctrl-1 = <&qup_uart13_sleep>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3998-bt";
+
+		vddio-supply = <&vreg_pmu_io>;
+		vddxo-supply = <&vreg_pmu_xo>;
+		vddrf-supply = <&vreg_pmu_rf>;
+		vddch0-supply = <&vreg_pmu_ch0>;
+	};
+};
+
 &ufs_mem_hc {
 	status = "okay";
 
@@ -709,12 +836,16 @@ &usb_2_dwc3 {
 };
 
 &wifi {
-	status = "okay";
-
+	/* SoC */
 	vdd-0.8-cx-mx-supply = <&vreg_l1a_0p75>;
-	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
-	vdd-1.3-rfa-supply = <&vreg_l2c_1p3>;
-	vdd-3.3-ch0-supply = <&vreg_l11c_3p3>;
+
+	/* WiFi / BT PMU */
+	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
+	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
+	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
+	vdd-3.3-ch1-supply = <&vreg_pmu_ch1>;
 
 	qcom,calibration-variant = "Qualcomm_sm8150hdk";
+
+	status = "okay";
 };

-- 
2.47.3



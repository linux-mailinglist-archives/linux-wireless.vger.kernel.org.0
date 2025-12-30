Return-Path: <linux-wireless+bounces-30199-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 833D3CEAE43
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 00:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 767A4301787F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 23:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BF332B9A7;
	Tue, 30 Dec 2025 23:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZyHOKL3h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EE07bxKM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0C92E62A8
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137794; cv=none; b=Tvxn91bSoFrnbwwwPi06CuixaYENo/IP6DgPdkYjLPzRFwU8TkKf4TfPSuE027YXwZ+4f5sdv6c9U+GRRF1KolsBRd7VhEMHNVWNWtywgliuF1/j607y5aPiUzgdtoE6V5e0irxga1MfF5AJngIsSHhLCPRG7TKYCaEmJ3A/GLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137794; c=relaxed/simple;
	bh=8vfZDA0+eLe1oxx8QbS4fcx/NwTCXaa5C6ek/BD4aCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uq0Gf0xQGRdgI8HXY9NeQONTBVGX1PmeLnlktqkUT71JVdUW/f1wP7F1pb3TJrJzlX+tb6Cj95XefhqAUXyPGZVpvvP5if/NgNqAcUPIgcUaBt2k8jFjGOQM1iNDYNWfD3qQkhpNvSUeIRtzzCtjzkAntDEmYzjTh9OcF9IToLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZyHOKL3h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EE07bxKM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BULPILd2551611
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ux95GdgAy7hFfesGPlF9hWlnbmmD5+m3uisShSQL5Is=; b=ZyHOKL3hcpp7i4qp
	0GIrq1tf5hu5F/14rTt4lUV1lZd0g/8nefz26aBytS+Bm3VE12Jtjnh6syzFyadx
	Bco4rsrmgTZHVZGfIYpYM+HNFdznF6j8Xs0eMNQXsoq154cdqvALhkqxo+FV9+8Z
	M65IziGfNfQlMzR6MldybzIwCh5CzeSPSMAg/hMVIBmhWbVzMoUEHC5DThIVpadC
	fPoYi9HvvEkzFZsHuktLdol239sG5SmoBuygBI439pVIpIdpcKMLK/ZD8Y9UXmDg
	LS8zEID76r4fhShzaibzWnFPVW8LYRx+YpyEVWtFDVCp8Z5LuGoxwnA3+w908wRu
	4q/76w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc0skk28h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:25 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed79dd4a47so226365361cf.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 15:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137785; x=1767742585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ux95GdgAy7hFfesGPlF9hWlnbmmD5+m3uisShSQL5Is=;
        b=EE07bxKM0Xa0PwrTaF/5k+J+jnvTJmAWXF2DVELKMyhl3yNz1d7jTL4Q2gprbDUzaw
         AzoYP+Tjd7z6NEky4ZhQn7k+ldJUVBsKZhfcP/9wNnwY3T03fqL3Nt3vrCi3ivogt8Pr
         kn5QqFQR3IZ61QDCNsYXnnOre0vzRPqCq/EWEKiSG3BNQHV3fSxZ9552wLQd6bbAXSuO
         hBD9B/TwZO+siaLJ2oV5SdE0Iq9fyD28/ZBa+q0bSOZyC08XNbkCau4fHjymajM1367e
         vedezsrzRICuE/TS1/ZOoXuG71wVcm6aitvwtyVBdKPuO6vT0sX8pjNB0s3GfRGoKt3w
         1ZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137785; x=1767742585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ux95GdgAy7hFfesGPlF9hWlnbmmD5+m3uisShSQL5Is=;
        b=Pu0wPggEbyTazJunNU5v4l+kuwUR35rd9bkohlKsCyX7uBRSere5Uf3QTeBMid2ylN
         srGbBb5tpnqSmzN48qYxutzyv2GSjuONcj413skuYIZQkzjZ0/b7M3pSVgOg3nCbXYan
         mGjm3bppAiT97aOIdmzvl0F5G+/bCA9r4JKjeubVoqCWJJJ7eApJqNsWX+I583WWB5vw
         IYnnnGHogub48PtL2Al6fikk14aXhEtk5wc31ZCFRY609FOM4pHu7orDWCy5I2YkzgWN
         nIPdfCYZba4Pvs/rdlqrdjLH9kFx7GBDsy5lMM9DvY9hpWw3C4I5xsaKzyKyIkmicwbh
         lnKA==
X-Forwarded-Encrypted: i=1; AJvYcCWXGL9TDcPA51q0OFW9W7ytk3n3pYDFXvql/5agsca5o1uUk2soMuItD8i25nj3W4eje/YYs12kI5kSMDZodA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzibMDakXyhY9LZeDqz7CbfZTBa3H0wU2BqSubDcCt1CIPFPRG
	JEDVFvn2t3pB9uunmCy/vOyDl65Z6sl5p5daep5DxDmWdgrJMz3t2Iwl5pBL5qCC2tCHHqvn/qB
	VEltfWT9EWxvWnhIkj1U073vEbLD6KwCMh6Sc3sHOFUyuVOSx4u4V9T9OxkF57VPLF657FA==
X-Gm-Gg: AY/fxX6Y/t0XEiaRmsNu47isYvPHlK+pwLYOEstGckh94XuifXtLo6SrXee+vPnWze+
	7tlKJDf4h9D1+1zzafBgQXctXD6zA1liOlEIDFPSS/2+F41QOHBrLG6XKTl4JuS+e/ksMKYaS21
	tK6B9eMjk9WdpIa9h891fD3TwCy9V71Vt2vxsoiD2QSQJz5/kFMg4CnAjAZWU4TJX7ch+TbtRiK
	TdjaQBMg4LRuDlR4L6gKOnQsWAUpg+S48TJ1EOFFxi2uIbw0SvY80IPseQkUUAQD+HFIAheCgB5
	4F4xhRaZeoGqkwl1l9/M/lutdnDrMPqPfqOP9Nqi1j9oPO6FCoC2CQ+WC4WUotG9AmAZzwwnQ7H
	bw/aAiinvjkjRlDYiYrY6pAMmuJ3tazUIp36D9u0aRfPS/UVZErrmsHl0o6pbMAsYVFlWR/XnXR
	ZDU6t77QB6Evt0FkcFts3FcgQ=
X-Received: by 2002:a05:622a:cf:b0:4ee:1e95:af68 with SMTP id d75a77b69052e-4f4abd1da6cmr579228101cf.36.1767137784785;
        Tue, 30 Dec 2025 15:36:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgR39HskKDK0VPENv4JCEhQfvh2ZibF0b4cYURAUkvz8grVJGOP6SkuWxVIrZPWDN84BJ6pw==
X-Received: by 2002:a05:622a:cf:b0:4ee:1e95:af68 with SMTP id d75a77b69052e-4f4abd1da6cmr579227521cf.36.1767137784225;
        Tue, 30 Dec 2025 15:36:24 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:23 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 01:36:04 +0200
Subject: [PATCH 14/14] arm64: dts: qcom: sm8150-hdk: describe WiFi/BT
 properly
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-wcn3990-pwrctl-v1-14-1ff4d6028ad5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5614;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=8vfZDA0+eLe1oxx8QbS4fcx/NwTCXaa5C6ek/BD4aCo=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ2ZI4lN9j3hTM6s03asXMy9bNyhf/3Jm0nFG5vitli6Sa
 uVTpuh1MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAi7j/Y/9nxJ+x5+6+5R6ff
 MV49rT0kL2PdIhaH2VZlUUnLHK69OHCxX9Yy84FzdMWOxBeZF5iPByeJHfEVNX883/XVzW7m3pz
 D4lmdy0vjpi9N2xrGObuh3qfDMVnv41qJ/LfRt1UjpQ88DTQS4uuatfr+3SM7H6/dEyhWyfHQmz
 fU2bR5+STlbaUGN+24P3D7Pe0svnVeVFQ75mx2Ss/WdY6H/i0I0Q5uObJ0xrLFrrsaparUtOYxR
 r1l97zlEVC3ILCVtZtLIY7hom720pM2a0y8Hp5bbXa+Y4Ze5tz9ReuFLNfWORx2zJl1sHzZXNbw
 Lmv+mTbeH1g/3TzCkBna0x3w3Jn5XsHuIpOW+G2l+hkA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfX5vCH5oetS90K
 UuTH353/zKmxRE06iDsy4jC6Mf4bVLH1CMDO7sWw5Ov2ZUGnox8dYBmP7pTbyVyi8xwqSt5EiLV
 sBJN4e6NpPoLwvbTIbLtx8TzIaKXIi8HkycjQK8v1AzA8PUklPmlPXP/6fJ648My7alF2v8oJqo
 cVQykdR1Di69omfdspAA++H/GhEF8m69w9HPBxNO0UUMFoWu9SxlRYyi3+fcWJjl7a0h7sPyVfG
 YsZWskgU790oCnFgTEZi6ffey88knuqfnh6CK/CV3zHprmlizvqMc/riDSBzFWv2F6ceouoIqNs
 RU+b5Ee8BWZyemhsW4u59OxAXZ09M/KF5vuRHkCdh8XQno6sLlg0VQ/ikw6spLt4vHxKabkEvTs
 6b3EcldZTQQhwX307o1NSUNZsROCNyCBWg9/MeP8pT2r/rrhxywt2HjWOODuIYhwH9JPt9ds6b7
 Vl1fsrVzKpu/2fqQ+2w==
X-Proofpoint-ORIG-GUID: _9D5aU9YFFSFXQQ9SLeEQ1X-BtJuq3Tp
X-Proofpoint-GUID: _9D5aU9YFFSFXQQ9SLeEQ1X-BtJuq3Tp
X-Authority-Analysis: v=2.4 cv=FJ0WBuos c=1 sm=1 tr=0 ts=695461f9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=daeKR1c1ZtUuBhPExssA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300211

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

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts | 141 ++++++++++++++++++++++++++++++--
 1 file changed, 136 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
index 0339a572f34d..18b51a1236de 100644
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
+		vddrfa1p3-supply = <&vreg_l2c_1p3>;
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
@@ -594,6 +632,10 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&qupv3_id_2 {
+	status = "okay";
+};
+
 &remoteproc_adsp {
 	status = "okay";
 
@@ -626,12 +668,97 @@ lt9611_irq_pin: lt9611-irq-state {
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
 
@@ -705,12 +832,16 @@ &usb_2_dwc3 {
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



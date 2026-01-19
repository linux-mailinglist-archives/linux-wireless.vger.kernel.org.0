Return-Path: <linux-wireless+bounces-30976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 532AAD3B41D
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 18:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7635331502ED
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 17:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B9F38E11A;
	Mon, 19 Jan 2026 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f+48wByP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eIlUPCJg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B7D389462
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842502; cv=none; b=Wj4OQziLN05IECtDYwzwnGtevWKxRo/PskXNAFlnI9AjnL7EpYjVbzIaepqNC52u5TR/wAiynPaDxeHNHDw/yfI5XxOzcgVtWVeMFwK3OT3fbYhN4HpxOQ9rsC3EyczaCns3l+3mHwFzcf03o55dEXGwr8WfMun59pSXn2fSPW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842502; c=relaxed/simple;
	bh=q9y+Dif9HlWdcnmMDM5hAVRBaWF08BPAccXmvU/QVEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WCD1CjINeHL77ix1rq/I5NWPlx6q5rX4M861t792Z56y++Uomd43vxKeiaQIZSFwu4z+Y25yugnB9Y8slaFeMOsfz38e/hLY40FZd/yY04G0M89byqbN3Hpv4tAk2ZXhLVegrLNVoXoZepBootiraDAxZQFuGWgezq4D2R42Hus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f+48wByP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eIlUPCJg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J9nHSn2966034
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 17:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JO4Pi21OVHijpMNbTgyCYWdKmobPiE/rHbiYvQZIfKM=; b=f+48wByPlf+opHLs
	gY4ySKU8LbHbYfXr2GoJGFQGupH5cCyOJ5q1VRzqkzCO+S9C/U10Ee8us+fHco0x
	arrDfJF1xBzLLbMaFdBzcwyBg84ONmfBAfeisD7VW8YgGqQv326+zB7SXFuQQJ7B
	8hVPIPf44hX/iEMn6vSyz+RrozG5REyHJMggXxOjO6gaYimTRZKpOR3ATqhnnyPh
	LrrCUjnwBvT1fcQCyWYRMDbB1re6QsT/bwqCGWMJwi1Pd9vTI5Y6/WWZ9qTepsL4
	sZwewb+4Mh9e09EH6wkORbLIPPyMrGQYKXgf4APiEvQDQLVwVEP66qRa98NNQvTs
	oEvKUQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsjaa997p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 17:08:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c6a289856eso891998285a.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 09:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768842499; x=1769447299; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JO4Pi21OVHijpMNbTgyCYWdKmobPiE/rHbiYvQZIfKM=;
        b=eIlUPCJgMqWYR4GkFiC2RNbNlD+zHT6S0F3RlJZ1r1nyEk7kH3i9nBpf+K6fPNUIdX
         u8byY3FqXemgzxfVBBvTNXtmvpsVQx5kmc5prLvucONtO6JNqx+V++6+UkOnyq+axryF
         /sxz3DFDn7e+R2tkwoMvHVLN/4xoVB18O8TyEphbEAgQqZi/8TtXpwpCrfKKOWYAvtQI
         gsa3LhqLZ0pqoKcf+Nj1k5ISXeCeUCzXYCgtaWMls5UQ9xvKQ8D1sWWkeXTh19MLIcB2
         YozqPxCqrrMAnqZ5uS5Yq2tZBqMozqzT0OVpd85mqIPhIytuSEL88hY0Dk02XEzLuYAw
         v19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768842499; x=1769447299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JO4Pi21OVHijpMNbTgyCYWdKmobPiE/rHbiYvQZIfKM=;
        b=EuQjPYrfiU6VVGcEMeXtK7p6EB3khuev3tq6B8KVqXwSJD/vdRJTz+RirSnXpURb0H
         xaFSTCa99tcznqpmAErNEVMzvnId0Js55UNjyERwDoi9lVrgP1J6EH8KaX3RxKVLM33l
         fpXU2O5RKA3YE1pv4gn0FL3nEo6nti73yIdglOGHy2/vCplpvzZeXynElUSqBC2LIiTD
         qWjsFMi6pXXA+kj7Dys/nprd5FjsCDtw1k5Yh2+Qw5rMdmWZn0GmYrJ/RKYrM1HDXiFi
         CHHBDJ4a9x9QVyBzchj4DsGiKE4z1JQxOH1PRRHd5Ry4cnGXyBJm3nQCVE7NiaaPyquq
         K/8g==
X-Forwarded-Encrypted: i=1; AJvYcCVoOXY45mZgQVCOti4gX+SVDnLfkpeOTR3yJ+v931VnUh5wPo2eii+TBhU1Zr64yMHTHB+idlu/7pa3llnuIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTAz/yecKFiOhgnzaK01JS32oesUPyfD2X8vAUCagn7xfDTVay
	GCiC1wtQnAwDXm0Q1Pb/kNDAIdCtJmOPwrrJMjk+IxqxtWn/upfcYCULDAKNeh+CQIZ3YBAJuyO
	hnjH5VxHZxZpYtSOX0GN/gxO9C9eGGvDhejunBE+HOXXJAHw6KZC7L/zja8jTgFgPoXvyEw==
X-Gm-Gg: AY/fxX4jCETsDW2HMU3A4M/dSwpf0iTDJb3qx4LjzQLZdMb6f98PbOQwG4DM2zlioga
	FWV8s1DWXMdC7ixO4WoSLIf6eIzyImZIWP2Kxm8HZBj2GJ19RjqxKwMgmSteC+TSMYgHNhhgHn6
	odz4wzZityc6/l+bT4uBv8H2hxPKqLZ50yldyJjJW5Fz7hfojASgmX7IZorJBjSHtc8U5C80Rqg
	o52zzzyq7nDxc4uUaZT2ZUu0B4EDYWrRxpcPuVTNOlTmYB6nZ6Xt+5jZYPtx7T+2WhOa3w1/EQP
	+ecsGKYO9c6pHQIGqnHtLlI5E4WzCQpDUY59+Nj+yTljONQD6etGA/hzb8HMnfifC4SzMlttLiq
	sYdd50zMmeRrRy4I9v1T9jBaJVIxNmABusxF6JBabvqV6PqoGe8P9vwptlNqUfmhjyf3VIm/+LX
	egaQ5i7ciE6br/BvBj62A+7II=
X-Received: by 2002:a05:620a:31a4:b0:8b2:62ae:acba with SMTP id af79cd13be357-8c5919e2319mr2036783785a.26.1768842498533;
        Mon, 19 Jan 2026 09:08:18 -0800 (PST)
X-Received: by 2002:a05:620a:31a4:b0:8b2:62ae:acba with SMTP id af79cd13be357-8c5919e2319mr2036777985a.26.1768842498023;
        Mon, 19 Jan 2026 09:08:18 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384e790a9sm32661211fa.26.2026.01.19.09.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 09:08:15 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 19:08:02 +0200
Subject: [PATCH v3 8/8] arm64: dts: qcom: sm8150-hdk: describe WiFi/BT
 properly
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-wcn3990-pwrctl-v3-8-948df19f5ec2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5744;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=q9y+Dif9HlWdcnmMDM5hAVRBaWF08BPAccXmvU/QVEU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpbmTu+r7ZJA1o77mk2TpRuSO15tDHIS8rMPkZ9
 kX3ms7qDI6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaW5k7gAKCRCLPIo+Aiko
 1dcsB/0V5kFzZwtHIqSGvv+1cFQ8ebww+6MqvikXSDrDO1RMot7omECcZXXVKK2xgqClME1XrqT
 X2sAqb7wgrXIv86pjCbwJn/fpJf4yPriyW2iHXOP49Mv6UN92sp1Dd6vRLouPWZQSmpm+yVJR+x
 nqSsorYmy1qjR4FdBIw0B4deuluimVT7jG3zH/Y0hWEbUJzWGSq4IuhzJIx0MTQ3mNrW+M0n6qp
 hmvZBWBcI4kbLGIa9dqZjOmn7zDqLCYoktL1LL8M1Q3KAagSRys0XecyKNC+3iOudjL98q8BByS
 YSAi2JLZSTtoRLu69lpwNfPGxWEtMKOxuoSj7f2gYL6ORUFV
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0MyBTYWx0ZWRfX+PlSeQfW3aYV
 /vA07OIo8EXs9usrUDPWMmw1OE2VmhX4LYTAmtZiqctIbP0+MG9gu44i+2B+3nGemKkzYwxkcXu
 YPgIdFIyFIXJwFEZFGD+phOi2UAqViTQYqb5Xky5UN2Ih5GUDtJfQ6OVhLZthuyf/lIdBtCDKWk
 GAlv7ISEX85juh2YvjiJEfZ96hRRnaomvRXWx8UjhnvQklQAMuZ6WCp67HIf5u5OV9L1cckBy8p
 pS10JQR8+Nl+cKnGU8bVR8ZHGr6GNeNCfpYLztgXMOY6Bypb+dXiHtH6okRY4N/e4TN/DgSAu3l
 j+9mVUHndM6xzeQw+JPyGEs+ozj3uIjbz8K+QA+xoOGXfNZQ4ZlEDCecv6BXWd8tkjPe/2FNAvn
 mVm5KhQaXMkiW/mpjFtFE1neabcUAx77S3ie22efLRQ343n/uKtX/sC3ki/dQyUec2/VGQm5Wo3
 cdjRV0UJ0jHA0meUcww==
X-Proofpoint-ORIG-GUID: ilXRcAvjO7Xh8iNViwdeqj1EQO4e8Xl-
X-Proofpoint-GUID: ilXRcAvjO7Xh8iNViwdeqj1EQO4e8Xl-
X-Authority-Analysis: v=2.4 cv=L8gQguT8 c=1 sm=1 tr=0 ts=696e6503 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=daeKR1c1ZtUuBhPExssA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190143

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



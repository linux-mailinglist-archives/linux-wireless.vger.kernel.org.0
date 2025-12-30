Return-Path: <linux-wireless+bounces-30192-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A0FCEAE5B
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 00:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65B303060E52
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 23:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05361303C8A;
	Tue, 30 Dec 2025 23:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uz5bxghF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DizC8ebk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2133F2DEA89
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137782; cv=none; b=li3qrJA6G87RtJzVfkRbtC3IAD3HeBMGDBS9ScGc9M83ZzUN2Hf/t9Yf+hZ1mGpM7slt8AhZeotTxhtWL/wWRS+Ci6B2CJDhEX5Anzx55zySBiSZmz+wBeHfE6zsxmeJUIm0Q892W8oCHYctQgpsMAD1Mda34uKRwY0yAkyU4Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137782; c=relaxed/simple;
	bh=EjTShN8dVXi1WOodHyvaBSpGXyNPhP2Q+wFwV3+ERgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oDW/7H0th4iVh7sxMPygXg7DYt181dRHgqt6Tird/f3mT06j1uLgR6O/MGd9sx3RYQ6zudLUjzMEoJ9E5UfzGufaQGtV2pnYrAUOgn+LS0J2u/aIPulcKzhf00ErZlDTby++JYN372apj2dVMv1k6T8ONhwNzG1TLe0JksXwuGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uz5bxghF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DizC8ebk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUDYC993555736
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wk/UYrnnjXipaBXYq+cjJDLHcQI4ENYT28LjgElhlps=; b=Uz5bxghFa+jtBFKW
	IoDA2XsQZUMCDrzo6flSzVSEKzTo4IPY1NuyFnKtSgAIMZ5+jKBbcv0MH2C528d/
	SmHWNbD2ep4LldxYBX2smVzeo5nSdV2Wfl/VEtDgqI+tAxxQTms4kMYcvIvwTjWY
	Fv6QYVtXmsXfoRrjTCr/Jx7QRKUVGIoNKxUo8MRgPY88EwNcDvsfCELIeMIXYytU
	TMC4mmqPwT8ugKAUtBZHVVlMC/1n+Pe+xIVcr/W40tK8NcgMaKMlwi1Y5OijM4d3
	IUrgxL8vJJ7E9qalneDRlmXo1ydiF1NxwJlL+OWl1rtfhgKzyzCUYA6gL0ZeXmDC
	YvDF5Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc7462cp7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:16 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f35f31000cso142435231cf.2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 15:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137776; x=1767742576; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wk/UYrnnjXipaBXYq+cjJDLHcQI4ENYT28LjgElhlps=;
        b=DizC8ebkNXb9TYMdZh+q0XB1Ae/08E7H75as4vK/Tj2kfc7HbtwYc7pMqdd5RZfZ5f
         FAU6pSn595ywCF5q/ouVRnOOt26DTFTFVhgsyFDa488C8sWKO2FCOQWoek/E1FK5YsAp
         i19IRQIUE9aqmveqpahTcNMc7o7XjRHQZHZ8j1r7M/whQvJFhDfiQ3IvN0QS9nB5v1oD
         XAe9DUdPz8WYKEcQs13lBBbiNMZN4tGxhoWj32IXUNJ4JpNag8aGap6GLyhVwdK3wXZp
         tFy6umIoYm9OmaFg8ztZTZU/gk8t11zjszxtXk1uTTObVWgHneGiGSktiyOtbIZcdSUO
         ClzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137776; x=1767742576;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wk/UYrnnjXipaBXYq+cjJDLHcQI4ENYT28LjgElhlps=;
        b=cOK6vAngKVMCIW6mh2/7UEwUSo/trqvIFPpdzzxHQ3qTypAq4Vwh2d1zdvmfllv7Hj
         xXRXrVZp7kXb9dS9gZn/XBC0GMEULza3Y2w943MWhspVRkFNQTxR2BVnfG8+/KZRLQ7X
         EcWL0oBweFCloVT7hS2+YEGOB6rwVMtml6NfRhTol1rNj7TTOoeKwAxt2cUwSrqEXSgL
         2ONfIWTyKk6GZhsLpAcrs+rzYr9Xzc89d3/AqCDKgVXjwbbhvr9FweGWkW2C5Tjubb3t
         tEzks5RkIdzJGscCiolo7vN65l6ALComBKipzn542TY0h8uqgdU6YuUtKfaY1Kz+MRuN
         Dd7w==
X-Forwarded-Encrypted: i=1; AJvYcCWq/u8YXDrbc+ILl5usHx7d0R1cQ8PLBzfZj81mhxcubJ5aPIjUci6t4Yg4azxj7N6k6MLizmXeh8rZJ1aOgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3qa9Dfsp9ygQhtagBKJ6Hzn/GFy16C19oJ4j5rzNCwZ1BdqEw
	k9kOtN6r0Y6DxD+rrrhL4KFAzrWEEQtC+SC1lAUHqAhuRCBzjhQywfJTIU0gPF2cCKCkwQncjEh
	rD6EaRXeHwhGvH7CYzia8PwGVxFbX5qJ+uzGLnFIA/SvWVyJivRW+MpSFoFBbgJHdkzRqFg==
X-Gm-Gg: AY/fxX6i/Thd6UAmMzCJs6Oh5h93p6dZv2LbRZ4cWA1elQyisFSApAgZsXyXu+oIc9U
	+K5LjOavxYpqKHGUpLoICFaNUfs73T+79Cx+KFcVKrdYVHxasG069JKE0QZLynmRLI2GVWx/sk/
	XUv7olNeQPSfTWn+ux6azpHXNo8CN0ZjjYAoyfE1yvZ+lzAJbommPuYH5aSL53TEhyDqhDrX71h
	Xl/AH1CbiBkIw5HkGgqD7Lzniq3l9mGCMZ/S8fQFC8cyxNb+jcEkPNV3LXHo44bnGRmWd6wabC5
	PxSYa7X1586PtGJPY4JB5I1GSFh8iryZUX4Aqzwij5eqiG5McFalfvTCjeMo/mFPPMhHwLsaicQ
	VK7SOPj1LS0YuCPHNgJKiwMzFT8ddlhm3/BesXQ+3Ax0guXA3hPhXCc+aFoWL3pjgPJq7ImTonx
	rTnUm+ii02T2IHSxu3QlIbRWg=
X-Received: by 2002:ac8:7d8d:0:b0:4c4:6b67:ccd7 with SMTP id d75a77b69052e-4f4abd8142emr556975311cf.55.1767137776202;
        Tue, 30 Dec 2025 15:36:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeHlzNHwWVyNiGrkZdVK9sqC0WDCaSDH/a1Qm9AsXJCXQ2gjEF5zMOFMszSi6RF6Kpz0yqFg==
X-Received: by 2002:ac8:7d8d:0:b0:4c4:6b67:ccd7 with SMTP id d75a77b69052e-4f4abd8142emr556974561cf.55.1767137775304;
        Tue, 30 Dec 2025 15:36:15 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:14 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 01:35:57 +0200
Subject: [PATCH 07/14] arm64: dts: qcom: sdm845-db845c: drop CS from SPIO0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-wcn3990-pwrctl-v1-7-1ff4d6028ad5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=953;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=EjTShN8dVXi1WOodHyvaBSpGXyNPhP2Q+wFwV3+ERgU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpVGHkSBQ04fZj+gnaMzS5W5ExjJFumBCj37eku
 0e91W+btOGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVRh5AAKCRCLPIo+Aiko
 1Y1yB/9T2MJ50lAxN4Ym0ghqy8gq4J89OST84ANmpJsQq9cplqyWHEvCVx/T2VbwkWRlA/UYm0q
 4/g5GO+XzahA20G/QYH+jZhfyMlXbk9IIKMqSTL6cm/HV5UyyxH1mf+DNGYTGQK1+WzmT+b7ttl
 itCNZGLz9atRLFBp/AzRaVmYxzSQkrdNN1PdUtMLFLsHxaCBDZO1BgQW7Zp1e+JUJMEMD8iMXpL
 lm3OELTeBy/npBOI1Nz5DyLicQEjQukdWZfWUB7nRkfGjJ/v7FIcqQYzJmQLOlgsjGxat63qWbb
 1xZL3SvRz8+RgPhN1OkpsLwtLB+QmBieIqcz+P7G5tRqEhC5
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Do9bOW/+ c=1 sm=1 tr=0 ts=695461f0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Vj5tKrsnPMLlX677hvEA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: iGw_joS1SKQoW18kcSG9CZE4nCBpYCoz
X-Proofpoint-ORIG-GUID: iGw_joS1SKQoW18kcSG9CZE4nCBpYCoz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfX2T8QbFe/SHyn
 j+6xoBD1I+S72t8fl72GfP9NTCZon6f8ChduWS7kytDJVvR2j+g7ZvFylQyhcIiSPD7gumoBgsu
 1Leb014KMNHydKX7vwNqbrHl7LnSr+luvbspEIVwU8IUI3/Ab9+KPiRRFsFMfT+ENMhE0jpp3k2
 n5S6+U24xAOKmgW43BTvv4nfQ0T/LixmIqDEpnhdRht+CGOnNb3HU01wUUMiFFnO8O2vkZvx9MJ
 Cul24SC+xwfGtoRYxa2ZMK8oCF1wIx/72mr+dC9hMnIKtc3b2rPmVqNe8b4QV7h+A/bb8pLbR1P
 2bqa1N+FqQpHOmmhOcf2hSSbesrB385d7pd2p0VSvZdWhyyrWTcfDBymYeq5UiR660RgQazbbrv
 3i5GwSUL5jVcuChNA32VmMB3MlT7z1IoQJNs6c/9DlQ141+/GGwQp8ks5QctTmqMOEn0b2VacAQ
 p7aTNRdftnRmKbNLwKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300211

On SDM845 SPI uses hardware-provided chip select, while specifying
cs-gpio makes the driver request GPIO pin, which on DB845c conflicts
with the normal host controllers pinctrl entry.

Drop the cs-gpios property to restore SPI functionality.

Fixes: cb29e7106d4e ("arm64: dts: qcom: db845c: Add support for MCP2517FD")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index ce23f87e0316..ad283a79bcdb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -850,7 +850,6 @@ &spi0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&qup_spi0_default>;
-	cs-gpios = <&tlmm 3 GPIO_ACTIVE_LOW>;
 
 	can@0 {
 		compatible = "microchip,mcp2517fd";

-- 
2.47.3



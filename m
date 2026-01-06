Return-Path: <linux-wireless+bounces-30374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FC6CF63F9
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 02:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA059307E248
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 01:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117C131DD97;
	Tue,  6 Jan 2026 01:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fCx6c0/g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CzVJyPlJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C947B319614
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 01:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661305; cv=none; b=c3gkrZMDGewk4K3M7r+hr5S5T4XiqFdnATCT1HOhoNNLeD+oo7XzyGbeoND9mXomj6Ae76hgg/0cZzpv4lPvJ1fJ5e8ALbrk8cSNJHYe3BFXI1b4jhfz4jDyqc6lqBCYJuD/WYitZqOK+XpvPgUu6jf0RsFnrGiLM4lDwcShLPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661305; c=relaxed/simple;
	bh=R5YT6nb9PgApzpeufYf7gthWk070NxoF+HtPuCCK/hI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qo47PNZPiJYgEZNO0L1ReYbHU0Mx70pvbPFZqisPN8spfk2ohHMY/LSG/51hLwlUV9/eg3th/CaCfe3fbEbTizhLedM+IU2ugN22943GmmbZ2JysRSj03c04G7+PmxgbvqY8AnoEmxELLPNl7vAc5QJ6smGjS+MXmY/s9dYOHoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fCx6c0/g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CzVJyPlJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nNdO202716
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 01:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5tsd5DKtNLlMZcvaCZDHlRAYCf+3uNDXyfWJlLEmAqA=; b=fCx6c0/g2WBsHU9D
	9p6IP81MxY9kSvJgZnSqN9cy5nJzlR8KohzvSq5yFpUHfOPsPdocZEN+Oq7UotJZ
	d67UGBQA1NUlfJYPn1lm3WPExfnIPhVYUYnQq/zpvuHz8R4Cafpq2mox16x2Xyft
	ClIvP+jK9WjHWlNbZgOKNlUFmRXk88HD6DSt3uWnGB4z8JzpMXiXss/cqyIt/jx8
	8R6WDHPGrWur5thjXdZ+K8orUUdpynkwQ1Ixsh846aeLpGuJ+Mb3MC+H2SOFw5L2
	r1tIQKwOpz8vB4OWfDNJbw/kcUXoqXdk3rCfYflveOQMZXU4Kep5ACnjPyn+XmTX
	P4SIvA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bggqu19g0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 01:01:42 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9426773a207so1389452241.3
        for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 17:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661302; x=1768266102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tsd5DKtNLlMZcvaCZDHlRAYCf+3uNDXyfWJlLEmAqA=;
        b=CzVJyPlJ/S1zm+71hJSojK1narRa6x2qaVesKUbdtLO5hzqNHx9GSTy7pCqZ0iWRxC
         WthrqJh2+An85GvUa8ecWC7M/CwZkWJSirzSaA6ZM3QvZJUJen1MezI0HFoxJ63uJgEm
         fdWzbtUFmX6SXvZEhB8AQPOc+0PALEDPITJKcytTcPSTa/hop9gzcfIpHpP1TRR9logf
         UAKCKomHZjcN1vLyMIRdjz8VQ+J5JtHFyQB96ZTsRkOI2YOV40QbIoFTvXVSzjYugQZh
         5tNwTII+5HDgFsHb25Q8bxCoP8W+Jm0W7uzbxW7kjYmIkV/N9mkeG+nm28CFR8ptnZuU
         uj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661302; x=1768266102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5tsd5DKtNLlMZcvaCZDHlRAYCf+3uNDXyfWJlLEmAqA=;
        b=wgeWIOxLSHv/KatwNU5hWALd4+lMI9U7pG6CSa7yEHWB3XPWYwMjS8bbp4KIp3dhZY
         c7CcSFVeZw5xu7PgLEaUEE7YgC3jnMDiJhSZ/q4NkVMliAD01rZgkQwk83VHk+caqsv5
         SzrSJ1vZnFCf9NTXmJzHLG1baAQErQMQ7D01hOvRcyAhllHYF/nJ2sDDwzq8KGKI2gmM
         vYAYYHuKFx/vxGxaWblSvY2sjDY5Xypyj7vG5PeGRRAVFh6TFfw6Tbezffdyf/hQEe/m
         1SJZ4G6ENi6JG/S82j1liXkdjg9Fx3sPsZboEatmvRWdsFlV7JXjD2D2N+F9BJ6M8n6C
         HTKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIcLdEI5T8329AhrPBRQe2e3khfeQcYGtEJlgyJjdHEGSbDJrr2CAnXv+B9CGI6gVfwnQmWHeDa1qfR+s2XQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/GYrLZ8FJ3/5QkbZ5hUkNNgkA/3hj1lZk2+QD3Iwln53deJze
	X4HpLJypf3VMCnhlShul+/biMcXDiNYLfZ4AANFvai73WDcxvkF93GLGthqS6AbQlGzsKPRPVCU
	Ry5mezprQRRxveY/x1n33IisMBVcRumWptHuxsWNdbfQ5/1al1lYjl0uXnzZqeTWsBucDDA==
X-Gm-Gg: AY/fxX4LEL3ISvILmBhJlhm8HvCan7KscoJvxLeQ6/e3wWf52c2an52czfU7D5Nm+Es
	nHXvCjFQjSq6mTjpbaqvnQ1BYwWtNFmn0GUSxagJAt210vJoQBTFm5LY0iv8bTknzpDQL/cH0KO
	scVNWDkKarG0x6wLufWOUaf3M7yrGjwqwrhCBUeVPUmfKoNZF4G6mhnXIqD3Slb206afvh2jZT0
	hXgs5bFINJIoZP6/3RHkTqTRmWqvel6/133gcItXJoZZMvoQibgXi0pReKv0skQ12tHxc/aSRVm
	oH5b9ghTsPYyqaN7HIb/sOqSFMf2eOyz/6ZJyHluHxyAAXrKAvevS4YFkr42PhZaR/w+DFn8v8O
	jhQ5cHFolbZ2bYjcS52cTZE8odmgYrfeotHsUl7MuvOc5WoJxXr+sTZaaHkDkP0KfZfDWDs7arQ
	sARmPIrmaBGg2qnNL6Jp3bX1Y=
X-Received: by 2002:a05:6102:448d:b0:5db:d2b7:9511 with SMTP id ada2fe7eead31-5ec74574d2dmr443414137.40.1767661299567;
        Mon, 05 Jan 2026 17:01:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIchMWx6h9LQgm2INjt7jZLpa0baSCgZJT92LF35vomyPAvbZ7Z2gmXZvJx10AwyD/MmXxzw==
X-Received: by 2002:a05:6102:448d:b0:5db:d2b7:9511 with SMTP id ada2fe7eead31-5ec74574d2dmr443361137.40.1767661297733;
        Mon, 05 Jan 2026 17:01:37 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:37 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:19 +0200
Subject: [PATCH v2 09/14] arm64: dts: qcom: sm8150: add uart13
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-9-0386204328be@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=971;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=R5YT6nb9PgApzpeufYf7gthWk070NxoF+HtPuCCK/hI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7ZeuJ4H5kQTiKN0SZPAWoEkpvXEwqkfstAM
 oFfkcFhRy+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2QAKCRCLPIo+Aiko
 1YNJB/91Nexwnv0JCxYQ3fcm0Z58dhtpTmhbVp0CaGAKg7i8jIX1Id9ZsqWTms+2sxzJTQIH4QS
 N4J1ZnxBkCFvfGrdqPu7j1ZDCg+CDX8nTrhqbE2z9s9XMR76wucz66SU2ATTHyWLWQYds/CXlBS
 +UaRxS2wXRfA6g7p6JPFctX4oSTLZlzIWsSBBsghkm+83cuPqUfDsJNR4QVwakCDavScMOrhzei
 fVb+vuo1cE7Rek/+SDQHIH54zHKd7Sak6FZDYkKgKz/Enl+bMGwZ2d/VUZIvv0CtviWxuCCNMSe
 JIdsWh/wdazrpirurs3xLBof1CtdRTNVlPkYUj9447wgGBQD
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfX5aLe+qaWkWoV
 4MN/wQjnCY66BmnfKQUY2YSLp3vOndDqE2WM3p1wL0synnqkVcB27dJc/vmSATN/KcA5opi/59k
 BvoK+BTfWed9s9EMDNi/rsV5RsREiVZPSh4PSeuhhp/p5xyivoU2uRoFWGBNiruPIk0dlTeCI1P
 Y9RkkerOInhZsCsb/U63A2LzqdctkTLTZSQslS5sr+kLDwLlhhh+5q9FPo8QJFeUaQ86IwxpbQH
 tYuQiULFbdJnaJZfHIMcYy4xA/BN9+2ozp9CMFNXBkqjkeymC+quSEUHOKTet5G2QtNSpBkINZB
 K+qJnFGneBT9miNdEyacdxCEeZBDa+hr4spqUzQ9bR+VYLNDSo8x64d4vuy9Zf2ynbSQUDFEnLf
 YxdCfxR2Cnf5JNaLTp3IEZJn3kwyvwzHvfOTryD/lP/LQ8O469Lr+mjz0GIP9SnhYr3TzQ51UJF
 mQnOq4813vzuzXWEovQ==
X-Proofpoint-ORIG-GUID: mB9GU9IlHgMMYjnsOZqHx8D6HwFTtyK2
X-Authority-Analysis: v=2.4 cv=fr/RpV4f c=1 sm=1 tr=0 ts=695c5ef6 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=tD0gfWrjhV-l0aOYTiAA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: mB9GU9IlHgMMYjnsOZqHx8D6HwFTtyK2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060007

Add UART13, typically used for Bluetooth connection on SM8150.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index d36a3d214db4..97ca5275d740 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1693,6 +1693,15 @@ spi13: spi@c8c000 {
 				status = "disabled";
 			};
 
+			uart13: serial@c8c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00c8c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			i2c14: i2c@c90000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00c90000 0 0x4000>;

-- 
2.47.3



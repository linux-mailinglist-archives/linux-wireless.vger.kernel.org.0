Return-Path: <linux-wireless+bounces-30371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFE1CF6395
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 02:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E37BC30B902E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 01:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB0B31619B;
	Tue,  6 Jan 2026 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aMl9wn13";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="brQWE3/o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8E9313277
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661300; cv=none; b=mUAumBmehgqAI6vv6GOfEaow3la0nRTNOSUlHQ3crPI992owNi0O/u1rxQIxhrl4U/HLq0mfXnKHJNRN/fpHMzRl+zst8mp8HqQPLtEnRwHYS9tRhZdi4Jcw0iJkU8LzfuCiH/UJsskYMbM+zd9AJ8PkQpy0BGN3AZwkD1vWpEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661300; c=relaxed/simple;
	bh=Sxwe6pBBzgKc/Rbx3hGlBLXglP8Dn+Y8xXV50hDaYm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tY52yO3XqqNpBj2uSDVbsToen/5i/PUpxDriALmyTEiw1YtkCk/EFv1yysOXNNSQeZ4RyIp5vTYwTvjUR6m1gQebYkIO0H0JkDkotjo9TAPosw8sZUUCoRXQ4lG7OKRidAVmqkgfaKFFZCPk4DDLH5Qsz3aDqzOvoUA5wVCS/XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aMl9wn13; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=brQWE3/o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060oWVs2107267
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 01:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qIHZTxnOdazQFGAJQSxqsY8ozTjZjXZSimhBE4+TrtU=; b=aMl9wn13r2pa8iQc
	y5aGy7bCAivl74SpmiNNqY1QPMmnGAr/jIZztOwzuVz2ne1Foxd0c1Vm4a2qlWtN
	VjAtWDfj0yitBmaOwJBEc3u9vDK8uCaKoTCDQ3T+2pUMdzphj2tni+F2xmQf7ycM
	lYCoH76UOSv3y50Ty9kIVEMRcQsv4CiZzbwrQ0q8dZ7mY6ITEmM523AqOoDG8y/J
	6KcUIzgxvpSBdjEvcH/C4kk90HZXjVG8av5Xzla93Oe37X0FH9AFtlyVieXFwBR9
	WJlqmhB7R2/XaoSxeXrj5lsIukCnvEmROEiUmYcx3R1xuJJTIHEk9R+eqEFIdB9y
	NZ1zyQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgr7380rv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 01:01:37 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9426773a207so1389266241.3
        for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 17:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661296; x=1768266096; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIHZTxnOdazQFGAJQSxqsY8ozTjZjXZSimhBE4+TrtU=;
        b=brQWE3/orSr7mQiryV26FRyiOrN5YXEFa+vwHhHgSHirpy+It3gv7vZPSJPo1XUzdy
         kh6sTVOdFO4m9cWsXy2txYOF59lXydX/KTPdCQsrHoN8gkcUQX+Vm3IWUxAH4Np+KJq4
         ++P+0M41dhSMJqv20LVuGjv+kATiOU9FFg3pjraoug0lx09qCq3iYxcCjYG1TWvFhdCr
         pctV9hkRj8tzJhDHrnYxXZFaeVB9b0sDMKxZTuKpVTe2fvgH/Mj4vju9GXjJssN2r7hW
         sVME0+FDBbZnAJizlZP+VOeyr3VqcjLjHwDEkw55Tav71QgwAgJllo7UmjPRhvJ4qz1q
         RdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661296; x=1768266096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qIHZTxnOdazQFGAJQSxqsY8ozTjZjXZSimhBE4+TrtU=;
        b=JdvVde6ObGp2EvX1OY9/l0/Nx7CWuPFm8gmeDcKFsaU/eY4lxNaASFCmfzje3wBKvL
         M/6tNea1KX/WJ6BxoIODGuVEszz8Z/c8zPjXA59dQgLGo836ikj9jHHxhFTt3Fw6LNA8
         GNVHtdI9T+EYhQuUz8Px6ncIHCfkm21jTrOnjLOvjsGyRLcVaI5i5ixESgyY/dI/BU9G
         kYxWlQS6R7KYVWwU2tRJc7HU5NR57vIOV7l11glc2YMatGY/qjYi8e1/uVhtdQAikdj6
         TapHyemo1qPrXYDKZSsivmb0/pbAACGBJz1PG12bqgXqac/rW0TPGPdQzsIEDYD/+p4T
         8LfA==
X-Forwarded-Encrypted: i=1; AJvYcCXEgi+mzkIlT4ZNL02IufA+25W1KuzZ9vP/QXodbnif0j4gySkwcCljwCUW2fnjGnggTBR/57xUUC5UDqaVYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMUEbeUsZkUfyLWtLQz4bSnL9iFekNfSd+1ffcxTYdfN/lnrXr
	PN7yc19vmxPhxSI1Z2JKdz6avyYZc0rb/pVmhYoo3xjMml5T79U1ty8P0p/99AOhGeYkIUiRXzd
	8hz0QQFwZLNp+dunvWdf6dqogyMsKpFOKlLX2sP+z3nLIp55mb1pYRVYUtfCtk75cEoJWXw==
X-Gm-Gg: AY/fxX6/FuFJt7cMSYMGKoMVu3ZHFkvSnon1t3aSPOuiulfSM5vq5Sj1VV7aFXx0UXH
	PEEhZgl+SnxbrPHMGtEzMR23rsOCzLBekZbiHXv7QK0i7oR1g+/U4sqmOUpH1E8neO3JvG1p0y/
	88nJDAjEQQ5nrZ0bkfFR1179n56iYKxXAQcIeWu+OOaIugr2yYOpKa2kW6B7doSzNlOrUnjQXph
	hPJcVgVEVxMoqTpavB/MDIW75Dywjpe7+PUMAWmrVy4PZXJV75bjLqtrHS9oJoG+pTmBSi/MU7l
	dzgdSPSwsmhD+NV/Qmof4Vk+Is6P9aJAAs7ia5I/4UMiml6AMtaxBxo4yqsSXPVm6zJzaZh2c8n
	1iFyDwZ+bFLhVKVk0bmI5Hq5XxN0HWraJLiLRnieO1onORCqb7gKdicYFjU2j2xPu2UMy1cv+5J
	uJTJc6KymoaiClUGVI0yHXxw8=
X-Received: by 2002:a05:6102:370e:b0:5db:cc69:7399 with SMTP id ada2fe7eead31-5ec74329c39mr406513137.5.1767661294625;
        Mon, 05 Jan 2026 17:01:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGebirOgsDiT7jy5CL+h38CH91id84REIWuMIjih8Il5xh+FCp6mTy2jPQ3VA807d2Ub/nd3w==
X-Received: by 2002:a05:6102:370e:b0:5db:cc69:7399 with SMTP id ada2fe7eead31-5ec74329c39mr406501137.5.1767661294163;
        Mon, 05 Jan 2026 17:01:34 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:32 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:17 +0200
Subject: [PATCH v2 07/14] arm64: dts: qcom: sdm845-db845c: drop CS from
 SPIO0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-7-0386204328be@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Sxwe6pBBzgKc/Rbx3hGlBLXglP8Dn+Y8xXV50hDaYm4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7ZlqUdRROe+lrbb5qeAmQzNxwRhkFbuQafZ
 1LnRVCUW9SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2QAKCRCLPIo+Aiko
 1VsbCACUB9ZxKyeCESIpnYkNLBvtnArQbybVrFIjFFgB6l3oeJuYSCmeGB8KtWBcWFX2p27bPvy
 l4Aze9U5+0VUf1taw5VP9+CAZWtu0J9j/xyuRRkykC8Cy4zqkDxHYPHOEijFrDMm7mRL+R5SMX0
 EH1oqdcUgqMlq0H99DIFM4hm6AWODt7utQmKjM5NQjq6qy/clKrEbuwMXOFqdJq3gYt1yUbMY+b
 RsiCT96M2hDYAk/EnNDrvSNw+PX1El55uN7ExzhDgQeQ+xxpacGhZkL1YLw54HrtKMAcGhvvDId
 WiS5YD8VbDIFZwP6j7BaWXuWjm97vOokxspiSsDKglf8y87A
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=QrxTHFyd c=1 sm=1 tr=0 ts=695c5ef1 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Vj5tKrsnPMLlX677hvEA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: grL-exMGjEPIZFv2diltsnCQpg1_P2En
X-Proofpoint-GUID: grL-exMGjEPIZFv2diltsnCQpg1_P2En
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfXwj4RQvif1o2f
 lFxt0o6lRm1Uw3OuHyiq4/K+f5MNoMsZPvQNlqvjo3PIQUDoCLiCG3RsjC5t9D3HEm588UmHz0o
 LMxL2DKC+HdfWHAlhuduNKaR2gkLZ3RHX8W97/w/voQ5ShrreUeqDvbvkz4Htz9uAwypTn9ACQc
 4/orhepQkk8zJNi3GOn1mtFWGw4lgQJ6LfGR4UcKeqccVo0GswWdePKPof+8Fm1SPMMAWPILpsj
 u5vSku9zmz5RU+VTr4G55f4dbkELmxiDZU9xxg/rsjinXVn3Lz0GlHATtv479OXNLKeHTE9/nSi
 UfCpfiOTfkacFp5tgRdxiFLl46s9iJUIowiofwxW9hb+QwE8cX/AQU1Ln9ACbYL88jEFDV4tALo
 2RTk5ZLOmSw7buj+lnZItnmhpVnTKSXSojTlsoy/vcM7O3JnY1cq7u+UpB3KHYZ549MYfj6Wy0y
 U0ai4OlwCRHRtdnTK/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060007

On SDM845 SPI uses hardware-provided chip select, while specifying
cs-gpio makes the driver request GPIO pin, which on DB845c conflicts
with the normal host controllers pinctrl entry.

Drop the cs-gpios property to restore SPI functionality.

Fixes: cb29e7106d4e ("arm64: dts: qcom: db845c: Add support for MCP2517FD")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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



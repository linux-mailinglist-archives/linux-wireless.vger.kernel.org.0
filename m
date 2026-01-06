Return-Path: <linux-wireless+bounces-30370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E42ACF64B6
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 02:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A66130A2E39
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 01:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900A61DEFE0;
	Tue,  6 Jan 2026 01:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iq25W79Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A515JhYm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA19313287
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 01:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661297; cv=none; b=EZXjV94wtE1hA07pkUNI/1QOLjJdzKiFu091ei3kCgSRttT5SBBSRmGw3lNZqKcWxqE+Khbpxll47/vGszczPGGB9dM4m7kQ7St5EA3NVSGbP4CzgQzJlQskl8QDGRlqMnKP75sgU3Mc+SCJbHsnp+Gs9PEXVbWpBPiK8P1Dirw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661297; c=relaxed/simple;
	bh=HBAxrX8iV9KJiU+UamUvJGLlnBeHexiYwRIWWSIzRDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ht8vnR1uO34LvbB0fOxvBvsmmXcE0Fg1RFfsgIPxNU+TGcJ1YznSDaYxaN1S5gi9QsEsXA4zelDo92kvY757WRsULgsIbcPBXIjH6wk7Wz6/6dsvgAOkvJtD7ZAx4RDhxGn4FZBZeRsY4XPNEunhzF47DhVn4++qkXyfck6jyFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iq25W79Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A515JhYm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060omFL2108084
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 01:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S8Ik7VDuVyBmarpdKkvCHwUmh0SVZadWNDXRUJ33//A=; b=Iq25W79QOFtdouNw
	ioka5oq/roDN02gFaTYy+Q+ikgRwZEV7UqDgdFZ4S5zFlPMfzVYDJ62yALrwSvMP
	Nn+2mEY9zNI6pRNpo52unhpDlH4ZJSviT8nvqCKUTZw1ZjEW0+nclIVALaAnTodY
	PDj6lkV2zM7Eipzib1Bex93VWk8H0CzzGQd95n/9ry0vdVzpsD+MSdSYynnynWn/
	QxzK4TyBuA4EvbBJh6JyO5/AMK8TT1e/3RSBN2V8tEvGLRgt1iREwqsI6ySrfu5Q
	/iHiAncTh7r8qk3xdNroCiTkfQarxc+3F5U+6aFrPvykKfIAyvM460uT0Xnd697p
	GutiPQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgr7380rg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 01:01:33 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed74e6c468so6210421cf.3
        for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 17:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661292; x=1768266092; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S8Ik7VDuVyBmarpdKkvCHwUmh0SVZadWNDXRUJ33//A=;
        b=A515JhYmEFGEO1v5jyyyh3QT/BPTjP7dn1iZ1R68B5+FRcyYwVQGtlaVkQaFJoQsT9
         oVPy1CahTP6sSrXv9uKcaqoERonyqKZRlROehCMzPE6+7O945YYuVDrqrJQEetpWuBlt
         Oz+s0Ykgyq4Lyl+5Q5IXw4s7A1U1pTZQhdCnjfmxqWDNgY7fZTl1Qiqhm69O7WrXDgjh
         F7yz8NqtlKo9c9l+ee+TbuMTqODZqFGFQFjd8heahliNVYWSpW3MF/HnEYPYA2FfPyLn
         jVuetsc+5H4whhUKcOkwq2gaFvoq3dBQR8RXPoKuNx6PtKW/2NZcbwGA8iRiG4GUOC79
         EeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661292; x=1768266092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S8Ik7VDuVyBmarpdKkvCHwUmh0SVZadWNDXRUJ33//A=;
        b=TyuDY41e7Lx1q89az0zFDSBDHxs4TUta1cy26KbiriTUw7EuL8ym3hymeDfgE0HInt
         Rb/jsx4gMsscvKKDGvDmpdRrMzwx52OxqSnUnKk3s6ooZFnwIv6xTw5zZB6mhKkcrEUz
         GONKhtH8ualSF+E8GTzH01VZ2lfurgI2Rfoluah7ONT0lILbEWtIy0R9Y08jB/EPxC+7
         tdGbtTE74GUkr8guA+tQEFp5RBogUbkoYMRiwfF6f/BDEY0JqHXn4XNxJ0+by03SwzjX
         vNwRviVm3ynEYsvxL26II3ihQK+RxeHfBIFjL8awtazPGPE2yMGsWunJq8jKlsgmLiJv
         Y3Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXoK4PkkpDoKdq+YMLJcEqzaiyJTi0vEJWFSOxVkW3cBF2JaE85cHEWxjk8Fw4ONbsOBEHtUnHzpFZ/31xo0w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpl9GZ8b1fmzbp8B9KYyUbnHyYTSNbTTNIrmLSDeYcGpl3HVIq
	bPsecbeoiEDEzgFlrJcP29GGLCNcAjYJTo7K+UkB+h5xIOt2Fyg7kpyIhIuaeJcQUO4C0UVP1Z9
	l9blZuEXp0+295WW9ushaOgFTm6P4Lw+xzPJATQpP67wLVF+pkOx518zYuSLoIcEFHwDAnw==
X-Gm-Gg: AY/fxX5EGVEO5uU+Ycm9Akrlkb8t1wEPIHNZshx2LFyMt8FZlNzLbbcqXxPcbJNK6g7
	QfdEYvikYEgEHmkf81wOY0km1u6d2gwQbwFQPTfQJszYAou8trUTUpHQb1Xzw7XmDfDDBfjaUV7
	EspgyJFwv3rKIyYyZi7+hZnBNIMdfrTznkpySzFtYsLaAZ3COzTsLoLydFMxcRpr2AFQLLuy9oZ
	KYPbvPay9sffqEXDu5+cvzuJOZ6PeozY1SbVsN+Qnbm0HPjATnPRqkDSBq0Gdh9s8xDOMQzn361
	IlZr2v7CsjUDsfvoMIKfSy78aYd5gv1AjKb8sWogJFDXEmCE0y4jhSmYF28nnJ4KGyf6ZQLeWrF
	vDANXJUF3cu14KMlySqEuJ/56DgxzU9cq170vGFtYtuTqnNVdzA1tlfNEu8H/vKNI5oFuKs5u8A
	oUBnFKLs7RTQjhW2Uk5lOQ8zY=
X-Received: by 2002:a05:622a:2597:b0:4ee:2984:7d95 with SMTP id d75a77b69052e-4ffa76a1fa9mr22530871cf.13.1767661292278;
        Mon, 05 Jan 2026 17:01:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEt7DDj2OmAqAuyn4uADPuy2ZgBfefpU7ocoBOHTN5kE9DO+gdCGToaNV+v3jan8nMFTXwpow==
X-Received: by 2002:a05:622a:2597:b0:4ee:2984:7d95 with SMTP id d75a77b69052e-4ffa76a1fa9mr22530081cf.13.1767661291701;
        Mon, 05 Jan 2026 17:01:31 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:29 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:16 +0200
Subject: [PATCH v2 06/14] arm64: dts: qcom: qrb4210-rb2: Fix UART3 wakeup
 IRQ storm
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-6-0386204328be@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=HBAxrX8iV9KJiU+UamUvJGLlnBeHexiYwRIWWSIzRDA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7ZuvUFKSSgxoY07jR5chyzPO9tSWZCnONwQ
 6EwB+Xb5t+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2QAKCRCLPIo+Aiko
 1TydCACKh+wp+fnm51csTFbwKAJL8ROyCe8q4mEdQ/VZh9vvL7LRhZg+i3LZH71A2YSF+0LzM12
 yLu2lIAGKrToPnigiBC+sER+qaLwgOD0c5RxIFrzQaItAoqNrhNW0JbvO0omP/jMNCxyaTJoPGC
 5b2UPXPBhDld7/r/LhIDrQyaNi4qB2awdhal1aXTGyTQ++ia3rMGUSliuG1bzlMIYASVuhH6Wwq
 WMTPaoYL7nBQvsx0ZzJuF/9HxGvRo/661EPfI+vrBrqWNSQtJybjYqVwgOIbDXlRUfYkxij2coz
 9wN980qyF2BdAWgtZWiq4E5vid5H5iLcjounuT/EysQubVO0
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=QrxTHFyd c=1 sm=1 tr=0 ts=695c5eed cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=4EO7c5U0FNLfYlZKXmMA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: M-TZOzE9jZaoWjYlidYj2yMBbSTbCBh1
X-Proofpoint-GUID: M-TZOzE9jZaoWjYlidYj2yMBbSTbCBh1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfX5s6kjCzCJSi/
 s5hZVcy6lEVkmRYo2r//TtEYqodeQMjnnBcpAmZtVxBOWN6Q7C2lAp0fZ2qGBdwkRanCTt4Zpgn
 HW4a2H7BGImZQ9vJeKPOwyHJazmCYMxUtuQUMOD9XXpLZgiv40Bkqt2Zat3h4qglnk/5sHS/MnG
 69spNg3HtdFfu7rgdAnAsK0iHKd6kV0AhWBnt2HyNRzuVKyBnsbejVedd5JSzcPJ3g9hTVOir8d
 NBzf/Wl2N67NZScwJ0x0PIKhZFS2AeCArjYEtsg5muEtiVDXVlyOsMn1ttvdj3wUKyT6NpbEoBS
 KiR79KKRO5JCs7ksYzS+xdOZnBstYkpRwAh3L7TyAIar1FFmwRrgkzkFmYjPCh8Jg1jGHDZowBs
 oJBRcsKLGwLOWsAAAF1KY3xBL5EopsY/gdwDj74RIfvHNC2mg4cbj7qfhr8LtY2uC9uKw2Olmil
 WiuRB1ei3m4ph/gZRVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060007

Follow commit 9c92d36b0b1e ("arm64: dts: qcom: qrb2210-rb1: Fix UART3
wakeup IRQ storm") and apply the similar fix to the RB2 platform.

Having RX / TX pins as pull up and wakup interrupt as high-level
triggered generates an interrupt storm when trying to suspend the
device. Avoid the storm by using the falling edge trigger (as all other
platforms do).

Fixes: cab60b166575 ("arm64: dts: qcom: qrb4210-rb2: Enable bluetooth")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 0cd36c54632f..5f8613150bdd 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -694,7 +694,7 @@ sdc2_card_det_n: sd-card-det-n-state {
 
 &uart3 {
 	interrupts-extended = <&intc GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
-			      <&tlmm 11 IRQ_TYPE_LEVEL_HIGH>;
+			      <&tlmm 11 IRQ_TYPE_EDGE_FALLING>;
 	pinctrl-0 = <&uart3_default>;
 	pinctrl-1 = <&uart3_sleep>;
 	pinctrl-names = "default", "sleep";

-- 
2.47.3



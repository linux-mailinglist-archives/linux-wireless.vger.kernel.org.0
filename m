Return-Path: <linux-wireless+bounces-30191-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DD6CEAE3A
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 00:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F797304B3C2
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 23:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079862FD1C2;
	Tue, 30 Dec 2025 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X64159YK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i2ShnxRm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C1A2F12B7
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137778; cv=none; b=Gcn4oLvjozbJEpMyeQLLIjeL/nTJavbypQTPle+OXsLO/vIIeBy7BF32tSE+QtbeoNkxdtQWliMj7QgbLMMv0Qb3msYSV49/pKZH1ZqbiS9Nd9PnDQu3/1sNjAJ4wKysmqZwNI4pxeyPx8vac1Kse7nwVC2s3pwv6i744g/2H4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137778; c=relaxed/simple;
	bh=FGGim44BfWQjkV94IPZI9LwB/0tKRgJ7VqsLfgE2Ze4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y/k76XVmECX0UAcsY5F3bVLm8N6HpOR7464SB9XWGQZfjRqULz1Du2PRCLfXmI6LEYJTFDrVGEqPe6XSdJkO2kWt4Bqru0U38uT7TIok/EV+/Mi0rdCrWb6qk8nfLW2MXXN2qoqiEs1pJy06ItTedE5zEpZuZbI3CNYbEUvHA5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X64159YK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i2ShnxRm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUMarwi677479
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yz0M2bONMw9l3lUPyJcEl7KC+6i7WH/5FxBRw7kdMZ0=; b=X64159YKNjQ8Yx5G
	YnPZhErsuZ6tqOaha8guF+8eyfGU2/K589czzzwfeNSvMmvXtmOmrZG1q3FGGNZT
	Uh4Q5PG7h6nB1b6rcyqMHjxa28sRzW4jZ8pVKIlF+ODehbdsd5Qo9PrKhJNPTeOA
	wx07du9EUA+UESqsQGSqA+/eqifBTZbIN3GltCXFuDNQUCdAyhG4KVfEpuPUo/hc
	3WhYt2/FnvDrcnZ9ft7V1CRSf/qNq86LnYs1G7ISaluIOwJjEsad832vBS3gm9c+
	fa7GUZvo9IBHasngo2AQtOZGLDo7utIXkk8yZosDH6TV4G41Qy3DFfKkp8ZQKANQ
	UUAaww==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc739acws-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f183e4cc7bso195021221cf.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 15:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137774; x=1767742574; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yz0M2bONMw9l3lUPyJcEl7KC+6i7WH/5FxBRw7kdMZ0=;
        b=i2ShnxRm25hMubATL/gTHLJyiEKKjVGWt23LWiqaVec3gzDF+SpBgaqFzDmtPOG3kz
         JjqdrYnLZeVJRZGDFzTI9JRCq/S9GeLDcZkcCxVcfp0N9XVTTgkmOMrYFysFcMeRNz8O
         bVB8Uuse7BKsM0vjoj4EL0aRWqe0q0tNUv4Utwp+8Piaw3vLzPCY6UnlZ82ia8gD4erC
         ougQRuKB3E+5ozd43pb/FmXoF7MftJ5P7CFnFlaCeahBGUV1GXgzuc7tmrwde1cT9iA8
         OudrV+HenBP8QfM77XAn19uq+4MtEaQn9GASIOcwBuWDC55zfZlhO5ESSHbp3FPQieKG
         m0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137774; x=1767742574;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yz0M2bONMw9l3lUPyJcEl7KC+6i7WH/5FxBRw7kdMZ0=;
        b=TLivzqjuwGpk9Uf2ptYgTVpEXbCHlop2sPGI9RvfemJlJNyNFK8cZEYkZ5CT0AaFLw
         LQfhIPH1ZjnSYvwamg+QfTExAsFEKEl0wa9YOWIqhoTiDbA9BoWJMZ4xEZC+O8bGtQjs
         ySyt5XMZpRvU9EqCvmNURTvbPv608b9S/SimhEUICnqj2GRigoHF6wrvcmS8enkImW3F
         vHP4qj0S2D41HEsUUHeF8J9Ys2agQmrflTJyRCYe83B1OCvMG2utGsyZiM+eHcsHOjc5
         RO6JC3BoVKfGNChfkLVZsUYSliV2lNS8OoGodRPfoxyurQAicGhzmoa9cbYlWDQITmqN
         bEDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMZlYap5cCOP4ixNUuFzcTsLa/yCF3p4X0gAlCNMeJsyqFKZHOg63UT+ywea+fsTGWG8T06UJGKIvFPzioCg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2VNDK95H7alXHjNMs269VwcqFWvm5wQS2IrBRIVvwYdK69LTS
	e5JQVRIpYNCM2rIHg4Vc869bKtMmORBmFKwdISP2IpioQBmLf+Oqv3v5kpr0bg34Qclc4I4TE1r
	SPuy+dD4yYYutr9rn2Oenzi2F0GCZlxlTVJ+6Qe28hHhIAlxLzv6HdEbvqYgY34RgLI0eEA==
X-Gm-Gg: AY/fxX4F1pKPD89N3GplMY2kMZOLDw+DwmeVKi3cYcQ4BlkpQfrHf/4Bufnjku5vfJw
	3uiK2f8NhZ/StcePBTxewtLgvMDeCn2jUOLSYnK9qQAw+5dW+5A2OvLNAwbz5DpheSOI4O8uSkV
	JjB/bo+3Hkfmyub8VteSrTvo0T1gKLsOT/vLsUWftNRU+EzOuBVwHiywGxtcLueqRL8fUNJcd6y
	cx1h2NWo6X0znKJe/w/jg19Fzf5GBpKYmyr+IW9isw4Ky0paJbi9i+f1wmowxutntT3kMC89q+h
	0g3fmMp9cwTcBruilORn6M057fkqi/Z5VraB2NMg4S9fxWnPYHsOZKGlxCgruu+TXFSI+q85sKm
	xoB3LM37lQhIFewytrntuGqTc1q4+lR/W7IpYcmPGE8QuEYnGZUk7+6Ws+h6IktjJzD8w2PBKyw
	idqVi5G5GNh0U2Jgu9l2XvOLA=
X-Received: by 2002:ac8:5a95:0:b0:4ee:43b0:b053 with SMTP id d75a77b69052e-4f4abcd0726mr473645241cf.9.1767137774622;
        Tue, 30 Dec 2025 15:36:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMGGQVJr5nFU32BS3rqlRNKcmT4nwQuRPso4jlVyupuyImgGYdCOcdntUN7XRhnoHEMgqIww==
X-Received: by 2002:ac8:5a95:0:b0:4ee:43b0:b053 with SMTP id d75a77b69052e-4f4abcd0726mr473645051cf.9.1767137774178;
        Tue, 30 Dec 2025 15:36:14 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:13 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 01:35:56 +0200
Subject: [PATCH 06/14] arm64: dts: qcom: qrb4210-rb2: Fix UART3 wakeup IRQ
 storm
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-wcn3990-pwrctl-v1-6-1ff4d6028ad5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=FGGim44BfWQjkV94IPZI9LwB/0tKRgJ7VqsLfgE2Ze4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpVGHkABOQMZr6Am7DyYFRXRSIogfZu+iSeRz6J
 dZ6Bzp6kY+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVRh5AAKCRCLPIo+Aiko
 1SMPB/9s6ve61Q1pA4PXAtBPD6/eg5LblpoBoY8MSqB1GYg0vr2VcRReBaI5UcN3j8+jf4XpfgB
 ipggYWe6Ll8hagzxVF86Oi0EMXPh/wMppwJPc5U3oQ6t/4QDozewFUp+uXkzHRoAu6l1b5rUiE7
 FnmlvBBDUiwJelnTQJDhNbem1sofjFQn3X3ToHeFOc0fWtdWkXMG43vqCQHKrv/FIWXG0CuAq7p
 mxoBrUC8z3iqv9fHWgOOnZr0efRh3h/V3D6w1F18vahSHPEKzn5kbXGa7loKJCdZeooj0S0qbcN
 /ZHQVn/+B1PDekoMnUbHdqWQ1bB75eCm98IJFmOQZh1rxPuW
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: UsnbLZmy1CFlqKNKp30XcxLxvUusu4ll
X-Authority-Analysis: v=2.4 cv=HrV72kTS c=1 sm=1 tr=0 ts=695461ef cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=4EO7c5U0FNLfYlZKXmMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfX7+K+pKrLPTiV
 dwU5kZRLfWRRqih0OD06YziMKtKxIoNhQTIRdbHmrhED3IGllaATEChqaZVqKPJLQFXTtsDRN2n
 T2oCvwp2w2pOojM3SLdccmIC9zeMF/g5rU0/AnalWnfvm/6YqBiGE1kz/c1WsAUtYXlYpiqQ25f
 4O/DcTZq3FrCJzPJe9l4mdoCVRp29MeI+S6PREBlSh6Xhqlzb8/O/5iqV6p1tc10SwLAgQIFz49
 u4nF70Lpx4NdhWTmsg8Sd4TiIZECuvXG+EjerapYnv/PFWrNWdaOuIf4ra5TDuCRByuBzjZ7OAA
 OzTuCKXyr913vJ5AuCvuyudHfQaab2IF7uZXCdveSkfyjyF+IyMSJbzx9Qz6YWu14N3q2JVRr7x
 lDJu2mDZujZO8YfIHJic8SUKjODYw0clIYp3wDnNpQvo3DDvC7ngiHRr5bAd7wu/41BiVILg2W+
 5qGkh4MnR0LCA7SxTbQ==
X-Proofpoint-ORIG-GUID: UsnbLZmy1CFlqKNKp30XcxLxvUusu4ll
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300211

Follow commit 9c92d36b0b1e ("arm64: dts: qcom: qrb2210-rb1: Fix UART3
wakeup IRQ storm") and apply the similar fix to the RB2 platform.

Having RX / TX pins as pull up and wakup interrupt as high-level
triggered generates an interrupt storm when trying to suspend the
device. Avoid the storm by using the falling edge trigger (as all other
platforms do).

Fixes: cab60b166575 ("arm64: dts: qcom: qrb4210-rb2: Enable bluetooth")
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



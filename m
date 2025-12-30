Return-Path: <linux-wireless+bounces-30189-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D291CEAE25
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 00:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21D5F302AF82
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 23:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEF0221578;
	Tue, 30 Dec 2025 23:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o0/OoV1O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lrf773ef"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB23D2E7F25
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137777; cv=none; b=dz1BDltqzmAmHbfJ1m3PBk9YdrowtpJEa71cCGNjUzPNdMSFzuYcEZoSZticuC4YFFnob967ljehjqL0pzvumyH3QxQx8+H/kgdXP0qExICS/EPGec9EuVTBa/J23PDghjL2m4Q1vKIz2y8lPhOUQowNmlB2tCKuR3g45mLpU3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137777; c=relaxed/simple;
	bh=7QSioEYvGLnmvEenw/yHYmMfZ9Xg0f5fS8NTJWat/EI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bHgIWy50pgs1aE74AzqXZb6Yobn2o9RPjLMD5ertIo5ovRJnoxZp+KedVDy0p0Vix6pdzTYBt2gl3DS3T5PT94EGByJmzhlgnTlM4PKzIICsDaw7vI5SDLWQdzKSPuR96v4hDJaYM5kpd+1kcZqFlXMVQvpKOgmQFAdVyghIqso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o0/OoV1O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lrf773ef; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUJ05LD2284829
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T4CuQYcWJDm2WGHsZX04dpGhQA7HPPf+2qQrhA2V7ZQ=; b=o0/OoV1OThKPsxHz
	si//UThuoOCGVSMdE94/7+HwvXZCDVXhmqZnBBs2OGmVHCy+1F/ZooG3jXKK5YTt
	4Whur72cD/C2Kt2nxFlSvBnPwxlYCKFEhsLSzb/mE8bbu05Tt7ML695ApiNdk6OE
	a3asbtKS54AZWJfiVXbGO9OVPqZNeqsUoTPD1Mh1nUbVIwzTfwImwiGTV94C+Wh7
	ALdd6bHE/Wuwdmwa46G0u3myvVMSwLYsUTGFoaZsGApVuRX+vOmk+cr6Z+Ql4cco
	IYznBc2nfWWRPj2Lvl9Oj5L/EgdvqVX6o2gGcvlxHunIXz8lG+UpcEHc+QSduj75
	fEYwDw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc06gu68j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f1d60f037bso230369131cf.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 15:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137772; x=1767742572; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4CuQYcWJDm2WGHsZX04dpGhQA7HPPf+2qQrhA2V7ZQ=;
        b=Lrf773efuYIpkGNnfqp6vYU2yha0poDjPYaY7kO7Y/8EA1jPCelsK5PG1Dm4wKSaxm
         dhZd0Bhks+oQZHA8MeAqYCFc+s65ilsQAiqjDCnOny0cv/kWp1Y7+b9RTVeD/4O/IY+c
         D5UbyS4qkH8LB7K7uFdwe1NvJ2RG6KJ7zV2HhOdtZ+71RW93BGGM6mW5D9Yq2lGYRUC9
         s+AWoeboyme9fsRcPLgKyVDz/9iARp6h8BuaixKAQVdm6P+hs5Y+GwZVjGqBihz/Fs7H
         7/LskoziO8lPQ/aFNNqybfi/x3js2JteUMBy7LtO8D+zRYY6tXQSDcIvm+rEBtX+baKp
         +6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137772; x=1767742572;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T4CuQYcWJDm2WGHsZX04dpGhQA7HPPf+2qQrhA2V7ZQ=;
        b=B9HJ2drhDnNc2ktRxB+Fe12NWuSNRMORXkEI8i/1xRPBlf5iM5lRvGxbZtkYJFUniG
         pH1/y9TVx4lSBVBMmCvgAm/Vogwuefeva5xyYH7EJe1Gfcjywtt1nRuAJGS80L8pWPIh
         Uj3UgoxQXjuEhLEvlXVwuC8ZyBQteUWJbgk/TdvqwcrFVLFaKGPjC/9HyQi5RGfVxGgZ
         BoEBMENG7E2wCXXCOkTzyFbdxioydCrHnHhx3AZ9v0RvXBSUw5WdSPYRGvuL4JPxsb8j
         pxNyRaE16GC44OGaE07IcAgscXjxyE+71NAs7Bq3NbkCGMr4gOq94rhakdLz3TdBYQLR
         otFw==
X-Forwarded-Encrypted: i=1; AJvYcCUm795P1yJwleyHQM/7OAJnIpPRre/Z/n/7C7KnyMLih8T6NWwrwUdqhnvPrN2YsbiKZaK0OJMQBIzNC7AvcA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/e8/gqoJYIrya9VAg/N8y3XEk3VXTjS/S1WQTdcEQqTamgkKZ
	ucA8+gUEerBLF/tPEvnM5TjHX7h1G26LWHb+gVM6qjBAA1zwsqyBMY8SlqR4Vp3njNtAvGsgiRP
	O7qZ6cOZEzeVq4WV4lCKZTjEVySwQ647F6tnIIla7+21DXuDNxFHDuPDClrX1FpDFV03a7mGNeD
	HAiQ==
X-Gm-Gg: AY/fxX41ZFwrUK8BI1DzhyvCWwWBvZs1FJdEXpCN9kDvjpQ4ZdH9gRiGSv0eD6gnP1a
	Lc89SwLvLyFbPaDS0KOxYhMotCAjHkGTF9j/ZqF+oRPi/TNWfSB4/LYWfrxFJepzZvkNLGG7yeG
	YCBWw0mdFHPSajtSsAbqGKV9EWQdmzVptdyip6KagWVBfrqn8El//5bFrGDiuuYd9YNKuS04QxS
	62QG1nZQoYftstDh+gVPbLCBAXJbQ0f42waFDWqxDjV1iROIjrZx1Z/K1HP44w34Wh0Jv6oOrx7
	fETrtL8KgQ4vI+udHLmG9Vs3uTb6UBy5kntkf+jzBGYBZeWugkJiU/XFUC3IIf4J3abhsERmeN/
	zWz8ONQk18n/KeksDXLJr4H/+R5QDleOzM0melznrAjR1LD4YwBlbPUkiguYIDW2QJykIlDJ39X
	LVD8Cu7lhQrA/ueuFf0F9a8iU=
X-Received: by 2002:a05:622a:4d43:b0:4f1:b9e1:f08f with SMTP id d75a77b69052e-4f4abccef46mr678516851cf.5.1767137772366;
        Tue, 30 Dec 2025 15:36:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlDPU6Dqq5czWrRWiRVo3KDmDnZib/IbWQyj9oxLhrnXD3CT7PTTDOP/hBeaierKDJ77x3Ew==
X-Received: by 2002:a05:622a:4d43:b0:4f1:b9e1:f08f with SMTP id d75a77b69052e-4f4abccef46mr678516561cf.5.1767137771935;
        Tue, 30 Dec 2025 15:36:11 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:11 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 01:35:54 +0200
Subject: [PATCH 04/14] wifi: ath10k: snoc: support powering on the device
 via pwrseq
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-wcn3990-pwrctl-v1-4-1ff4d6028ad5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3870;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7QSioEYvGLnmvEenw/yHYmMfZ9Xg0f5fS8NTJWat/EI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpVGHkHbyPI900A+jLy/7p42gbNUYAcF9OhJ9mB
 7CW85kKHn2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVRh5AAKCRCLPIo+Aiko
 1dx4B/0VHR786H300VxW1pwdym1Ee/FczTpqsCvyGjuyZ8bo/+du7C/9JfjMuGXPzW5orBpXdfX
 hOX0pOrMszp9hBJ/O0L+ApDBodhZDfskjO14Fa/4vPTzOjGk3yQ60DjzecKwh4KnW7w2zf4LhZ1
 P7QFGFWi8b+9wIcDtqcB8/jWIqsNxoVgjtim4ECCrX435hc50mrsI1sfzAFLEKhWWbFlIxxNRbg
 0vAy+Nqp4uYoS9P3h5pnYO7sJks5sGJ1MlpbU/0x7M+TKO2rcS8hS03VvOOGg3hZ6j7oZWMX+cX
 Gsc1rgY1RWm4Dr3OTJF4rS/sr/flKCwZFonWYiO8K41KPg/E
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: tx19eJf1IC6udHWl5IgtCLDZdJeyIHPr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfX7Fa8JerhNVCk
 ySZLUxP1bJpr0HB/V0riYpvLU/sS/WfhVg7NAEUhblWgJ8pfLm72GdNi8KSEJknYCPY2IFqujbk
 Udk2XwNruxUIAdRVDYWEOImYFkVf/ae1bsIXMhvNo95a1rXLxyLga68Hn/vj2b0wjh0TjjCLRCp
 U8tCWxyvu+cEJzgJw256LTGCWXG9F07201TOm/gX5r/sjbyKUi+gcrarWcBcLLijdlKJSQ1pnZZ
 35OzzrewybVADBvojg8B3D5bAzEL05yIsNUFiDZjrIHr+IQ2SlvQqJ2iDNH51alfo9AXzdKfT7S
 hgGQYwpx5bg2yEg/PqyFsrbT5qS++xXlQaikrfKculT+2l5oix2BwAW1HmzuRmCUCDBmNNShw68
 GOEi1YZJC4IBZfp6HyNfGg5X+dXq3pFI1jqcJW1atfwinw442xjR6wddr9ws1e5DSCeTqT1ZoiH
 D74smog31srYo+oVVAQ==
X-Authority-Analysis: v=2.4 cv=A45h/qWG c=1 sm=1 tr=0 ts=695461ed cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Hs-j7k2oS4XMYd915dMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: tx19eJf1IC6udHWl5IgtCLDZdJeyIHPr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512300211

The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
voltages over internal rails. Implement support for using powersequencer
for this family of ATH10k devices in addition to using regulators.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 43 +++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath10k/snoc.h |  2 ++
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index b3f6424c17d3..919d4b0b87cd 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -11,6 +11,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/remoteproc/qcom_rproc.h>
 #include <linux/of_reserved_mem.h>
@@ -1023,9 +1024,15 @@ static int ath10k_hw_power_on(struct ath10k *ar)
 
 	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power on\n");
 
+	if (ar_snoc->pwrseq) {
+		ret = pwrseq_power_on(ar_snoc->pwrseq);
+		if (ret)
+			return ret;
+	}
+
 	ret = regulator_bulk_enable(ar_snoc->num_vregs, ar_snoc->vregs);
 	if (ret)
-		return ret;
+		goto pwrseq_off;
 
 	ret = clk_bulk_prepare_enable(ar_snoc->num_clks, ar_snoc->clks);
 	if (ret)
@@ -1035,18 +1042,28 @@ static int ath10k_hw_power_on(struct ath10k *ar)
 
 vreg_off:
 	regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
+pwrseq_off:
+	pwrseq_power_off(ar_snoc->pwrseq);
+
 	return ret;
 }
 
 static int ath10k_hw_power_off(struct ath10k *ar)
 {
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
+	int ret_seq = 0;
+	int ret_vreg;
 
 	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power off\n");
 
 	clk_bulk_disable_unprepare(ar_snoc->num_clks, ar_snoc->clks);
 
-	return regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
+	ret_vreg = regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
+
+	if (ar_snoc->pwrseq)
+		ret_seq = pwrseq_power_off(ar_snoc->pwrseq);
+
+	return ret_vreg ? : ret_seq;
 }
 
 static void ath10k_snoc_wlan_disable(struct ath10k *ar)
@@ -1762,7 +1779,27 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
 		goto err_release_resource;
 	}
 
-	ar_snoc->num_vregs = ARRAY_SIZE(ath10k_regulators);
+	/*
+	 * Backwards compatibility, ignore the defer error from pwrseq, if it
+	 * should be used, we will get an error from regulator get.
+	 */
+	ar_snoc->pwrseq = devm_pwrseq_get(&pdev->dev, "wlan");
+	if (IS_ERR(ar_snoc->pwrseq)) {
+		ret = PTR_ERR(ar_snoc->pwrseq);
+		ar_snoc->pwrseq = NULL;
+		if (ret != -EPROBE_DEFER)
+			goto err_free_irq;
+
+		ar_snoc->num_vregs = ARRAY_SIZE(ath10k_regulators);
+	} else {
+		/*
+		 * The first regulator (vdd-0.8-cx-mx) is used to power on part
+		 * of the SoC rather than the PMU on WCN399x, the rest are
+		 * handled via pwrseq.
+		 */
+		ar_snoc->num_vregs = 1;
+	}
+
 	ar_snoc->vregs = devm_kcalloc(&pdev->dev, ar_snoc->num_vregs,
 				      sizeof(*ar_snoc->vregs), GFP_KERNEL);
 	if (!ar_snoc->vregs) {
diff --git a/drivers/net/wireless/ath/ath10k/snoc.h b/drivers/net/wireless/ath/ath10k/snoc.h
index d4bce1707696..eeaa1c009cb0 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.h
+++ b/drivers/net/wireless/ath/ath10k/snoc.h
@@ -53,6 +53,7 @@ enum ath10k_snoc_flags {
 };
 
 struct clk_bulk_data;
+struct pwrseq_desc;
 struct regulator_bulk_data;
 
 struct ath10k_snoc {
@@ -73,6 +74,7 @@ struct ath10k_snoc {
 	struct ath10k_snoc_ce_irq ce_irqs[CE_COUNT_MAX];
 	struct ath10k_ce ce;
 	struct timer_list rx_post_retry;
+	struct pwrseq_desc *pwrseq;
 	struct regulator_bulk_data *vregs;
 	size_t num_vregs;
 	struct clk_bulk_data *clks;

-- 
2.47.3



Return-Path: <linux-wireless+bounces-30190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4A7CEAE2E
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 00:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 708B53043573
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 23:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998142E8B8D;
	Tue, 30 Dec 2025 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DgvFeT/L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dERdLtyY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880ED2EA482
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137777; cv=none; b=FpqelRr/JCYfHxcguc9s51k6igG3ZrxByiigvRuDLjjHrIF2d8IfEgCKLl3UQVkZP92XpkHBnD5NuXXHhl6NxcX2bidxNGKLo8SzTLvXCUhgrr7lADVnq2I0PIXASiPPutBPiAlgi5wRNHK1rCubcsjskHLbcIHiyQbFB2WuT9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137777; c=relaxed/simple;
	bh=G5Z4yR6nEsG1t9E48mwIwJpb2fx2CuxEMAwYvVJCpKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YL0rLBUA21XQeNoOaPqDTrKUKvTKWfFe3WHQPxSYWSXzHmgbRmjuHqxndz+Q7d/jxlsRwYIBUUqc08bp35ExH7oGLEHYqBjs8vMGYeQVr96qWndZrevcdR59JYRXWQi+juhM+QrrztxiENgIkcgHI11t47OYDeTjcPdbqCouTOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DgvFeT/L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dERdLtyY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUMjnRL2380826
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M+J6odUgaa8iwTvncGdMwjsDOYue6NOpQi6sZNGxf7o=; b=DgvFeT/LbKpAbaOJ
	6pJL0julzqo9F5xShPc/sPjnNl6mQU+meQIux5oud1XPM38IrvDErvwTUBYOK97/
	FOqpZal5hMHfcSYMc43GdFQ1BUVVW7ba1pDXwPfFRxidheChhL8IemJYRXQVz/E9
	5SWom50wRnFtyn84TqATGvIj0zrQmz5b3gFgFZWGG+P+1KuXmfFmp7uJrD1qc9Nl
	rWJEn80lAYBpds9ZIVnJ1dLtP2WfrRzFEezT2Nrr9uNYJSZBLyeHMS18T0Shhe/x
	kLLWYkFW1Yf5aBmdB4Ba9QBVYOUHi0+rmFCbnWmkRMSz9UYTU3DxM8ww3nboD6k9
	IIb7hQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bbqk1ccyk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed6ceab125so274978881cf.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 15:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137773; x=1767742573; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+J6odUgaa8iwTvncGdMwjsDOYue6NOpQi6sZNGxf7o=;
        b=dERdLtyYJnoY/av+Yjk48EUJFKT3Gw9B+ga4y90isjeqFzmFNG0QCOpy99GkslhpUs
         3kbHOqFRmijInZIguhEC6AcClW0YAyOQiX1uNknrF8coWDOMN6l8vDIRO+3b/k1TFnCD
         /FXX4PEpijTkoyWprfr8JmCnhM3MjZDipSH5haQi2NIBKAmz5V21VYvOWjDjJCvT+8lo
         1ShDQ3SqnghbklJRzqIJaPOKLBug0hkfzCjZ1Owuc2T2mE5aYFGy8iVj3v715lTnUvbz
         mn2ykNU3g9xfw8PpKaY2WrQy8oOAokasz10IH28qX+36F0k+ybIzeFoDjMLlaIT2AApI
         YBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137773; x=1767742573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M+J6odUgaa8iwTvncGdMwjsDOYue6NOpQi6sZNGxf7o=;
        b=Cr/2I0EcDA7KtDEB7L3p2EUgnf2YMptEIiWh+2hbX3bvzXfTMb3LL7/iI6Hk0+PCkj
         PFci2qLBZl6Pio9P+GakPj5fKpMCn28PmZ/Mutyf76mA50tLsey1tAbXCJOwTm1O/zkl
         WxEsw9EeHcGZFpG+vEOXI3y7qYs5yekKttqwFtKEI2llEKSKZGyiGAwFVEsgSBHgcu8v
         zi5oG/MVs6pHJC8Z9niqa6w0oI7u2UYxlXU1pIdlCN5Jm4bXD4mFm7KBx6CSk5lSdyH3
         4Z6v3lwTYkR6y5ucevbyah0FV9BAn6aevOBRuwmLG+6ZDSH6cySBI7x8MzsUoLtYnWa0
         yGsg==
X-Forwarded-Encrypted: i=1; AJvYcCXeKciiat4WBOct9pVIuMyWFG90VLlVLx9++jCbcPHypHLGBn7/DcNULijxfpdFfrXRkQTRKY2iIGPJhcsoRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5EVfcpzwl/Y5yiumpqgp7Jy8YL5Y4g8z1urrJfw0dr6Ry2Ir9
	kWlFEYr7dqSaJBkCadrJUcnfCtY1pAVrAIclPHVb8HJHX1ADYOHURsmuacK0IlCquumyVzgRRQM
	TQRpHisNk1z/REVSg4vHD4NMVrmFzyGI483d3cX4YExo6T+BLPZTPMOh0lrErrC7omPaP2w==
X-Gm-Gg: AY/fxX6C/JM5BdX49bcDn6boG0R+rxE1YlgyBEv3pj6LX+3yaS5xHFYE829W3Pz2lpY
	zeH3TidE7kQNGtFfQINJ8YT8bGsFUGvoln/uqv9IZHCjsDUu94NNzBKgf3JB0e2wFaB/+nbLahx
	g5GK2moG3zdqSOcbxtXLShz5VXGXDOwEej/FaPfvs+RJAHnvDTamVQuF56UVgd0atHk7/QGEJzW
	5mHy2KEV8wQhMS1DPftIBtyJghR6llrqUCd9Dllc46vlQpY306qqBnB7YTIFWN8AiUlt8zjd9H2
	SRVkLs8w/4bSC6IE+h+oEO8ixvu0a3eg9utp5sZvQsZTFf3EB/Wdk2XAPpyuqLGvDYEPmyPQ0Yy
	jSx0ol4Rt2YWLqgo8jV4OsomRipN5XHx5lBaAK2tTKtybYoN4zQYbZizAUw/teasTSOw+iiEGmo
	zN8imQcfmLH4jOTo94uMbzLwc=
X-Received: by 2002:ac8:46c8:0:b0:4f4:c7c0:bd15 with SMTP id d75a77b69052e-4f4c7c0c07bmr350486961cf.12.1767137773512;
        Tue, 30 Dec 2025 15:36:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHt+XoYSbSJNRXHtMXQNgN0f/XiydU8U/JTEU2GP7wJMRDcjK6UqRn6PIVza81M2IRsxDEozw==
X-Received: by 2002:ac8:46c8:0:b0:4f4:c7c0:bd15 with SMTP id d75a77b69052e-4f4c7c0c07bmr350486631cf.12.1767137773096;
        Tue, 30 Dec 2025 15:36:13 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:12 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 01:35:55 +0200
Subject: [PATCH 05/14] power: sequencing: qcom-wcn: add support for WCN39xx
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-wcn3990-pwrctl-v1-5-1ff4d6028ad5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8160;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=G5Z4yR6nEsG1t9E48mwIwJpb2fx2CuxEMAwYvVJCpKM=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ2ZI4pMOE1aXJRkm0xhOXLnBtuXhofJsj6deTGt0rvqou
 ynUW4p1MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAimjLs/7QvHi2x29XYuu7P
 xelC2x5FthbuFb3BkNgXkNkwNYTXZu2s0stSKRs0v01X2Tp9t8qfS3pdPs+2Hpv44f8fb78ob1+
 uqF358VaiTPW++62ezZffIV+Y4C9QH7S0kMV1WdHbLPZHD0We7Ew8W/ia+c8UnyCp/tsXuG8qfk
 rcHB5sUtXZcOn13qPC/SkWQW1etl4MP8Xt23W/rmmPtFaqitsQc8e3Ye3JvX3Vdx5JyZx43njNv
 OvC+hsmIU++TSgUyU54O2eumYvmoUWPJ0Rnu71jXn1RReu3jc1v9antHLZZatwHgytffgs/vqtL
 /4vsv7/pLw4bx39K1zRa/U3N/KHUjWWWphH+NYUSTY0mAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: h6MIKKQQ3CFOzDMwYgu9IO8PzBTnjpqB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfX4b2CF+nrdEq9
 cXmcdBHzO7VJTx+3lSZOIiMPCMiM1eilbp1/o9Er2wolWDDguuBjcbjWxhdmppRAedABdClJuI+
 iMWbTu7kTbikorBiNHb1RpPCGvuzpYHEtRAoK+UBXhRZc7JAptPremNvy+2DWVxsRa1yok7f6/E
 zsHOjv0C3u5igV9T2a6i07vPjIfZ25DTO+Mq3XfyBNjiarpvd55ZIzDmPGjgWb+VfoTVZX0NP+3
 74yF598cJdcpmRLQjWRLv6FXZrXbA94Xv3otF01lPAFv4Nb+zM5IncAbIZrDV9D1OAHRXu+78PA
 VcvgetvJ/s0NQOFqtv32zUelTfhjR3mvkD9oS98cWX4NA2HymA7c4JW6GaPGQELRaMPKvUKT68N
 8n89dNgUed2KOPgFLDR5litv8fr5nUM6G9PlXNQO0rwcfkpBnEemk/rxYZB11zaCzooF7Xbv7xO
 BoVKoRh7pargPwQKmpw==
X-Authority-Analysis: v=2.4 cv=Tf6bdBQh c=1 sm=1 tr=0 ts=695461ee cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=I1O4o1mkfA9rNPu_QXcA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: h6MIKKQQ3CFOzDMwYgu9IO8PzBTnjpqB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300211

The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
voltages over internal rails. Implement power sequencing support for
this generation of WCN chips. Unlike later devices, they don't have
separate enable GPIO lines, letting the chip figure out the necessary
parts on its own.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 130 +++++++++++++++++++++++++++--
 1 file changed, 125 insertions(+), 5 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index 663d9a537065..ed81d0c90a2d 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -23,6 +23,8 @@ struct pwrseq_qcom_wcn_pdata {
 	unsigned int pwup_delay_ms;
 	unsigned int gpio_enable_delay_ms;
 	const struct pwrseq_target_data **targets;
+	bool has_vddio; /* separate VDD IO regulator */
+	int (*match)(struct pwrseq_device *pwrseq, struct device *dev);
 };
 
 struct pwrseq_qcom_wcn_ctx {
@@ -30,6 +32,7 @@ struct pwrseq_qcom_wcn_ctx {
 	struct device_node *of_node;
 	const struct pwrseq_qcom_wcn_pdata *pdata;
 	struct regulator_bulk_data *regs;
+	struct regulator *vddio;
 	struct gpio_desc *bt_gpio;
 	struct gpio_desc *wlan_gpio;
 	struct gpio_desc *xo_clk_gpio;
@@ -52,6 +55,26 @@ static void pwrseq_qcom_wcn_ensure_gpio_delay(struct pwrseq_qcom_wcn_ctx *ctx)
 		msleep(ctx->pdata->gpio_enable_delay_ms - diff_msecs);
 }
 
+static int pwrseq_qcom_wcn_vddio_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return regulator_enable(ctx->vddio);
+}
+
+static int pwrseq_qcom_wcn_vddio_disable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return regulator_disable(ctx->vddio);
+}
+
+static const struct pwrseq_unit_data pwrseq_qcom_wcn_vddio_unit_data = {
+	.name = "vddio-enable",
+	.enable = pwrseq_qcom_wcn_vddio_enable,
+	.disable = pwrseq_qcom_wcn_vddio_disable,
+};
+
 static int pwrseq_qcom_wcn_vregs_enable(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
@@ -94,6 +117,19 @@ static const struct pwrseq_unit_data pwrseq_qcom_wcn_clk_unit_data = {
 	.disable = pwrseq_qcom_wcn_clk_disable,
 };
 
+static const struct pwrseq_unit_data *pwrseq_qcom_wcn3990_unit_deps[] = {
+	&pwrseq_qcom_wcn_vddio_unit_data,
+	&pwrseq_qcom_wcn_vregs_unit_data,
+	NULL,
+};
+
+static const struct pwrseq_unit_data pwrseq_qcom_wcn3990_unit_data = {
+	.name = "clock-enable",
+	.deps = pwrseq_qcom_wcn3990_unit_deps,
+	.enable = pwrseq_qcom_wcn_clk_enable,
+	.disable = pwrseq_qcom_wcn_clk_disable,
+};
+
 static const struct pwrseq_unit_data *pwrseq_qcom_wcn_unit_deps[] = {
 	&pwrseq_qcom_wcn_vregs_unit_data,
 	&pwrseq_qcom_wcn_clk_unit_data,
@@ -229,6 +265,17 @@ static const struct pwrseq_target_data pwrseq_qcom_wcn_wlan_target_data = {
 	.post_enable = pwrseq_qcom_wcn_pwup_delay,
 };
 
+/* There are no separate BT and WLAN enablement pins */
+static const struct pwrseq_target_data pwrseq_qcom_wcn3990_bt_target_data = {
+	.name = "bluetooth",
+	.unit = &pwrseq_qcom_wcn3990_unit_data,
+};
+
+static const struct pwrseq_target_data pwrseq_qcom_wcn3990_wlan_target_data = {
+	.name = "wlan",
+	.unit = &pwrseq_qcom_wcn3990_unit_data,
+};
+
 static const struct pwrseq_target_data pwrseq_qcom_wcn6855_bt_target_data = {
 	.name = "bluetooth",
 	.unit = &pwrseq_qcom_wcn6855_bt_unit_data,
@@ -247,6 +294,12 @@ static const struct pwrseq_target_data *pwrseq_qcom_wcn_targets[] = {
 	NULL
 };
 
+static const struct pwrseq_target_data *pwrseq_qcom_wcn3990_targets[] = {
+	&pwrseq_qcom_wcn3990_bt_target_data,
+	&pwrseq_qcom_wcn3990_wlan_target_data,
+	NULL
+};
+
 static const struct pwrseq_target_data *pwrseq_qcom_wcn6855_targets[] = {
 	&pwrseq_qcom_wcn6855_bt_target_data,
 	&pwrseq_qcom_wcn6855_wlan_target_data,
@@ -272,6 +325,26 @@ static const struct pwrseq_qcom_wcn_pdata pwrseq_qca6390_of_data = {
 	.targets = pwrseq_qcom_wcn_targets,
 };
 
+static const char *const pwrseq_wcn3990_vregs[] = {
+	/* vddio is handled separately */
+	"vddxo",
+	"vddrfa1p3",
+	"vddch0",
+	"vddch1",
+};
+
+static int pwrseq_qcom_wcn3990_match(struct pwrseq_device *pwrseq,
+				     struct device *dev);
+
+static const struct pwrseq_qcom_wcn_pdata pwrseq_wcn3990_of_data = {
+	.vregs = pwrseq_wcn3990_vregs,
+	.num_vregs = ARRAY_SIZE(pwrseq_wcn3990_vregs),
+	.pwup_delay_ms = 50,
+	.targets = pwrseq_qcom_wcn3990_targets,
+	.has_vddio = true,
+	.match = pwrseq_qcom_wcn3990_match,
+};
+
 static const char *const pwrseq_wcn6750_vregs[] = {
 	"vddaon",
 	"vddasd",
@@ -328,8 +401,9 @@ static const struct pwrseq_qcom_wcn_pdata pwrseq_wcn7850_of_data = {
 	.targets = pwrseq_qcom_wcn_targets,
 };
 
-static int pwrseq_qcom_wcn_match(struct pwrseq_device *pwrseq,
-				 struct device *dev)
+static int pwrseq_qcom_wcn_match_regulator(struct pwrseq_device *pwrseq,
+					   struct device *dev,
+					   const char *name)
 {
 	struct pwrseq_qcom_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
 	struct device_node *dev_node = dev->of_node;
@@ -340,11 +414,11 @@ static int pwrseq_qcom_wcn_match(struct pwrseq_device *pwrseq,
 	 * 'vddaon-supply' property and whether it leads us to the right
 	 * device.
 	 */
-	if (!of_property_present(dev_node, "vddaon-supply"))
+	if (!of_property_present(dev_node, name))
 		return PWRSEQ_NO_MATCH;
 
 	struct device_node *reg_node __free(device_node) =
-			of_parse_phandle(dev_node, "vddaon-supply", 0);
+			of_parse_phandle(dev_node, name, 0);
 	if (!reg_node)
 		return PWRSEQ_NO_MATCH;
 
@@ -360,6 +434,26 @@ static int pwrseq_qcom_wcn_match(struct pwrseq_device *pwrseq,
 	return PWRSEQ_MATCH_OK;
 }
 
+static int pwrseq_qcom_wcn_match(struct pwrseq_device *pwrseq,
+				 struct device *dev)
+{
+	return pwrseq_qcom_wcn_match_regulator(pwrseq, dev, "vddaon-supply");
+}
+
+static int pwrseq_qcom_wcn3990_match(struct pwrseq_device *pwrseq,
+				     struct device *dev)
+{
+	int ret;
+
+	/* BT device */
+	ret = pwrseq_qcom_wcn_match_regulator(pwrseq, dev, "vddio-supply");
+	if (ret == PWRSEQ_MATCH_OK)
+		return ret;
+
+	/* WiFi device match */
+	return pwrseq_qcom_wcn_match_regulator(pwrseq, dev, "vdd-1.8-xo-supply");
+}
+
 static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -391,6 +485,12 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret,
 				     "Failed to get all regulators\n");
 
+	if (ctx->pdata->has_vddio) {
+		ctx->vddio = devm_regulator_get(dev, "vddio");
+		if (IS_ERR(ctx->vddio))
+			return dev_err_probe(dev, ret, "Failed to get VDDIO\n");
+	}
+
 	ctx->bt_gpio = devm_gpiod_get_optional(dev, "bt-enable", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->bt_gpio))
 		return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
@@ -432,7 +532,7 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 	config.parent = dev;
 	config.owner = THIS_MODULE;
 	config.drvdata = ctx;
-	config.match = pwrseq_qcom_wcn_match;
+	config.match = ctx->pdata->match ? : pwrseq_qcom_wcn_match;
 	config.targets = ctx->pdata->targets;
 
 	ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
@@ -444,6 +544,26 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id pwrseq_qcom_wcn_of_match[] = {
+	{
+		.compatible = "qcom,wcn3950-pmu",
+		.data = &pwrseq_wcn3990_of_data,
+	},
+	{
+		.compatible = "qcom,wcn3988-pmu",
+		.data = &pwrseq_wcn3990_of_data,
+	},
+	{
+		.compatible = "qcom,wcn3990-pmu",
+		.data = &pwrseq_wcn3990_of_data,
+	},
+	{
+		.compatible = "qcom,wcn3991-pmu",
+		.data = &pwrseq_wcn3990_of_data,
+	},
+	{
+		.compatible = "qcom,wcn3998-pmu",
+		.data = &pwrseq_wcn3990_of_data,
+	},
 	{
 		.compatible = "qcom,qca6390-pmu",
 		.data = &pwrseq_qca6390_of_data,

-- 
2.47.3



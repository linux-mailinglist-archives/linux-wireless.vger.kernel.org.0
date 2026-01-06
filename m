Return-Path: <linux-wireless+bounces-30369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4354ECF6480
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 02:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 350E9303E0EF
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 01:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9804731353A;
	Tue,  6 Jan 2026 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IT10/NfK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VqFn2Hx8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9813F312815
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 01:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661295; cv=none; b=VQSIWK+lYeCTi0+5hJPw1m7mknPshLb4JZCMQzyyrisb12ViLjWo/iADB6nKhX3iKMZb3+QOBnuwn/r9k4tmCAm1kS6xGGhdtAfvZWuCfPKkZIHOGS2GwTslgOgkRd55sRkFoQevDwpQYGmd/IaMDv0y5BV/xIUF5V7hqe6N3/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661295; c=relaxed/simple;
	bh=RE5x+iyzWkq+myL/UhBPksXnYELVIZK7yVIYkyV8M9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dvF61XYj3VlBdboFlJAcqW2llyMHiCzxUDSokmkk2qTzbWRbozsAdDqMV1HlpT8SHVfUvMb7HRIcCDmmcbi3y9C0ZX5O+ZwS9es8qVs/C79rZMjo04xBqWKCyQxsseQvIJBWszrKmVh1wPvSMtQVcn273Ah1iQMg7jtaXpbB1mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IT10/NfK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VqFn2Hx8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060oJQO3116770
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 01:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9OuOUyprpOAl+aN/Pwr6K2wJvLACCaUnkXSkdJN8k3E=; b=IT10/NfKS6xP5lck
	HZNGYuQd6GNJ0jAwS6vc39GoF0T4oGbupZrEQt7by6ctp8rH8dNLBp7f6/HCdDEX
	4y8Z4U4m+qxOnY2xF44VAIE43W8/ZrMHZ4pny9ENVEpQomVIsnLMPXD+b7prC/K2
	Dcc58m/fKYpR+UigE98Vn/DTjUB95yqNJxrpb5nrXsoC3WSpqcW+bZhSNp0YI732
	Nu0AV+hovbzY+ZK09GAo+HZpMRb22Kjp2OTStLEEIqR2sUANpIRCrZRnEPrb/nbF
	er9L7HcQv+4r0wxlQbKQmqRb6r/j9cYYwQqZzUgZdoBR8w4GCQ7P+019Z+gA9k5r
	m0H04g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgmnh8gx9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 01:01:30 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed74ab4172so9943621cf.1
        for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 17:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661290; x=1768266090; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9OuOUyprpOAl+aN/Pwr6K2wJvLACCaUnkXSkdJN8k3E=;
        b=VqFn2Hx8ZmZClYExxl7rrQJvZUdqFYOgw2Gs661qwIjJPw/xLM4UdZ02iOJnVFHVWo
         cadYn/JhmiopR374ZznHOtAXNxtCT11ZjSJWchCydJcrknt2n+4/BVzPyPak8+l9dcdG
         5lx9U1KBSelyfnvgJbEYkHPug2eqxZA9rTAMXu9SCNxjKUG0CJZkrP9CcN3wYSDgwrq0
         sSKJ5qxpXNLNOVezkLp24hU3Ki5krFm2zbEj5FiCpdn//F8Y58wtq+FqdplUxC9Rb0Dc
         udP+P1w80c69d6TgWGwyoCR5oRR0NjDjZR69YwmmSfaN9ULH3XzGjqDoOkk4wyBEPgmQ
         YnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661290; x=1768266090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9OuOUyprpOAl+aN/Pwr6K2wJvLACCaUnkXSkdJN8k3E=;
        b=dB/f+ooD2MdJYEZEc4jjONG1kBv1hk3mwwD9HI/DheYSZaBTLTQQpUt3PQb07aMKIy
         PqZZD/dkkXGjjMwyyF0epZhPHXE21Als/4Cwj7XBRSzoF9CqzE+xASWdnjbuH3l9FPeF
         m5fdu75RBpAoSen8StIREvnA5K2jIhkma80sYJ4Mp/z1MxWWPujnIbeKqy1X1y5v4QrY
         MH1RcF+1gr+TIcnsN1a/fadOJARwHDc4nlB7SBNolDyyVd2iuHyV8slnRJXDNEygE184
         VuG+wbfA3NFUov5mKQcg8v8+bAJDfPX0cR0ayZDzYUHbCdnRp6IZgMUuOBtYn7fV8piJ
         DsMg==
X-Forwarded-Encrypted: i=1; AJvYcCVk/fLEZb7vfAAlxv8pXQewW4ybA1OtaemBwkgyRO+hVo85CMjNMaf+Q7qq58ZRRDmFEp2rwXDX+Ay0AxJn2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNXFf3poRV4J0DN9mXhm1v1fcPEIh1n3dvtlbV2dWJcxPdFStL
	x9dUSK1V63T7GGU+GjlrbvTO/102KhMEE6VeAFD73b3UiQ7RlCP6uYyKRUqkpa/GKRRJHgowOuE
	IYppjUXmH+CdO2F5IdKg7++NLzetSAys0FNR9tx5lLdgndNiDR477EOvpZPtETwUq/PdgRw==
X-Gm-Gg: AY/fxX5QGQOhF/JDPq0gfELsuT4lUd/y39qTlFS6wyYIuk4esJYnVBVZOZ0scRg07JX
	MJqKcoLlIREK/QPgbSBBf5kf69aKEf+Il6IHIPRsJ1d4MmD3Fc/CrtkDNb0j3UanJN5rJQfzcnY
	4MPPcnRJON6joiZWyZhM/rj9WKNLRRF5efsqhI8eW3yprcXnciy6E2FCbpajdZurHtSv7E/FoWU
	0xYtMQMeFECFfzDVw3AePt4mFckzCNubX6ZyqpEZ3hTQM+5t1t8yE96j+JQeOf0aOFSj/uKSfFz
	oOdW2ys1coFsA6Uj2wANYPeCIrz6oXKxPfYPYPK/4C1jE6nUO89FKo7KT/wtTu8vCHVKOPi5eln
	Y/yrjZVydLEPKMEKKXGL9vojHUg1SLmlEDqaXjUxvEjmA8psAAZwv8eNSL95D9jhZyZLdQPZhSz
	N53dzwJpPNsSuMIvKkVAt3IoM=
X-Received: by 2002:a05:622a:1a90:b0:4f1:83e4:7247 with SMTP id d75a77b69052e-4ffa77edba0mr20001931cf.60.1767661289783;
        Mon, 05 Jan 2026 17:01:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+5IzIJNwWT75Bh0S3llMlTTaHsdE2oxSePDzByPLYAXS5enj4ixoORoDpw3xOvmfFuqxWEw==
X-Received: by 2002:a05:622a:1a90:b0:4f1:83e4:7247 with SMTP id d75a77b69052e-4ffa77edba0mr20001301cf.60.1767661289211;
        Mon, 05 Jan 2026 17:01:29 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:28 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:15 +0200
Subject: [PATCH v2 05/14] power: sequencing: qcom-wcn: add support for
 WCN39xx
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-5-0386204328be@oss.qualcomm.com>
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
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8156;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=RE5x+iyzWkq+myL/UhBPksXnYELVIZK7yVIYkyV8M9U=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7Z4PYSXJjreNhQo0g4VN4zQEJz72nOo1Bsl
 FTSkKEYZFGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2QAKCRCLPIo+Aiko
 1RmVB/4znVfiyGXJsJwane98IRGdlpZTj++hBTtO8qlpJ6T9RmVDgopL0fKjfWEaPcJEQ3iWAyR
 QXN4rhcttyl/0FA5p1JPIAtrvn9FSRUzBycGDMAsiOZ5HTB4jVGAyde5LsLxT1RSIs0lVKcTL7p
 +BQKu22ovgITvebJuSaEhuyheuBrTN1NA7VoNsuWNwA7fPcDI3Aabsr56NBTUlWBUBmPvTzJjr6
 aYKOxo4FVqWv5N5EOsoHhFFDW021GdDSaedsiXdLpNELmzNtABGj/bIGew5Mn64H4fnurnp8pKN
 YNSDDu2HuDMtpgVg3zCw7RPhBeziSqABstLqS2QDKCKpjpe7
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: GzfcOlnjH-UJj7YOo8I1vK08xfCf6Hjv
X-Proofpoint-ORIG-GUID: GzfcOlnjH-UJj7YOo8I1vK08xfCf6Hjv
X-Authority-Analysis: v=2.4 cv=Vscuwu2n c=1 sm=1 tr=0 ts=695c5eea cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=I1O4o1mkfA9rNPu_QXcA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfX6mpdki8Ws0Vg
 ktaY2EnbbtPDTr9ZJZ3EQH7IXUdKf04x8vPdsPxKMKmL0lG5hDWHjh999DsntYUKDl8pSfFM5xt
 dxdBlorRXDK5BbQrtD49A3Rah8UfW6bj5iP+BRTv+U6yB7sIMb4/bg+dIJZPjxkRKTp7L/lRJAX
 kFk1MHIHcG1B2dOYlb8rktkwhvDC1NlCqAXEWYZkHMtI+eSExJqdbgJkKQkh4tJUT01ei4qDjCZ
 dNIe1LtBQiDsC3kiaogABDmHGI2qYy4QY81WdOtpbYcNFwikn++t2Ukxb3hxZFyMpxfZLsgZ3lQ
 +GZAXoBWx0wuPCmOEwwR+kIjVZ0fNfPaI/mpPvFnIklum7K7yOCbW2/+cpy6sHwjHgAWLizmvGi
 G6D3PiKaPWieG3FZkb2mx4fOyW1T+ZAJzioxP/oEIfr8CxEShN0rvQOT85BCoWwSy/qeUAaqLvg
 HeCyp7zMLy+79diQL/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601060007

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
index 663d9a537065..c5071708e85e 100644
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
+	"vddrf",
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



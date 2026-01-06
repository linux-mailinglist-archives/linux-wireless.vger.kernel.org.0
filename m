Return-Path: <linux-wireless+bounces-30368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 484F0CF6487
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 02:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69A5B3024240
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 01:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43BF3128AE;
	Tue,  6 Jan 2026 01:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iJND170N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hI1V/Pcu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC743126C3
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 01:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661293; cv=none; b=CZszzTOz83DlvxL1xCvTBZxcbrPGOG/0k6tDB9K62YPYjqnrmzSrUeLXth6F2ZVFbXpliV12L+7Y2W4Xd0kDXjtfdc86zK8z3r+/yvgXnO/s4jOHvUPcuSCWzUfI19lIjKx0YvzYADxXatfklkv2uH036QC63jmiqcn/bKKWnHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661293; c=relaxed/simple;
	bh=vGKw+wEv4m8AuXcSbM8ug5QUp/CDr75AFUCT++yOsvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QQf9tJNutlmqQQVsh/JgWpJn4JSa6Xew4FbxiNYCQyMdXPHmrtyE55GogrfLm2MMMRWOqP+S8OHA2oJ9f4dUhoeSOh3UBpTLsKoJ5eGTYCmbixLVAtuiB4zrJDuCGdWzXdFtLfm0I1rt9d+HbdzWxnhhOVNWfZdhU5ISqklhK+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iJND170N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hI1V/Pcu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nKBf2969875
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 01:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	toWGAj7SgswRPrjJQFNYvHcUGCLQpi1FqKeAVpzqbvU=; b=iJND170NW1tlBMQB
	HYoxumSS2BP8uillqDNEGwEiprL8Z7jNmZVPJApMFMAswdb9bJ5/1fFbcpSsYXM8
	Bqsy3M6n1ZGBsDyKJvrS9X2Kmt5VPPKKfi/6jeViftU15HfJ0cycqXdrXQHTw2k1
	KtTh5+2/44vamyxPnAyfJXVhEMmZabVmzQeAi1AdKzkHWnBfF3dYwlXbP2E1N3AU
	s3iVAyZUUpAD45jQieYRy+3SX6KdHNLSizY6ULzhaaCxQ3JaFittHSPyC3v762Fa
	PMw+Yj2Km5cWQ2XIReRVz9EZraWD5CGdVvxEnM9FUuEpnOoTj1Y62B/VSv1+WkqB
	AOazbQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bggsvs7q0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 01:01:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f1d26abbd8so13289401cf.1
        for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 17:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661289; x=1768266089; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=toWGAj7SgswRPrjJQFNYvHcUGCLQpi1FqKeAVpzqbvU=;
        b=hI1V/Pcuney3KEUzHH7oey1/c2QYHF7gZxDAkxlbGx1Y65vx3UkNHuVzkF2i9ZYUoC
         sCN/hjSh75u0nTWPSkmy5qTBpckqewxP+ExuxQAXfvuLa8MtiRCKCwhTgQUPxHuZukwO
         jh74JYlxJB4X8b3VSdru6t0Z2BE/AZq5FwwNGrb4dM0PnXGSL/9sHzgIFvmFeC9gPcPI
         +5JfNc87uAAjdiEE5KZ5QCEXOpXu8fehQvRte2AXRpsz/Zq6uqj75laZe3cD81Pdv55R
         5VTS3Zh9brl0UR/jUt/pp1DurN0KbLattkza8+EBMKxEeQBC9m7bOOxe51yv/MC9NXEo
         T1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661289; x=1768266089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=toWGAj7SgswRPrjJQFNYvHcUGCLQpi1FqKeAVpzqbvU=;
        b=DJhHs5WzQVuzVbFfxvq8wf4A6zGsc4QwYd8qHAphYnbvyORkDvhYwGI+iM5w1VT/2b
         RqT6wZjmYcdaAr47mfJcOj9WCG2pWmuBSeSgB30MBtApeb8sOxE03tn0ZoWWftMXzUBk
         YSi7n0RwXgXyeCMMKy6l8qntN0tMoQBRzVuPduF4duQRYRWwSuCnOFQgwz5hba8SQidj
         6kzJI6kTuGuK+vsJP08KFfA7m5MY6FeKrGx8/RHht2IyHSqFCFD5EqxoC5fuYvgFZ6lv
         /o+AfUllkpzutY2s0EtvqbURNCH8ay82Uon6uU5aasDj/TB+RafQd6qLx+1w9cA0uWWv
         ICPA==
X-Forwarded-Encrypted: i=1; AJvYcCV4+vYRM68XL31T3I6ekrGy/sJTGU+zfwDSc7rhoLdAAMAJ/P7JDi0MZAouxIjSUOpb+bRsoU4nxDpw0jB/bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWGac2fVhHNo7moxZxLdOhbDIOAojyapuQqoscn8OexqTJvntd
	e6hAdGAVP6R6T+ROVEuZjXhnnWO+iQ46HCQ6x2ehCO2v3SoaV6hB5YaBT0iMlt/toi+dTli6wY5
	2bYjSmWsOeYhBkuavR2qryAfKgNg/R9q/6xUUeI9J4LatKzJ41s6ZJfpI8mZoLOWp1GuDow==
X-Gm-Gg: AY/fxX7aE5nHozB4pgbRggt5BwzyCPNLXarf2PUhAaRKiBIRn5MZKuBobvQajUz1HS9
	4a2YLxHTENgCOf5xW5cuyeuhh/oFfTv0TCNYL+OXvp3Yj8vQ/NYRlI9tqPPwOEuk6Yf+uHrIbKp
	C5dv7LzjwcsYBWSz0Vz7aeONH//+ZJTN2UOhOen76RaQs+S9reLk2ul5Y7EUo7PeKhuQoUBtwqe
	xiOv2qtAyhquZUdo56wuq0cyVacbOcgLh0Bg/q2p7KiB356HSakEQBNYNsFuZSESTmCVGlk/3qP
	fpzl083WUWEAmj2UVq78IYG301rHvyP23F2kpT7YiQ3DUyYy288jp/ZwDI/zHaMqLEtquyLmxF+
	1/5qyFBQwG4cq1jIXo9TM2XzooouRIz6YVNmGCbU3dlLl+Pr1jqPUNVTDrv06Ziv9Mpi+SQRQgT
	QOk3kNTLd7c7tt0OrOvYM3lqY=
X-Received: by 2002:ac8:7d06:0:b0:4ee:24fc:bea3 with SMTP id d75a77b69052e-4ffa770d84fmr20866101cf.35.1767661288600;
        Mon, 05 Jan 2026 17:01:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGRIkm3qB3iAMhjMsr9K7RBdmhsGoeWiJuR1zZQW9HRAWrshi4AJ0+6RJy7rL89ggSBiDVrw==
X-Received: by 2002:ac8:7d06:0:b0:4ee:24fc:bea3 with SMTP id d75a77b69052e-4ffa770d84fmr20865361cf.35.1767661287983;
        Mon, 05 Jan 2026 17:01:27 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:25 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:14 +0200
Subject: [PATCH v2 04/14] wifi: ath10k: snoc: support powering on the
 device via pwrseq
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-4-0386204328be@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4482;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=vGKw+wEv4m8AuXcSbM8ug5QUp/CDr75AFUCT++yOsvs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7Z98G7nWfKXlYg2gNCIQMwgRzHPZzJbxVnJ
 z1q/ZSkHjaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2QAKCRCLPIo+Aiko
 1fEZB/4tvPMVzx1O9X5hVg4SC8qKvMxE3IAdsH/tCrsqATAl0+wRT2TyB9Hn7GAeWvGOctHu3iH
 Wz1nzZlcEEGfMaeWu5SwWMpltRfuQ30OmP73iSkLDJIyDkaYgNS18F1gFf+O6ny0yTUySKvTrcD
 yyXDgiHMM2btCQT/nwRoSHoTn9L8puSf+qIsWNnwNXcYhQ//We6KROhs35aw/OlL/hwOSrlP/S/
 5HwYUn/Y4mmzJ5Htk1E8M+w9R1szu/pRNZ3IJKY3GuKUB9KSiWfh873JV70NTtpLblRXY42mIM+
 v4EhUqx2idwTvvn1tfM66om+MAtEwG9gtY9dLCdkm/h9l9Pv
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: XeXlnSXS4kuj5Wpb64qGv1vZCQFdJKhi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfXzd6YDb/6vhDM
 5HclWtGye2SJhQ6uVSnqJ2QpOi8AKx5ehIeAtVAsTLhGaMnbRYGtBPRUSONbgCy2H8Wzl18PUo/
 SsZwIzjq+uSd6qqWQFFtHW/Decpsr8KrJtneb7/mJZf+/Dl1fOm0vaPXCBxWcwMaNl5dCiLU/NR
 AAZCfYPw10RGjcPw7PGw0kdEmzRP2Dnrij4dI/YygeejfyxhwnZ8ab5T7AqQqrmiW1WPjlPJ3Q7
 zd3kjCgmb7ibT0nT24TM/1sSKtwKPY6sfSE3+XDYVN1xxCYQ4VlF/ORmfQyrFZkc1STmFHjNapn
 F4mnEPjKCu/EwjJ+jfAhIRvl0GTI+8nX8kFwrQc9ls73a48iHsZDFEoWxe15W7Ijyskn81se6u4
 fDSja11FsQDEWQk2bMp9v1DZ79fxC9+Mlgi4gXFJMnEPnBPD5Td/WdGsM0+HKTvwAD16QqefYvh
 r4pWEEil+6G7u+GeStQ==
X-Proofpoint-ORIG-GUID: XeXlnSXS4kuj5Wpb64qGv1vZCQFdJKhi
X-Authority-Analysis: v=2.4 cv=Yv4ChoYX c=1 sm=1 tr=0 ts=695c5ee9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=JZG1H6jYz0umZupwJd8A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060007

The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
voltages over internal rails. Implement support for using powersequencer
for this family of ATH10k devices in addition to using regulators.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 54 ++++++++++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath10k/snoc.h |  2 ++
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index b3f6424c17d3..3600c8eb19a3 100644
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
@@ -1762,7 +1779,38 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
 		goto err_release_resource;
 	}
 
-	ar_snoc->num_vregs = ARRAY_SIZE(ath10k_regulators);
+	/*
+	 * devm_pwrseq_get() can return -EPROBE_DEFER in two cases:
+	 * - it is not supposed to be used
+	 * - it is supposed to be used, but the driver hasn't probed yet.
+	 *
+	 * There is no simple way to distinguish between these two cases, but:
+	 * - if it is not supposed to be used, then regulator_bulk_get() will
+	 *   return all regulators as expected, continuing the probe
+	 * - if it is supposed to be used, but wasn't probed yet, we will get
+	 *   -EPROBE_DEFER from regulator_bulk_get() too.
+	 *
+	 * For backwards compatibility with DTs specifying regulators directly
+	 * rather than using the PMU device, ignore the defer error from
+	 * pwrseq.
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



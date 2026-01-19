Return-Path: <linux-wireless+bounces-30969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F16D3B47F
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 18:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F1E53029BFE
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 17:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C05B324713;
	Mon, 19 Jan 2026 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Phequo9S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VDd80JvC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FA23148B6
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842485; cv=none; b=h4mW+3FXC/+THPB3x+sRH2RL9mXyDK6o1irB+8CASc6ZjLhrgUkOkUB+Kcp5eNn+9bzhzq5CB28EZYjT3rMuDeniEEbV0N/WDLAuy7jdRM+6XH4K4ngSOtvNDMvURL70UoMsuIYfeE1utPrlSN/OyMZ8imt73zpHQ7EvsIezoKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842485; c=relaxed/simple;
	bh=8ro0A6tVVAR8N1a3EJt6gZeL+nfKC2FamuLo+mTTcgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nmGwF1Xgi5UXNM7IrTtTWVhkhIDLtta2hhoA1hi7Qn7Cdgt2R+4kVza/xavTyYmmxbAk9hHHjQL0toXA9Pv/yXxU3KUcnNdbfIGE7DPVeeemje0ZBJBYDSkOfMkgGCU76ajzmOYBfRsmhhDgu41+wDTI0kOhERVHQsYCOgiSgqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Phequo9S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VDd80JvC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J9mxnG2965063
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 17:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SuVJjvlCTXRFYAFx0rLVTZXUOY4TgeWGafNaZ/GaNBM=; b=Phequo9SA/a/PCp6
	NlJTaZczZwRqq5IeMCtKydM+r4rs+si1FNopaHWIet3RsQT+eS/jbWhJJh4fyxQO
	vQXM0Hw4lqk1857DMIpaXnUu7ev9iFLv/J5BqPXm3ENvNSCnP509TEa/l89uiQP4
	z5LO2Db6QVmS+wvwIG0Q1efI2idKPV3YdotGlQ3o+skN5/LP+9pp9t5i9vfA3pvE
	9Fi9E2QDq0GPHSjbtgrpE3BPCE4hqTjlJTQilOjHxdfwJHUYv1ALyfhY6FVP0C1X
	IeuoGR6RPRPKAkDHRAgrv+8ozc3DifumhNmTn+Fckove1eazGIRhNp3V7ceZYNqp
	uE+Eqg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsjaa995x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 17:08:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c53919fbfcso1096988185a.2
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 09:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768842482; x=1769447282; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuVJjvlCTXRFYAFx0rLVTZXUOY4TgeWGafNaZ/GaNBM=;
        b=VDd80JvClWjQzDLy4AbsWcvp1PRqqbyPkZUywD2G2cSeMADC7i3QkuiWDGDO7Xofp/
         kD6f21HbGqRNmxjBixrorR2Eqgo0/v3KDsTuLuxElGaGofA8OjNF4Fbm8KJZAnIeL/Qg
         okqg7YAprQR96jCn1EiyWHcjO3h1KYAiIZjKHeoDkkx6LjszFWhgQ032TZNypUKlw/z4
         bqT81gKtdYFOX1h3LSRssliU81F66ZOQb7nTmwtAL3+yf+rcy0cuuVV9Ko8P4UWfIPcK
         3oW7AHvjxSh5aWAZHiQgkzTF8hJ+HIUwsCAPdc1DvpEoi6Ml4YwS2WsvDCgN/MQlpCP8
         hdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768842482; x=1769447282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SuVJjvlCTXRFYAFx0rLVTZXUOY4TgeWGafNaZ/GaNBM=;
        b=tdhOnsXaX+lHQBdaANgnYvhoa/URuPMkmC5lptjkE0NGHK2XgXPyT+bmRVUHcsdVrC
         JsP1slnEIlipTos/qQjhVfSi6XBQgT3pSRirpaUZtri0+mx3tpT9RaAA2NMVQtxnVD2n
         04M5zs1sxgPZDZSVmMNjq9d+p406CKEhYKnI7G71RF1nz+s1Z+6KPmfN84sfiQGdvunK
         u1FWmyz35fawGl4FaiBmlXj+srMeiBLdWdfUkSNwQnMasyRiisuwQvc5KopdH8oFAPu/
         YhagaG0HrWPh8Eqbm5iCdu1gkMxFbbyXXYjOLD21uZSH5QB9gszYGzHPJ1vX2IdORjRk
         QeSw==
X-Forwarded-Encrypted: i=1; AJvYcCW3Ei2bbbj+LlcXwhmPRfK1qDMH++r1yxkqDGAy15qhTLH4OltNf1AGOQl8wXvK20j8Lx5f7vjFRdpGAmx1+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNGYHoOoavE3T/y2O0WZct1g2Ui1VXqGGOwsRNXEelXlqppK96
	Wc1m9r1fL1OQehysQ7dfuYlLNs9HmZtFmztiyI4NRdn3cXO7JQGhJBBpFYaNu1g9I9/CDYeeeRV
	mHhuHC69h5MDSlvhoWrAzWwXf8QGvTpvi8UozTuAt65vRQMip38xXf4JIdXpyoeQ10HHSdg==
X-Gm-Gg: AY/fxX4j6RD35PlQTjF8yqn28sWKelrVyGjojnMi75+IJqhYaDWnhqCbuo0MxIrqqRG
	8MaW+hrw92zOI4o7Xo0hNtvLeGbWThhICnVd95uC7b7QeZZQefhM3mh+wvs7LmJ6YPTMo7UfuS3
	1Ic7nauOU5rv2bA6jYq94RTAFiPvMaBubQjFlnxh8XLIyOINhuvBbDtO3nDu2+PRbkY/qIPANQp
	eUQaYrFRRKcSXYMV1oLSy2sCSMOkUi7clx0NO/EIFxa7IBBz9TdgO8q1wjPGEg1bSq9QQXBlCuG
	m95ACHnWQm4RNY8DqDI+sCXz86c8a5s4uiNDY3tNq6pcgpJrtpG/BWMX1qmbAfMKZS7/5M92wF9
	9od9xXfx7T4APdHEfH9B+dR81uvdRd1t7hiS1QZaz8Tj65WMZxW2W0SwnqWh4Qb/EOnirc61VkE
	xFCVeRRTW9zdQf2IWhvGg75Qo=
X-Received: by 2002:a05:620a:31a0:b0:8b2:e6b1:a9a6 with SMTP id af79cd13be357-8c6a66c833dmr1553064985a.17.1768842482477;
        Mon, 19 Jan 2026 09:08:02 -0800 (PST)
X-Received: by 2002:a05:620a:31a0:b0:8b2:e6b1:a9a6 with SMTP id af79cd13be357-8c6a66c833dmr1553058985a.17.1768842481942;
        Mon, 19 Jan 2026 09:08:01 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384e790a9sm32661211fa.26.2026.01.19.09.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 09:08:01 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 19:07:55 +0200
Subject: [PATCH v3 1/8] Bluetooth: qca: enable pwrseq support for WCN39xx
 devices
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-wcn3990-pwrctl-v3-1-948df19f5ec2@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2075;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=8ro0A6tVVAR8N1a3EJt6gZeL+nfKC2FamuLo+mTTcgM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpbmTtJkjq8QRehFWdJgm9SxyOHvINLBQgHL/BO
 cfn6uEaosiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaW5k7QAKCRCLPIo+Aiko
 1dYSB/4mAIVY1Uxgf8lpFuKOsE8xM/V+Rh7rNNYEBCcBFyqY7YknsndW1uZpnqvilai7bnfI/Op
 nIxt8kq+/NYZJbRHnSlbUFkqCBgOfzIxabuLUwlljRP28UvhPnIcKmvYzcHsx0/1O7vql3olS48
 Rx6E+Te7MXS+JhR1nrjfchlvXIxv3ZBIJR7zHMHfh47GMNJ7qSKkKmWM27Jr2glV9rskj/gYjLC
 F/mOIczZumwoeoKoWIXqv85nKT2P6BzJCeT83mPZsp53Fgpp61D6nn07ZRvR/mv+o1FpbSRVqtc
 6ErJ+ElIWpYIknQPzscQ5kNNhH4dp2bX58K59Ooi0UUUoofS
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0MyBTYWx0ZWRfX0d0x505qUpUF
 5DIOvDxmuNHPv9jfnYJhpLl9ZgS4E/vtxIQdWDUT5NCQ9aSjys9av50nsWqOjGt6XBgd8bt3Ey3
 pXcR8mO4A9ZPgwLV/zx3KL1lJTFI5ujOZpvZSOuQUK52Ta9S7j2bYvCJm4TFnyB7en9FW4hlG3Q
 UKi7UQtSdXApG2K7zDzfHW4nMLH5zjYf8eevh9f95Lxpexz/0KivghagwUY/YXx7/L+nUhJUmyx
 MhfENDHtJwJa8HTuCrr4gm2+4GHKpajWSIBYD6H4iK/t+T+ZBVMs8bocDoOMTHB1vq4Hme7ijr/
 krrezoRBSSDz4F5NL4sp4620uoXOCnx9tExB0vNtddyw4zHPCYheBK/c5p7sHBMcfSQWQ7CBFJI
 24b9fwGjf7GchVCjrTGlLsqiXaSrZy4yCNzeTtcalNgw4iupQRRZ52abj+LYjVqPF+Dx64N9p+H
 KYXlD8tejQ4Cy6V6WWA==
X-Proofpoint-ORIG-GUID: qBNUZnuzHYfW6XjWcWaGAH9dlsCStadk
X-Proofpoint-GUID: qBNUZnuzHYfW6XjWcWaGAH9dlsCStadk
X-Authority-Analysis: v=2.4 cv=L8gQguT8 c=1 sm=1 tr=0 ts=696e64f3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=WNkeAZsnUospxCs8hJ4A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190143

The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
voltages over internal rails. Implement support for using powersequencer
for this family of QCA devices in addition to using regulators.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index b54350317a43..d1402a344063 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2230,6 +2230,18 @@ static void qca_power_shutdown(struct hci_uart *hu)
 	qcadev = serdev_device_get_drvdata(hu->serdev);
 	power = qcadev->bt_power;
 
+	switch (soc_type) {
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+		host_set_baudrate(hu, 2400);
+		qca_send_power_pulse(hu, false);
+		break;
+	default:
+		break;
+	}
+
 	if (power && power->pwrseq) {
 		pwrseq_power_off(power->pwrseq);
 		set_bit(QCA_BT_OFF, &qca->flags);
@@ -2241,8 +2253,6 @@ static void qca_power_shutdown(struct hci_uart *hu)
 	case QCA_WCN3990:
 	case QCA_WCN3991:
 	case QCA_WCN3998:
-		host_set_baudrate(hu, 2400);
-		qca_send_power_pulse(hu, false);
 		qca_regulator_disable(qcadev);
 		break;
 
@@ -2414,6 +2424,11 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	}
 
 	switch (qcadev->btsoc_type) {
+	case QCA_WCN3950:
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 	case QCA_WCN6750:
@@ -2438,12 +2453,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			else
 				break;
 		}
-		fallthrough;
-	case QCA_WCN3950:
-	case QCA_WCN3988:
-	case QCA_WCN3990:
-	case QCA_WCN3991:
-	case QCA_WCN3998:
+
 		qcadev->bt_power->dev = &serdev->dev;
 		err = qca_init_regulators(qcadev->bt_power, data->vregs,
 					  data->num_vregs);

-- 
2.47.3



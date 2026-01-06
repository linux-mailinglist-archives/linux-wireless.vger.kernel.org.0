Return-Path: <linux-wireless+bounces-30366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 535E5CF64BC
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 02:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04A203029D0D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 01:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26A82FE071;
	Tue,  6 Jan 2026 01:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jQmbv7Hm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U7g2+wcM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCCB28D84F
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 01:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661288; cv=none; b=oOVtVxL24K8n0nzhN223iz5eoGjw8D30CSJt0CmSVh1DuOHGyAfFitFZIWpGWZ4BGL3ivAb+bjPO3DyRex/OVEHQywAaEhnMdlAyu/tNr06Jo7hALp/ZIzjYj6FBQVHyRm+wT9ggo4S5Op49HVSyMKNf2VEMbLt9HrpURWRk4bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661288; c=relaxed/simple;
	bh=8ro0A6tVVAR8N1a3EJt6gZeL+nfKC2FamuLo+mTTcgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S6uX3Pjw99cWWZrWIDq4ViiwwxrcrXaK3da9Rhg3rpuJHJLIgcpoX9d/1iTSkskAN/pjgKNG+HlT9d6AtzbvEnh5QZVAG2bG5OIZSMoA4rySUQChxBcH5dnK57vjIDrtJ1B56L0uLBHZbiZyQX6Y/It93QD4XW7D3GZR9nZ1Mto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jQmbv7Hm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U7g2+wcM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nUww2597642
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 01:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SuVJjvlCTXRFYAFx0rLVTZXUOY4TgeWGafNaZ/GaNBM=; b=jQmbv7Hm6oM7Fh9T
	PsbD2BMkMvJs2UioXCo1W5VCFS3fhze52LW/etURrC386p5MtNw824OiW05k2eSF
	js5GvLofGI5vymuNSG5h8FU/VaeReoAAzJuzty5IG7MPEIZVDVyOvGhsChH6429a
	tcnA7x5TBFdUPdMDRDS1jguEFYsVnFlL4P529MEF07oazVQSz88Hvb7QwrdcXYD7
	cG3qnoxsQOg335m8ujGk6KDzsqfjYsFf8FQNcqx1sf4Gg/9bbwylSPq0ZbB0WHMq
	gnRwQJ/GMNjBeQomqRmoqmXfpGcaYTnnUy4LCjK4g43G+mYuKOiJ2MbH9P8hrlSp
	twXDLw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bga8pjer9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 01:01:25 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88fcbe2e351so60784126d6.1
        for <linux-wireless@vger.kernel.org>; Mon, 05 Jan 2026 17:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661284; x=1768266084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuVJjvlCTXRFYAFx0rLVTZXUOY4TgeWGafNaZ/GaNBM=;
        b=U7g2+wcMMiOQA49DU2gJFYtwYPVJUzaUFP2aRCj+lbflNICwWeuXla2EIwEPqepmn2
         j9ZFdTzBAtgLUVsRWE5rReCxrOq8r9qwDR29NfM+mFXVQkxt73LqJ4v++Jcq8NYHYXMb
         7340MumXKM3xahoW6tmAqVxsRLvIqvvarrjh/F4DFhZQZIzvDBSmtPmwFzoIo98JhPlt
         pd81xo/0fw+srrOd4AcE2ncN+TA/hphjV5+ZXMlaCoqEGAtVxIQU5OP2sSvh/So6B4yL
         XFsCXyzvLgBnp8K+GGhN9gYcE595ODliDk61Se6heyu8IyvnmVM41ld1A3L+yIxStZwj
         BmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661284; x=1768266084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SuVJjvlCTXRFYAFx0rLVTZXUOY4TgeWGafNaZ/GaNBM=;
        b=wBCDwu7n+jfiE9uXNrngBVKJtcyiEkyMqbD7Yda9U2W6zkNYUYMeY42SvxApR0oKq2
         o7q/22IVkDMb7aUfMGzUBa5TQkbVFObWzoYuZYJR2CpWzadcEdRCCr3RhOvj4e7FVjA2
         LIq+2XzA31vUdoadPAB9tPP87xh+Fm9BJtgNam4cjowmmSO9jhsiLZ6qHVpZTYU/o6s2
         cl71rrfdSEUus4ZO2fYP5BPi9W53IDTUgN1i/HIFvYnkffpEOAekQFp9kM7jE20yInzW
         7Uw4n5yl7susfmP6/s5YVgs3CEsrs5FEhFTt6R+V+mU3xQHzK31u8fztqUzdsT2+Ywg8
         LdEg==
X-Forwarded-Encrypted: i=1; AJvYcCWQD6sbigHzGTQ9N5Yl54biLGQPQA0MkExGwunFeQWJDPGkmcuMgcfhgyDeS7AbJqtUM8EUcSAewDb+B/dVhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyctKLxNxpjXUSL4kmZ02NF8lwuCPOutSD1pJy2Z3kCjF5/UQbn
	Tu7AozoIss9vCasV6/jFwjNqRFp7PBPVeaxySMhkuZKyBRhIbXIO4LUX3VoH3yQ8zUNXS5/zx9E
	Tp1bWc2cSOwIiftwTrjA7umFR3wNypdnXw7zrEfflYFyQhFV62tea62eTSeu2CMD6XwbHfQ==
X-Gm-Gg: AY/fxX7GqTvuZDL1b3jWWWliojfSxIkjrvZCRk1TZSxwH4HE2sTGGfRmumbMiulIPOJ
	8ClnRVG0o9xt8TTH/4DDJmw7rTjWpligsx6UnJxvNJgYHR9z3F0cICnpRXAAaso4aMKX1ru4TeG
	apdTVmUx1dshSoMPDG8vCXibAslkuXogztTKJ8XdTz0be6MMrhymEguy9Yl1xbXyn4vt2E5KZpx
	e8kha1aO9iGxATObAIwjEEvoQ1xdgW5XoKUc3O/b/IbHvHO2jiiYgBOZap3gPS3vBBmO/X2DHgj
	czl4XKovhFvWvxx+uNdhUMbzZIvGh7WuBdX4hZhRNTtUbX9JWAN+5g7GvpebTtAOB8HxXcNHNFH
	jgk2SNSDIBwYfoYPsuDMv9wvhRZJt7M6EGl+3w7TSPfLDV+JwpkW0ZRT/yYl+jhopE0tqjvbJ2e
	l6DyJsRZAZQKVUrz03d9RORK0=
X-Received: by 2002:a05:622a:14d4:b0:4ed:7fe3:7be7 with SMTP id d75a77b69052e-4ffa84d5bd0mr14665221cf.24.1767661283393;
        Mon, 05 Jan 2026 17:01:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrZ1tIZiQ6ycHzI3EiYuZDUWEqWF7mMpIemTNtxXuHPb4jtHfXaJhVQFBU4f2EXJPRI/6qNg==
X-Received: by 2002:a05:622a:14d4:b0:4ed:7fe3:7be7 with SMTP id d75a77b69052e-4ffa84d5bd0mr14664681cf.24.1767661282972;
        Mon, 05 Jan 2026 17:01:22 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:21 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:12 +0200
Subject: [PATCH v2 02/14] Bluetooth: qca: enable pwrseq support for WCN39xx
 devices
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-2-0386204328be@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2075;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=8ro0A6tVVAR8N1a3EJt6gZeL+nfKC2FamuLo+mTTcgM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7YIE+RgnOdF6j0+1WDplDzh9OEu7rZOc19L
 X/4QNNE9O6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2AAKCRCLPIo+Aiko
 1YXkCACC7NBtif8a2rH1Vkwu+aCXo1j7E9efr80epimwSe9+/TpA38HWBS8S9p5hLjd+LkneptH
 dTD1KFpwF9FhUb66xrLzboGL/Qu+AkHxaw2OEUxdQuBpW8dOcszVT43KfRGk4u7I10YMxMEb403
 0SXACEFtKg4FZafeHufsYLCBlPE5GpXBbwR2YLACyCFrt4lSmtlwTWmoC9IcVExx2vLzEYzSWO3
 G9HZIcJEbbfAf8bPovnN256QMeNiLd4sW5DgaoRtsbWHEKHLC8mowRF2iTN6mlHP7Ua/Zeh3GKT
 eMKVCkcXPzZXfPFenhs63JikBAY3tfp3eyMLslp+14pWjp0H
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfX28aa51Wgg6IO
 4te7IPdcLMNQQY6bY2L11grYv1x/AV2a31bWmfYHK9G4AnhgEMASzTHDCqKmyrZJUhzQS1KFIH+
 F5mHWPgv/untzP5Zo1bmVKeazlcRhbauDh3pldEGdCwvscFXMyuiaZpykA7lZvAH+ajcYc7GWB4
 Q3OgPbDvO9Hry2lWNROhByS2RwQctfmMg/jQEFGWu2nDj/DJKGOesOoG3iYEN2+tlwhJ2CiDpPY
 ijX13ahWU7WM7WD05gHkRO88bkJY4peM5Ii20MdFTmINAjB/S4YdPaC6U8qcPMia0kB1a23LmtE
 jzqoC2scC+RQjn/v+pIJ4YYuN1EMBodvxXOkgX0fL9VkvWUqR6f7O8VufxjCvXn4sy2Jdk5Hqam
 MwhYegHUzfragkUZyFRj3pVJNh1yzQBPgrJJiVwqzRaiFLP3w00RI5ox/8p+uqYqYLLbY4lPnsr
 zQhfTTD3UhY7wURLd3A==
X-Authority-Analysis: v=2.4 cv=JfWxbEKV c=1 sm=1 tr=0 ts=695c5ee5 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=WNkeAZsnUospxCs8hJ4A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: vqQIlmTnc-KSYixRt04Ko4oEi2RKMalm
X-Proofpoint-GUID: vqQIlmTnc-KSYixRt04Ko4oEi2RKMalm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060007

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



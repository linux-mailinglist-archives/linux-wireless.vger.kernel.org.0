Return-Path: <linux-wireless+bounces-30187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2684CCEAE0D
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 00:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6E453019B44
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 23:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A458D2D6409;
	Tue, 30 Dec 2025 23:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e6K48ciD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bQwC64C7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1032DF15C
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137773; cv=none; b=c+k0W3Rqb6PldEX/X5KZQ3FADISsuNWCp3p0kGLvXpq959gNFaLsHkL5SkNU7C9toCMVY9flwO03/MdOA2eSnXyi8bwEhEmEBWjxl6E3epwWAEmR/fGhsprvzZOBK5tMpTY1j+xDEkPiNQDHTppDq+QkcrqwNFeLKSOYs9Le3kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137773; c=relaxed/simple;
	bh=AG1LuEu35/QXARVDmQljJ6/X6wU6zxwBmWxtwK9pVwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iCqPXeh6kyuFT0Mi2XMsWzKltpV7gJ8lWkDxSI81H8kTOA0/qrvz5twI0E2ANVL0VmVRWJSumnNSIcLBWNZHrcUvWQfcaHwvs4KIUPLuhD6F8OpMCGzz53pV0HHYQ//lm5mIHiy3pTLqiT4wq4WUA23mvHs9yhf1AJS9GpL/68I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e6K48ciD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bQwC64C7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUKlGSd1008702
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5zzqm3vWt+G5X81VnTc/HMamR4mFoNc+f/SQq1irb68=; b=e6K48ciDEEdSVIk1
	V5URzU4EmIaNi+mTWu3/CM0TJ0FSs7gV/tn2Ua5J/MGr7ubda0KYd9jbWLZ3LhUC
	DIxsGwxjtbpxf6qnSRvRYW7tQyimoHG8nQCTMUc5BrFE4unSNsDFH3653SGPqhBD
	a1K4811xoS2DlJjyO0LU84S9Vc64qKW+jEgvjTd4iBIFFxa8B/E0IRFodDtMbYjE
	FY1xmPZ3xulWcRUYhzTP1wW4fT90lELBoqTgN/1+z2a9UolIvHL2300hJafBHFX3
	2Oau6tWOr7pkxmdKB4JpBOk/qlokuVLOQ+Y7zFVZTxvUXnEePHYi7nla/anAwKTq
	j0N1Xw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bbqk1ccy9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:11 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88a43d4cd2bso128261456d6.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 15:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137770; x=1767742570; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zzqm3vWt+G5X81VnTc/HMamR4mFoNc+f/SQq1irb68=;
        b=bQwC64C7KlAPJwBDNAjBspxhrQVNDNHo6y2rDpNhhMe5yqYzf5yk7sGxtptygna/CX
         zF8S7/Vv8YEtPeCYEySz0om+jKrkoYfTd3a/oG6YONMblC1DL8VPet1HDiH8N4sSpcgi
         BzYNd1diHcBAaK+mXdpIDjSor+zBh8PSQscIj0flBKVzgbzGXlP9LZSWZEmOY3SMbUjQ
         1jV+UhSeMu5rP23/tkTGBJkb8KbAX+4CtFveCkXIG3CyDaIPX3op+v4OrxxbaLKA4kRr
         tvmdRPkQXelkz7tryQqImM9gyvrvslhjoE/hoigb7l1qn8elw7vW3/rIGwAvZUdmQ++K
         GyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137770; x=1767742570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5zzqm3vWt+G5X81VnTc/HMamR4mFoNc+f/SQq1irb68=;
        b=GLFZQrVRG8oLCHAzP/hQTqwvEb3RSNynvLyKk5/aNmn1ZXbr4wQNom3T572gwEtcmI
         9hIuOdoCCaUsU1icCf+GZGxLwUGCOv4na0ndM30VatFYentFyLbfLYsGiMkQOo64vlF6
         3Kg+HkxRezbdmxhd/qTR20Js2Vi3kecSxi1cazDO9FHyTv2yOuVJufG7oruxARvotC3g
         kwPw86HvUpoFsCL6SjXPs8es2C3t0ZXkxuSEZLkgNFRlQRKMbccld5249EWDhwto6ImH
         BTYWVQbkB76n4rF8r+oR2QpCHkfR9/ymnSjdUzg8fuRL843kooKli0LYnAV1YkvLp31x
         KmOg==
X-Forwarded-Encrypted: i=1; AJvYcCWCimgTD2q+5Asf92QZT5hYxNPr2+5AaM2nOzzjNSyp7igby3MxCICDk5x4Fesx+EKeEj7vD5d4AkM7w0FYcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKo9YMKSZ8YYhefh5050hN2EeD1DmiiECQ6KFVqFVEC7AtQGda
	BG/rvD0ilPbKKQAAPUur7lE8ssZEbgMRr1gsPv2kW94y+it/sw/vIX4V3kvk9kYPzUNplm2wHoM
	FFFS+fxeiwbtLEY1vd/dwDwJJGKbi8/j4bMAooktiZ1wyYzdLucHNh4BwaYWU2FfrmIlF+g==
X-Gm-Gg: AY/fxX4livISZETAR1dyrR9el/K31b15on39mNxeYskiItWSrdDIbXhc2V4rX9B32Wy
	8rXpQZROR+prl94MwZLlxIpCFHblc6wbM3rMKZuSGO1+b1KSoBZKt7cJ6q+RtELya9Na6VI5S6I
	9Z8wAEaEDO/VR8ZcxHCi+LIHaEeYHe3K0plTFoJUZyu2cRDodCVhryEcZyKHC6Og+NU0N+UuaiI
	01yFJgaeWc6WWNdSi0t3knqhJpaR+N6s/IFnch/pZAv5iF00/THYf+nCGpxCZixYyNl4nHza1lL
	qGVuILEOeRkow00WxshxqXzyKZK5XswjKT8B7TSl+F2NjOSMo1UT7MXETMnczu3qp2tJHcfvx/o
	leyTWk6Vudt4J7n+l2DiKICgNEKnETt4L8ciVX0IAycKN/w9AQmkN8SOzsZOlpjODMaOoaujUig
	AsBfHl5nHeW/zaV7dTMLThf98=
X-Received: by 2002:a05:6214:23cb:b0:880:4c15:599b with SMTP id 6a1803df08f44-88d81667282mr560504916d6.14.1767137770090;
        Tue, 30 Dec 2025 15:36:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdWALg7FWe8HnFIGfMzmshFveG7DXhOdt7rpEnzHy14H+14CgajaaMGSxFNnYetgNtZv2I/A==
X-Received: by 2002:a05:6214:23cb:b0:880:4c15:599b with SMTP id 6a1803df08f44-88d81667282mr560504496d6.14.1767137769569;
        Tue, 30 Dec 2025 15:36:09 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:08 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 01:35:52 +0200
Subject: [PATCH 02/14] Bluetooth: qca: enable pwrseq support for WCN39xx
 devices
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-wcn3990-pwrctl-v1-2-1ff4d6028ad5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2002;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=AG1LuEu35/QXARVDmQljJ6/X6wU6zxwBmWxtwK9pVwc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpVGHjmoSFavXQi3JlRn+Z2QMO9Tk/0rtLaWUNv
 pHS4GewQyOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVRh4wAKCRCLPIo+Aiko
 1S++B/9RyP7SAXCM/MZIkkTS9QxNyh/wJ1yzA3IFsGEWaw0uinf2VvjekVO4joaHHPKkGhTVXDd
 8BOqELjg7HLDo5E1037L+ZFMPTHeJeTqMUid/ELoPcdLZzqFsN0icUg6ALx/Biexleanj6SfQLQ
 VI0jBlNA5Y0PD8nXFxMvT2d6TxwiDTXbl/iCXW3yVBSjbA4Dk/M2d3/seAshcy0Ci6TBPs99q2K
 NO0sLSXgMLMIJGTcl4+XgowZ7CpnomXgFJstjr695of/roCI/KEg0DV2hQ2eITfnhRuKG8x+zwd
 lKpcwSLnv4Ji+P4FuzzfBz0AVoluNcbIwH2ysn4q3yNZdf8r
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: V34Yrwjgneht2sqAtDQDcFaV1Dde9GyK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfX+YB3DwAWkFsU
 B10VFTzkT7TJinjicvmeYilemU2Lv/RLHPL4X+wrUIlY3G12lccVCfQD2kDnCgnVTvB3dt8UY3l
 Sq6RP1FfEZOnZNV3ye9iH1sJSu4Ure5tZ03tx8VDC3VAYa/8g5RZLcrEP7rgm3e3MmH88kepHAv
 +rTTnhfFcahOVIKcunURI0zv81xYXMZl4t0ld/cZj6ZccL8g4XRyBVGkZPeS88aMw+aDCfy1Rji
 C1gvIpq5y6s06Tkli4xrgImYG7DZz9UzearGPt+LKIYqYq6WxALLfNUMp4pzI4WISqbuJOK5naN
 3pMgwsZGhAnfhUHnYDFUk58lKCkhQMD/SHFXyu1iZOh5DY8u/kVhxD/bbYtY8CTVPHCtfYVpekq
 oBaO/uf8pEC9YyNh9Y8PsoAioq4NwYtoRAeAiPu5s0g8M6s82XV/vAOZ5nxg2zIdQOMmMzvMfJ+
 Ko34pmt7kJnUmrYbyRw==
X-Authority-Analysis: v=2.4 cv=Tf6bdBQh c=1 sm=1 tr=0 ts=695461eb cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=7G4NRjGX0UlV4bIyNksA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: V34Yrwjgneht2sqAtDQDcFaV1Dde9GyK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300211

The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
voltages over internal rails. Implement support for using powersequencer
for this family of QCA devices in addition to using regulators.

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



Return-Path: <linux-wireless+bounces-29880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0626CCA05D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 02:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DED23074CC1
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 01:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AD226ED59;
	Thu, 18 Dec 2025 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PXvDgeqP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XDQ1XtR4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A7B26FD9A
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022945; cv=none; b=AXDLe6p+hhijEw4u1uIb7h/dPoiwPvi3REnNhOitUdGLBbb1nEr0sRjEgUet0ko21oAFv+emu88XHpIA/2ZuQ8nvGIc1Ta+V7ZBBak9AxnviUPjF34Ex7HapSOuVDbG2YBcCI8lQvfd9zT4U2NwEpQ/YF44JeBHRQBrTuyG3X/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022945; c=relaxed/simple;
	bh=eL9dMmOmf90JdzeHdvJjtIP7BSKWjMJAcyDyVsFObJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JYWPTev6Vf1LlUhsDzJLOZ0WaG7Ovze1eENdyzCvZeV29ENEsze/Kci7XNoky//YOzXc04x2TYc46t4685rOucuOBytfe+al4HYR1QE7CHvBZHu15rTG3riVQWABItDh/amYowGmIZbPEtsjY1MWSQLyXPI5q8BBQB0tlIoX2Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PXvDgeqP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XDQ1XtR4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1Yj4s3717109
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RjNVQHclYLWfxtu9pN9DpjLIUxji9CjBRXoyJoIynas=; b=PXvDgeqPYDyaysA9
	ZuLLXZh3E2tsXlhbOOWVuyyu+KxrD0fhZgBEsekVdOFgcms37ZXqPyDitDdWbfaK
	pDffECQYWJqg8uJ4mfm6ZLyymsXNt6Z/uU5hnJzDMGNX619or6TQXa5fzgmNfVFG
	/+krUin766ON065YoabISsWoyP3ybM9EeTUwn4v/C39QC7Ye8gPtyx5Y+IM+ZXrh
	svkA8/A2QWw7JJaqZfSRUb9inr/6M+Ic5pe6HJpMSjAnNRUNxBH6iZROqvznn8XO
	+2XwXGqwLCV4R3B7EaYtgsft35mGl9/vZGoSrt5qWwCVv9vy/QznkPnjC2mwrTXe
	PYJ9FQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40n79avb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:43 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0b7eb0a56so3654825ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 17:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766022942; x=1766627742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjNVQHclYLWfxtu9pN9DpjLIUxji9CjBRXoyJoIynas=;
        b=XDQ1XtR4JTKtGdf/LNFoZaq4ksS+IlZeUhlsLIJCXUboJBSV8RIH+DAZ+CtphvdH6G
         1jVn1lwivk9bQkYYIMsUC5+XcQzTnyVaIpeEdw6SgvvvpWLGZdWy16KWq9Fqp/aTcqyJ
         sHLqO43CtT6InHI1PsjrAhkdlB7fnQblv3wdYDOvHEvXWWePgPfc/gjZC8Gxc6APf0eH
         xv/+kmh4+miqswEb/lXMIXQ8QNElycp92VvNM0gAyF9JnRSj/CGcCa0DZmOXlM5PzMvV
         +Abi09eGEAobw8jsQiaRxlkdtHETLHEmMaZJ7GLN4z8FId/Pf/8HXto6p8rBhGCQgG/K
         +Mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766022942; x=1766627742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RjNVQHclYLWfxtu9pN9DpjLIUxji9CjBRXoyJoIynas=;
        b=bA6V3kymV1mSMMSHS3mpV6ioSQb7HoWwe595PYw0kdEsCeB8elBdleIgSGamH5ryBx
         rXUnFlV0mYsKH6VLTuC96bgOdjWkSfUKLHXk+EFGeRpUmdim5jQ7dJ9el+0nSIz8CnUW
         9jCAoJ4H/6jnwLmE6I0XZ9TjDXCYmuQKTLmuTaUsceAfG/3iq2HgQyMxCiZGhv17j4jm
         J+lz2R5sNkomu3l4k9boP/GCDJWJ5thWyCiqSOJRXYzvnMkkT+0Dz0UikxfkRQgEmzfM
         0R7JHHUFftepe6HkvR7wmRerIVAodzx6ZujQXKtcDeyu6ZjcjAEJ9lQB9+sCK+1D1FzI
         cn+A==
X-Gm-Message-State: AOJu0YzCmgsVUWM1jRLUjkGWroTzNNn1iYoJZ7mNtH7YhT8v4yLmakNv
	qDHa83X8Y8ERo0E1hQPaprP+hgl3W/emk0jquNWJGTSRprK7ZusJFNpdUyxDYLRCrt9Mz9Hviem
	t1/VYJoXW5RmVxrn5U2kMZQG+mxkwPzQw2AhpvDMJl6TtMIclIVDn427lVUfgKWkImnx2YA==
X-Gm-Gg: AY/fxX4EcjEnb7MFQWoi7vvWUHGJf+R+6/V/AOlaTlGvB0QQpB8UzkdXK3inm6iAeFP
	+S6XEjXYWhWm6i9jjBX/5Bbz4e6Zym1aUBhNefSevqnzzHhjPWneQL6e3+u1f81Jp1AIVD6Nwwg
	XMKz35nP2rocq6wysKgAvcnYa7i3hYu5USeoepCktu7dtWfJv2iXWf3VkcrheiB6/2iZmZnkhAm
	JN0vxFyLqWsEpxojG2WS3GmuFa4NYuDgikn5eKkBmqvBldbMpwpxi8VqyRUPTxknz8KmfMWMbud
	yny/SBfTl9ahroT2e+0XMxvdpTnfBF2MopO2D2kbnkK/UviPaCVpp7zU1dSBmpTSQch5j4/eLdG
	WNqapG3RKOoQoDMNfAfhZ2vzrmKd9T0VlFOSZPDtAf94TpKOWhIxY9G0tA+RQY+w=
X-Received: by 2002:a17:903:2cc:b0:295:888e:9fff with SMTP id d9443c01a7336-29f23b5f44dmr192675765ad.20.1766022942402;
        Wed, 17 Dec 2025 17:55:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJSmu9dm9C9vNb3njKDwE3EVTmRL+9bdjclw9GoO4vF5hRs+uJYgJAyFTonJNTLy0K9uZ5Rg==
X-Received: by 2002:a17:903:2cc:b0:295:888e:9fff with SMTP id d9443c01a7336-29f23b5f44dmr192675655ad.20.1766022941960;
        Wed, 17 Dec 2025 17:55:41 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c812sm6548175ad.15.2025.12.17.17.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:55:41 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 09:54:33 +0800
Subject: [PATCH ath-next 19/19] wifi: ath12k: enable QCC2072 support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-ath12k-support-qcc2072-v1-19-87928cf8e547@oss.qualcomm.com>
References: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
In-Reply-To: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 4IU1XT0xguRBeEX1pHBRAzvHN6tQC4-C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDAxMyBTYWx0ZWRfX6t/r39TdjPGx
 MhL4Q+3mFTt0NeRt5yWWGcadfsKI88Yr/HYGxLJ4mkbeCg9QaoG/1P73kAaIAxSOgZ41jwFZnq8
 ZoU7YJXYWGe+MvCAnCuPVjPxGixgCY9k1CLKFykkIs8amRBuZFF775IsNV0TF8R620rRTKzVsnQ
 znc/XXSCaj7iYeqsCTo826bLQKTwVGwZ+JA7/pMlO5FiA967l3K6PGGu0EwUfhchYAtBlq7ZrNB
 OlGyQeUSh2o3FywQObKHNNrzH64714Fi4KEAHk0LIY5ahirLcDcvG3Lm+Bzs8QFzeROgbxUXH3J
 35x95hPBqeJIV1FYPufZxX8koz9vnVS4M91KkzEFf4HQ9UB19Fme1jRvEvkIeTur0GpzGWpWk7m
 uGG78CCyND+ik1lB2XCWqVkZtH35Mw==
X-Authority-Analysis: v=2.4 cv=TZebdBQh c=1 sm=1 tr=0 ts=69435f1f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ef0WcUByH-36KoXH_5MA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 4IU1XT0xguRBeEX1pHBRAzvHN6tQC4-C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180013

QCC2072 is a PCI based device that is very much like WCN7850, the major
difference is that QCC2072 has only one phy hence does not support DBS.
With previous patches handling such similarity and difference, it is now
ready to finally enable supporting this device.

Add QCC2072's ID to the PCI device ID table, to allow it getting probed
hence enable support. Also populate some necessary parameters when probing.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0-01560-QCACOLSWPL_V1_TO_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wifi7/pci.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/pci.c b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
index 6c477fe97298..6c96b52dec13 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/pci.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
@@ -19,6 +19,7 @@
 
 #define QCN9274_DEVICE_ID		0x1109
 #define WCN7850_DEVICE_ID		0x1107
+#define QCC2072_DEVICE_ID		0x1112
 
 #define ATH12K_PCI_W7_SOC_HW_VERSION_1	1
 #define ATH12K_PCI_W7_SOC_HW_VERSION_2	2
@@ -28,10 +29,12 @@
 #define TCSR_SOC_HW_VERSION_MINOR_MASK	GENMASK(7, 4)
 
 #define WINDOW_REG_ADDRESS		0x310c
+#define WINDOW_REG_ADDRESS_QCC2072	0x3278
 
 static const struct pci_device_id ath12k_wifi7_pci_id_table[] = {
 	{ PCI_VDEVICE(QCOM, QCN9274_DEVICE_ID) },
 	{ PCI_VDEVICE(QCOM, WCN7850_DEVICE_ID) },
+	{ PCI_VDEVICE(QCOM, QCC2072_DEVICE_ID) },
 	{}
 };
 
@@ -152,7 +155,16 @@ static int ath12k_wifi7_pci_probe(struct pci_dev *pdev,
 			return -EOPNOTSUPP;
 		}
 		break;
-
+	case QCC2072_DEVICE_ID:
+		ab->id.bdf_search = ATH12K_BDF_SEARCH_BUS_AND_BOARD;
+		ab_pci->msi_config = &ath12k_wifi7_msi_config[0];
+		ab->static_window_map = false;
+		ab_pci->pci_ops = &ath12k_wifi7_pci_ops_wcn7850;
+		ab_pci->window_reg_addr = WINDOW_REG_ADDRESS_QCC2072;
+		ab->target_mem_mode = ATH12K_QMI_MEMORY_MODE_DEFAULT;
+		/* there is only one version till now */
+		ab->hw_rev = ATH12K_HW_QCC2072_HW10;
+		break;
 	default:
 		dev_err(&pdev->dev, "Unknown Wi-Fi 7 PCI device found: 0x%x\n",
 			pci_dev->device);

-- 
2.25.1



Return-Path: <linux-wireless+bounces-30691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3BBD10EA0
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4CD33300DD89
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 07:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCAF32E154;
	Mon, 12 Jan 2026 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IWv6pOCz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K456IxYO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840B9331A4B
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203449; cv=none; b=RIRehDMetusNY0A2QAGgAIxQhla5gwSf46F3CL4t1Ji/GLW0MVZlJi2GKorSlUFzeb0nL3UP9gumKHylC/mlgH5DM11bOarejzyAeCHPYMAc7iSZrzlnfZ4b6VN/E7tItgCQog2Ih4bgkwmrItFcH6y0cDN+pFjNlArJBKsp4ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203449; c=relaxed/simple;
	bh=eL9dMmOmf90JdzeHdvJjtIP7BSKWjMJAcyDyVsFObJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O7f+hB66Gf76fFULcwwe63DHjFPEONxwZkMkfj/74sTUUwADhhCRX/xPfdZx5Ggia2/NqHWR7/Cs5hxVYDAcWKtyF6IdrT5QcL6Zh9LMK1Z3lsPhlrTbOK8I310YdkEwQPghGGQfitXcEu/LtgT77iFHY6uVF9hHO5BDgBrFLfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IWv6pOCz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K456IxYO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BMpHEg3130016
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RjNVQHclYLWfxtu9pN9DpjLIUxji9CjBRXoyJoIynas=; b=IWv6pOCzC4Qo0SZ4
	NEuNEvUq8KmkzEYJbVCkALhzTy4hgOwOku70/S3cbJ/oQzVz+pIK0YDkmrmO6JVh
	Jh3EDA/O8EhjWiD7eZAYAkU+att83wEgujhXGB+jLOA3a0NOcJP33OUYGbs8WFpU
	mR6p27E55QTCHAZxZs0O4XMmWIz12kKBBz91H6Offqkm9kVqWBPrh8NWh3Ugjzcc
	OojkAi1ivQEOFzf36sQ/dRkPTHw7ud8ZYVN5Zajaew2WOH4GgqQf4/3To2qFjHtV
	yeQLBOi+KHSmwkFs7zR3dkIcTSBEKHe4Q/ryxuTVIHyaOt5CsRsFbAHOEMFPyYwp
	hqWfXw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkf57bya9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:27 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c52ff723c86so2235111a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 23:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768203447; x=1768808247; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjNVQHclYLWfxtu9pN9DpjLIUxji9CjBRXoyJoIynas=;
        b=K456IxYOcsP+E5lkWGMpZt50mJ751lmZl01fWS5lZscmuSxZ/LSeLglsZc3fSPPHm3
         i9oxTbkugv/7nPE4IhvImP8OhVTjDaMc0HDuyqhJjgqR6he1tgf6t7vNPAzZrrtDvRd3
         uD0Oywi6eRJDa2jCIrjtAkUdGW1d4YXYP9kLEbRPhKJXWxYmKF+gpjbb0CkcJkajROex
         3vdgo/AkQuhPkJf2vbXq4pz15iLWidixzi58GIyhx8udKFehDu0r7npUUfbwG+E4NF1X
         8XgY0OFKMHe6zBB9NdYUHRn/rGxqzRIFQLigQXcGdjrBAz4SBNJ58Oc/6iAnAMfeFGkd
         h+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203447; x=1768808247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RjNVQHclYLWfxtu9pN9DpjLIUxji9CjBRXoyJoIynas=;
        b=O22dCcX2IlqsQ8S010ost9lcKNnsn4BBFxwg4e8+Q/d/lFVxA5CZgOyJ7C5nhMWC2N
         eNcKFVW3mOcjVtZ+q38NVfMUXOGKZI2YKErLttg2fdB3ElcOQpr+Jz7urDO+cItON4aE
         RcTqKbGo9qdxQX0Ea5LTLy18WlrVIGAq/nEpu+h2GnC/hAAKG5geNpuuD7u64lDFL+tc
         bBho7wi8CXzeN7Zn0QloIIaljnThxz8+X7F2bQJLGF0VqHGQXWn1CAiDUJDDfEvDaJc7
         FvTMQGP+SGRnx0aeyi0+7dCNv0iSgYfBcAh3KYHGzLRqJG51K6I7MUB2fmUUmxuxF86s
         2xqg==
X-Gm-Message-State: AOJu0YzXmk9fysfkM5trLKvtciOwVaUuEMaQ/zykwJ6LR+iUBPOEh1o/
	17aBuY342KBMlnZDGrQDc7kK1Sy0co3jYT73pZuVUslNUjbHGTx+mE2tCI1gc5PRz+FTY4EDVOw
	zSTuJnu6dtRHzcYS89FcO1t9PuZUiQvUQnCRMg7EElmvCsai3Y9eJed/zigmS+zVHMVzTGg==
X-Gm-Gg: AY/fxX7L9994QhCDVUM1mg4kER62VEcG8HH5GXpBxAJZ53EFvQlp5lWO2fDu+52UV5S
	AeRZ/5FsD7WGUyU+mr67wLfYn22FhKsTFYv7YJ1ZUEsmo5pO0YWGit3OvKzn054cz1H8cCAm0Ve
	cq4hJZDMIf58nalk0GXKY6N+11iJrrZyfGwtE0QHlk9/Z6n8be8uP8ldoVYyFN1cGX2dTPfBjuH
	yyDzAx9HJ8V/xcKSMheoaWQZNFZarGps/WR8x7lGcpmBh3lRg1RcU98UnrwSHDBuM2EXq7PEEY6
	m9Kg/XkTwAdninvtNMHofuPZLy9kKFmhINR4zX2ixERap11+tI+Mx4APdeMhnPMPIr7FOXwUv7w
	bZsqfhfWetTYjJaAj9iBLBcgo9Agz/C0ge027frw/cTzNddalSxhQbf85ttXpL/Y=
X-Received: by 2002:a05:6a20:e290:b0:366:14b0:4b12 with SMTP id adf61e73a8af0-3898f9bde9fmr16362765637.78.1768203446560;
        Sun, 11 Jan 2026 23:37:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/3b+RCzW+/Dbq7svVhbYRRWrlgi4ZmsYOV1KHNtRuTJUDGE0XVcdRer7wiWjxrySVZh8KvA==
X-Received: by 2002:a05:6a20:e290:b0:366:14b0:4b12 with SMTP id adf61e73a8af0-3898f9bde9fmr16362755637.78.1768203446080;
        Sun, 11 Jan 2026 23:37:26 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28faa9sm16548684a12.2.2026.01.11.23.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 23:37:25 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 15:36:38 +0800
Subject: [PATCH ath-next v2 18/18] wifi: ath12k: enable QCC2072 support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-ath12k-support-qcc2072-v2-18-fc8ce1e43969@oss.qualcomm.com>
References: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
In-Reply-To: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=K/sv3iWI c=1 sm=1 tr=0 ts=6964a4b7 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ef0WcUByH-36KoXH_5MA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1OCBTYWx0ZWRfX3VY9VLJ+/2bn
 +nuHEX67V61KKm8dn+5D0SxRV+wiyq5X7Hj6iC1DXIPbuyiTKE0Lk0f2lqOTxFLjaQgNulQwT/o
 1+MNk5u18o0TpV5tS4pLD25zhsBA5GZSXVGzBhd6UQHVtR45YVy/uid87NMIT7tRvmxi08hNzS5
 n0mcBSAj07lU+YGvA9q2ywFGmCw4CvzbG5RIJlr4KY3zA+JFO5VmO/WJ529uiTDOTe0VBtzos+0
 yNElKo5TQ2+V5nWVbFzMVETBPo0tsMKzInmJalFy7D3eXal0cZAf3Dm+lWshw7jVY5UOa0Qcs9V
 gnh4qX5EYZn/tAbHr2/p6XyHQ+Ez+ra8mxVPKwnnvf1Cx3V6NDCVkMy6STQFcFtmqQ5HuPUo7Dk
 R/F7jdgZO6/Ys2OOS/Tm/mIFmn1znanQ0ZjZswUacsLYhFid030gY6raefj7xigxe4qTLlarydZ
 5CWYvYhBvgc/ZlLeakQ==
X-Proofpoint-GUID: RnxOsSgsW36RdYECTJGu-VCAPREfHm3_
X-Proofpoint-ORIG-GUID: RnxOsSgsW36RdYECTJGu-VCAPREfHm3_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120058

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



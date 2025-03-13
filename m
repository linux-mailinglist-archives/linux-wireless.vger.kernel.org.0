Return-Path: <linux-wireless+bounces-20318-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 105ACA5F2DC
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 12:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4602E173193
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 11:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2DF266F12;
	Thu, 13 Mar 2025 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EVEq33vx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B0A268FCB
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866100; cv=none; b=iMynDkeCnDIx5pn5MJfbotofv2cbUVj2fI6CbqeF0xQgqiJuBCWqRVcSJyOeFU2uo9etEMYQ8wipi3Qj63m5/nlvTYZkGFe04peU/DLU21AkcRYxIlGHWFYWWQEixu9ABtJSWtK5iDmewO1wonCgAFpzdwGp0Sb1RRDA6xZTRlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866100; c=relaxed/simple;
	bh=8h6iYqT9QgxKQ7chsjPReDkmLMBOz+R1kQyF7lNPqNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BIJ5Q4VXlCNeJc21W2GaZxv2V/uBCMgL0FIZ0LvWSq3u/wZTPGHKMRldUApVUBuKJwGldguYA4mSXB/kS0QwLdI4CLZGDIuoYd+LRvMwSMpNHSo3pUVhhQdyVnCAOfJZLVTXUzwFm4TijnffLwRp+atNAWHQDIth/01dQKuX6qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EVEq33vx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D9KsVD016092
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 11:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6csxGEooemVwhVCZXPAno/xD7GGqltefCOv7rH6G52E=; b=EVEq33vx9yuK88OJ
	7jNNxLMvNyDzkk86pb2QlSDH9SQcw8BWIchhNFiWLi/cZbGdwPHC3U0+T11I4FeS
	D0732izuKp3qV41qcrmhIkuP2jGrxpSSdqA8C0w4pV3cdELSeJ+b3tsFuE38fHzy
	skY0zVfKNn/YjaWg9+5Hb3W0dWinwf4MfinLPONKJsC/WZw6RCxIPA5Xc5JJbX2s
	iD4n51F4INZhPgBdkeXEgVOVsiIWnnTlFrV/WPn1ag6ZTRDXyxhU/YgzlX5ZK13B
	otFrH9JgdfJBq7z4Ug7+JIMsog/Lq2w18j1OusVIDTDeQ0yIIEGllen3YUvO3hzL
	YJBbJw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nwpx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 11:41:37 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff69646218so2503580a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 04:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866097; x=1742470897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6csxGEooemVwhVCZXPAno/xD7GGqltefCOv7rH6G52E=;
        b=KF2x2umubZWKX+3Dvp98csmLDl+0dvdiQoYcgNxEtYtUcewK5QdgyB9mLdhmDOQyvB
         nh3bj/hwJY2xzovVLHuvKOaZWElqQXysu0DJf+O5fB9N6ddc0+3uNaobb8BHfx5xiVxp
         Mv+2Nmp+rdPpHqtWbgucs/83/1aKVQ+u8kC3Fi3+uAXYRtlFxFlkZUD6mS6nVCJMlXte
         nSJRPt2A/AsPbhCULHuEn9/R+l76FVB90XRzuXsfu2Oh+T1pXxh1UxfaOysN2S3boYww
         LpGpUzr1E9C0carYwAiVWv9xi00kl8epMoV25uKPQy2TFVmAAp/p6x2pkhRvsJazZB0/
         9urQ==
X-Forwarded-Encrypted: i=1; AJvYcCV18vrPiB3AMEr8paZ279kBmbDaU0ibdZFQhPB3d4AwgdfGhIM4Z1c5Q8qGaM9kwzb4DVinXANHEQG5h0h1Yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDwGZfb0VY6S7iIEJqA0cZlwmMhjHwxCw903uVcNpnZuHjKh7A
	XMwQmTRdzt7GMO/9Tiz35AVej7wWl+wHYfdx49d4u1xwpf61DIBqHAlzpkamsc2l9E08znkJHpZ
	ka74GYIoUZHnsDHAMWZJZtfTRWqt9rVhey0pkRM/6v/Vv8N2Z1D4UbGj/uTcye0/VTQ==
X-Gm-Gg: ASbGncuCnJVgc04YxMgWrFFsGFUxi6Lmc9Lu+9whSwJkvpfEOz05JAM+bC+Zzwy/g8M
	rD3CVMIQaHJbqxV9ERMCFjTg5zzO050VDldmjS4cbuoNvlV7riXAM4dU84sm9UJlLIA1u2ZyJh0
	5nXhoTkCd44RnWZYBMbIp8eOkUNj61dLfah1opTcR9J39Y4s4qGw+69czCjSR9UcGvsMaMTc5pI
	hm2mCaspyEjH4BBj2u2GkvreXL1bb7K56bzAqblbGpA5YjKnpO56Y4Lwh0UQ9nWvrKxLDK093pd
	5mcByDLQQJlzvniLFcIPkpJz6lU+sBULIInZHQ2fPZc1eS+Pp1A=
X-Received: by 2002:a05:6a21:516:b0:1f5:709d:e0c6 with SMTP id adf61e73a8af0-1f5709de3e1mr24106483637.42.1741866097051;
        Thu, 13 Mar 2025 04:41:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO+VZsMHm3zLtB84wJpH9RObZO6+qVAnGGVqwEYlnPvnXu3mMtC1TTdcKCjIwnGlhmgp426g==
X-Received: by 2002:a05:6a21:516:b0:1f5:709d:e0c6 with SMTP id adf61e73a8af0-1f5709de3e1mr24106444637.42.1741866096735;
        Thu, 13 Mar 2025 04:41:36 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea964e3sm1063219a12.76.2025.03.13.04.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:41:36 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 17:10:16 +0530
Subject: [PATCH v2 09/10] PCI: Add function to convert lnkctl2speed to
 pci_bus_speed
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-mhi_bw_up-v2-9-869ca32170bf@oss.qualcomm.com>
References: <20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com>
In-Reply-To: <20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        quic_pyarlaga@quicinc.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741866038; l=1512;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=8h6iYqT9QgxKQ7chsjPReDkmLMBOz+R1kQyF7lNPqNQ=;
 b=gNFMqlJS4PqDCxPL2OtSQ6eC/PtryQoUwiUm6/NuGn6xNnLkYCte4RpeEygA+SWaLg737Q1XU
 MERgI9pKC7DArMKbUXJJttHUPva7o7L2vUckaXu6sD9dwPouLJ3V5cj
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: Rqgs3PlZ5K2WJEYD-EENpjWt2bj2oqY-
X-Authority-Analysis: v=2.4 cv=ZObXmW7b c=1 sm=1 tr=0 ts=67d2c471 cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=rcts_Xg4tTJKaDXoMsUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: Rqgs3PlZ5K2WJEYD-EENpjWt2bj2oqY-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130092

Add a exported function to convert lnkctl2speed to enum pci_bus_speed,
so that other kernel drivers can use it.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pci.c   | 12 ++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..75505437a9c9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6011,6 +6011,18 @@ int pcie_link_speed_mbps(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcie_link_speed_mbps);
 
+/**
+ * pci_lnkctl2_bus_speed - converts lnkctl2 speed to pci_bus_speed
+ * @speed: LNKCAP2 SLS value
+ *
+ * Returns pci_bus_speed
+ */
+enum pci_bus_speed pci_lnkctl2_bus_speed(int speed)
+{
+	return pcie_link_speed[speed];
+}
+EXPORT_SYMBOL(pci_lnkctl2_bus_speed);
+
 /**
  * pcie_bandwidth_available - determine minimum link settings of a PCIe
  *			      device and its bandwidth limitation
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9ae199c1e698..b84473f228c8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1653,6 +1653,7 @@ unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
+enum pci_bus_speed pci_lnkctl2_bus_speed(int speed);
 
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)

-- 
2.34.1



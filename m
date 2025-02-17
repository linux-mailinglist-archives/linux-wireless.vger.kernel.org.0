Return-Path: <linux-wireless+bounces-19038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFFCA37B88
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 07:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C7C16A7F8
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 06:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C281190497;
	Mon, 17 Feb 2025 06:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZPunaYbj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC8D19E97F
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 06:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774083; cv=none; b=kRvvg6xDCKSjhvWNr5XRLNP3h/gJ7c0ct5enbNXi5U3rT1tPM5SLP4X8Mi4cqlxx/JlVIOmyN21/Q9LuM7171DyDramTGPK3tyijRIr5PCnVJtzGQsSI6v8xi55q63IeeJEoid0BlIZmKRTApKJvkupDbljcUBhHPwZSxnk1XaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774083; c=relaxed/simple;
	bh=0G/XG/YxFU6rag6WMJ+nAr2rfc55DQyaEL7pfp0M3cA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cC91CnCL2fWgUdnfbruAcz50kjDpIFsMyS9wjEJxReyWmXuzseM0W7NJlvXvPV0zCbNCaua+TL1Z4aWHT0w1BYOgEy2D83gCW1Gc4qRcRj26EsNiCEjYvRWJs1uI86CTdqzVRbB5EvWHupRxZSMTVLh1x3atfhhpgJ4VhX5sgLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZPunaYbj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H03CMI003062
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 06:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q1NDvwgjsJKCHcz2zk+2Dmi/QW8Mawbbd+wgtBUmftM=; b=ZPunaYbj4TIqMFz0
	T3LRCGPJk17W1qhvXE63JJeWaIgGUAdJhkRTqmXbjhVx4RZ9SQNEFoEYFG8PtH1P
	28slha4pYfrQeOKWOd2t6eu23DpA2pXW196TmKNY6h6kkjH8ZRgF9fNi6TQNjR7h
	96DHuKFGpqbuowOW9gyH5odARl1rpmFwXTuELIIZ6eKiM9JpPPWXfFL5/nvnfyIu
	wxxnm9W3JSPCZ+INrVGKcQNmZ6C22prHhLCkJdtAnZ9agXca9nXFD33NymbiP+7c
	voMmrf6SUvIzuey3sNHDqN2bufJAUCihixw83cHFGRbPOWXKPlH7YU/3ksT9qZrM
	YAmWqw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7trpqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 06:34:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc43be27f8so5347438a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 22:34:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739774079; x=1740378879;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1NDvwgjsJKCHcz2zk+2Dmi/QW8Mawbbd+wgtBUmftM=;
        b=qoWCcEFEUGnOv51j++EWBKYA5uOzGurupAC5fpym2xVyx6gezo9oScKpdKbCqLrTHP
         zH+u41D8gCZc3QByquO6WFcXw7LtBs1UODat+derTr80UZNxLLj6KqoY2aDX4lx9IiNl
         44LiKmYAF7je+rDEC9vDaejRa5ozfaiSkVgb/ycOv0tTk5y29SGLdIacZDLluTK1Hed+
         qmGFVM5g2+iVnR3Fg7pe21uZf6AEn6yv/J51vuhQLULhc+pnXfszkafHXMEGTSh3Nzcn
         spZIF+bpeXp0bdmGatkhc1WP1DRZPsjx9uiahHKxnlOny1qVoTbyRBtQtWJy4xx8lxrD
         ioJg==
X-Forwarded-Encrypted: i=1; AJvYcCUyqAc1EGe0zuQwdD5nBhsxvywUfGLcepXHIadRXRbMO8CxnH6EXnkq74jjdsUCcjUVy6dIcPJa5EsBsd08AA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg7iAsTDL8zJ//hT9GFShDzF4AlYqFZhAvCWXtFTx6cj58wxPq
	D7oUf0vyPdh3xeuff8ablbHbe4blk/9EelB7JlbThtCUpaAP/yOnstMW3OjVph0rMWKceDTw4RM
	PJ8uzvQcTrogbph8r0Xg/RIv8lk+e+D60neRWH0zhGYu2vsHcpiV3s1zw3dlARdFfeA==
X-Gm-Gg: ASbGncs9YHF5oHeRshNtEWj93AduYolAbNr4gvIqAK9qO4k8J/KmjKyCuwp3s05Ni2D
	ZXwarli/+/8nSy/3htLHgFi+QsAZJrUN9A1afqSl+sThhJeVPxDPPmTtII2nZhBTmEZ6DLuKZc3
	ukEt1re/kkWp2YFtu4BOL5x/Bqggw9lmVzMkcVPqJM2K9bxNoExV6CoNZ4yAKhPBfGQFpnEchjZ
	P3q71MrmLXAysABvij1EI5GpXXctyrW7l/CsO6DCmpXW08u6/KU59sOiyj8UO0fM7Vgbn4rWy05
	u/i1LFvU5DSprxwQEutUxVc32jFePkC7yrDChBDh
X-Received: by 2002:a05:6a00:2447:b0:732:7fc1:92b with SMTP id d2e1a72fcca58-7327fc109efmr3075250b3a.14.1739774079207;
        Sun, 16 Feb 2025 22:34:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHo0N15+Zd6Zvn9MgmFe3O8zvUpQANFOb3oxcmBBPbKXDnoGvy/IogEzYji+ZVTk5wsJ02f0w==
X-Received: by 2002:a05:6a00:2447:b0:732:7fc1:92b with SMTP id d2e1a72fcca58-7327fc109efmr3075222b3a.14.1739774078806;
        Sun, 16 Feb 2025 22:34:38 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73263b79287sm3771800b3a.29.2025.02.16.22.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 22:34:38 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 17 Feb 2025 12:04:11 +0530
Subject: [PATCH 4/8] PCI: dwc: qcom: Update ICC & OPP votes based upon the
 requested speed
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-mhi_bw_up-v1-4-9bad1e42bdb1@oss.qualcomm.com>
References: <20250217-mhi_bw_up-v1-0-9bad1e42bdb1@oss.qualcomm.com>
In-Reply-To: <20250217-mhi_bw_up-v1-0-9bad1e42bdb1@oss.qualcomm.com>
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
        quic_jjohnson@quicinc.com, quic_pyarlaga@quicinc.com,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739774050; l=4852;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=0G/XG/YxFU6rag6WMJ+nAr2rfc55DQyaEL7pfp0M3cA=;
 b=Hv/Cj81cpzxIilICVPcYYxPIKptPd12BGfcSJ+l3Y8rH9BsZmDsiq3nLW5/vP+pOP5tdLvy7T
 nSrKxG7A+K/Bkp3+j4W6kGPcRka5O/GhV7R4Fhb2BVuY4JowhVuxifs
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: nCK3Revoei6Hk7_mL8EyBoGjxyr4eF3L
X-Proofpoint-ORIG-GUID: nCK3Revoei6Hk7_mL8EyBoGjxyr4eF3L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1011 phishscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170056

QCOM PCIe controllers needs to disable ASPM before initiating link
re-train. So as part of pre_bw_scale() disable ASPM and as part of
post_scale_bus_bw() enable ASPM back.

Update ICC & OPP votes based on the requested speed so that RPMh votes
gets updated based on the speed.

Bring out the core logic from qcom_pcie_icc_opp_update() to new function
qcom_pcie_set_icc_opp().

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 105 +++++++++++++++++++++++++--------
 1 file changed, 79 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e4d3366ead1f..a39d4c5d7992 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1294,10 +1294,88 @@ static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
 		pcie->cfg->ops->host_post_init(pcie);
 }
 
+static int qcom_pcie_set_icc_opp(struct qcom_pcie *pcie, int speed, int width)
+{
+	struct dw_pcie *pci = pcie->pci;
+	unsigned long freq_kbps;
+	struct dev_pm_opp *opp;
+	int ret, freq_mbps;
+
+	if (pcie->icc_mem) {
+		ret = icc_set_bw(pcie->icc_mem, 0,
+				 width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
+		if (ret) {
+			dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
+				ret);
+		}
+	} else if (pcie->use_pm_opp) {
+		freq_mbps = pcie_dev_speed_mbps(pcie_link_speed[speed]);
+		if (freq_mbps < 0)
+			return -EINVAL;
+
+		freq_kbps = freq_mbps * KILO;
+		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
+						 true);
+		if (!IS_ERR(opp)) {
+			ret = dev_pm_opp_set_opp(pci->dev, opp);
+			if (ret)
+				dev_err(pci->dev, "Failed to set OPP for freq (%lu): %d\n",
+					freq_kbps * width, ret);
+			dev_pm_opp_put(opp);
+		}
+	}
+
+	return ret;
+}
+
+static int qcom_pcie_scale_bw(struct dw_pcie_rp *pp, int speed)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u32 offset, status, width;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
+
+	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
+
+	return qcom_pcie_set_icc_opp(pcie, speed, width);
+}
+
+static int qcom_pcie_enable_disable_aspm(struct pci_dev *pdev, void *userdata)
+{
+	bool *enable = userdata;
+
+	if (*enable)
+		pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
+	else
+		pci_disable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
+
+	return 0;
+}
+
+static void qcom_pcie_host_post_scale_bus_bw(struct dw_pcie_rp *pp, int current_speed)
+{
+	bool enable = true;
+
+	pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_disable_aspm, &enable);
+	qcom_pcie_scale_bw(pp, current_speed);
+}
+
+static int qcom_pcie_host_pre_scale_bus_bw(struct dw_pcie_rp *pp, int target_speed)
+{
+	bool enable = false;
+
+	pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_disable_aspm, &enable);
+	return qcom_pcie_scale_bw(pp, target_speed);
+}
+
 static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
 	.init		= qcom_pcie_host_init,
 	.deinit		= qcom_pcie_host_deinit,
 	.post_init	= qcom_pcie_host_post_init,
+	.pre_scale_bus_bw	= qcom_pcie_host_pre_scale_bus_bw,
+	.post_scale_bus_bw	= qcom_pcie_host_post_scale_bus_bw,
 };
 
 /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
@@ -1478,9 +1556,6 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 {
 	u32 offset, status, width, speed;
 	struct dw_pcie *pci = pcie->pci;
-	unsigned long freq_kbps;
-	struct dev_pm_opp *opp;
-	int ret, freq_mbps;
 
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
@@ -1492,29 +1567,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
 	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
 
-	if (pcie->icc_mem) {
-		ret = icc_set_bw(pcie->icc_mem, 0,
-				 width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
-		if (ret) {
-			dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
-				ret);
-		}
-	} else if (pcie->use_pm_opp) {
-		freq_mbps = pcie_dev_speed_mbps(pcie_link_speed[speed]);
-		if (freq_mbps < 0)
-			return;
-
-		freq_kbps = freq_mbps * KILO;
-		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
-						 true);
-		if (!IS_ERR(opp)) {
-			ret = dev_pm_opp_set_opp(pci->dev, opp);
-			if (ret)
-				dev_err(pci->dev, "Failed to set OPP for freq (%lu): %d\n",
-					freq_kbps * width, ret);
-			dev_pm_opp_put(opp);
-		}
-	}
+	qcom_pcie_set_icc_opp(pcie, speed, width);
 }
 
 static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)

-- 
2.34.1



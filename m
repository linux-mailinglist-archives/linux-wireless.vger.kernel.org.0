Return-Path: <linux-wireless+bounces-23854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6170AD1BED
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 12:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E433A4CE1
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 10:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD35425B1DA;
	Mon,  9 Jun 2025 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NZKDSen1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F305D25A642
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466343; cv=none; b=HqYueTJhtNkdR00MATqYCuuoWOzzZEyPzktQHuTIYidSrAsPU5o8/7z/23eY8MeIZVAVxs/EeKdMZ1OdAXYjMkOuVdVTP8IhQDHYiRBwVQRPZnHTZFwSYzgw01SsTrhPRhqQRFTYQ8GnDmb7ZWWuN4VLUAPq72uLLljZEnSaNvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466343; c=relaxed/simple;
	bh=rfpuuz4A0QmsWV8lRO0l5whEsWzWwv+rc5GG1/o0xok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LlFe+FHn+f8K3QRzf08z0lffFdCnV5RJorSH90NnD1/AuO1D+HfJqtcRa2K56+qpZt1KhyONEjHnkMqCmqN7B+J3W7/scEnj36Cy6vEtUc/3bVk+JP6N4cKy91IqHIxpdsAJosUG/9hvt3LzXRSdoKEj/Es0YEt2yRudWsq2MxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NZKDSen1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5599R2W8001080
	for <linux-wireless@vger.kernel.org>; Mon, 9 Jun 2025 10:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QsooE1BDcjvS4+pylG64GDXCYMB/yvCU5ly5nWPDrGY=; b=NZKDSen1iZxQsCyL
	umvq/NRS79yMsXt8GKVeb+0Ht2gMZR8HOyPCyoYTBDXIDg80nh7sCAcuuXDedPLM
	WU98ISW6XS3E19fXVbRplrsflSlCllf0rlU3eVAA9IJT//fxOnSPis4tPaxMRJTx
	/cRDz37Y7j9aiUHzFQPCw2kng2ixppx3V6SSg/fYgJrlcZFSkLcJEAW+XVAk71si
	zxnU9YaIyrHaP2lBuvtJaZBY4VEMcaKaPOi0WeU7tahv+YRVKGEHKfvzSFmkHPfs
	51bKzHMU3S05fWzgbYVOXdWvAr8fUeS52S/EryztCe9vuHMs+g5fuhJLhZbC56wJ
	JmnA7A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dgxp39s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 10:52:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235dd77d11fso35402325ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 03:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749466338; x=1750071138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsooE1BDcjvS4+pylG64GDXCYMB/yvCU5ly5nWPDrGY=;
        b=WcWAKIV12bGoMP8SDifR+TAd9nW3YACUTwvEAtmHPbO1m0I7A1WtL1L+ld3SQEX5VH
         gAr1jGQmLutIQH+GRIy6rOKn33BQm4xayIYPnTehZ189iWivNTzi9+V03FSHQnhMvOGl
         0cTfWHvWxwex83PBTIIVEfVQiQof4zQR9JeOMGHlw54YWUyY+Xy5a8Vpis99FqRJgYgW
         95jkFqLkzIL8nDUchp/5kKktuG/VPAuRJE88Wm5gt0kzHmvAg4RMnjRK4Li5B7WUQx1l
         +5tfSZPlJuOmQcVgINVllfUnHSfB5WE/amWDfUZHyntR5qSMTRKf3z4OP9MdwPQ3dhLg
         U4tg==
X-Forwarded-Encrypted: i=1; AJvYcCW4KZmcweiC4GsSOA4WeG6q2QYrm+V2WCLtLffoVVC/GZMiQe3dC/CoUF4ISqpBL4WGt2k/dn7sMr5NkUkjJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHS3KJB4908XAESPBWz3j0VrJhPfzRHsfZItBznsxAI0nuvlro
	n+JIIu37CX1c7nkBahYj+gmf5aZAALUC9Vh1LXIycSZurbUEb7SwHba+rOnTy4g42QQmQ3H+vgZ
	bzyRPxJE0JkvUnl8sNqjuwGWdp4ReWUSzxIDi+OOmgssO50dNADE0cwblufy9nyXeWuYiZA==
X-Gm-Gg: ASbGncuBE+6eBwS4PkbHtAZhdWbZYQ7fv9hZ52Mt8t/z5V0nfFw+aCluaYpG0XVTCMB
	XcciLPELfUsBk+Z+ks5q8cl9GGE7KncXjO9kCwoCJMpD0TSSePRLWMo+YtBT+hGMNODOy+5ggl9
	gFdzYNOzuyPrui/amfgxwBKHceOhccctpre8U+IBvxVG9EPLLx8RPFybNkmD03rlvfJ3uWrXaLK
	0dWNSsJpX2CQOtr5zJqSubpS28/xVQvr6Z502TLWikFDxhBnY98FpuANpUj9rS9CQeD9zxdC9Ys
	+rll8nQet+0tA8fr35Yw84wCeAeqfHvmZ3xL0BV1CjRFGCg=
X-Received: by 2002:a17:903:2349:b0:235:2799:640 with SMTP id d9443c01a7336-23601d225damr200290185ad.25.1749466338501;
        Mon, 09 Jun 2025 03:52:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFsj9gbm1Xe2gggDXCvM8eocxd1s80k1LTfUZKFfmG+nVAZVHG2TZKNjCJmXQ8psxA+pG/sQ==
X-Received: by 2002:a17:903:2349:b0:235:2799:640 with SMTP id d9443c01a7336-23601d225damr200289795ad.25.1749466338116;
        Mon, 09 Jun 2025 03:52:18 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603092f44sm51836465ad.63.2025.06.09.03.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 03:52:17 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 09 Jun 2025 16:21:28 +0530
Subject: [PATCH v4 07/11] PCI: qcom: Extract core logic from
 qcom_pcie_icc_opp_update()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-mhi_bw_up-v4-7-3faa8fe92b05@qti.qualcomm.com>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
In-Reply-To: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749466291; l=3243;
 i=krichai@qti.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=rfpuuz4A0QmsWV8lRO0l5whEsWzWwv+rc5GG1/o0xok=;
 b=YVwMdol+AseMlfIz0/NjSMg6XCl8+u+DF7+jT+n81+w4e7KH9oYdQk4afC9TamYNqaM1TKy8M
 bo1nu3Kf+/ZBUYGTEKdroWLMKZLaUue+XTINQy4n4hMD1rB2U+XFiUi
X-Developer-Key: i=krichai@qti.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 7FZwXPtlpzeAaxChnvCrOcPlPgQcUL_M
X-Authority-Analysis: v=2.4 cv=HMbDFptv c=1 sm=1 tr=0 ts=6846bce3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=h4B-02p0z56_JbXvspoA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 7FZwXPtlpzeAaxChnvCrOcPlPgQcUL_M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MiBTYWx0ZWRfX1PqPWMj5heWW
 1To2V1ULJNk8Zz5NrEYhggYsB1BJPJDzmkoD3Z0irOw6UXUm2iioHDQlNNAugTcg4nNqIq1Fc6+
 wncPmeuWouSHqpmsuyrDlKYYWAqhxzjD7sfV+OljBXGajn5knQbG1Jp2Fd2On3yapwbtaiH39k5
 n87zE9IljtxsjBjyy0JCseMdL2JQRQ1/ylheu+LSTsCFSwCdNo/isLSrCBT46sGlxsDqM+WLMc1
 14NXyCHmdUXNW7JRMdt+cxQZRg9Q4XI/QsIpkwMN+8H9i4F8b4DQKDWYKTcOKgsIhvScORIXy5D
 6R0adBUoxobW15io3m2AAgOvovwfhLJRkLCszyF4kheb9xM0wGtpU7rStX15y9LoYjhG/WwseLf
 Kc+EPLQOob/DzV7sMJZ/ZXIcAxSF4SE6UluqDAsKfcSJ0V+nqybGo1R1pB5hH+oTNEv/+7Pw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506090082

Extract core logic from qcom_pcie_icc_opp_update() into
qcom_pcie_set_icc_opp() to use in other parts of the code to avoid
duplications.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 61 +++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c789e3f856550bcfa1ce09962ba9c086d117de05..02643579707f45fc7279023feb7dbc903e69822d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1294,6 +1294,40 @@ static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
 		pcie->cfg->ops->host_post_init(pcie);
 }
 
+static int qcom_pcie_set_icc_opp(struct qcom_pcie *pcie, int speed, int width)
+{
+	struct dw_pcie *pci = pcie->pci;
+	unsigned long freq_kbps;
+	struct dev_pm_opp *opp;
+	int ret = 0, freq_mbps;
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
 static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
 	.init		= qcom_pcie_host_init,
 	.deinit		= qcom_pcie_host_deinit,
@@ -1478,9 +1512,6 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 {
 	u32 offset, status, width, speed;
 	struct dw_pcie *pci = pcie->pci;
-	unsigned long freq_kbps;
-	struct dev_pm_opp *opp;
-	int ret, freq_mbps;
 
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
@@ -1492,29 +1523,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
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



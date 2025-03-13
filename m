Return-Path: <linux-wireless+bounces-20312-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC59CA5F2AC
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 12:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0FFA17CC4E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 11:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8962661B1;
	Thu, 13 Mar 2025 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LJdpXMm1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E9266B4F
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866066; cv=none; b=n6pBZUyDVB6lh6VMiOIno1LVWA/5xVYGpcznWmTwE2jiyyEmiEn6h5s+AJqlCLNv2a63wymXkhNC6B8MGl2RDCOXlbr2WF1AEhnq9C2DDQQNFhL6c5GP3IUv1o7qHRXvwxaVQRzfU/ePmCc5Pz72GqesTBPDQHbBx6BBwlAdZdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866066; c=relaxed/simple;
	bh=PmKuDjh7TYnL36BsL4uFK3e2cvQCdB+O1CmCQrAD7C4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xvvrutz/SI0q+IDv7FTAwaBREId8APApHLr+JCe8e3oGyMEv2to+B+MRr2s9/+mGGM76/21mAQ+/r7Q7oDK+usUzG6mUVZjj0Lx0dvkacEl2JcKr/tibDMz76FD8Z/1l7u7e3hv3n1FzIQzOPwe3+V2oA/LJ6nw3ZZu77o02upc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LJdpXMm1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DAVNYl013284
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 11:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9igTd27vOSt75Vx+/a3cETdMPX96Kxrxr1+ntLhQKa0=; b=LJdpXMm1EP47TTkE
	dCKCnyi9uSNuDrjG6kCvT1m0N04PDA+pLITKhF5ob+irswRvHAWAahJ41OoESqM2
	pkvxkCxhZjb/jRCn01OLtWtekBZms7TBbH8dEhXjI+jeUmxymdWSKcRcmU1d/ss3
	sfQoyyplCiN3SCCjY3ugZQYTnOlLqBvSZ1ePbOXC87DQ9naQgXCxuIYMAmpZgbyr
	zAAbdQLwiYlzOWzyRLnKjJz+XOqeSvBPZDbVdIGYs0AolySNYv67GPA9hlGXEv31
	WYPVdyTDjBkNxCe1U59aZuKbbqpBXZ5MoKYQa9my4N5OCte9tGxmIFuevK+g/1jW
	v7S2uQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2p5qna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 11:41:03 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso2526576a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 04:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866062; x=1742470862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9igTd27vOSt75Vx+/a3cETdMPX96Kxrxr1+ntLhQKa0=;
        b=BelaML6oYZ4aMmP6U6NzKjx9Dr+O65AVT5foK4cu9XHNnT86C5Kdf1xsGiVm07h6mQ
         ys5nn++V2FWs4GYi3SPVIUqmNR5b7/qgEavO72gMLhuW+y5GFV8dkNn+txzXgRQYfPgj
         cnnxVWbV8HkTHFjAlG765dIn1epKcGdo0z8USjrWC9ZVTqYALGzaxsvMpETciyYT1ANK
         U8sACuW539EGL+nPSs0wiEWRvPMBapKDbVO4FuFCBNvfyLln5HNUPf41auXUXOBROyud
         aQ+7uluQdHyosX8ig113WRyKXn7cKD15MjU4HPYSfs8TZCiYogcRLIrfu8QO0neilnPZ
         yBSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW96xVaRcsd8eRufFyePTC540L4PtgkBq7P+f+wfyTSiUMsWEvs5n9HjoNm7R2dMyd/lWK6F4hjIhWu22aQIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEEjARj3IZTKA1oAw6U5OSW8ciDbXdM5TVLtICauVcLd5VQqAA
	KipvUmrNM7DHChhRZjsulrtrHYvswH/TsIb4CvmRTeRPJsTXUBpw/rld7iFl39ho6mUtmGW5VZ+
	6YzlwsZKI26d75BigiJaRvBmY1/7d4MEOj/2/nlrpkbGTdoiC7AU0tY8XmyEchL+6jQ==
X-Gm-Gg: ASbGncsFXpA7fOEKhSwsgNJ2yqqxpeaQX1tvmpSqsNq6kISF3tnsmKj9H8Q3X60Krat
	oIk+IhVD75/Mc9aW10TZqYH6Nwbcs7pe46S4cxDOceN4meIzaFuCb8avaL3R+yhZY/KpX0s14+j
	FB/hbG07/9QirzBiPvc7Ke8lXvW05MGvSwvJuFzSMuQQ3KG0tA3MV8pN7dXnAjSNKqpGEgadPI/
	8N1q95ExI/yRlCgPNSUWlnEr2nSg5KxTemCgekj2R2DaX+1xPylU0bkeF56oEZUYRxYSxffN8fV
	8I28glQa1hr9JKXy/BEhb204kYhQ0I0BJWlI0xCBcKmjNze5xH0=
X-Received: by 2002:a05:6a21:6e91:b0:1f5:7eb5:72d1 with SMTP id adf61e73a8af0-1f57eb5751amr22690504637.28.1741866062275;
        Thu, 13 Mar 2025 04:41:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlL/GCRjzts+GtMG3DvPuELC8MTIBXKCPb9dz3VzWgArb8MlHvCY5x4YkSJvM9UW4P6sKDeA==
X-Received: by 2002:a05:6a21:6e91:b0:1f5:7eb5:72d1 with SMTP id adf61e73a8af0-1f57eb5751amr22690452637.28.1741866061945;
        Thu, 13 Mar 2025 04:41:01 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea964e3sm1063219a12.76.2025.03.13.04.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:41:01 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 17:10:10 +0530
Subject: [PATCH v2 03/10] PCI: dwc: Implement .pre_scale_bus_bw() &
 .post_scale_bus_bw hook
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-mhi_bw_up-v2-3-869ca32170bf@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741866038; l=2235;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=PmKuDjh7TYnL36BsL4uFK3e2cvQCdB+O1CmCQrAD7C4=;
 b=VI/8VNWycXRlPi0pSYk0Fr6aifEQor01L8qOLpfV49fEVzw8N9gQDJummotBMBPqY31zZA7TF
 8B8Qv21rWMtAW2YvmJKRYqNsOmy9HioTo1b4j7eqVXVCjt88vTUB69Y
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=HP/DFptv c=1 sm=1 tr=0 ts=67d2c44f cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=kXhGf0cxdCgfIYue-YsA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 5VG_k9i6xZOB22Fm0wZOdUPi_jEQq-4O
X-Proofpoint-GUID: 5VG_k9i6xZOB22Fm0wZOdUPi_jEQq-4O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130092

Add support for pre_scale_bus_bw() & post_scale_bus_bw() function op's.
Add support for DWC glue drivers to register for these ops.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 21 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ffaded8f2df7..4da4df62c3f8 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -697,10 +697,31 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 }
 EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
 
+static int dw_pcie_pre_scale_bus_bw(struct pci_bus *bus, int target_speed)
+{
+	struct dw_pcie_rp *pp = bus->sysdata;
+	int ret = 0;
+
+	if (pp->ops->pre_scale_bus_bw)
+		ret = pp->ops->pre_scale_bus_bw(pp, target_speed);
+
+	return ret;
+}
+
+static void dw_pcie_post_scale_bus_bw(struct pci_bus *bus, int current_speed)
+{
+	struct dw_pcie_rp *pp = bus->sysdata;
+
+	if (pp->ops->pre_scale_bus_bw)
+		pp->ops->post_scale_bus_bw(pp, current_speed);
+}
+
 static struct pci_ops dw_pcie_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
+	.pre_scale_bus_bw = dw_pcie_pre_scale_bus_bw,
+	.post_scale_bus_bw = dw_pcie_post_scale_bus_bw,
 };
 
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 501d9ddfea16..16e02646a8b4 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -354,6 +354,8 @@ struct dw_pcie_host_ops {
 	void (*post_init)(struct dw_pcie_rp *pp);
 	int (*msi_init)(struct dw_pcie_rp *pp);
 	void (*pme_turn_off)(struct dw_pcie_rp *pp);
+	int (*pre_scale_bus_bw)(struct dw_pcie_rp *pp, int target_speed);
+	void (*post_scale_bus_bw)(struct dw_pcie_rp *pp, int current_speed);
 };
 
 struct dw_pcie_rp {

-- 
2.34.1



Return-Path: <linux-wireless+bounces-23852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EE1AD1BE8
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 12:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3999F188E1BA
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 10:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BED259C80;
	Mon,  9 Jun 2025 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MpKYz8vo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25383254B18
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466330; cv=none; b=FzrVuu73bQQYo5bb6h6ZiYNfTabycuq2iy6j6XpwT9JULlu07z8Z2OdVMW0Tvo++KQoiYCA/pd2lifTWr6LEn+Wr/CqYgAHXiL8RWrgRKYuijt3ibsHtCKqdPyLaadfRnM4RToPCX1n8touF1bO3ssSLYDIqxWeQ3FwiCW0qzFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466330; c=relaxed/simple;
	bh=Oy5xhLR0GTbxXIyGSehq2C1m7jHsrRB+NLo3OFoCcpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sgiUBFsB4XhJjG46oIIW6qRaE+SMlLUT7NHWgo6kAH3W90baT8OCV4CtzdoEF32UqSBzy4TO1cKgMZw9Q68bQmTT4qelWQUfljB/PsVoOQEktzukut0yNZb3/aKJF3IZ4xbBJJwe1CLdSS3DG0VSfZ8AHpn3aap2UmH/hi9/XyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MpKYz8vo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5599S0lO009897
	for <linux-wireless@vger.kernel.org>; Mon, 9 Jun 2025 10:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tq24Wrli2Qp9Evrio+qi8qkO57cIWgh+60vTcG6QRNc=; b=MpKYz8voCd14SNZk
	b3H4gwBUmyxfECn4zVOKUdcz3fDqCrVXIeT/2zxj7AtaYAR8A9SRcO8dl01gxUWD
	Pv+jPXtvPEF0pyxMQF3ZRX6e3tRuMBAwdrOsbo7FW2qyhwoCTEq0wfTs+zlYwdla
	fyzHDyhtojphon9hHzFgpIbw3wy1P0lrt01F2Qb6JtKdYkIglJgW53B6s58FMcsn
	4EWuhMpKT9csLJeUe3vUyaKcGNUuD+v6ZAfvqKOeTzyF/YjnlcmcsvW1JvC2/mAQ
	CF7Ozxj2TBIxbtWWVPPk3hS3lTXmzMciAJK/oD/AZf2gQSqXsAo+nHjvBqehcN5h
	LzAlAw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474d11wxpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 10:52:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235eefe6a8fso29369105ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 03:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749466327; x=1750071127;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tq24Wrli2Qp9Evrio+qi8qkO57cIWgh+60vTcG6QRNc=;
        b=hyo8PiMTzXyINb3/yIHaGgjWIs5WGGKkzfY+ChYJ35GhxMzbTVj63tl46o90NiP1No
         QkSjHbH/+JF+mvOoVuTXht8w/ZlWBBVVRy55c7B3zLUyFFYYZOKCiSBhFVqcKyCvsxlW
         5ulFuPYFHlz0yH6oDEE+aGo/LATrHC/usJ1o0G5quItkvL9hshIOkLiyZI5HM7b5AB3o
         INKsMqfdAdjFHeR9YmjAyFWVJFcYF3lNe3rVxJ4zkAALmOMZyQ8ctb7bnimD5pkRKfDm
         AZT88oAJhmLDhjBPaDiwxY9Tt2EDG02lJgv1SNGqkAUoxoMzEpQt79Wjo5yfCeuOMwe6
         eWfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkFlrAnZpgZTItN9YmWEC9gILfAOJGy0x8yJghtPJNUmjWqtmEGXQsgT1TyceXsIej+0NLqKt3sr+j33c+mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxO8k6i8o9d6qkyj29YhBNqXoFpbtVcd2tEjDxX6GlCGT2/dl8r
	4Yo5dBaEE+uAH2kDQ16WY1iVLPVscDPDRtYpZNJcfFhHrVy3a0pl3e5bx6sLZFiD59wNZZgsTBk
	g2Hcf7UKE3AjB09dWM9t0gOd+9xkLa2pgY+TJIi4BqVcxnNXahoP0lwE2eGgHxwj+w5qgRQ==
X-Gm-Gg: ASbGncvt/EFEzVsJcTPREBR/dprRE/DOgMt5Jfhg/CIdZTT1O3RV3yLgUI9IAWwyal+
	ZxN7ze3xuG5VhS0OcnCSTfvdQHu24lJd/oiAIorAibVAlFUwZ22zIC9jBIrTxnBG3w4EQbiMvc+
	1q1FvXxLmIkS7WezhCNQuzLkPRIfjesSlURjTj/YmzWqjUUz4w1mRIMCgcb1WeasCpfvPJdpMRl
	qjm+guqj/Y/zyI/BVRBH4YIDiXDjuiCsAdEnG40S3MsDOIig7BH6C3YgCeIt53VgoWiQynfcC2z
	xiiBklugOpyFnT6ud0Jf/zh1RYJhEqar3Qcw+OJCyjrS1Hbe6yufT6GgKw==
X-Received: by 2002:a17:903:228a:b0:234:986c:66f9 with SMTP id d9443c01a7336-23601d2485dmr182543695ad.22.1749466326738;
        Mon, 09 Jun 2025 03:52:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDh+coUuKtWGJZpFtogDmaKOAu2e7dpBqqLmg6/yIehhTMpFOXeREwgQnJUjxOnFZLxpXf1w==
X-Received: by 2002:a17:903:228a:b0:234:986c:66f9 with SMTP id d9443c01a7336-23601d2485dmr182543445ad.22.1749466326366;
        Mon, 09 Jun 2025 03:52:06 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603092f44sm51836465ad.63.2025.06.09.03.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 03:52:06 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 09 Jun 2025 16:21:26 +0530
Subject: [PATCH v4 05/11] PCI/ASPM: Return enabled ASPM states as part of
 pcie_aspm_enabled()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-mhi_bw_up-v4-5-3faa8fe92b05@qti.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749466291; l=2258;
 i=krichai@qti.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Oy5xhLR0GTbxXIyGSehq2C1m7jHsrRB+NLo3OFoCcpU=;
 b=FsGVVNU4bBpjH/bLJkqhzBlwA7pBTdKA29oGrWjW1VZGoNcZ5tmxRnyiCdmxxfmQ0EcHrbZCt
 jOaYiPUbZ5RBI4TM1CIEZmIONqihPCbrpnBazbboLIEdYWTK8S6/0Zo
X-Developer-Key: i=krichai@qti.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: hXheBZKy5t6V6Pur7COstV6iHm_jRTBN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MiBTYWx0ZWRfXzW7lTfcETza5
 c8X++WYTjlk4fQPqUEP+JKnxjDh0Vx6f+5dNVMHkFHkcJri3YtSdemWrMI74RwM2N5cOWJZkr0k
 kqHtUc7ZK7T41BguLS6I0GfcxGLFlknJhha+0M7/Hvt2v9IsvLx+RzlSYCkcFNhEYFRyMZMA78+
 3t9qs/sS4BSXJA/YKh9SVCt0PWTBMcLGRugKUzbtKX2EnJhd1VZi9l6IGbj9j2V3NJVEBRhc1+O
 N0XzTPakMeA5DJ+NKPJ+5Czur0uulxnXF2AGEIL21sFXvo73t0lu+1iRaT1S6oTi9qSfVpf3ADW
 2jdndP2UdoQlkHhyMRTqZv8UqWMpPGYSIRuv1aVw8w5rlfhPHPwDBSr24EqQL+bZeMvhhC+U4eQ
 35znybNqAgNxxDimOzhIG39it8RwSwMaZ2U6jKB1wvmQQel7u/m3pO/i0yctphtJkST16W4Y
X-Authority-Analysis: v=2.4 cv=GYkXnRXL c=1 sm=1 tr=0 ts=6846bcd7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=wuQQqu7ThqwHlQwkt1oA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: hXheBZKy5t6V6Pur7COstV6iHm_jRTBN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506090082

PCIe ASPM states can be also controlled by userspace using exposed sysfs
entries, if drivers wants to disable and enable ASPM at runtime they
need to know enabled states for correctly enabling them back.

So return the enabled aspm states as part of pcie_aspm_enabled().

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pcie/aspm.c | 4 +++-
 include/linux/pci.h     | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 29fcb0689a918f9cb123691e1680de5a1af2c115..94324fc0d3e650cd3ca2c0bb8c1895ca7e647b9d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1555,8 +1555,10 @@ module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
  * is deallocated only when the last child of the bridge (i.e., @pdev or a
  * sibling) is removed, and the caller should be holding a reference to
  * @pdev, so this should be safe.
+ *
+ * Return: Enabled ASPM states
  */
-bool pcie_aspm_enabled(struct pci_dev *pdev)
+int pcie_aspm_enabled(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1740bab514b0a9a61c027463a1fb154843312a22..cb703443290a013c8372333fc8d547d190d9f3b4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1848,7 +1848,7 @@ int pci_enable_link_state(struct pci_dev *pdev, int state);
 int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
 void pcie_no_aspm(void);
 bool pcie_aspm_support_enabled(void);
-bool pcie_aspm_enabled(struct pci_dev *pdev);
+int pcie_aspm_enabled(struct pci_dev *pdev);
 #else
 static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
 { return 0; }
@@ -1860,7 +1860,7 @@ static inline int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
 { return 0; }
 static inline void pcie_no_aspm(void) { }
 static inline bool pcie_aspm_support_enabled(void) { return false; }
-static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
+static inline int pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
 #endif
 
 #ifdef CONFIG_HOTPLUG_PCI

-- 
2.34.1



Return-Path: <linux-wireless+bounces-24974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D0CAFD62E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 20:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60AAE17E523
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 18:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99552E7178;
	Tue,  8 Jul 2025 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I4sBTt+O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408AC14A60D
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998280; cv=none; b=Ih4tCv6Q4JckA0fqXR2gZZj90zdxPnj6hrj4SR8wyR5B6r5z58C5yMcI0xq+QM8lS9npvBMXpd0p+Tep58/7wW/VN9Cgx0ijFbO0ze/4qlEUEsQMUdLbIUsTaHcE4x7q6syEaDrkMTCDXkxpsAWjX0Ze6WDL/2D+gPptVTLLjEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998280; c=relaxed/simple;
	bh=E0u5P7I3WkgfHvZE3fnJKZGoKYo3qoRrCMma1baXDPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=egi6Co0pxB2zEK34TSD0Ysjue2YAmlucWzJ1FUyhwbg9QE4zHqxvAAWIIYdibXaMjDUjEGIPrqd/HyeamHnfoir5DQuJDiDNtOpzhP/IVBDvPmcVM8CuI24R+PJKHTHF1LI/hrCqf33Ch8rSm+AgqGvfn2I9K1fY238xvfivwSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I4sBTt+O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAP64012171
	for <linux-wireless@vger.kernel.org>; Tue, 8 Jul 2025 18:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PDQQPlyVXHe
	TjS0woDlYKuu2qKMss3vgvb8MQtjuQHw=; b=I4sBTt+O7CVW0clC3AfMWaoZPaJ
	gT+NLiNgFVp7B3jUr4mNpyW5QUvQyNdFTPdgzy3aJ0L9VZZJFAy4WabPFBLkuPEu
	6B/FxHN7SwtXDFeDwFv1SPNkrHrX/qd2JOw1CO7mJe9dLrDgAahOcpUtEleedHBD
	UpE4gDarMeF3a10veLOWcGmS7ganWLGPTju0+KlDCUAudm51K2CRRvsglFQvrrtN
	G0lF7H3lH9QnyhMHiyYtVy4qqqegzwjnltFGMEJkxwPvkLzuSvE1uNgyt6+eH9ig
	JePmiJ8YqUjb4s8P62bmZJZloer1gSKJvawztELTHq1oVYycbW5FtH/MqHw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pv97rk6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 18:11:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2369dd58602so48867885ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 11:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751998277; x=1752603077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDQQPlyVXHeTjS0woDlYKuu2qKMss3vgvb8MQtjuQHw=;
        b=sDgwnPd9gWq6IFtDQrdGxPGkEQm+zfqA9Fuj0P2VPcgIpd4mmkgSGSaoDWl1K/+FA1
         Bgzx7s71kQisbWxlv0/J+omegJkrRs66IuD0wHCF8AW4q92opnm97zo7sIJ+G16SE1Lu
         7PilXyVnCTwZduFQYnDSNmwmMtU9COju2SWu/0fOSTwmnlEPdVENfDP7MjD6zxQ5VIUs
         w4ANdJCwWbfLXPiP21TEdiywBBwdLQJcVvX/grRtzUHvmPxGFKaVN3QL6sO5j6R+3a2Q
         TunmZxemmbGeIDbxYjjcWXb1dNsCybYNkp3//yP40l2qRnSJag+NTnqsrAr8b2L4AXGC
         SHiw==
X-Gm-Message-State: AOJu0YzTZKugbYwtAZlgM6g8m7gJ62sUAhZoT/jttxaHxv01RKsKP+0W
	2DSEieFvF05ZJ0Fk0Oj9K18iCDcitr4O+k/ioKJREVnH/Yv1Kb/JR7yddO2z5H+65/Jt8l/xCRu
	xLiMecd0/Qc00pKdKKTpecjvR2Du55u/stjIsFEwmKNlecQhgRTv6x438mmki2mWtGStXGQ==
X-Gm-Gg: ASbGncuY+iZFI0dZTXA0MGOGoSJ3bMzfqBJXfPMbuQg3WMxdrFfBvN5ZwzV0FFY+YJT
	yJYVW0ZjdfdHSHd7MmRftMXtgj2dWN2HsuTGv8Yltf5E/rlIGyJeS2WXDtfPORg0wiXzGRaN4Q6
	zb5bvegXh+gN2yBKpPFtnu8P0lVvbqMMCB00SQyijMG5H+hpZ0IeiLMQ1oLckLBCxY19ljvJM+H
	OP65DHUUmquLxXV9wOziwudZPF5v7wlK6AzNfX0EHtleZIESwOuAtantpbugba4adFnIyy7L8y5
	7qfdAk256O1wh/ACFMxbEyKf+nUCNyMxEeM036noX7phFrvo8QlG1JvaEKDcT1G43P/zcZdybnO
	wUh9N1AeD2Cl7tI4QTZJxz7y/QHFDxIgNikS2FZ2i56PZQA==
X-Received: by 2002:a17:903:11c8:b0:234:c2e7:a102 with SMTP id d9443c01a7336-23c875acb4bmr302714165ad.43.1751998277481;
        Tue, 08 Jul 2025 11:11:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMyeSXllmP6m2/JdAhcJhqK49ek9KKCbovVDSPqQI+Y6lC8k1G7S2GMhzpPyUXaWnSfqUxiA==
X-Received: by 2002:a17:903:11c8:b0:234:c2e7:a102 with SMTP id d9443c01a7336-23c875acb4bmr302713865ad.43.1751998277053;
        Tue, 08 Jul 2025 11:11:17 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455d0a9sm115980425ad.95.2025.07.08.11.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:11:16 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next 4/4] wifi: ath12k: Enable memory profile selection for QCN9274
Date: Tue,  8 Jul 2025 23:41:02 +0530
Message-Id: <20250708181102.4111054-5-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708181102.4111054-1-aaradhana.sahu@oss.qualcomm.com>
References: <20250708181102.4111054-1-aaradhana.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FrUF/3rq c=1 sm=1 tr=0 ts=686d5f46 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=RydBrGAMdIcuIQtkkqMA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE1MiBTYWx0ZWRfX/HDvZovcWWBR
 fkK4FTI4GSC20+MhR6VYLm0k4sGzrMHG20I5QB/OmHs88U9FPhlKEWdtI1pONDa81QbdufEflq9
 ATZLG4BlyH9fdUgkUURMzXHoqFFCPJhuEKnZ0DtjMckDNyGAOxxq88mRA9ICmGO41akfbC+8MF0
 bFLFE9LVfOlFpsli9oXsrGtzO4nJcEcDsLBXqspbMYaA93xwlevTdJzpgnXeIjFqUp+jJnfI8a2
 q3jhD1OYIZG39W7KqO7mI/meflBIhB1h6MpT25gyzuAQPgJUbjwAGxllr6oTTnqC0ZfUk7SeaU8
 80cvfey26rGiVCh1KoPywShNm8/Z/pNpKeU1tjX3Ygg8i6MJR8kiobSme2xVYcORlvjYl8ZYcSU
 tJnkf+oRqmqN8/mPeeqkLDTegsuCtzQ/fJAJvC8FLJvBzUzSH1cLZYvCp8lAhniOBrRoj1/9
X-Proofpoint-GUID: Ipp5k95CkJpr91jm9QMN8L01qqN1gcUb
X-Proofpoint-ORIG-GUID: Ipp5k95CkJpr91jm9QMN8L01qqN1gcUb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_05,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080152

The QCN9274 supports two memory profiles: a default profile and a
low-memory profile. The driver signals the firmware to enable
low-memory optimizations using the QMI initialization service.

Add support to select the low-memory profile on system with less than
512 MB RAM.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c  |  1 +
 drivers/net/wireless/ath/ath12k/core.c | 16 +++++++++++++++-
 drivers/net/wireless/ath/ath12k/core.h |  2 ++
 drivers/net/wireless/ath/ath12k/pci.c  |  2 ++
 drivers/net/wireless/ath/ath12k/qmi.c  |  2 +-
 5 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 8d1a86e420a4..3b983f4e3268 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -1022,6 +1022,7 @@ static int ath12k_ahb_probe(struct platform_device *pdev)
 	ab->hif.ops = hif_ops;
 	ab->pdev = pdev;
 	ab->hw_rev = hw_rev;
+	ab->target_mem_mode = ATH12K_QMI_MEMORY_MODE_DEFAULT;
 	platform_set_drvdata(pdev, ab);
 	ab_ahb = ath12k_ab_to_ahb(ab);
 	ab_ahb->ab = ab;
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 53e60dba3bf8..bf46acb54268 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1728,6 +1728,20 @@ static void ath12k_core_reset(struct work_struct *work)
 	mutex_unlock(&ag->mutex);
 }
 
+enum ath12k_qmi_mem_mode ath12k_core_get_memory_mode(struct ath12k_base *ab)
+{
+	unsigned long total_ram;
+	struct sysinfo si;
+
+	si_meminfo(&si);
+	total_ram = si.totalram * si.mem_unit;
+
+	if (total_ram < SZ_512M)
+		return ATH12K_QMI_MEMORY_MODE_LOW_512_M;
+
+	return ATH12K_QMI_MEMORY_MODE_DEFAULT;
+}
+
 int ath12k_core_pre_init(struct ath12k_base *ab)
 {
 	const struct ath12k_mem_profile_based_param *param;
@@ -1739,7 +1753,7 @@ int ath12k_core_pre_init(struct ath12k_base *ab)
 		return ret;
 	}
 
-	param = &ath12k_mem_profile_based_param[ATH12K_QMI_MEMORY_MODE_DEFAULT];
+	param = &ath12k_mem_profile_based_param[ab->target_mem_mode];
 	ab->profile_param = param;
 	ath12k_fw_map(ab);
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 272b7e9822ea..996753d794f0 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1230,6 +1230,7 @@ struct ath12k_base {
 	struct ath12k_reg_freq reg_freq_5ghz;
 	struct ath12k_reg_freq reg_freq_6ghz;
 	const struct ath12k_mem_profile_based_param *profile_param;
+	enum ath12k_qmi_mem_mode target_mem_mode;
 
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
@@ -1364,6 +1365,7 @@ void ath12k_fw_stats_free(struct ath12k_fw_stats *stats);
 void ath12k_fw_stats_reset(struct ath12k *ar);
 struct reserved_mem *ath12k_core_get_reserved_mem(struct ath12k_base *ab,
 						  int index);
+enum ath12k_qmi_mem_mode ath12k_core_get_memory_mode(struct ath12k_base *ab);
 
 static inline const char *ath12k_scan_state_str(enum ath12k_scan_state state)
 {
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 1f3cfd9b89fd..b4e7e77518dd 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1595,6 +1595,7 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 		ab->hal_rx_ops = &hal_rx_qcn9274_ops;
 		ath12k_pci_read_hw_version(ab, &soc_hw_version_major,
 					   &soc_hw_version_minor);
+		ab->target_mem_mode = ath12k_core_get_memory_mode(ab);
 		switch (soc_hw_version_major) {
 		case ATH12K_PCI_SOC_HW_VERSION_2:
 			ab->hw_rev = ATH12K_HW_QCN9274_HW20;
@@ -1618,6 +1619,7 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 		ab->hal_rx_ops = &hal_rx_wcn7850_ops;
 		ath12k_pci_read_hw_version(ab, &soc_hw_version_major,
 					   &soc_hw_version_minor);
+		ab->target_mem_mode = ATH12K_QMI_MEMORY_MODE_DEFAULT;
 		switch (soc_hw_version_major) {
 		case ATH12K_PCI_SOC_HW_VERSION_2:
 			ab->hw_rev = ATH12K_HW_WCN7850_HW20;
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 5e8943060443..7c611a1fd6d0 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3856,7 +3856,7 @@ int ath12k_qmi_init_service(struct ath12k_base *ab)
 	memset(&ab->qmi.target_mem, 0, sizeof(struct target_mem_chunk));
 	ab->qmi.ab = ab;
 
-	ab->qmi.target_mem_mode = ATH12K_QMI_MEMORY_MODE_DEFAULT;
+	ab->qmi.target_mem_mode = ab->target_mem_mode;
 	ret = qmi_handle_init(&ab->qmi.handle, ATH12K_QMI_RESP_LEN_MAX,
 			      &ath12k_qmi_ops, ath12k_qmi_msg_handlers);
 	if (ret < 0) {
-- 
2.34.1



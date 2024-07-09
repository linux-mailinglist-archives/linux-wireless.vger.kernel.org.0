Return-Path: <linux-wireless+bounces-10098-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DD692AFA0
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 07:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3032E1C218E3
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 05:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC6A376EC;
	Tue,  9 Jul 2024 05:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="POAL+C5q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8079B139F
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 05:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720504722; cv=none; b=eUBOPPyBa+pGnyCH/JFniLvXmhvsIBLOXcSkyzjA64fZb1PlQZr3KW5M7tITDAJ5KcN0PnbvzT9rJ9QNNxJDutiBn6PSmxR2B0HcJwA++vZMVTrb7K9mbvfh77JSFkk8aJTGTYkYj+qqwmPNBzDDbb9b6vqeUD+ZEwC2KP2G3bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720504722; c=relaxed/simple;
	bh=t3R0IMHKv+2QGFMziSaWB/M9pFdaIWhKmrICHKVP/NQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BwLK9+jxU7vM537KgdfPn9xV/gTblXOgglDegUTb034WNffZNj98xy4NdIPjs9Mv+nIHxrz/HNxt/02EBBiYo7DbhyK6gbUGUjY1tzqjgkTwaIKTuMAvaTs6ccRLqVjKes/qj4mzHDRuUkElylNoliDRDDoCnHJxdomYMPtlFHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=POAL+C5q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468N8MIs000983;
	Tue, 9 Jul 2024 05:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2sqKfWeLb//E5e1NbZQTLB
	18yv0j8fhAfiIGY6pQEjs=; b=POAL+C5qEefx4HqzuOt03R+kbEQSbq1XvSbRX3
	nVMVL+qUqv6eZGAXy5C1JfmGFxdiuJ8wX5CBC0CWCXVueDKbuyx0f3D9qa4+y0Y1
	BrRf1D7mQ7iGofGTW2UQh85+eWbXwJazaY7C0gpK38J/3EzwwEZx6gkHg6YD0K05
	6pS9o2/ya7CsQWvpookTXQ/ezRWPAskVgxOigRNO7KSVYnkKHqRBq92lGYK8C8yh
	y17YdB/R3sDBotL4GlHExNMC81oQRmAD2uWHTjd5U4FKTgyNjQ6QVwOO7b46mYMb
	cA+gVm31sC6YlsK4dcpvU6ozihw9kfjhDAwwWsEp8Zf2HxkQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406x0t5n9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 05:58:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4695wYB8009291
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 05:58:34 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 8 Jul 2024 22:58:32 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH] wifi: ath12k: restore ASPM for supported hardwares only
Date: Tue, 9 Jul 2024 11:28:17 +0530
Message-ID: <20240709055817.3371406-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cxWUjw7GihkvnaZ3SejBq5LCiKSa5VzG
X-Proofpoint-ORIG-GUID: cxWUjw7GihkvnaZ3SejBq5LCiKSa5VzG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=877 priorityscore=1501 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090038

During PCI based hardware device start up, ASPM is disabled for all. And
once firmware is ready, it is restored back. However, not all hardwares
(for example QCN9274) supports ASPM. Hence there is a need to conditionally
restore ASPM back. Or else, for such hardwares, issue can be seen during
sending and receiving packets.

Introduce a new hardware param supports_aspm which identifies whether a
given hardware supports ASPM or not and then accordingly restore it.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c  | 6 ++++++
 drivers/net/wireless/ath/ath12k/hw.h  | 1 +
 drivers/net/wireless/ath/ath12k/pci.c | 3 ++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 2e11ea763574..76c0e07a88de 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -924,6 +924,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.acpi_guid = NULL,
 		.supports_dynamic_smps_6ghz = true,
+
+		.supports_aspm = false,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -1000,6 +1002,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.acpi_guid = &wcn7850_uuid,
 		.supports_dynamic_smps_6ghz = false,
+
+		.supports_aspm = true,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1072,6 +1076,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.acpi_guid = NULL,
 		.supports_dynamic_smps_6ghz = true,
+
+		.supports_aspm = false,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index e792eb6b249b..4cfbb240bbf4 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -187,6 +187,7 @@ struct ath12k_hw_params {
 	bool tcl_ring_retry:1;
 	bool reoq_lut_support:1;
 	bool supports_shadow_regs:1;
+	bool supports_aspm:1;
 
 	u32 num_tcl_banks;
 	u32 max_tx_ring;
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 876c029f58f6..ff2199f7754c 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -953,7 +953,8 @@ static void ath12k_pci_update_qrtr_node_id(struct ath12k_base *ab)
 
 static void ath12k_pci_aspm_restore(struct ath12k_pci *ab_pci)
 {
-	if (test_and_clear_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags))
+	if (ab_pci->ab->hw_params->supports_aspm &&
+	    test_and_clear_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags))
 		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
 						   PCI_EXP_LNKCTL_ASPMC,
 						   ab_pci->link_ctl &

base-commit: 9fddbf081f2da3a20fecda0b58adacbf1379e304
-- 
2.34.1



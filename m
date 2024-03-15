Return-Path: <linux-wireless+bounces-4784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C74987C74C
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Mar 2024 02:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09DB282C61
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Mar 2024 01:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0F44C8F;
	Fri, 15 Mar 2024 01:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TE06+Pid"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53494C8D
	for <linux-wireless@vger.kernel.org>; Fri, 15 Mar 2024 01:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710467060; cv=none; b=dMalP1/H9/AYo8Poap+RnFCneSHu6t+Y7mOzdHu01pw/TfbwgDH+DH14zWZ1HUWqnxjHn+6QWWqxFD1kQBRshPEF/0Wh7Qw/07JSZ7AKWciO6AkJLcp10RMcTAgHCQYq9TaiwMNTVAEKpTMOtCyNQCJvdRruzeSO4CnmBn03ouo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710467060; c=relaxed/simple;
	bh=9XKMlrIspoL/raBToNSPMIiwY134egt6M/bJXHioSr0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mGsoEhScnALWmQLH/XtqNNYxHQGu1mR4WyMpR4+nlQQyLBfcR4UB8RDMY2b/PgIOZu70H0Qc9YaqB8V4o2mA4bPdpISmrba0AQGYRJH13l5RD+49exY9W+O4B/cuPAHcp1nSgSJjcBTCeJnX+NkFxIg/YsGr2b8Iz+Wq6m0apM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TE06+Pid; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42F0rj8n007011;
	Fri, 15 Mar 2024 01:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=RTbjxZI
	OMviRH3aUzis16GaSM/Y+0ZKj9CvJ6VLKnZs=; b=TE06+Pid3fXdXgUndikRCvE
	lZcx96JtqUGIDt5ROL3RAQKCicGB+3r1DfdZTTJwJmhKB4QywoM5MRTKNlpr/yYk
	5EwegHTDK/24u56ZpuPmg8/Y/QmI8PtvDwBFH/uvjcHVPeqdPSLrflf4SIrgKtYm
	Sdm7AdNaw5fjLQ5XWOtSi3ep3sjkmPrpiGJ8cPwIaDgUUJNEy+irT8eI/iV0rdMc
	+c4Fs1BVYZsWAZeSP+sG7xIaQpaq8RudAxGYCj6jGo6vRYmknCxuXskOhNKhcjOT
	e9J/KYKbrQy2xlY5MhswzAgHGxg+vzXJ2yyGIC06DUQ3YpBveHZjeWc0bP6a0Ig=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wva0609d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 01:44:08 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42F1i74U028555
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 01:44:07 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Mar 2024 18:44:05 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
Subject: [PATCH] wifi: ath11k: fix memory leak in ath11k_xxx_remove()
Date: Fri, 15 Mar 2024 09:43:07 +0800
Message-ID: <20240315014307.3132980-1-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 22b0kfWFUIDFYEBMIersIueYpjbfAZNA
X-Proofpoint-ORIG-GUID: 22b0kfWFUIDFYEBMIersIueYpjbfAZNA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=834
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403150010

The firmware memory was allocated in ath11k_pci_probe() or
ath11k_ahb_probe(), but not freed in ath11k_xxx_remove() in case
ATH11K_FLAG_QMI_FAIL bit is set. So call ath11k_fw_destroy() to
free the memory.

Found while fixing the same problem in ath12k:
https://lore.kernel.org/linux-wireless/20240314012746.2729101-1-quic_miaoqing@quicinc.com

No functional changes, compile tested only.

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 1 +
 drivers/net/wireless/ath/ath11k/fw.c  | 1 +
 drivers/net/wireless/ath/ath11k/pci.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 7c0a23517949..6bc4e55c6c2b 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1259,6 +1259,7 @@ static void ath11k_ahb_remove(struct platform_device *pdev)
 		ath11k_ahb_power_down(ab);
 		ath11k_debugfs_soc_destroy(ab);
 		ath11k_qmi_deinit_service(ab);
+		ath11k_fw_destroy(ab);
 		goto qmi_fail;
 	}
 
diff --git a/drivers/net/wireless/ath/ath11k/fw.c b/drivers/net/wireless/ath/ath11k/fw.c
index 4e36292a79db..22327d5f9680 100644
--- a/drivers/net/wireless/ath/ath11k/fw.c
+++ b/drivers/net/wireless/ath/ath11k/fw.c
@@ -166,3 +166,4 @@ void ath11k_fw_destroy(struct ath11k_base *ab)
 {
 	release_firmware(ab->fw.fw);
 }
+EXPORT_SYMBOL(ath11k_fw_destroy);
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index be9d2c69cc41..6099d02d5f65 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -973,6 +973,7 @@ static void ath11k_pci_remove(struct pci_dev *pdev)
 		ath11k_pci_power_down(ab);
 		ath11k_debugfs_soc_destroy(ab);
 		ath11k_qmi_deinit_service(ab);
+		ath11k_fw_destroy(ab);
 		goto qmi_fail;
 	}
 
-- 
2.25.1



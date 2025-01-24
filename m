Return-Path: <linux-wireless+bounces-17898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63264A1B23E
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 10:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9421885545
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 09:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EE7191F8E;
	Fri, 24 Jan 2025 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dQgDThI4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A83219A98
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709290; cv=none; b=kM7AkpbrvC81K4ozDG/0/GQYZTsoJNBKqIXe/XOZziGU2P29/ivs3WXmPiy1bt32xOJzUwW0FPs7/As9pAaOgd5Ju1bBMuVYlp+n+waqhm9zHDcSzRTVgKZNN9rdERPnJ2KVjelgvvvuphi3lflleJC8Hf21Eh1CVYWiJkbae6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709290; c=relaxed/simple;
	bh=IMgL6Bs0dbjFp5dMkC9JC6PzA/hUzs3gstoZJ1kEdTk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TLOmAlBM85GOuRSmeIVUrWhzuHDrcYSs61LxA8Q3JYjs1NaKam097VPUWrCsqvehmtmzEvHd2BAO4hNE6J9ASneBB7+4UDlflM5neDDnD4xqbYxG3eiH4yYhNlUBBvEfpd5D3HfSGNul3Vhg2m8uIWVEX6vzjtvba61fOoJVSqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dQgDThI4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O5TYLR027165;
	Fri, 24 Jan 2025 09:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RHZCJxnvFexyyottsp2BNe
	q6E9JY4sjlIRl41pyx9eI=; b=dQgDThI4wpA8i9+/Kil2/GlvVSi3tTE3fuTK9c
	k5b0xpW+rfB8OEEK5dwILhx/M2fGNrXd8htagfJfJ3yCMB4XAMtlbioKZqmgwe2l
	9ZpFEyG2vPCvZ9zeOIZN7G6Ek25KszdWTWjsw094To0emxhhmQT25Io5GcukVqiC
	ZolWWSDBTJlmwfi74lGBgdl/mK7pbsw9Yex+Ty+xCDDdBVSwA1cX2QUk20LNOxUL
	+6QNt+dv/7ZpztDA9guwnRVahD2K2C9bJELU9yufUQ+Ofjdn9hRhMijCdFgO7Llj
	hr7ZfeP/mgkMB43LmriGemiCWxMm03UnTQdjrrtne1DUga1Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c4rngfv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 09:01:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50O91A9A023713
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 09:01:10 GMT
Received: from hu-tamizhr-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 24 Jan 2025 01:01:08 -0800
From: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Avula Sri Charan
	<quic_asrichar@quicinc.com>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Subject: [PATCHv2] wifi: ath12k: Avoid napi_sync before napi_enable
Date: Fri, 24 Jan 2025 14:30:58 +0530
Message-ID: <20250124090058.3194299-1-quic_tamizhr@quicinc.com>
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
X-Proofpoint-GUID: grQxDM6-AYPDKvwp15qskzAa8sIWR3Nc
X-Proofpoint-ORIG-GUID: grQxDM6-AYPDKvwp15qskzAa8sIWR3Nc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_03,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240065

From: Avula Sri Charan <quic_asrichar@quicinc.com>

In case of MHI error a reset work will be queued
which will try napi_disable after napi_synchronize.

As the napi will be only enabled after qmi_firmware_ready
event trying napi_synchronize before napi_enable will
result in indefinite sleep in case of a firmware crash
in QMI init sequence.

To avoid this introduce napi_enabled flag to check
if napi is enabled or not before calling napi_synchronize.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Avula Sri Charan <quic_asrichar@quicinc.com>
Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
---
v2:
  * Removed prerequisite-patch-id tag which added wrongly

 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/pci.c  | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 86a1eeec64a6..b5adbb21315a 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -166,6 +166,7 @@ struct ath12k_ext_irq_grp {
 	u32 num_irq;
 	u32 grp_id;
 	u64 timestamp;
+	bool napi_enabled;
 	struct napi_struct napi;
 	struct net_device *napi_ndev;
 };
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 4a50d7118b3e..24c5ef96baf6 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -483,8 +483,11 @@ static void __ath12k_pci_ext_irq_disable(struct ath12k_base *ab)
 
 		ath12k_pci_ext_grp_disable(irq_grp);
 
-		napi_synchronize(&irq_grp->napi);
-		napi_disable(&irq_grp->napi);
+		if (irq_grp->napi_enabled) {
+			napi_synchronize(&irq_grp->napi);
+			napi_disable(&irq_grp->napi);
+			irq_grp->napi_enabled = false;
+		}
 	}
 }
 
@@ -1114,7 +1117,11 @@ void ath12k_pci_ext_irq_enable(struct ath12k_base *ab)
 	for (i = 0; i < ATH12K_EXT_IRQ_GRP_NUM_MAX; i++) {
 		struct ath12k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
 
-		napi_enable(&irq_grp->napi);
+		if (!irq_grp->napi_enabled) {
+			napi_enable(&irq_grp->napi);
+			irq_grp->napi_enabled = true;
+		}
+
 		ath12k_pci_ext_grp_enable(irq_grp);
 	}
 

base-commit: 376673aa393c1c232299be3e910d7f2e6d974b2f
-- 
2.34.1



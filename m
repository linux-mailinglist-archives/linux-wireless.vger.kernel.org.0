Return-Path: <linux-wireless+bounces-17252-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FE4A07FD9
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 19:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4495B7A2EEC
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 18:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CDC199239;
	Thu,  9 Jan 2025 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e46/evcz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EB713B2B8
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 18:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447783; cv=none; b=a1ypH3C/9Ou2WylXSsJ1ScI4obD11YkEGbyiWRE8n0iLQBXYh0XFsqnlmM1qN7QJuuJnuLjqq4IU63YEZWoVObPU/UbsjL/a02x57kk8H+mRr/yvFUjC1VPkZyUHG1QGicO8Sn9sYejLcHkawDKFzpw8k+vK47055R5FAe8QN+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447783; c=relaxed/simple;
	bh=B3STwXVnmbGnEWgYz0J/reBRIM+ktzksrSsHMQZS9PU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMCcbBrh2dpGxwS1xcnjW8QKrTtDmMOx/38SDH5gOFxdlDP92DJsFQTbE3Xqk15mUAamXXcuAePEGEA/B9MsA0NQWcz8DIt+xJsFCsLJQ0T8WqpKNC+A2wdGQlRkSJfjhhzuDJkM3Ugpxz/VxlbwMHWAW0KgP2tr5Z/+tkt1LaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e46/evcz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509B3xLR025136;
	Thu, 9 Jan 2025 18:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dXAAJ3Q2KJefI38pytyD5c5fjyRALuNb86ZzFcAHctc=; b=e46/evcz8HmeE7uU
	gAR1Jr6UMmrRrUIDi4VDOBdC4xG5ylOC/lAmVMRTjxc2nBV9S9/tThBLjwtk2srQ
	UpoJUtp+2owjTHL3xkcJFesbN2/FCCGmvPXnj9f+B3D7D8MYcIQr7kpP/WXlZPVV
	GJXDOZ5sz1Pz+86Omv556PNc+pK4UV+pcGtB0smiCN/mkfRaJKhCoORAefYmzVe0
	RsgYIf1zFaFpTdHp4y1zshLhlvWYAmPO7SSSZiBpSNjwQGzBsTcJgbsDOOInIdE0
	A7w3Cr2+Z1wSyOFurUHFJ4eObmBaOdja24p7E+pPHYFGeDrBxd8BW07vKKZx74qR
	SBAUog==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442d8hh3c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 18:36:18 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 509IaHBX009263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Jan 2025 18:36:17 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 10:36:16 -0800
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
Subject: [PATCH v6 5/5] wifi: ath12k: Disable MLO in Factory Test Mode
Date: Fri, 10 Jan 2025 00:05:51 +0530
Message-ID: <20250109183551.1028791-6-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109183551.1028791-1-quic_aarasahu@quicinc.com>
References: <20250109183551.1028791-1-quic_aarasahu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JNsn-5Mln42PPk4PPafH-95oo4posame
X-Proofpoint-ORIG-GUID: JNsn-5Mln42PPk4PPafH-95oo4posame
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=785
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090147

Factory test mode(FTM) is supported only non-mlo(multi-link operation)
mode. Therefore, disable MLO when driver boots in FTM mode.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 5 ++---
 drivers/net/wireless/ath/ath12k/qmi.c  | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index d0cf82ca6dae..6705e33074aa 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1630,10 +1630,9 @@ static struct ath12k_hw_group *ath12k_core_hw_group_assign(struct ath12k_base *a
 			return NULL;
 		}
 
-		if (ath12k_core_get_wsi_info(ag, ab) ||
+		if (ath12k_ftm_mode || ath12k_core_get_wsi_info(ag, ab) ||
 		    ath12k_core_get_wsi_index(ag, ab)) {
-			ath12k_dbg(ab, ATH12K_DBG_BOOT,
-				   "unable to get wsi info from dt, grouping single device");
+			ath12k_dbg(ab, ATH12K_DBG_BOOT, "grouping single device");
 			ag->id = ATH12K_INVALID_GROUP_ID;
 			ag->num_devices = 1;
 			memset(ag->wsi_node, 0, sizeof(ag->wsi_node));
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 5c3563383fab..344c12b3b937 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/elf.h>
@@ -2265,7 +2265,7 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
 		goto out;
 	}
 
-	if (resp.single_chip_mlo_support_valid &&
+	if (!ath12k_ftm_mode && resp.single_chip_mlo_support_valid &&
 	    resp.single_chip_mlo_support)
 		ab->single_chip_mlo_supp = true;
 
-- 
2.34.1



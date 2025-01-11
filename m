Return-Path: <linux-wireless+bounces-17349-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA634A0A218
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jan 2025 10:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 490357A43DD
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jan 2025 09:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B6C186615;
	Sat, 11 Jan 2025 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nz6fzpX8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABFC10E9
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jan 2025 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736586127; cv=none; b=WoIw24xPqOFaDAsRZnGb7izNf3zKTp+3QCBuFptpYC/f5PXOJfIHiTHtGRRD2Kr1HXRG+E/fS5CQtDTsyOjz+I1h0Z0lUpbQ2EUx/qjViC5nqgn+R37pd3YXOjQX7HsHU42S0eVm0rJ3QiKu5LO+3Ey/iKS5+3eMU5QbwUFXIeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736586127; c=relaxed/simple;
	bh=z/itc+5zmvKFduCl9G7q64fVr3KsvNsMDyIi6khUvZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3a2yMePsxcIwRcCVo0FUSfbFIE+pZOtffN/fa9zzgoDSC6sCu48kqlfH6WlrnwI8fgDfvjBEvVuZDZ29MX8A7YdiQ4DR3KVZOqXVp4GbEPnAoa3VdnvuNKmZpI2Bdz6D3YNo/PCj+sJTomYZzVbeCH08wCta6nXTTPuuWB78cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nz6fzpX8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50B6SHs9006655;
	Sat, 11 Jan 2025 09:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PJ63j6DHvyDLWUNSupcFgeowrcnLFfohcX7dkOPyfTo=; b=nz6fzpX8PZ8hSmQv
	u0+lffREoOkDSHylU7m00bIFKuF5rXsud1dLJQWJOaVLboH7T0GLhv1W8M3LSrRR
	qgxu3TCzwpcUoTUwN6hYyjzC28u1dihd4rtzBINWxVG23PrTKdjbvsETIMYc1jSx
	XmtVQurDsZJncXCA+zi56X9d2MtbbmcN7XoXPdWLsvfTO3OHoG0MykMjNvgmZ4MN
	/vAGdQi5iKjJxqEVJzE5dBByaiIYLH34TNh7WpK9BnynU65O3kf1SYIMfwb6bXit
	f+XhTHyMFaDgOugg9xDfa14pQwDBAi+98Z2XWfVTO0Yh/4Cfp/YLe1JCuNZRaNVu
	TXZ+kw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443hj2ra4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jan 2025 09:02:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50B922bQ026677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jan 2025 09:02:02 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 11 Jan 2025 01:02:00 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: [PATCH v3 4/4] wifi: ath12k: Fix uninitialized variable access in ath12k_mac_allocate() function
Date: Sat, 11 Jan 2025 14:31:29 +0530
Message-ID: <20250111090129.2733338-5-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111090129.2733338-1-quic_periyasa@quicinc.com>
References: <20250111090129.2733338-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: QwT4AcFOCDOpHtXuPJ_OU7XMx7FZtbMr
X-Proofpoint-ORIG-GUID: QwT4AcFOCDOpHtXuPJ_OU7XMx7FZtbMr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501110077

Currently, the uninitialized variable 'ab' is accessed in the
ath12k_mac_allocate() function. Initialize 'ab' with the first radio device
present in the hardware abstraction handle (ah). Additionally, move the
default setting procedure from the pdev mapping iteration to the total
radio calculating iteration for better code readability. Perform the
maximum radio validation check for total_radio to ensure that both num_hw
and radio_per_hw are validated indirectly, as these variables are derived
from total_radio. This also fixes the below Smatch static checker warning.

Smatch warning:
ath12k_mac_allocate() error: uninitialized symbol 'ab'

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Fixes: a343d97f27f5 ("wifi: ath12k: move struct ath12k_hw from per device to group")
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 4b6a236d8ae4..925916ee245e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11383,8 +11383,20 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
 	u8 radio_per_hw;
 
 	total_radio = 0;
-	for (i = 0; i < ag->num_devices; i++)
-		total_radio += ag->ab[i]->num_radios;
+	for (i = 0; i < ag->num_devices; i++) {
+		ab = ag->ab[i];
+		if (!ab)
+			continue;
+
+		ath12k_mac_set_device_defaults(ab);
+		total_radio += ab->num_radios;
+	}
+
+	if (!total_radio)
+		return -EINVAL;
+
+	if (WARN_ON(total_radio > ATH12K_GROUP_MAX_RADIO))
+		return -ENOSPC;
 
 	/* All pdev get combined and register as single wiphy based on
 	 * hardware group which participate in multi-link operation else
@@ -11397,14 +11409,16 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
 
 	num_hw = total_radio / radio_per_hw;
 
-	if (WARN_ON(num_hw >= ATH12K_GROUP_MAX_RADIO))
-		return -ENOSPC;
-
 	ag->num_hw = 0;
 	device_id = 0;
 	mac_id = 0;
 	for (i = 0; i < num_hw; i++) {
 		for (j = 0; j < radio_per_hw; j++) {
+			if (device_id >= ag->num_devices || !ag->ab[device_id]) {
+				ret = -ENOSPC;
+				goto err;
+			}
+
 			ab = ag->ab[device_id];
 			pdev_map[j].ab = ab;
 			pdev_map[j].pdev_idx = mac_id;
@@ -11416,10 +11430,11 @@ int ath12k_mac_allocate(struct ath12k_hw_group *ag)
 			if (mac_id >= ab->num_radios) {
 				mac_id = 0;
 				device_id++;
-				ath12k_mac_set_device_defaults(ab);
 			}
 		}
 
+		ab = pdev_map->ab;
+
 		ah = ath12k_mac_hw_allocate(ag, pdev_map, radio_per_hw);
 		if (!ah) {
 			ath12k_warn(ab, "failed to allocate mac80211 hw device for hw_idx %d\n",
-- 
2.34.1



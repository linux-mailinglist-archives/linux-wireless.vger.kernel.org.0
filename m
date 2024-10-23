Return-Path: <linux-wireless+bounces-14354-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215B29ABE59
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 08:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C704B252EA
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 06:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB23D148FE5;
	Wed, 23 Oct 2024 06:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m8SRo0RX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB6153838;
	Wed, 23 Oct 2024 06:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729663495; cv=none; b=SXVrFKX3LL6gsXWfF3nBEgZF+BgbaW2csYpVhXV0n/Q60+GKYyVvpci80Oh0VmvBAAxUVUIJGGpwE5GEkmfNcguk+lpwu9yJlgG0ry7+I21rQSaeeGn8QL8GrTmch8JH8M86nQj71L7FuEfBFvj+4hRCCGrxrYG7SAcALvNP/eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729663495; c=relaxed/simple;
	bh=ovONsQb0U0AYWnvAHHf4yrbpZbwWrdimmmldGh9DE0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=auf547PfLVN+jjepgw5Id23lErY94Qq/3uYzVh2Z3k4xc7HsjaHDNe5xnkJmcZnjVprJPu73fPCofEQBReSJwcbvhPUWjXRcn3zaef4ofwdSUytT78BdCgKA11UF3KB8U7BXHeZljAzZw6O1CjuBiAqH2NX9NCFor3xakqYYunY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m8SRo0RX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLaD9R027445;
	Wed, 23 Oct 2024 06:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9F5+3SyJi3HXysrmFef3nEPWLR39X3yDiSrjaO+fm7w=; b=m8SRo0RXscw9nYp+
	2AUDwDN50dhjyajM6fzRAT8f/DELgIV9/7Dn4+IEYhtFgXoS5cOS5c0Fe/VB0zQ7
	dR67dyKY0z9AMtBfR6YpUIXnH9szlggcfUf7LDKKxmeBW7XoWlVxEyhQBasKmY1u
	vbTjLGsv6HFJTwFPhLRb0bZ3Xk8h8vKIOvUK4WnKCPFow8GIXyReEusYqnw509Mu
	dWW6y53XMOXgrIFn5/8JFIimKa7k4dcBTE71QEV9DyStZcDBMYDpWbPEDgbDo0rJ
	bjjAcAR4nfGffcRtGXHHUpeBT5gCURzFSAxi1WLHKu6h1qO6lDeS9vjN+/CQI61s
	8i8ecg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em41s0q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:04:48 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49N64eve016789
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:04:40 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 23:04:35 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>
Subject: [RFC PATCH 5/6] wifi: ath12k: assign unique hardware link IDs during QMI host cap
Date: Wed, 23 Oct 2024 11:33:51 +0530
Message-ID: <20241023060352.605019-6-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023060352.605019-1-quic_rajkbhag@quicinc.com>
References: <20241023060352.605019-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rpXHHXZlA3lf6xD1Fl7u6nVa-CP7cpIh
X-Proofpoint-ORIG-GUID: rpXHHXZlA3lf6xD1Fl7u6nVa-CP7cpIh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230035

From: Aditya Kumar Singh <quic_adisi@quicinc.com>

Currently, in the QMI host capability, the device index, the number of
local links, and the corresponding hardware link IDs are sent. The hardware
link ID assignment is based on the local variable hw_link_id, which starts
from 0 and ranges up to num_local_links in the device. Starting from 0 is
not ideal because it can result in the same link ID being assigned to
different devices in certain scenarios (for example split mac). Hence, for
MLO to function seamlessly, the hardware link IDs across devices need to
be unique.

To address this, a previous change already read the device ID from the
Device Tree (DT) and stored it. This device ID will now be used as the
starting index for the hardware link IDs. This ensures that the hardware
link IDs assigned are unique across all devices.

While at it, add debug prints to clearly show the MLO capability
advertisement sent during QMI host capability exchange.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 689171b7b19f..24aa74fa1c85 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2060,6 +2060,12 @@ static int ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 	req->mlo_num_chips_valid = 1;
 	req->mlo_num_chips = ag->num_devices;
 
+	ath12k_dbg(ab, ATH12K_DBG_QMI, "MLO Capability advertisement:");
+	ath12k_dbg(ab, ATH12K_DBG_QMI, " * device_id: %d", req->mlo_chip_id);
+	ath12k_dbg(ab, ATH12K_DBG_QMI, " * group_id: %d", req->mlo_group_id);
+	ath12k_dbg(ab, ATH12K_DBG_QMI, " * num_devices: %d", req->mlo_num_chips);
+	ath12k_dbg(ab, ATH12K_DBG_QMI, " * Devices info:");
+
 	mutex_lock(&ag->mutex_lock);
 	for (i = 0; i < ag->num_devices; i++) {
 		info = &req->mlo_chip_info[i];
@@ -2074,13 +2080,19 @@ static int ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 		info->chip_id = partner_ab->device_id;
 		info->num_local_links = partner_ab->qmi.num_radios;
 
-		ath12k_dbg(ab, ATH12K_DBG_QMI, "MLO device id %d num_link %d\n",
-			   info->chip_id, info->num_local_links);
+		ath12k_dbg(ab, ATH12K_DBG_QMI, "   * device_id: %d",
+			   info->chip_id);
+		ath12k_dbg(ab, ATH12K_DBG_QMI, "     * num_links: %d",
+			   info->num_local_links);
 
 		for (j = 0; j < info->num_local_links; j++) {
-			info->hw_link_id[j] = hw_link_id;
+			info->hw_link_id[j] = partner_ab->wsi_index + j;
 			info->valid_mlo_link_id[j] = 1;
 
+			ath12k_dbg(ab, ATH12K_DBG_QMI,
+				   "       * hw_link_id: %d\n",
+				   info->hw_link_id[j]);
+
 			hw_link_id++;
 		}
 	}
-- 
2.34.1



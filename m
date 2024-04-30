Return-Path: <linux-wireless+bounces-7027-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C779F8B6A09
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 07:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D951F225D9
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 05:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D901798C;
	Tue, 30 Apr 2024 05:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iU07EfEX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD28182A0
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714456111; cv=none; b=rluIDrng7N3W2iZh7qHeSNEfxxVp9VOoPVMOhBGfrgB6l5U41FhSmqOdXdvy/zL0rpvhq/mwIr/EkRq1IULQchBL9cnOJ+L/rsHmD0YrjrEFMf+lc8TCTlHw20PRwW3DnakvnI2Lpwx1NqXYEfAjShfrkm6rKZypC1LDDT2TfjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714456111; c=relaxed/simple;
	bh=0NJet9EJ2l4msDWVbK1+Rz0Oha8tfn1LpcHfAP6/29E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVyuS2Bn50v42ex+3p2keIBSDY/qprXvIH+lGWzlJR1fRV/cPMaeBKdSHgm5mXtSDdq73OhzIFPhq+QimNYuu5u/B0kOLjbgA7w/cJ7gjH+bpblzV1C3dgU3KSEJ+0akDbGc+qxI1CeBgzBlf7tTof8vkAXzo8ZKuSj1bxcPcLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iU07EfEX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U50tTF019456;
	Tue, 30 Apr 2024 05:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=gRx07PeP42Xu6oKZNz8pFA5EA7fQkStcMuP0sznf570=; b=iU
	07EfEXIB3MfWHFSN3U2mvawOi72ms+qW5ul5jUxRVF0qW5QCZ5KaQdLGZyRvrwWr
	yv8FED5ehNGgGne2odI7tSZEFKa7Mi5rZLV0ktyqzYNupMSoKOwZ1AjIfW++fizo
	ciVt8QSvfD4jnZEJJexEALd1Pof7nU1JOVQvvqlWm8xdSdWdOJ3UJ8HDGBPamu7Z
	jRbHRBiT/RH6FEH8ZOaqTy7tLVYv3Rk5u5kFl+dKRW2RK2NocnR6dN1v+W7Xgk7X
	2FG0X4huAgu4jFvYcj59EvqyIunXzJ+bbza5dOjiTRKnQY+QMWnLcDbV8e37TPBZ
	978X/K3LgcbOrmxjKZqA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtaf2mngb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 05:48:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U5mKp8015407
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 05:48:20 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 22:48:18 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 3/4] wifi: ath12k: use device index to advertise MLO parameter
Date: Tue, 30 Apr 2024 11:17:58 +0530
Message-ID: <20240430054759.722620-4-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430054759.722620-1-quic_periyasa@quicinc.com>
References: <20240430054759.722620-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: XqsYjIRN6b1env4eTNqavI2e0RSVC0JG
X-Proofpoint-GUID: XqsYjIRN6b1env4eTNqavI2e0RSVC0JG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_02,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300040

Device index parameter is used as unique identifier for devices involved
in Inter-device MLO. It is also used to configure the MLO parameter within
the QMI host capability send request. While currently set to zero, future
logic will be added for inter device support to populate this parameter
with non-zero values.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 10 ++++++++++
 drivers/net/wireless/ath/ath12k/qmi.c  |  4 ++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index b304895ee295..e82442540697 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1562,6 +1562,16 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	ab->qmi.num_radios = U8_MAX;
 	ab->mlo_capable_flags = ATH12K_INTRA_DEVICE_MLO_SUPPORT;
 
+	/* Device index used to identify the devices in a group.
+	 *
+	 * In Intra-device MLO, only one device present in a group,
+	 * so it is always zero.
+	 *
+	 * In Inter-device MLO, Multiple device present in a group,
+	 * expect non-zero value.
+	 */
+	ab->device_id = 0;
+
 	return ab;
 
 err_free_wq:
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index b37ab6244931..a9946f0f6bd8 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2041,7 +2041,7 @@ static void ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 	req->mlo_capable_valid = 1;
 	req->mlo_capable = 1;
 	req->mlo_chip_id_valid = 1;
-	req->mlo_chip_id = 0;
+	req->mlo_chip_id = ab->device_id;
 	req->mlo_group_id_valid = 1;
 	req->mlo_group_id = 0;
 	req->max_mlo_peer_valid = 1;
@@ -2053,7 +2053,7 @@ static void ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 	req->mlo_num_chips = 1;
 
 	info = &req->mlo_chip_info[0];
-	info->chip_id = 0;
+	info->chip_id = ab->device_id;
 	info->num_local_links = ab->qmi.num_radios;
 
 	for (i = 0; i < info->num_local_links; i++) {
-- 
2.34.1



Return-Path: <linux-wireless+bounces-21054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C41AA7869B
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 04:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9AC33AFD66
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 02:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2F119CC31;
	Wed,  2 Apr 2025 02:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nfSjE7/I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F1D192D97;
	Wed,  2 Apr 2025 02:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743562010; cv=none; b=euRpzpaDgV0hPpqt3cPPoy1FxToeOiTQRHfOIB3zYfiZ0ft6215NE0IZhAZ/9PHMeAbQM/vShomweXRt8b+AorU3V4dOxnv0sZVe+nI4KCRFg5q+szjsW7/DmxMBRgPYg3YCliGJoLYv+fEKTkhgLgGXrDIqZwIXKkJNz9cPQiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743562010; c=relaxed/simple;
	bh=afUkO3bRuziRKNeaUK+p2eorXBer39U2giTBbsni1Zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SMEYOD9bXGmw4Aa/qoB2KOojBUYYEN3rjYfEwQKxWRx3NivYYFp771Na9S1Lf9HnQ+NGsM4aZfgqSrvyFi+HDIgVf7Ev4XWhO5OBymThYuwC9qkNb7VMT3PMzaiL+a/nuxyaH1ARiV8Cz/CTqmZ/Y7AYot/5X8rHdVF3jmSr8Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nfSjE7/I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531Fh7K2008564;
	Wed, 2 Apr 2025 02:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	auf2rTWz9nF4b1B9ipcZv2SB/TXc1xaaoz/erFdslY0=; b=nfSjE7/IANrqxPEU
	Gs6mUIvtZ2zIVS/jVG0LlKrZRl9YvSB3aa5Mvd8ifnoW+qYkz4RcfN+iLuT8nfOA
	TIPU2pc3cT1mE5EbASfIEoZkLz50ngDt8wKHzbcQNVlBGkN0jZwWDYjwEYoJgzlR
	q4cTsKHDDlt5GZj/ldo9HRihgIMgWjrk9FK7Bikuo7JjozR5CI/7jLg2+3YmWmKS
	Td/NBp0XsJyjLoDueLawTTNe2snkAgBCvUUv7YnJjf7Z5FmFgcw35PUliq+Vrd+0
	sCoShNFoUDem/fkrTib7IaUv7OIU3F5XH8GmommiiFGdZxoe6PA4vb0pA3L9kP7h
	whR0/Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45r1xnmbdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 02:46:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5322kSGN012731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Apr 2025 02:46:28 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Apr 2025
 19:46:26 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Wed, 2 Apr 2025 10:45:47 +0800
Subject: [PATCH ath-next 8/9] wifi: ath12k: don't skip non-primary links
 for WCN7850
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250402-ath12k-wcn7850-mlo-support-v1-8-bad47cf00704@quicinc.com>
References: <20250402-ath12k-wcn7850-mlo-support-v1-0-bad47cf00704@quicinc.com>
In-Reply-To: <20250402-ath12k-wcn7850-mlo-support-v1-0-bad47cf00704@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B4ehtDyozZv2I4dHiniU_7bgffjtoZ_Y
X-Proofpoint-ORIG-GUID: B4ehtDyozZv2I4dHiniU_7bgffjtoZ_Y
X-Authority-Analysis: v=2.4 cv=Qv1e3Uyd c=1 sm=1 tr=0 ts=67eca505 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=JV4BEDbtibSLdtTV1wAA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_01,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=975 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020017

The primary link check bypasses REO queue setup for non-primary links
in ath12k_dp_rx_peer_tid_setup(), this works for QCN9274 but breaks
WCN7850 as WCN7850 needs it to be done for each link peer.

Add a new hardware parameter to differentiate them.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 3 ++-
 drivers/net/wireless/ath/ath12k/hw.c    | 8 ++++++++
 drivers/net/wireless/ath/ath12k/hw.h    | 3 +++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 6bad4e4440f74d5f9a143ef6ef79a8df5c3cdfab..f949cc8cf7543ad195f6d2b5e342d1f1c17c1745 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1006,7 +1006,8 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 		return -ENOENT;
 	}
 
-	if (!peer->primary_link) {
+	if (ab->hw_params->dp_primary_link_only &&
+	    !peer->primary_link) {
 		spin_unlock_bh(&ab->base_lock);
 		return 0;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 0ba6aedc8405364f7311871b2f32c2fb35c469ad..73d471bc6efd682d0043c8dcabb6a92de7fa69e6 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1323,6 +1323,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.ce_ie_addr = NULL,
 		.ce_remap = NULL,
 		.bdf_addr_offset = 0,
+
+		.dp_primary_link_only = true,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -1408,6 +1410,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.ce_ie_addr = NULL,
 		.ce_remap = NULL,
 		.bdf_addr_offset = 0,
+
+		.dp_primary_link_only = false,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1489,6 +1493,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.ce_ie_addr = NULL,
 		.ce_remap = NULL,
 		.bdf_addr_offset = 0,
+
+		.dp_primary_link_only = true,
 	},
 	{
 		.name = "ipq5332 hw1.0",
@@ -1565,6 +1571,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.ce_ie_addr = &ath12k_ce_ie_addr_ipq5332,
 		.ce_remap = &ath12k_ce_remap_ipq5332,
 		.bdf_addr_offset = 0xC00000,
+
+		.dp_primary_link_only = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index d4a2e47169d97436a2c7ca88e0204085258df61e..a00d032a4cde16475d2b2e1e1cc500d8dc313fb0 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -232,6 +232,9 @@ struct ath12k_hw_params {
 	const struct ce_ie_addr *ce_ie_addr;
 	const struct ce_remap *ce_remap;
 	u32 bdf_addr_offset;
+
+	/* setup REO queue, frag etc only for primary link peer */
+	bool dp_primary_link_only:1;
 };
 
 struct ath12k_hw_ops {

-- 
2.25.1



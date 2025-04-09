Return-Path: <linux-wireless+bounces-21296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FAEA81AFA
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 04:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF547B4909
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 02:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622BF1DA0E0;
	Wed,  9 Apr 2025 02:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O7soVSfX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E57C1D89F0;
	Wed,  9 Apr 2025 02:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744165659; cv=none; b=ALrNwXcwI6EBUYPsJGvjvUTrLfccn0gAWscfPL9r+6IyVWnL5v3DLlH2HGLBvMDupOsTWnziBGaQg/enwDPs+d8lsw+DnlsOK2/UOV4di5OFHxL0I8L0lbmR2AHBAOASEn+FWMAXk0MLdSlVCOgEHOIk+c8RHk92b1tnIbpeoD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744165659; c=relaxed/simple;
	bh=DGnEGe32TCyh8gYH5fIPDgEimumoDQJ04qVI7zfhMqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QFxlmgu+xqWCjumaMliTPciK/PB3oiPhlA1D12XnlTB3AM0tHfn/4aNs9/ykpjTnyuTXwxyqqsYWkVbmUbWTdGuz+KoIt0OYD00ET+Poyzq4Cy0UpxhpYij/g7D8tataBPg4DX1jjTHr68bLLJmsr9BBa6+0BfTlF2liq7RBlC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O7soVSfX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538JYqcM027492;
	Wed, 9 Apr 2025 02:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rRcEA5uvBayQrPlkqfpTlU7OuUp6qX2a4CqKAjKfYWs=; b=O7soVSfXhNFqGtJX
	lg6LqL+CHSfpp/xn8aj26WCZaj4/SuAVirFrp2/tCOcS90DPIoqeyucjOFtPR92L
	g3FZbBSkgyw+hH0uqx+Y6zM8HUzlzjaVduLKO6OZlQyAmprUKhTlma1D9O6Ro8fH
	TifmD/2/NIG7NZjRSLFRzJYX8NCRYHKj0SHPAOLMaT8cft63c12C06bZgjD/Nhb6
	i+nHFSy79Fofbt559a0p0XdbEUMgSSvFZ02EovwvKhitE9Ko5KviWjN3Ra8CAZbh
	yEKHu+A+hubVknyitOT3LA8NzX76ZIJ/nGxzgY1z2N1lgWFRHZURMWWkZY12+qv4
	scuQkw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcrhuwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 02:27:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5392RRS3024597
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Apr 2025 02:27:27 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Apr 2025
 19:27:25 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Wed, 9 Apr 2025 10:26:41 +0800
Subject: [PATCH ath-next v2 8/9] wifi: ath12k: don't skip non-primary links
 for WCN7850
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250409-ath12k-wcn7850-mlo-support-v2-8-3801132ca2c3@quicinc.com>
References: <20250409-ath12k-wcn7850-mlo-support-v2-0-3801132ca2c3@quicinc.com>
In-Reply-To: <20250409-ath12k-wcn7850-mlo-support-v2-0-3801132ca2c3@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8ubE4lMxrcxy4IgQX1BBfQdVJYwgsxi5
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f5db10 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=JV4BEDbtibSLdtTV1wAA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 8ubE4lMxrcxy4IgQX1BBfQdVJYwgsxi5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090002

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
index 3b4dac515b6a02c12656565e1acac636616bdbf6..271d6edad49a0f1902601e031d6ffb3aa7658830 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1001,7 +1001,8 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 		return -ENOENT;
 	}
 
-	if (!peer->primary_link) {
+	if (ab->hw_params->dp_primary_link_only &&
+	    !peer->primary_link) {
 		spin_unlock_bh(&ab->base_lock);
 		return 0;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index e3249719ca5300bab7e6821ae01c42444fd93504..a46d82857c5d3e111c5db4ff95eba2fa67cd1b41 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1327,6 +1327,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.bdf_addr_offset = 0,
 
 		.current_cc_support = false,
+
+		.dp_primary_link_only = true,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -1414,6 +1416,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.bdf_addr_offset = 0,
 
 		.current_cc_support = true,
+
+		.dp_primary_link_only = false,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1497,6 +1501,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.bdf_addr_offset = 0,
 
 		.current_cc_support = false,
+
+		.dp_primary_link_only = true,
 	},
 	{
 		.name = "ipq5332 hw1.0",
@@ -1573,6 +1579,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.ce_ie_addr = &ath12k_ce_ie_addr_ipq5332,
 		.ce_remap = &ath12k_ce_remap_ipq5332,
 		.bdf_addr_offset = 0xC00000,
+
+		.dp_primary_link_only = true,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index d0218d3eea54f5fdd88ab2a3a689171a00f9d7b2..024cfcd2cc158d6f4c26d369a97b1e2382ec6360 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -233,6 +233,9 @@ struct ath12k_hw_params {
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



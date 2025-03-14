Return-Path: <linux-wireless+bounces-20391-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73350A6141D
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 15:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECDD17CB4F
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 14:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C55C201271;
	Fri, 14 Mar 2025 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PqYMjiBu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB8E1FF7BB
	for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963876; cv=none; b=uj80RslVYVy22sBMFCfjPJEx9Uqd9BTlXRCk/HrsZiMqvmek90kTBovZzC/Y3ZTXFOifrdu6gxuSDeRVbtfyj1M8hfVjKk3tuViZAmT4Bju6PRssliE79D4FvTWDIo9B2hhdmTzckat92qcR1qFk5sOAS5r6TEQrjBl31VW16vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963876; c=relaxed/simple;
	bh=orQ3XfNr6Z9vNDMFOApQSPiAh4O3HXbFP60c1lTSiw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsKjz/W6dsNzeG+gxu1h1dSyTWHk8LA4GCEd8guB01rDZ5i7PWQd/M/o49wmwHeCLeYwj9mx78X96fojvWXzFB1YLVeq3T5jMP1Wc0kS3n9I6mXaKZRjxgpdrmwRxamMqdO/yyEsYguM+YDmQaJ7oK5MKb56aPYCjibP1Enh/Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PqYMjiBu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52E9Y7a6027558;
	Fri, 14 Mar 2025 14:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f8nVUMrNDHW33iOJwYoY1ObVSkQMh1Ba3jL8eUSV4KM=; b=PqYMjiBuTAU0FtfR
	nQVms+SHDq5nVu8kdBTuqOjudqqYZxWSDGQfYlxr6m1RFNKYeTZ6i6xzkRBWKm4b
	lD69MlaQxwd2lLI5JpX8+hYenE8ZAi75gzigwMiCwxftyAYOPPqKH3MKDpnEzcL3
	9IQ/Ls/8FlbpN/5kqjBGTgWbPVoRbO0gfNVrRSqRIgCUV5FQSNIPLdxWcEFd75YB
	k1GyMe/jpskb4S+TNNcFNNdzqmppyL43LFiIxt1cTQu6Zr5j9eZqMvBWidyeeI1r
	bxS46zGT7mJb5ZZFEnaPw6sElPh/7/pSwjDNsGY9xsEwIoBAlM2vVPGRfRwtrnum
	SZVDUg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45c6732h1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 14:51:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52EEpCnN015093
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 14:51:12 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 14 Mar 2025 07:51:10 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Vasanthakumar Thiagarajan
	<vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: [PATCH v10 7/9] wifi: ath12k: fix NULL access in assign channel context handler
Date: Fri, 14 Mar 2025 20:20:35 +0530
Message-ID: <20250314145037.3678649-8-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314145037.3678649-1-quic_periyasa@quicinc.com>
References: <20250314145037.3678649-1-quic_periyasa@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=a5Iw9VSF c=1 sm=1 tr=0 ts=67d44260 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=On6beQQLwNlP3L0m5AoA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: cVc5b2satOf9e7Fb1U62z3TDAcoV1ddE
X-Proofpoint-ORIG-GUID: cVc5b2satOf9e7Fb1U62z3TDAcoV1ddE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_05,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=902
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140117

Currently, when ath12k_mac_assign_vif_to_vdev() fails, the radio handle
(ar) gets accessed from the link VIF handle (arvif) for debug logging, This
is incorrect. In the fail scenario, radio handle is NULL. Fix the NULL
access, avoid radio handle access by moving to the hardware debug logging
helper function (ath12k_hw_warn).

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 90570ba4610b ("wifi: ath12k: do not return invalid link id for scan link")
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 9c72cc472901..acc775960adf 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9462,8 +9462,8 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	ar = ath12k_mac_assign_vif_to_vdev(hw, arvif, ctx);
 	if (!ar) {
-		ath12k_warn(arvif->ar->ab, "failed to assign chanctx for vif %pM link id %u link vif is already started",
-			    vif->addr, link_id);
+		ath12k_hw_warn(ah, "failed to assign chanctx for vif %pM link id %u link vif is already started",
+			       vif->addr, link_id);
 		return -EINVAL;
 	}
 
-- 
2.34.1



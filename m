Return-Path: <linux-wireless+bounces-23404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEEAAC3848
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 05:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C748C3B3DCE
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 03:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3AA335BA;
	Mon, 26 May 2025 03:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DbYNA2K6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42CF126C03
	for <linux-wireless@vger.kernel.org>; Mon, 26 May 2025 03:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748231266; cv=none; b=dWuC7YejH7PjttIe1ZdB/On0TStIQ/F3Gl1zi7jE7/Lc52cpvm8GUuTwopvK8HDX3aIX6jNZVbgwDVz19aAGqot1J/rNzpvz3PfCLvdE8Xb9G8Ia4jlf834ceUYPOtqqhJW5Oc/n0AbiYUhFW4xt6EI2MTo9E0K3DNq0f9qJ5tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748231266; c=relaxed/simple;
	bh=8hYIwfY/+9BiW1uTi6sNIMPzNP9VE/Ucj3RutVg1zYA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SXrroJOyAZWkffpajcuhZKxZYxEVa41RfQTva6S2kD8OsehWHEODs4y+PZ+kh2VXzhgjc96NZ75HJCMG/bCuWp5OVbGs6PdN38Dc8CqMur3LpJo1yRvQtel5L6VHI//a17O9m1pPyrrrkEF0IwcJ9+RaLHUvRvAQDjOXcvAc9ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DbYNA2K6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54PNo5Bc007771;
	Mon, 26 May 2025 03:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cKRV5GKyuP23Y3M9k0BT2s
	vzLUAessr9qg1Tki7V058=; b=DbYNA2K6351IrXC8Mt7KDWNbOvCfaGKtZ920Uq
	JLwMxC6S0rB15+Wc+6dFYf+cVhlDBjnRBWrzDDtCSDtxQMe2H7RO9RmXkbpCfRaB
	hQbQI6VCBWVhzOV4jt3fKR0BtNzEVSwb8amv5IqJqPS+oY/FtBBDTRaY/o+6Madk
	lbmVsbkaiQd5O4ndV/ZKzuoOcSFNPssV/YmVuX5G32qBIbpWmPQ/3FqOERiQ6X3P
	3VD9D4bImkBsE/vB5pHUEj/uISC2d0Lepeq+DPQPdzadoW9avATeSw9YsxtgwWdi
	yMwlPtrRawe5wvmHG9YwGBmNW3wWyBEJOQkAcByo0BL5anqA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u6b5jvje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 May 2025 03:47:39 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54Q3ldRx016814
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 May 2025 03:47:39 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 25 May 2025 20:47:37 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel
	<quic_kathirve@quicinc.com>,
        Sarika Sharma <quic_sarishar@quicinc.com>
Subject: [PATCH ath-next] wifi: ath12k: Decrement TID on RX peer frag setup error handling
Date: Mon, 26 May 2025 09:17:13 +0530
Message-ID: <20250526034713.712592-1-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=ZcodNtVA c=1 sm=1 tr=0 ts=6833e45b cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=C3E12wa_uFYmd_9f3VUA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDAyOCBTYWx0ZWRfXyeyqLkUYgsKc
 ufE+dTar19ok2HfyMLf5zvahcponN8GMkFp3tX9TyVnOIRxxpq05BI0z7m26p79vyooHWxBglCH
 LWtbbC306UIKKo1BiC5Jg0UE2ghC3qr2PzF2hxXenbhx/S0vPmV2PAoZWsaXRlHa4BzSablvFEV
 z4fYnRAMO2TkLr1QhbeCmnA49MLk4ir1YxJF5UHd1MABF8GT9kWpYknXQ1tYRmN+lb4lgXU4oBy
 9rZQEnreHcEVLBjjkdi5Ae2+Ss0wxLHwax/c1udcgFdroXj9ICowbzjggPnHXkk3cU1utcgK9a6
 dnKIBeshsim0HqEJnLS5QMCmdIrr1Sz0l+isYYWc16S/mFhQQS8mB0GKLzQH/ybiCcO8OkyrvcG
 R4nRs6vdf0079bOWmMxhCc4774Fa4eOcqoOesGj85ffyEVrBbWNNuuegYQu9LtFk0HtfxZ8K
X-Proofpoint-GUID: V23L18Z-8ub8mD2g8DhyQZyfb0OvQqEF
X-Proofpoint-ORIG-GUID: V23L18Z-8ub8mD2g8DhyQZyfb0OvQqEF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 mlxlogscore=662 bulkscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505260028

From: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>

Currently, TID is not decremented before peer cleanup, during error
handling path of ath12k_dp_rx_peer_frag_setup(). This could lead to
out-of-bounds access in peer->rx_tid[].

Hence, add a decrement operation for TID, before peer cleanup to
ensures proper cleanup and prevents out-of-bounds access issues when
the RX peer frag setup fails.

Found during code review. Compile tested only.

Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 6317c6d4c043..c6b10acb643e 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -84,6 +84,7 @@ int ath12k_dp_peer_setup(struct ath12k *ar, int vdev_id, const u8 *addr)
 	ret = ath12k_dp_rx_peer_frag_setup(ar, addr, vdev_id);
 	if (ret) {
 		ath12k_warn(ab, "failed to setup rx defrag context\n");
+		tid--;
 		goto peer_clean;
 	}
 

base-commit: 3d933084a072fd5fb5da54c06a017abc0412c86f
-- 
2.34.1



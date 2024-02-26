Return-Path: <linux-wireless+bounces-4014-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9EA867BB5
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 17:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55272282046
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 16:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5113912C800;
	Mon, 26 Feb 2024 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EKjwAo3A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FCD12C55E
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964614; cv=none; b=dGb2Hv9FhZakyFPgBj4AybaZ49n8QZrCmi46CbMgtiW2lsbbvZ+gPBv5lPp8WAJWlKUu0a0TZMMMVee02U5zemL8XiAzBdwMAsTVcMaAMcyzEPACJc6LX/glOjpujpXBlVFSzO9vX6+yG+ony8H7H3Ym0KLnUSQeUa1xab300BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964614; c=relaxed/simple;
	bh=Wx00fq4IIrfxg+VrGpLrWjBy3jRIqFOSjP3wCqu+KEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfAfs5nw2nLj5FtxFksNjYiLQeKvXDzf5a1EEZDIsKyYdL+ZXc5h0zMcOVbkafREB/NTGmZGYtlSt5a9rqC2BKb8xheeazWS4mccsenc6NRxsHO0uLKxnMga90NLW7D6RlbvT1JSnwRrsp8NNWnygubhRxatUlAzpdyuCUoWAmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EKjwAo3A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QF8FXX015472;
	Mon, 26 Feb 2024 16:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=tVOT/Ynlm2jEPxxVndSwOeCRNtYwXVYPyCrsokhF8cs=; b=EK
	jwAo3ACtJLY6VqwzOcrafqu55uhALJcc/Z8oLllYzwGlZA3yZ3jnC0Z1gvp/gr2Q
	hAs68qqcGg+5FfI39M+7R/8e5H/ge/kD1wSzA6vhYPLktrIznmaB4GLQJzbLZbyO
	e2bs/6SOpFqd9dDMZtaVora9Ois2GR/tpA2NCO2Ylh6KIgfpiVTsAza5qt6g6EA2
	LMenDEdhA14E94KAMh3ltSskQrUwnofvch2gWYOAE3AWF7nJA4xobFKKcumNOr2W
	LKBzKjkchdrn8YNAsnPykorYFYRmHaBkRb46Brf1QfqeRua13m/eHMjUXv9yiL0x
	c0jBAZ6LiGZ4fiGJiNRg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxm1dfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:23:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QGNREP007165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 16:23:27 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 08:23:25 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 1/3] wifi: ath12k: Refactor Rxdma buffer replinish argument
Date: Mon, 26 Feb 2024 21:53:08 +0530
Message-ID: <20240226162310.629162-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226162310.629162-1-quic_periyasa@quicinc.com>
References: <20240226162310.629162-1-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cxw3115EHLQi_D2eDS4VPHNcp6_-92mv
X-Proofpoint-GUID: cxw3115EHLQi_D2eDS4VPHNcp6_-92mv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=571 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260124

Currently, the Rxdma buffer replenish procedure implicitly retrieves the
number of free entries when the caller passes req_entries as zero. This is
helpful to replenishing the Rxdma ring when the caller is unaware of the
number of entries to replenish. After the Rxdma ring is initialized, we
can pass req_entries as zero to replenish all the free entry in the Rxdma
ring. This change helps to align the argument req_entries to the used list
entries for better code readability.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index ca76c018dd0c..45646d987139 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -422,13 +422,10 @@ static int ath12k_dp_rxdma_mon_ring_buf_setup(struct ath12k_base *ab,
 static int ath12k_dp_rxdma_ring_buf_setup(struct ath12k_base *ab,
 					  struct dp_rxdma_ring *rx_ring)
 {
-	int num_entries;
-
-	num_entries = rx_ring->refill_buf_ring.size /
-		ath12k_hal_srng_get_entrysize(ab, HAL_RXDMA_BUF);
+	rx_ring->bufs_max = rx_ring->refill_buf_ring.size /
+			ath12k_hal_srng_get_entrysize(ab, HAL_RXDMA_BUF);
 
-	rx_ring->bufs_max = num_entries;
-	ath12k_dp_rx_bufs_replenish(ab, rx_ring, num_entries);
+	ath12k_dp_rx_bufs_replenish(ab, rx_ring, 0);
 
 	return 0;
 }
-- 
2.34.1



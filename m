Return-Path: <linux-wireless+bounces-4936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C70B8808DE
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 02:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB26F1F23FF9
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 01:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A53115A5;
	Wed, 20 Mar 2024 01:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FLi7b2Md"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0FBEDC
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 01:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710896800; cv=none; b=hrcrupNq++Qs3+PIrQSbGl5wNVcPYgBv+sXaG/35k7SwL8+MZGrxfvk1s5xpNwHv6XB3qkyiPebvEMGug4bzM7l7w57C+GAaW4xOJJUZ2rgFgQhNaImywgK6w0r/URRsAEmALun4jJYjhS4YCYhWNq4gNknWM5d4raOQ5DRF/M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710896800; c=relaxed/simple;
	bh=Wx00fq4IIrfxg+VrGpLrWjBy3jRIqFOSjP3wCqu+KEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUSZLU+lNPkLzQCa9eymoXMFg8oEgaStT3KaD6T5Tqo9JHCNuxBLOnH6rM6zorLnIf7WwI1+sP7Kz0EA3fB9kBtHBQtincdpjIiczLDIe6GpIvFv9w8EkOBJ/gb0b9ldXQfOzA3WyIzaz/J6N3EHMscs5Nn1l16mETGaFonjthw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FLi7b2Md; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42K0HC7g023379;
	Wed, 20 Mar 2024 01:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=tVOT/Ynlm2jEPxxVndSwOeCRNtYwXVYPyCrsokhF8cs=; b=FL
	i7b2MdMeyVbpkMhCTFwuMnEFV2tBp8dHGEXKnCDiFg0zck1V9UgXUrtzoigk1yWk
	0k4kzsr+ZNVczWujVKaMItLr+eD4L7M9erf6pp0XANLl0vCDkoprMs/vCBndq9k6
	BfkEP9jd6r4xYVtwCuFvVt5rzFLUjGzXAia4y5fosRhwkbdMn2QobTAVl8tog0NK
	Uh30BMHmOv5TxpVcfoilV2WaSuQIpN7VmpOpJdoelU21CsbVzRWt6T00lMJUIWVO
	qvJ/5C1vLHMYiIVti6WLgXleMWhT4/BtmI+i5noRVMeSane/7aLFgqyKjLhSuqNI
	AVdc63ZbYfEHpw2RkQYg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy5ppterh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 01:06:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42K16YRn010004
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 01:06:34 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 18:06:32 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 1/3] wifi: ath12k: Refactor Rxdma buffer replinish argument
Date: Wed, 20 Mar 2024 06:36:13 +0530
Message-ID: <20240320010615.91331-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320010615.91331-1-quic_periyasa@quicinc.com>
References: <20240320010615.91331-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: HrVsaDexiud-ug2K-L1aUhNF0d1ZKRb4
X-Proofpoint-ORIG-GUID: HrVsaDexiud-ug2K-L1aUhNF0d1ZKRb4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=574 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200005

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



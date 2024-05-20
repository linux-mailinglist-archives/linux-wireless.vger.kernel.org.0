Return-Path: <linux-wireless+bounces-7836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA458C9916
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 09:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3411F2155A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 07:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6C3D52F;
	Mon, 20 May 2024 07:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YHfscpIF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A82B11CBD
	for <linux-wireless@vger.kernel.org>; Mon, 20 May 2024 07:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716188479; cv=none; b=GIKEG7nKIFI8jJtsZgUHBWgglSQZ4eJe00QqRw8m3CsxIbS61QzSzPGF8JLWuI+HqqbbjkYKWd+iXHzplt9OOGBldq7CSbwEugirOeExNqo9q3A8ctbVmqoN+9UopSyUp2tiCMinMOd1wPIO/WXtWQn4qz0+SKmcWR5oQT4cEOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716188479; c=relaxed/simple;
	bh=EHZppAIQciKR6Ro7ktVy5BeCZmcdq/dtByfUpAz1tTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QfuWqZrimY9IsKyzBK1zLGMengVUD/UnVA0k+mbGZ7dwVFr6jLk9BdPgW3iNV0CEpDtE0jUBkPOHY1ZXdNnutwJNpWyQv0JY3NcmjRwDvI+ZyamBukhIzsF7yj/XOPpQeIAb/7i4ajzjms2wZlZYOLw7COSltsFHvyciQrEVm3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YHfscpIF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44K0vWwW009728;
	Mon, 20 May 2024 07:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Bxx4KK47uAyf3m6ptl0PVPbJrylEdGaXrem/QL3uYxA=; b=YH
	fscpIFCum4foNzVJvXyni1FpcJjmhVS6pNu5mO26QVJRPd2k1j6+OFTRFkRLQNeX
	CjAHgN/StTWaWi25PCtKddXMl2BdbgpVLUERJt4B1w3gwEWD8z6aSCw4XwGthMUo
	ToTX+tEs0wEPc2/XshrK+nOxqCrBj+0DkkAHCMi+1BJpnfOgxnCOFNCgeNIF4DPz
	VHsxTi4E7oNeZlHpS0A1tdx/IEymQE41Q9aTbyrvTPnegqRq3exmBERC8BJ/o7jy
	Sh/U91Qwg89ssU0Xb/XBUJqP5E5F8pF3BlCk9k/lbAoAppGlb9mS52CY8S/tlSjN
	B+GDpc9ZuKeYI3hcd69g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n4gapav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 07:01:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44K71DPR028083
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 07:01:13 GMT
Received: from hu-ppranees-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 20 May 2024 00:01:11 -0700
From: P Praneesh <quic_ppranees@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH 2/3] wifi: ath12k: fix invalid memory access while processing fragmented packets
Date: Mon, 20 May 2024 12:30:44 +0530
Message-ID: <20240520070045.631029-3-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240520070045.631029-1-quic_ppranees@quicinc.com>
References: <20240520070045.631029-1-quic_ppranees@quicinc.com>
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
X-Proofpoint-GUID: B_4DcRW6xWkCFEXjhg4yQfBR7wr2kcjF
X-Proofpoint-ORIG-GUID: B_4DcRW6xWkCFEXjhg4yQfBR7wr2kcjF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_04,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=951
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200057

The monitor ring and the reo reinject ring share the same ring mask index.
When the driver receives an interrupt for the reo reinject ring, the
monitor ring is also processed, leading to invalid memory access. Since
monitor support is not yet enabled in ath12k, the ring mask for the monitor
ring should be removed.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00209-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 06f443216488..ffe06ebdc992 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -544,9 +544,6 @@ static const struct ath12k_hw_ring_mask ath12k_hw_ring_mask_qcn9274 = {
 	},
 	.rx_mon_dest = {
 		0, 0, 0,
-		ATH12K_RX_MON_RING_MASK_0,
-		ATH12K_RX_MON_RING_MASK_1,
-		ATH12K_RX_MON_RING_MASK_2,
 	},
 	.rx = {
 		0, 0, 0, 0,
@@ -572,8 +569,7 @@ static const struct ath12k_hw_ring_mask ath12k_hw_ring_mask_qcn9274 = {
 		ATH12K_HOST2RXDMA_RING_MASK_0,
 	},
 	.tx_mon_dest = {
-		ATH12K_TX_MON_RING_MASK_0,
-		ATH12K_TX_MON_RING_MASK_1,
+		0, 0, 0,
 	},
 };
 
-- 
2.25.1



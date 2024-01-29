Return-Path: <linux-wireless+bounces-2638-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8019B83FEBB
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 07:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20D31C21612
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 06:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01254EB5E;
	Mon, 29 Jan 2024 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ItgVL67M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3173C4EB4E
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706511480; cv=none; b=qpCtR7SMFqZfewUvhC2phLaPk/3IVxp2jeDdv4OjhDy9sHNQvbIAD/OS3gW7DX1mm00FgmrTryPfjN0EbC/afyXlABLOn8wjKtRkjUVMioipdi/vDk85JGmzZxgD0k76b4IDduqgZhGvFdoiwL9iubwZnSUWnhtAG63erVdCKmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706511480; c=relaxed/simple;
	bh=dTWWyGjPUmoTuzm7vGZ7/rsVkXzAjeJEyQYrnJaeRoQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJDF+9VKHnCFVefe21KeUSOTdtSKjc/3WC8aVAmQ+hrH9eMpNRUQlIe9B63twpUUia1/wUrMU0f9H+HbZWKmzwLAx0oTXmT62XHJijZ24TpzluH8EEnmthVeXp8Ds7a5EQjmGXklWoVZAdcBx+EUjD7YjiVzqhTc0OFgsQu0xEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ItgVL67M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T3mSC5032511;
	Mon, 29 Jan 2024 06:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=+Z6BHs4NytYKgx1IVPLbLC5OOXQrQHuaTfLIwvygqzs=; b=It
	gVL67MgMoT80NWr605cduKrZ8VABOctxYp+p6E2ymxCYSx1vaVRYaQ8wUTSVxPPH
	2feOqUvQnwz6gLOgQ3mM6qWzrMBALCSB0Ba9UR4/ZiO2VJ1bBr9UoXiUu9n0/u5z
	gsYalugRQ8/jqHSf6QvytohIJFNBnX2QxDcRR/L4YFaUA9Oqb0K3RDvx3or63mhm
	SRovZpHL7m5Bn+NP7P0VCnfnfcNSPj+FZplq1/M96UfkDdH8NCIPhCgTsGP1difX
	A7MlWNi1T98SfPsxpE+uwq1nh1yGv/5qsEMTKfH8rRUzsyX3v2IXgF/Yyt9cji5Z
	uyC647Ioq0AF8sQj26Zg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx275gf6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:57:55 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T6vsTo008794
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:57:54 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 22:57:53 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH v3 04/13] wifi: ath12k: fix fetching MCBC flag for QCN9274
Date: Mon, 29 Jan 2024 12:27:15 +0530
Message-ID: <20240129065724.2310207-5-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: N1_4dzkQXDNCOmzpQL25mhx7mfaD184a
X-Proofpoint-GUID: N1_4dzkQXDNCOmzpQL25mhx7mfaD184a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_03,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290049

In QCN9274, RX packet's multicast and broadcast(MCBC) flag is fetched
from RX descriptor's msdu_end info5 member but it is not correct
for QCN9274. Due to this with encryption, ARP request packet is wrongly
marked as MCBC packet and it is sent to mac80211 without setting
RX_FLAG_PN_VALIDATED & RX_FLAG_DECRYPTED flag. This results in packet
getting dropped in mac80211. Hence ping initiated from station to AP
fails.

Fix this by fetching correct MCBC flag in case of QCN9274.
For QC9274 MCBC flag should be fetched from RX descriptor's mpdu_start
info6 member.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 8f04852e90cb ("wifi: ath12k: Use msdu_end to check MCBC")
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index a489369d8068..1bdab8604db9 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/dma-mapping.h>
 #include "hal_tx.h"
@@ -449,8 +449,8 @@ static u8 *ath12k_hw_qcn9274_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
 
 static bool ath12k_hw_qcn9274_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
 {
-	return __le16_to_cpu(desc->u.qcn9274.msdu_end.info5) &
-	       RX_MSDU_END_INFO5_DA_IS_MCBC;
+	return __le32_to_cpu(desc->u.qcn9274.mpdu_start.info6) &
+	       RX_MPDU_START_INFO6_MCAST_BCAST;
 }
 
 static void ath12k_hw_qcn9274_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
-- 
2.34.1



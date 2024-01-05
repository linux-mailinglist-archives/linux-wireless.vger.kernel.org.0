Return-Path: <linux-wireless+bounces-1528-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5A8825B45
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 20:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDD22857D7
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 19:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EE635F14;
	Fri,  5 Jan 2024 19:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="alaaykvK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF8235F17
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 405Jv8Pb005424;
	Fri, 5 Jan 2024 19:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=OOfXOm6ZBzRyz5WTXxNAkXxuBJLY2aBq8yiJwQhO2rg=; b=al
	aaykvKz/FX72v5AkJxkXtMPHhk2SXUtxWNCyU2eafFQaTMZW1QZDaIVOfkL/8sGr
	Myv7kD3GE9Y5/mlkV3ReH7iurkQhR03ji8gFbvRGTQN9kJIhitH+ntNwUr4slb/C
	lEVurmUfcDZLq8eQ06p45kIa/h5byfBdD74tOS4EYeRCfswehz/Vvx1v2wd2SCJn
	alEQOeAspePU/p+nj2wtHAMkV9y0YsrRkFkU7BiqnU4lMDrTAT+y7Ph0bfNs9s39
	WxUpFPPoV/c8jINTjczidOLVdp1PHpe+961+pafGu4UFnKKPiUZA6p2kcpLP3eqf
	H8utH4J3nYbhl33NUzDA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ve96qt423-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 19:57:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 405Jv686031905
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jan 2024 19:57:06 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 5 Jan 2024 11:57:05 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH v2 04/12] wifi: ath12k: fix fetching MCBC flag for QCN9274
Date: Sat, 6 Jan 2024 01:26:31 +0530
Message-ID: <20240105195639.3217739-5-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105195639.3217739-1-quic_rajkbhag@quicinc.com>
References: <20240105195639.3217739-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-ORIG-GUID: jIPru5vas5kOgxXurZuBuPo3dG1k1zNr
X-Proofpoint-GUID: jIPru5vas5kOgxXurZuBuPo3dG1k1zNr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401050160

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



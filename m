Return-Path: <linux-wireless+bounces-501-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F603807220
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 15:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718A91C20A6C
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 14:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA603DBA4;
	Wed,  6 Dec 2023 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IOWyNIhn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D55E1A2
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 06:18:23 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B63vqlo028777;
	Wed, 6 Dec 2023 14:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=n2zx7nVpjTZl2imYMKYHRPzs0K7FPXPfMqVrqz5Ph4c=;
 b=IOWyNIhnN/8r70bIL+DP7q750P2F1YTdwe2LX3jysRVxIVqZFvePhj8FQNp+S2WDrfZl
 BwCnqLLqexF2IPNqdQITzK747HRmyAJrhKZ8pI+eOzYOt3ZutXgebyinRQpC9qVrXh5F
 jeOl/Q1DZCoVwdWNFvx9n8UVCrUgaXQ9HIrawx7Yl+9hdTc3Cv05j+5ICu03z72KX24R
 ZLDjWmtGsGGts6k1nkhlvj1yj26PTeCH0tGQSDKOq5qT+2D36CCpbycsX2bOTtRgVCvt
 zvbzv3k1+0AVImH6exV8czgPbS0T7/ooz1cEujUAjhEuwzx3muugOJYwV9IpPcxJPPC/ 1g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utdadsxku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Dec 2023 14:18:18 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B6EIHS2010490
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Dec 2023 14:18:17 GMT
Received: from lingbok-HP-EliteBook-8460p.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 06:18:10 -0800
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: fix the issue that the multicast/broadcast indicator is not read correctly for WCN7850
Date: Wed, 6 Dec 2023 22:17:59 +0800
Message-ID: <20231206141759.5430-1-quic_lingbok@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CqCkTtYq3IqQzIuAPnbM_RgMrsoSSoOR
X-Proofpoint-ORIG-GUID: CqCkTtYq3IqQzIuAPnbM_RgMrsoSSoOR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_11,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=731 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060115

We observe some packets are discarded in ieee80211_rx_handlers_result
function for WCN7850. This is because the way to get multicast/broadcast
indicator with RX_MSDU_END_INFO5_DA_IS_MCBC & info5 is incorrect. It should
use RX_MSDU_END_INFO13_MCAST_BCAST & info13 to get multicast/broadcast
indicator.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
v2:
1.change __le16_to_cpu to __le32_to_cpu
2.always run ath12k-check

 drivers/net/wireless/ath/ath12k/hal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index ca6f1d0db31e..a489369d8068 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -889,8 +889,8 @@ static u8 *ath12k_hw_wcn7850_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
 
 static bool ath12k_hw_wcn7850_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
 {
-	return __le16_to_cpu(desc->u.wcn7850.msdu_end.info5) &
-	       RX_MSDU_END_INFO5_DA_IS_MCBC;
+	return __le32_to_cpu(desc->u.wcn7850.msdu_end.info13) &
+	       RX_MSDU_END_INFO13_MCAST_BCAST;
 }
 
 static void ath12k_hw_wcn7850_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,

base-commit: 0dbdc9383054fd3ecbcacfeb364aace3db744314
-- 
2.34.1



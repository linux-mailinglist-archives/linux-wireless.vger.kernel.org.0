Return-Path: <linux-wireless+bounces-2658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C03E84029D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 11:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428471F22B23
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 10:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F155810D;
	Mon, 29 Jan 2024 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bjUHBQiM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050AA57888
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706523330; cv=none; b=NGN4VdWJRQZWltwJ9mo/t4EQ6jhlcT0VK5lLaI0vU/4wUY1pNoxkuqcSV7Ov8Pe0vwyyY1Q3ebTqIsNzGCLKwung5tO4Hn3yrRu/Wt+PKaQiaC74zTKC7tXUCJhRCYH6N0DsJfK+FB32hm3QcRd+kIIysyNu049yFFmdQ0uLr0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706523330; c=relaxed/simple;
	bh=iO8+EN2NLGPBgbwsoZjviNxpZoxTWzKzc0uiJ6a7f9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frIl3tMDJnTIEtYOtYs1EDlRWTCuCGOesPEyDfUTwTFUF+C1+0a+EWlRlVXimDbWJpb4RTY/ZsQuasTbN25zVuhxtOU1kNDZgM/a3tvtjn+73bXMwhQsJFghB5WYj6hPObUADipKt6aXhLG11pnYz2f9uFuHOcotxET79W2w0jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bjUHBQiM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T4j1Wi005191;
	Mon, 29 Jan 2024 10:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Cc8L+zh6LekZybqZ7+u/JVOV3mwJlzaeIdqeTTQmflQ=; b=bj
	UHBQiMrRQZyzAvdr8gPWpx2uFaAzRhVYgMvqyi2V9lL1UbKrzp8Ttf2KIyNw4v3J
	euD77ixgl8BYkrC7wAntXdtTbnuRFEsKG2V/KhouiA/xRxUutH00KkT+G1pzEbqe
	7WsLEdAmfWsxt2PXP1Vc+o/jpUEZXSFB7Lw82s6ecraIKwjOOh5vgdHx07SgZdgt
	WLwoJGjVXDv9VBuNiiJuTIY963YQk2SlsD9Z7T3vV6IOzhhHcBWG6ywxplqXyUVx
	EU9QskzifkyXC+qeBzTIEl1it94Dg7RXdtJOu9DHvA9kwW1kY/svB8OiAogyK1Jh
	gNLG30pmUlcpIJkxh2fQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx3rqgqb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:15:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40TAFODm027362
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:15:24 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 02:15:22 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v5 08/11] wifi: ath12k: fix incorrect logic of calculating vdev_stats_id
Date: Mon, 29 Jan 2024 18:14:50 +0800
Message-ID: <20240129101453.368494-9-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129101453.368494-1-quic_kangyang@quicinc.com>
References: <20240129101453.368494-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: 5vmgoFhafGBpW788eszfZcZNvMjnwvWb
X-Proofpoint-ORIG-GUID: 5vmgoFhafGBpW788eszfZcZNvMjnwvWb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_06,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxlogscore=980 spamscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401290073

During calculate vdev_stats_id, will compare vdev_stats_id with
ATH12K_INVAL_VDEV_STATS_ID by '<='. If vdev_stats_id is relatively
small, then assign ATH12K_INVAL_VDEV_STATS_ID to vdev_stats_id.

This logic is incorrect. Firstly, should use '>=' instead of '<=' to
check if this u8 variable exceeds the max valid range.

Secondly, should use the maximum value as comparison value.

Correct comparison symbols and use the maximum value
ATH12K_MAX_VDEV_STATS_ID for comparison.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v5: 
    1. rewrite commit log. 
    2. move position.
v4: new patch.

---
 drivers/net/wireless/ath/ath12k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 4ad23bc9381c..1377b710bdcb 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5473,7 +5473,7 @@ ath12k_mac_get_vdev_stats_id(struct ath12k_vif *arvif)
 	do {
 		if (ab->free_vdev_stats_id_map & (1LL << vdev_stats_id)) {
 			vdev_stats_id++;
-			if (vdev_stats_id <= ATH12K_INVAL_VDEV_STATS_ID) {
+			if (vdev_stats_id >= ATH12K_MAX_VDEV_STATS_ID) {
 				vdev_stats_id = ATH12K_INVAL_VDEV_STATS_ID;
 				break;
 			}
-- 
2.34.1



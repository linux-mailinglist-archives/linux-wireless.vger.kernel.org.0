Return-Path: <linux-wireless+bounces-16977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C2B9FF61A
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 05:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AA467A1690
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 04:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC61617BD6;
	Thu,  2 Jan 2025 04:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BVX0ufEv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374924A00
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 04:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735792289; cv=none; b=n4CaDv1bDT+FvnPDcmf6K7XFdx33vYjtLdQqBPxKEjDRBfAsn2rzBlZN+aa0wCVX0xJdMTZ5Jc+1M4rmOnyz16+pI+eSjq8+LCXnhb2sqeZRmXhRNHzB2Gzl6wADWLtLjVRSPbzyHWX21Xo1xD16VEt+6fnoWem3pPnIf3vsEhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735792289; c=relaxed/simple;
	bh=CnGESVeiTd91spCz56Lgro5cjpdE7qcLS/4JJjOamJA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KlntfShexch1wA5Aa22N6AEfRjeOHVP7ID5QXQsCY1ZgRSatgWbxqPDfaPBvS0Dbcy3S4wF7/6V+VqXC0untG/HsRA2UV0NDPbmI4H/ca/2uyK/9+Y8DaY0ZIW9r1hMnF3ekJ6S5L/XWb2Hh7lVmZAMzMXsPYdvA29Al5AyNkyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BVX0ufEv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 501NU2SB007955;
	Thu, 2 Jan 2025 04:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UqB6/cziN3fxnmdaE0pArL
	mx8fRvdKeWVi1N934YblI=; b=BVX0ufEvqqf4e3pr6pML3fCd3zGMg5HNEV3uDg
	n8r9ihl69s1FY2oovm6hZNu0/C893GjaF/20Vjrzv6bpe105tZN9O3gyVW+/lqEJ
	Cp+HL2RCR/jRk0rcd+kM0DGIN4+wWiwI4LwDqSUAn+KSt9DEqeoXTypHGi4ptz/U
	RvR/DJWgEV9Q41ap/sCiwcw6lgbzJfW5JaQp03b2r0OL0C4pqFGKpGlXwWMBX0gx
	EwepkjqAMa6boMDETZfgARJBbWnRo7IWQcg8V+bwITLCdrN/Pvr2rU/nIMMBlp0h
	DKPRGt9sT376MOVG9ThV8tAGr51MwrNOodovSM3YZsxqnteA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43vxsr1hxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jan 2025 04:31:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5024V3hN005217
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 Jan 2025 04:31:03 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 1 Jan 2025 20:31:01 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>
Subject: [PATCH] wifi: ath12k: Fix pdev lookup in WBM error processing
Date: Thu, 2 Jan 2025 10:00:48 +0530
Message-ID: <20250102043048.2596791-1-quic_ramess@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 51SQEiKHpe_OPzARrTgzHSB3xpGZ4Vbd
X-Proofpoint-ORIG-GUID: 51SQEiKHpe_OPzARrTgzHSB3xpGZ4Vbd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=965
 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501020036

Currently in ath12k_dp_rx_process_wbm_err(), when processing packets
received on the WBM error ring, pdev validation is done based upon the
hw_link_id. But hw_link_id corresponds to link id of a given partner pdev
in a MLO hardware group, and is not the correct index to use to lookup a
pdev in an SoC(ab). As a result, pdev validation fails, and the reaped
packets are dropped instead of being processed.

The correct index to use is the pdev_id, which is already derived in the
function. So update the logic to validate the pdev based upon the pdev_id
instead of the hw_link_id. This matches the logic used in other Rx ring
processing functions.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 1a73acb5fba4 ("wifi: ath12k: move to HW link id based receive handling")
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 5c5a3aae393b..5584baec764e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/ieee80211.h>
@@ -4032,7 +4032,7 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
 						      hw_links[hw_link_id].pdev_idx);
 		ar = partner_ab->pdevs[pdev_id].ar;
 
-		if (!ar || !rcu_dereference(ar->ab->pdevs_active[hw_link_id])) {
+		if (!ar || !rcu_dereference(ar->ab->pdevs_active[pdev_id])) {
 			dev_kfree_skb_any(msdu);
 			continue;
 		}

base-commit: 09fa3b6974a1245ddd0751747609431494ba5b4f
-- 
2.34.1



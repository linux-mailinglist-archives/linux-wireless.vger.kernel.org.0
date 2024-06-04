Return-Path: <linux-wireless+bounces-8459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F468FAA49
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 07:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16C1BB251E6
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 05:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134C713D88C;
	Tue,  4 Jun 2024 05:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RdBALS+R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D2013E02A
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 05:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717480472; cv=none; b=gBCrprH10mdL0yjCK7obP+iO8SIHOqJVOxwV6zTNz64bzps+covGDysCLEiIm6sMPfnbU45+uPUAJABFwXDk8+yb+7Oxrd5y06nuMO4m5KBuQORR4iPIYanEA1PW7q2N1iUdUGdo+IWBP5D908pBtazLVdtYxauZFK9CDG7R8VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717480472; c=relaxed/simple;
	bh=V2hhKzYtAeVaybcOAqLGCVDkupnRIdvOR6OYxEV6jVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iaTOAI9onmho2BCYUAmhobcdGi0iPVeAs0H+R+R522kO4Tc6d9WW5Fk54awIfaL3LJXUipLEQBqEi83+lQDgFRSLcmKMIqhmhb+uKX7Q7I2Tl8G7F7ufCu34H2mkTQ77ygb4JHwhXBE8XGNDjNYC3HDzhdyWOPXC2Rj0KddW7/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RdBALS+R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4541H5Uu031232;
	Tue, 4 Jun 2024 05:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n5VJLyK/NC6hWykI6BCWPYgwag0ACkmw+1WRel8YgOA=; b=RdBALS+RSqucWBQC
	RY7fqRmSXhwNHy3q/nqwE4ZJf6vn+wg799CobRTSadxAf9iHkmdM3ISehAiEs8WP
	13UU7DyZSfsmULJkV4xeKUuZDryZEAKeegqBj8+CNcD3gLN/RPHrvp+ARDeSqwAk
	CEg6ytjIdXEPTHrN6M0yLogupAcNdqsv943MwEWKHpD8iAeLl+fqih0gjE1tiRpm
	sLd/9Jzo+D7iYZlGN6cQ8s0gfH+gbbhv2lXXT1DF0RRZp2lcNh03cCKGnb2IdTfR
	em5xyzJ4OWmQmTnVxU1Nx+IMvnp47aLFeJ4bW3MjroxXpMvBBdlPOItUBu9Koi1W
	UnAV/w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw4d616f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 05:54:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4545sKY3029317
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 05:54:20 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Jun 2024 22:54:19 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v4 1/8] wifi: ath12k: add ATH12K_DBG_WOW log level
Date: Tue, 4 Jun 2024 13:54:00 +0800
Message-ID: <20240604055407.12506-2-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240604055407.12506-1-quic_bqiang@quicinc.com>
References: <20240604055407.12506-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: LOahDlfTQbUX13DwnfHPZKyABf6_R8I-
X-Proofpoint-GUID: LOahDlfTQbUX13DwnfHPZKyABf6_R8I-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-04_02,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 clxscore=1015 mlxlogscore=795 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406040045

Currently there is no dedicated log level for WoW, so create it for future use.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/debug.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/debug.h b/drivers/net/wireless/ath/ath12k/debug.h
index aa685295f8a4..f7005917362c 100644
--- a/drivers/net/wireless/ath/ath12k/debug.h
+++ b/drivers/net/wireless/ath/ath12k/debug.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _ATH12K_DEBUG_H_
@@ -25,6 +25,7 @@ enum ath12k_debug_mask {
 	ATH12K_DBG_PCI		= 0x00001000,
 	ATH12K_DBG_DP_TX	= 0x00002000,
 	ATH12K_DBG_DP_RX	= 0x00004000,
+	ATH12K_DBG_WOW		= 0x00008000,
 	ATH12K_DBG_ANY		= 0xffffffff,
 };
 
-- 
2.25.1



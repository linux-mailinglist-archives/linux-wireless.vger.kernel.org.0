Return-Path: <linux-wireless+bounces-12201-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2D6963DB7
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 09:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B80B21A04
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 07:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D8B189F3B;
	Thu, 29 Aug 2024 07:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cclX8N9+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FAB15821A
	for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2024 07:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724918003; cv=none; b=mwZAPw7WzEq1VkxZGA7wGKG7owHrOiN+wBMc9aBFnQuMjGTY7Imh6tXdzNPZ6ZYaek8YKNNrm+xTQRbqN9Q59U7zq+e9FPG5ssqyWHIqxgPuBet7Lo7pUkU8Kyl6wLPeoscuu1Htrw7U7sWBzG7JCa5epMsIiRJWrFT8jOUzNZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724918003; c=relaxed/simple;
	bh=Q5T7KaAI3Zn74mrdATraAqwZySynt+fFVcxoKhp5WUY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jfQkVGevVzeBP6/qVcV5dhmUtzbpJH05TqrDPPdCtWZWA8eHT0ggLTOsGowc2vxnj1cSovVxDcFmwjGXa3JsgKCQimNsHgWnORVf4KjC9tXb8Y9ie9++H7Yz3gK47sA8pR1Z8tU7wUN0IJ2i4I2iKJWgq7O+j4p4JMOujzYSIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cclX8N9+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJMEm7026629;
	Thu, 29 Aug 2024 07:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bAH/oAM85EkYQewplQx4RP
	6QZxgIYQilhYlHugcbV88=; b=cclX8N9+MOVqY4ooNI8eNe1mVpD/wg4YSLnrrb
	v+JY+D5UjkXdUOlyrQQkrViQNs8FXZXjjTEmiUDAIy0rNh7ufKPr6xwYgwaZOL5y
	Mo9Iyug9aG7aH1zZei1cAybcrEtNCwow6Cop1mEQhy5+uKaMuwq+XzJmXEudH5/a
	SvKxTXj5RQpPttT4mA1+yNuSNBSC8NccFPuDFM/FezBdOngEkcwSt6pmPtXfXPrV
	V9nd1dDajQ/rOXMUMJff3FZKmW6ui7Btg5oa5Nlubf7qPbiHaVZB/mSyeVpKpPU4
	vSp5rZdx+Ji95b15Ju5QVa3c6zo38o4pQu4vBgy3w3sYguew==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419puucb5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 07:53:05 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47T7r4Pp019121
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 07:53:04 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 Aug 2024 00:53:02 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
Subject: [PATCH] wifi: ath11k: fix the stack frame size warning in ath11k_vif_wow_set_wakeups
Date: Thu, 29 Aug 2024 15:52:53 +0800
Message-ID: <20240829075253.657667-1-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kaa24pcrp6a5LxP8LX4uLf2IV7IhWcGO
X-Proofpoint-ORIG-GUID: Kaa24pcrp6a5LxP8LX4uLf2IV7IhWcGO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=999 mlxscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290056

Fix the following W=1 kernel build warning:

drivers/net/wireless/ath/ath11k/wow.c: In function ‘ath11k_vif_wow_set_wakeups’:
drivers/net/wireless/ath/ath11k/wow.c:461:1: warning: the frame size of 1352 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Remove the nonessential variable 'struct cfg80211_pkt_pattern
old_pattern' by relocating bitmask to bytemask conversion into
ath11k_wow_convert_8023_to_80211().

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04358-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wow.c | 39 ++++++++++++++-------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wow.c b/drivers/net/wireless/ath/ath11k/wow.c
index 99d8ba45a75b..827085a926b2 100644
--- a/drivers/net/wireless/ath/ath11k/wow.c
+++ b/drivers/net/wireless/ath/ath11k/wow.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/delay.h>
@@ -155,6 +155,7 @@ static void ath11k_wow_convert_8023_to_80211(struct cfg80211_pkt_pattern *new,
 	u8 hdr_8023_bit_mask[ETH_HLEN] = {};
 	u8 hdr_80211_pattern[WOW_HDR_LEN] = {};
 	u8 hdr_80211_bit_mask[WOW_HDR_LEN] = {};
+	u8 bytemask[WOW_MAX_PATTERN_SIZE] = {};
 
 	int total_len = old->pkt_offset + old->pattern_len;
 	int hdr_80211_end_offset;
@@ -172,11 +173,17 @@ static void ath11k_wow_convert_8023_to_80211(struct cfg80211_pkt_pattern *new,
 	struct rfc1042_hdr *new_rfc_mask =
 		(struct rfc1042_hdr *)(hdr_80211_bit_mask + hdr_len);
 	int rfc_len = sizeof(*new_rfc_pattern);
+	int i;
+
+	/* convert bitmask to bytemask */
+	for (i = 0; i < old->pattern_len; i++)
+		if (old->mask[i / 8] & BIT(i % 8))
+			bytemask[i] = 0xff;
 
 	memcpy(hdr_8023_pattern + old->pkt_offset,
 	       old->pattern, ETH_HLEN - old->pkt_offset);
 	memcpy(hdr_8023_bit_mask + old->pkt_offset,
-	       old->mask, ETH_HLEN - old->pkt_offset);
+	       bytemask, ETH_HLEN - old->pkt_offset);
 
 	/* Copy destination address */
 	memcpy(new_hdr_pattern->addr1, old_hdr_pattern->h_dest, ETH_ALEN);
@@ -232,7 +239,7 @@ static void ath11k_wow_convert_8023_to_80211(struct cfg80211_pkt_pattern *new,
 		       (void *)old->pattern + ETH_HLEN - old->pkt_offset,
 		       total_len - ETH_HLEN);
 		memcpy((u8 *)new->mask + new->pattern_len,
-		       (void *)old->mask + ETH_HLEN - old->pkt_offset,
+		       bytemask + ETH_HLEN - old->pkt_offset,
 		       total_len - ETH_HLEN);
 
 		new->pattern_len += total_len - ETH_HLEN;
@@ -393,35 +400,31 @@ static int ath11k_vif_wow_set_wakeups(struct ath11k_vif *arvif,
 	}
 
 	for (i = 0; i < wowlan->n_patterns; i++) {
-		u8 bitmask[WOW_MAX_PATTERN_SIZE] = {};
 		u8 ath_pattern[WOW_MAX_PATTERN_SIZE] = {};
 		u8 ath_bitmask[WOW_MAX_PATTERN_SIZE] = {};
 		struct cfg80211_pkt_pattern new_pattern = {};
-		struct cfg80211_pkt_pattern old_pattern = patterns[i];
-		int j;
 
 		new_pattern.pattern = ath_pattern;
 		new_pattern.mask = ath_bitmask;
 		if (patterns[i].pattern_len > WOW_MAX_PATTERN_SIZE)
 			continue;
-		/* convert bytemask to bitmask */
-		for (j = 0; j < patterns[i].pattern_len; j++)
-			if (patterns[i].mask[j / 8] & BIT(j % 8))
-				bitmask[j] = 0xff;
-		old_pattern.mask = bitmask;
 
 		if (ar->wmi->wmi_ab->wlan_resource_config.rx_decap_mode ==
 		    ATH11K_HW_TXRX_NATIVE_WIFI) {
 			if (patterns[i].pkt_offset < ETH_HLEN) {
-				u8 pattern_ext[WOW_MAX_PATTERN_SIZE] = {};
-
-				memcpy(pattern_ext, old_pattern.pattern,
-				       old_pattern.pattern_len);
-				old_pattern.pattern = pattern_ext;
 				ath11k_wow_convert_8023_to_80211(&new_pattern,
-								 &old_pattern);
+								 &patterns[i]);
 			} else {
-				new_pattern = old_pattern;
+				int j;
+
+				new_pattern = patterns[i];
+				new_pattern.mask = ath_bitmask;
+
+				/* convert bitmask to bytemask */
+				for (j = 0; j < patterns[i].pattern_len; j++)
+					if (patterns[i].mask[j / 8] & BIT(j % 8))
+						ath_bitmask[j] = 0xff;
+
 				new_pattern.pkt_offset += WOW_HDR_LEN - ETH_HLEN;
 			}
 		}
-- 
2.25.1



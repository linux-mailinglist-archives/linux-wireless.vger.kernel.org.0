Return-Path: <linux-wireless+bounces-19516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72797A474EF
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 05:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FBD3B1673
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 04:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9761E5210;
	Thu, 27 Feb 2025 04:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FYcvzwBd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6693FB0E
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 04:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740632345; cv=none; b=gIAcOtriwqr7n5Jvr9YQyvLn/QZI3HGNu4y0+d/UWQHdmCQ+eGbELJlQIRINChMAkWnRq6imLACzgC5HKIho/QUsmfId4kQSbfOp32tpfiDwMZoHeJtWTN7UZZ2L6LUG8IvCaRWSqK2+Ahhpdzm+oLCRh9yDzRwKavHC30xVszY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740632345; c=relaxed/simple;
	bh=v0Ceut6KHKipPUzC2dhY/AsTweOH01R2qTh488o1zko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHEnoIF91BvF3UcUcP2JUmTXlrjPjAfV3P0Qo9zILCrK/HU//UWPL3PpL2ktOkjwRaoDAH1bodGfr5F4g242tTm03gtcTTdspUmGy4PcTvIxEESUu2v4E9h63Oqh2m3q48NiUnUaV/JNz9LHCtBnwThaEECRtxc/jOqdrhhymxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FYcvzwBd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QJTPmD000821;
	Thu, 27 Feb 2025 04:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	saN0YybRpnHcboeumFqgvksTqT9ZbXEfVKz7yRrPeUU=; b=FYcvzwBdedRuFgHs
	bwDZV2nqTwd0SoQhYmgeDs+piy+Au3oNqehTe23us9udFisl95gaXEabDLhODeIw
	cXYlTtpOfuoSrshsJ+8hJBPA8pjynTelb0hsaxhZiuztJ3cjf3KKnQ2iJSgBfcV6
	rnxjIn+Hgju1yoAHmqIOcwRai08zU4QPOaugHymFYgFUw6kJQMHm2RNFAGiMX+if
	SN+7VQABK1tS90ygbDaUku4oaHz+koCaVcdyhn5k9D4cxYtxSTiz14uegYrUVw6G
	fEDtrwdjxsjd5VO9adCiudWOqQXB9kQNAYiWIf9G/Ksq/DYhE5+yIpbkR35sucI5
	WzVVyg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451pu9cb7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 04:58:48 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51R4wl1M013532
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 04:58:47 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Feb 2025 20:58:46 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        "Sarika
 Sharma" <quic_sarishar@quicinc.com>
Subject: [PATCH v3 3/5] wifi: ath12k: add EHT support for TX rate
Date: Thu, 27 Feb 2025 10:28:22 +0530
Message-ID: <20250227045824.91480-4-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227045824.91480-1-quic_sarishar@quicinc.com>
References: <20250227045824.91480-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nqC2F6SzuccKguYquDl5RNqIL3dByzoP
X-Proofpoint-ORIG-GUID: nqC2F6SzuccKguYquDl5RNqIL3dByzoP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=831 malwarescore=0 suspectscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270036

Currently, TX rates are not supported for EHT. Hence, add EHT
handling for TX rates and update the EHT-specific fields in arsta
accordingly.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 1fa7cf044afe..070568b8322c 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1481,6 +1481,16 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 		v = ath12k_he_ru_tones_to_nl80211_he_ru_alloc(tones);
 		arsta->txrate.he_ru_alloc = v;
 		break;
+	case WMI_RATE_PREAMBLE_EHT:
+		arsta->txrate.mcs = mcs;
+		arsta->txrate.flags = RATE_INFO_FLAGS_EHT_MCS;
+		arsta->txrate.he_dcm = dcm;
+		arsta->txrate.eht_gi = ath12k_mac_eht_gi_to_nl80211_eht_gi(sgi);
+		tones = le16_to_cpu(user_rate->ru_end) -
+			le16_to_cpu(user_rate->ru_start) + 1;
+		v = ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(tones);
+		arsta->txrate.eht_ru_alloc = v;
+		break;
 	}
 
 	arsta->txrate.nss = nss;
-- 
2.34.1



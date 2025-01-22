Return-Path: <linux-wireless+bounces-17832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C08FA192AD
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 14:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B5A1620FA
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 13:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36131BDCF;
	Wed, 22 Jan 2025 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OmKrU5Lb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B97921325D
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737552925; cv=none; b=tXVJu6qYWyMF7iPnkz4BOPSDxnugQmBEClmKVEY1fAi/RALdhNKfxEVGgo9tiue416hz8/D4oPuNjhz8NFXwLg9qwYskvaMPKiWrj67S5HibDGSIjPTlKy5lioDz9liDyncRC5uJpFSGw8Tz8dHKnk5rRuRkJPP2pOC23H5qEWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737552925; c=relaxed/simple;
	bh=orIhZqHN1n1cSb3NxeDYheLjql9XD3bKtuCGynOJwP0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3A1vDbAHnVvxH45ADroiUkEEHj79HskbAIFKszqAmRXgOcf2z2OL+GWmBBL5VcM6VxwZWw0g8pKiaB+dhubve9vVABHmkQfyfL4HGInb96n1Hcv2sNcWSWMEen3vvz3ih2bBiM5ikoi7F35xesVFpuEFvcsYUYPk9hzm8MQkgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OmKrU5Lb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MAql8F001899;
	Wed, 22 Jan 2025 13:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4MF89TeAwJcnRoHLM7N/QFTlaU/zQVVKV25LMH8q43M=; b=OmKrU5LbVuhDbo0t
	C6pAqSMhAJOB/vgtAnPXBlaF8KmiG29NvAUgovEpOph+IFnF8H47HhJg+uVd6n0/
	QTgi5P/dnlQXvmNoPMhxmJLAvCp4H+JODJ4J2c1FLd1+tRuPLqz5gEisd8YmzcAe
	yEMqw4djmV2+MPfeuOmE9XbpV24gDFUDq4V7hmMwlQkvBfAr66isHDwdJxk1/Anm
	HDg3Wgv07RHQWrUFaBmdztlZACir9aKjgvPKBJt72q+8M8I1jzSxn2pyOeBD+eGK
	L9YbZXTZvGC0dOzHaQ1pgHYNrWB/ZVTpSPgx95UrtGo3Usmb13g/fCNizGf10pT5
	cZA2kw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ayaagca7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 13:35:18 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50MDZH5e012259
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 13:35:17 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 22 Jan 2025 05:35:15 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        "Sarika
 Sharma" <quic_sarishar@quicinc.com>
Subject: [PATCH RFC 3/3] wifi: ath12k: add EHT support for TX rate
Date: Wed, 22 Jan 2025 19:04:24 +0530
Message-ID: <20250122133424.1226555-4-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122133424.1226555-1-quic_sarishar@quicinc.com>
References: <20250122133424.1226555-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-GUID: G6K-ENfGgZ5_neLvEhx4j2f5-3_E3146
X-Proofpoint-ORIG-GUID: G6K-ENfGgZ5_neLvEhx4j2f5-3_E3146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_06,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=682 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220100

Currently, TX rates are not supported for EHT. Hence, add EHT
handling for TX rates and update the EHT-specific fields in arsta
accordingly.

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 10 ++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h   |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index eae85849c88f..39aa03ede214 100644
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
+		arsta->txrate.eht_gi = ath12k_eht_gi_to_nl80211_eht_gi(sgi);
+		tones = le16_to_cpu(user_rate->ru_end) -
+			le16_to_cpu(user_rate->ru_start) + 1;
+		v = ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(tones);
+		arsta->txrate.eht_ru_alloc = v;
+		break;
 	}
 
 	arsta->txrate.nss = nss;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index b6a197389277..b855e666b0e4 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_WMI_H
@@ -4605,6 +4605,7 @@ enum wmi_rate_preamble {
 	WMI_RATE_PREAMBLE_HT,
 	WMI_RATE_PREAMBLE_VHT,
 	WMI_RATE_PREAMBLE_HE,
+	WMI_RATE_PREAMBLE_EHT,
 };
 
 /**
-- 
2.34.1



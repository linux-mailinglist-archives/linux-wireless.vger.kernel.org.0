Return-Path: <linux-wireless+bounces-2323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CE2836248
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 12:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CF128848F
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 11:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAADB3D964;
	Mon, 22 Jan 2024 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RhLuhiY/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E263D99C
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923584; cv=none; b=iF3fyKkZjJeaYCm5wMry8PqvlmpZxcDdhQLxdxl4rzh4tC1I30+KkWbjWlXK3pBy03dd547CajAtmmvaQb3ovwX+oUVr1JJJX5e0ZXOlprAI68NYnb+oku24JmZVqynLY2pIDZxx5jC4fUou+5NrfqOOKJ3elw1LH1ywErubtDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923584; c=relaxed/simple;
	bh=p01vPnjBgxRaRUNVbhjGNJeZ2KUEX75bgVvpjKJBP1c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1caMGdL+x1a0f+UcF64AGP4sfNnx3HvTFewsr5tuAIzUZQ7HDezdc3w/hJdHdCBa8eqwKiZdwvTaMFzXEGiiujLn5yJh2vw+2lC1NwcbJH7Z1D2j2XFFfCFNYBN5anTMmsCNNoxvQ4k78Hn344rO4imm4nt3JtdoKcGOivJhgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RhLuhiY/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M8c3nM015705;
	Mon, 22 Jan 2024 11:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=HBALOrUIoJncMSgE9LOut+h5W/C0H94IHwomEhjIkQk=; b=Rh
	LuhiY/cN0bdDfvriG6k/KIfeDU187zKKukic7gOZNdYriDRpA9CUaBeo7QOe1bZX
	sNlLsXBDUcrYgi3cZ35Xs1/BeeMmHqpUR/y4q0nhocoFyo0vrbU90gjnVsI+f4Hd
	Pk/p/8GDbnmpYfAy+qWVG/xPrvXoMQxg200o9vKNF75/L3KxumERmpLK6DjFEFwI
	FwFRvVjp/VagIA6shYBm6QzH5kwtOivCTvM6Nm4bIfqIGZS5CgmXJ/YjG7/IKAhT
	lDf74+SR8HIogzThrH1EASYWSC2CcYa5F3q4Omx8FP6Ruum2RmBC+KDwn7cLHCIT
	NwNXvygFSdJUfcTAQrPA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vsn0wrcd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 11:39:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MBddd4014953
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 11:39:39 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 03:39:37 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v3 10/10] wifi: ath12k: advertise P2P dev support for WCN7850
Date: Mon, 22 Jan 2024 19:39:04 +0800
Message-ID: <20240122113904.8938-11-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122113904.8938-1-quic_kangyang@quicinc.com>
References: <20240122113904.8938-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: _dh7kINkx6QRe7hB1WDz6BLs45qoEEru
X-Proofpoint-GUID: _dh7kINkx6QRe7hB1WDz6BLs45qoEEru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_02,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=606 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220083

Now that all the necessary pieces are implemented we can enable P2P
support for WCN7850.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v3: no change.
v2:
    1. add Tested-on tag of QCN9274.
    2. update copyright.

---
 drivers/net/wireless/ath/ath12k/hw.c  | 7 +++++--
 drivers/net/wireless/ath/ath12k/mac.c | 8 ++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index cbb6e2b6d826..b804d9f88a1b 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/types.h>
@@ -953,7 +953,10 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.vdev_start_delay = true,
 
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
-				   BIT(NL80211_IFTYPE_AP),
+				   BIT(NL80211_IFTYPE_AP) |
+				   BIT(NL80211_IFTYPE_P2P_DEVICE) |
+				   BIT(NL80211_IFTYPE_P2P_CLIENT) |
+				   BIT(NL80211_IFTYPE_P2P_GO),
 		.supports_monitor = false,
 
 		.idle_ps = true,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 10aa8b20ef7a..d811bcc01456 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5745,17 +5745,25 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_STATION:
 		arvif->vdev_type = WMI_VDEV_TYPE_STA;
+		if (vif->p2p)
+			arvif->vdev_subtype = WMI_VDEV_SUBTYPE_P2P_CLIENT;
 		break;
 	case NL80211_IFTYPE_MESH_POINT:
 		arvif->vdev_subtype = WMI_VDEV_SUBTYPE_MESH_11S;
 		fallthrough;
 	case NL80211_IFTYPE_AP:
 		arvif->vdev_type = WMI_VDEV_TYPE_AP;
+		if (vif->p2p)
+			arvif->vdev_subtype = WMI_VDEV_SUBTYPE_P2P_GO;
 		break;
 	case NL80211_IFTYPE_MONITOR:
 		arvif->vdev_type = WMI_VDEV_TYPE_MONITOR;
 		ar->monitor_vdev_id = bit;
 		break;
+	case NL80211_IFTYPE_P2P_DEVICE:
+		arvif->vdev_type = WMI_VDEV_TYPE_STA;
+		arvif->vdev_subtype = WMI_VDEV_SUBTYPE_P2P_DEVICE;
+		break;
 	default:
 		WARN_ON(1);
 		break;
-- 
2.34.1



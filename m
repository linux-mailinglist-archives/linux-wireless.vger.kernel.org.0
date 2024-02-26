Return-Path: <linux-wireless+bounces-3992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DAD8669D9
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 07:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400AC2811FD
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 06:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9861BDF4;
	Mon, 26 Feb 2024 06:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IvSk1tSW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2464D1BDD3
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 06:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708927382; cv=none; b=dTQleS2IL9S33PMXNRSN1iCaV8kCjGkRGi4f8wnbkQMSXHxNNg7zOIrNnFcKqke8oGzA7KrHlAvLZCWLS0FJsjHEYLQ8WYDj8hpPHnmxm1CiMClQPunzerGDRxo0C3vGkHsDLg97nyL+DKpIW7HzS+jGPgetBnU/iZD97CuGPd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708927382; c=relaxed/simple;
	bh=fDJMjndxb6r8lf8hobkyyJEU9X+Hl62sndPuN5vjTjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+6zbDfOAya/gnhfoUecF4mF3VZZgHRK1Gh/fRm1mWHKIYHrIfO3cxcA2oZd9E0fLk7cEJt85dyWGXnLVxhYhTpmm/nsi35hm+sQYBI16WRhjQg+VleBN9LGCwJ2ay2HUfSYER3WkKyJ3d3RJRNemQWL7yTnwQItKdxzQdm3Ww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IvSk1tSW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q5ed6v004214;
	Mon, 26 Feb 2024 06:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=FVSajQ4ipY7CK01ECej57ZZ4nv+x5sAtuaAw3OxTecM=; b=Iv
	Sk1tSWepVeslOXbeu4dNFhHmC4BETp4l4YvPkFPDWxcj6wekZWLKKbpV95Dl3R+Q
	rb/8QUlUAbePWUqqp+puVFiFIXXVTv6WjYzk0CUTVXqGagDmdohgbDYA9qYHabP4
	CRmmxuRkPy8DqQZBcib5UjktBVBXNRsEuhaMi8mb4AzxY+KLSeZwyzahoV21HNbZ
	ijWxqSfngvEH6qktZTouwOejMRVV7exiMT5TwdJBXSJwsEjpy8OiJGmCt/TXBjTz
	FAp9DAAWjfdtwD32BVPEcbMURkSFfYGVpJ67fJYJi0KNhGsZl3FA4sLBJlFncaGb
	6YzQxRVB4mtprUovmrHg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxp83k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 06:02:58 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41Q62TGs013463
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 06:02:29 GMT
Received: from Mayan.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 25 Feb 2024 22:02:27 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 6/6] wifi: ath11k: advertise P2P dev support for QCA6390/WCN6855/QCA2066
Date: Mon, 26 Feb 2024 14:02:03 +0800
Message-ID: <20240226060203.2040444-7-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226060203.2040444-1-quic_kangyang@quicinc.com>
References: <20240226060203.2040444-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: UDIU1emLCcPkKu7p5cOkcKtfJZvNUJXb
X-Proofpoint-GUID: UDIU1emLCcPkKu7p5cOkcKtfJZvNUJXb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=682 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260044

Now that all the necessary pieces are implemented we can enable P2P
support for QCA6390/WCN6855/QCA2066.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.2

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 20 ++++++++++++++++----
 drivers/net/wireless/ath/ath11k/mac.c  |  9 +++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index c78bce19bd75..6e9f16f01ebd 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -247,7 +247,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		},
 
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
-					BIT(NL80211_IFTYPE_AP),
+					BIT(NL80211_IFTYPE_AP) |
+					BIT(NL80211_IFTYPE_P2P_DEVICE) |
+					BIT(NL80211_IFTYPE_P2P_CLIENT) |
+					BIT(NL80211_IFTYPE_P2P_GO),
 		.supports_monitor = false,
 		.full_monitor_mode = false,
 		.supports_shadow_regs = true,
@@ -416,7 +419,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		},
 
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
-					BIT(NL80211_IFTYPE_AP),
+					BIT(NL80211_IFTYPE_AP) |
+					BIT(NL80211_IFTYPE_P2P_DEVICE) |
+					BIT(NL80211_IFTYPE_P2P_CLIENT) |
+					BIT(NL80211_IFTYPE_P2P_GO),
 		.supports_monitor = false,
 		.full_monitor_mode = false,
 		.supports_shadow_regs = true,
@@ -501,7 +507,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		},
 
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
-					BIT(NL80211_IFTYPE_AP),
+					BIT(NL80211_IFTYPE_AP) |
+					BIT(NL80211_IFTYPE_P2P_DEVICE) |
+					BIT(NL80211_IFTYPE_P2P_CLIENT) |
+					BIT(NL80211_IFTYPE_P2P_GO),
 		.supports_monitor = false,
 		.supports_shadow_regs = true,
 		.idle_ps = true,
@@ -750,7 +759,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		},
 
 		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
-					BIT(NL80211_IFTYPE_AP),
+					BIT(NL80211_IFTYPE_AP) |
+					BIT(NL80211_IFTYPE_P2P_DEVICE) |
+					BIT(NL80211_IFTYPE_P2P_CLIENT) |
+					BIT(NL80211_IFTYPE_P2P_GO),
 		.supports_monitor = false,
 		.full_monitor_mode = false,
 		.supports_shadow_regs = true,
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f52dd52dabbb..053785e0eba8 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6657,17 +6657,26 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
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
+
 	default:
 		WARN_ON(1);
 		break;
-- 
2.34.1



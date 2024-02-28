Return-Path: <linux-wireless+bounces-4170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B71AD86AB6E
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 10:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8271C20B9C
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A91376FE;
	Wed, 28 Feb 2024 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bXdn2NNl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92279374F9
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112969; cv=none; b=GmcCqNakMSyr773NKwgyHDTtKoJWy64gqQTs8NVJEuGRxhR7Fk9Ie1LS3qnWqQYxYV2m54seX2XK68XETX1R0wUF6Jz85KdMNlaUT69Sxmpg/4duGsjDIFzUudQSSEAUw+IGp9q/M3b13wde06Y/b3nCLpLZ7wvSIlDBcyYubLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112969; c=relaxed/simple;
	bh=s6r+B+shzV3IvSIUTLipeDS+RgSuFBr/ZdpLmSoIFmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhjgDWtBOljFrJkaYB5H3ru9RI45cr47MMFj25C0D+OYUujkHJ4wPMGg4V8us8rV41uK1b8sbgDHETy/8aCQDacnu/alDmeusV9FT0P2W+F0OKlfWnlCDM6RPwYhwt5H4KKXUlt8LMI5JJ3c8er8DPhxmA1iKn4WW3RWbADGQAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bXdn2NNl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S6wQpA021955;
	Wed, 28 Feb 2024 09:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=xhZpSXOktuljl2YCd0chFVKdksb1/p3nGTT5rFI0ha8=; b=bX
	dn2NNlIqcY12hPOVJyggz5BmdTbVhU2XbzCmmB3LSfINSCr0TtIExyx5oCuCygAq
	ZwVvJ+QPAN6jgBwZypO7ZrwslgJreVBZ1JnJ6llZLPPG56PWZJW4SLigMn1PciLf
	5pau68yoYHJ1poqu/ofC/tlhmXvBTYWyAxgI/ptnH14O1jCWNB5t2mc/aEYbc8CF
	oB+pZiY/xZFP/aVxqrwcaMZm3T6pm1UfwhBXNOdgVXNZ3YQid4XuRc68bXAb84e7
	WvNUt7nZHvAAV8Wb4vUd2rcmVzTJlSLfL/MrmDUOaekSFfC+HthoA3JodJUUVTlB
	Ipd0JkRxHB3vLv4ASP7g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whtbw8vvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 09:36:05 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41S9a3DD001623
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 09:36:03 GMT
Received: from Mayan.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 01:36:01 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2 6/6] wifi: ath11k: advertise P2P dev support for QCA6390/WCN6855/QCA2066
Date: Wed, 28 Feb 2024 17:35:37 +0800
Message-ID: <20240228093537.25052-7-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228093537.25052-1-quic_kangyang@quicinc.com>
References: <20240228093537.25052-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: FQHr_VAeHJ169jaG-7dyEsyLZYuhNd3t
X-Proofpoint-ORIG-GUID: FQHr_VAeHJ169jaG-7dyEsyLZYuhNd3t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 mlxlogscore=692 lowpriorityscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280075

Now that all the necessary pieces are implemented we can enable P2P
support for QCA6390/WCN6855/QCA2066.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.2

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
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
index d66d09adf2fa..d65a19f9b694 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6660,17 +6660,26 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
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



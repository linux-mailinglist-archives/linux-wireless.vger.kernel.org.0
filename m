Return-Path: <linux-wireless+bounces-1573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25A8826975
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 09:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C505B21762
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 08:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C42A12B84;
	Mon,  8 Jan 2024 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pqf771uM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB525125AB
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4086x2CT028135;
	Mon, 8 Jan 2024 08:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=G3KMXD9RCLoi+tZuHWuFW6Oc6L6RnY+cp37DfvNmPKw=; b=pq
	f771uMEVxS294ynZFglL4m6/AA9q220X2hGDyk36Kcm081QvsZd7dymPd1pf5DNR
	MB/UuBScn+97QhLFQJGKSP7kNSOUUuWOsB0SdsL2IT5EFK8QzsJLACB9wZmR8kEp
	vLT8iAOL4U4PJDbvvCZu7J9CT3no6ak0DrCStSSBMu4F1q1kZtaepm8qd4u7kLst
	ekxenjMdv4bJJnS+zfH2hjhsOxB9k5BvPguXWoyiBP59i2C5llYoR60wOmg7KOwI
	oKPpbbsScFHCDuKCLTrj95EtZAJ5qAYqYpihLKIvqMuf6mrHsXooT63o8QssKQh7
	495H9r0LQniqVs0sQcMQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3veymmbcvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 08:26:41 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4088Qf6e026446
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 08:26:41 GMT
Received: from yk-E5440.local (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 00:26:39 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 10/10] wifi: ath12k: advertise P2P dev support for WCN7850
Date: Mon, 8 Jan 2024 16:25:52 +0800
Message-ID: <20240108082552.7227-11-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108082552.7227-1-quic_kangyang@quicinc.com>
References: <20240108082552.7227-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: jVnfvjn-OamslVSfC8tIc6T2Vd11ULjD
X-Proofpoint-GUID: jVnfvjn-OamslVSfC8tIc6T2Vd11ULjD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=695 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080070

Now that all the necessary pieces are implemented we can enable P2P
support for WCN7850.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c  | 5 ++++-
 drivers/net/wireless/ath/ath12k/mac.c | 8 ++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index de60d988d860..9b7402f5a9f7 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -950,7 +950,10 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
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
index 7e2e88ad9d66..48f7975311b6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5635,17 +5635,25 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
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



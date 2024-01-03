Return-Path: <linux-wireless+bounces-1430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D743822878
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 07:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F4D1F21335
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 06:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3445182AB;
	Wed,  3 Jan 2024 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lBDuM27/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB84182AA
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4035CE1J017806;
	Wed, 3 Jan 2024 06:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=LzE8b+TzVlArLN9l3Cx3bw7GgUhpbD/KvhtmQjAt0Bw=; b=lB
	DuM27/ZTDEIvcVnaJhUrLzGHlbGoxNu0/qrm2JPCBT3G+JMnDmp9GtVRvpXNF7qj
	n9eha2r5W95kJQI5dmftwHwIoBQQSZo0lho4UZaD9aGHRFMJn4eXkwkuDD5Urk78
	z9NznbxsC5ZsIFqxWHNvxnJvo5hJ3mhsprdaQoUQIKEyKC8KSavmlds4TMLunq0x
	8j0RtSy9HHSXDemyraj7Ph4qcIyH3CwQ+ng32qlu1ukG+emLM++emfmI97z0h0y6
	g6kUceuhGnfk3vs9Tgt3xTGxWhl4LZ0TyNvq1Yxpd1W+aX5mDgtqLra5IYYyd864
	9wwh+pKDHU8bgL4T0TfA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vcqak9e8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 06:38:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4036c0pq017734
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 06:38:00 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 2 Jan 2024 22:37:58 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 06/10] wifi: ath12k: Refactor mac callback of update vif offload
Date: Wed, 3 Jan 2024 12:07:27 +0530
Message-ID: <20240103063731.3356060-7-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103063731.3356060-1-quic_periyasa@quicinc.com>
References: <20240103063731.3356060-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: hBnJbK3U7dxReFmS0DWPI6nVvTuGE37G
X-Proofpoint-ORIG-GUID: hBnJbK3U7dxReFmS0DWPI6nVvTuGE37G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxlogscore=675 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401030053

To support single wiphy abstraction, introduce link/radio specific helper
function in the mac80211 callback update_vif_offload(). This way, the
callback can be extended to handle multiple link/radio in the future.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 0b72b32e25d4..5c7b747addda 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5434,12 +5434,11 @@ static int ath12k_set_he_mu_sounding_mode(struct ath12k *ar,
 	return ret;
 }
 
-static void ath12k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
-					     struct ieee80211_vif *vif)
+static void ath12k_mac_update_vif_offload(struct ath12k_vif *arvif)
 {
-	struct ath12k *ar = hw->priv;
+	struct ieee80211_vif *vif = arvif->vif;
+	struct ath12k *ar = arvif->ar;
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	u32 param_id, param_value;
 	int ret;
 
@@ -5481,6 +5480,14 @@ static void ath12k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
 	}
 }
 
+static void ath12k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
+					     struct ieee80211_vif *vif)
+{
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+
+	ath12k_mac_update_vif_offload(arvif);
+}
+
 static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif)
 {
@@ -5584,7 +5591,7 @@ static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
 	list_add(&arvif->list, &ar->arvifs);
 	spin_unlock_bh(&ar->data_lock);
 
-	ath12k_mac_op_update_vif_offload(hw, vif);
+	ath12k_mac_update_vif_offload(arvif);
 
 	nss = hweight32(ar->cfg_tx_chainmask) ? : 1;
 	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
-- 
2.34.1



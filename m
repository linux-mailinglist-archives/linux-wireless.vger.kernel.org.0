Return-Path: <linux-wireless+bounces-1427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BCB822875
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 07:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9DB284EF4
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 06:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525A318053;
	Wed,  3 Jan 2024 06:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eCauo3qd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D240318032
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 06:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4035OACW030576;
	Wed, 3 Jan 2024 06:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=vN6UMDr06HrJmaET79dVD6wGXnD64xPphUTDZDvLSOs=; b=eC
	auo3qdu1JBJIJNS4PhOK1gyqeB1JNdGmFSf4Cf3jWuczDrZTohJYAotpkyun83iW
	cYD3GyC5ZJMl2kOdXPh3NB3k/9VYsamY4eQHKreN1qu0iQJuO20pBoewEPaOfE91
	XH7CBg3DzN9lU+qw7vbnLl4512mNLamaww01uRCAl9E31CZlxwi9VDgiYnnyRN0t
	ipRxTjcq7iuVnsgJS9DH4sDMKlxL40u1eSl15aVxQMVcEg+0VD3jf+wujYc51CjR
	YZVrP7eT9PFqxTn1wvd6yhdSka0obbsuxHTs17wBJuQ38qdzCRXD7txokd9RP7vH
	XB+nJceFN6aBI0cwYzCw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vcbnb2sjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 06:37:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4036bsON023482
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 06:37:54 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 2 Jan 2024 22:37:52 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 03/10] wifi: ath12k: Refactor mac callback of conf tx
Date: Wed, 3 Jan 2024 12:07:24 +0530
Message-ID: <20240103063731.3356060-4-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: KG9RoH2nZdhisPtJEgHlJnpGyYFHTWSQ
X-Proofpoint-GUID: KG9RoH2nZdhisPtJEgHlJnpGyYFHTWSQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=689 mlxscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030052

To support single wiphy abstraction, introduce link/radio specific helper
function in the mac80211 callback conf_tx(). This way, the callback can
be extended to handle multiple link/radio in the future.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 41 ++++++++++++++++++---------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index bbd57b73fa63..66c758bddf48 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3986,10 +3986,10 @@ static void ath12k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 	ieee80211_queue_work(hw, &arsta->update_wk);
 }
 
-static int ath12k_conf_tx_uapsd(struct ath12k *ar, struct ieee80211_vif *vif,
+static int ath12k_conf_tx_uapsd(struct ath12k_vif *arvif,
 				u16 ac, bool enable)
 {
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ath12k *ar = arvif->ar;
 	u32 value;
 	int ret;
 
@@ -4043,17 +4043,16 @@ static int ath12k_conf_tx_uapsd(struct ath12k *ar, struct ieee80211_vif *vif,
 	return ret;
 }
 
-static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
-				 struct ieee80211_vif *vif,
-				 unsigned int link_id, u16 ac,
-				 const struct ieee80211_tx_queue_params *params)
+static int ath12k_mac_conf_tx(struct ath12k_vif *arvif,
+			      unsigned int link_id, u16 ac,
+			      const struct ieee80211_tx_queue_params *params)
 {
-	struct ath12k *ar = hw->priv;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct wmi_wmm_params_arg *p = NULL;
+	struct ath12k *ar = arvif->ar;
+	struct ath12k_base *ab = ar->ab;
 	int ret;
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_held(&ar->conf_mutex);
 
 	switch (ac) {
 	case IEEE80211_AC_VO:
@@ -4083,17 +4082,33 @@ static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
 	ret = ath12k_wmi_send_wmm_update_cmd(ar, arvif->vdev_id,
 					     &arvif->wmm_params);
 	if (ret) {
-		ath12k_warn(ar->ab, "failed to set wmm params: %d\n", ret);
+		ath12k_warn(ab, "pdev idx %d failed to set wmm params: %d\n",
+			    ar->pdev_idx, ret);
 		goto exit;
 	}
 
-	ret = ath12k_conf_tx_uapsd(ar, vif, ac, params->uapsd);
-
+	ret = ath12k_conf_tx_uapsd(arvif, ac, params->uapsd);
 	if (ret)
-		ath12k_warn(ar->ab, "failed to set sta uapsd: %d\n", ret);
+		ath12k_warn(ab, "pdev idx %d failed to set sta uapsd: %d\n",
+			    ar->pdev_idx, ret);
 
 exit:
+	return ret;
+}
+
+static int ath12k_mac_op_conf_tx(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 unsigned int link_id, u16 ac,
+				 const struct ieee80211_tx_queue_params *params)
+{
+	struct ath12k *ar = hw->priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+	ret = ath12k_mac_conf_tx(arvif, link_id, ac, params);
 	mutex_unlock(&ar->conf_mutex);
+
 	return ret;
 }
 
-- 
2.34.1



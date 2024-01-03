Return-Path: <linux-wireless+bounces-1428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE97C822876
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 07:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40783B22E5F
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 06:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B099F18059;
	Wed,  3 Jan 2024 06:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y2QQ9WsW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F1C18050
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4036MK07013687;
	Wed, 3 Jan 2024 06:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=7CCndLqV4SPfnzkM4mtvG4/Yj+XK3kF89EKJfkCjrKQ=; b=Y2
	QQ9WsWXTrl0jcbHsvTjQ/wURQnwqA44BxcZxF1eopYdGT8rDIhdg2Fg5hC7EPYRZ
	4+hRBjryelyyAbsROnYmM+Fsu7CYX+WhB1asmB5MKmeU6ttdKjmwpzatJnZpUbo4
	FMzKf2mesiyX0icCFh+vFcGL/9WexK+LpR5E3ZoL68i6qMH9pwxSlOs7gWb6PMkX
	aLGOIDcHx71t1bxzXQgMeCkVi3Bswr1d6Qee6Yqw01QEKcUO/IJVhqmIpI+DVpDk
	WpA7mgMICCX6NPWXq2dt1uFHU6r7v63ZUe07lPc2X4uHdkW13z26OiiIY5ezXlll
	msTeqM5aLHQIgq9SoLKg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vd27yg1e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 06:37:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4036buY6017698
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 06:37:56 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 2 Jan 2024 22:37:54 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 04/10] wifi: ath12k: Refactor mac callback of start
Date: Wed, 3 Jan 2024 12:07:25 +0530
Message-ID: <20240103063731.3356060-5-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: DzmMBCpnNhVIq4ldqksAsqSxw3EKNAxM
X-Proofpoint-ORIG-GUID: DzmMBCpnNhVIq4ldqksAsqSxw3EKNAxM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030053

To support single wiphy abstraction, introduce link/radio specific helper
function in the mac80211 callback start(). This way, the callback can be
extended to handle multiple link/radio in the future.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 31 ++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 66c758bddf48..31ed3d342741 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5081,14 +5081,12 @@ static void ath12k_mac_wait_reconfigure(struct ath12k_base *ab)
 				    ATH12K_RECONFIGURE_TIMEOUT_HZ);
 }
 
-static int ath12k_mac_op_start(struct ieee80211_hw *hw)
+static int ath12k_mac_start(struct ath12k *ar)
 {
-	struct ath12k *ar = hw->priv;
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_pdev *pdev = ar->pdev;
 	int ret;
 
-	ath12k_mac_drain_tx(ar);
 	mutex_lock(&ar->conf_mutex);
 
 	switch (ar->state) {
@@ -5111,14 +5109,14 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 					1, pdev->pdev_id);
 
 	if (ret) {
-		ath12k_err(ar->ab, "failed to enable PMF QOS: (%d\n", ret);
+		ath12k_err(ab, "failed to enable PMF QOS: (%d\n", ret);
 		goto err;
 	}
 
 	ret = ath12k_wmi_pdev_set_param(ar, WMI_PDEV_PARAM_DYNAMIC_BW, 1,
 					pdev->pdev_id);
 	if (ret) {
-		ath12k_err(ar->ab, "failed to enable dynamic bw: %d\n", ret);
+		ath12k_err(ab, "failed to enable dynamic bw: %d\n", ret);
 		goto err;
 	}
 
@@ -5148,7 +5146,7 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 					1, pdev->pdev_id);
 
 	if (ret) {
-		ath12k_err(ar->ab, "failed to enable MESH MCAST ENABLE: (%d\n", ret);
+		ath12k_err(ab, "failed to enable MESH MCAST ENABLE: (%d\n", ret);
 		goto err;
 	}
 
@@ -5174,7 +5172,7 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 	}
 
 	if (ret == -ENOTSUPP)
-		ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+		ath12k_dbg(ab, ATH12K_DBG_MAC,
 			   "monitor status config is not yet supported");
 
 	/* Configure the hash seed for hash based reo dest ring selection */
@@ -5196,7 +5194,6 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 			   &ab->pdevs[ar->pdev_idx]);
 
 	return 0;
-
 err:
 	ar->state = ATH12K_STATE_OFF;
 	mutex_unlock(&ar->conf_mutex);
@@ -5204,6 +5201,24 @@ static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 	return ret;
 }
 
+static int ath12k_mac_op_start(struct ieee80211_hw *hw)
+{
+	struct ath12k *ar = hw->priv;
+	struct ath12k_base *ab = ar->ab;
+	int ret;
+
+	ath12k_mac_drain_tx(ar);
+
+	ret = ath12k_mac_start(ar);
+	if (ret) {
+		ath12k_err(ab, "fail to start mac operations in pdev idx %d ret %d\n",
+			   ar->pdev_idx, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 int ath12k_mac_rfkill_config(struct ath12k *ar)
 {
 	struct ath12k_base *ab = ar->ab;
-- 
2.34.1



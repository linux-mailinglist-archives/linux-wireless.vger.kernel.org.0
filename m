Return-Path: <linux-wireless+bounces-1432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A5E82287A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 07:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75AC7B22D59
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 06:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47088182DF;
	Wed,  3 Jan 2024 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LYV102nO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E56182AA
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 06:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4036MLls013700;
	Wed, 3 Jan 2024 06:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=6mtgjMrHnorYxe7ayCJzySEgYbdMD5ryqzkqWuNmhR4=; b=LY
	V102nO9QddAKn91rv5B2DJskPWyAojh9qJvAiIIlWN+5tlmV0qZ4R0GVjzKLUCD+
	71qdi42Jzde5enR8QmAzetlYubBD95vpTqJcv5KaHF4GQIvErscNWQa4U+14BlCr
	zoHIETxejC7wyqTubCzUSvHF6w23Q0Dl0chxnOwKt6V/EK2vhaC/M0BehIKyGV6j
	2SwApXFF1FmUQ+NXJCBEZumrN1x6bBDZJnzsI1mUKggbO805vc9MA46OcHDmsRa/
	n9ng1byYkUd5B4bpMxdJyRuCdc1b4mj221DGkrnj1ufRva8ZB3JVrZIfLJj6U0QT
	PnwHEPES3deKHSlV8aiw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vd27yg1ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 06:38:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4036c4JK009960
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 06:38:04 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 2 Jan 2024 22:38:02 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 08/10] wifi: ath12k: Refactor mac callback of ampdu action
Date: Wed, 3 Jan 2024 12:07:29 +0530
Message-ID: <20240103063731.3356060-9-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: DetE6UMgI7S1FeesTy8_X4IokACohyux
X-Proofpoint-ORIG-GUID: DetE6UMgI7S1FeesTy8_X4IokACohyux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxlogscore=556 adultscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030053

To support single wiphy abstraction, introduce link/radio specific helper
function in the mac80211 callback ampdu_action(). This way, the callback
can be extended to handle multiple link/radio in the future.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 1566b43029cd..c505bac365f6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5901,14 +5901,13 @@ static int ath12k_mac_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx
 	return ret;
 }
 
-static int ath12k_mac_op_ampdu_action(struct ieee80211_hw *hw,
-				      struct ieee80211_vif *vif,
-				      struct ieee80211_ampdu_params *params)
+static int ath12k_mac_ampdu_action(struct ath12k_vif *arvif,
+				   struct ieee80211_ampdu_params *params)
 {
-	struct ath12k *ar = hw->priv;
+	struct ath12k *ar = arvif->ar;
 	int ret = -EINVAL;
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_held(&ar->conf_mutex);
 
 	switch (params->action) {
 	case IEEE80211_AMPDU_RX_START:
@@ -5929,8 +5928,25 @@ static int ath12k_mac_op_ampdu_action(struct ieee80211_hw *hw,
 		break;
 	}
 
+	return ret;
+}
+
+static int ath12k_mac_op_ampdu_action(struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_ampdu_params *params)
+{
+	struct ath12k *ar = hw->priv;
+	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	int ret = -EINVAL;
+
+	mutex_lock(&ar->conf_mutex);
+	ret = ath12k_mac_ampdu_action(arvif, params);
 	mutex_unlock(&ar->conf_mutex);
 
+	if (ret)
+		ath12k_warn(ar->ab, "pdev idx %d unable to perform ampdu action %d ret %d\n",
+			    ar->pdev_idx, params->action, ret);
+
 	return ret;
 }
 
-- 
2.34.1



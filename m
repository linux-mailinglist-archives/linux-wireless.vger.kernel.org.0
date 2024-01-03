Return-Path: <linux-wireless+bounces-1434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9375682287C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 07:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7851F223BC
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 06:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C520A18629;
	Wed,  3 Jan 2024 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mFz6svmn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB4418635
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 06:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4033wrZt028851;
	Wed, 3 Jan 2024 06:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=f6gTHbbt+D1TXWHItPU4W2QwHAZqa3tRzDPC/qx42LY=; b=mF
	z6svmnJcw+/Q6uQzeylApf7dgk7MROQM9a1m5B7C95YZKkni1+L7oJBbNSLjquLx
	wFYh0mVD3e5X76/vArF4zcj1YuJugKKyCdl/40y38klburNbCpZbhpnTRR3LC0D8
	T5ws682RUbJadHtHbu0Rj9NH2+uObahYIF9q+HIpp3KEyH99R/alG5ANUJaF+Ko/
	MTRUu9ZqAxN2Dq2lQVK6CSgFWc5uAo0dXgEKPqkCwfKykRE90AnwO81R7Igr9SAp
	QlsLaZdMIheCl38fIpHskn9hf66eg03QnCVxH4IG7hvvdNJHg1SJPfZo7zHYiw5G
	+mF9IzRNXMwwCz9HVYFw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vcvq5gt9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 06:38:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4036c7hZ018613
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 06:38:07 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 2 Jan 2024 22:38:06 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 10/10] wifi: ath12k: Refactor start vdev delay function
Date: Wed, 3 Jan 2024 12:07:31 +0530
Message-ID: <20240103063731.3356060-11-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: RtPuDGAdK0jQq9mzZR890P9VeiAa1T8f
X-Proofpoint-GUID: RtPuDGAdK0jQq9mzZR890P9VeiAa1T8f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=666 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030052

To support single wiphy abstraction, remove the mac80211 hw data
dependency from the start vdev delay function. This way, this
function can be extended to handle multiple link/radio in the future.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 84587c5782e6..d328f37dac92 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -241,8 +241,8 @@ static const u32 ath12k_smps_map[] = {
 	[WLAN_HT_CAP_SM_PS_DISABLED] = WMI_PEER_SMPS_PS_NONE,
 };
 
-static int ath12k_start_vdev_delay(struct ieee80211_hw *hw,
-				   struct ieee80211_vif *vif);
+static int ath12k_start_vdev_delay(struct ath12k *ar,
+				   struct ath12k_vif *arvif);
 
 static const char *ath12k_mac_phymode_str(enum wmi_phy_mode mode)
 {
@@ -3718,7 +3718,7 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 	if (ab->hw_params->vdev_start_delay &&
 	    !arvif->is_started &&
 	    arvif->vdev_type != WMI_VDEV_TYPE_AP) {
-		ret = ath12k_start_vdev_delay(ar->hw, vif);
+		ret = ath12k_start_vdev_delay(ar, arvif);
 		if (ret) {
 			ath12k_warn(ab, "failed to delay vdev start: %d\n", ret);
 			goto free_peer;
@@ -6411,12 +6411,11 @@ static void ath12k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 	mutex_unlock(&ar->conf_mutex);
 }
 
-static int ath12k_start_vdev_delay(struct ieee80211_hw *hw,
-				   struct ieee80211_vif *vif)
+static int ath12k_start_vdev_delay(struct ath12k *ar,
+				   struct ath12k_vif *arvif)
 {
-	struct ath12k *ar = hw->priv;
 	struct ath12k_base *ab = ar->ab;
-	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
+	struct ieee80211_vif *vif = arvif->vif;
 	int ret;
 
 	if (WARN_ON(arvif->is_started))
-- 
2.34.1



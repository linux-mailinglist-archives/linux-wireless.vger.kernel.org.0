Return-Path: <linux-wireless+bounces-15231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 533FA9C66F5
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 02:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF1A2840FF
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 01:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB38283CD3;
	Wed, 13 Nov 2024 01:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Syiqf0rn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3803F7E0E8
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731463016; cv=none; b=G4PunkOo0vWXv3xSuNjQyWfEGdKzKm4VjV06DZ6MzTlp4FIKiyWK+2lUmBWnKuU3m6Zq5zxUopiI4QHV6Fn4gHC+qklxR76Owy3OVbZ2jB748dBY6dk/ZmoWps7CLsvB6M+EX7yScydJgU6JvrLwiD/tIXvrpYJIn8oPZ7sN/cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731463016; c=relaxed/simple;
	bh=EoZOyrDiTv1SjeMO5f0r9CrtHmSPZiOya5wJmRbYWr8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=irN0/IxTmmvppRSGNXh1X33g6O1DZnWxn33+eH5odZ3DIU1a8et26BvnRorb5j2JawpIPUS1rmiLLz8DkHFc/uBr8rznAUh3USOjQ8P1bGv2CKXCUEAvyrd/vWGiHdH/Gnmx97LD5ZS9saemDUTPG6p41U1c2lqpUKE0SNBBcPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Syiqf0rn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACMRURh019976;
	Wed, 13 Nov 2024 01:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hdo54KNX6U9BaDxLyHu5BcLqMgjTZ9yLofe90SH96LI=; b=Syiqf0rn5DW44VIX
	K/TWjaiJ2VDf1ZeNbT/JmD7E2d3SIcOx7HsAlz56LKrsEuTIgV1oeJHAADukJHmT
	XQQntoAHDTFjorLHhqdgs99w0LjwQRcHr0drvNpplqI0Qyly6BcGOWyKlprcmqCI
	mapU7uLM6yWJz0pFolG8iOpOLEq4az96hr9Ub7ekdEbT+tlyK9KDI2Ofhuu3lPHW
	/QhmJG9sKEd/X7ldV0KauoB4L1xMskfiwa8AK/hwplcr5k31BclY92eP8sSyRKdk
	EaUdClLlzHua/JNNgt4z/PWtgOfK+eJK/+Iv1jzLebI+4Eqy1484ZBs98GHgE4KB
	MrtX0Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42uc60duf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 01:56:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AD1uonh028169
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 01:56:50 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 12 Nov 2024 17:56:49 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 5/6] wifi: ath11k: move locking outside of ath11k_mac_get_fw_stats()
Date: Wed, 13 Nov 2024 09:56:30 +0800
Message-ID: <20241113015631.3105-6-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241113015631.3105-1-quic_bqiang@quicinc.com>
References: <20241113015631.3105-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: 18iVTIzaqSCbj1m87ipQ5S0hZop2Sotq
X-Proofpoint-ORIG-GUID: 18iVTIzaqSCbj1m87ipQ5S0hZop2Sotq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130015

Currently ath11k_mac_get_fw_stats() is acquiring/releasing ar->conf_mutex by itself.
In order to reuse this function in a context where that lock is already taken, move
lock handling to its callers, then the function itself only has to assert it.

There is only one caller now, i.e., ath11k_mac_op_sta_statistics(), so add lock handling
there.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 318fd0bb6fe5..0ff430931bfd 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9007,12 +9007,10 @@ static int ath11k_mac_get_fw_stats(struct ath11k *ar, u32 pdev_id,
 	struct stats_request_params req_param;
 	int ret;
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_held(&ar->conf_mutex);
 
-	if (ar->state != ATH11K_STATE_ON) {
-		ret = -ENETDOWN;
-		goto err_unlock;
-	}
+	if (ar->state != ATH11K_STATE_ON)
+		return -ENETDOWN;
 
 	req_param.pdev_id = pdev_id;
 	req_param.vdev_id = vdev_id;
@@ -9026,9 +9024,6 @@ static int ath11k_mac_get_fw_stats(struct ath11k *ar, u32 pdev_id,
 		   "debug get fw stat pdev id %d vdev id %d stats id 0x%x\n",
 		   pdev_id, vdev_id, stats_id);
 
-err_unlock:
-	mutex_unlock(&ar->conf_mutex);
-
 	return ret;
 }
 
@@ -9066,6 +9061,7 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 
 	ath11k_mac_put_chain_rssi(sinfo, arsta, "ppdu", false);
 
+	mutex_lock(&ar->conf_mutex);
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL)) &&
 	    arsta->arvif->vdev_type == WMI_VDEV_TYPE_STA &&
 	    ar->ab->hw_params.supports_rssi_stats &&
@@ -9081,6 +9077,7 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	    !(ath11k_mac_get_fw_stats(ar, ar->pdev->pdev_id, 0,
 				      WMI_REQUEST_VDEV_STAT)))
 		signal = arsta->rssi_beacon;
+	mutex_unlock(&ar->conf_mutex);
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
 		   "sta statistics db2dbm %u rssi comb %d rssi beacon %d\n",
-- 
2.25.1



Return-Path: <linux-wireless+bounces-1431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC49822879
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 07:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E501F21A35
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 06:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27C0182D4;
	Wed,  3 Jan 2024 06:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KfZGCRSI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582C0182C7
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 06:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40343EGY030643;
	Wed, 3 Jan 2024 06:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=fhjN5vgS5tAzPN+Ji/o+3RZBLi5pvCp43QR1Ii0yfFQ=; b=Kf
	ZGCRSIiq0ExTKheG1dqGIrwk5JzfcV7wG33K+MEQL+1s8Blvk3zhjEykO+3U9v8q
	gsim0Y8+QpAMl9dySXAzhBb6Dpi54S5sA8TmAYGweqjqBMHw5flW2IeUHGRrDh/E
	qBw4wVlM3u6UdPVVIR7SqV/L/QCF6aR0EsNV8QKrGBufaiYMV+QIjXrO8dyRfxe2
	GJhQr1XIiXJjg8BwgCdtrMCZ16T5TnlB2DIfqTPcm2cru5rMlcoKTqi8jwoptIh4
	emIiokLxUTFmS6LBpXoOYjAq9CKeMxCihQhuPvEa2jAv2F6CQTzQODSXjh/uzO4q
	S8OY+vvNRoVDp2R+oukw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vcgkuab36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 06:38:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4036c2Gu017799
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 06:38:02 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 2 Jan 2024 22:38:00 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 07/10] wifi: ath12k: Refactor mac callback of configure filter
Date: Wed, 3 Jan 2024 12:07:28 +0530
Message-ID: <20240103063731.3356060-8-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: LP6eedxWnSwXBAWfQ6rx07jW1gW1keUa
X-Proofpoint-ORIG-GUID: LP6eedxWnSwXBAWfQ6rx07jW1gW1keUa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 mlxlogscore=729
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030053

To support single wiphy abstraction, introduce link/radio specific helper
function in the mac80211 callback configure_filter(). This way, the
callback can be extended to handle multiple link/radio in the future.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 28 ++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 5c7b747addda..1566b43029cd 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5831,19 +5831,15 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	FIF_PROBE_REQ |				\
 	FIF_FCSFAIL)
 
-static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
-					   unsigned int changed_flags,
-					   unsigned int *total_flags,
-					   u64 multicast)
+static void ath12k_mac_configure_filter(struct ath12k *ar,
+					unsigned int total_flags)
 {
-	struct ath12k *ar = hw->priv;
 	bool reset_flag;
 	int ret;
 
-	mutex_lock(&ar->conf_mutex);
+	lockdep_assert_held(&ar->conf_mutex);
 
-	*total_flags &= SUPPORTED_FILTERS;
-	ar->filter_flags = *total_flags;
+	ar->filter_flags = total_flags;
 
 	/* For monitor mode */
 	reset_flag = !(ar->filter_flags & FIF_BCN_PRBRESP_PROMISC);
@@ -5858,9 +5854,23 @@ static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
 		ath12k_warn(ar->ab,
 			    "fail to set monitor filter: %d\n", ret);
 	}
+
 	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
 		   "total_flags:0x%x, reset_flag:%d\n",
-		   *total_flags, reset_flag);
+		   total_flags, reset_flag);
+}
+
+static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
+					   unsigned int changed_flags,
+					   unsigned int *total_flags,
+					   u64 multicast)
+{
+	struct ath12k *ar = hw->priv;
+
+	mutex_lock(&ar->conf_mutex);
+
+	*total_flags &= SUPPORTED_FILTERS;
+	ath12k_mac_configure_filter(ar, *total_flags);
 
 	mutex_unlock(&ar->conf_mutex);
 }
-- 
2.34.1



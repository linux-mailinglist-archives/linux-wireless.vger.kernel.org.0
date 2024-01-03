Return-Path: <linux-wireless+bounces-1433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA8B82287B
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 07:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E291F21938
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 06:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A11818631;
	Wed,  3 Jan 2024 06:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FUXfKUJx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEE918629
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4034kCDc031155;
	Wed, 3 Jan 2024 06:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=iDHPcu06Vp/H7UGHAlf8EtJK34/JamD1tjpx9S1ZcDc=; b=FU
	XfKUJxkG5n8YWfttvvzwwnqiyLRIU37z+J1sxLNDowE2ox2tXnJ4lBbYGIgc4w0Y
	iSSs5lMaV/eecvADaT6m4rI0frGk2gKYrUnfDN1IdSxZCOITpwj+dnZ/kLTMYtp1
	3imwrDoPTckgzmLx/SKSBb5fFfb007VZmSKn8ChSJ+Cg7kF8U4ioxRZFBbvbEY7+
	SjTEBiZbhopZFdpM7illmRt4c/KZpKr4tomEwXzMOC0CMAUC1zr3VsiAAGqYb9J7
	Ea4VCYFaN2IVQxOf754mMCiYyurhsy6PIrxqB+atq9cE7D82XPPkrXgQgxOvbLmn
	+fJEL8jZ7jDpf8kz7Ong==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vcguba9vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 06:38:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4036c6bu009990
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 06:38:06 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 2 Jan 2024 22:38:04 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 09/10] wifi: ath12k: Refactor mac callback of flush
Date: Wed, 3 Jan 2024 12:07:30 +0530
Message-ID: <20240103063731.3356060-10-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: GUvqxIbPUFTKHQePngcbUG9TFzyjGd9i
X-Proofpoint-GUID: GUvqxIbPUFTKHQePngcbUG9TFzyjGd9i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=824 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030052

To support single wiphy abstraction, introduce link/radio specific helper
function in the mac80211 callback flush(). This way, the callback can be
extended to handle multiple link/radio in the future.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index c505bac365f6..84587c5782e6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6644,15 +6644,10 @@ static int ath12k_mac_op_set_frag_threshold(struct ieee80211_hw *hw, u32 value)
 	return -EOPNOTSUPP;
 }
 
-static void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-				u32 queues, bool drop)
+static void ath12k_mac_flush(struct ath12k *ar)
 {
-	struct ath12k *ar = hw->priv;
 	long time_left;
 
-	if (drop)
-		return;
-
 	time_left = wait_event_timeout(ar->dp.tx_empty_waitq,
 				       (atomic_read(&ar->dp.num_tx_pending) == 0),
 				       ATH12K_FLUSH_TIMEOUT);
@@ -6667,6 +6662,17 @@ static void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *v
 			    time_left);
 }
 
+static void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+				u32 queues, bool drop)
+{
+	struct ath12k *ar = hw->priv;
+
+	if (drop)
+		return;
+
+	ath12k_mac_flush(ar);
+}
+
 static int
 ath12k_mac_bitrate_mask_num_ht_rates(struct ath12k *ar,
 				     enum nl80211_band band,
-- 
2.34.1



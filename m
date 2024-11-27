Return-Path: <linux-wireless+bounces-15734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F229DA09C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 03:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E889B22B8C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 02:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7003E1BDE6;
	Wed, 27 Nov 2024 02:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XUdEDOXn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E7B8F5C
	for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2024 02:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732674489; cv=none; b=QkJSxhaSmLENQCzl/xSzmm1aRIRcDS6Joa2BGsouaF2ikUrzgTczEokufnhFtUBvMiqBZqsrbD8rPiscpgEkATtRwtVCd9Swe8Q4HJlPJo/21RmsJPLWo8tnaMN5Jp3aaFB9tBxiUD0R1QvEztxRVqGjsFVjaYfzm4GAw/JFFi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732674489; c=relaxed/simple;
	bh=lo//PJN0C6GCoKsuD5k8guqJGsWbtU1klMa4HM3z5cU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f8j4Xqeq3e7TwCHdvQJQLAOW/CLG84eukq4vyM7NYViJhDKHDuQyGRIDCUgxmVzHTrch1Ssl3rr+IRivjb1jVvtXVN36XmUJN4zC3PQFcJAAsCR3mKKX6+/mIo6cQtIUf0b5MsOlK99e65Rz/TwuKxlEcxgiC6o6Io/8X0s5ebI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XUdEDOXn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQKLXWf006763;
	Wed, 27 Nov 2024 02:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qC4SGT9DFDAwSW9hYNzONl
	YrXnRIro+hC0CFg7X7Ut4=; b=XUdEDOXnaBZi0dzNrXMrrKphAMssqgaVcwS6hG
	RipxkE2PG6QAy9rZBSuMuXL47Zcf2pHWSIrd5neq1fCeRo4GOKtv0zxnM1q6lgNY
	NumF8JTQvW6rPZHJBw3joTRyiAE2Q35ziSlpz0ShXXGLlCeDM2GtbZIcJOfds19n
	nnro5s8pJr+UKNg9Ib3Tx/TTWTDlro2A2CsI9qWiHYN5x7icLKjfMbrIyZ+PzsVj
	tLXbCgoCHQ9V92G9lJvhA60pXcD7WIIpqSvZ0QBGgOKjJT5ilbv7p22vtDcPrnlW
	QGRZkgg8Q/9aVvEQd0pLsnQ1hO/Z0a83Xx6gGsZuxx8OZ46w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 434ts1mwqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 02:27:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AR2RvqI001477
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 02:27:57 GMT
Received: from yuzha-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 26 Nov 2024 18:27:56 -0800
From: "Yu Zhang(Yuriy)" <quic_yuzha@quicinc.com>
To: <kvalo@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, Mihai Moldovan <ionic@ionic.de>
Subject: [PATCH v3] wifi: ath11k: support DBS and DFS compatibility
Date: Wed, 27 Nov 2024 10:27:42 +0800
Message-ID: <20241127022742.4016870-1-quic_yuzha@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: -Zk1Y3FxWH-qfoG1CbNRlGfqNFf8oDp_
X-Proofpoint-ORIG-GUID: -Zk1Y3FxWH-qfoG1CbNRlGfqNFf8oDp_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 impostorscore=0 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411270020

Now some chips which support 'support_dual_stations' will enable DBS,
but will disable DFS. Restructure the ath11k_mac_setup_iface_combinations
function to support DBS and DFS compatibility.

About 'support_dual_station' feature can refer:
https://msgid.link/20230714023801.2621802-2-quic_cjhuang@quicinc.com

Add a ieee80211_iface_combination to support DBS and DFS compatibility,
one combination can support DFS(same with non dual sta), another
combination can support DBS. When running different scenarios that will
use different ieee80211_iface_combination due to mac80211 will go through
all of possible interface combinations.

In addition, maximum number of interfaces of these types should be total
allowed in this group.

The chips affected are:

 QCA6390 hw2.0
 WCN6855 hw2.0
 WCN6855 hw2.1

Other chips are not affected.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-00410-QCAHKSWPL_SILICONZ-2
Tested-on: IPQ6018 hw1.0 AHB WLAN.HK.2.1.0.1-01161-QCAHKSWPL_SILICONZ-1
Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04402-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1.
Tested-by: Mihai Moldovan <ionic@ionic.de>
Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Yu Zhang(Yuriy) <quic_yuzha@quicinc.com>
---
v2:
 - Add tested-on IPQ8074 and IPQ6018.
v3:
 - Add tested-on QCA6390.  
---
 drivers/net/wireless/ath/ath11k/mac.c | 42 +++++++++++++++------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 31ae9b384a29..aa63f5e20f2b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9911,12 +9911,17 @@ static int ath11k_mac_setup_iface_combinations(struct ath11k *ar)
 	struct ath11k_base *ab = ar->ab;
 	struct ieee80211_iface_combination *combinations;
 	struct ieee80211_iface_limit *limits;
-	int n_limits;
+	int n_limits, n_combos;
 	bool p2p;
 
 	p2p = ab->hw_params.interface_modes & BIT(NL80211_IFTYPE_P2P_DEVICE);
 
-	combinations = kzalloc(sizeof(*combinations), GFP_KERNEL);
+	if (ab->hw_params.support_dual_stations)
+		n_combos = 2;
+	else
+		n_combos = 1;
+
+	combinations = kcalloc(n_combos, sizeof(*combinations), GFP_KERNEL);
 	if (!combinations)
 		return -ENOMEM;
 
@@ -9931,7 +9936,9 @@ static int ath11k_mac_setup_iface_combinations(struct ath11k *ar)
 		return -ENOMEM;
 	}
 
+	limits[0].max = 1;
 	limits[0].types |= BIT(NL80211_IFTYPE_STATION);
+	limits[1].max = 16;
 	limits[1].types |= BIT(NL80211_IFTYPE_AP);
 	if (IS_ENABLED(CONFIG_MAC80211_MESH) &&
 	    ab->hw_params.interface_modes & BIT(NL80211_IFTYPE_MESH_POINT))
@@ -9941,25 +9948,24 @@ static int ath11k_mac_setup_iface_combinations(struct ath11k *ar)
 	combinations[0].n_limits = n_limits;
 	combinations[0].beacon_int_infra_match = true;
 	combinations[0].beacon_int_min_gcd = 100;
+	combinations[0].max_interfaces = 16;
+	combinations[0].num_different_channels = 1;
+	combinations[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+						BIT(NL80211_CHAN_WIDTH_20) |
+						BIT(NL80211_CHAN_WIDTH_40) |
+						BIT(NL80211_CHAN_WIDTH_80) |
+						BIT(NL80211_CHAN_WIDTH_80P80) |
+						BIT(NL80211_CHAN_WIDTH_160);
 
 	if (ab->hw_params.support_dual_stations) {
 		limits[0].max = 2;
-		limits[1].max = 1;
-
-		combinations[0].max_interfaces = ab->hw_params.num_vdevs;
-		combinations[0].num_different_channels = 2;
-	} else {
-		limits[0].max = 1;
-		limits[1].max = 16;
 
-		combinations[0].max_interfaces = 16;
-		combinations[0].num_different_channels = 1;
-		combinations[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
-							BIT(NL80211_CHAN_WIDTH_20) |
-							BIT(NL80211_CHAN_WIDTH_40) |
-							BIT(NL80211_CHAN_WIDTH_80) |
-							BIT(NL80211_CHAN_WIDTH_80P80) |
-							BIT(NL80211_CHAN_WIDTH_160);
+		combinations[1].limits = limits;
+		combinations[1].n_limits = n_limits;
+		combinations[1].beacon_int_infra_match = true;
+		combinations[1].beacon_int_min_gcd = 100;
+		combinations[1].max_interfaces = ab->hw_params.num_vdevs;
+		combinations[1].num_different_channels = 2;
 	}
 
 	if (p2p) {
@@ -9970,7 +9976,7 @@ static int ath11k_mac_setup_iface_combinations(struct ath11k *ar)
 	}
 
 	ar->hw->wiphy->iface_combinations = combinations;
-	ar->hw->wiphy->n_iface_combinations = 1;
+	ar->hw->wiphy->n_iface_combinations = n_combos;
 
 	return 0;
 }
-- 
2.34.1



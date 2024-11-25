Return-Path: <linux-wireless+bounces-15683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E66B9D833E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 11:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D92FB220D0
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 10:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D079818E37D;
	Mon, 25 Nov 2024 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jxkzpA6b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2B415B97D
	for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732529131; cv=none; b=COPlmoPuKe5VTazMRZ7c8pwGLSjGqrrQ2AgtEEhxalrifSMKcwAw7DcW3TO4H996CfJyL3t26azn39ic7EL/bZ29EqBKz/vozvFam7G5Y6HGvgBNcnJX8EdhJeei0ZrwgO2wleZFnCoMO72NtZTyfr0uFWOvtvHIRg/4g5sEjWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732529131; c=relaxed/simple;
	bh=GlA1IgChmx3cFTJi9KpxqbHcgVOD5vUNLKrDjvBi6XI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z6AnpeSPEHjNZPqyeFr8zJ1pTLOPv3n2+slGRzNq6H8HLEc1KvXgsTOy08suB6oLv9YcN3QfsQ4jOb3XxU6DqtWjAYhjcnr+if3R07zIyMblfSO1B0S+nBT6ecgvp11wjmo/JTk//xrmZoj3wW2rtEAF07EYE/kU1hg+8FPVzso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jxkzpA6b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP7VmmF010664;
	Mon, 25 Nov 2024 10:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Ym9IGhVMBFeE/qWHJ4OPX/
	exJtvzF0mAWZpoTfRaIXk=; b=jxkzpA6bfd2JxWLaSe89TBbz6Ovjm54c1OgS9v
	Z5FvFnVlUGPOfN0EoHh240rsoDUbnLADyUnfyzFYZ+BxF1TAYzfjA191QRU4lqW9
	BgYh3vFFoFs5WcO1JQgpGcXrWlJm3tLEYIdRkKerhlr+gkEyb0qQIURa4Q+pt35M
	Y6PIcspjFE0lfVBa1ABcR4mt44/emrU2ciXC3er8yVuYxOLyvwnA3ZDVacUKiaqt
	B/8i4RdmP3fAgOeHI04lb39CqxNk97liHqpcbBref5hmsew+HaeequM/5L5HVEfQ
	HjPpXzt9FM0nIQ/qduDZcBFRnlFGs/2OI3Joqi9+2EgqKt9Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 434mx70e1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 10:05:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4APA5MqB028100
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 10:05:22 GMT
Received: from yuzha-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 25 Nov 2024 02:05:21 -0800
From: "Yu Zhang(Yuriy)" <quic_yuzha@quicinc.com>
To: <kvalo@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2] wifi: ath11k: support DBS and DFS compatibility
Date: Mon, 25 Nov 2024 18:05:08 +0800
Message-ID: <20241125100508.3458594-1-quic_yuzha@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FmzFNJNQlKtq5ccWGSJAvHS1wpTkhYhG
X-Proofpoint-ORIG-GUID: FmzFNJNQlKtq5ccWGSJAvHS1wpTkhYhG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxlogscore=966 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250086

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

Signed-off-by: Yu Zhang(Yuriy) <quic_yuzha@quicinc.com>
---
v2:

  - Add tested-on IPQ8074 and IPQ6018.
---
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



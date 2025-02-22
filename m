Return-Path: <linux-wireless+bounces-19317-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA17A40552
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2025 04:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9468D19C6E68
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2025 03:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99181200BB4;
	Sat, 22 Feb 2025 03:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W0ecHzf/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBE0201267
	for <linux-wireless@vger.kernel.org>; Sat, 22 Feb 2025 03:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740195042; cv=none; b=OfQFV4qxauAdZKyHLlYPlwL1s/IzGyGtWvqhRr01jvy+MX0D03NPJo4z+eULwxcFy7aHQzKW+GJX7vE51eKOeR1n1AxF4g3at64srlt7Nwv16wtHK+1rodcCdWaNNh9s0kKJn1uCdC7cJW2LmjYwLpFZe1s14fEAkXmXTPQxZLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740195042; c=relaxed/simple;
	bh=k3JiR9UrB07hMEfS6WC4nHtwiohXR7kZTTJHDy3Ed0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alCWvqJFfngYlh0jqY2OJ9PcFpVs92ZRi5db31de8UiLoxW9g797NOqhuFOZQX49FYpi7ymOvqMXp/bylXETVtoYa8R2aKefcoH7hnhy7B7UiAVmjkOUHmw7fgms4oR/FWp/EODtoI2t5f90lM/tMIflQeRSzog3Yfs+8GR58PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W0ecHzf/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LEXL0d020255;
	Sat, 22 Feb 2025 03:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/Cjymd7RFlnL3KaUcfMo+UlqcDBxY71O3yF4xGP22bU=; b=W0ecHzf/rQW1XCbl
	EFTj+l+HVjtrhxlHkXV8IYYK5Wz2bIDmC657VItCKVJZjkOKnUG1XDNO5tnrpXfS
	XEI+z+b6+7W2M/QIr0OxyRMNNMmUYK4/mJ9XhHwpX3uWO/Ce5P0/DhgQILhvNU9M
	BvyyLYNv+vakf5vknWxUPe+jQR5XuAy33Ok6gqfG8zBTcbBCJuP99ugwmkwZRvJI
	oxVPCd7WJbJ3nuP9inWkRztAu1X/uhfop2L1c6e8bQCqG6Ld0RhpLZ/Nz571Yr3f
	Z+rN8bdREeWoo4JPcQJw5PvkwGMcmGbXuFZUMqCIbdwymFGnCPLP6qzsDoNTJgM6
	16BqaA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44x06t6fbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 03:30:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51M3UcvE021579
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 03:30:38 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 21 Feb 2025 19:30:36 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v7 8/9] wifi: ath12k: Refactor the monitor channel context procedure
Date: Sat, 22 Feb 2025 09:00:01 +0530
Message-ID: <20250222033002.3886215-9-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250222033002.3886215-1-quic_periyasa@quicinc.com>
References: <20250222033002.3886215-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: H70bZqBynNfaPsOa91uq7P26MHAIXSOH
X-Proofpoint-GUID: H70bZqBynNfaPsOa91uq7P26MHAIXSOH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_01,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 mlxlogscore=783 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502220025

Currently, the monitor start procedure use the iteration callback to pick
the last available channel definition in the mac80211 hardware. This
approach is incorrect for the single wiphy model, as it holds multiple
radio/link channel contexts within the same mac80211 hardware. To fix this,
change the iteration callback to pick the specific channel context for the
given radio/link. This approach makes the monitor start procedure
compatible with both multi wiphy and single wiphy models.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index c0e50cc5c024..54af9cbbf7cb 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1323,19 +1323,9 @@ static int ath12k_mac_monitor_vdev_delete(struct ath12k *ar)
 	return ret;
 }
 
-static void
-ath12k_mac_get_any_chandef_iter(struct ieee80211_hw *hw,
-				struct ieee80211_chanctx_conf *conf,
-				void *data)
-{
-	struct cfg80211_chan_def **def = data;
-
-	*def = &conf->def;
-}
-
 static int ath12k_mac_monitor_start(struct ath12k *ar)
 {
-	struct cfg80211_chan_def *chandef = NULL;
+	struct ath12k_mac_get_any_chanctx_conf_arg arg;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -1343,13 +1333,16 @@ static int ath12k_mac_monitor_start(struct ath12k *ar)
 	if (ar->monitor_started)
 		return 0;
 
+	arg.ar = ar;
+	arg.chanctx_conf = NULL;
 	ieee80211_iter_chan_contexts_atomic(ath12k_ar_to_hw(ar),
-					    ath12k_mac_get_any_chandef_iter,
-					    &chandef);
-	if (!chandef)
+					    ath12k_mac_get_any_chanctx_conf_iter,
+					    &arg);
+	if (!arg.chanctx_conf)
 		return 0;
 
-	ret = ath12k_mac_monitor_vdev_start(ar, ar->monitor_vdev_id, chandef);
+	ret = ath12k_mac_monitor_vdev_start(ar, ar->monitor_vdev_id,
+					    &arg.chanctx_conf->def);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to start monitor vdev: %d\n", ret);
 		ath12k_mac_monitor_vdev_delete(ar);
-- 
2.34.1



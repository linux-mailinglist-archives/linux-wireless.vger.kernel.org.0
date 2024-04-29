Return-Path: <linux-wireless+bounces-6983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9BB8B5721
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 13:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23B428703B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 11:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90744DA19;
	Mon, 29 Apr 2024 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f8KnqEL/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4635B4D5AC
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714391423; cv=none; b=DtTYsZfTQhxGnuAue55R0kJBs76+98t2NzYxh7yzSikKjo8C0YWYBxq7ImKWgB4YqThz1cijYt33hVujoyfsWkQtN3PUENTz7XIFftjc8rEJiLTC1rKZuzKyKwkOs6hTQDps7Ue+sGR/bgCCPrEhOz+i0e0caz4mBvFEdYz8X7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714391423; c=relaxed/simple;
	bh=hsDtPcmUMg+fYxd+lTeMEdulBCzYLSxIP8WlWFFtKb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQO+2jKd/jnw9yICCBETwseTxwT+W9Ns1by4qCdxkedSOw/2xErE6ocDRzaxVo4D1uQRGJpiMjzri0pJ50/Iq+OyvXp/jFW7Y5TYON5TXPQ9u5sNCkpAF0UTbwNi+xhP7sq823PAKxEQNj/VrPbD1qGtlVLXJ06NJVqXLwQZrfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f8KnqEL/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TAPSgd014163;
	Mon, 29 Apr 2024 11:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=EJpLVNgj7+kIsFsk6UDnZCXHiR4+OXOMHwvxr+xzguo=; b=f8
	KnqEL/W1SrjiWoL0PiqZylJvTDSubtuFi4cBMC3rVqijdLAEXO+b4JTxTRnStqr5
	Tg05J2jAXdwfY9A3FvlMwtBhY99ltIOkwX1SoHUhKXbcPHifXjxyZ5eIVRyHJgIK
	tqSTp3SjW41TbS4IvOgu7jG4beUOvAGN1GEeFxC6NoGMCOyTeSYWHL6schIFoa+p
	TJHog8DvhKuMMry1xonQQbtk1pKuzFA2DR1xtcMA1j9cjCXYfx8TiKNO1ljm713R
	nUoUO+m193LET+xO34R8MOptALwmINyKpZYJ+fpJ/kJWLrhvSTz0a5YcrE5/SSpP
	cglACM/kMsp+LT8uhj8A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrt4kujh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 11:50:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43TBnZEi006572
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 11:49:35 GMT
Received: from hu-kathirve-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 04:49:33 -0700
From: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sven Eckelmann <sven@narfation.org>,
        Sarika Sharma <quic_sarishar@quicinc.com>,
        Karthikeyan Kathirvel
	<quic_kathirve@quicinc.com>
Subject: [PATCH v3 1/2] wifi: ath12k: Don't drop tx_status in failure case
Date: Mon, 29 Apr 2024 17:18:39 +0530
Message-ID: <20240429114841.413901-2-quic_kathirve@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429114841.413901-1-quic_kathirve@quicinc.com>
References: <20240429114841.413901-1-quic_kathirve@quicinc.com>
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
X-Proofpoint-GUID: t5KCnv3HWUYK9UWRr98JJ5qIVdJpCwc6
X-Proofpoint-ORIG-GUID: t5KCnv3HWUYK9UWRr98JJ5qIVdJpCwc6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_08,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290075

From: Sven Eckelmann <sven@narfation.org>

When a station idles for a long time, hostapd will try to send
a QoS Null frame to the station as "poll". NL80211_CMD_PROBE_CLIENT
is used for this purpose.
And the skb will be added to ack_status_frame - waiting for a
completion via ieee80211_report_ack_skb().

But when the peer was already removed before the tx_complete arrives,
the peer will be missing. And when using dev_kfree_skb_any (instead
of going through mac80211), the entry will stay inside
ack_status_frames thus not clean up related information in its
internal data structures. This IDR will therefore run full after
8K request were generated for such clients.
At this point, the access point will then just stall and not allow
any new clients because idr_alloc() for ack_status_frame will fail.

ieee80211_free_txskb() on the other hand will (when required) call
ieee80211_report_ack_skb() and make sure that (when required) remove
the entry from the ack_status_frame and clean up related
information in its internal data structures.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Link: https://lore.kernel.org/r/20230802-ath11k-ack_status_leak-v2-1-c0af729d6229@narfation.org
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 9b6d7d72f57c..6a387f1f9567 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -448,6 +448,7 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 				       struct hal_tx_status *ts)
 {
 	struct ath12k_base *ab = ar->ab;
+	struct ath12k_hw *ah = ar->ah;
 	struct ieee80211_tx_info *info;
 	struct ath12k_skb_cb *skb_cb;
 
@@ -466,12 +467,12 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	rcu_read_lock();
 
 	if (!rcu_dereference(ab->pdevs_active[ar->pdev_idx])) {
-		dev_kfree_skb_any(msdu);
+		ieee80211_free_txskb(ah->hw, msdu);
 		goto exit;
 	}
 
 	if (!skb_cb->vif) {
-		dev_kfree_skb_any(msdu);
+		ieee80211_free_txskb(ah->hw, msdu);
 		goto exit;
 	}
 
-- 
2.34.1



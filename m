Return-Path: <linux-wireless+bounces-24650-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4D5AED550
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 09:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73EE1898048
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 07:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA29F1E5B6A;
	Mon, 30 Jun 2025 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B4C7NA8n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A060521421D
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 07:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751267545; cv=none; b=oBZ2Vbr+1noq1rdRIum3bI6pp0/3Pv8dvyZWlQ1oSxi8nvReaOfTKzzhfhyh/9THJT6K+4YqpHR62P89zv9RBpb7Y+o1M5iO530NzFlnas7xbk/ZF3deYSe/cpzVyAVLzFKQoXUvr9IiN6xl8SPP2ZR4ELcv8LQ/9fm1zgiXLes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751267545; c=relaxed/simple;
	bh=vPrFs2XHTw1luB8sKJ4OOmc4thvhqwtTH5ZaD6Jk49I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g582Y1JIgS5gnu5gpCi5b4ZIF8HtKcfFBLRwG2n0aERh2CGYP7v3K3l8vd0JyVYfPORlJjjWctZmlW6PxIou1ZaSKb6sJhEF9LI1klmA8sL1BbmpXjrzcPGkGQPGY5zGxjKtBKas1j3txwTul5qQ3Gs/N5Zpa+u/rYAetrgpKuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B4C7NA8n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TNoRL7012946;
	Mon, 30 Jun 2025 07:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ulT/Nqfbytz71cdnz+Y/4xe8c9g5ccEFbDzWFeRuMKI=; b=B4C7NA8nXWG57ssG
	j0Lg29hVsT9IJIfgrk/Sl9/rsl+TmpYf542xciuq5jgWAhRdfImpeU3/bKFS/whM
	e1ELN2jqeO9XHUrwZzMAd9BPVjRkt9ZQ+6JCtfrxMQYWsN8Fp+z9LJ3SZF1BeSPL
	GcXWkT7Rm6eMGJjFULo7jt5jqQbPjK3sGK0qfarH34e444LQ144zejEJdF1Z6+qV
	5vwDrFUYeiFu6bjqFfR82aBJchaH9kwd4uzCap72+UdkqBK3JNmY4Dzy/d52KRn9
	5m6gu1iI4hdm7sCL7xL46iUEl3TtnzCTJfLQI/T74lM2zPWymj2YRhmH8ZJs7iSg
	aO11sw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j7bvkrru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 07:12:20 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55U7CK0S009632
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 07:12:20 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 00:12:18 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH ath-next v7 1/5] wifi: ath12k: fill link station statistics for MLO
Date: Mon, 30 Jun 2025 12:41:10 +0530
Message-ID: <20250630071114.3474672-2-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630071114.3474672-1-quic_sarishar@quicinc.com>
References: <20250630071114.3474672-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5SzwztOO0K9-_rm5GalVPuPJ7eizLkEN
X-Authority-Analysis: v=2.4 cv=RJCzH5i+ c=1 sm=1 tr=0 ts=686238d4 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=pS3n3Mt4l41vp9au72QA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 5SzwztOO0K9-_rm5GalVPuPJ7eizLkEN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA1OCBTYWx0ZWRfX0n07VJKD74Ou
 lj1f59fHMVE8vmBB9XNftjEwzVLTmb1eFtOASK5V6xWAK9kwSeiIAkVogHCf2j0O87Ois2Cm8KC
 08nr7w2q3T2RdFr0uIshJBZPDbEbTMVMowXC1LWUOJ97UZH11lLu/ulOt8mYr+1tCL5GRh8TsC3
 VFxjvC2pc6lsuwYBIEU/StRnE6LaAqaEV3gB/gDLKgE/myar+h0WESdGGsbmTC1V6+1k/wgA/wl
 Im2tkj3hrKaVZM8Lni0zFWsQ90517YZN2OY9D5xj0V+r6HZ7sKrC2hQ8HUMxUGpeA3Sret3LK5Z
 e4HCCMl/ocecz8gn63zieg+HzujgMKS6BGMflfH/IgVeHiI5/AbRuSWxhC4b+LThyydooDhfZ50
 Z+sIxswQc3KDVekbXkPl66wqm1jB86pXRBhMMFKeY+afdtQS0fEScji3PZc4I1yUpJwQ6DYt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300058

Introduce ath12k_mac_op_link_sta_statistics(), to report link level
station statistics for MLO. The link_station_info structure is filled
from arsta and arsta is fetch from corresponding ahsta->link[link_id].

Therefore, this will be helpful to check the link related statistics.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 78 +++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 71e07c546a2d..8aa74c9171f8 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11686,6 +11686,83 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
 }
 
+static void ath12k_mac_op_link_sta_statistics(struct ieee80211_hw *hw,
+					      struct ieee80211_vif *vif,
+					      struct ieee80211_link_sta *link_sta,
+					      struct link_station_info *link_sinfo)
+{
+	struct ath12k_sta *ahsta = ath12k_sta_to_ahsta(link_sta->sta);
+	struct ath12k_fw_stats_req_params params = {};
+	struct ath12k_link_sta *arsta;
+	struct ath12k *ar;
+	s8 signal;
+	bool db2dbm;
+
+	lockdep_assert_wiphy(hw->wiphy);
+
+	arsta = wiphy_dereference(hw->wiphy, ahsta->link[link_sta->link_id]);
+
+	if (!arsta)
+		return;
+
+	ar = ath12k_get_ar_by_vif(hw, vif, arsta->link_id);
+	if (!ar)
+		return;
+
+	db2dbm = test_bit(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT,
+			  ar->ab->wmi_ab.svc_map);
+
+	link_sinfo->rx_duration = arsta->rx_duration;
+	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
+
+	link_sinfo->tx_duration = arsta->tx_duration;
+	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_DURATION);
+
+	if (arsta->txrate.legacy || arsta->txrate.nss) {
+		if (arsta->txrate.legacy) {
+			link_sinfo->txrate.legacy = arsta->txrate.legacy;
+		} else {
+			link_sinfo->txrate.mcs = arsta->txrate.mcs;
+			link_sinfo->txrate.nss = arsta->txrate.nss;
+			link_sinfo->txrate.bw = arsta->txrate.bw;
+			link_sinfo->txrate.he_gi = arsta->txrate.he_gi;
+			link_sinfo->txrate.he_dcm = arsta->txrate.he_dcm;
+			link_sinfo->txrate.he_ru_alloc =
+				arsta->txrate.he_ru_alloc;
+			link_sinfo->txrate.eht_gi = arsta->txrate.eht_gi;
+			link_sinfo->txrate.eht_ru_alloc =
+				arsta->txrate.eht_ru_alloc;
+		}
+		link_sinfo->txrate.flags = arsta->txrate.flags;
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+	}
+
+	/* TODO: Use real NF instead of default one. */
+	signal = arsta->rssi_comb;
+
+	params.pdev_id = ar->pdev->pdev_id;
+	params.vdev_id = 0;
+	params.stats_id = WMI_REQUEST_VDEV_STAT;
+
+	if (!signal &&
+	    ahsta->ahvif->vdev_type == WMI_VDEV_TYPE_STA &&
+	    !(ath12k_mac_get_fw_stats(ar, &params)))
+		signal = arsta->rssi_beacon;
+
+	if (signal) {
+		link_sinfo->signal =
+			db2dbm ? signal : signal + ATH12K_DEFAULT_NOISE_FLOOR;
+		link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+	}
+
+	link_sinfo->signal_avg = ewma_avg_rssi_read(&arsta->avg_rssi);
+
+	if (!db2dbm)
+		link_sinfo->signal_avg += ATH12K_DEFAULT_NOISE_FLOOR;
+
+	link_sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
+}
+
 static int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
 						  struct ieee80211_vif *vif)
 {
@@ -11921,6 +11998,7 @@ static const struct ieee80211_ops ath12k_ops = {
 	.get_survey			= ath12k_mac_op_get_survey,
 	.flush				= ath12k_mac_op_flush,
 	.sta_statistics			= ath12k_mac_op_sta_statistics,
+	.link_sta_statistics		= ath12k_mac_op_link_sta_statistics,
 	.remain_on_channel              = ath12k_mac_op_remain_on_channel,
 	.cancel_remain_on_channel       = ath12k_mac_op_cancel_remain_on_channel,
 	.change_sta_links               = ath12k_mac_op_change_sta_links,
-- 
2.34.1



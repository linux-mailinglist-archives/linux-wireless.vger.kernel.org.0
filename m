Return-Path: <linux-wireless+bounces-24624-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2557AEBDF0
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 18:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513E76A0C69
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 16:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FF62EA744;
	Fri, 27 Jun 2025 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pvdZEkT+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE69EEDE
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751043555; cv=none; b=iIHOj5hLT5SJFrW8J0j9ll5OxbHQMjR4kRpprRZBq8g9GPn1uERSKoc8tWWG8UjGBeWm1yBdJmFG8GYDTQpBJCPsQgTtt4R6Kb7/SUApqU3ap4pU6lEXcRWdhohcwNa71YQvifP8kC1VzdEhPDZSLISvYA/b03F/LfbcqWn+Mao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751043555; c=relaxed/simple;
	bh=+v+yk0NQy+KsWAcfKL98rkZWMUkON3Onkua1OmIP7CQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdcG+dR0vhPtBZA31Joq3wazqQJiFRU2lgdHBsJw4WZc40RQZqlPkGvE+Do2hz8xy7ULcR5Oi7Hv+CY7pzBDV19H7RinQaZ0UUFtoPkNcwRQJnPke/h5NhwM6AHMiSPtDBV/pUMebPyvtPcCocC1rGMF4xca0ywiRhajLBGVtpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pvdZEkT+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RBVXqn028766;
	Fri, 27 Jun 2025 16:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IMX5iqv49jmVH6zQwpJ08384zI60U8x4L5xRLE5vCTY=; b=pvdZEkT+De6rFxHL
	pzcEYWiUDxU8z/c1ydF/rTcdJbS+hVngUsxmmgCFbfqPw9vEkd85yncdlSABIMaF
	I4odjeYaF35Mhecqjkivjw5fF2UsBP1I7zQJickPI/AtwVpAfU79NK0KlLyCLFiN
	GTG2jBWsGGck/utnzzUKPwZ8zSYMF8fIstdlwk6NBckcuOLHpB8KmE7M5FDMoxvv
	sd41Aln4ZxG87acjecSXKEqe816XoEx3JKhldiihfYrokFN1H2xtD6dbGY8egX+X
	+ThW6b2070jA+Z+8OpMCse0XzZO2pjV682MB0Yd9fS0xHSS6mjxOItXd5PeVoAbH
	b87Wrg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47hkpbj73w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 16:59:09 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55RGx8KS023882
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 16:59:08 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 27 Jun 2025 09:59:07 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH ath-next v6 1/5] wifi: ath12k: fill link station statistics for MLO
Date: Fri, 27 Jun 2025 22:28:44 +0530
Message-ID: <20250627165848.3178339-2-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627165848.3178339-1-quic_sarishar@quicinc.com>
References: <20250627165848.3178339-1-quic_sarishar@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEzNyBTYWx0ZWRfX1QItwoIEc6cI
 Hx1mf7VQ/f/jL4CXWMW+qsAgQdgCNnyare9q8AIQ1kJpIffg45bQNKAi2kt5kL1lk62TsWbfPrU
 xehtshORQntWSD8KpO1T3iedsqgAITzGSXma2/DYyh530xlBW7aFt1gFihrtTT9APx5IO8+aGu5
 REKJigpK0Vao7e8qdaviHm2bLfGRTz6mDc1nspHRXQCB1KGqc6lDIS7L8YIPMAZImXiNJcRh6Rr
 yWfUpIpc9fMi2wJM6AGafLCmzm7SMjkR9Jw1amedicSePIzNpN3Dz6KMLvbwcuiwhFq7HNgah3d
 0ucJM18i8K6h4JXmSBIkNzeY2qHJOZ4VkH+2/NsrVf+INVI3balfRtTBCxSZIu8+OsJakBKeDyf
 1JKfJk9ZHnvPlvifDZwyzxTziwafGj6A8iCokOMdXLmPu5VtfpndWs1j5jmKq0Dfu9f/l7oT
X-Proofpoint-GUID: 0YUEww5tkoMwxD8GK5JyWZVTFPJKeVGX
X-Authority-Analysis: v=2.4 cv=AY2xH2XG c=1 sm=1 tr=0 ts=685ecddd cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=pS3n3Mt4l41vp9au72QA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 0YUEww5tkoMwxD8GK5JyWZVTFPJKeVGX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270137

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
index 32519666632d..ec03d4470085 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11652,6 +11652,83 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
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
@@ -11887,6 +11964,7 @@ static const struct ieee80211_ops ath12k_ops = {
 	.get_survey			= ath12k_mac_op_get_survey,
 	.flush				= ath12k_mac_op_flush,
 	.sta_statistics			= ath12k_mac_op_sta_statistics,
+	.link_sta_statistics		= ath12k_mac_op_link_sta_statistics,
 	.remain_on_channel              = ath12k_mac_op_remain_on_channel,
 	.cancel_remain_on_channel       = ath12k_mac_op_cancel_remain_on_channel,
 	.change_sta_links               = ath12k_mac_op_change_sta_links,
-- 
2.34.1



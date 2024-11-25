Return-Path: <linux-wireless+bounces-15682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391F49D7CF3
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 09:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3F416351F
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 08:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C5E2A1BA;
	Mon, 25 Nov 2024 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YIwcXJB1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0245E18BB8E
	for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523575; cv=none; b=DxvCDCm4YetxgRvjAQRjtAQX09L/dVuHlZNplLPETqo9cKMUA/BElFkWFmEuuViCoSeX0zWFm+ar3oeMKFoejNlfrJVTlTliQ86tfpRtTK6k2fNkGk1H0h0iANxE1Qq8rFcY6q8hDNUliCBPHMEgTHkG0LYsNNgYeUOVX8BL6h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523575; c=relaxed/simple;
	bh=9KY8yIZmw2zdbJ+A4Hwwb2PWRE3fe6Lp7jEOwkCvbIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJ/D8i7ozLhkpxDyodzYiwEFzytrQVjTlVf50/0X2/LhB2COnQuBvCiwu0ixgkyPjLI50416uzhARGOVKoNjiaibzWQqnPxVM0e5kbGcZNiHcNaZSzJ3LPvPo7Wjzi02HZzKW1S+bA+byyiRhzSC9Umb5lMbh1iNu9eBgBeqwK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YIwcXJB1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AONVSEd027636;
	Mon, 25 Nov 2024 08:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U3IcVk26OvuOS1UjsufSsm39gadT+VRmd8Eob8V9Iyw=; b=YIwcXJB1MGEDrsH9
	Fq5kRfFaIML4/De98mhmVNH6/clDLy41w+yo0yD5JOWY7W7U4YULVe4Cs/ac3mbe
	hHXybDnKWb+OiPZOHGpfQY13+yN1jGmx9InEOTN5jdx1lQbz1trV4ptVNQS8ZFox
	oMesTt6egcd/ezgOvumegBua1cvmHxWho5y4xY6H5PYb/JK44el7jEBG2We45KcO
	pAI7C0NmfVWMBnLkmq2iBhSSe5echg6heS+MX12gKv/I2tDQ61hxYD6jdiprz+G5
	asEss3wT11AOEIRplz4qyOuaJI4bnwjit64+89JtE8L3CF5v4AOtj+f97CaLbg+6
	B0teHA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4338b8bv06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 08:32:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AP8Wn0J008648
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 08:32:49 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 25 Nov 2024 00:32:46 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>,
        Aaradhana Sahu <quic_aarasahu@quicinc.com>
Subject: [PATCH 2/2] wifi: mac80211: get tx power per link
Date: Mon, 25 Nov 2024 14:02:17 +0530
Message-ID: <20241125083217.216095-3-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125083217.216095-1-quic_ramess@quicinc.com>
References: <20241125083217.216095-1-quic_ramess@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 1VG198pRzAp4NcRmn9RLql3xmi1vdVfz
X-Proofpoint-GUID: 1VG198pRzAp4NcRmn9RLql3xmi1vdVfz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=975 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250072

ML interfaces can have multiple affiliated links to it and
hence there is a need to report tx power of specified link
rather deflink.

Add changes to report tx power of requested link from mac80211,
also pass link id as an argument in get_tx_power op so that supported
drivers can use it to report link's tx power.

Co-developed-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c         |  1 +
 drivers/net/wireless/ath/ath9k/main.c         |  2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
 include/net/mac80211.h                        |  2 +-
 net/mac80211/cfg.c                            | 15 +++++++++++----
 net/mac80211/driver-ops.h                     |  7 ++++---
 net/mac80211/trace.h                          | 10 ++++++----
 8 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index e6acbff06749..7e75a9b13ef9 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9356,6 +9356,7 @@ static int ath11k_fw_stats_request(struct ath11k *ar,
 
 static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
+				     unsigned int link_id,
 				     int *dbm)
 {
 	struct ath11k *ar = hw->priv;
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index b92c89dad8de..2f137856a823 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -2767,7 +2767,7 @@ void ath9k_fill_chanctx_ops(void)
 #endif
 
 static int ath9k_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			     int *dbm)
+			     unsigned int link_id, int *dbm)
 {
 	struct ath_softc *sc = hw->priv;
 	struct ath_vif *avp = (void *)vif->drv_priv;
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 9d5561f44134..7fbce5e757df 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1596,7 +1596,7 @@ void mt76_wcid_cleanup(struct mt76_dev *dev, struct mt76_wcid *wcid)
 EXPORT_SYMBOL_GPL(mt76_wcid_cleanup);
 
 int mt76_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		     int *dbm)
+		     unsigned int link_id, int *dbm)
 {
 	struct mt76_phy *phy = hw->priv;
 	int n_chains = hweight16(phy->chainmask);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 0b75a45ad2e8..ca2dba3ac65d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1431,7 +1431,7 @@ void mt76_sta_pre_rcu_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 int mt76_get_min_avg_rssi(struct mt76_dev *dev, bool ext_phy);
 
 int mt76_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		     int *dbm);
+		     unsigned int link_id, int *dbm);
 int mt76_init_sar_power(struct ieee80211_hw *hw,
 			const struct cfg80211_sar_specs *sar);
 int mt76_get_sar_power(struct mt76_phy *phy,
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index a97c9f85ae9a..5ce4dfa3fba5 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4759,7 +4759,7 @@ struct ieee80211_ops {
 	u32 (*get_expected_throughput)(struct ieee80211_hw *hw,
 				       struct ieee80211_sta *sta);
 	int (*get_txpower)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			   int *dbm);
+			   unsigned int link_id, int *dbm);
 
 	int (*tdls_channel_switch)(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b2410a913556..2fa594fb6c1a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3195,15 +3195,22 @@ static int ieee80211_get_tx_power(struct wiphy *wiphy,
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
+	struct ieee80211_link_data *link_data;
 
 	if (local->ops->get_txpower &&
 	    (sdata->flags & IEEE80211_SDATA_IN_DRIVER))
-		return drv_get_txpower(local, sdata, dbm);
+		return drv_get_txpower(local, sdata, link_id, dbm);
 
-	if (local->emulate_chanctx)
+	if (local->emulate_chanctx) {
 		*dbm = local->hw.conf.power_level;
-	else
-		*dbm = sdata->vif.bss_conf.txpower;
+	} else {
+		link_data = wiphy_dereference(wiphy, sdata->link[link_id]);
+
+		if (link_data)
+			*dbm = link_data->conf->txpower;
+		else
+			return -ENOLINK;
+	}
 
 	/* INT_MIN indicates no power level was set yet */
 	if (*dbm == INT_MIN)
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index edd1e4d4ad9d..c64531e0a60e 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1273,7 +1273,8 @@ static inline u32 drv_get_expected_throughput(struct ieee80211_local *local,
 }
 
 static inline int drv_get_txpower(struct ieee80211_local *local,
-				  struct ieee80211_sub_if_data *sdata, int *dbm)
+				  struct ieee80211_sub_if_data *sdata,
+				  unsigned int link_id, int *dbm)
 {
 	int ret;
 
@@ -1283,8 +1284,8 @@ static inline int drv_get_txpower(struct ieee80211_local *local,
 	if (!local->ops->get_txpower)
 		return -EOPNOTSUPP;
 
-	ret = local->ops->get_txpower(&local->hw, &sdata->vif, dbm);
-	trace_drv_get_txpower(local, sdata, *dbm, ret);
+	ret = local->ops->get_txpower(&local->hw, &sdata->vif, link_id, dbm);
+	trace_drv_get_txpower(local, sdata, link_id, *dbm, ret);
 
 	return ret;
 }
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 7a4985fc2b16..dc35fed7e9b0 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -2173,13 +2173,14 @@ DEFINE_EVENT(chanswitch_evt, drv_channel_switch_rx_beacon,
 TRACE_EVENT(drv_get_txpower,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
-		 int dbm, int ret),
+		 unsigned int link_id, int dbm, int ret),
 
-	TP_ARGS(local, sdata, dbm, ret),
+	TP_ARGS(local, sdata, link_id, dbm, ret),
 
 	TP_STRUCT__entry(
 		LOCAL_ENTRY
 		VIF_ENTRY
+		__field(unsigned int, link_id)
 		__field(int, dbm)
 		__field(int, ret)
 	),
@@ -2187,13 +2188,14 @@ TRACE_EVENT(drv_get_txpower,
 	TP_fast_assign(
 		LOCAL_ASSIGN;
 		VIF_ASSIGN;
+		__entry->link_id = link_id;
 		__entry->dbm = dbm;
 		__entry->ret = ret;
 	),
 
 	TP_printk(
-		LOCAL_PR_FMT VIF_PR_FMT " dbm:%d ret:%d",
-		LOCAL_PR_ARG, VIF_PR_ARG, __entry->dbm, __entry->ret
+		LOCAL_PR_FMT VIF_PR_FMT " link_id:%d dbm:%d ret:%d",
+		LOCAL_PR_ARG, VIF_PR_ARG, __entry->link_id, __entry->dbm, __entry->ret
 	)
 );
 
-- 
2.34.1



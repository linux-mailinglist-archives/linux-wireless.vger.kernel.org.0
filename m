Return-Path: <linux-wireless+bounces-34995-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JAUGGag5WkqmQEAu9opvQ
	(envelope-from <linux-wireless+bounces-34995-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:41:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEDC426928
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EE6A300998C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 03:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372A63112BD;
	Mon, 20 Apr 2026 03:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="XrHHFDAF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B53C2FD1B1
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 03:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776656484; cv=none; b=j898Kpih6Dq5s/Bs3sUX0LogFqZ6Dd3FQ1tb++ussxYm/hr9s/JZSEfvDp3ewDSTPHYnopoGJuU+BhaP4Q6XO/F/ZrkX4C6Tx4B5JKlFfRf6MH4dTUBP2rtLeUQJnZNcsy8tGLW0rBkdwbmExE4cyJ+evieFwv53WSHD7jNFwr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776656484; c=relaxed/simple;
	bh=P53uSObz7J8sDilJ5Cd5x2sjCPsUJ9lrM/N8YHFZ3Sk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmhFYUgMovTHWcR4R/f3AZynKDiOnCtveMvIEg/8/ejYgXsE+YhjTSn7ARuLOSsVAzZ9cwv9PrE9cywJYixFLBB3mOcJ5P3+dRZ7g2mRufekaha2bkP9VhY8DprjAWju31Cskkfv2X6OX8c+qTFMfOTRdyahyV+mV0+bbnUo4jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=XrHHFDAF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K3fJBm9426693, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776656480; bh=9/tAjPQprrnwhDztcrMA+2ILDpyEyi1ZlRVH3QjIjz0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=XrHHFDAFXHIBkeVCotYuMhqC/hDF1qp0fgkn3qLVHPLxsccKiEzEXtVpyER9+tanr
	 878s22dEzYU3VGbOD6g9us41qxU3r699Mr1hug17fkus3Ee7qS5eY5+aTN6at6KtdS
	 z6+/CMV9xIuH05xS2ovQDBRF/uxdCM6ciAzNi2MIjm6cwXQ9jece+fv0d4kjVf95YO
	 hCtmvGdvFRxhxMMBaHjyiKo1ywfQ1wLqCh71YNxV1RjFpOTL1PMkGuq6ConywMtApL
	 AKasrao400Z7z+zAHU05oBhxSf329MY5nL27WINJ7WoLvU2anX5vN9pTdoGuogEw7i
	 kLuYk4/ifB5dw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K3fJBm9426693
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 11:41:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 11:41:20 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 20 Apr 2026 11:41:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <gary.chang@realtek.com>, <echuang@realtek.com>,
        <wenjie.tsai@realtek.com>, <phhuang@realtek.com>, <isaiah@realtek.com>,
        <kevin_yang@realtek.com>, <mh_chen@realtek.com>
Subject: [PATCH rtw-next 02/16] wifi: rtw89: 8852a: refine power save to lower latency
Date: Mon, 20 Apr 2026 11:40:37 +0800
Message-ID: <20260420034051.17666-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260420034051.17666-1-pkshih@realtek.com>
References: <20260420034051.17666-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-34995-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9DEDC426928
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Po-Hao Huang <phhuang@realtek.com>

Improve user experience while using interactive applications.
Adjust power saving decisions under different scenarios.
Minimize latency for delay-sensitive connections by exiting
power-save on packet bursts and maintain active until a period
of inactivity is reached. For connections that are not that
sensitive to delays, keep the current aggressive power save logic.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 87 +++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h |  9 +++
 2 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 70feab97dccb..c9c4ec1d93af 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -341,10 +341,26 @@ static const struct rtw89_hw_rate_def {
 	},
 };
 
+static void rtw89_core_tx_skb_proto_stats(struct rtw89_traffic_stats *stats,
+					  struct sk_buff *skb)
+{
+	switch (ip_hdr(skb)->protocol) {
+	case IPPROTO_TCP:
+		stats->tcp++;
+		break;
+	case IPPROTO_UDP:
+		stats->udp++;
+		break;
+	default:
+		break;
+	}
+}
+
 static void __rtw89_traffic_stats_accu(struct rtw89_traffic_stats *stats,
 				       struct sk_buff *skb, bool tx)
 {
 	if (tx) {
+		rtw89_core_tx_skb_proto_stats(stats, skb);
 		stats->tx_cnt++;
 		stats->tx_unicast += skb->len;
 	} else {
@@ -2902,6 +2918,23 @@ static void rtw89_core_bcn_track_reset(struct rtw89_dev *rtwdev)
 	memset(&rtwdev->bcn_track, 0, sizeof(rtwdev->bcn_track));
 }
 
+static bool rtw89_core_proto_stats_can_lps(struct rtw89_dev *rtwdev,
+					   struct rtw89_vif *rtwvif,
+					   enum rtw89_tfc_interval interval)
+{
+	if (rtwdev->chip->chip_id != RTL8852A)
+		return true;
+
+	if (rtwvif->burst_active)
+		return false;
+
+	if (interval == RTW89_TFC_INTERVAL_100MS &&
+	    hweight8(rtwvif->stats_ps.active_histogram) < 3)
+		return false;
+
+	return true;
+}
+
 static void rtw89_vif_rx_bcn_stat(struct rtw89_dev *rtwdev, struct sk_buff *skb)
 {
 #define RTW89_APPEND_TSF_2GHZ 384
@@ -4540,9 +4573,42 @@ static enum rtw89_tfc_lv rtw89_get_traffic_level(struct rtw89_dev *rtwdev,
 	return RTW89_TFC_ULTRA_LOW;
 }
 
+static void rtw89_calc_vif_active_histogram(struct rtw89_dev *rtwdev,
+					    struct rtw89_traffic_stats *stats,
+					    enum rtw89_tfc_interval interval)
+{
+	struct rtw89_vif *rtwvif;
+
+	stats->udp_ratio = stats->tx_cnt ?
+			   DIV_ROUND_DOWN_ULL(stats->udp * 100, stats->tx_cnt) : 0;
+	stats->active_histogram <<= 1;
+
+	switch (interval) {
+	case RTW89_TFC_INTERVAL_2SEC:
+		rtwvif = container_of(stats, struct rtw89_vif, stats);
+
+		if (stats->tcp >= RTW89_TCP_TH && stats->tx_cnt >= stats->rx_cnt)
+			stats->active_histogram |= BIT(0);
+
+		if (stats->active_histogram & RTW89_RECENT_ACTIVE_HIST)
+			rtwvif->burst_active = true;
+		else
+			rtwvif->burst_active = false;
+
+		break;
+	case RTW89_TFC_INTERVAL_100MS:
+		if (stats->udp_ratio >= RTW89_UDP_RATIO_TH)
+			stats->active_histogram |= BIT(0);
+		break;
+	}
+
+	stats->tcp = 0;
+	stats->udp = 0;
+}
+
 static bool rtw89_traffic_stats_calc(struct rtw89_dev *rtwdev,
 				     struct rtw89_traffic_stats *stats,
-				     enum rtw89_tfc_interval interval)
+				     enum rtw89_tfc_interval interval, bool by_vif)
 {
 	enum rtw89_tfc_lv tx_tfc_lv = stats->tx_tfc_lv;
 	enum rtw89_tfc_lv rx_tfc_lv = stats->rx_tfc_lv;
@@ -4564,6 +4630,9 @@ static bool rtw89_traffic_stats_calc(struct rtw89_dev *rtwdev,
 	stats->rx_avg_len = stats->rx_cnt ?
 			    DIV_ROUND_DOWN_ULL(stats->rx_unicast, stats->rx_cnt) : 0;
 
+	if (by_vif)
+		rtw89_calc_vif_active_histogram(rtwdev, stats, interval);
+
 	stats->tx_unicast = 0;
 	stats->rx_unicast = 0;
 	stats->tx_cnt = 0;
@@ -4585,11 +4654,11 @@ static bool rtw89_traffic_stats_track(struct rtw89_dev *rtwdev)
 	bool tfc_changed;
 
 	tfc_changed = rtw89_traffic_stats_calc(rtwdev, &rtwdev->stats,
-					       RTW89_TFC_INTERVAL_2SEC);
+					       RTW89_TFC_INTERVAL_2SEC, false);
 
 	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
 		rtw89_traffic_stats_calc(rtwdev, &rtwvif->stats,
-					 RTW89_TFC_INTERVAL_2SEC);
+					 RTW89_TFC_INTERVAL_2SEC, true);
 
 		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
 			rtw89_fw_h2c_tp_offload(rtwdev, rtwvif_link);
@@ -4598,7 +4667,8 @@ static bool rtw89_traffic_stats_track(struct rtw89_dev *rtwdev)
 	return tfc_changed;
 }
 
-static void rtw89_enter_lps_track(struct rtw89_dev *rtwdev)
+static void rtw89_enter_lps_track(struct rtw89_dev *rtwdev,
+				  enum rtw89_tfc_interval interval)
 {
 	struct ieee80211_vif *vif;
 	struct rtw89_vif *rtwvif;
@@ -4622,6 +4692,9 @@ static void rtw89_enter_lps_track(struct rtw89_dev *rtwdev)
 		if (!rtw89_core_bcn_track_can_lps(rtwdev))
 			continue;
 
+		if (!rtw89_core_proto_stats_can_lps(rtwdev, rtwvif, interval))
+			continue;
+
 		rtw89_enter_lps(rtwdev, rtwvif, true);
 	}
 }
@@ -4771,13 +4844,13 @@ static void rtw89_track_ps_work(struct wiphy *wiphy, struct wiphy_work *work)
 
 	rtw89_for_each_rtwvif(rtwdev, rtwvif)
 		rtw89_traffic_stats_calc(rtwdev, &rtwvif->stats_ps,
-					 RTW89_TFC_INTERVAL_100MS);
+					 RTW89_TFC_INTERVAL_100MS, true);
 
 	if (rtwdev->scanning)
 		return;
 
 	if (rtwdev->lps_enabled && !rtwdev->btc.lps)
-		rtw89_enter_lps_track(rtwdev);
+		rtw89_enter_lps_track(rtwdev, RTW89_TFC_INTERVAL_100MS);
 }
 
 static void rtw89_track_work(struct wiphy *wiphy, struct wiphy_work *work)
@@ -4825,7 +4898,7 @@ static void rtw89_track_work(struct wiphy *wiphy, struct wiphy_work *work)
 	rtw89_core_mlo_track(rtwdev);
 
 	if (rtwdev->lps_enabled && !rtwdev->btc.lps)
-		rtw89_enter_lps_track(rtwdev);
+		rtw89_enter_lps_track(rtwdev, RTW89_TFC_INTERVAL_2SEC);
 }
 
 void rtw89_core_dm_disable_cfg(struct rtw89_dev *rtwdev, u32 new)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index fd29dbbb120d..bbcac7cc207c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1477,6 +1477,10 @@ enum rtw89_tfc_lv {
 
 DECLARE_EWMA(tp, 10, 2);
 
+#define RTW89_TCP_TH 40
+#define RTW89_UDP_RATIO_TH 70
+#define RTW89_RECENT_ACTIVE_HIST GENMASK(4, 0)
+
 struct rtw89_traffic_stats {
 	/* units in bytes */
 	u64 tx_unicast;
@@ -1504,6 +1508,10 @@ struct rtw89_traffic_stats {
 
 	u16 tx_rate;
 	u16 rx_rate;
+
+	/* used by rtwvif only */
+	u64 tcp, udp, udp_ratio;
+	u8 active_histogram;
 };
 
 struct rtw89_btc_chdef {
@@ -6354,6 +6362,7 @@ struct rtw89_vif {
 
 	struct rtw89_roc roc;
 	bool offchan;
+	bool burst_active;
 
 	enum rtw89_mlo_mode mlo_mode;
 	struct rtw89_vif_ml_trans ml_trans;
-- 
2.25.1



Return-Path: <linux-wireless+bounces-26552-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42643B30DF1
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 07:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ECD617BC96
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 05:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5496728D83E;
	Fri, 22 Aug 2025 05:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TpHlWq3V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B877D28505F
	for <linux-wireless@vger.kernel.org>; Fri, 22 Aug 2025 05:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755840096; cv=none; b=tkFLSEB9ziUbVOvx6vUk1cdQCc7tI19CnVvvP8L0a1dTe6rLOP1mG2wvomVF32KH7wzo1l4LNYzqYL+5IY2bF7ZNMIuNmRnVIE3CnMpr3jsSe0Mi57mG22x4yepa9OpKJfdePNRn+YAymQIzLXmFMiAX9/L35/ZFE65Emc0eA5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755840096; c=relaxed/simple;
	bh=mSSnI5TByVTB/01yuYbSFJ6RT/gAxqR1cclh0ors0A8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DywUhsb6rdN9L8/H5uignhGaeD/ALnlVHgY8kwa4aih8reWcHJnu6VxAiZ9MAOuGNQTWCOyOJWBY7TUvU0fdoNggS00gKlFc3LHe5DRKGSIkzlkXMEQsNuTKox7a893u9E+hOM9etauxK7aF/c4AKENBvOxJf+H37Egs4vsf6Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TpHlWq3V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LI9JLN022911;
	Fri, 22 Aug 2025 05:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=N+PGl87Yl4jeN4wnyyzokE
	gAAPtcw7SWg8MNXN01qMQ=; b=TpHlWq3V4GS6XTqWoOh13N48EFLbFqwBYcoqoh
	6YQbF+pUYu6jkwTksZWszCYyRrh+jkSCL8tb1kYXkYEPIJh/bBoLztOctbZM0ZZ4
	bwZAs+5CekKsresct5WP5W2o1EMqot5VIn4dAfnsrQCI652biWLeDV5MD2KqZa7b
	YkpAFkwDuz7qZO4520rFU4HiY3hiJ8fE7E1SxEsnrEa/wE2MmEp+DuksH0DccjZx
	UcovcesIIWeaaDFF85rux7GXY4Q/4e7X7Ck2yhbp6zz6OsyJVp3Nec7Uz+7Afu7C
	77Bg+PKnjCqy57aays2oWjVvBzv6It2TSXF96Ko9SHxJSwuw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52afxkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 05:21:28 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57M5LRdZ031205
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 05:21:27 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 21 Aug 2025 22:21:25 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>,
        Hari Chandrakanthan <quic_haric@quicinc.com>
Subject: [PATCH wireless-next] wifi: mac80211: add tx_handlers_drop statistics to ethtool
Date: Fri, 22 Aug 2025 10:51:10 +0530
Message-ID: <20250822052110.513804-1-quic_sarishar@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IaVk1F26eWqirkV7AjdmolLVbyy7QCbw
X-Authority-Analysis: v=2.4 cv=B83gEOtM c=1 sm=1 tr=0 ts=68a7fe58 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=az_UEyvAFAIfud0NVgkA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: IaVk1F26eWqirkV7AjdmolLVbyy7QCbw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX6WqiwHrh8KQi
 3xvT/zXLZAl13tEB2cudQQccTeC6sALB7IDsQWuwvSZ7Qr+eyoPc910ek/Vx1MB7PLDmqZ3Vcba
 p/sJMtMrwH9s1xxNsXL4GS9KxH7Zh4CdksJCqhCN2ZOiLSFUJfxklU8yPSdY7lAI0CeInuk36qZ
 /rvcllPRBTC57Nc03cZ+YcAjCsZ57Erxc9LYcP8uVw2G17jubD+ExbOeQfhLFE/U+i3XdUyUXGj
 BHnYe4NOP6uKv7m4jd4f/MdTSq7AzRtsJRfcti5pcF2mCatR2SZYJmyLJTn2y01TqAshOg5htUZ
 cojhoqVSvM9UMJMR5X29qSXjo+JUt6IsViARtqBsrEe2XKI0C0C0unQ5R0O1Ii9EXkIl89Vq1+Q
 VdsYwqccDwmeHzJnFXHZyznY6j6KAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Currently tx_handlers_drop statistics are handled only for slow TX
path and only at radio level. This also requires
CONFIG_MAC80211_DEBUG_COUNTERS to be enabled to account the dropped
packets. There is no way to check these stats for fast TX,
at interface level and monitor without enabling the debug configuration.

Hence, add a new counter at the sdata level to track packets dropped
with reason as TX_DROP during transmission for fast path, slow path
and other tx management packets. Expose this via ethtool statistics,
to improve visibility into transmission failures at interface level
and aid debugging and performance monitoring.

Place the counter in ethtool with other available tx_* stats for
better readability and accurate tracking.

Sample output:
root@buildroot:~# ethtool -S wlan0
NIC statistics:
     rx_packets: 5904
     rx_bytes: 508122
     rx_duplicates: 12
     rx_fragments: 5900
     rx_dropped: 12
     tx_packets: 391487
     tx_bytes: 600423383
     tx_filtered: 0
     tx_retry_failed: 10332
     tx_retries: 1548
     tx_handlers_drop: 4
     ....

Co-developed-by: Hari Chandrakanthan <quic_haric@quicinc.com>
Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 net/mac80211/ethtool.c     | 6 ++++--
 net/mac80211/ieee80211_i.h | 1 +
 net/mac80211/tx.c          | 7 ++++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
index 0397755a3bd1..3d365626faa4 100644
--- a/net/mac80211/ethtool.c
+++ b/net/mac80211/ethtool.c
@@ -48,8 +48,8 @@ static const char ieee80211_gstrings_sta_stats[][ETH_GSTRING_LEN] = {
 	"rx_duplicates", "rx_fragments", "rx_dropped",
 	"tx_packets", "tx_bytes",
 	"tx_filtered", "tx_retry_failed", "tx_retries",
-	"sta_state", "txrate", "rxrate", "signal",
-	"channel", "noise", "ch_time", "ch_time_busy",
+	"tx_handlers_drop", "sta_state", "txrate", "rxrate",
+	"signal", "channel", "noise", "ch_time", "ch_time_busy",
 	"ch_time_ext_busy", "ch_time_rx", "ch_time_tx"
 };
 #define STA_STATS_LEN	ARRAY_SIZE(ieee80211_gstrings_sta_stats)
@@ -120,6 +120,7 @@ static void ieee80211_get_stats(struct net_device *dev,
 		i = 0;
 		ADD_STA_STATS(&sta->deflink);
 
+		data[i++] = sdata->tx_handlers_drop;
 		data[i++] = sta->sta_state;
 
 
@@ -145,6 +146,7 @@ static void ieee80211_get_stats(struct net_device *dev,
 			sta_set_sinfo(sta, &sinfo, false);
 			i = 0;
 			ADD_STA_STATS(&sta->deflink);
+			data[i++] = sdata->tx_handlers_drop;
 		}
 	}
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8afa2404eaa8..f44f7d14689b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1210,6 +1210,7 @@ struct ieee80211_sub_if_data {
 	} debugfs;
 #endif
 
+	u32 tx_handlers_drop;
 	/* must be last, dynamically sized area in this! */
 	struct ieee80211_vif vif;
 };
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 00671ae45b2f..53114568a79d 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1814,6 +1814,7 @@ static int invoke_tx_handlers_early(struct ieee80211_tx_data *tx)
 
  txh_done:
 	if (unlikely(res == TX_DROP)) {
+		tx->sdata->tx_handlers_drop++;
 		I802_DEBUG_INC(tx->local->tx_handlers_drop);
 		if (tx->skb)
 			ieee80211_free_txskb(&tx->local->hw, tx->skb);
@@ -1858,6 +1859,7 @@ static int invoke_tx_handlers_late(struct ieee80211_tx_data *tx)
 
  txh_done:
 	if (unlikely(res == TX_DROP)) {
+		tx->sdata->tx_handlers_drop++;
 		I802_DEBUG_INC(tx->local->tx_handlers_drop);
 		if (tx->skb)
 			ieee80211_free_txskb(&tx->local->hw, tx->skb);
@@ -1942,6 +1944,7 @@ static bool ieee80211_tx(struct ieee80211_sub_if_data *sdata,
 
 	if (unlikely(res_prepare == TX_DROP)) {
 		ieee80211_free_txskb(&local->hw, skb);
+		tx.sdata->tx_handlers_drop++;
 		return true;
 	} else if (unlikely(res_prepare == TX_QUEUED)) {
 		return true;
@@ -3728,8 +3731,10 @@ void __ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	r = ieee80211_xmit_fast_finish(sdata, sta, fast_tx->pn_offs,
 				       fast_tx->key, &tx);
 	tx.skb = NULL;
-	if (r == TX_DROP)
+	if (r == TX_DROP) {
+		tx.sdata->tx_handlers_drop++;
 		goto free;
+	}
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		sdata = container_of(sdata->bss,

base-commit: d9104cec3e8fe4b458b74709853231385779001f
-- 
2.34.1



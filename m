Return-Path: <linux-wireless+bounces-35622-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOGIFHQJ8mnhmwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35622-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:36:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B3A494F27
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4AFA7305FC9F
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E993FD14F;
	Wed, 29 Apr 2026 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GrGfdokB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41BB3FBEBB
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469206; cv=none; b=XhdP9FcFm1dQ0eltAnFIVgTN4duiTXdiWu58S6k/gHgvYm8cfC5E1SUVCpI1mUdE9Wiz8geS5aTApV8lOeK9YZ1ODAaux9ENNZK0GUFRWKDUY3ykz/I54fqtk+Tqe0EoV/FPZRu/gT5RyzQpt9pdgPR61fAop6UA9V8j71FdNVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469206; c=relaxed/simple;
	bh=ETlHeabXF+LvxwEtUQb3U40Y2XI95VRuYFIqzxggMD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1yxYyykTmqJCrvjWGcwVV8csYjFlfiWtAeMNl+AuFjfrEcP89KgajckdUCX0IZZz5I309N2pEJ3alAd2C/PHWchYLpJurBt0xCF+KflkpjFujhSsgfM58d7aGMlwZ9M4F7hpHLLlxn8Cx+ZqmZtQ/VqOpDPvMo1abnI0RDX8Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GrGfdokB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63TDQgExA1223049, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777469202; bh=WsMV5zy7InJVas1iMOfzUdyt6R47SAcl23mMVzGRDgM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=GrGfdokBf9MgaExaJLvfvfScLVmbDTtwTIYfFNVVH4aro16HGjJFimHyGZptm4sfn
	 4tNi9yt1VkGBzTu147EF71Thrw/aZ+/nRJxobdl+REyEd2FlirtbGbJ6qUyENtatvp
	 HxXm3i7CYrCvOdkMGC7Jm3wYxPrJuPBD39/LCMK0457IpaMtzfbs6VyHr4du33xWkx
	 YzapagUGDhb+5KsHqEx8B6K2KE7mQ9CcYil+W7udv6i4Ot1lRVYnoasNjVjVidQajO
	 m++1ysEgL+GuXGL6kWBceGKNUePS/nTsjnB3/ALEXjV7YVe5m+A62xjwuKhTM3x2pE
	 Kvphgzq5vBrxw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63TDQgExA1223049
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:26:42 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 21:26:42 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 21:26:41 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 29 Apr 2026 21:26:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH rtw-next 3/7] wifi: rtw89: debug: bb_info entry including TX rate count for WiFi 7 chips
Date: Wed, 29 Apr 2026 21:26:21 +0800
Message-ID: <20260429132625.1659182-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260429132625.1659182-1-pkshih@realtek.com>
References: <20260429132625.1659182-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 56B3A494F27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35622-lists,linux-wireless=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Kuan-Chung Chen <damon.chen@realtek.com>

Enhance TX performance visibility for WiFi 7 chips by introducing TX
rate count tracking. This is critical for debugging and validation.
Additionally, introduce a new debugfs bb_info to enable and provide
baseband status.

Usage of bb_info debugfs:
  $ echo enable 1 > bb_info  // Start logging BB statistics information
  $ echo mac_id 0 > bb_info  // Specify mac_id for TX rate count tracking

The output of bb_info:

  TP TX: 0 [0] Mbps, RX: 0 [0] Mbps
  Avg packet length: TX=118, RX=136
  TF: 0
  TX count [0]:
     Legacy: [0, 0, 0, 0]
       OFDM: [0, 0, 0, 0, 0, 0, 0, 0]
    MCS 1SS: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    MCS 2SS: [183, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

  [PHY 0]
  == RSSI/RX Rate
  Beacon: 19 (-41 dBm)
  RX count:
     Legacy: [0, 0, 0, 0]
       OFDM: [0, 0, 0, 0, 0, 0, 0, 0]
       HT 0: [0, 0, 0, 0, 0, 0, 0, 0]
       HT 1: [0, 0, 0, 0, 0, 0, 0, 0]
    VHT 1SS: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0][0, 0]
    VHT 2SS: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0][0, 0]
     HE 1SS: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
     HE 2SS: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    EHT 1SS: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0][0, 0]
    EHT 2SS: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 185]

  TX rate [0, 2]: EHT 2SS MCS-0 GI:0.8 FB_G BW:160 (hw_rate=0x420) ==> agg_wait=-1 (1)
  RX rate [0, 2]: EHT 2SS MCS-13 GI:0.8 BW:160 (hw_rate=0x42d)
  RSSI: -43 dBm (raw=134, prev=135) [-43, -44]
  EVM: [38.75, (41.50, 43.00)]    SNR: 39

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |   2 +
 drivers/net/wireless/realtek/rtw89/core.h     |  13 ++
 drivers/net/wireless/realtek/rtw89/debug.c    | 110 +++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.c       | 122 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       |  35 +++++
 drivers/net/wireless/realtek/rtw89/mac80211.c |  11 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |  29 +++++
 drivers/net/wireless/realtek/rtw89/phy.h      |   1 +
 8 files changed, 314 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 81f3ae21dc18..d8f83623e54a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -6613,6 +6613,8 @@ int rtw89_core_mlsr_switch(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	if (RTW89_CHK_FW_FEATURE_GROUP(WITH_RFK_PRE_NOTIFY, &rtwdev->fw))
 		rtw89_chip_rfk_channel(rtwdev, target);
 
+	rtw89_fw_h2c_tx_history(rtwdev, target->mac_id);
+
 	rtwvif->mlo_mode = RTW89_MLO_MODE_MLSR;
 
 wake_queue:
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index f15a0c43ef6d..c4396f0100be 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4511,6 +4511,15 @@ struct rtw89_antdiv_info {
 	bool get_stats;
 };
 
+struct rtw89_bb_stat_cfg {
+	bool enable;
+	u16 mac_id;
+};
+
+struct rtw89_phy_info {
+	struct rtw89_bb_stat_cfg bb_stat_cfg;
+};
+
 enum rtw89_chanctx_state {
 	RTW89_CHANCTX_STATE_MCC_START,
 	RTW89_CHANCTX_STATE_MCC_STOP,
@@ -4831,6 +4840,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_SIM_SER_L0L1_BY_HALT_H2C,
 	RTW89_FW_FEATURE_LPS_ML_INFO_V1,
 	RTW89_FW_FEATURE_SER_POST_RECOVER_DMAC,
+	RTW89_FW_FEATURE_TX_HISTORY_V1,
 
 	NUM_OF_RTW89_FW_FEATURES,
 };
@@ -5342,9 +5352,11 @@ struct rtw89_beacon_stat {
 
 DECLARE_EWMA(thermal, 4, 4);
 
+#define RTW89_TX_RATE_NR 40
 struct rtw89_phy_stat {
 	struct ewma_thermal avg_thermal[RF_PATH_MAX];
 	u8 last_thermal_max;
+	u32 tx_rate_cnt[RTW89_TX_RATE_NR];
 	struct rtw89_beacon_stat bcn_stat;
 };
 
@@ -6308,6 +6320,7 @@ struct rtw89_dev {
 	struct rtw89_phy_efuse_gain efuse_gain;
 	struct rtw89_phy_ul_tb_info ul_tb_info;
 	struct rtw89_antdiv_info antdiv;
+	struct rtw89_phy_info phy_info;
 
 	struct rtw89_bb_ctx {
 		enum rtw89_phy_idx phy_idx;
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 2d953bec149b..b82b13645fb0 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -85,6 +85,7 @@ struct rtw89_debugfs {
 	struct rtw89_debugfs_priv btc_manual;
 	struct rtw89_debugfs_priv fw_log_manual;
 	struct rtw89_debugfs_priv phy_info;
+	struct rtw89_debugfs_priv bb_info;
 	struct rtw89_debugfs_priv stations;
 	struct rtw89_debugfs_priv disable_dm;
 	struct rtw89_debugfs_priv static_pd_th;
@@ -4016,15 +4017,15 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 }
 
 static int
-rtw89_debug_append_rx_rate(char *buf, size_t bufsz, struct rtw89_pkt_stat *pkt_stat,
-			   enum rtw89_hw_rate first_rate, int len)
+rtw89_debug_append_rate(char *buf, size_t bufsz, const u32 *rate_cnt,
+			int first_rate, int len)
 {
 	char *p = buf, *end = buf + bufsz;
 	int i;
 
 	for (i = 0; i < len; i++)
 		p += scnprintf(p, end - p, "%s%u", i == 0 ? "" : ", ",
-			       pkt_stat->rx_rate_cnt[first_rate + i]);
+			       rate_cnt[first_rate + i]);
 
 	return p - buf;
 }
@@ -4051,6 +4052,17 @@ static const struct rtw89_rx_rate_cnt_info {
 	{FIRST_RATE_GEV1(EHT_NSS2_MCS0), 14, 0, "EHT 2SS:"},
 };
 
+static const struct rtw89_tx_rate_cnt_info {
+	int first_rate;
+	int len;
+	const char *rate_mode;
+} rtw89_tx_rate_cnt_infos[] = {
+	{0, 4, "Legacy:"},
+	{4, 8, "OFDM:"},
+	{12, 14, "MCS 1SS:"},
+	{26, 14, "MCS 2SS:"},
+};
+
 static int rtw89_get_rx_pkt_stat(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb,
 				 char *buf, size_t bufsz)
 {
@@ -4075,12 +4087,13 @@ static int rtw89_get_rx_pkt_stat(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *
 			continue;
 
 		p += scnprintf(p, end - p, "%10s [", info->rate_mode);
-		p += rtw89_debug_append_rx_rate(p, end - p, pkt_stat,
-						first_rate, info->len);
+		p += rtw89_debug_append_rate(p, end - p, pkt_stat->rx_rate_cnt,
+					     first_rate, info->len);
 		if (info->ext) {
 			p += scnprintf(p, end - p, "][");
-			p += rtw89_debug_append_rx_rate(p, end - p, pkt_stat,
-							first_rate + info->len, info->ext);
+			p += rtw89_debug_append_rate(p, end - p, pkt_stat->rx_rate_cnt,
+						     first_rate + info->len,
+						     info->ext);
 		}
 		p += scnprintf(p, end - p, "]\n");
 	}
@@ -4125,6 +4138,87 @@ static ssize_t rtw89_debug_priv_phy_info_get(struct rtw89_dev *rtwdev,
 	return p - buf;
 }
 
+static int rtw89_get_bb_stat(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb,
+			     char *buf, size_t bufsz)
+{
+	char *p = buf, *end = buf + bufsz;
+
+	p += scnprintf(p, end - p, "\n[PHY %u]\n", bb->phy_idx);
+
+	p += scnprintf(p, end - p, "== RSSI/RX Rate\n");
+	p += rtw89_get_rx_pkt_stat(rtwdev, bb, p, end - p);
+
+	return p - buf;
+}
+
+static ssize_t
+rtw89_debug_priv_bb_info_get(struct rtw89_dev *rtwdev,
+			     struct rtw89_debugfs_priv *debugfs_priv,
+			     char *buf, size_t bufsz)
+{
+	struct rtw89_bb_stat_cfg *bb_stat = &rtwdev->phy_info.bb_stat_cfg;
+	struct rtw89_traffic_stats *stats = &rtwdev->stats;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_tx_rate_cnt_info *info;
+	struct rtw89_debugfs_iter_data iter_data;
+	char *p = buf, *end = buf + bufsz;
+	struct rtw89_bb_ctx *bb;
+	int i;
+
+	p += scnprintf(p, end - p, "TP TX: %u [%u] Mbps, RX: %u [%u] Mbps\n",
+		       stats->tx_throughput, stats->tx_throughput_raw,
+		       stats->rx_throughput, stats->rx_throughput_raw);
+	p += scnprintf(p, end - p, "Avg packet length: TX=%u, RX=%u\n",
+		       stats->tx_avg_len,
+		       stats->rx_avg_len);
+	p += scnprintf(p, end - p, "TF: %u\n", stats->rx_tf_periodic);
+
+	if (chip->chip_gen != RTW89_CHIP_AX) {
+		p += scnprintf(p, end - p,
+			       "TX count [0x%x]:\n", bb_stat->mac_id);
+
+		for (i = 0; i < ARRAY_SIZE(rtw89_tx_rate_cnt_infos); i++) {
+			info = &rtw89_tx_rate_cnt_infos[i];
+
+			p += scnprintf(p, end - p, "%10s [", info->rate_mode);
+			p += rtw89_debug_append_rate(p, end - p,
+						     rtwdev->phystat.tx_rate_cnt,
+						     info->first_rate, info->len);
+			p += scnprintf(p, end - p, "]\n");
+		}
+	}
+
+	rtw89_for_each_active_bb(rtwdev, bb)
+		p += rtw89_get_bb_stat(rtwdev, bb, p, end - p);
+	p += scnprintf(p, end - p, "\n");
+
+	rtw89_debugfs_iter_data_setup(&iter_data, p, end - p);
+	ieee80211_iterate_stations_atomic(rtwdev->hw, rtw89_sta_info_get_iter, &iter_data);
+	p += iter_data.written_sz;
+
+	return p - buf;
+}
+
+static ssize_t
+rtw89_debug_priv_bb_info_set(struct rtw89_dev *rtwdev,
+			     struct rtw89_debugfs_priv *debugfs_priv,
+			     const char *buf, size_t count)
+{
+	struct rtw89_bb_stat_cfg *bb_stat = &rtwdev->phy_info.bb_stat_cfg;
+	int val;
+
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
+	if (sscanf(buf, "enable %d", &val) == 1)
+		bb_stat->enable = !!val;
+	else if (sscanf(buf, "mac_id %x", &val) == 1)
+		rtw89_fw_h2c_tx_history(rtwdev, val);
+	else
+		return -EINVAL;
+
+	return count;
+}
+
 static int rtw89_dump_addr_cam(struct rtw89_dev *rtwdev,
 			       char *buf, size_t bufsz,
 			       struct rtw89_addr_cam_entry *addr_cam)
@@ -5000,6 +5094,7 @@ static const struct rtw89_debugfs rtw89_debugfs_templ = {
 	.btc_manual = rtw89_debug_priv_set(btc_manual),
 	.fw_log_manual = rtw89_debug_priv_set(fw_log_manual, WLOCK),
 	.phy_info = rtw89_debug_priv_get(phy_info),
+	.bb_info = rtw89_debug_priv_set_and_get(bb_info, RWLOCK),
 	.stations = rtw89_debug_priv_get(stations, RLOCK),
 	.disable_dm = rtw89_debug_priv_set_and_get(disable_dm, RWLOCK),
 	.static_pd_th = rtw89_debug_priv_set_and_get(static_pd_th, RWLOCK),
@@ -5049,6 +5144,7 @@ void rtw89_debugfs_add_sec1(struct rtw89_dev *rtwdev, struct dentry *debugfs_top
 	rtw89_debugfs_add_w(btc_manual);
 	rtw89_debugfs_add_w(fw_log_manual);
 	rtw89_debugfs_add_r(phy_info);
+	rtw89_debugfs_add_rw(bb_info);
 	rtw89_debugfs_add_r(stations);
 	rtw89_debugfs_add_rw(disable_dm);
 	rtw89_debugfs_add_rw(static_pd_th);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 2a3662ed733f..ff3914a16b81 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -930,6 +930,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__DIS_FW_FEAT(RTL8922A, ge, 0, 35, 84, 0, WITH_RFK_PRE_NOTIFY, G),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 84, 0, RFK_PRE_NOTIFY_MCC_V1),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 84, 0, ADDR_CAM_V0),
+	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 92, 0, TX_HISTORY_V1),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 97, 0, SIM_SER_L0L1_BY_HALT_H2C),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 100, 0, SER_POST_RECOVER_DMAC),
 };
@@ -5588,6 +5589,127 @@ int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi
 	return ret;
 }
 
+int rtw89_fw_h2c_tx_history(struct rtw89_dev *rtwdev, u16 mac_id)
+{
+	struct rtw89_bb_stat_cfg *bb_stat = &rtwdev->phy_info.bb_stat_cfg;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_h2c_ra_tx_history *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	if (chip->chip_gen == RTW89_CHIP_AX)
+		return 0;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c tx history\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_ra_tx_history *)skb->data;
+
+	h2c->w0 = le32_encode_bits(mac_id, RTW89_H2C_RA_TX_HISTORY_W0_MACID) |
+		  le32_encode_bits(0, RTW89_H2C_RA_TX_HISTORY_W0_PER_PPDU);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RA,
+			      H2C_FUNC_OUTSRC_RA_TX_HISTORY, 0, 0, len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	bb_stat->mac_id = mac_id;
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
+int rtw89_fw_h2c_phy_ch_rpt(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_h2c_ra_phy_ch_rpt *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	if (chip->chip_gen == RTW89_CHIP_AX)
+		return 0;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c phy ch rpt\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_ra_phy_ch_rpt *)skb->data;
+
+	h2c->w1 = le32_encode_bits(1, RTW89_H2C_RA_PHY_CH_RPT_W1_RPT_TX_COUNT);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RA,
+			      H2C_FUNC_OUTSRC_RA_PHY_CH_RPT, 0, 0, len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
+int rtw89_fw_h2c_drv_ctrl_fw(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_h2c_ra_drv_ctrl_fw *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	if (chip->chip_gen == RTW89_CHIP_AX)
+		return 0;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c drv ctrl fw\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_ra_drv_ctrl_fw *)skb->data;
+
+	h2c->w0 = le32_encode_bits(1, RTW89_H2C_RA_DRV_CTRL_FW_W0_RPT_TX_COUNT);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RA,
+			      H2C_FUNC_OUTSRC_RA_DRV_CTRL_FW, 0, 0, len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
 int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 6ef53fcd0cce..cde8fd34723b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -471,6 +471,28 @@ struct rtw89_h2c_ra_v1 {
 #define RTW89_H2C_RA_V1_W4_RAMASK_UHL16 GENMASK(31, 16)
 #define RTW89_H2C_RA_V1_W5_RAMASK_UHH16 GENMASK(15, 0)
 
+struct rtw89_h2c_ra_tx_history {
+	__le32 w0;
+} __packed;
+
+#define RTW89_H2C_RA_TX_HISTORY_W0_MACID GENMASK(15, 0)
+#define RTW89_H2C_RA_TX_HISTORY_W0_PER_PPDU GENMASK(23, 16)
+
+struct rtw89_h2c_ra_phy_ch_rpt {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+} __packed;
+
+#define RTW89_H2C_RA_PHY_CH_RPT_W1_RPT_TX_COUNT BIT(10)
+
+struct rtw89_h2c_ra_drv_ctrl_fw {
+	__le32 w0;
+} __packed;
+
+#define RTW89_H2C_RA_DRV_CTRL_FW_W0_RPT_TX_COUNT BIT(13)
+
 static inline void RTW89_SET_FWCMD_SEC_IDX(void *cmd, u32 val)
 {
 	le32p_replace_bits((__le32 *)(cmd) + 0x00, val, GENMASK(7, 0));
@@ -3973,6 +3995,13 @@ struct rtw89_c2h_lps_rpt {
 	 */
 } __packed;
 
+struct rtw89_c2h_ra_tx_history {
+	struct rtw89_c2h_hdr hdr;
+	__le32 ra_tbtt_cnt;
+	__le32 tx_rate_tot_cnt_hist[RTW89_TX_RATE_NR];
+	__le32 tx_cat_cnt[3];
+} __packed;
+
 struct rtw89_c2h_fw_scan_rpt {
 	struct rtw89_c2h_hdr hdr;
 	u8 phy_idx;
@@ -4771,6 +4800,9 @@ enum rtw89_mrc_h2c_func {
 
 #define H2C_CL_OUTSRC_RA		0x1
 #define H2C_FUNC_OUTSRC_RA_MACIDCFG	0x0
+#define H2C_FUNC_OUTSRC_RA_TX_HISTORY	0x9
+#define H2C_FUNC_OUTSRC_RA_PHY_CH_RPT	0xe
+#define H2C_FUNC_OUTSRC_RA_DRV_CTRL_FW	0xf
 
 #define H2C_CL_OUTSRC_DM		0x2
 #define H2C_FUNC_FW_MCC_DIG		0x6
@@ -5349,6 +5381,9 @@ int rtw89_fw_h2c_rssi_offload(struct rtw89_dev *rtwdev,
 			      struct rtw89_rx_phy_ppdu *phy_ppdu);
 int rtw89_fw_h2c_tp_offload(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
 int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi);
+int rtw89_fw_h2c_phy_ch_rpt(struct rtw89_dev *rtwdev);
+int rtw89_fw_h2c_tx_history(struct rtw89_dev *rtwdev, u16 mac_id);
+int rtw89_fw_h2c_drv_ctrl_fw(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_init_v7(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev, u8 type);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 9ee2aa225976..b72f6661fbd1 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -721,14 +721,21 @@ static void rtw89_ops_vif_cfg_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_MLD_VALID_LINKS) {
 		struct rtw89_vif_link *cur = rtw89_get_designated_link(rtwvif);
+		u16 mac_id;
 
 		if (RTW89_CHK_FW_FEATURE_GROUP(WITH_RFK_PRE_NOTIFY, &rtwdev->fw))
 			rtw89_chip_rfk_channel(rtwdev, cur);
 
-		if (hweight16(vif->active_links) == 1)
+		if (hweight16(vif->active_links) == 1) {
+			mac_id = cur->mac_id;
 			rtwvif->mlo_mode = RTW89_MLO_MODE_MLSR;
-		else
+		} else {
+			/* Specify for all MAC ID */
+			mac_id = 0xffff;
 			rtwvif->mlo_mode = RTW89_MLO_MODE_EMLSR;
+		}
+
+		rtw89_fw_h2c_tx_history(rtwdev, mac_id);
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 29770cc5ea60..3124a99d5381 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3379,12 +3379,24 @@ rtw89_phy_c2h_ra_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 					  &ra_data);
 }
 
+static void
+rtw89_phy_c2h_tx_history(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+	const struct rtw89_c2h_ra_tx_history *history = (const void *)c2h->data;
+	u32 *tx_rate_cnt = rtwdev->phystat.tx_rate_cnt;
+	u32 i;
+
+	for (i = 0; i < RTW89_TX_RATE_NR; i++)
+		tx_rate_cnt[i] = le32_to_cpu(history->tx_rate_tot_cnt_hist[i]);
+}
+
 static
 void (* const rtw89_phy_c2h_ra_handler[])(struct rtw89_dev *rtwdev,
 					  struct sk_buff *c2h, u32 len) = {
 	[RTW89_PHY_C2H_FUNC_STS_RPT] = rtw89_phy_c2h_ra_rpt,
 	[RTW89_PHY_C2H_FUNC_MU_GPTBL_RPT] = NULL,
 	[RTW89_PHY_C2H_FUNC_TXSTS] = NULL,
+	[RTW89_PHY_C2H_FUNC_TX_HISTORY] = rtw89_phy_c2h_tx_history,
 	[RTW89_PHY_C2H_FUNC_ACCELERATE_EN] = rtw89_fw_c2h_dummy_handler,
 };
 
@@ -5832,6 +5844,22 @@ static void rtw89_phy_stat_init(struct rtw89_dev *rtwdev)
 	rtwdev->hal.thermal_prot_lv = 0;
 }
 
+static void rtw89_phy_trigger_tx_count(struct rtw89_dev *rtwdev)
+{
+	if (RTW89_CHK_FW_FEATURE(TX_HISTORY_V1, &rtwdev->fw))
+		rtw89_fw_h2c_phy_ch_rpt(rtwdev);
+	else
+		rtw89_fw_h2c_drv_ctrl_fw(rtwdev);
+}
+
+static void rtw89_phy_stat_update(struct rtw89_dev *rtwdev)
+{
+	if (!rtwdev->phy_info.bb_stat_cfg.enable)
+		return;
+
+	rtw89_phy_trigger_tx_count(rtwdev);
+}
+
 void rtw89_phy_stat_track(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_bb_ctx *bb;
@@ -5839,6 +5867,7 @@ void rtw89_phy_stat_track(struct rtw89_dev *rtwdev)
 	rtw89_phy_stat_thermal_update(rtwdev);
 	rtw89_phy_thermal_protect(rtwdev);
 	rtw89_phy_stat_rssi_update(rtwdev);
+	rtw89_phy_stat_update(rtwdev);
 
 	rtw89_for_each_active_bb(rtwdev, bb) {
 		bb->last_pkt_stat = bb->cur_pkt_stat;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 3f9d306ff1ca..c6761cedc5a5 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -139,6 +139,7 @@ enum rtw89_phy_c2h_ra_func {
 	RTW89_PHY_C2H_FUNC_STS_RPT,
 	RTW89_PHY_C2H_FUNC_MU_GPTBL_RPT,
 	RTW89_PHY_C2H_FUNC_TXSTS,
+	RTW89_PHY_C2H_FUNC_TX_HISTORY = 0x4,
 	RTW89_PHY_C2H_FUNC_ACCELERATE_EN = 0x7,
 
 	RTW89_PHY_C2H_FUNC_RA_NUM,
-- 
2.25.1



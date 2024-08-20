Return-Path: <linux-wireless+bounces-11688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CBE95866C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F9C2882E8
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109B518FDA2;
	Tue, 20 Aug 2024 12:00:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB1E18F2DC
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155234; cv=none; b=oZ/4+jzOkDvZajFQNuOo/Ej/GXw5wVpCz39tMgXesu5CYG+zT/rAH/XDNczaUOz+nijxBk1s/g7mCKZhoGXbgeGJfL0mFlqTOXHhxvHR+YtWJMHrYDLayS+x4pmmu1rsYNDMovbh4HL+bxBGtUhducomnnEp6GIb0mmZIkvrcBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155234; c=relaxed/simple;
	bh=wpHLf0bbOY2m3B3/4YzPyoXnonFr10puJFX2pVEDLyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jmMzzai5CZE4AEHLiL7+vdr7JOzludNRr1LeaERrsDKe5pjjm5WIM1t2Kprjuosu3PSMFoih7+NSYzRGXWlyJuCT4VWxpl+LbZu/8b3yBu/inrn1YxbZQa89WjbsSIl/Pjb7TRTyScFww/LAk9OTonz0AlCf7c3En+bUl68YWUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-0000uV-Dx; Tue, 20 Aug 2024 14:00:26 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXF-001lNA-Vm; Tue, 20 Aug 2024 14:00:25 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1R;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:46 +0200
Subject: [PATCH 21/31] wifi: mwifiex: associate tx_power to the adapter
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-21-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=11051;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=wpHLf0bbOY2m3B3/4YzPyoXnonFr10puJFX2pVEDLyE=;
 b=Kz5G5bIaDfkfxMhu3KvGHJQ8qESBdYrFBTMcx+C5YVoHzwmo9LkXC2GjBDgXxOdvBHsO9Rh6v
 zTEO9879PVrDnWqaUA026KuxpvGDsd3yUladD2Swz9ORb5oeFCO1I+R
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

The tx_power limitations are specific to the adapter, not to the
priv (of which an adapter has multiple), so move the *tx_power_level
variables from struct mwifiex_private to struct mwifiex_adapter and
adjust the context pointers of the corresponding functions accordingly.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    | 14 +++-----
 drivers/net/wireless/marvell/mwifiex/init.c        |  3 --
 drivers/net/wireless/marvell/mwifiex/main.h        |  8 ++---
 drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c | 37 +++++++++++-----------
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c   | 22 ++++++-------
 5 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index ffdd2b8e5f955..5c8232b5a8c7d 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -379,7 +379,6 @@ mwifiex_cfg80211_set_tx_power(struct wiphy *wiphy,
 			      int mbm)
 {
 	struct mwifiex_adapter *adapter = mwifiex_cfg80211_get_adapter(wiphy);
-	struct mwifiex_private *priv;
 	struct mwifiex_power_cfg power_cfg;
 	int dbm = MBM_TO_DBM(mbm);
 
@@ -399,9 +398,7 @@ mwifiex_cfg80211_set_tx_power(struct wiphy *wiphy,
 		break;
 	}
 
-	priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
-
-	return mwifiex_set_tx_power(priv, &power_cfg);
+	return mwifiex_set_tx_power(adapter, &power_cfg);
 }
 
 /*
@@ -413,16 +410,15 @@ mwifiex_cfg80211_get_tx_power(struct wiphy *wiphy,
 			      int *dbm)
 {
 	struct mwifiex_adapter *adapter = mwifiex_cfg80211_get_adapter(wiphy);
-	struct mwifiex_private *priv = mwifiex_get_priv(adapter,
-							MWIFIEX_BSS_ROLE_ANY);
-	int ret = mwifiex_send_cmd(priv, HostCmd_CMD_RF_TX_PWR,
-				   HostCmd_ACT_GEN_GET, 0, NULL, true);
+
+	int ret = mwifiex_adapter_send_cmd(adapter, HostCmd_CMD_RF_TX_PWR,
+					   HostCmd_ACT_GEN_GET, 0, NULL, true);
 
 	if (ret < 0)
 		return ret;
 
 	/* tx_power_level is set in HostCmd_CMD_RF_TX_PWR command handler */
-	*dbm = priv->tx_power_level;
+	*dbm = adapter->tx_power_level;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index df89c9dc44b75..a2296c0d91534 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -105,9 +105,6 @@ int mwifiex_init_priv(struct mwifiex_private *priv)
 	priv->adhoc_channel = DEFAULT_AD_HOC_CHANNEL;
 	priv->atim_window = 0;
 	priv->adhoc_state = ADHOC_IDLE;
-	priv->tx_power_level = 0;
-	priv->max_tx_power_level = 0;
-	priv->min_tx_power_level = 0;
 	priv->tx_ant = 0;
 	priv->rx_ant = 0;
 	priv->tx_rate = 0;
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 8ca770738d08e..cb3a52c0869c9 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -542,9 +542,6 @@ struct mwifiex_private {
 	u32 curr_pkt_filter;
 	u32 bss_mode;
 	u32 pkt_tx_ctrl;
-	u16 tx_power_level;
-	u8 max_tx_power_level;
-	u8 min_tx_power_level;
 	u32 tx_ant;
 	u32 rx_ant;
 	u8 tx_rate;
@@ -950,6 +947,9 @@ struct mwifiex_adapter {
 	u8 config_bands;
 	u8 tx_lock_flag;
 	struct mwifiex_sleep_period sleep_period;
+	u8 max_tx_power_level;
+	u8 min_tx_power_level;
+	u16 tx_power_level;
 	u16 ps_mode;
 	u32 ps_state;
 	u8 need_to_wakeup;
@@ -1501,7 +1501,7 @@ int mwifiex_drv_set_power(struct mwifiex_private *priv, u32 *ps_mode);
 int mwifiex_drv_get_driver_version(struct mwifiex_adapter *adapter,
 				   char *version, int max_len);
 
-int mwifiex_set_tx_power(struct mwifiex_private *priv,
+int mwifiex_set_tx_power(struct mwifiex_adapter *adapter,
 			 struct mwifiex_power_cfg *power_cfg);
 
 int mwifiex_main_process(struct mwifiex_adapter *);
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
index 7f81e709bd6b7..87b4c552c4056 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
@@ -321,7 +321,7 @@ static int mwifiex_ret_tx_rate_cfg(struct mwifiex_private *priv,
  * Handling includes saving the maximum and minimum Tx power levels
  * in driver, as well as sending the values to user.
  */
-static int mwifiex_get_power_level(struct mwifiex_private *priv, void *data_buf)
+static int mwifiex_get_power_level(struct mwifiex_adapter *adapter, void *data_buf)
 {
 	int length, max_power = -1, min_power = -1;
 	struct mwifiex_types_power_group *pg_tlv_hdr;
@@ -353,8 +353,8 @@ static int mwifiex_get_power_level(struct mwifiex_private *priv, void *data_buf)
 
 		length -= sizeof(struct mwifiex_power_group);
 	}
-	priv->min_tx_power_level = (u8) min_power;
-	priv->max_tx_power_level = (u8) max_power;
+	adapter->min_tx_power_level = (u8) min_power;
+	adapter->max_tx_power_level = (u8) max_power;
 
 	return 0;
 }
@@ -366,10 +366,9 @@ static int mwifiex_get_power_level(struct mwifiex_private *priv, void *data_buf)
  * Handling includes changing the header fields into CPU format
  * and saving the current Tx power level in driver.
  */
-static int mwifiex_ret_tx_power_cfg(struct mwifiex_private *priv,
+static int mwifiex_ret_tx_power_cfg(struct mwifiex_adapter *adapter,
 				    struct host_cmd_ds_command *resp)
 {
-	struct mwifiex_adapter *adapter = priv->adapter;
 	struct host_cmd_ds_txpwr_cfg *txp_cfg = &resp->params.txp_cfg;
 	struct mwifiex_types_power_group *pg_tlv_hdr;
 	struct mwifiex_power_group *pg;
@@ -392,9 +391,9 @@ static int mwifiex_ret_tx_power_cfg(struct mwifiex_private *priv,
 	switch (action) {
 	case HostCmd_ACT_GEN_GET:
 		if (adapter->hw_status == MWIFIEX_HW_STATUS_INITIALIZING)
-			mwifiex_get_power_level(priv, pg_tlv_hdr);
+			mwifiex_get_power_level(adapter, pg_tlv_hdr);
 
-		priv->tx_power_level = (u16) pg->power_min;
+		adapter->tx_power_level = (u16) pg->power_min;
 		break;
 
 	case HostCmd_ACT_GEN_SET:
@@ -402,7 +401,7 @@ static int mwifiex_ret_tx_power_cfg(struct mwifiex_private *priv,
 			break;
 
 		if (pg->power_max == pg->power_min)
-			priv->tx_power_level = (u16) pg->power_min;
+			adapter->tx_power_level = (u16) pg->power_min;
 		break;
 	default:
 		mwifiex_dbg(adapter, ERROR,
@@ -412,8 +411,8 @@ static int mwifiex_ret_tx_power_cfg(struct mwifiex_private *priv,
 	}
 	mwifiex_dbg(adapter, INFO,
 		    "info: Current TxPower Level = %d, Max Power=%d, Min Power=%d\n",
-		    priv->tx_power_level, priv->max_tx_power_level,
-		    priv->min_tx_power_level);
+		    adapter->tx_power_level, adapter->max_tx_power_level,
+		    adapter->min_tx_power_level);
 
 	return 0;
 }
@@ -421,23 +420,23 @@ static int mwifiex_ret_tx_power_cfg(struct mwifiex_private *priv,
 /*
  * This function handles the command response of get RF Tx power.
  */
-static int mwifiex_ret_rf_tx_power(struct mwifiex_private *priv,
+static int mwifiex_ret_rf_tx_power(struct mwifiex_adapter *adapter,
 				   struct host_cmd_ds_command *resp)
 {
 	struct host_cmd_ds_rf_tx_pwr *txp = &resp->params.txp;
 	u16 action = le16_to_cpu(txp->action);
 
-	priv->tx_power_level = le16_to_cpu(txp->cur_level);
+	adapter->tx_power_level = le16_to_cpu(txp->cur_level);
 
 	if (action == HostCmd_ACT_GEN_GET) {
-		priv->max_tx_power_level = txp->max_power;
-		priv->min_tx_power_level = txp->min_power;
+		adapter->max_tx_power_level = txp->max_power;
+		adapter->min_tx_power_level = txp->min_power;
 	}
 
-	mwifiex_dbg(priv->adapter, INFO,
+	mwifiex_dbg(adapter, INFO,
 		    "Current TxPower Level=%d, Max Power=%d, Min Power=%d\n",
-		    priv->tx_power_level, priv->max_tx_power_level,
-		    priv->min_tx_power_level);
+		    adapter->tx_power_level, adapter->max_tx_power_level,
+		    adapter->min_tx_power_level);
 
 	return 0;
 }
@@ -1237,10 +1236,10 @@ int mwifiex_process_sta_cmdresp(struct mwifiex_private *priv, u16 cmdresp_no,
 	case HostCmd_CMD_802_11_BG_SCAN_CONFIG:
 		break;
 	case HostCmd_CMD_TXPWR_CFG:
-		ret = mwifiex_ret_tx_power_cfg(priv, resp);
+		ret = mwifiex_ret_tx_power_cfg(adapter, resp);
 		break;
 	case HostCmd_CMD_RF_TX_PWR:
-		ret = mwifiex_ret_rf_tx_power(priv, resp);
+		ret = mwifiex_ret_rf_tx_power(adapter, resp);
 		break;
 	case HostCmd_CMD_RF_ANTENNA:
 		ret = mwifiex_ret_rf_antenna(priv, resp);
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index c01ac5061a05c..ed9f75adcdea3 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -588,8 +588,8 @@ int mwifiex_get_bss_info(struct mwifiex_private *priv,
 
 	info->media_connected = priv->media_connected;
 
-	info->max_power_level = priv->max_tx_power_level;
-	info->min_power_level = priv->min_tx_power_level;
+	info->max_power_level = adapter->max_tx_power_level;
+	info->min_power_level = adapter->min_tx_power_level;
 
 	info->adhoc_state = priv->adhoc_state;
 
@@ -657,7 +657,7 @@ int mwifiex_drv_get_data_rate(struct mwifiex_private *priv, u32 *rate)
  *      - Modulation class HTBW20
  *      - Modulation class HTBW40
  */
-int mwifiex_set_tx_power(struct mwifiex_private *priv,
+int mwifiex_set_tx_power(struct mwifiex_adapter *adapter,
 			 struct mwifiex_power_cfg *power_cfg)
 {
 	int ret;
@@ -669,13 +669,13 @@ int mwifiex_set_tx_power(struct mwifiex_private *priv,
 
 	if (!power_cfg->is_power_auto) {
 		dbm = (u16) power_cfg->power_level;
-		if ((dbm < priv->min_tx_power_level) ||
-		    (dbm > priv->max_tx_power_level)) {
-			mwifiex_dbg(priv->adapter, ERROR,
+		if ((dbm < adapter->min_tx_power_level) ||
+		    (dbm > adapter->max_tx_power_level)) {
+			mwifiex_dbg(adapter, ERROR,
 				    "txpower value %d dBm\t"
 				    "is out of range (%d dBm-%d dBm)\n",
-				    dbm, priv->min_tx_power_level,
-				    priv->max_tx_power_level);
+				    dbm, adapter->min_tx_power_level,
+				    adapter->max_tx_power_level);
 			return -1;
 		}
 	}
@@ -687,7 +687,7 @@ int mwifiex_set_tx_power(struct mwifiex_private *priv,
 	txp_cfg->action = cpu_to_le16(HostCmd_ACT_GEN_SET);
 	if (!power_cfg->is_power_auto) {
 		u16 dbm_min = power_cfg->is_power_fixed ?
-			      dbm : priv->min_tx_power_level;
+			      dbm : adapter->min_tx_power_level;
 
 		txp_cfg->mode = cpu_to_le32(1);
 		pg_tlv = (struct mwifiex_types_power_group *)
@@ -732,8 +732,8 @@ int mwifiex_set_tx_power(struct mwifiex_private *priv,
 		pg->power_max = (s8) dbm;
 		pg->ht_bandwidth = HT_BW_40;
 	}
-	ret = mwifiex_send_cmd(priv, HostCmd_CMD_TXPWR_CFG,
-			       HostCmd_ACT_GEN_SET, 0, buf, true);
+	ret = mwifiex_adapter_send_cmd(adapter, HostCmd_CMD_TXPWR_CFG,
+				       HostCmd_ACT_GEN_SET, 0, buf, true);
 
 	kfree(buf);
 	return ret;

-- 
2.39.2



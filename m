Return-Path: <linux-wireless+bounces-11685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2973E958668
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC241F24E8B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D8818F2D5;
	Tue, 20 Aug 2024 12:00:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D81318F2F4
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155234; cv=none; b=TsNPHi+j1HlIaXbTjaDpVJu6CjWH7+l0wfIX9DZRVKiZ7dUuOaTg3G3DIpu1Ks+fH3P3qZK10fQr2J7qRRnSR8yn4HvDL4UH2nOb+3vP9aPLU4s+TCHJDEPdMvxihYS45JD/crnbOkVUdaGeK3OVAHlO61aAkXABt0y9bRjWBQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155234; c=relaxed/simple;
	bh=KkjdiOp7h9kGCcGqG0lJJWcoVvNY6hz2UpwrIQN8aJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DA1Ejh855OCOpgkFAFvc1OI5NEAyw6Xoso2WpYBkWm2cf24JyqiQjldt6+ZFJJj2TdnzyJPzrjgR95YdWgb1ljy0VcnvTiSt9aZz983fKfwHPqwoQ0Sj1avpRTPNr1DhTAKKEF/fegWYJcCFmcK61f9mWMCNyLioQUzeI6jDy7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-0000w8-WE; Tue, 20 Aug 2024 14:00:27 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-001lNY-Gg; Tue, 20 Aug 2024 14:00:26 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1Y;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:53 +0200
Subject: [PATCH 28/31] wifi: mwifiex: move rx_ant/tx_ant to adapter
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-28-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=4813;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=KkjdiOp7h9kGCcGqG0lJJWcoVvNY6hz2UpwrIQN8aJI=;
 b=OqrPKiaweYcUdwJBkSVfsB2YPHraoNPXkHrA/UjePyV5FzG6CVRJTTlrTfrfgAvfSAfO0/HD4
 PFl/zxeyLlkAI5berNTFqkWR8Vfx2AwCniZboT//+5KoDHHuFWO7eYU
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

The antenna settings are specific to the adapter, not to the priv, so
use adapter as context pointer and use mwifiex_adapter_send_cmd()
instead of mwifiex_send_cmd().

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    | 11 +++++------
 drivers/net/wireless/marvell/mwifiex/init.c        |  2 --
 drivers/net/wireless/marvell/mwifiex/main.h        |  4 ++--
 drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c | 13 ++++++-------
 4 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index b341b36bc7395..a704886049c64 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1867,13 +1867,12 @@ static int
 mwifiex_cfg80211_get_antenna(struct wiphy *wiphy, u32 *tx_ant, u32 *rx_ant)
 {
 	struct mwifiex_adapter *adapter = mwifiex_cfg80211_get_adapter(wiphy);
-	struct mwifiex_private *priv = mwifiex_get_priv(adapter,
-							MWIFIEX_BSS_ROLE_ANY);
-	mwifiex_send_cmd(priv, HostCmd_CMD_RF_ANTENNA,
-			 HostCmd_ACT_GEN_GET, 0, NULL, true);
 
-	*tx_ant = priv->tx_ant;
-	*rx_ant = priv->rx_ant;
+	mwifiex_adapter_send_cmd(adapter, HostCmd_CMD_RF_ANTENNA,
+				 HostCmd_ACT_GEN_GET, 0, NULL, true);
+
+	*tx_ant = adapter->tx_ant;
+	*rx_ant = adapter->rx_ant;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index a2296c0d91534..ae79eb500ae13 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -105,8 +105,6 @@ int mwifiex_init_priv(struct mwifiex_private *priv)
 	priv->adhoc_channel = DEFAULT_AD_HOC_CHANNEL;
 	priv->atim_window = 0;
 	priv->adhoc_state = ADHOC_IDLE;
-	priv->tx_ant = 0;
-	priv->rx_ant = 0;
 	priv->tx_rate = 0;
 	priv->rxpd_htinfo = 0;
 	priv->rxpd_rate = 0;
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index c51b9a5766150..0098bae832885 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -542,8 +542,6 @@ struct mwifiex_private {
 	u32 curr_pkt_filter;
 	u32 bss_mode;
 	u32 pkt_tx_ctrl;
-	u32 tx_ant;
-	u32 rx_ant;
 	u8 tx_rate;
 	u8 tx_htinfo;
 	u8 rxpd_htinfo;
@@ -950,6 +948,8 @@ struct mwifiex_adapter {
 	u8 max_tx_power_level;
 	u8 min_tx_power_level;
 	u16 tx_power_level;
+	u32 tx_ant;
+	u32 rx_ant;
 	u16 ps_mode;
 	u32 ps_state;
 	u8 need_to_wakeup;
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
index 87b4c552c4056..de6a623174701 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
@@ -444,16 +444,15 @@ static int mwifiex_ret_rf_tx_power(struct mwifiex_adapter *adapter,
 /*
  * This function handles the command response of set rf antenna
  */
-static int mwifiex_ret_rf_antenna(struct mwifiex_private *priv,
+static int mwifiex_ret_rf_antenna(struct mwifiex_adapter *adapter,
 				  struct host_cmd_ds_command *resp)
 {
 	struct host_cmd_ds_rf_ant_mimo *ant_mimo = &resp->params.ant_mimo;
 	struct host_cmd_ds_rf_ant_siso *ant_siso = &resp->params.ant_siso;
-	struct mwifiex_adapter *adapter = priv->adapter;
 
 	if (adapter->hw_dev_mcs_support == HT_STREAM_2X2) {
-		priv->tx_ant = le16_to_cpu(ant_mimo->tx_ant_mode);
-		priv->rx_ant = le16_to_cpu(ant_mimo->rx_ant_mode);
+		adapter->tx_ant = le16_to_cpu(ant_mimo->tx_ant_mode);
+		adapter->rx_ant = le16_to_cpu(ant_mimo->rx_ant_mode);
 		mwifiex_dbg(adapter, INFO,
 			    "RF_ANT_RESP: Tx action = 0x%x, Tx Mode = 0x%04x\t"
 			    "Rx action = 0x%x, Rx Mode = 0x%04x\n",
@@ -462,8 +461,8 @@ static int mwifiex_ret_rf_antenna(struct mwifiex_private *priv,
 			    le16_to_cpu(ant_mimo->action_rx),
 			    le16_to_cpu(ant_mimo->rx_ant_mode));
 	} else {
-		priv->tx_ant = le16_to_cpu(ant_siso->ant_mode);
-		priv->rx_ant = le16_to_cpu(ant_siso->ant_mode);
+		adapter->tx_ant = le16_to_cpu(ant_siso->ant_mode);
+		adapter->rx_ant = le16_to_cpu(ant_siso->ant_mode);
 		mwifiex_dbg(adapter, INFO,
 			    "RF_ANT_RESP: action = 0x%x, Mode = 0x%04x\n",
 			    le16_to_cpu(ant_siso->action),
@@ -1242,7 +1241,7 @@ int mwifiex_process_sta_cmdresp(struct mwifiex_private *priv, u16 cmdresp_no,
 		ret = mwifiex_ret_rf_tx_power(adapter, resp);
 		break;
 	case HostCmd_CMD_RF_ANTENNA:
-		ret = mwifiex_ret_rf_antenna(priv, resp);
+		ret = mwifiex_ret_rf_antenna(adapter, resp);
 		break;
 	case HostCmd_CMD_802_11_PS_MODE_ENH:
 		ret = mwifiex_ret_enh_power_mode(priv, resp, data_buf);

-- 
2.39.2



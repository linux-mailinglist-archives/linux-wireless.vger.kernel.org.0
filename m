Return-Path: <linux-wireless+bounces-11697-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AA0958675
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E1A288F1F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981A41917DD;
	Tue, 20 Aug 2024 12:00:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AE818FC63
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155236; cv=none; b=jWeIqnnDqVHuuyvalxTbBggDEZ5q8FOnGjk9IOgk/POkbZI2nOO+ccrZurGcWECd/7nR3UtGF2ufrfQ3BfOmY7/KhPq8LKifXufdyS4EDJsiqAup9vNsFcpJG6HWpa3zCqyA7vYth5v6y/cOn0wDB1X3wp82Qy+ZCsUw9IwvA2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155236; c=relaxed/simple;
	bh=9X8SO+JYHum8BIevtxJ8U6Zsv0Zl9cCM2zo/USbNvo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SAs8esSGOivpd5++ZBHKOma4j6lK3kMwgdlX2p1K/LtXz3D2BiIxVyj2K8d/6bGi5oKEdIkFTU2o79u9qp+UV/tw0xkY7/TwNvWNGtfOUvgbKcsTlJvngkWkXrcc9HuLWEELnl3IuCYdo0grwjHKzYVJbzzubYFSw72NTML6pVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXH-0000wT-3h; Tue, 20 Aug 2024 14:00:27 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-001lNc-JN; Tue, 20 Aug 2024 14:00:26 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1U;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:49 +0200
Subject: [PATCH 24/31] wifi: mwifiex: make txpwr specific to adapter
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-24-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=5604;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=9X8SO+JYHum8BIevtxJ8U6Zsv0Zl9cCM2zo/USbNvo0=;
 b=Wmupbcafez0xuXE4f18yvOD+T1euZld73ZPmP49mEC+GWD9xsI8gbjYVYElIIdIWwhJ1hNGGE
 gNUzdkyp1HeAnV/Dorg1fCulYrQY2CTui9hCJd9SBzi98AF+vnkX9r0
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

The txpwr settings are for the whole adapter, not for a single priv,
so pass the adapter to the relevant functions and use
mwifiex_adapter_send_cmd() instead of mwifiex_send_cmd().

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c  |  5 ++---
 drivers/net/wireless/marvell/mwifiex/main.h      |  4 ++--
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c   | 10 +++++-----
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c | 10 +++++-----
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c   |  2 +-
 5 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 5c8232b5a8c7d..35fb86b4cb8d5 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -657,8 +657,7 @@ static void mwifiex_reg_notifier(struct wiphy *wiphy,
 				 struct regulatory_request *request)
 {
 	struct mwifiex_adapter *adapter = mwifiex_cfg80211_get_adapter(wiphy);
-	struct mwifiex_private *priv = mwifiex_get_priv(adapter,
-							MWIFIEX_BSS_ROLE_ANY);
+
 	mwifiex_dbg(adapter, INFO,
 		    "info: cfg80211 regulatory domain callback for %c%c\n",
 		    request->alpha2[0], request->alpha2[1]);
@@ -684,7 +683,7 @@ static void mwifiex_reg_notifier(struct wiphy *wiphy,
 		memcpy(adapter->country_code, request->alpha2,
 		       sizeof(request->alpha2));
 		mwifiex_send_domain_info_cmd_fw(wiphy);
-		mwifiex_dnld_txpwr_table(priv);
+		mwifiex_dnld_txpwr_table(adapter);
 	}
 }
 
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 298726c663724..c51b9a5766150 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1554,9 +1554,9 @@ int mwifiex_11h_activate(struct mwifiex_private *priv, bool flag);
 void mwifiex_11h_process_join(struct mwifiex_private *priv, u8 **buffer,
 			      struct mwifiex_bssdescriptor *bss_desc);
 int mwifiex_11h_handle_event_chanswann(struct mwifiex_private *priv);
-int mwifiex_dnld_dt_cfgdata(struct mwifiex_private *priv,
+int mwifiex_dnld_dt_cfgdata(struct mwifiex_adapter *adapter,
 			    struct device_node *node, const char *prefix);
-void mwifiex_dnld_txpwr_table(struct mwifiex_private *priv);
+void mwifiex_dnld_txpwr_table(struct mwifiex_adapter *adapter);
 
 extern const struct ethtool_ops mwifiex_ethtool_ops;
 
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index 30dd4e58e2b1d..bf081278000a7 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -1455,7 +1455,7 @@ static u32 mwifiex_parse_cal_cfg(u8 *src, size_t len, u8 *dst)
 	return d - dst;
 }
 
-int mwifiex_dnld_dt_cfgdata(struct mwifiex_private *priv,
+int mwifiex_dnld_dt_cfgdata(struct mwifiex_adapter *adapter,
 			    struct device_node *node, const char *prefix)
 {
 #ifdef CONFIG_OF
@@ -1472,9 +1472,9 @@ int mwifiex_dnld_dt_cfgdata(struct mwifiex_private *priv,
 		/* property header is 6 bytes, data must fit in cmd buffer */
 		if (prop->value && prop->length > 6 &&
 		    prop->length <= MWIFIEX_SIZE_OF_CMD_BUFFER - S_DS_GEN) {
-			ret = mwifiex_send_cmd(priv, HostCmd_CMD_CFG_DATA,
-					       HostCmd_ACT_GEN_SET, 0,
-					       prop, true);
+			ret = mwifiex_adapter_send_cmd(adapter, HostCmd_CMD_CFG_DATA,
+						       HostCmd_ACT_GEN_SET, 0,
+						       prop, true);
 			if (ret)
 				return ret;
 		}
@@ -2274,7 +2274,7 @@ int mwifiex_sta_init_cmd(struct mwifiex_private *priv, u8 first_sta, bool init)
 				adapter->hs_cfg.gpio = data;
 			}
 
-			mwifiex_dnld_dt_cfgdata(priv, adapter->dt_node,
+			mwifiex_dnld_dt_cfgdata(adapter, adapter->dt_node,
 						"marvell,caldata");
 		}
 
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index 3586def45adae..1a8a60c1c2e67 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -180,13 +180,13 @@ int mwifiex_fill_new_bss_desc(struct mwifiex_private *priv,
 	return mwifiex_update_bss_desc_with_ie(priv->adapter, bss_desc);
 }
 
-void mwifiex_dnld_txpwr_table(struct mwifiex_private *priv)
+void mwifiex_dnld_txpwr_table(struct mwifiex_adapter *adapter)
 {
-	if (priv->adapter->dt_node) {
+	if (adapter->dt_node) {
 		char txpwr[] = {"marvell,00_txpwrlimit"};
 
-		memcpy(&txpwr[8], priv->adapter->country_code, 2);
-		mwifiex_dnld_dt_cfgdata(priv, priv->adapter->dt_node, txpwr);
+		memcpy(&txpwr[8], adapter->country_code, 2);
+		mwifiex_dnld_dt_cfgdata(adapter, adapter->dt_node, txpwr);
 	}
 }
 
@@ -249,7 +249,7 @@ static int mwifiex_process_country_ie(struct mwifiex_private *priv,
 		return -1;
 	}
 
-	mwifiex_dnld_txpwr_table(priv);
+	mwifiex_dnld_txpwr_table(priv->adapter);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index 1c0ceac6b27fb..e016ca25ff5a9 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -1029,7 +1029,7 @@ void mwifiex_uap_set_channel(struct mwifiex_private *priv,
 
 	if (old_bands != config_bands) {
 		mwifiex_send_domain_info_cmd_fw(priv->adapter->wiphy);
-		mwifiex_dnld_txpwr_table(priv);
+		mwifiex_dnld_txpwr_table(priv->adapter);
 	}
 }
 

-- 
2.39.2



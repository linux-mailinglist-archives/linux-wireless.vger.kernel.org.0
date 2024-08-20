Return-Path: <linux-wireless+bounces-11698-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD5A958683
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767D72892CD
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A71918F2DA;
	Tue, 20 Aug 2024 12:00:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D7C191F9B
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155240; cv=none; b=gv4nYYohSzF0+54d7VEAnvaFCnH4ZE0M7I70q/ZBe5OasbYc0J+xU8h3+ALvmFoP/gRfhi0Gy4/jxfsCXhv4p2Z0cIqDDoO1ixw59QQloGOoCwFZECjwtofsx5jOgD+fcDbEy2aPlEhsQQvhDA3Lc8ywdwZgNPMqGztg6N58atc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155240; c=relaxed/simple;
	bh=AsLPSKsgMMas0Su/h1eS8Xse0HWcoiFEKU1EdN43vGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gJbRLKhBOK8RcW30MMLj1Gxb40xiCT/VKax8vWm8J5X7U9k3sXUYurnJv2iVjrnaY0OPz75sZM6n7yjJFQzmG2gC0ccUNIFChGG0HxcIFqEkr+XYjTQJq4ICoVLd6VTP1gTt/aIbx7UBgj+IA8AT3a4W/eegQVe0Ki8CL5ip7/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-0000tf-08; Tue, 20 Aug 2024 14:00:26 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXF-001lMv-F4; Tue, 20 Aug 2024 14:00:25 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1Q;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:45 +0200
Subject: [PATCH 20/31] wifi: mwifiex: pass adapter to host sleep functions
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-20-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=10913;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=AsLPSKsgMMas0Su/h1eS8Xse0HWcoiFEKU1EdN43vGg=;
 b=vsL1Q4TxTBHQfJLyE1GvRMumCUn079MBNN6sX/155c3ead+/Oz5JZ73/t9CWGcin4N3E05W6F
 +oXiwm4tKMYBH3/JCc1IRWsBsiauSxBfNSf8flP+PC9WvlCJ5+hReGv
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

The host sleep functions have effect on the adapter as a whole and
not to the priv *, so pass the adapter to these functions and use
mwifiex_adapter_send_cmd() to send the commands.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c  |  2 +-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c    |  9 ++++-----
 drivers/net/wireless/marvell/mwifiex/debugfs.c   |  8 ++++----
 drivers/net/wireless/marvell/mwifiex/main.c      |  9 +++------
 drivers/net/wireless/marvell/mwifiex/main.h      |  4 ++--
 drivers/net/wireless/marvell/mwifiex/pcie.c      |  3 +--
 drivers/net/wireless/marvell/mwifiex/sdio.c      |  3 +--
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c | 12 +++++-------
 drivers/net/wireless/marvell/mwifiex/usb.c       |  4 +---
 9 files changed, 22 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 8efb3b444cabc..ffdd2b8e5f955 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -3392,7 +3392,7 @@ static int mwifiex_cfg80211_suspend(struct wiphy *wiphy,
 	hs_cfg.is_invoke_hostcmd = false;
 	hs_cfg.gpio = adapter->hs_cfg.gpio;
 	hs_cfg.gap = adapter->hs_cfg.gap;
-	ret = mwifiex_set_hs_params(sta_priv, HostCmd_ACT_GEN_SET,
+	ret = mwifiex_set_hs_params(adapter, HostCmd_ACT_GEN_SET,
 				    MWIFIEX_SYNC_CMD, &hs_cfg);
 	if (ret)
 		mwifiex_dbg(adapter, ERROR, "Failed to set HS params\n");
diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 445fca5c43a6c..400f1785d0d9e 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -591,10 +591,10 @@ int mwifiex_send_cmd(struct mwifiex_private *priv, u16 cmd_no,
 		return -1;
 	}
 
-	if (priv->adapter->hs_activated_manually &&
+	if (adapter->hs_activated_manually &&
 	    cmd_no != HostCmd_CMD_802_11_HS_CFG_ENH) {
-		mwifiex_cancel_hs(priv, MWIFIEX_ASYNC_CMD);
-		priv->adapter->hs_activated_manually = false;
+		mwifiex_cancel_hs(adapter, MWIFIEX_ASYNC_CMD);
+		adapter->hs_activated_manually = false;
 	}
 
 	/* Get a new command node */
@@ -1251,8 +1251,7 @@ mwifiex_process_hs_config(struct mwifiex_adapter *adapter)
 	adapter->if_ops.wakeup(adapter);
 
 	if (adapter->hs_activated_manually) {
-		mwifiex_cancel_hs(mwifiex_get_priv (adapter, MWIFIEX_BSS_ROLE_ANY),
-				  MWIFIEX_ASYNC_CMD);
+		mwifiex_cancel_hs(adapter, MWIFIEX_ASYNC_CMD);
 		adapter->hs_activated_manually = false;
 	}
 
diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c b/drivers/net/wireless/marvell/mwifiex/debugfs.c
index 9deaf59dcb625..ed6d49418ca6d 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -783,12 +783,12 @@ mwifiex_hscfg_write(struct file *file, const char __user *ubuf,
 	}
 
 	if (arg_num >= 1 && arg_num < 3)
-		mwifiex_set_hs_params(priv, HostCmd_ACT_GEN_GET,
+		mwifiex_set_hs_params(priv->adapter, HostCmd_ACT_GEN_GET,
 				      MWIFIEX_SYNC_CMD, &hscfg);
 
 	if (arg_num) {
 		if (conditions == HS_CFG_CANCEL) {
-			mwifiex_cancel_hs(priv, MWIFIEX_ASYNC_CMD);
+			mwifiex_cancel_hs(priv->adapter, MWIFIEX_ASYNC_CMD);
 			ret = count;
 			goto done;
 		}
@@ -800,7 +800,7 @@ mwifiex_hscfg_write(struct file *file, const char __user *ubuf,
 		hscfg.gap = gap;
 
 	hscfg.is_invoke_hostcmd = false;
-	mwifiex_set_hs_params(priv, HostCmd_ACT_GEN_SET,
+	mwifiex_set_hs_params(priv->adapter, HostCmd_ACT_GEN_SET,
 			      MWIFIEX_SYNC_CMD, &hscfg);
 
 	mwifiex_enable_hs(priv->adapter);
@@ -828,7 +828,7 @@ mwifiex_hscfg_read(struct file *file, char __user *ubuf,
 	if (!buf)
 		return -ENOMEM;
 
-	mwifiex_set_hs_params(priv, HostCmd_ACT_GEN_GET,
+	mwifiex_set_hs_params(priv->adapter, HostCmd_ACT_GEN_GET,
 			      MWIFIEX_SYNC_CMD, &hscfg);
 
 	pos = snprintf(buf, PAGE_SIZE, "%u 0x%x 0x%x\n", hscfg.conditions,
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 6f4815f83af84..f42d537cc6ce0 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -401,8 +401,7 @@ int mwifiex_main_process(struct mwifiex_adapter *adapter)
 		    !adapter->data_sent &&
 		    !skb_queue_empty(&adapter->tx_data_q)) {
 			if (adapter->hs_activated_manually) {
-				mwifiex_cancel_hs(mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY),
-						  MWIFIEX_ASYNC_CMD);
+				mwifiex_cancel_hs(adapter, MWIFIEX_ASYNC_CMD);
 				adapter->hs_activated_manually = false;
 			}
 
@@ -420,8 +419,7 @@ int mwifiex_main_process(struct mwifiex_adapter *adapter)
 		    !mwifiex_bypass_txlist_empty(adapter) &&
 		    !mwifiex_is_tdls_chan_switching(adapter)) {
 			if (adapter->hs_activated_manually) {
-				mwifiex_cancel_hs(mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY),
-						  MWIFIEX_ASYNC_CMD);
+				mwifiex_cancel_hs(adapter, MWIFIEX_ASYNC_CMD);
 				adapter->hs_activated_manually = false;
 			}
 
@@ -438,8 +436,7 @@ int mwifiex_main_process(struct mwifiex_adapter *adapter)
 		    !adapter->data_sent && !mwifiex_wmm_lists_empty(adapter) &&
 		    !mwifiex_is_tdls_chan_switching(adapter)) {
 			if (adapter->hs_activated_manually) {
-				mwifiex_cancel_hs(mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY),
-						  MWIFIEX_ASYNC_CMD);
+				mwifiex_cancel_hs(adapter, MWIFIEX_ASYNC_CMD);
 				adapter->hs_activated_manually = false;
 			}
 
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index bd8bf1f5e2653..8ca770738d08e 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1133,7 +1133,7 @@ int mwifiex_ret_enh_power_mode(struct mwifiex_private *priv,
 void mwifiex_process_hs_config(struct mwifiex_adapter *adapter);
 void mwifiex_hs_activated_event(struct mwifiex_adapter *adapter,
 					u8 activated);
-int mwifiex_set_hs_params(struct mwifiex_private *priv, u16 action,
+int mwifiex_set_hs_params(struct mwifiex_adapter *adapter, u16 action,
 			  int cmd_type, struct mwifiex_ds_hs_cfg *hs_cfg);
 int mwifiex_ret_802_11_hs_cfg(struct mwifiex_private *priv,
 			      struct host_cmd_ds_command *resp);
@@ -1454,7 +1454,7 @@ int mwifiex_wait_queue_complete(struct mwifiex_adapter *adapter,
 				struct cmd_ctrl_node *cmd_queued);
 int mwifiex_bss_start(struct mwifiex_private *priv, struct cfg80211_bss *bss,
 		      struct cfg80211_ssid *req_ssid);
-int mwifiex_cancel_hs(struct mwifiex_private *priv, int cmd_type);
+int mwifiex_cancel_hs(struct mwifiex_adapter *adapter, int cmd_type);
 int mwifiex_enable_hs(struct mwifiex_adapter *adapter);
 int mwifiex_disable_auto_ds(struct mwifiex_private *priv);
 int mwifiex_drv_get_data_rate(struct mwifiex_private *priv, u32 *rate);
diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index 5f997becdbaa2..a25f90034e38d 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -359,8 +359,7 @@ static int mwifiex_pcie_resume(struct device *dev)
 
 	clear_bit(MWIFIEX_IS_SUSPENDED, &adapter->work_flags);
 
-	mwifiex_cancel_hs(mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_STA),
-			  MWIFIEX_ASYNC_CMD);
+	mwifiex_cancel_hs(adapter, MWIFIEX_ASYNC_CMD);
 	mwifiex_disable_wake(adapter);
 
 	return 0;
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 490ffd981164d..18ed5015064db 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -654,8 +654,7 @@ static int mwifiex_sdio_resume(struct device *dev)
 	clear_bit(MWIFIEX_IS_SUSPENDED, &adapter->work_flags);
 
 	/* Disable Host Sleep */
-	mwifiex_cancel_hs(mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_STA),
-			  MWIFIEX_SYNC_CMD);
+	mwifiex_cancel_hs(adapter, MWIFIEX_SYNC_CMD);
 
 	mwifiex_disable_wake(adapter);
 
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index aa138cab7bea9..c01ac5061a05c 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -395,11 +395,10 @@ int mwifiex_bss_start(struct mwifiex_private *priv, struct cfg80211_bss *bss,
  * This function prepares the correct firmware command and
  * issues it.
  */
-int mwifiex_set_hs_params(struct mwifiex_private *priv, u16 action,
+int mwifiex_set_hs_params(struct mwifiex_adapter *adapter, u16 action,
 			  int cmd_type, struct mwifiex_ds_hs_cfg *hs_cfg)
 
 {
-	struct mwifiex_adapter *adapter = priv->adapter;
 	int status = 0;
 	u32 prev_cond = 0;
 
@@ -440,7 +439,7 @@ int mwifiex_set_hs_params(struct mwifiex_private *priv, u16 action,
 				break;
 			}
 
-			status = mwifiex_send_cmd(priv,
+			status = mwifiex_adapter_send_cmd(adapter,
 						  HostCmd_CMD_802_11_HS_CFG_ENH,
 						  HostCmd_ACT_GEN_SET, 0,
 						  &adapter->hs_cfg,
@@ -476,14 +475,14 @@ int mwifiex_set_hs_params(struct mwifiex_private *priv, u16 action,
  * This function allocates the IOCTL request buffer, fills it
  * with requisite parameters and calls the IOCTL handler.
  */
-int mwifiex_cancel_hs(struct mwifiex_private *priv, int cmd_type)
+int mwifiex_cancel_hs(struct mwifiex_adapter *adapter, int cmd_type)
 {
 	struct mwifiex_ds_hs_cfg hscfg;
 
 	hscfg.conditions = HS_CFG_CANCEL;
 	hscfg.is_invoke_hostcmd = true;
 
-	return mwifiex_set_hs_params(priv, HostCmd_ACT_GEN_SET,
+	return mwifiex_set_hs_params(adapter, HostCmd_ACT_GEN_SET,
 				    cmd_type, &hscfg);
 }
 EXPORT_SYMBOL_GPL(mwifiex_cancel_hs);
@@ -539,8 +538,7 @@ int mwifiex_enable_hs(struct mwifiex_adapter *adapter)
 	set_bit(MWIFIEX_IS_HS_ENABLING, &adapter->work_flags);
 	mwifiex_cancel_all_pending_cmd(adapter);
 
-	if (mwifiex_set_hs_params(mwifiex_get_priv(adapter,
-						   MWIFIEX_BSS_ROLE_STA),
+	if (mwifiex_set_hs_params(adapter,
 				  HostCmd_ACT_GEN_SET, MWIFIEX_SYNC_CMD,
 				  &hscfg)) {
 		mwifiex_dbg(adapter, ERROR,
diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
index 6085cd50970d4..520ea4bc9a3fb 100644
--- a/drivers/net/wireless/marvell/mwifiex/usb.c
+++ b/drivers/net/wireless/marvell/mwifiex/usb.c
@@ -637,9 +637,7 @@ static int mwifiex_usb_resume(struct usb_interface *intf)
 
 	/* Disable Host Sleep */
 	if (adapter->hs_activated)
-		mwifiex_cancel_hs(mwifiex_get_priv(adapter,
-						   MWIFIEX_BSS_ROLE_ANY),
-				  MWIFIEX_ASYNC_CMD);
+		mwifiex_cancel_hs(adapter, MWIFIEX_ASYNC_CMD);
 
 	return 0;
 }

-- 
2.39.2



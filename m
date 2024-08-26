Return-Path: <linux-wireless+bounces-11976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 553E595EF7D
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA692B21D69
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C331537D9;
	Mon, 26 Aug 2024 11:12:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E941482F5
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724670721; cv=none; b=YtUCI+7/HvU12dw2boJPK3Z/kha5k6VZWiF9rr8QDc+hi5eVWYKLE8hWduTTbU6k8f09tEx62xcDQTRK2g52B+j4hWcW6mV0pxJVKqoXNev5D4gus9vfMrqbPHeXnQQdyeslLWZ3q8SLoP8zxGzgQGZ+Evf0UwdJl3BWx5navSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724670721; c=relaxed/simple;
	bh=zJE1XRr4+JUQqLAGI3hvzbuF0ANKhlUzHzqJoFGQqA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qXTbrUOonfXfaVOuseWxdI4EvTL2W85Om1VqDCe+DuD14ZPmik+IuclkM82qrh8P4vZU2KNmbKiS/IRY2Wg4w53AgUrmRZol1HDLbp/bOAWslCvdTr6DysncHMZpdqiZC7+91ZuuP3kaIqUHH5g2bxjMGchOywSJB/DfAJo4O0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXdc-0005UB-NU; Mon, 26 Aug 2024 13:11:56 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXdc-003AwZ-9D; Mon, 26 Aug 2024 13:11:56 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXTX-004aRi-32;
	Mon, 26 Aug 2024 13:01:31 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 26 Aug 2024 13:01:33 +0200
Subject: [PATCH 12/12] wifi: mwifiex: drop asynchronous init waiting code
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-mwifiex-cleanup-1-v1-12-56e6f8e056ec@pengutronix.de>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
In-Reply-To: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724670091; l=8821;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=zJE1XRr4+JUQqLAGI3hvzbuF0ANKhlUzHzqJoFGQqA8=;
 b=Tm6zHL0XtdeGUlX18sHpQdUvUt4beHKgGEpolkaOIrGRbu81VOT2U/hO3DRb5L73mPGAOw54c
 cfgDgca0TIiCGMoc386cVZ97ifv3xCJhwCp17VxNL+BK5N+ZQ8BpfDF
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Historically all commands sent to the mwifiex driver have been
asynchronous. For this reason there is code that waits for the
last initialization command to complete before going on. Nowadays the
commands can be sent synchronously, meaning that they are completed
when the command call returns. This makes all the waiting code
unnecessary. It is removed in this patch.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c  | 16 ----------------
 drivers/net/wireless/marvell/mwifiex/init.c    | 18 +++++-------------
 drivers/net/wireless/marvell/mwifiex/main.c    | 25 +++----------------------
 drivers/net/wireless/marvell/mwifiex/main.h    |  6 ------
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c |  6 ------
 drivers/net/wireless/marvell/mwifiex/util.c    | 18 ------------------
 6 files changed, 8 insertions(+), 81 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 402531a03ece3..8a614dc993b2c 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -892,18 +892,6 @@ int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter)
 		ret = mwifiex_process_sta_cmdresp(priv, cmdresp_no, resp);
 	}
 
-	/* Check init command response */
-	if (adapter->hw_status == MWIFIEX_HW_STATUS_INITIALIZING) {
-		if (ret) {
-			mwifiex_dbg(adapter, ERROR,
-				    "%s: cmd %#x failed during\t"
-				    "initialization\n", __func__, cmdresp_no);
-			mwifiex_init_fw_complete(adapter);
-			return -1;
-		} else if (adapter->last_init_cmd == cmdresp_no)
-			adapter->hw_status = MWIFIEX_HW_STATUS_INIT_DONE;
-	}
-
 	if (adapter->curr_cmd) {
 		if (adapter->curr_cmd->wait_q_enabled)
 			adapter->cmd_wait_q.status = ret;
@@ -1022,10 +1010,6 @@ mwifiex_cmd_timeout_func(struct timer_list *t)
 			mwifiex_cancel_pending_ioctl(adapter);
 		}
 	}
-	if (adapter->hw_status == MWIFIEX_HW_STATUS_INITIALIZING) {
-		mwifiex_init_fw_complete(adapter);
-		return;
-	}
 
 	if (adapter->if_ops.device_dump)
 		adapter->if_ops.device_dump(adapter);
diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index 0259c9f88486b..b27596c7c02cb 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -486,7 +486,6 @@ int mwifiex_init_fw(struct mwifiex_adapter *adapter)
 	int ret;
 	struct mwifiex_private *priv;
 	u8 i, first_sta = true;
-	int is_cmd_pend_q_empty;
 
 	adapter->hw_status = MWIFIEX_HW_STATUS_INITIALIZING;
 
@@ -508,7 +507,6 @@ int mwifiex_init_fw(struct mwifiex_adapter *adapter)
 	}
 	if (adapter->mfg_mode) {
 		adapter->hw_status = MWIFIEX_HW_STATUS_READY;
-		ret = -EINPROGRESS;
 	} else {
 		for (i = 0; i < adapter->priv_num; i++) {
 			ret = mwifiex_sta_init_cmd(adapter->priv[i],
@@ -520,18 +518,12 @@ int mwifiex_init_fw(struct mwifiex_adapter *adapter)
 		}
 	}
 
-	spin_lock_bh(&adapter->cmd_pending_q_lock);
-	is_cmd_pend_q_empty = list_empty(&adapter->cmd_pending_q);
-	spin_unlock_bh(&adapter->cmd_pending_q_lock);
-	if (!is_cmd_pend_q_empty) {
-		/* Send the first command in queue and return */
-		if (mwifiex_main_process(adapter) != -1)
-			ret = -EINPROGRESS;
-	} else {
-		adapter->hw_status = MWIFIEX_HW_STATUS_READY;
-	}
+	adapter->hw_status = MWIFIEX_HW_STATUS_READY;
 
-	return ret;
+	if (adapter->if_ops.init_fw_port)
+		adapter->if_ops.init_fw_port(adapter);
+
+	return 0;
 }
 
 /*
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 588887aa29a79..63344e2e03656 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -354,13 +354,6 @@ int mwifiex_main_process(struct mwifiex_adapter *adapter)
 		if (adapter->cmd_resp_received) {
 			adapter->cmd_resp_received = false;
 			mwifiex_process_cmdresp(adapter);
-
-			/* call mwifiex back when init_fw is done */
-			if (adapter->hw_status == MWIFIEX_HW_STATUS_INIT_DONE) {
-				adapter->hw_status = MWIFIEX_HW_STATUS_READY;
-				mwifiex_init_fw_complete(adapter);
-				maybe_quirk_fw_disable_ds(adapter);
-			}
 		}
 
 		/* Check if we need to confirm Sleep Request
@@ -578,21 +571,11 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 			goto err_dnld_fw;
 	}
 
-	adapter->init_wait_q_woken = false;
 	ret = mwifiex_init_fw(adapter);
-	if (ret == -1) {
+	if (ret < 0)
 		goto err_init_fw;
-	} else if (!ret) {
-		adapter->hw_status = MWIFIEX_HW_STATUS_READY;
-		goto done;
-	}
-	/* Wait for mwifiex_init to complete */
-	if (!adapter->mfg_mode) {
-		wait_event_interruptible(adapter->init_wait_q,
-					 adapter->init_wait_q_woken);
-		if (adapter->hw_status != MWIFIEX_HW_STATUS_READY)
-			goto err_init_fw;
-	}
+
+	maybe_quirk_fw_disable_ds(adapter);
 
 	if (!adapter->wiphy) {
 		if (mwifiex_register_cfg80211(adapter)) {
@@ -1551,7 +1534,6 @@ mwifiex_reinit_sw(struct mwifiex_adapter *adapter)
 
 	adapter->hw_status = MWIFIEX_HW_STATUS_INITIALIZING;
 	clear_bit(MWIFIEX_SURPRISE_REMOVED, &adapter->work_flags);
-	init_waitqueue_head(&adapter->init_wait_q);
 	clear_bit(MWIFIEX_IS_SUSPENDED, &adapter->work_flags);
 	adapter->hs_activated = false;
 	clear_bit(MWIFIEX_IS_CMD_TIMEDOUT, &adapter->work_flags);
@@ -1719,7 +1701,6 @@ mwifiex_add_card(void *card, struct completion *fw_done,
 
 	adapter->hw_status = MWIFIEX_HW_STATUS_INITIALIZING;
 	clear_bit(MWIFIEX_SURPRISE_REMOVED, &adapter->work_flags);
-	init_waitqueue_head(&adapter->init_wait_q);
 	clear_bit(MWIFIEX_IS_SUSPENDED, &adapter->work_flags);
 	adapter->hs_activated = false;
 	init_waitqueue_head(&adapter->hs_activate_wait_q);
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index f026e6069be3f..1eb0b5f9cb4a5 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -240,7 +240,6 @@ struct mwifiex_dbg {
 enum MWIFIEX_HARDWARE_STATUS {
 	MWIFIEX_HW_STATUS_READY,
 	MWIFIEX_HW_STATUS_INITIALIZING,
-	MWIFIEX_HW_STATUS_INIT_DONE,
 	MWIFIEX_HW_STATUS_RESET,
 	MWIFIEX_HW_STATUS_NOT_READY
 };
@@ -869,8 +868,6 @@ struct mwifiex_adapter {
 	unsigned long work_flags;
 	u32 fw_release_number;
 	u8 intf_hdr_len;
-	u16 init_wait_q_woken;
-	wait_queue_head_t init_wait_q;
 	void *card;
 	struct mwifiex_if_ops if_ops;
 	atomic_t bypass_tx_pending;
@@ -923,7 +920,6 @@ struct mwifiex_adapter {
 	struct cmd_ctrl_node *curr_cmd;
 	/* spin lock for command */
 	spinlock_t mwifiex_cmd_lock;
-	u16 last_init_cmd;
 	struct timer_list cmd_timer;
 	struct list_head cmd_free_q;
 	/* spin lock for cmd_free_q */
@@ -1064,8 +1060,6 @@ void mwifiex_free_priv(struct mwifiex_private *priv);
 
 int mwifiex_init_fw(struct mwifiex_adapter *adapter);
 
-int mwifiex_init_fw_complete(struct mwifiex_adapter *adapter);
-
 void mwifiex_shutdown_drv(struct mwifiex_adapter *adapter);
 
 int mwifiex_dnld_fw(struct mwifiex_adapter *, struct mwifiex_fw_image *);
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index 30dd4e58e2b1d..da89e15e5fe76 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -2406,11 +2406,5 @@ int mwifiex_sta_init_cmd(struct mwifiex_private *priv, u8 first_sta, bool init)
 	ret = mwifiex_send_cmd(priv, HostCmd_CMD_11N_CFG,
 			       HostCmd_ACT_GEN_SET, 0, &tx_cfg, true);
 
-	if (init) {
-		/* set last_init_cmd before sending the command */
-		priv->adapter->last_init_cmd = HostCmd_CMD_11N_CFG;
-		ret = -EINPROGRESS;
-	}
-
 	return ret;
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index ea28d604ee69c..4c5b1de0e936c 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -115,24 +115,6 @@ static struct mwifiex_debug_data items[] = {
 
 static int num_of_items = ARRAY_SIZE(items);
 
-/*
- * Firmware initialization complete callback handler.
- *
- * This function wakes up the function waiting on the init
- * wait queue for the firmware initialization to complete.
- */
-int mwifiex_init_fw_complete(struct mwifiex_adapter *adapter)
-{
-
-	if (adapter->hw_status == MWIFIEX_HW_STATUS_READY)
-		if (adapter->if_ops.init_fw_port)
-			adapter->if_ops.init_fw_port(adapter);
-
-	adapter->init_wait_q_woken = true;
-	wake_up_interruptible(&adapter->init_wait_q);
-	return 0;
-}
-
 /*
  * This function sends init/shutdown command
  * to firmware.

-- 
2.39.2



Return-Path: <linux-wireless+bounces-21905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B8BA98361
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 10:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A2417A5A9
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA3727E1B8;
	Wed, 23 Apr 2025 08:21:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920B127CB31
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396478; cv=none; b=LtR0Ry6pqBAbxOj6FHhjdrOT+gSXCMMr2QxtAoAUp8uG+58KMlpYeIqBwgbu3Ed+Oc6ua3yndwyD9YDWLosPGMvmURGsG7AiuxxjN5QyHOOJZyexRRX1qz850WhDNT1KMY8+ztfv1RzXROmmud44fHEa7JAsxu7pu4OImitksfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396478; c=relaxed/simple;
	bh=pZN1CHAKoCst/C+8jzXhb0QdTymlffmmARiAVh8UwXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UnO0dl8ObLNoHJpNopclVdUOPPVTSS5NRuEBbpGjy62cO2vGqhyhvFS0KxglHjXicFZ23Oym3fbfv4Ph5bukfiAivZTzKvbTYeWyFPFJ8E8VPdbMAjZ1GQOh1dM94stBB3UxyvP/E1cX2+5SmBi+XcVM7LwDBNzUcHxyNa58MN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u7VLt-0003K5-VX; Wed, 23 Apr 2025 10:21:05 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u7VLt-001gbE-1y;
	Wed, 23 Apr 2025 10:21:05 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u7VLt-00BoAZ-1d;
	Wed, 23 Apr 2025 10:21:05 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 23 Apr 2025 10:21:04 +0200
Subject: [PATCH v2 3/4] wifi: mwifiex: drop asynchronous init waiting code
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-mwifiex-drop-asynchronous-init-v2-3-1bb951073a06@pengutronix.de>
References: <20250423-mwifiex-drop-asynchronous-init-v2-0-1bb951073a06@pengutronix.de>
In-Reply-To: <20250423-mwifiex-drop-asynchronous-init-v2-0-1bb951073a06@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745396465; l=8580;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=pZN1CHAKoCst/C+8jzXhb0QdTymlffmmARiAVh8UwXU=;
 b=wx7aTylmP2ImZtOzm60/jGiZpiOL9vxyq1k5rmwadpAHu/JppLMzEPb0OBBMYFp94txy8fiAr
 +NamtSul8VuD8aAdkqDL3myTNUqt5oJ2GWH6ifwudWI7mBScFX3LC6v
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Historically all commands sent to the mwifiex driver have been
asynchronous. The different commands sent during driver initialization
have been queued at once and only the final command has been waited
for being ready before finally starting the driver.

This has been changed in Commit 7bff9c974e1a ("mwifiex: send firmware
initialization commands synchronously"). With this the initialization
is finished once the last mwifiex_send_cmd_sync() (now
mwifiex_send_cmd()) has returned. This makes all the code used to
wait for the last initialization command to be finished unnecessary,
so it's removed in this patch.

Acked-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c  | 16 ----------------
 drivers/net/wireless/marvell/mwifiex/init.c    |  5 +++--
 drivers/net/wireless/marvell/mwifiex/main.c    | 18 +-----------------
 drivers/net/wireless/marvell/mwifiex/main.h    |  6 ------
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c |  4 ----
 drivers/net/wireless/marvell/mwifiex/util.c    | 18 ------------------
 6 files changed, 4 insertions(+), 63 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 5573e2ded72f2..c07857c49a713 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -900,18 +900,6 @@ int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter)
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
@@ -1030,10 +1018,6 @@ mwifiex_cmd_timeout_func(struct timer_list *t)
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
index dd24e8b140655..dd2c17d946d7c 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -480,14 +480,12 @@ int mwifiex_init_lock_list(struct mwifiex_adapter *adapter)
  *      - Initialize the private structure
  *      - Add BSS priority tables to the adapter structure
  *      - For each interface, send the init commands to firmware
- *      - Send the first command in command pending queue, if available
  */
 int mwifiex_init_fw(struct mwifiex_adapter *adapter)
 {
 	int ret;
 	struct mwifiex_private *priv;
 	u8 i, first_sta = true;
-	int is_cmd_pend_q_empty;
 
 	adapter->hw_status = MWIFIEX_HW_STATUS_INITIALIZING;
 
@@ -526,6 +524,9 @@ int mwifiex_init_fw(struct mwifiex_adapter *adapter)
 
 	adapter->hw_status = MWIFIEX_HW_STATUS_READY;
 
+	if (adapter->if_ops.init_fw_port)
+		adapter->if_ops.init_fw_port(adapter);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 3f1b8be5ad26c..73298b0769c94 100644
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
@@ -587,18 +580,11 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 			goto err_dnld_fw;
 	}
 
-	adapter->init_wait_q_woken = false;
 	ret = mwifiex_init_fw(adapter);
 	if (ret == -1)
 		goto err_init_fw;
 
-	/* Wait for mwifiex_init to complete */
-	if (!adapter->mfg_mode) {
-		wait_event_interruptible(adapter->init_wait_q,
-					 adapter->init_wait_q_woken);
-		if (adapter->hw_status != MWIFIEX_HW_STATUS_READY)
-			goto err_init_fw;
-	}
+	maybe_quirk_fw_disable_ds(adapter);
 
 	if (!adapter->wiphy) {
 		if (mwifiex_register_cfg80211(adapter)) {
@@ -1555,7 +1541,6 @@ mwifiex_reinit_sw(struct mwifiex_adapter *adapter)
 
 	adapter->hw_status = MWIFIEX_HW_STATUS_INITIALIZING;
 	clear_bit(MWIFIEX_SURPRISE_REMOVED, &adapter->work_flags);
-	init_waitqueue_head(&adapter->init_wait_q);
 	clear_bit(MWIFIEX_IS_SUSPENDED, &adapter->work_flags);
 	adapter->hs_activated = false;
 	clear_bit(MWIFIEX_IS_CMD_TIMEDOUT, &adapter->work_flags);
@@ -1723,7 +1708,6 @@ mwifiex_add_card(void *card, struct completion *fw_done,
 
 	adapter->hw_status = MWIFIEX_HW_STATUS_INITIALIZING;
 	clear_bit(MWIFIEX_SURPRISE_REMOVED, &adapter->work_flags);
-	init_waitqueue_head(&adapter->init_wait_q);
 	clear_bit(MWIFIEX_IS_SUSPENDED, &adapter->work_flags);
 	adapter->hs_activated = false;
 	init_waitqueue_head(&adapter->hs_activate_wait_q);
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 63f1c900e0967..35d13eada0868 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -239,7 +239,6 @@ struct mwifiex_dbg {
 enum MWIFIEX_HARDWARE_STATUS {
 	MWIFIEX_HW_STATUS_READY,
 	MWIFIEX_HW_STATUS_INITIALIZING,
-	MWIFIEX_HW_STATUS_INIT_DONE,
 	MWIFIEX_HW_STATUS_RESET,
 	MWIFIEX_HW_STATUS_NOT_READY
 };
@@ -865,8 +864,6 @@ struct mwifiex_adapter {
 	unsigned long work_flags;
 	u32 fw_release_number;
 	u8 intf_hdr_len;
-	u16 init_wait_q_woken;
-	wait_queue_head_t init_wait_q;
 	void *card;
 	struct mwifiex_if_ops if_ops;
 	atomic_t bypass_tx_pending;
@@ -919,7 +916,6 @@ struct mwifiex_adapter {
 	struct cmd_ctrl_node *curr_cmd;
 	/* spin lock for command */
 	spinlock_t mwifiex_cmd_lock;
-	u16 last_init_cmd;
 	struct timer_list cmd_timer;
 	struct list_head cmd_free_q;
 	/* spin lock for cmd_free_q */
@@ -1060,8 +1056,6 @@ void mwifiex_free_priv(struct mwifiex_private *priv);
 
 int mwifiex_init_fw(struct mwifiex_adapter *adapter);
 
-int mwifiex_init_fw_complete(struct mwifiex_adapter *adapter);
-
 void mwifiex_shutdown_drv(struct mwifiex_adapter *adapter);
 
 int mwifiex_dnld_fw(struct mwifiex_adapter *, struct mwifiex_fw_image *);
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index af38744eddaa9..7a8a74df86ab1 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -2433,9 +2433,5 @@ int mwifiex_sta_init_cmd(struct mwifiex_private *priv, u8 first_sta, bool init)
 	ret = mwifiex_send_cmd(priv, HostCmd_CMD_11N_CFG,
 			       HostCmd_ACT_GEN_SET, 0, &tx_cfg, true);
 
-	if (init)
-		/* set last_init_cmd before sending the command */
-		priv->adapter->last_init_cmd = HostCmd_CMD_11N_CFG;
-
 	return ret;
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 1f1f6280a0f25..daa363f082612 100644
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
2.39.5



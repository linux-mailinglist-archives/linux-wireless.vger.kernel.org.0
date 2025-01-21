Return-Path: <linux-wireless+bounces-17769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C0AA175C7
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 02:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3EBE1887D16
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 01:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD0385931;
	Tue, 21 Jan 2025 01:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="BOZ0svdb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5990F49641;
	Tue, 21 Jan 2025 01:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737423197; cv=none; b=FnNDnimL7kR8PC3xeACVTcbruEQP+JkfqgqjfyC/iOMZatYB6Nv9fTAKVSOQr5wPy4bAaraMcv7cR4p30dNFHb7hN6R1cqjTdgjqMozyVBc7XSB7W1UAia/HNmFwNXgNljRHxGdXOgXQcEDofVKTd9IYGRRbBI/JHesrG0xrqeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737423197; c=relaxed/simple;
	bh=m44pva6xLSwoayoDGldZwPJePGM+tFoBiV1JvRB0LTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpUz8jXv6ERKwWaYtGxSZnuGdQOC2jjs7gc6KP4ITIJvb2kdNwNUJYm8v6cJk0OvoEMpoCAJtmI5mMXsJ1BfXtlocxmu9gpIGJzdZRE7LGw2l3UmPX3MPydBmmwgOqAH/lAUOTPVpHSVZ2P1QfQmN211TB6MwitTJpHLQhl+HyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=BOZ0svdb; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=VmrvnobXFnfz6nZ86BtHR6A5ZAKaDHYd9kZJD/zijBw=; b=BOZ0svdbmitN+npN
	M/vm2+zuBrpFY2QkjclMMhE0KT7ZF7nIZIT3NlRj8aAFmJbByUxrNQyUv4zvg4jFSBu6wrqEsdFdw
	Smu+e//z36UlcEuZuBdBslzWdaxEcPooOEfbAzcYJw4fMHyOvPPn1p+0fCcW6vfLq9pfs4WUTO6AJ
	sjF7W1ydOKhVDnDnGy9J9Ni5nzNEFJ+adJjdpYM/ty1OGTVOVjBNQ8xjgy3Etc6nr0mpwYoAuZbZQ
	HMeTDjQSn3ccVZF8BO+4XM9S/d9lgKYKl9OQn8BevM3cDU7+iwD5K/dQ+0Qvkfxeig79FM44MM2v8
	hersAeGx5E0CpAuoxg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1ta38Y-00BEI2-2Y;
	Tue, 21 Jan 2025 01:33:02 +0000
From: linux@treblig.org
To: kvalo@kernel.org,
	libertas-dev@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 3/3] wifi: libertas: Remove unused auto deep sleep code
Date: Tue, 21 Jan 2025 01:33:00 +0000
Message-ID: <20250121013300.433538-4-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121013300.433538-1-linux@treblig.org>
References: <20250121013300.433538-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

With the recent removal of the uncalled
  lbs_(enter|exit)_auto_deep_sleep()
functions, it's no longer possible to set
  priv->is_auto_deep_sleep_enabled
so we can remove all tests of it and the variable itself.

With that gone, priv->wakeup_dev_required also doesn't
get set, so we can remove any testing of it.

Now the timer itself, and the function it calls goes.
The timer used the apparently unset auto_deep_sleep_timeout
member, which can also go.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/wireless/marvell/libertas/cmd.c   | 14 ++----
 .../net/wireless/marvell/libertas/cmdresp.c   |  1 -
 drivers/net/wireless/marvell/libertas/dev.h   |  4 --
 drivers/net/wireless/marvell/libertas/main.c  | 48 +------------------
 4 files changed, 6 insertions(+), 61 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/cmd.c b/drivers/net/wireless/marvell/libertas/cmd.c
index 4032bbd28acd..21fde876bb0d 100644
--- a/drivers/net/wireless/marvell/libertas/cmd.c
+++ b/drivers/net/wireless/marvell/libertas/cmd.c
@@ -903,10 +903,6 @@ static void lbs_submit_command(struct lbs_private *priv,
 	}
 
 	if (command == CMD_802_11_DEEP_SLEEP) {
-		if (priv->is_auto_deep_sleep_enabled) {
-			priv->wakeup_dev_required = 1;
-			priv->dnld_sent = 0;
-		}
 		priv->is_deep_sleep = 1;
 		lbs_complete_command(priv, cmdnode, 0);
 	} else {
@@ -1391,12 +1387,10 @@ struct cmd_ctrl_node *__lbs_cmd_async(struct lbs_private *priv,
 	/* No commands are allowed in Deep Sleep until we toggle the GPIO
 	 * to wake up the card and it has signaled that it's ready.
 	 */
-	if (!priv->is_auto_deep_sleep_enabled) {
-		if (priv->is_deep_sleep) {
-			lbs_deb_cmd("command not allowed in deep sleep\n");
-			cmdnode = ERR_PTR(-EBUSY);
-			goto done;
-		}
+	if (priv->is_deep_sleep) {
+		lbs_deb_cmd("command not allowed in deep sleep\n");
+		cmdnode = ERR_PTR(-EBUSY);
+		goto done;
 	}
 
 	cmdnode = lbs_get_free_cmd_node(priv);
diff --git a/drivers/net/wireless/marvell/libertas/cmdresp.c b/drivers/net/wireless/marvell/libertas/cmdresp.c
index f2aa659e7714..8393f396eebe 100644
--- a/drivers/net/wireless/marvell/libertas/cmdresp.c
+++ b/drivers/net/wireless/marvell/libertas/cmdresp.c
@@ -279,7 +279,6 @@ void lbs_process_event(struct lbs_private *priv, u32 event)
 			priv->reset_deep_sleep_wakeup(priv);
 		lbs_deb_cmd("EVENT: ds awake\n");
 		priv->is_deep_sleep = 0;
-		priv->wakeup_dev_required = 0;
 		wake_up_interruptible(&priv->ds_awake_q);
 		break;
 
diff --git a/drivers/net/wireless/marvell/libertas/dev.h b/drivers/net/wireless/marvell/libertas/dev.h
index 4b6e05a8e5d5..c4708ce4eb83 100644
--- a/drivers/net/wireless/marvell/libertas/dev.h
+++ b/drivers/net/wireless/marvell/libertas/dev.h
@@ -83,12 +83,8 @@ struct lbs_private {
 	/* Deep sleep */
 	int is_deep_sleep;
 	int deep_sleep_required;
-	int is_auto_deep_sleep_enabled;
-	int wakeup_dev_required;
 	int is_activity_detected;
-	int auto_deep_sleep_timeout; /* in ms */
 	wait_queue_head_t ds_awake_q;
-	struct timer_list auto_deepsleep_timer;
 
 	/* Host sleep*/
 	int is_host_sleep_configured;
diff --git a/drivers/net/wireless/marvell/libertas/main.c b/drivers/net/wireless/marvell/libertas/main.c
index e7fa27a7de81..017e5c6bbade 100644
--- a/drivers/net/wireless/marvell/libertas/main.c
+++ b/drivers/net/wireless/marvell/libertas/main.c
@@ -256,8 +256,7 @@ void lbs_host_to_card_done(struct lbs_private *priv)
 
 	/* Wake main thread if commands are pending */
 	if (!priv->cur_cmd || priv->tx_pending_len > 0) {
-		if (!priv->wakeup_dev_required)
-			wake_up(&priv->waitq);
+		wake_up(&priv->waitq);
 	}
 
 	spin_unlock_irqrestore(&priv->driver_lock, flags);
@@ -448,8 +447,7 @@ static int lbs_thread(void *data)
 			shouldsleep = 0;	/* We have a command response */
 		else if (priv->cur_cmd)
 			shouldsleep = 1;	/* Can't send a command; one already running */
-		else if (!list_empty(&priv->cmdpendingq) &&
-					!(priv->wakeup_dev_required))
+		else if (!list_empty(&priv->cmdpendingq))
 			shouldsleep = 0;	/* We have a command to send */
 		else if (kfifo_len(&priv->event_fifo))
 			shouldsleep = 0;	/* We have an event to process */
@@ -516,14 +514,6 @@ static int lbs_thread(void *data)
 		}
 		spin_unlock_irq(&priv->driver_lock);
 
-		if (priv->wakeup_dev_required) {
-			lbs_deb_thread("Waking up device...\n");
-			/* Wake up device */
-			if (priv->exit_deep_sleep(priv))
-				lbs_deb_thread("Wakeup device failed\n");
-			continue;
-		}
-
 		/* command timeout stuff */
 		if (priv->cmd_timed_out && priv->cur_cmd) {
 			struct cmd_ctrl_node *cmdnode = priv->cur_cmd;
@@ -606,7 +596,6 @@ static int lbs_thread(void *data)
 
 	del_timer(&priv->command_timer);
 	del_timer(&priv->tx_lockup_timer);
-	del_timer(&priv->auto_deepsleep_timer);
 
 	return 0;
 }
@@ -753,35 +742,6 @@ static void lbs_tx_lockup_handler(struct timer_list *t)
 	spin_unlock_irqrestore(&priv->driver_lock, flags);
 }
 
-/**
- * auto_deepsleep_timer_fn - put the device back to deep sleep mode when
- * timer expires and no activity (command, event, data etc.) is detected.
- * @t: Context from which to retrieve a &struct lbs_private pointer
- * returns:	N/A
- */
-static void auto_deepsleep_timer_fn(struct timer_list *t)
-{
-	struct lbs_private *priv = from_timer(priv, t, auto_deepsleep_timer);
-
-	if (priv->is_activity_detected) {
-		priv->is_activity_detected = 0;
-	} else {
-		if (priv->is_auto_deep_sleep_enabled &&
-		    (!priv->wakeup_dev_required) &&
-		    (priv->connect_status != LBS_CONNECTED)) {
-			struct cmd_header cmd;
-
-			lbs_deb_main("Entering auto deep sleep mode...\n");
-			memset(&cmd, 0, sizeof(cmd));
-			cmd.size = cpu_to_le16(sizeof(cmd));
-			lbs_cmd_async(priv, CMD_802_11_DEEP_SLEEP, &cmd,
-					sizeof(cmd));
-		}
-	}
-	mod_timer(&priv->auto_deepsleep_timer , jiffies +
-				(priv->auto_deep_sleep_timeout * HZ)/1000);
-}
-
 static int lbs_init_adapter(struct lbs_private *priv)
 {
 	int ret;
@@ -795,9 +755,7 @@ static int lbs_init_adapter(struct lbs_private *priv)
 	priv->psmode = LBS802_11POWERMODECAM;
 	priv->psstate = PS_STATE_FULL_POWER;
 	priv->is_deep_sleep = 0;
-	priv->is_auto_deep_sleep_enabled = 0;
 	priv->deep_sleep_required = 0;
-	priv->wakeup_dev_required = 0;
 	init_waitqueue_head(&priv->ds_awake_q);
 	init_waitqueue_head(&priv->scan_q);
 	priv->authtype_auto = 1;
@@ -809,7 +767,6 @@ static int lbs_init_adapter(struct lbs_private *priv)
 
 	timer_setup(&priv->command_timer, lbs_cmd_timeout_handler, 0);
 	timer_setup(&priv->tx_lockup_timer, lbs_tx_lockup_handler, 0);
-	timer_setup(&priv->auto_deepsleep_timer, auto_deepsleep_timer_fn, 0);
 
 	INIT_LIST_HEAD(&priv->cmdfreeq);
 	INIT_LIST_HEAD(&priv->cmdpendingq);
@@ -843,7 +800,6 @@ static void lbs_free_adapter(struct lbs_private *priv)
 	kfifo_free(&priv->event_fifo);
 	del_timer(&priv->command_timer);
 	del_timer(&priv->tx_lockup_timer);
-	del_timer(&priv->auto_deepsleep_timer);
 }
 
 static const struct net_device_ops lbs_netdev_ops = {
-- 
2.48.1



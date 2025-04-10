Return-Path: <linux-wireless+bounces-21379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4321A84094
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 12:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8FD19E1DD7
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 10:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4C5283C83;
	Thu, 10 Apr 2025 10:24:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E694028136D
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280692; cv=none; b=diXyG3U5Uscdr7A2juwb4WGRdsdCXUR04ECfQTCLflaDU9isKJA5lpn3riAesnnmm7GIknx78NUtOib4OK2q0CgBM2k2wMdv5uN1Tea0+AZ0Qmn2nMqlMilcomrhCR03lLlDOn1LKIQUPLvFBqnlHzetMRVKb7z4PSocOYv5ZEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280692; c=relaxed/simple;
	bh=sTpc2b8bbM7EJ5rOPTmhe/8vAh34UMl26UbwJ2fJPKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T7DPzQjUYiuMO1CgqNApB4ihBaUEbjGDJt9L8O8NpzWL2EhIkpOYPwTQsSFkFNDApOz5T2EExMbrjwB/JcE9wnvwIZ0FUipT4YRE/r+H3IuKJtqPfW9w1amtRh4tyHXy7X9gdLLUi7yn5pf3qOArku8+wBF2Fl6EuXUY2FtHDd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p5C-0002DF-5h; Thu, 10 Apr 2025 12:24:30 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p5A-004Fmv-2Z;
	Thu, 10 Apr 2025 12:24:28 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p5A-002ODU-2I;
	Thu, 10 Apr 2025 12:24:28 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 10 Apr 2025 12:24:26 +0200
Subject: [PATCH wireless-next v6 2/9] wifi: mwifiex: use adapter as context
 pointer for mwifiex_hs_activated_event()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-mwifiex-cleanup-1-v6-2-a6bbd4ac4d37@pengutronix.de>
References: <20250410-mwifiex-cleanup-1-v6-0-a6bbd4ac4d37@pengutronix.de>
In-Reply-To: <20250410-mwifiex-cleanup-1-v6-0-a6bbd4ac4d37@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744280668; l=7387;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=sTpc2b8bbM7EJ5rOPTmhe/8vAh34UMl26UbwJ2fJPKU=;
 b=b+/QVShwhY6CG57ALfcKn1v/bQG3sWqGFHbdZfXDkcW7pFbrfHV8IPK6UZw3qBeJYbTC3da1j
 XonIhzBcUH/D0UjU0IxSn6Hg12Om0fRTwo/nqYc7swKwhRXUQsFm8i3
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

mwifiex_hs_activated_event() takes a struct mwifiex_private * as
context pointer which this function doesn't need directly and the callers
don't have. Use struct mwifiex_adapter * instead to simplify both the
function and the callers.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 44 ++++++++++++---------------
 drivers/net/wireless/marvell/mwifiex/main.c   | 15 ++-------
 drivers/net/wireless/marvell/mwifiex/main.h   |  2 +-
 3 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 5573e2ded72f2..ee3ec80ae3a46 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -367,8 +367,7 @@ static int mwifiex_dnld_sleep_confirm_cmd(struct mwifiex_adapter *adapter)
 	    (test_bit(MWIFIEX_IS_HS_CONFIGURED, &adapter->work_flags) &&
 	     !adapter->sleep_period.period)) {
 		adapter->pm_wakeup_card_req = true;
-		mwifiex_hs_activated_event(mwifiex_get_priv
-				(adapter, MWIFIEX_BSS_ROLE_ANY), true);
+		mwifiex_hs_activated_event(adapter, true);
 	}
 
 	return ret;
@@ -784,17 +783,16 @@ int mwifiex_exec_next_cmd(struct mwifiex_adapter *adapter)
 
 	spin_unlock_bh(&adapter->mwifiex_cmd_lock);
 	ret = mwifiex_dnld_cmd_to_fw(priv, cmd_node);
-	priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
+
 	/* Any command sent to the firmware when host is in sleep
 	 * mode should de-configure host sleep. We should skip the
 	 * host sleep configuration command itself though
 	 */
-	if (priv && (host_cmd->command !=
-	     cpu_to_le16(HostCmd_CMD_802_11_HS_CFG_ENH))) {
+	if (host_cmd->command != cpu_to_le16(HostCmd_CMD_802_11_HS_CFG_ENH)) {
 		if (adapter->hs_activated) {
 			clear_bit(MWIFIEX_IS_HS_CONFIGURED,
 				  &adapter->work_flags);
-			mwifiex_hs_activated_event(priv, false);
+			mwifiex_hs_activated_event(adapter, false);
 		}
 	}
 
@@ -1160,27 +1158,27 @@ mwifiex_check_ps_cond(struct mwifiex_adapter *adapter)
  * This event is generated by the driver, with a blank event body.
  */
 void
-mwifiex_hs_activated_event(struct mwifiex_private *priv, u8 activated)
+mwifiex_hs_activated_event(struct mwifiex_adapter *adapter, u8 activated)
 {
 	if (activated) {
 		if (test_bit(MWIFIEX_IS_HS_CONFIGURED,
-			     &priv->adapter->work_flags)) {
-			priv->adapter->hs_activated = true;
-			mwifiex_update_rxreor_flags(priv->adapter,
+			     &adapter->work_flags)) {
+			adapter->hs_activated = true;
+			mwifiex_update_rxreor_flags(adapter,
 						    RXREOR_FORCE_NO_DROP);
-			mwifiex_dbg(priv->adapter, EVENT,
+			mwifiex_dbg(adapter, EVENT,
 				    "event: hs_activated\n");
-			priv->adapter->hs_activate_wait_q_woken = true;
+			adapter->hs_activate_wait_q_woken = true;
 			wake_up_interruptible(
-				&priv->adapter->hs_activate_wait_q);
+				&adapter->hs_activate_wait_q);
 		} else {
-			mwifiex_dbg(priv->adapter, EVENT,
+			mwifiex_dbg(adapter, EVENT,
 				    "event: HS not configured\n");
 		}
 	} else {
-		mwifiex_dbg(priv->adapter, EVENT,
+		mwifiex_dbg(adapter, EVENT,
 			    "event: hs_deactivated\n");
-		priv->adapter->hs_activated = false;
+		adapter->hs_activated = false;
 	}
 }
 
@@ -1204,7 +1202,7 @@ int mwifiex_ret_802_11_hs_cfg(struct mwifiex_private *priv,
 
 	if (phs_cfg->action == cpu_to_le16(HS_ACTIVATE) &&
 	    adapter->iface_type != MWIFIEX_USB) {
-		mwifiex_hs_activated_event(priv, true);
+		mwifiex_hs_activated_event(adapter, true);
 		return 0;
 	} else {
 		mwifiex_dbg(adapter, CMD,
@@ -1217,11 +1215,11 @@ int mwifiex_ret_802_11_hs_cfg(struct mwifiex_private *priv,
 	if (conditions != HS_CFG_CANCEL) {
 		set_bit(MWIFIEX_IS_HS_CONFIGURED, &adapter->work_flags);
 		if (adapter->iface_type == MWIFIEX_USB)
-			mwifiex_hs_activated_event(priv, true);
+			mwifiex_hs_activated_event(adapter, true);
 	} else {
 		clear_bit(MWIFIEX_IS_HS_CONFIGURED, &adapter->work_flags);
 		if (adapter->hs_activated)
-			mwifiex_hs_activated_event(priv, false);
+			mwifiex_hs_activated_event(adapter, false);
 	}
 
 	return 0;
@@ -1250,9 +1248,7 @@ mwifiex_process_hs_config(struct mwifiex_adapter *adapter)
 	adapter->hs_activated = false;
 	clear_bit(MWIFIEX_IS_HS_CONFIGURED, &adapter->work_flags);
 	clear_bit(MWIFIEX_IS_SUSPENDED, &adapter->work_flags);
-	mwifiex_hs_activated_event(mwifiex_get_priv(adapter,
-						    MWIFIEX_BSS_ROLE_ANY),
-				   false);
+	mwifiex_hs_activated_event(adapter, false);
 }
 EXPORT_SYMBOL_GPL(mwifiex_process_hs_config);
 
@@ -1302,9 +1298,7 @@ mwifiex_process_sleep_confirm_resp(struct mwifiex_adapter *adapter,
 	}
 	adapter->pm_wakeup_card_req = true;
 	if (test_bit(MWIFIEX_IS_HS_CONFIGURED, &adapter->work_flags))
-		mwifiex_hs_activated_event(mwifiex_get_priv
-						(adapter, MWIFIEX_BSS_ROLE_ANY),
-					   true);
+		mwifiex_hs_activated_event(adapter, true);
 	adapter->ps_state = PS_STATE_SLEEP;
 	cmd->command = cpu_to_le16(command);
 	cmd->seq_num = cpu_to_le16(seq_num);
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 0e1f539404014..8982017e871d4 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -415,10 +415,7 @@ int mwifiex_main_process(struct mwifiex_adapter *adapter)
 			if (adapter->hs_activated) {
 				clear_bit(MWIFIEX_IS_HS_CONFIGURED,
 					  &adapter->work_flags);
-				mwifiex_hs_activated_event
-					(mwifiex_get_priv
-					(adapter, MWIFIEX_BSS_ROLE_ANY),
-					false);
+				mwifiex_hs_activated_event(adapter, false);
 			}
 		}
 
@@ -438,10 +435,7 @@ int mwifiex_main_process(struct mwifiex_adapter *adapter)
 			if (adapter->hs_activated) {
 				clear_bit(MWIFIEX_IS_HS_CONFIGURED,
 					  &adapter->work_flags);
-				mwifiex_hs_activated_event
-					(mwifiex_get_priv
-					 (adapter, MWIFIEX_BSS_ROLE_ANY),
-					 false);
+				mwifiex_hs_activated_event(adapter, false);
 			}
 		}
 
@@ -460,10 +454,7 @@ int mwifiex_main_process(struct mwifiex_adapter *adapter)
 			if (adapter->hs_activated) {
 				clear_bit(MWIFIEX_IS_HS_CONFIGURED,
 					  &adapter->work_flags);
-				mwifiex_hs_activated_event
-					(mwifiex_get_priv
-					 (adapter, MWIFIEX_BSS_ROLE_ANY),
-					 false);
+				mwifiex_hs_activated_event(adapter, false);
 			}
 		}
 
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 63f1c900e0967..88bd21fd3c07f 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1125,7 +1125,7 @@ int mwifiex_ret_enh_power_mode(struct mwifiex_private *priv,
 			       struct host_cmd_ds_command *resp,
 			       struct mwifiex_ds_pm_cfg *pm_cfg);
 void mwifiex_process_hs_config(struct mwifiex_adapter *adapter);
-void mwifiex_hs_activated_event(struct mwifiex_private *priv,
+void mwifiex_hs_activated_event(struct mwifiex_adapter *adapter,
 					u8 activated);
 int mwifiex_set_hs_params(struct mwifiex_private *priv, u16 action,
 			  int cmd_type, struct mwifiex_ds_hs_cfg *hs_cfg);

-- 
2.39.5



Return-Path: <linux-wireless+bounces-11679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A2995865D
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232F91F258DC
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40B418FC76;
	Tue, 20 Aug 2024 12:00:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD3F18F2D7
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155231; cv=none; b=Uq26pf6+EekpSiXaPQ0gcpn73XmCcXet+tkL8clGnTM4qZWuHjMXyFmsm1+uBxIRIcG7D8qAs79xJ5u1OEUzj5qGse6v9ArS4bpiJogkFJmTxAwDcR/hb5StYo+5fC3X77E3oLzgW44ci8uCfBO4WUU3y8hMjlkUwJpl+jN59uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155231; c=relaxed/simple;
	bh=a4wuBptPHFo9gmCPiVVThKDwNP1M7F5R34Dm5VBtJj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g3b8wB6UEdemMCfqnGwzZUWl029dexQdYpGSUQJdU1cCjUSzB0TuFiqaz38wY6KrT9Cn7IKCFk5+10l3JepgcK9BgwnhrRH08qarKhmXtxYHmTlSiEI7JRnFoyZjfZsU2Pp9KNWlfE5tOVGzQ9MjSaY5QWeDpFH+FdbSUiT2O2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-0000uO-Ab; Tue, 20 Aug 2024 14:00:26 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXF-001lN7-Sw; Tue, 20 Aug 2024 14:00:25 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1S;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:47 +0200
Subject: [PATCH 22/31] wifi: mwifiex: pass adapter to
 mwifiex_init_shutdown_fw()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-22-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=5046;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=a4wuBptPHFo9gmCPiVVThKDwNP1M7F5R34Dm5VBtJj0=;
 b=Jch8I4JE/geS6HJCBRRb7E+GOOWTnGB3t7WS2mYatNAwsP/DNkwcdEOwlMvb/qKDdc/wKfs/h
 UY1BVV8RjRQBiD8chWjJp5m8c9r5C5iWrwhxJxs/clmuzlOTsutz6QA
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

mwifiex_init_shutdown_fw() shuts down the firmware of the whole adapter,
not of a single priv, so pass the adapter to this function and use
mwifiex_adapter_send_cmd().

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/main.c | 5 +----
 drivers/net/wireless/marvell/mwifiex/main.h | 2 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c | 2 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c | 2 +-
 drivers/net/wireless/marvell/mwifiex/usb.c  | 4 +---
 drivers/net/wireless/marvell/mwifiex/util.c | 6 +++---
 6 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index f42d537cc6ce0..8978934b1115e 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -1493,8 +1493,6 @@ static void mwifiex_uninit_sw(struct mwifiex_adapter *adapter)
  */
 int mwifiex_shutdown_sw(struct mwifiex_adapter *adapter)
 {
-	struct mwifiex_private *priv;
-
 	if (!adapter)
 		return 0;
 
@@ -1502,10 +1500,9 @@ int mwifiex_shutdown_sw(struct mwifiex_adapter *adapter)
 	/* Caller should ensure we aren't suspending while this happens */
 	reinit_completion(adapter->fw_done);
 
-	priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
 	mwifiex_deauthenticate_all(adapter);
 
-	mwifiex_init_shutdown_fw(priv, MWIFIEX_FUNC_SHUTDOWN);
+	mwifiex_init_shutdown_fw(adapter, MWIFIEX_FUNC_SHUTDOWN);
 
 	mwifiex_uninit_sw(adapter);
 	adapter->is_up = false;
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index cb3a52c0869c9..114e0141dc01a 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1436,7 +1436,7 @@ static inline void mwifiex_enable_wake(struct mwifiex_adapter *adapter)
 	}
 }
 
-int mwifiex_init_shutdown_fw(struct mwifiex_private *priv,
+int mwifiex_init_shutdown_fw(struct mwifiex_adapter *adapter,
 			     u32 func_init_shutdown);
 
 int mwifiex_add_card(void *card, struct completion *fw_done,
diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index a25f90034e38d..2a7ed2aad1a34 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -452,7 +452,7 @@ static void mwifiex_pcie_remove(struct pci_dev *pdev)
 
 		mwifiex_disable_auto_ds(priv);
 
-		mwifiex_init_shutdown_fw(priv, MWIFIEX_FUNC_SHUTDOWN);
+		mwifiex_init_shutdown_fw(adapter, MWIFIEX_FUNC_SHUTDOWN);
 	}
 
 	mwifiex_remove_card(adapter);
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 18ed5015064db..e3a995514efc7 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -867,7 +867,7 @@ mwifiex_sdio_remove(struct sdio_func *func)
 
 		priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
 		mwifiex_disable_auto_ds(priv);
-		mwifiex_init_shutdown_fw(priv, MWIFIEX_FUNC_SHUTDOWN);
+		mwifiex_init_shutdown_fw(adapter, MWIFIEX_FUNC_SHUTDOWN);
 	}
 
 	mwifiex_remove_card(adapter);
diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
index 520ea4bc9a3fb..e082c26003cd7 100644
--- a/drivers/net/wireless/marvell/mwifiex/usb.c
+++ b/drivers/net/wireless/marvell/mwifiex/usb.c
@@ -656,9 +656,7 @@ static void mwifiex_usb_disconnect(struct usb_interface *intf)
 	if (card->udev->state != USB_STATE_NOTATTACHED && !adapter->mfg_mode) {
 		mwifiex_deauthenticate_all(adapter);
 
-		mwifiex_init_shutdown_fw(mwifiex_get_priv(adapter,
-							  MWIFIEX_BSS_ROLE_ANY),
-					 MWIFIEX_FUNC_SHUTDOWN);
+		mwifiex_init_shutdown_fw(adapter, MWIFIEX_FUNC_SHUTDOWN);
 	}
 
 	mwifiex_dbg(adapter, FATAL,
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 078877161ab7c..a8c44cc14f8a2 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -137,7 +137,7 @@ int mwifiex_init_fw_complete(struct mwifiex_adapter *adapter)
  * This function sends init/shutdown command
  * to firmware.
  */
-int mwifiex_init_shutdown_fw(struct mwifiex_private *priv,
+int mwifiex_init_shutdown_fw(struct mwifiex_adapter *adapter,
 			     u32 func_init_shutdown)
 {
 	u16 cmd;
@@ -147,12 +147,12 @@ int mwifiex_init_shutdown_fw(struct mwifiex_private *priv,
 	} else if (func_init_shutdown == MWIFIEX_FUNC_SHUTDOWN) {
 		cmd = HostCmd_CMD_FUNC_SHUTDOWN;
 	} else {
-		mwifiex_dbg(priv->adapter, ERROR,
+		mwifiex_dbg(adapter, ERROR,
 			    "unsupported parameter\n");
 		return -1;
 	}
 
-	return mwifiex_send_cmd(priv, cmd, HostCmd_ACT_GEN_SET, 0, NULL, true);
+	return mwifiex_adapter_send_cmd(adapter, cmd, HostCmd_ACT_GEN_SET, 0, NULL, true);
 }
 EXPORT_SYMBOL_GPL(mwifiex_init_shutdown_fw);
 

-- 
2.39.2



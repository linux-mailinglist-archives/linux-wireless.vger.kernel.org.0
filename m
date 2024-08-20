Return-Path: <linux-wireless+bounces-11696-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6F3958672
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8491F2610F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FF4190679;
	Tue, 20 Aug 2024 12:00:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3E218FC6A
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155235; cv=none; b=bB0LLm2gUmfdtzgTuSogzOCkQSGztD59eg/fGroo6xbuBSWqAg69Ew1MwMNYqifrHWRg73lOajBO8osL2OFOwq3Z1e5WvExYMU04fsZphnQiLFmGtbEVpifvM+npQAHz9GKhxqyU4+4ALQE8xgZXq7fSvXgDUF9PmQxYkJiV7Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155235; c=relaxed/simple;
	bh=gWnCb3QuySdShmzGxQ9sy7njEC7F0EcaCl9k2MjgDF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LQWxi+dpa73+uAGk9gpnAGWxDhrbRJOs/jshEMdbLsD3A1u30AF+At9pPdaJvAyzwSb83+yCnNYdN4iuw7N1qA7q3asvdi2QX05WxNJ1MsjfCSrAImtkYiNmPwEc0q4YkmaU5iQtKMblXpT4qYK/f1O9jjZ80g3CXgQCEXWXNvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXH-0000xc-FX; Tue, 20 Aug 2024 14:00:27 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-001lNr-UW; Tue, 20 Aug 2024 14:00:26 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1T;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:48 +0200
Subject: [PATCH 23/31] wifi: mwifiex: pass adapter to
 mwifiex_disable_auto_ds()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-23-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=3973;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=gWnCb3QuySdShmzGxQ9sy7njEC7F0EcaCl9k2MjgDF0=;
 b=vM30aopucHqN7m5GD2tznSI71PjvYPy56UY0BZPiN41kTNm6ehRyBQlKL4sfLsU0C1o22vLK8
 9ltY6kUiQVQCcu9tDvIvIPX3aWkFDjnTLm5TYc8dNhiiVx89S0o6xJD
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

mwifiex_disable_auto_ds() has effect on the whole adapter and not
to a priv, so pass the adapter to this function and use
mwifiex_adapter_send_cmd() instead of mwifiex_send_cmd().

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/main.h      | 2 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c      | 5 +----
 drivers/net/wireless/marvell/mwifiex/sdio.c      | 4 +---
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c | 6 +++---
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 114e0141dc01a..298726c663724 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1456,7 +1456,7 @@ int mwifiex_bss_start(struct mwifiex_private *priv, struct cfg80211_bss *bss,
 		      struct cfg80211_ssid *req_ssid);
 int mwifiex_cancel_hs(struct mwifiex_adapter *adapter, int cmd_type);
 int mwifiex_enable_hs(struct mwifiex_adapter *adapter);
-int mwifiex_disable_auto_ds(struct mwifiex_private *priv);
+int mwifiex_disable_auto_ds(struct mwifiex_adapter *adapter);
 int mwifiex_drv_get_data_rate(struct mwifiex_private *priv, u32 *rate);
 int mwifiex_request_scan(struct mwifiex_private *priv,
 			 struct cfg80211_ssid *req_ssid);
diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index 2a7ed2aad1a34..caa3a383dd56d 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -427,7 +427,6 @@ static void mwifiex_pcie_remove(struct pci_dev *pdev)
 {
 	struct pcie_service_card *card;
 	struct mwifiex_adapter *adapter;
-	struct mwifiex_private *priv;
 	const struct mwifiex_pcie_card_reg *reg;
 	u32 fw_status;
 
@@ -448,9 +447,7 @@ static void mwifiex_pcie_remove(struct pci_dev *pdev)
 	if (fw_status == FIRMWARE_READY_PCIE && !adapter->mfg_mode) {
 		mwifiex_deauthenticate_all(adapter);
 
-		priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
-
-		mwifiex_disable_auto_ds(priv);
+		mwifiex_disable_auto_ds(adapter);
 
 		mwifiex_init_shutdown_fw(adapter, MWIFIEX_FUNC_SHUTDOWN);
 	}
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index e3a995514efc7..6a33afc8a9d97 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -844,7 +844,6 @@ mwifiex_sdio_remove(struct sdio_func *func)
 {
 	struct sdio_mmc_card *card;
 	struct mwifiex_adapter *adapter;
-	struct mwifiex_private *priv;
 	int ret = 0;
 	u16 firmware_stat;
 
@@ -865,8 +864,7 @@ mwifiex_sdio_remove(struct sdio_func *func)
 	    !adapter->mfg_mode) {
 		mwifiex_deauthenticate_all(adapter);
 
-		priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
-		mwifiex_disable_auto_ds(priv);
+		mwifiex_disable_auto_ds(adapter);
 		mwifiex_init_shutdown_fw(adapter, MWIFIEX_FUNC_SHUTDOWN);
 	}
 
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index ed9f75adcdea3..3586def45adae 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -610,14 +610,14 @@ int mwifiex_get_bss_info(struct mwifiex_private *priv,
 /*
  * The function disables auto deep sleep mode.
  */
-int mwifiex_disable_auto_ds(struct mwifiex_private *priv)
+int mwifiex_disable_auto_ds(struct mwifiex_adapter *adapter)
 {
 	struct mwifiex_ds_auto_ds auto_ds = {
 		.auto_ds = DEEP_SLEEP_OFF,
 	};
 
-	return mwifiex_send_cmd(priv, HostCmd_CMD_802_11_PS_MODE_ENH,
-				DIS_AUTO_PS, BITMAP_AUTO_DS, &auto_ds, true);
+	return mwifiex_adapter_send_cmd(adapter, HostCmd_CMD_802_11_PS_MODE_ENH,
+					DIS_AUTO_PS, BITMAP_AUTO_DS, &auto_ds, true);
 }
 EXPORT_SYMBOL_GPL(mwifiex_disable_auto_ds);
 

-- 
2.39.2



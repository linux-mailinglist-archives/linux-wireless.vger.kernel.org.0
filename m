Return-Path: <linux-wireless+bounces-21906-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD68A98368
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 10:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD2E3A580D
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B7426AA93;
	Wed, 23 Apr 2025 08:21:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AEE27CCD7
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396479; cv=none; b=Kh/gQSjrvTtk+My8A4U/Qfh89rVXhzwtKJ4mwYWClmeqxMXc6tnq86Su2lHzwfgWuVDcQ6cFmx0Kn9OFeBl3Na7m8slDjFEYijCruT1A+OGj5Cl+VwATJRUqnFrDYjYv03MMP9oLWqCGp0RYdlzWTpFipKTkEXMNxU/YnzZ5WkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396479; c=relaxed/simple;
	bh=MM8zTb7fBXXRsmhqv/GChF68VhXTaKMR0tZATYq8nfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cKVq34MjEDGsqYOA6X5QzHUUEFq2DgRgO7m+BcEVj0g1/LuVEnf8RaZUXppMLg2Oys4UHAf7/ZNdBTdETSg7O0fb92rkYVX3fI2gQJ9yIHWEMJZGLJv98gKSOd/dj0r9jSe5kDEwbX4oPLAYhm+weI16aHtuzOpQL3NmWPJFWNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u7VLu-0003K3-5G; Wed, 23 Apr 2025 10:21:06 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u7VLt-001gbG-1x;
	Wed, 23 Apr 2025 10:21:05 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u7VLt-00BoAZ-1e;
	Wed, 23 Apr 2025 10:21:05 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 23 Apr 2025 10:21:05 +0200
Subject: [PATCH v2 4/4] wifi: mwifiex: remove mwifiex_sta_init_cmd() last
 argument
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-mwifiex-drop-asynchronous-init-v2-4-1bb951073a06@pengutronix.de>
References: <20250423-mwifiex-drop-asynchronous-init-v2-0-1bb951073a06@pengutronix.de>
In-Reply-To: <20250423-mwifiex-drop-asynchronous-init-v2-0-1bb951073a06@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745396465; l=3985;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=MM8zTb7fBXXRsmhqv/GChF68VhXTaKMR0tZATYq8nfM=;
 b=qHDdlj4etJcCatxtjge4NhvULdjxQqgfWi3QqDFXrN3qT8qW7geA6GpuzKvuNk49fT6iztuki
 fQ9x+R76EpmD/8rpZ2pqTBCnENFCIFR9SuKPcVylQTzyY+xoni5rWJD
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

The init argument from mwifiex_sta_init_cmd() is no longer used. Drop
it.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Acked-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 8 ++++----
 drivers/net/wireless/marvell/mwifiex/init.c     | 2 +-
 drivers/net/wireless/marvell/mwifiex/main.h     | 2 +-
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c  | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index a099fdaafa45d..df4186c0678ae 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1126,7 +1126,7 @@ mwifiex_change_vif_to_p2p(struct net_device *dev,
 			     HostCmd_ACT_GEN_SET, 0, NULL, true))
 		return -1;
 
-	if (mwifiex_sta_init_cmd(priv, false, false))
+	if (mwifiex_sta_init_cmd(priv, false))
 		return -1;
 
 	return 0;
@@ -1167,7 +1167,7 @@ mwifiex_change_vif_to_sta_adhoc(struct net_device *dev,
 	if (mwifiex_send_cmd(priv, HostCmd_CMD_SET_BSS_MODE,
 			     HostCmd_ACT_GEN_SET, 0, NULL, true))
 		return -1;
-	if (mwifiex_sta_init_cmd(priv, false, false))
+	if (mwifiex_sta_init_cmd(priv, false))
 		return -1;
 
 	return 0;
@@ -1204,7 +1204,7 @@ mwifiex_change_vif_to_ap(struct net_device *dev,
 	if (mwifiex_send_cmd(priv, HostCmd_CMD_SET_BSS_MODE,
 			     HostCmd_ACT_GEN_SET, 0, NULL, true))
 		return -1;
-	if (mwifiex_sta_init_cmd(priv, false, false))
+	if (mwifiex_sta_init_cmd(priv, false))
 		return -1;
 
 	return 0;
@@ -3122,7 +3122,7 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 		if (ret)
 			goto err_set_bss_mode;
 
-		ret = mwifiex_sta_init_cmd(priv, false, false);
+		ret = mwifiex_sta_init_cmd(priv, false);
 		if (ret)
 			goto err_sta_init;
 	}
diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index dd2c17d946d7c..32c374e477943 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -510,7 +510,7 @@ int mwifiex_init_fw(struct mwifiex_adapter *adapter)
 	} else {
 		for (i = 0; i < adapter->priv_num; i++) {
 			ret = mwifiex_sta_init_cmd(adapter->priv[i],
-						   first_sta, true);
+						   first_sta);
 			if (ret == -1)
 				return -1;
 
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 35d13eada0868..e01310ccef54f 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1150,7 +1150,7 @@ void mwifiex_process_sta_txpd(struct mwifiex_private *priv,
 			      struct sk_buff *skb);
 void mwifiex_process_uap_txpd(struct mwifiex_private *priv,
 			      struct sk_buff *skb);
-int mwifiex_sta_init_cmd(struct mwifiex_private *, u8 first_sta, bool init);
+int mwifiex_sta_init_cmd(struct mwifiex_private *, u8 first_sta);
 int mwifiex_cmd_802_11_scan(struct host_cmd_ds_command *cmd,
 			    struct mwifiex_scan_cmd_config *scan_cfg);
 void mwifiex_queue_scan_cmd(struct mwifiex_private *priv,
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index 7a8a74df86ab1..b7cae596294bd 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -2258,7 +2258,7 @@ int mwifiex_sta_prepare_cmd(struct mwifiex_private *priv, uint16_t cmd_no,
  *      - Set 11d control
  *      - Set MAC control (this must be the last command to initialize firmware)
  */
-int mwifiex_sta_init_cmd(struct mwifiex_private *priv, u8 first_sta, bool init)
+int mwifiex_sta_init_cmd(struct mwifiex_private *priv, u8 first_sta)
 {
 	struct mwifiex_adapter *adapter = priv->adapter;
 	int ret;

-- 
2.39.5



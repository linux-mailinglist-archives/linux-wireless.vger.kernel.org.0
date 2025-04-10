Return-Path: <linux-wireless+bounces-21383-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E66FA840A7
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 12:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2006169D9C
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 10:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F8D277813;
	Thu, 10 Apr 2025 10:28:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E756280A4E
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280931; cv=none; b=Vc1AzheUkDd1KpbLdmwhynalfBnlPyhgbvs7AodDwq8YpP7dhjiZehn243oz2L5b869vs/qxXW8MPAsW5CIlYwJQSJcfVHQlni5PhHhx7UoAIM0w8yQs6TP94nEXvk1Euqzmxeo+zaBOGTknNmQnz2YqdWZkXTzfBmwwxMqTTHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280931; c=relaxed/simple;
	bh=F/FS/Nn37B1dBOxDyq7j+tMX77ijz2Mh/c7A8bjVWqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g9Oo5XUlQrBOpj5U+9u+M5bIkehkjbhlDikI2DZ/Gjyu7YWfK3iek+maNNRXLQEa78lRy6HX+TGADEnhDy01qHYtKYu58bkhGx6RySjOf1cwSb3c93xHCaqU3/H+QyNrDlIX6yuP1bVbSucFwWiQklf7KzlEXYu/PGEzELCvJ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p9L-0003R2-Jc; Thu, 10 Apr 2025 12:28:47 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p9L-004Fof-18;
	Thu, 10 Apr 2025 12:28:47 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p9L-002cFD-0u;
	Thu, 10 Apr 2025 12:28:47 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 10 Apr 2025 12:28:46 +0200
Subject: [PATCH 4/4] wifi: mwifiex: remove mwifiex_sta_init_cmd() last
 argument
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-mwifiex-drop-asynchronous-init-v1-4-6a212fa9185e@pengutronix.de>
References: <20250410-mwifiex-drop-asynchronous-init-v1-0-6a212fa9185e@pengutronix.de>
In-Reply-To: <20250410-mwifiex-drop-asynchronous-init-v1-0-6a212fa9185e@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744280927; l=3870;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=F/FS/Nn37B1dBOxDyq7j+tMX77ijz2Mh/c7A8bjVWqk=;
 b=cPDgqMWQoZBQLvFCW/FzwbmezrOQrsXWDAelLI7/ybdd1S5P2o2ZoDr6ah2+xTR8BSzew5zaU
 75gvQ5OkQw8B6aTDW1TWjcMksL4b12sDPYtUQZFGEdih0H42GDMkAc6
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

The init argument from mwifiex_sta_init_cmd() is no longer used. Drop
it.

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



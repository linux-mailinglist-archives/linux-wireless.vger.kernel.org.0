Return-Path: <linux-wireless+bounces-21904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148BAA98360
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 10:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB84177327
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF17B27D78D;
	Wed, 23 Apr 2025 08:21:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9170427CB2C
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396478; cv=none; b=DELI+bilbA2UGwOeHmfKPGoYL0jGqLcbNVEejxq6tRPcWWWPLDNqPl5D7k6xN4RxGwsWTN7YaaLAE2sTDJvf8ys71RbKyskkHt8RQYFHYYODa5Z31a6rAzSUdTmETLFcvQpbg84oJ4BjoYwRo0FmQNgGAGRBLsfmVSNrNTWHGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396478; c=relaxed/simple;
	bh=CDaH+20zbj/NLBg8TqnLrM6ZgtaWU9tyRANrkmaHO5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NiZ6SImQQzWwN0e4IErOIymso17boNa60dAoFRnVe0IUaPm+j4iTNVsnEpzcJo52RKFmVMh8DO1LIlB45mfCQIYNI87WeDzw3cFbumvnHO8GZ7+0NFJHx9c3VKYKiVmnkIARyJ6BT8Ae3wIdEMV2g7d7R9wNPgQl9IoXejeCtQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u7VLu-0003K2-5H; Wed, 23 Apr 2025 10:21:06 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u7VLt-001gbC-1t;
	Wed, 23 Apr 2025 10:21:05 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u7VLt-00BoAZ-1c;
	Wed, 23 Apr 2025 10:21:05 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 23 Apr 2025 10:21:03 +0200
Subject: [PATCH v2 2/4] wifi: mwifiex: let mwifiex_init_fw() return 0 for
 success
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-mwifiex-drop-asynchronous-init-v2-2-1bb951073a06@pengutronix.de>
References: <20250423-mwifiex-drop-asynchronous-init-v2-0-1bb951073a06@pengutronix.de>
In-Reply-To: <20250423-mwifiex-drop-asynchronous-init-v2-0-1bb951073a06@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745396465; l=3107;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=CDaH+20zbj/NLBg8TqnLrM6ZgtaWU9tyRANrkmaHO5s=;
 b=W7K8TlycEY8aylV625l/5KRdlD060Pxv2t3Xs5U7KbSbasxspgj0XrEwK6fT7R55IP/heCN3E
 7k/xhCgpG6SBtj/8DzQO60/j6IPS/e/YdIdqRRljMOZ3kN+6ySdBVFn
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

mwifiex_sta_init_cmd() returns -EINPROGRESS as success indication when
the init param is true. Likewise mwifiex_init_fw() returns -EINPROGRESS
as success indication: It will either return -EINPROGRESS directly when
in mfg_mode or the return value of mwifiex_sta_init_cmd() when in normal
mode.

-EINPROGRESS is a leftover from times when the initialization commands
were sent asynchronously. Since Commit 7bff9c974e1a ("mwifiex: send
firmware initialization commands synchronously") the return value has
become meaningless, so change mwifiex_sta_init_cmd() and
mwifiex_init_fw() to return 0 for success.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Acked-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/init.c    | 3 +--
 drivers/net/wireless/marvell/mwifiex/main.c    | 7 ++-----
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c | 4 +---
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index 7877dfe5a2233..dd24e8b140655 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -509,7 +509,6 @@ int mwifiex_init_fw(struct mwifiex_adapter *adapter)
 	}
 	if (adapter->mfg_mode) {
 		adapter->hw_status = MWIFIEX_HW_STATUS_READY;
-		ret = -EINPROGRESS;
 	} else {
 		for (i = 0; i < adapter->priv_num; i++) {
 			ret = mwifiex_sta_init_cmd(adapter->priv[i],
@@ -527,7 +526,7 @@ int mwifiex_init_fw(struct mwifiex_adapter *adapter)
 
 	adapter->hw_status = MWIFIEX_HW_STATUS_READY;
 
-	return ret;
+	return 0;
 }
 
 /*
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 0e1f539404014..3f1b8be5ad26c 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -589,12 +589,9 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 
 	adapter->init_wait_q_woken = false;
 	ret = mwifiex_init_fw(adapter);
-	if (ret == -1) {
+	if (ret == -1)
 		goto err_init_fw;
-	} else if (!ret) {
-		adapter->hw_status = MWIFIEX_HW_STATUS_READY;
-		goto done;
-	}
+
 	/* Wait for mwifiex_init to complete */
 	if (!adapter->mfg_mode) {
 		wait_event_interruptible(adapter->init_wait_q,
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index c4689f5a1acc8..af38744eddaa9 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -2433,11 +2433,9 @@ int mwifiex_sta_init_cmd(struct mwifiex_private *priv, u8 first_sta, bool init)
 	ret = mwifiex_send_cmd(priv, HostCmd_CMD_11N_CFG,
 			       HostCmd_ACT_GEN_SET, 0, &tx_cfg, true);
 
-	if (init) {
+	if (init)
 		/* set last_init_cmd before sending the command */
 		priv->adapter->last_init_cmd = HostCmd_CMD_11N_CFG;
-		ret = -EINPROGRESS;
-	}
 
 	return ret;
 }

-- 
2.39.5



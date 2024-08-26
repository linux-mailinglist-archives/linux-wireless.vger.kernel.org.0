Return-Path: <linux-wireless+bounces-11967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 849C495EF4A
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41EAE28104E
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2DC154C0E;
	Mon, 26 Aug 2024 11:01:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B1913BC12
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724670098; cv=none; b=IYTLIArqWLvErygF3FdVLXy9YmKe/ndrmDdKul5fmsVOUeKkRbNcfhec/Jqyvmrn0h6oPY6BK5yeypS821Nt8cw5Z0Q3IFURlwzAdpj5dSZgL2+N9TSOvCnNWugJrg2Gfg7ATbAhAxqpFvngx3my8doqEemca0jHZ3wHY+a2P+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724670098; c=relaxed/simple;
	bh=InLYrg3vjt0WJ0PH01kCt0baD9/cMpZEt3bdBabOl1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U3y9KjOIwsr8+sO0mIX353bIsymFTf3chayETXePHtSdCcP5uCiMICtFdecFfmccjP4A4TYQwskd5h3S6t0JyyazzY0cIZvznTKfkZPd6e5ftZwOY+5roqLPr0xfAWk/Cs5be5ljfH85cXvJmEancHe0h6selwaH6tPXfxXt7Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXTY-00047b-LD; Mon, 26 Aug 2024 13:01:32 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXTY-003Ae9-0w; Mon, 26 Aug 2024 13:01:32 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXTX-004aRi-2w;
	Mon, 26 Aug 2024 13:01:31 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 26 Aug 2024 13:01:28 +0200
Subject: [PATCH 07/12] wifi: mwifiex: pass adapter to
 mwifiex_dnld_cmd_to_fw()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-mwifiex-cleanup-1-v1-7-56e6f8e056ec@pengutronix.de>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
In-Reply-To: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724670091; l=2048;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=InLYrg3vjt0WJ0PH01kCt0baD9/cMpZEt3bdBabOl1s=;
 b=9ZQ5/K6N2Z55HK3MKff3I5jVCiYFVjmQY7Fvamy2gqxW7tUM2qPf2rnRb/XkbTQomhWfWCU0w
 mEgX94AnZP5CbuWH5P4lfDLxBKxmaLHYv47Z4/CKZE3GWe8fSA4lBYz
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

priv is not needed in mwifiex_dnld_cmd_to_fw(), so pass the adapter to
it as context pointer.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 8a2ad0038d36f..402531a03ece3 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -159,11 +159,9 @@ static int mwifiex_cmd_host_cmd(struct mwifiex_private *priv,
  * sending. Afterwards, it logs the command ID and action for debugging
  * and sets up the command timeout timer.
  */
-static int mwifiex_dnld_cmd_to_fw(struct mwifiex_private *priv,
+static int mwifiex_dnld_cmd_to_fw(struct mwifiex_adapter *adapter,
 				  struct cmd_ctrl_node *cmd_node)
 {
-
-	struct mwifiex_adapter *adapter = priv->adapter;
 	int ret;
 	struct host_cmd_ds_command *host_cmd;
 	uint16_t cmd_code;
@@ -742,7 +740,6 @@ mwifiex_insert_cmd_to_pending_q(struct mwifiex_adapter *adapter,
  */
 int mwifiex_exec_next_cmd(struct mwifiex_adapter *adapter)
 {
-	struct mwifiex_private *priv;
 	struct cmd_ctrl_node *cmd_node;
 	int ret = 0;
 	struct host_cmd_ds_command *host_cmd;
@@ -766,7 +763,6 @@ int mwifiex_exec_next_cmd(struct mwifiex_adapter *adapter)
 				    struct cmd_ctrl_node, list);
 
 	host_cmd = (struct host_cmd_ds_command *) (cmd_node->cmd_skb->data);
-	priv = cmd_node->priv;
 
 	if (adapter->ps_state != PS_STATE_AWAKE) {
 		mwifiex_dbg(adapter, ERROR,
@@ -781,7 +777,7 @@ int mwifiex_exec_next_cmd(struct mwifiex_adapter *adapter)
 	spin_unlock_bh(&adapter->cmd_pending_q_lock);
 
 	spin_unlock_bh(&adapter->mwifiex_cmd_lock);
-	ret = mwifiex_dnld_cmd_to_fw(priv, cmd_node);
+	ret = mwifiex_dnld_cmd_to_fw(adapter, cmd_node);
 
 	/* Any command sent to the firmware when host is in sleep
 	 * mode should de-configure host sleep. We should skip the

-- 
2.39.2



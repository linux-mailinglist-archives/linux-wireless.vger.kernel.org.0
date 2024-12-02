Return-Path: <linux-wireless+bounces-15819-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28489E02A3
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 13:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F6F28346B
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 12:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C37202F8F;
	Mon,  2 Dec 2024 12:58:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A481FF61C
	for <linux-wireless@vger.kernel.org>; Mon,  2 Dec 2024 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144295; cv=none; b=fsZb2KbIskbWSKqqZZSDZkD9yIlxUQqK25dnN7dOXYkZEmmYOXGtljySRqYsDnNf8PW/lygYTQs7wj/ve0pHZGRvfRVlp+ivHwFylokNWcbIlBCvWb0VvSVP53FnLV80623M2tiddBjO9IA1l7wdBjCJNEIbkyms6J+Il7fKzzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144295; c=relaxed/simple;
	bh=7KBgP3YHIb8EuPDTsFYtK3mhC/xpviHm9ZADlP+zwMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IiM3NElrUrkDz5XYVP4T/kXOxE9a7EOsBw0CcG6kPqpihm9aZQXlEBoUYIX9iupI3pgpscpXpOJC2+JZk/nb/XI9F81wK7khDd3thklgVmXPqyOgyQjbERdiJfQ+ChMz1/pnMi+vsRsITRUsLjwzrL06pzwlCf4FUiinWseOcro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tI608-0000ZW-NL; Mon, 02 Dec 2024 13:58:08 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tI607-001IdQ-15;
	Mon, 02 Dec 2024 13:58:08 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tI607-00Boj9-3D;
	Mon, 02 Dec 2024 13:58:07 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 02 Dec 2024 13:58:06 +0100
Subject: [PATCH v3 07/12] wifi: mwifiex: pass adapter to
 mwifiex_dnld_cmd_to_fw()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-mwifiex-cleanup-1-v3-7-317a6ce0dd5b@pengutronix.de>
References: <20241202-mwifiex-cleanup-1-v3-0-317a6ce0dd5b@pengutronix.de>
In-Reply-To: <20241202-mwifiex-cleanup-1-v3-0-317a6ce0dd5b@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733144287; l=2112;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=7KBgP3YHIb8EuPDTsFYtK3mhC/xpviHm9ZADlP+zwMA=;
 b=2dKQgPGBIwJeDzjWtsMbOytRDYMGQmOx3SOI8NJGzR/RqyoYixBYDC7Ms0D8p+NZkqBBFoAh+
 pbo6C5c78JEC89bI9WRnKwVz6K86ZtS8zYXx8AgRO+dNauxcHYYX9Y0
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

priv is not needed in mwifiex_dnld_cmd_to_fw(), so pass the adapter to
it as context pointer.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
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
2.39.5



Return-Path: <linux-wireless+bounces-11667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67236958635
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 13:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24595284062
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 11:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEFA18EFF7;
	Tue, 20 Aug 2024 11:55:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8C218E74B
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154940; cv=none; b=uUeOQJEelxR7fUSUvKlC9s+O1j6YEM72BYDP4DIHhYC1Jno4XkMpZIamwJIRcNIaP8IvxSPJj3c9WZmr7TPIskKq2hZ4flIUzhNR4Sw7pLqi49PmT5h4C0PpbpLukVshEODB+RBrm0DdYPtG6RlsFhSFOzUjlZW2MoYpf8v2EH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154940; c=relaxed/simple;
	bh=Dy2rYpe7ga87zMwt7gfk8WBV36PYG+YAWWRPNjyhnG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ovrry+B17EuHYlCnzvOgGQGcT6afhbvHpCU1pv4i/1feO2Vg4a7IiAtGll3mvqXfbTWJwZJGxhdKhgcZAhco4tXipivxuFaXK1X7VOPgg3E5iBihLNX/XoEyVdEoMAqbX/OLtDnSxNpbJCa4hvubrxwviEQ141ZmI6bQmxsElHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSS-0000An-5X; Tue, 20 Aug 2024 13:55:28 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-001lLl-FB; Tue, 20 Aug 2024 13:55:27 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1B;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:32 +0200
Subject: [PATCH 07/31] wifi: mwifiex: pass adapter to
 mwifiex_dnld_cmd_to_fw()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-7-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=2048;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=Dy2rYpe7ga87zMwt7gfk8WBV36PYG+YAWWRPNjyhnG0=;
 b=AHnT83hR8Of4IOFaciGACi2w940X2VOUZRD3Yl2ZwiPr8es4PYjzUpSa5MqsTAB0VVvXRKQ7g
 XN3h2sITF2kA9CNoRhutQl9BThpQkTgLebOEiB1oeNuTPZfSbTd+4m+
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
index d50a2925d0739..4f814110f750e 100644
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



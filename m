Return-Path: <linux-wireless+bounces-12947-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AEF97BB61
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 13:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7236CB2B0D6
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 11:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E194318E032;
	Wed, 18 Sep 2024 11:10:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A5618DF78
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726657847; cv=none; b=Eb955h+Zn2Ci8rxmrj0XAQO/7CiJI6+2fV0v7DkdjBJyljrJvwgVX/irjvaQB7Yli01MfJG549ipc86/A0y2/WGFPRTvaKD9HeO/4bdXUgEj6wXe78P6C/XYJ4sCQ7C70AL6O8rKmS3jREBZlKRKUTgt6rfPR6DMJHF9TccGaFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726657847; c=relaxed/simple;
	bh=7KBgP3YHIb8EuPDTsFYtK3mhC/xpviHm9ZADlP+zwMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jBEEk5ci+Eb8OXtZVCe6o2JuwqFvU0tQATd5p255JwQ3xb88FIUD4MqSaxbXz9MLQgeEK3aZqNhFJ26b1wA9Lsni0dAvWux27mTpFPPWlOx7y4CPTZdrg5F4LqnScUTSqRxs/WPboHJ9d9lbAEVbIgh/YF3SjrIOP1XyfkNmeHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sqsZs-0007wh-Pi; Wed, 18 Sep 2024 13:10:32 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sqsZr-008nTC-FY; Wed, 18 Sep 2024 13:10:31 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sqsZr-0086AC-1B;
	Wed, 18 Sep 2024 13:10:31 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 18 Sep 2024 13:10:32 +0200
Subject: [PATCH v2 07/12] wifi: mwifiex: pass adapter to
 mwifiex_dnld_cmd_to_fw()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-mwifiex-cleanup-1-v2-7-2d0597187d3c@pengutronix.de>
References: <20240918-mwifiex-cleanup-1-v2-0-2d0597187d3c@pengutronix.de>
In-Reply-To: <20240918-mwifiex-cleanup-1-v2-0-2d0597187d3c@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726657831; l=2112;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=7KBgP3YHIb8EuPDTsFYtK3mhC/xpviHm9ZADlP+zwMA=;
 b=TGytUlxql5CwmBE3scbbie0V6StjnOVvkDyRZKelLKb/zXhywfjriVexwHgkx2CkHcmumTGVk
 o9k7tqZV7ahAQ/Hq13rirwuSVp0EHcCqgntC43srT/rtJQl94QcxsEe
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



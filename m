Return-Path: <linux-wireless+bounces-20758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BA3A6DB5C
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 14:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2BB171313
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 13:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16AE25F7B2;
	Mon, 24 Mar 2025 13:24:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D96425EFAE
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822691; cv=none; b=s3UkvPVl3NHs8g9MreRS+zI6Cm81DfPmhn3I2wzmHkBfBvENU9PgfBLSw2dZ9bgT5HCbWNu1JS8UgV/LxkyDhaFNiypUvgJP+2CxJ9atg46sUObU+LfJRO0siqJPHcSxpNIK1fPnkVcFVS41OKgIM/IsXPajz6+ItfLDMQinTPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822691; c=relaxed/simple;
	bh=Jv1NSGT2N7HVk3/ySZFtdiSWqxrSSCGwJlYA6fMHMyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eBrTcrwtXwiWLGOGEkOy440xpoI+F1Al6DSLGJ5vA8CAPzsIflhmaPDzbsMOg7z2ac7FTN8HzX53IuwA3TBDMrBqrZmjuK+POnhUBdzzpewjw53z9mi25hAED1AxNaPPdtU/Mp8GV4O4Ib3SrZNC77Hqxh9/irO6I665uKes/zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1twhmm-0003sJ-72; Mon, 24 Mar 2025 14:24:12 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1twhml-001PyN-09;
	Mon, 24 Mar 2025 14:24:11 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1twhml-004Vqr-16;
	Mon, 24 Mar 2025 14:24:11 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 24 Mar 2025 14:24:04 +0100
Subject: [PATCH wireless-next v5 03/10] wifi: mwifiex: drop unnecessary
 initialization
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-mwifiex-cleanup-1-v5-3-1128a2be02af@pengutronix.de>
References: <20250324-mwifiex-cleanup-1-v5-0-1128a2be02af@pengutronix.de>
In-Reply-To: <20250324-mwifiex-cleanup-1-v5-0-1128a2be02af@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742822651; l=2020;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=Jv1NSGT2N7HVk3/ySZFtdiSWqxrSSCGwJlYA6fMHMyo=;
 b=/Zk1d7ZyDTqRH95nQP68H1emu04BWz8wgcHMIn/fNlZEoE2xLBJHTDR1xasQOk0jqxYZ88vzK
 zW9HYpSzqE0Bkj5K+BQuRxn/oe1LCTWCkxkyD5NGAme7aacZCTEgh6r
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Several functions initialize the priv * without actually using the
initialized value. Drop the initialization.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 6 ++----
 drivers/net/wireless/marvell/mwifiex/txrx.c   | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index b318210366f7c..fa2f13c21bea4 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -472,8 +472,7 @@ void mwifiex_free_cmd_buffer(struct mwifiex_adapter *adapter)
 int mwifiex_process_event(struct mwifiex_adapter *adapter)
 {
 	int ret, i;
-	struct mwifiex_private *priv =
-		mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
+	struct mwifiex_private *priv;
 	struct sk_buff *skb = adapter->event_skb;
 	u32 eventcause;
 	struct mwifiex_rxinfo *rx_info;
@@ -808,8 +807,7 @@ int mwifiex_exec_next_cmd(struct mwifiex_adapter *adapter)
 int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter)
 {
 	struct host_cmd_ds_command *resp;
-	struct mwifiex_private *priv =
-		mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
+	struct mwifiex_private *priv;
 	int ret = 0;
 	uint16_t orig_cmdresp_no;
 	uint16_t cmdresp_no;
diff --git a/drivers/net/wireless/marvell/mwifiex/txrx.c b/drivers/net/wireless/marvell/mwifiex/txrx.c
index bd91678d26b49..f44e22f245110 100644
--- a/drivers/net/wireless/marvell/mwifiex/txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/txrx.c
@@ -24,8 +24,7 @@
 int mwifiex_handle_rx_packet(struct mwifiex_adapter *adapter,
 			     struct sk_buff *skb)
 {
-	struct mwifiex_private *priv =
-		mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
+	struct mwifiex_private *priv;
 	struct rxpd *local_rx_pd;
 	struct mwifiex_rxinfo *rx_info = MWIFIEX_SKB_RXCB(skb);
 	int ret;

-- 
2.39.5



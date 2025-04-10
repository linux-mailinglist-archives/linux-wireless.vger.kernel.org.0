Return-Path: <linux-wireless+bounces-21380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E2EA840B6
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 12:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A638A13FC
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 10:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855A1280CF6;
	Thu, 10 Apr 2025 10:25:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD2E280CF0
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280700; cv=none; b=m/iO+AoTKkHZY8o1qRBUzhGOELml7PNU3q9PbK6A16fjvnpHChqqFOm9zLC4f7salor96i/S1LsYT0gvyGtpnsmdC7BQ/3IWe/ynW4dW/A9g934CKF7MBQl3IP13QucGwfZzCB8CMa+JFm67maEv+SOeteuEW1KRQQl/6D9FnvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280700; c=relaxed/simple;
	bh=Ab11XkYP7l2RY9CTzXZ7K6wUdJN9FcRnpf0wdbRd/Lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LkTKlO5irkh1dmjNr1gUqya7OYRkjKPLLAChk5OHGyc2u+03GkrljIO0geCetyaZm4yMmnmir3VW5099QV1Wsv6mc40InN/PavVdCc+7IyX8ipIiXSyRqauAVF/c6G0VArTlXK+vHzyFoJecQONaaUls3eydEMKIDWWBPC/sH7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p5C-0002DH-5i; Thu, 10 Apr 2025 12:24:30 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p5A-004Fmw-2r;
	Thu, 10 Apr 2025 12:24:28 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p5A-002ODU-2J;
	Thu, 10 Apr 2025 12:24:28 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 10 Apr 2025 12:24:27 +0200
Subject: [PATCH wireless-next v6 3/9] wifi: mwifiex: drop unnecessary
 initialization
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-mwifiex-cleanup-1-v6-3-a6bbd4ac4d37@pengutronix.de>
References: <20250410-mwifiex-cleanup-1-v6-0-a6bbd4ac4d37@pengutronix.de>
In-Reply-To: <20250410-mwifiex-cleanup-1-v6-0-a6bbd4ac4d37@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744280668; l=2071;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=Ab11XkYP7l2RY9CTzXZ7K6wUdJN9FcRnpf0wdbRd/Lo=;
 b=OClhyOO/WDA6Wvh4yNjDUyGVTsMh9WUsTjnL9xyMDa2aOwwLO+o926RHCeuD4ate7KDUCcwsJ
 9NNshB5xM2ICihw96VJ//ZM5cfMkLUXGnMCrBNPVamElp3QCENniivs
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
Acked-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 6 ++----
 drivers/net/wireless/marvell/mwifiex/txrx.c   | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index ee3ec80ae3a46..1c8d69190be65 100644
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



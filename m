Return-Path: <linux-wireless+bounces-11673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61306958642
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 13:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAAE1C2487F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 11:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0B019005F;
	Tue, 20 Aug 2024 11:55:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE5A190068
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154948; cv=none; b=kjSGoOEV4KWLAixwtkvd0e9GkJz6Y5uuF+RLnPj9/Y5KW54iyK2d/NT9rkJvfuZKVczEy1QeXewSW6MvDYsOzK9ze3pNQ32/av2PxRjosehwBeGp7DOsihO7viuZMVkjTB2L731eBuy57+FAPG4uH+PN3NzI/AdGdQrxEFfoLz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154948; c=relaxed/simple;
	bh=zrTZPqrwqKbku5CptsquReGfBlQNXUNkDNqmRwZwNj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cocu7cyt5mH2nIrLJZdCOdjfeVYln2jOuHhkN39cFISXNrtYV9IocVfkkbVcaesKUrsCpk8TfFhpZnHfCgTwmmXxUOzyzM6oPc0GSPuDR9WnXMa6fKD0/QVIeYMS8tGiF5rQyBz1ikTqSxNzMM1LDumAdhNAU2MGuKto9iAW/jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSS-0000Af-5V; Tue, 20 Aug 2024 13:55:28 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-001lLh-DL; Tue, 20 Aug 2024 13:55:27 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-17;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:28 +0200
Subject: [PATCH 03/31] wifi: mwifiex: drop HostCmd_CMD_802_11_MAC_ADDRESS
 response handling
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-3-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=1754;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=zrTZPqrwqKbku5CptsquReGfBlQNXUNkDNqmRwZwNj0=;
 b=2qlCSy2sZykp9cchANIYzJ3bKr+tDCatxcmAE+RLZXssChPv0XL/yoGxQ0jx0CtcDJsIzZXl/
 /qApv3GC6mfDp7uUHc4zUqlLis9K1nUfYsFinwu8WnAEO8XFF+bNS5W
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

The command response handler copies the new MAC address over to
priv->curr_addr. The same is done in the code issuing the call
already, so drop the unnecessary HostCmd_CMD_802_11_MAC_ADDRESS
handling.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
index 9c53825f222d1..7f81e709bd6b7 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
@@ -473,25 +473,6 @@ static int mwifiex_ret_rf_antenna(struct mwifiex_private *priv,
 	return 0;
 }
 
-/*
- * This function handles the command response of set/get MAC address.
- *
- * Handling includes saving the MAC address in driver.
- */
-static int mwifiex_ret_802_11_mac_address(struct mwifiex_private *priv,
-					  struct host_cmd_ds_command *resp)
-{
-	struct host_cmd_ds_802_11_mac_address *cmd_mac_addr =
-							&resp->params.mac_addr;
-
-	memcpy(priv->curr_addr, cmd_mac_addr->mac_addr, ETH_ALEN);
-
-	mwifiex_dbg(priv->adapter, INFO,
-		    "info: set mac address: %pM\n", priv->curr_addr);
-
-	return 0;
-}
-
 /*
  * This function handles the command response of set/get MAC multicast
  * address.
@@ -1232,7 +1213,6 @@ int mwifiex_process_sta_cmdresp(struct mwifiex_private *priv, u16 cmdresp_no,
 	case HostCmd_CMD_MAC_CONTROL:
 		break;
 	case HostCmd_CMD_802_11_MAC_ADDRESS:
-		ret = mwifiex_ret_802_11_mac_address(priv, resp);
 		break;
 	case HostCmd_CMD_MAC_MULTICAST_ADR:
 		ret = mwifiex_ret_mac_multicast_adr(priv, resp);

-- 
2.39.2



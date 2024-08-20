Return-Path: <linux-wireless+bounces-11678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F08695865F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357861F25709
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC76118FC7D;
	Tue, 20 Aug 2024 12:00:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD3F18E048
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155231; cv=none; b=LHVKD/cxjXnRnRTLbFQU77MDMGnE4Jll2JPi+Zdk45K3GOq7mn3NDIYWdoKzbzBd1OBqozKV0lrA4fohs6U5yijJtJ4WEUagdTwNGBHJKwyBFI56hUTceAdbkczsIG3h/N4iYdKZnvlWYopstyJkAi+G89mdNUZyahDJGyjEV4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155231; c=relaxed/simple;
	bh=NbLRRE/2rj8Js3vruT5fYGNGmwFqeMK5YEVrNf5xIH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rwxlwV3EJem17ehU4qxnIscyNwlrgXbmIg4D1qRD0d2DNYeuIM3WOAo1lf91UeTzDzxe/jrwpLngaL1vzUKYqXE8vOQgviSKGMybYufb4KvPJaVL2U3PS1s342d5qAmOU/XHTZ5gleH6LPVmprIr9JTsqCxNZIGvF/Dncm8c2Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-0000th-1X; Tue, 20 Aug 2024 14:00:26 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXF-001lMy-K9; Tue, 20 Aug 2024 14:00:25 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1V;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:50 +0200
Subject: [PATCH 25/31] wifi: mwifiex: return error on unexpected bss_num
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-25-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=2733;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=NbLRRE/2rj8Js3vruT5fYGNGmwFqeMK5YEVrNf5xIH4=;
 b=AJLdrzn9DT8g8FDwVuPeWjmHGY0EKOuUmw7q6fY0YqvHz6VZ+yJG5sCSw3vy9qHl8G6Xxse6w
 zNJbY1fd/oUADAcvCGm6hHdP/K34yD2lA2CMDjh3lvmihmsa0lmj8n/
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

When we receive an event, command response or RX packet on with a
bss_num we haven't sent then it must be a driver or firmware bug. It
makes no sense to continue with an arbitrary bss in this case, so print
an error message and bail out with an error.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 15 +++++++++++----
 drivers/net/wireless/marvell/mwifiex/txrx.c   |  6 ++----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 400f1785d0d9e..410e548fab074 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -497,8 +497,11 @@ int mwifiex_process_event(struct mwifiex_adapter *adapter)
 
 	/* Get BSS number and corresponding priv */
 	priv = mwifiex_get_priv_by_id(adapter, EVENT_GET_BSS_NUM(eventcause));
-	if (!priv)
-		priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
+	if (!priv) {
+		mwifiex_dbg(adapter, ERROR, "received event on unused bss_num %d\n",
+			    EVENT_GET_BSS_NUM(eventcause));
+		return -EINVAL;
+	}
 
 	/* Clear BSS_NO_BITS from event */
 	eventcause &= EVENT_ID_MASK;
@@ -861,8 +864,12 @@ int mwifiex_process_cmdresp(struct mwifiex_adapter *adapter)
 	/* Get BSS number and corresponding priv */
 	priv = mwifiex_get_priv_by_id(adapter,
 			     HostCmd_GET_BSS_NO(le16_to_cpu(resp->seq_num)));
-	if (!priv)
-		priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
+	if (!priv) {
+		mwifiex_dbg(adapter, ERROR, "received event on unused bss_num %d\n",
+			    HostCmd_GET_BSS_NO(le16_to_cpu(resp->seq_num)));
+		return -EINVAL;
+	}
+
 	/* Clear RET_BIT from HostCmd */
 	resp->command = cpu_to_le16(orig_cmdresp_no & HostCmd_CMD_ID_MASK);
 
diff --git a/drivers/net/wireless/marvell/mwifiex/txrx.c b/drivers/net/wireless/marvell/mwifiex/txrx.c
index 21cfee3290377..0e5247bd642b6 100644
--- a/drivers/net/wireless/marvell/mwifiex/txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/txrx.c
@@ -32,12 +32,10 @@ int mwifiex_handle_rx_packet(struct mwifiex_adapter *adapter,
 	local_rx_pd = (struct rxpd *) (skb->data);
 	/* Get the BSS number from rxpd, get corresponding priv */
 	priv = mwifiex_get_priv_by_id(adapter, local_rx_pd->bss_num & BSS_NUM_MASK);
-	if (!priv)
-		priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
-
 	if (!priv) {
 		mwifiex_dbg(adapter, ERROR,
-			    "data: priv not found. Drop RX packet\n");
+			    "data: recived RX packet on unused bss_num %d. Dropping it\n",
+			    local_rx_pd->bss_num & BSS_NUM_MASK);
 		dev_kfree_skb_any(skb);
 		return -1;
 	}

-- 
2.39.2



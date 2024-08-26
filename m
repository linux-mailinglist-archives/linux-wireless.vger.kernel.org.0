Return-Path: <linux-wireless+bounces-11970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B75D95EF50
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED381C22194
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C382E158873;
	Mon, 26 Aug 2024 11:01:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5133C14EC77
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724670099; cv=none; b=pkfs2PPg1lOxbigK/1mbhkRdDgZdttOB4IbYkddy8I5qML9EZxJPlNKN9VOQtqRa4BGEb7hhZsj+mTEb1tdCOWy7tZS/OjADxVoTkzZtRtnsehkQMHdf0kf2DzeZpUZfSgag/+5S80d2zkDYYoZeZVTkIEkUC/4UaLHZ11FuzzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724670099; c=relaxed/simple;
	bh=TD3nr6uPC5o2ZzzHwrhWEYiqDYjA0YRx37EVyUKjilQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lpq5ACP+MRRQ6LkKdh+flxGRdVBRcaj0FyAa7uF1khaOg5XEgzuxHkBenRIWhSyTK9vCW16rXWb2XpojQx/lDug9qloGixu5xuyo2CEBXxYJRWJF5eb6RdngAr7DYamZawmg7v94uG9E6mkiNk53usbCCGagGtK8DmZzG8sKmEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXTY-00047W-JZ; Mon, 26 Aug 2024 13:01:32 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXTX-003Ae6-Vs; Mon, 26 Aug 2024 13:01:32 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXTX-004aRi-2u;
	Mon, 26 Aug 2024 13:01:31 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 26 Aug 2024 13:01:26 +0200
Subject: [PATCH 05/12] wifi: mwifiex: drop unnecessary initialization
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-mwifiex-cleanup-1-v1-5-56e6f8e056ec@pengutronix.de>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
In-Reply-To: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724670091; l=1956;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=TD3nr6uPC5o2ZzzHwrhWEYiqDYjA0YRx37EVyUKjilQ=;
 b=jNza1huVZWrVxbb/uGKFbJelNg833BPfqHbYEP+/+tIeIH10/ytj1Xv+8s/u/A8GC3ilxnp5W
 ivbpFKmD9GRAapXwUPEUxUdt8+lliaRutk8vlB+j2tgQJI4XknyPrr2
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Several functions initialize the priv * without actually using the
initialized value. Drop the initialization.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 6 ++----
 drivers/net/wireless/marvell/mwifiex/txrx.c   | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 0c175c6a1b201..8a2ad0038d36f 100644
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
2.39.2



Return-Path: <linux-wireless+bounces-11676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038EB95864D
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 13:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62272856CC
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 11:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E45A190684;
	Tue, 20 Aug 2024 11:55:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2261718EFFF
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 11:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154956; cv=none; b=XQsKZHcy9n9eZVZ1Tx1QjQ81ex9drtqJfuSgI/tqZ7v9uXVjC4YTACpaNA0kjW22fDzw9wPvKsOOXYt/IyQ7wfAvnMs17ry0GOKjMFngj381lrByM3267TXx7hk+SwwosPIgYLndfExGmlf9YNEtKiJO8q+aDz5sDvBtMPqSE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154956; c=relaxed/simple;
	bh=ub6bLaPuTHcCZMiXbWB6JhIgGt2owL18udvenP083fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D8A8rVnXFY0rIjSI66RLwRM36zdPKDaMqxvdYcS3c7DW4lCiIhjEcfGNqr2WvmNN3ne/c+Jp1p45Vq+8gRHTHTEwq4+Y3H8Vv4DwSJHt25Rpfj1uYOYE7UBsi5B7j20hA8w8uSo+I5YwK9GUPA/mG4B2CwJYFotITuigRVyY1Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSS-0000Am-5W; Tue, 20 Aug 2024 13:55:28 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-001lLn-FN; Tue, 20 Aug 2024 13:55:27 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1E;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:34 +0200
Subject: [PATCH 09/31] wifi: mwifiex: deduplicate code in
 mwifiex_cmd_tx_rate_cfg()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-9-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=3107;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=ub6bLaPuTHcCZMiXbWB6JhIgGt2owL18udvenP083fo=;
 b=+PIhpDmqELJBEkl3fyKxfeXdRDT+iSAeqXvKKlf9BHbbmYFR5IJONNEl+Cs/aJb0ZgeQnXQCv
 kzcW4BFT6ffDrauypw3y/RGNBwHdJh/0iOMSHf4hUudkzsEFJ09JSkp
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

The code block inside the if/else is the same with just using
pbitmap_rates if non NULL or priv->bitmap_rates otherwise. Deduplicate
the code by picking the correct pointer first and then using it
unconditionally.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c | 43 +++++++++-----------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index e2800a831c8ed..30dd4e58e2b1d 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -157,7 +157,7 @@ mwifiex_cmd_802_11_get_log(struct host_cmd_ds_command *cmd)
  */
 static int mwifiex_cmd_tx_rate_cfg(struct mwifiex_private *priv,
 				   struct host_cmd_ds_command *cmd,
-				   u16 cmd_action, u16 *pbitmap_rates)
+				   u16 cmd_action, const u16 *pbitmap_rates)
 {
 	struct host_cmd_ds_tx_rate_cfg *rate_cfg = &cmd->params.tx_rate_cfg;
 	struct mwifiex_rate_scope *rate_scope;
@@ -174,34 +174,19 @@ static int mwifiex_cmd_tx_rate_cfg(struct mwifiex_private *priv,
 	rate_scope->type = cpu_to_le16(TLV_TYPE_RATE_SCOPE);
 	rate_scope->length = cpu_to_le16
 		(sizeof(*rate_scope) - sizeof(struct mwifiex_ie_types_header));
-	if (pbitmap_rates != NULL) {
-		rate_scope->hr_dsss_rate_bitmap = cpu_to_le16(pbitmap_rates[0]);
-		rate_scope->ofdm_rate_bitmap = cpu_to_le16(pbitmap_rates[1]);
-		for (i = 0; i < ARRAY_SIZE(rate_scope->ht_mcs_rate_bitmap); i++)
-			rate_scope->ht_mcs_rate_bitmap[i] =
-				cpu_to_le16(pbitmap_rates[2 + i]);
-		if (priv->adapter->fw_api_ver == MWIFIEX_FW_V15) {
-			for (i = 0;
-			     i < ARRAY_SIZE(rate_scope->vht_mcs_rate_bitmap);
-			     i++)
-				rate_scope->vht_mcs_rate_bitmap[i] =
-					cpu_to_le16(pbitmap_rates[10 + i]);
-		}
-	} else {
-		rate_scope->hr_dsss_rate_bitmap =
-			cpu_to_le16(priv->bitmap_rates[0]);
-		rate_scope->ofdm_rate_bitmap =
-			cpu_to_le16(priv->bitmap_rates[1]);
-		for (i = 0; i < ARRAY_SIZE(rate_scope->ht_mcs_rate_bitmap); i++)
-			rate_scope->ht_mcs_rate_bitmap[i] =
-				cpu_to_le16(priv->bitmap_rates[2 + i]);
-		if (priv->adapter->fw_api_ver == MWIFIEX_FW_V15) {
-			for (i = 0;
-			     i < ARRAY_SIZE(rate_scope->vht_mcs_rate_bitmap);
-			     i++)
-				rate_scope->vht_mcs_rate_bitmap[i] =
-					cpu_to_le16(priv->bitmap_rates[10 + i]);
-		}
+	if (!pbitmap_rates)
+		pbitmap_rates = priv->bitmap_rates;
+
+	rate_scope->hr_dsss_rate_bitmap = cpu_to_le16(pbitmap_rates[0]);
+	rate_scope->ofdm_rate_bitmap = cpu_to_le16(pbitmap_rates[1]);
+
+	for (i = 0; i < ARRAY_SIZE(rate_scope->ht_mcs_rate_bitmap); i++)
+		rate_scope->ht_mcs_rate_bitmap[i] = cpu_to_le16(pbitmap_rates[2 + i]);
+
+	if (priv->adapter->fw_api_ver == MWIFIEX_FW_V15) {
+		for (i = 0; i < ARRAY_SIZE(rate_scope->vht_mcs_rate_bitmap); i++)
+			rate_scope->vht_mcs_rate_bitmap[i] =
+				cpu_to_le16(pbitmap_rates[10 + i]);
 	}
 
 	rate_drop = (struct mwifiex_rate_drop_pattern *) ((u8 *) rate_scope +

-- 
2.39.2



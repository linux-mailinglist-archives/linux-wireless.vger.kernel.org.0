Return-Path: <linux-wireless+bounces-12945-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D03D597BB5E
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 13:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0B21C240BB
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 11:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC23F18CC07;
	Wed, 18 Sep 2024 11:10:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E87818C935
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726657846; cv=none; b=FCcfYu6WziPPF341sIs+w3qaOKjXWft3o+EQl453GGItKQUEXA/XyW/X7DV23q64Tz88CNagPMVGuIFLPQoHcp/h3j7s0FnPHhD8jga1FQvXq0x+XFVSpW8BaYSsFNUfc1GqWWGqrNw5eOR4mpcnL3rHSKbhcL/XpDzRp7/3MPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726657846; c=relaxed/simple;
	bh=YJf7CTJU9cjm7wgH3iWlza8QlTGiJ6PyQ1angbO+zjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MSf4sO3UnznzFfPct76gX1zct3AE41Sfvyu94OJK5VPI0xOpFu6Bl0TmaHWXfRzbpqh8JWiaunE8UaH1GwgC4YKD0t02IuWIyNaXKx8xuLTu4l/NQXaIhyiJyDcD72YST3iJvGUJQsjj392dvgNsZwRs5Nk2M/oAPKjPuNdOGS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sqsZs-0007wf-Pi; Wed, 18 Sep 2024 13:10:32 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sqsZr-008nT8-F1; Wed, 18 Sep 2024 13:10:31 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sqsZr-0086AC-17;
	Wed, 18 Sep 2024 13:10:31 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 18 Sep 2024 13:10:28 +0200
Subject: [PATCH v2 03/12] wifi: mwifiex: deduplicate code in
 mwifiex_cmd_tx_rate_cfg()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-mwifiex-cleanup-1-v2-3-2d0597187d3c@pengutronix.de>
References: <20240918-mwifiex-cleanup-1-v2-0-2d0597187d3c@pengutronix.de>
In-Reply-To: <20240918-mwifiex-cleanup-1-v2-0-2d0597187d3c@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726657831; l=3171;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=YJf7CTJU9cjm7wgH3iWlza8QlTGiJ6PyQ1angbO+zjg=;
 b=bfcCn6q3oxkvT+xrcU4RDhU5uBTI939HOToIYjAoWG33rI10vSxlnKEVYkOrFYzv/HnyL+id9
 aEBCtUQpKk1A6uRpSh2b4/PoTprxthBvxWjr1UwjpfxO993g8tkZHHi
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

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
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
2.39.5



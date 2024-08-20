Return-Path: <linux-wireless+bounces-11680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9F895865C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16EB1C22871
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D1518FC81;
	Tue, 20 Aug 2024 12:00:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED44F18F2CC
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155231; cv=none; b=tRK2nMnj1wmGMpe3M293oWoYoy+MGDMqg1NsH6GjT4wdjr8G1jwbPaiLZn6A92D1PW3um3CQ8eOQ/b7FQ7vu31mPtGvCsO3nTv8pilIOYEUDEeZ32YCC2X3A5ovcUms//s2x+d6b58LiN5MRaC40OGSQnQBTv/QFDD6MZmWvRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155231; c=relaxed/simple;
	bh=HUrhV/9RXsSk4lgK781J6es6YfH4gCFyqD9ti2W7so4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r5rtQRh2hyF9s1ZFtpvw0j8EPoEUsO6jCiDeG9S7mJUAL8q3HcJDQFWi82VXxisiJ0dd+PsE/Cdna83ilV5NcVPXA2Zr2P+ef/Eu9R/vPqW1c0kk57vFnvBmk3tqrh3FoqZZA4amkTS8jI79ZFlXoTG+BGlpTZ2+btUyQb0eo40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-0000tn-8J; Tue, 20 Aug 2024 14:00:26 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXF-001lN4-Pt; Tue, 20 Aug 2024 14:00:25 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1W;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:51 +0200
Subject: [PATCH 26/31] wifi: mwifiex: coalesce rules are adapter specific
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-26-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=3362;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=HUrhV/9RXsSk4lgK781J6es6YfH4gCFyqD9ti2W7so4=;
 b=K4m8hT/tGagGzzyPfn3CmE+s3CaVMRXxNoNLwy3dTyfLbqWbdEXdhlW50gmGI77LnX9kZSiz7
 6Y9yH8Gg315ARnJn27rkHqGPp9Kr8+c1LM4qDpKLvytE74vFRV/aSh/
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

The coalesce rules are adapter specific, so use the adapter as context
pointer and use mwifiex_adapter_send_cmd() instead of
mwifiex_send_cmd();

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 35fb86b4cb8d5..b341b36bc7395 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -3517,7 +3517,7 @@ static int mwifiex_get_coalesce_pkt_type(u8 *byte_seq)
 }
 
 static int
-mwifiex_fill_coalesce_rule_info(struct mwifiex_private *priv,
+mwifiex_fill_coalesce_rule_info(struct mwifiex_adapter *adapter,
 				struct cfg80211_coalesce_rules *crule,
 				struct mwifiex_coalesce_rule *mrule)
 {
@@ -3534,7 +3534,7 @@ mwifiex_fill_coalesce_rule_info(struct mwifiex_private *priv,
 		if (!mwifiex_is_pattern_supported(&crule->patterns[i],
 						  byte_seq,
 						MWIFIEX_COALESCE_MAX_BYTESEQ)) {
-			mwifiex_dbg(priv->adapter, ERROR,
+			mwifiex_dbg(adapter, ERROR,
 				    "Pattern not supported\n");
 			return -EOPNOTSUPP;
 		}
@@ -3544,7 +3544,7 @@ mwifiex_fill_coalesce_rule_info(struct mwifiex_private *priv,
 
 			pkt_type = mwifiex_get_coalesce_pkt_type(byte_seq);
 			if (pkt_type && mrule->pkt_type) {
-				mwifiex_dbg(priv->adapter, ERROR,
+				mwifiex_dbg(adapter, ERROR,
 					    "Multiple packet types not allowed\n");
 				return -EOPNOTSUPP;
 			} else if (pkt_type) {
@@ -3568,7 +3568,7 @@ mwifiex_fill_coalesce_rule_info(struct mwifiex_private *priv,
 	}
 
 	if (!mrule->pkt_type) {
-		mwifiex_dbg(priv->adapter, ERROR,
+		mwifiex_dbg(adapter, ERROR,
 			    "Packet type can not be determined\n");
 		return -EOPNOTSUPP;
 	}
@@ -3582,21 +3582,19 @@ static int mwifiex_cfg80211_set_coalesce(struct wiphy *wiphy,
 	struct mwifiex_adapter *adapter = mwifiex_cfg80211_get_adapter(wiphy);
 	int i, ret;
 	struct mwifiex_ds_coalesce_cfg coalesce_cfg;
-	struct mwifiex_private *priv =
-			mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_STA);
 
 	memset(&coalesce_cfg, 0, sizeof(coalesce_cfg));
 	if (!coalesce) {
 		mwifiex_dbg(adapter, WARN,
 			    "Disable coalesce and reset all previous rules\n");
-		return mwifiex_send_cmd(priv, HostCmd_CMD_COALESCE_CFG,
-					HostCmd_ACT_GEN_SET, 0,
-					&coalesce_cfg, true);
+		return mwifiex_adapter_send_cmd(adapter, HostCmd_CMD_COALESCE_CFG,
+						HostCmd_ACT_GEN_SET, 0,
+						&coalesce_cfg, true);
 	}
 
 	coalesce_cfg.num_of_rules = coalesce->n_rules;
 	for (i = 0; i < coalesce->n_rules; i++) {
-		ret = mwifiex_fill_coalesce_rule_info(priv, &coalesce->rules[i],
+		ret = mwifiex_fill_coalesce_rule_info(adapter, &coalesce->rules[i],
 						      &coalesce_cfg.rule[i]);
 		if (ret) {
 			mwifiex_dbg(adapter, ERROR,
@@ -3606,8 +3604,8 @@ static int mwifiex_cfg80211_set_coalesce(struct wiphy *wiphy,
 		}
 	}
 
-	return mwifiex_send_cmd(priv, HostCmd_CMD_COALESCE_CFG,
-				HostCmd_ACT_GEN_SET, 0, &coalesce_cfg, true);
+	return mwifiex_adapter_send_cmd(adapter, HostCmd_CMD_COALESCE_CFG,
+					HostCmd_ACT_GEN_SET, 0, &coalesce_cfg, true);
 }
 
 /* cfg80211 ops handler for tdls_mgmt.

-- 
2.39.2



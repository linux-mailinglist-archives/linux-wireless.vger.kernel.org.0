Return-Path: <linux-wireless+bounces-15821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B1C9E0523
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 15:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDFFEB3E682
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 12:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F03204081;
	Mon,  2 Dec 2024 12:58:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472911FF61B
	for <linux-wireless@vger.kernel.org>; Mon,  2 Dec 2024 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144295; cv=none; b=FYGrehtCHTOvcr9UIEdWg/A4UVpk3djNYLf6rm2yfJDugC0oHs0BhT9fF+Ob+PXRcXC/dNDhGEKC0oLx9wPQmyk93SVEwSYtg+uTbjB13PoBlws1Vinx82icead83GKZ2u2KvITWWUrec+COVfvg2eqNt4dC8Je3slyKE907fRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144295; c=relaxed/simple;
	bh=SkDbnW/g//Lpq45aEWvOkOmfkXLSqxyH2urQsrrcM0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ep69EdTo/LnfZj75lybkat25Bw2sl6GLmNtw4v3KSDNY9XIzN+iJSH9TtF2aNWrIFC3FtQDSlqYKAcdoIhryue9BxTtAhj1ycwBWh3pz98txUuPQaNFJaueu95o2oJ5g0B6TJzHqcLnh2EeMPqyDSLf3qTb1AuLAh9AJZ9I4yLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tI608-0000ZY-NK; Mon, 02 Dec 2024 13:58:08 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tI607-001IdP-17;
	Mon, 02 Dec 2024 13:58:08 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tI607-00Boj9-3C;
	Mon, 02 Dec 2024 13:58:07 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 02 Dec 2024 13:58:05 +0100
Subject: [PATCH v3 06/12] wifi: mwifiex: make region_code_mapping_t const
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-mwifiex-cleanup-1-v3-6-317a6ce0dd5b@pengutronix.de>
References: <20241202-mwifiex-cleanup-1-v3-0-317a6ce0dd5b@pengutronix.de>
In-Reply-To: <20241202-mwifiex-cleanup-1-v3-0-317a6ce0dd5b@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733144287; l=2590;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=SkDbnW/g//Lpq45aEWvOkOmfkXLSqxyH2urQsrrcM0Y=;
 b=mIkvvR/WULVC+xiu6bDiQaKGKgbLVsS3EW6p9Kmuc0HBfsZsab0P1uC5XXE8EmwZprLZaHOon
 Xp3VW0k9f6iC2/S+YQ/rxqXsSf9TRQKRHsKpLuKWg43fTBdZXfVQOYd
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

region_code_mapping_t is not modified and shouldn't be. Mark it const.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 +-
 drivers/net/wireless/marvell/mwifiex/cfp.c      | 4 ++--
 drivers/net/wireless/marvell/mwifiex/main.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index d3e1424bea390..8cf6267b03579 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4701,7 +4701,7 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 	void *wdev_priv;
 	struct wiphy *wiphy;
 	struct mwifiex_private *priv = adapter->priv[MWIFIEX_BSS_TYPE_STA];
-	u8 *country_code;
+	const u8 *country_code;
 	u32 thr, retry;
 	struct cfg80211_ops *ops;
 
diff --git a/drivers/net/wireless/marvell/mwifiex/cfp.c b/drivers/net/wireless/marvell/mwifiex/cfp.c
index d39092b992129..47c93dca6041b 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfp.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfp.c
@@ -153,7 +153,7 @@ struct region_code_mapping {
 	u8 region[IEEE80211_COUNTRY_STRING_LEN];
 };
 
-static struct region_code_mapping region_code_mapping_t[] = {
+static const struct region_code_mapping region_code_mapping_t[] = {
 	{ 0x10, "US " }, /* US FCC */
 	{ 0x20, "CA " }, /* IC Canada */
 	{ 0x30, "FR " }, /* France */
@@ -165,7 +165,7 @@ static struct region_code_mapping region_code_mapping_t[] = {
 };
 
 /* This function converts integer code to region string */
-u8 *mwifiex_11d_code_2_region(u8 code)
+const u8 *mwifiex_11d_code_2_region(u8 code)
 {
 	u8 i;
 
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index ce5b80af305a0..56f413cb6eb30 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1569,7 +1569,7 @@ int mwifiex_add_wowlan_magic_pkt_filter(struct mwifiex_adapter *adapter);
 int mwifiex_set_mgmt_ies(struct mwifiex_private *priv,
 			 struct cfg80211_beacon_data *data);
 int mwifiex_del_mgmt_ies(struct mwifiex_private *priv);
-u8 *mwifiex_11d_code_2_region(u8 code);
+const u8 *mwifiex_11d_code_2_region(u8 code);
 void mwifiex_uap_set_channel(struct mwifiex_private *priv,
 			     struct mwifiex_uap_bss_param *bss_cfg,
 			     struct cfg80211_chan_def chandef);

-- 
2.39.5



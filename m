Return-Path: <linux-wireless+bounces-20752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFBBA6DB46
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 14:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06809188641F
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 13:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4335725F96F;
	Mon, 24 Mar 2025 13:24:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214E725F7B1
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822666; cv=none; b=CFheIoQeWKmJtfco7mGVufh9GC+z0g/+6dbOBs6X3AiNKyjOlzZF7Re5rwOfXj712trOaLjTcSlYTtcMiW1SZpKgdlebBBkt7aLKOuvDf1sOCHW0Ir3GPZdQ9JvnT62P7+4XMub8Qt1p2wXrmSjKAMxc5/B+KJBNzLwAGMjNwtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822666; c=relaxed/simple;
	bh=GB1PxUmJ9bNthEWBZQPH93fgDTrldEAByTJonNDrc+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NTcIuuiyi+GSNiMTk+0MpLvuilqmiomnSHhIgnHwv9o8/maKmjINciNpQJZurNhwIjVb0mkt5WVpCql4sgl+GD8AJ8zp3AE2gZwlV33QK35T7q3h5fmgstDhsYpyhUreThG7OgYgPWfM65InwdD2VGBolW6e8rVZMhwsKcp6VAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1twhmm-0003sH-72; Mon, 24 Mar 2025 14:24:12 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1twhml-001PyM-07;
	Mon, 24 Mar 2025 14:24:11 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1twhml-004Vqr-19;
	Mon, 24 Mar 2025 14:24:11 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 24 Mar 2025 14:24:05 +0100
Subject: [PATCH wireless-next v5 04/10] wifi: mwifiex: make
 region_code_mapping_t const
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-mwifiex-cleanup-1-v5-4-1128a2be02af@pengutronix.de>
References: <20250324-mwifiex-cleanup-1-v5-0-1128a2be02af@pengutronix.de>
In-Reply-To: <20250324-mwifiex-cleanup-1-v5-0-1128a2be02af@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742822651; l=2602;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=GB1PxUmJ9bNthEWBZQPH93fgDTrldEAByTJonNDrc+s=;
 b=jwfDJtB0stU9aYG04hVALr9P3A/mnNF9mMwB2NGN63QE95NvcAo8HqfMy4WdYgswlYtBRxQN9
 yvQwuGkPZ8LDNr55tLgED6uyw30Ib6kwjSjCd5Lhgs2e0jwtcpCKZ2e
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
index a099fdaafa45d..33bc5cd3ce960 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4703,7 +4703,7 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 	void *wdev_priv;
 	struct wiphy *wiphy;
 	struct mwifiex_private *priv = adapter->priv[MWIFIEX_BSS_TYPE_STA];
-	u8 *country_code;
+	const u8 *country_code;
 	u32 thr, retry;
 	struct cfg80211_ops *ops;
 
diff --git a/drivers/net/wireless/marvell/mwifiex/cfp.c b/drivers/net/wireless/marvell/mwifiex/cfp.c
index d7fd79214bcfb..686bf12b6c26b 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfp.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfp.c
@@ -153,7 +153,7 @@ struct region_code_mapping {
 	u8 region[IEEE80211_COUNTRY_STRING_LEN] __nonstring;
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
index 88bd21fd3c07f..3efdd53c4b59f 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1565,7 +1565,7 @@ int mwifiex_add_wowlan_magic_pkt_filter(struct mwifiex_adapter *adapter);
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



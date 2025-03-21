Return-Path: <linux-wireless+bounces-20635-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF1DA6B648
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 09:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF9119C4F5D
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 08:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606471F0980;
	Fri, 21 Mar 2025 08:50:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7811EB1AE
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742547029; cv=none; b=nouY4aAFVwq56PrlE+PZZ3CZPUZsP+viv8KrbbuEoDWKnFVWS171YpFB+zkH9mSn4sB8ZqVLuXRZ2WGZN2uD1ptF2O847ToZUXnDxYWvLY5f/T1WyACZ12FuyjghM+od+kGniavcS9aW/zhmUWjM7tMAklbe8IDKVAcd/NrVl58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742547029; c=relaxed/simple;
	bh=P+PKGnzTfrP23Udni7Vzlx28z9oAafx/tlenUU/je5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TtZ0Dol83ExdvczuupTX76Z3JXEX9NH9YgWOznHE1NMK5ZjTikhEjIxJk5lv7JWIZHaOBaaLI4GGb6MzI1cHAQIklZyIuOKszCfzZtADMCgRWCeLC8RYuRN+zVBuZJ55eXVSdY2WpY0NNoGKZZJdX+7RWGjWhSqvFUkEa+5thOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tvY51-0001Lq-Da; Fri, 21 Mar 2025 09:50:15 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tvY4z-000taP-2U;
	Fri, 21 Mar 2025 09:50:14 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tvY50-003L3W-0B;
	Fri, 21 Mar 2025 09:50:14 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 21 Mar 2025 09:50:06 +0100
Subject: [PATCH v4 06/10] wifi: mwifiex: simplify mwifiex_setup_ht_caps()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-mwifiex-cleanup-1-v4-6-4a32b21e2553@pengutronix.de>
References: <20250321-mwifiex-cleanup-1-v4-0-4a32b21e2553@pengutronix.de>
In-Reply-To: <20250321-mwifiex-cleanup-1-v4-0-4a32b21e2553@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742547013; l=2368;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=P+PKGnzTfrP23Udni7Vzlx28z9oAafx/tlenUU/je5s=;
 b=8IQf662YmUX5ChCdteUh1WFHnI5yCmPjhI1PCgkSKfuQCn8E/J4tqi0I+onR+V88CGGZlT44C
 m74KDjXB+1nBFuUWZMpmCbGlvrkDRiUKEDabNrkT2vpMSMh9YWleMQh
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

In mwifiex_setup_ht_caps() first a local struct ieee80211_mcs_info
is initialized and afterwards copied over &ht_info->mcs. Simplify
this by initializing &ht_info->mcs directly.

While at it call memset on the u8 rx_mask[] array instead of the struct
which makes the intention clearer and we no longer have to assume the
rx_mask array is the first member of struct ieee80211_mcs_info.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 33bc5cd3ce960..1d9bc8f980c8d 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -2906,16 +2906,12 @@ mwifiex_setup_ht_caps(struct ieee80211_sta_ht_cap *ht_info,
 		      struct mwifiex_private *priv)
 {
 	int rx_mcs_supp;
-	struct ieee80211_mcs_info mcs_set;
-	u8 *mcs = (u8 *)&mcs_set;
 	struct mwifiex_adapter *adapter = priv->adapter;
 
 	ht_info->ht_supported = true;
 	ht_info->ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
 	ht_info->ampdu_density = IEEE80211_HT_MPDU_DENSITY_NONE;
 
-	memset(&ht_info->mcs, 0, sizeof(ht_info->mcs));
-
 	/* Fill HT capability information */
 	if (ISSUPP_CHANWIDTH40(adapter->hw_dot_11n_dev_cap))
 		ht_info->cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40;
@@ -2961,17 +2957,15 @@ mwifiex_setup_ht_caps(struct ieee80211_sta_ht_cap *ht_info,
 	ht_info->cap |= IEEE80211_HT_CAP_SM_PS;
 
 	rx_mcs_supp = GET_RXMCSSUPP(adapter->user_dev_mcs_support);
+
+	memset(&ht_info->mcs, 0, sizeof(ht_info->mcs));
 	/* Set MCS for 1x1/2x2 */
-	memset(mcs, 0xff, rx_mcs_supp);
-	/* Clear all the other values */
-	memset(&mcs[rx_mcs_supp], 0,
-	       sizeof(struct ieee80211_mcs_info) - rx_mcs_supp);
+	memset(ht_info->mcs.rx_mask, 0xff, rx_mcs_supp);
+
 	if (priv->bss_mode == NL80211_IFTYPE_STATION ||
 	    ISSUPP_CHANWIDTH40(adapter->hw_dot_11n_dev_cap))
 		/* Set MCS32 for infra mode or ad-hoc mode with 40MHz support */
-		SETHT_MCS32(mcs_set.rx_mask);
-
-	memcpy((u8 *) &ht_info->mcs, mcs, sizeof(struct ieee80211_mcs_info));
+		SETHT_MCS32(ht_info->mcs.rx_mask);
 
 	ht_info->mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
 }

-- 
2.39.5



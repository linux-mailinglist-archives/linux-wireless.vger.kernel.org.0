Return-Path: <linux-wireless+bounces-21382-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6556DA840BD
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 12:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8CD3AEA6A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 10:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60982853FA;
	Thu, 10 Apr 2025 10:25:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04B0284B58
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280717; cv=none; b=ui+ccneQzDWsAzstrV/UIpikZ58CqBeqOBqRUeMjG44eVgG/BQkmH7pP8NVpSWnbuZPq/jJ00cnKS8AL6fHuI+lz7RsFtATY4OURHBbWTU8ywaPCbwkzdybbf7v1GmPecE8VtBrQbQqApjViuT7E2uUjoE22zpZy8JuJ4nn1MJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280717; c=relaxed/simple;
	bh=nt+RA2PEb1rBYOFg/KbiJGocixEt5bp9cJpa0Hka3K8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KU4wLo2Gjt/+mVEYrPiLPqxJegjAyEI7Jxg/FJEQ5OxaY8BGbUutxWbPKDgoRKs/fjIBY9ltwkBa6kJGpbVTb0+IJir13OXQ/nFfbx54KLChOqOYqKBaH2KlmUx5P2oppDMfowOfDUUzKy6hgpzeUkX5UCtGmAXc/ipzIkpN8Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p5C-0002DG-5i; Thu, 10 Apr 2025 12:24:30 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p5A-004Fmz-2r;
	Thu, 10 Apr 2025 12:24:28 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p5A-002ODU-2O;
	Thu, 10 Apr 2025 12:24:28 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 10 Apr 2025 12:24:30 +0200
Subject: [PATCH wireless-next v6 6/9] wifi: mwifiex: simplify
 mwifiex_setup_ht_caps()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-mwifiex-cleanup-1-v6-6-a6bbd4ac4d37@pengutronix.de>
References: <20250410-mwifiex-cleanup-1-v6-0-a6bbd4ac4d37@pengutronix.de>
In-Reply-To: <20250410-mwifiex-cleanup-1-v6-0-a6bbd4ac4d37@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744280668; l=2419;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=nt+RA2PEb1rBYOFg/KbiJGocixEt5bp9cJpa0Hka3K8=;
 b=PGGT8nVJMqbToJ/pQIyVmvysnIns+uBNtP3Xa3hbQHCTH7p3hp06BLob4oOS0PKhCcH9zx28K
 5reydWOLU41DF12xz5n/pFI9qrXujO6rpkj5fQjJlPis2Tx5UftC8qJ
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
Acked-by: Brian Norris <briannorris@chromium.org>
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



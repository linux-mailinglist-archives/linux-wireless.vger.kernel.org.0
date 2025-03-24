Return-Path: <linux-wireless+bounces-20757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48506A6DB5B
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 14:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E121701A3
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 13:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3B1261392;
	Mon, 24 Mar 2025 13:24:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4D925EFAE
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822682; cv=none; b=If3m4CENFtDsOzyb2jZ1KmB8DYdEudkcYWb01y4KRVXEXKKUjajQRZxtaTs0MQTt326QC85+lSLRD54VDqZ1mgpCmzlbcw8t6+i1CT/OPes5vbzZmPq4zx7QOr62oV/d4OWut2MImKi8f851Rk1Gz8rRSHzkZYOxFu6o17RqlPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822682; c=relaxed/simple;
	bh=P+PKGnzTfrP23Udni7Vzlx28z9oAafx/tlenUU/je5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AQGWiDisRP20kHar48RlgH3DC0wNlFrIka4qzw6BJBOEGzeDLG3Y3ACj3Q4waEK43e93muyphn6wjaUDuGtNypSic7Fl2YFn8r2avmokwRotUPHe0vDzSMvygx8OcZDpBb0FLlARGOb1ykxegnB+/xI+tlyKQuCxr6DIP0t3Xbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1twhmm-0003sI-72; Mon, 24 Mar 2025 14:24:12 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1twhml-001PyP-08;
	Mon, 24 Mar 2025 14:24:11 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1twhml-004Vqr-1D;
	Mon, 24 Mar 2025 14:24:11 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 24 Mar 2025 14:24:07 +0100
Subject: [PATCH wireless-next v5 06/10] wifi: mwifiex: simplify
 mwifiex_setup_ht_caps()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-mwifiex-cleanup-1-v5-6-1128a2be02af@pengutronix.de>
References: <20250324-mwifiex-cleanup-1-v5-0-1128a2be02af@pengutronix.de>
In-Reply-To: <20250324-mwifiex-cleanup-1-v5-0-1128a2be02af@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742822651; l=2368;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=P+PKGnzTfrP23Udni7Vzlx28z9oAafx/tlenUU/je5s=;
 b=nts+uaaKh1CMICcIuDwQK56+e+v+LVCFNX93rEfnbRExQ8O4JX+/d7+RGDSr0DxPr5kteM2VT
 hxrV5/cJ2xwCOGsBMzAAPJSCKIPB1wsBpen009nmkC7aAGcYy/A8Ic+
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



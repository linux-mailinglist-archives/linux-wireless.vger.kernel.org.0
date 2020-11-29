Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AAF2C79BC
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Nov 2020 16:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgK2Pbt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Nov 2020 10:31:49 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:33532 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726021AbgK2Pbs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Nov 2020 10:31:48 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kjOfF-0035ld-Ae; Sun, 29 Nov 2020 17:31:01 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 29 Nov 2020 17:30:47 +0200
Message-Id: <iwlwifi.20201129172929.8228e2be791e.I626c93241fef66bc71aa0cb9719aba1b11232cf1@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129153055.1971298-1-luca@coelho.fi>
References: <20201129153055.1971298-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 05/13] mac80211: Skip entries with SAE H2E only membership selector
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

When parsing supported rates IE.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/mlme.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b0afb61d9e84..6de63ba6b1c8 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3199,8 +3199,8 @@ static void ieee80211_get_rates(struct ieee80211_supported_band *sband,
 			*have_higher_than_11mbit = true;
 
 		/*
-		 * Skip HT, VHT and HE BSS membership selectors since they're
-		 * not rates.
+		 * Skip HT, VHT, HE and SAE H2E only BSS membership selectors
+		 * since they're not rates.
 		 *
 		 * Note: Even though the membership selector and the basic
 		 *	 rate flag share the same bit, they are not exactly
@@ -3208,7 +3208,8 @@ static void ieee80211_get_rates(struct ieee80211_supported_band *sband,
 		 */
 		if (supp_rates[i] == (0x80 | BSS_MEMBERSHIP_SELECTOR_HT_PHY) ||
 		    supp_rates[i] == (0x80 | BSS_MEMBERSHIP_SELECTOR_VHT_PHY) ||
-		    supp_rates[i] == (0x80 | BSS_MEMBERSHIP_SELECTOR_HE_PHY))
+		    supp_rates[i] == (0x80 | BSS_MEMBERSHIP_SELECTOR_HE_PHY) ||
+		    supp_rates[i] == (0x80 | BSS_MEMBERSHIP_SELECTOR_SAE_H2E))
 			continue;
 
 		for (j = 0; j < sband->n_bitrates; j++) {
-- 
2.29.2


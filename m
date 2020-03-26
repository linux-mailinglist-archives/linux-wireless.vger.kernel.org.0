Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 214C2193E7F
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 13:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgCZMBD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 08:01:03 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44112 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728001AbgCZMBC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 08:01:02 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHRC0-0003we-K8; Thu, 26 Mar 2020 14:01:01 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 14:00:35 +0200
Message-Id: <20200326120042.578777-6-luca@coelho.fi>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326120042.578777-1-luca@coelho.fi>
References: <20200326120042.578777-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 05/12] mac80211: Skip entries with HE membership selector
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

When parsing supported rates IE.

Change-Id: I93aad0e5ddb7ce79f05f8153922acb9aa5076d38
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/mlme.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a0de21a51f65..04ed883339c7 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3154,15 +3154,16 @@ static void ieee80211_get_rates(struct ieee80211_supported_band *sband,
 			*have_higher_than_11mbit = true;
 
 		/*
-		 * Skip HT and VHT BSS membership selectors since they're not
-		 * rates.
+		 * Skip HT, VHT and HE BSS membership selectors since they're
+		 * not rates.
 		 *
 		 * Note: Even though the membership selector and the basic
 		 *	 rate flag share the same bit, they are not exactly
 		 *	 the same.
 		 */
 		if (supp_rates[i] == (0x80 | BSS_MEMBERSHIP_SELECTOR_HT_PHY) ||
-		    supp_rates[i] == (0x80 | BSS_MEMBERSHIP_SELECTOR_VHT_PHY))
+		    supp_rates[i] == (0x80 | BSS_MEMBERSHIP_SELECTOR_VHT_PHY) ||
+		    supp_rates[i] == (0x80 | BSS_MEMBERSHIP_SELECTOR_HE_PHY))
 			continue;
 
 		for (j = 0; j < sband->n_bitrates; j++) {
-- 
2.25.1


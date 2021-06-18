Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4413AC97A
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 13:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbhFRLMN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 07:12:13 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48300 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229848AbhFRLML (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 07:12:11 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBx1-001YXx-JK; Fri, 18 Jun 2021 13:42:17 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:43 +0300
Message-Id: <iwlwifi.20210618133832.05e935e8dd98.I83ff7eb2ae8ebdf2e30c4fa2461344d9e569f599@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618104156.747775-1-luca@coelho.fi>
References: <20210618104156.747775-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 18/31] mac80211: always include HE 6GHz capability in assoc request
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If HE/6GHz is available (thus we consider dot11HE6GOptionImplemented
to be true), then always include the corresponding capability in the
association request as required by the spec.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/util.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index fb3b7bbfb1dc..08530da5ac05 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2960,15 +2960,15 @@ void ieee80211_ie_build_he_6ghz_cap(struct ieee80211_sub_if_data *sdata,
 	u8 *pos;
 	u16 cap;
 
-	sband = ieee80211_get_sband(sdata);
-	if (!sband)
+	if (!cfg80211_any_usable_channels(sdata->local->hw.wiphy,
+					  BIT(NL80211_BAND_6GHZ),
+					  IEEE80211_CHAN_NO_HE))
 		return;
 
-	if (sband->band != NL80211_BAND_6GHZ)
-		return;
+	sband = sdata->local->hw.wiphy->bands[NL80211_BAND_6GHZ];
 
 	iftd = ieee80211_get_sband_iftype_data(sband, iftype);
-	if (WARN_ON(!iftd))
+	if (!iftd)
 		return;
 
 	/* Check for device HE 6 GHz capability before adding element */
-- 
2.32.0


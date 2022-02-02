Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082444A6D44
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Feb 2022 09:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245251AbiBBIuI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Feb 2022 03:50:08 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37942 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245216AbiBBIuI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Feb 2022 03:50:08 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFBL3-0004v8-VA;
        Wed, 02 Feb 2022 10:50:06 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Wed,  2 Feb 2022 10:49:43 +0200
Message-Id: <iwlwifi.20220202104617.8e9b2bfaa0f5.I41c53f754eef28206d04dafc7263ccb99b63d490@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202084947.370289-1-luca@coelho.fi>
References: <20220202084947.370289-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 10/14] mac80211: airtime: avoid variable shadowing
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This isn't very dangerous, since the outer 'rate' variable
isn't even a pointer, but it's still confusing, so use a
different variable inside.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/airtime.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index 26d2f8ba7029..ffb7559b36d4 100644
--- a/net/mac80211/airtime.c
+++ b/net/mac80211/airtime.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: ISC
 /*
  * Copyright (C) 2019 Felix Fietkau <nbd@nbd.name>
+ * Copyright (C) 2021 Intel Corporation
  */
 
 #include <net/mac80211.h>
@@ -650,12 +651,12 @@ u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 		struct sta_info *sta = container_of(pubsta, struct sta_info,
 						    sta);
 		struct ieee80211_rx_status stat;
-		struct ieee80211_tx_rate *rate = &sta->tx_stats.last_rate;
+		struct ieee80211_tx_rate *tx_rate = &sta->tx_stats.last_rate;
 		struct rate_info *ri = &sta->tx_stats.last_rate_info;
 		u32 duration, overhead;
 		u8 agg_shift;
 
-		if (ieee80211_fill_rx_status(&stat, hw, rate, ri, band, len))
+		if (ieee80211_fill_rx_status(&stat, hw, tx_rate, ri, band, len))
 			return 0;
 
 		if (stat.encoding == RX_ENC_LEGACY || !ampdu)
-- 
2.34.1


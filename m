Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFF201679A7
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2020 10:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgBUJpw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Feb 2020 04:45:52 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:55518 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgBUJpw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Feb 2020 04:45:52 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j54sY-00Eu34-8m; Fri, 21 Feb 2020 10:45:50 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: check vif pointer before airtime calculation
Date:   Fri, 21 Feb 2020 10:45:45 +0100
Message-Id: <20200221104544.dddb7a3568fd.I0ede2733a3c76e95daeab07538449ea847e7b78d@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In case of monitor mode injection, vif may be NULL, don't crash
on that in ieee80211_calc_expected_tx_airtime().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/tx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 38f20a370f2a..8dd93072f6e6 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018-2020 Intel Corporation
  *
  * Transmit and frame generation functions.
  */
@@ -3682,7 +3682,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 encap_out:
 	IEEE80211_SKB_CB(skb)->control.vif = vif;
 
-	if (wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL)) {
+	if (vif &&
+	    wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL)) {
 		u32 airtime;
 
 		airtime = ieee80211_calc_expected_tx_airtime(hw, vif, txq->sta,
-- 
2.24.1


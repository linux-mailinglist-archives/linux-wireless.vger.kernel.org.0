Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2223C2D04FA
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 13:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgLFMzx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 07:55:53 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34928 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727974AbgLFMzo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 07:55:44 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kltZ2-003AHZ-W4; Sun, 06 Dec 2020 14:54:57 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 14:54:46 +0200
Message-Id: <iwlwifi.20201206145305.0c46e5097cc0.I06e75706770c40b9ba1cabd1f8a78ab7a05c5b73@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206125450.564941-1-luca@coelho.fi>
References: <20201206125450.564941-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 07/11] mac80211: use bitfield helpers for BA session action frames
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Use the appropriate bitfield helpers for encoding and decoding
the capability field in the BA session action frames instead of
open-coding the shifts/masks.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/agg-rx.c |  8 ++++----
 net/mac80211/agg-tx.c | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index cd4cf84a7f99..cce28e3b2232 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -250,10 +250,10 @@ static void ieee80211_send_addba_resp(struct sta_info *sta, u8 *da, u16 tid,
 	mgmt->u.action.u.addba_resp.action_code = WLAN_ACTION_ADDBA_RESP;
 	mgmt->u.action.u.addba_resp.dialog_token = dialog_token;
 
-	capab = (u16)(amsdu << 0);	/* bit 0 A-MSDU support */
-	capab |= (u16)(policy << 1);	/* bit 1 aggregation policy */
-	capab |= (u16)(tid << 2); 	/* bit 5:2 TID number */
-	capab |= (u16)(buf_size << 6);	/* bit 15:6 max size of aggregation */
+	capab = u16_encode_bits(amsdu, IEEE80211_ADDBA_PARAM_AMSDU_MASK);
+	capab |= u16_encode_bits(policy, IEEE80211_ADDBA_PARAM_POLICY_MASK);
+	capab |= u16_encode_bits(tid, IEEE80211_ADDBA_PARAM_TID_MASK);
+	capab |= u16_encode_bits(buf_size, IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK);
 
 	mgmt->u.action.u.addba_resp.capab = cpu_to_le16(capab);
 	mgmt->u.action.u.addba_resp.timeout = cpu_to_le16(timeout);
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index b37c8a983d88..430a58587538 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -95,10 +95,10 @@ static void ieee80211_send_addba_request(struct ieee80211_sub_if_data *sdata,
 	mgmt->u.action.u.addba_req.action_code = WLAN_ACTION_ADDBA_REQ;
 
 	mgmt->u.action.u.addba_req.dialog_token = dialog_token;
-	capab = (u16)(1 << 0);		/* bit 0 A-MSDU support */
-	capab |= (u16)(1 << 1);		/* bit 1 aggregation policy */
-	capab |= (u16)(tid << 2); 	/* bit 5:2 TID number */
-	capab |= (u16)(agg_size << 6);	/* bit 15:6 max size of aggergation */
+	capab = IEEE80211_ADDBA_PARAM_AMSDU_MASK;
+	capab |= IEEE80211_ADDBA_PARAM_POLICY_MASK;
+	capab |= u16_encode_bits(tid, IEEE80211_ADDBA_PARAM_TID_MASK);
+	capab |= u16_encode_bits(agg_size, IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK);
 
 	mgmt->u.action.u.addba_req.capab = cpu_to_le16(capab);
 
@@ -950,8 +950,8 @@ void ieee80211_process_addba_resp(struct ieee80211_local *local,
 
 	capab = le16_to_cpu(mgmt->u.action.u.addba_resp.capab);
 	amsdu = capab & IEEE80211_ADDBA_PARAM_AMSDU_MASK;
-	tid = (capab & IEEE80211_ADDBA_PARAM_TID_MASK) >> 2;
-	buf_size = (capab & IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK) >> 6;
+	tid = u16_get_bits(capab, IEEE80211_ADDBA_PARAM_TID_MASK);
+	buf_size = u16_get_bits(capab, IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK);
 	buf_size = min(buf_size, local->hw.max_tx_aggregation_subframes);
 
 	txq = sta->sta.txq[tid];
-- 
2.29.2


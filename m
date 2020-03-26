Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2BD19421B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 15:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgCZOxl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 10:53:41 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:48806 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgCZOxl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 10:53:41 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jHTt5-00BYvu-M7; Thu, 26 Mar 2020 15:53:39 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] mac80211: remove ieee80211_tx_h_check_control_port_protocol()
Date:   Thu, 26 Mar 2020 15:53:35 +0100
Message-Id: <20200326155333.05f411833f60.Ibf3dccc8aea73ae868da352811e5f1a3aef72ee0@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326155333.f183f52b02f0.I4054e2a8c11c2ddcb795a0103c87be3538690243@changeid>
References: <20200326155333.f183f52b02f0.I4054e2a8c11c2ddcb795a0103c87be3538690243@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This code is actually not ever effective, since the skb->protocol
isn't set up correctly (or at all) on outgoing frames. Also, we
already set the flags (except for IEEE80211_TX_CTL_USE_MINRATE)
in other code paths, and rate control already handles the frames
specially. Just remove it entirely.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/tx.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index bc1c27dc8dd5..5a37f7924af4 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -568,21 +568,6 @@ ieee80211_tx_h_ps_buf(struct ieee80211_tx_data *tx)
 		return ieee80211_tx_h_multicast_ps_buf(tx);
 }
 
-static ieee80211_tx_result debug_noinline
-ieee80211_tx_h_check_control_port_protocol(struct ieee80211_tx_data *tx)
-{
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx->skb);
-
-	if (unlikely(tx->sdata->control_port_protocol == tx->skb->protocol)) {
-		if (tx->sdata->control_port_no_encrypt)
-			info->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT;
-		info->control.flags |= IEEE80211_TX_CTRL_PORT_CTRL_PROTO;
-		info->flags |= IEEE80211_TX_CTL_USE_MINRATE;
-	}
-
-	return TX_CONTINUE;
-}
-
 static ieee80211_tx_result debug_noinline
 ieee80211_tx_h_select_key(struct ieee80211_tx_data *tx)
 {
@@ -1775,7 +1760,6 @@ static int invoke_tx_handlers_early(struct ieee80211_tx_data *tx)
 	CALL_TXH(ieee80211_tx_h_dynamic_ps);
 	CALL_TXH(ieee80211_tx_h_check_assoc);
 	CALL_TXH(ieee80211_tx_h_ps_buf);
-	CALL_TXH(ieee80211_tx_h_check_control_port_protocol);
 	CALL_TXH(ieee80211_tx_h_select_key);
 	if (!ieee80211_hw_check(&tx->local->hw, HAS_RATE_CONTROL))
 		CALL_TXH(ieee80211_tx_h_rate_ctrl);
-- 
2.25.1


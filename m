Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906182D04FB
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 13:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgLFMzx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 07:55:53 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34920 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727972AbgLFMzo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 07:55:44 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kltZ2-003AHZ-8N; Sun, 06 Dec 2020 14:54:56 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 14:54:45 +0200
Message-Id: <iwlwifi.20201206145305.4786559af475.Ia54486bb0a12e5351f9d5c60ef6fcda7c9e7141c@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206125450.564941-1-luca@coelho.fi>
References: <20201206125450.564941-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 06/11] mac80211: support Rx timestamp calculation for all preamble types
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Add support for calculating the Rx timestamp for HE frames.
Since now all frame types are supported, allow setting the Rx
timestamp regardless of the frame type.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/ieee80211_i.h |  9 ++----
 net/mac80211/util.c        | 66 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index cd8275e4b2cd..cb721c7c1cdb 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1589,13 +1589,8 @@ ieee80211_have_rx_timestamp(struct ieee80211_rx_status *status)
 {
 	WARN_ON_ONCE(status->flag & RX_FLAG_MACTIME_START &&
 		     status->flag & RX_FLAG_MACTIME_END);
-	if (status->flag & (RX_FLAG_MACTIME_START | RX_FLAG_MACTIME_END))
-		return true;
-	/* can't handle non-legacy preamble yet */
-	if (status->flag & RX_FLAG_MACTIME_PLCP_START &&
-	    status->encoding == RX_ENC_LEGACY)
-		return true;
-	return false;
+	return !!(status->flag & (RX_FLAG_MACTIME_START | RX_FLAG_MACTIME_END |
+				  RX_FLAG_MACTIME_PLCP_START));
 }
 
 void ieee80211_vif_inc_num_mcast(struct ieee80211_sub_if_data *sdata);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 8c3c01a1b923..6234e5c2b07b 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3666,6 +3666,7 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 	u64 ts = status->mactime;
 	struct rate_info ri;
 	u16 rate;
+	u8 n_ltf;
 
 	if (WARN_ON(!ieee80211_have_rx_timestamp(status)))
 		return 0;
@@ -3676,11 +3677,58 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 
 	/* Fill cfg80211 rate info */
 	switch (status->encoding) {
+	case RX_ENC_HE:
+		ri.flags |= RATE_INFO_FLAGS_HE_MCS;
+		ri.mcs = status->rate_idx;
+		ri.nss = status->nss;
+		ri.he_ru_alloc = status->he_ru;
+		if (status->enc_flags & RX_ENC_FLAG_SHORT_GI)
+			ri.flags |= RATE_INFO_FLAGS_SHORT_GI;
+
+		/*
+		 * See P802.11ax_D6.0, section 27.3.4 for
+		 * VHT PPDU format.
+		 */
+		if (status->flag & RX_FLAG_MACTIME_PLCP_START) {
+			mpdu_offset += 2;
+			ts += 36;
+
+			/*
+			 * TODO:
+			 * For HE MU PPDU, add the HE-SIG-B.
+			 * For HE ER PPDU, add 8us for the HE-SIG-A.
+			 * For HE TB PPDU, add 4us for the HE-STF.
+			 * Add the HE-LTF durations - variable.
+			 */
+		}
+
+		break;
 	case RX_ENC_HT:
 		ri.mcs = status->rate_idx;
 		ri.flags |= RATE_INFO_FLAGS_MCS;
 		if (status->enc_flags & RX_ENC_FLAG_SHORT_GI)
 			ri.flags |= RATE_INFO_FLAGS_SHORT_GI;
+
+		/*
+		 * See P802.11REVmd_D3.0, section 19.3.2 for
+		 * HT PPDU format.
+		 */
+		if (status->flag & RX_FLAG_MACTIME_PLCP_START) {
+			mpdu_offset += 2;
+			if (status->enc_flags & RX_ENC_FLAG_HT_GF)
+				ts += 24;
+			else
+				ts += 32;
+
+			/*
+			 * Add Data HT-LTFs per streams
+			 * TODO: add Extension HT-LTFs, 4us per LTF
+			 */
+			n_ltf = ((ri.mcs >> 3) & 3) + 1;
+			n_ltf = n_ltf == 3 ? 4 : n_ltf;
+			ts += n_ltf * 4;
+		}
+
 		break;
 	case RX_ENC_VHT:
 		ri.flags |= RATE_INFO_FLAGS_VHT_MCS;
@@ -3688,6 +3736,23 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 		ri.nss = status->nss;
 		if (status->enc_flags & RX_ENC_FLAG_SHORT_GI)
 			ri.flags |= RATE_INFO_FLAGS_SHORT_GI;
+
+		/*
+		 * See P802.11REVmd_D3.0, section 21.3.2 for
+		 * VHT PPDU format.
+		 */
+		if (status->flag & RX_FLAG_MACTIME_PLCP_START) {
+			mpdu_offset += 2;
+			ts += 36;
+
+			/*
+			 * Add VHT-LTFs per streams
+			 */
+			n_ltf = (ri.nss != 1) && (ri.nss % 2) ?
+				ri.nss + 1 : ri.nss;
+			ts += 4 * n_ltf;
+		}
+
 		break;
 	default:
 		WARN_ON(1);
@@ -3711,7 +3776,6 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 		ri.legacy = DIV_ROUND_UP(bitrate, (1 << shift));
 
 		if (status->flag & RX_FLAG_MACTIME_PLCP_START) {
-			/* TODO: handle HT/VHT preambles */
 			if (status->band == NL80211_BAND_5GHZ) {
 				ts += 20 << shift;
 				mpdu_offset += 2;
-- 
2.29.2


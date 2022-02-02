Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EDD4A6D4C
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Feb 2022 09:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245247AbiBBIuK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Feb 2022 03:50:10 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37948 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245237AbiBBIuK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Feb 2022 03:50:10 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFBL6-0004v8-4g;
        Wed, 02 Feb 2022 10:50:09 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Wed,  2 Feb 2022 10:49:46 +0200
Message-Id: <iwlwifi.20220202104617.7023450fdf16.I194df59252097ba25a0a543456d4350f1607a538@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202084947.370289-1-luca@coelho.fi>
References: <20220202084947.370289-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 13/14] mac80211: mlme: validate peer HE supported rates
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

We validate that AP has mandatory rates set in HE capabilities.

Also we make sure AP is consistent with itself on rates set in HE basic
rates required joining the BSS and rates set in HE capabilities.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/mlme.c | 101 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index bf777943cacd..cb89538571c2 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5006,6 +5006,104 @@ static u8 ieee80211_max_rx_chains(struct ieee80211_sub_if_data *sdata,
 	return chains;
 }
 
+static bool
+ieee80211_verify_peer_he_mcs_support(struct ieee80211_sub_if_data *sdata,
+				     const struct cfg80211_bss_ies *ies,
+				     const struct ieee80211_he_operation *he_op)
+{
+	const struct element *he_cap_elem;
+	const struct ieee80211_he_cap_elem *he_cap;
+	struct ieee80211_he_mcs_nss_supp *he_mcs_nss_supp;
+	u16 mcs_80_map_tx, mcs_80_map_rx;
+	u16 ap_min_req_set;
+	int mcs_nss_size;
+	int nss;
+
+	he_cap_elem = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY,
+					     ies->data, ies->len);
+
+	/* invalid HE IE */
+	if (!he_cap_elem || he_cap_elem->datalen < 1 + sizeof(*he_cap)) {
+		sdata_info(sdata,
+			   "Invalid HE elem, Disable HE\n");
+		return false;
+	}
+
+	/* skip one byte ext_tag_id */
+	he_cap = (void *)(he_cap_elem->data + 1);
+	mcs_nss_size = ieee80211_he_mcs_nss_size(he_cap);
+
+	/* invalid HE IE */
+	if (he_cap_elem->datalen < 1 + sizeof(*he_cap) + mcs_nss_size) {
+		sdata_info(sdata,
+			   "Invalid HE elem with nss size, Disable HE\n");
+		return false;
+	}
+
+	/* mcs_nss is right after he_cap info */
+	he_mcs_nss_supp = (void *)(he_cap + 1);
+
+	mcs_80_map_tx = le16_to_cpu(he_mcs_nss_supp->tx_mcs_80);
+	mcs_80_map_rx = le16_to_cpu(he_mcs_nss_supp->rx_mcs_80);
+
+	/* P802.11-REVme/D0.3
+	 * 27.1.1 Introduction to the HE PHY
+	 * ...
+	 * An HE STA shall support the following features:
+	 * ...
+	 * Single spatial stream HE-MCSs 0 to 7 (transmit and receive) in all
+	 * supported channel widths for HE SU PPDUs
+	 */
+	if ((mcs_80_map_tx & 0x3) == IEEE80211_HE_MCS_NOT_SUPPORTED ||
+	    (mcs_80_map_rx & 0x3) == IEEE80211_HE_MCS_NOT_SUPPORTED) {
+		sdata_info(sdata,
+			   "Missing mandatory rates for 1 Nss, rx 0x%x, tx 0x%x, disable HE\n",
+			   mcs_80_map_tx, mcs_80_map_rx);
+		return false;
+	}
+
+	if (!he_op)
+		return true;
+
+	ap_min_req_set = le16_to_cpu(he_op->he_mcs_nss_set);
+
+	/* make sure the AP is consistent with itself
+	 *
+	 * P802.11-REVme/D0.3
+	 * 26.17.1 Basic HE BSS operation
+	 *
+	 * A STA that is operating in an HE BSS shall be able to receive and
+	 * transmit at each of the <HE-MCS, NSS> tuple values indicated by the
+	 * Basic HE-MCS And NSS Set field of the HE Operation parameter of the
+	 * MLME-START.request primitive and shall be able to receive at each of
+	 * the <HE-MCS, NSS> tuple values indicated by the Supported HE-MCS and
+	 * NSS Set field in the HE Capabilities parameter of the MLMESTART.request
+	 * primitive
+	 */
+	for (nss = 8; nss > 0; nss--) {
+		u8 ap_op_val = (ap_min_req_set >> (2 * (nss - 1))) & 3;
+		u8 ap_rx_val;
+		u8 ap_tx_val;
+
+		if (ap_op_val == IEEE80211_HE_MCS_NOT_SUPPORTED)
+			continue;
+
+		ap_rx_val = (mcs_80_map_rx >> (2 * (nss - 1))) & 3;
+		ap_tx_val = (mcs_80_map_tx >> (2 * (nss - 1))) & 3;
+
+		if (ap_rx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
+		    ap_tx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
+		    ap_rx_val < ap_op_val || ap_tx_val < ap_op_val) {
+			sdata_info(sdata,
+				   "Invalid rates for %d Nss, rx %d, tx %d oper %d, disable HE\n",
+				   nss, ap_rx_val, ap_rx_val, ap_op_val);
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static bool
 ieee80211_verify_sta_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_supported_band *sband,
@@ -5191,7 +5289,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 			}
 		}
 
-		if (!ieee80211_verify_sta_he_mcs_support(sdata, sband, he_oper))
+		if (!ieee80211_verify_peer_he_mcs_support(sdata, ies, he_oper) ||
+		    !ieee80211_verify_sta_he_mcs_support(sdata, sband, he_oper))
 			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
 	}
 
-- 
2.34.1


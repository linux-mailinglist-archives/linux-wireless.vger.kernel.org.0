Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1894A6D49
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Feb 2022 09:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243066AbiBBIuA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Feb 2022 03:50:00 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37926 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245223AbiBBIuA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Feb 2022 03:50:00 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFBKv-0004v8-5T;
        Wed, 02 Feb 2022 10:49:58 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Wed,  2 Feb 2022 10:49:35 +0200
Message-Id: <iwlwifi.20220202104617.3713e0dea5dd.I3b9a15b4c53465c3f86f35459e9dc15ae4ea2abd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202084947.370289-1-luca@coelho.fi>
References: <20220202084947.370289-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 02/14] mac80211: consider RX NSS in UHB connection
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

In UHB connection we don't have any HT/VHT elemens so in order to
calculate the max RX-NSS we need also to look at HE capa element, this
causes to limit us to max rx nss in UHB to 1.

Also anyway we need to look at HE max rx NSS and not only at HT/VHT
capa to determine the max rx nss over the connection.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/mlme.c | 61 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 55e21557a3d2..291226a1599d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4907,13 +4907,20 @@ void ieee80211_mlme_notify_scan_completed(struct ieee80211_local *local)
 	rcu_read_unlock();
 }
 
-static u8 ieee80211_ht_vht_rx_chains(struct ieee80211_sub_if_data *sdata,
-				     struct cfg80211_bss *cbss)
+static u8 ieee80211_max_rx_chains(struct ieee80211_sub_if_data *sdata,
+				  struct cfg80211_bss *cbss)
 {
+	struct ieee80211_he_mcs_nss_supp *he_mcs_nss_supp;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	const struct element *ht_cap_elem, *vht_cap_elem;
+	const struct cfg80211_bss_ies *ies;
 	const struct ieee80211_ht_cap *ht_cap;
 	const struct ieee80211_vht_cap *vht_cap;
+	const struct ieee80211_he_cap_elem *he_cap;
+	const struct element *he_cap_elem;
+	u16 mcs_80_map, mcs_160_map;
+	int i, mcs_nss_size;
+	bool support_160;
 	u8 chains = 1;
 
 	if (ifmgd->flags & IEEE80211_STA_DISABLE_HT)
@@ -4948,6 +4955,54 @@ static u8 ieee80211_ht_vht_rx_chains(struct ieee80211_sub_if_data *sdata,
 		chains = max(chains, nss);
 	}
 
+	if (ifmgd->flags & IEEE80211_STA_DISABLE_HE)
+		return chains;
+
+	ies = rcu_dereference(cbss->ies);
+	he_cap_elem = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY,
+					     ies->data, ies->len);
+
+	if (!he_cap_elem || he_cap_elem->datalen < sizeof(*he_cap))
+		return chains;
+
+	/* skip one byte ext_tag_id */
+	he_cap = (void *)(he_cap_elem->data + 1);
+	mcs_nss_size = ieee80211_he_mcs_nss_size(he_cap);
+
+	/* invalid HE IE */
+	if (he_cap_elem->datalen < 1 + mcs_nss_size + sizeof(*he_cap))
+		return chains;
+
+	/* mcs_nss is right after he_cap info */
+	he_mcs_nss_supp = (void *)(he_cap + 1);
+
+	mcs_80_map = le16_to_cpu(he_mcs_nss_supp->tx_mcs_80);
+
+	for (i = 7; i >= 0; i--) {
+		u8 mcs_80 = mcs_80_map >> (2 * i) & 3;
+
+		if (mcs_80 != IEEE80211_VHT_MCS_NOT_SUPPORTED) {
+			chains = max_t(u8, chains, i + 1);
+			break;
+		}
+	}
+
+	support_160 = he_cap->phy_cap_info[0] &
+		      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+
+	if (!support_160)
+		return chains;
+
+	mcs_160_map = le16_to_cpu(he_mcs_nss_supp->tx_mcs_160);
+	for (i = 7; i >= 0; i--) {
+		u8 mcs_160 = mcs_160_map >> (2 * i) & 3;
+
+		if (mcs_160 != IEEE80211_VHT_MCS_NOT_SUPPORTED) {
+			chains = max_t(u8, chains, i + 1);
+			break;
+		}
+	}
+
 	return chains;
 }
 
@@ -5162,7 +5217,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 						     s1g_oper,
 						     &chandef, false);
 
-	sdata->needed_rx_chains = min(ieee80211_ht_vht_rx_chains(sdata, cbss),
+	sdata->needed_rx_chains = min(ieee80211_max_rx_chains(sdata, cbss),
 				      local->rx_chains);
 
 	rcu_read_unlock();
-- 
2.34.1


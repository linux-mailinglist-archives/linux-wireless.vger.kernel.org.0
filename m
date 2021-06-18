Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E31C3AC975
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 13:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhFRLKc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 07:10:32 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48292 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232184AbhFRLKa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 07:10:30 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBx9-001YXx-Si; Fri, 18 Jun 2021 13:42:25 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:53 +0300
Message-Id: <iwlwifi.20210618133832.80d716d69a5f.I28097ff19be6b22aebdc33a72795d2662755d41f@changeid>
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
Subject: [PATCH 28/31] mac80211: add vendor-specific capabilities to assoc request
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When sending an association request, add any vendor specific
capabilities at the end of the frame. This way, mac80211 is
still completely in charge of building the frame, but drivers
can determine what should be added depending on the band and
interface type.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/mlme.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a5d0f62de5c3..9af6fac56429 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -681,6 +681,8 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	u32 rates = 0;
 	__le16 listen_int;
 	struct element *ext_capa = NULL;
+	enum nl80211_iftype iftype = ieee80211_vif_type_p2p(&sdata->vif);
+	const struct ieee80211_sband_iftype_data *iftd;
 
 	/* we know it's writable, cast away the const */
 	if (assoc_data->ie_len)
@@ -725,6 +727,8 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		}
 	}
 
+	iftd = ieee80211_get_sband_iftype_data(sband, iftype);
+
 	skb = alloc_skb(local->hw.extra_tx_headroom +
 			sizeof(*mgmt) + /* bit too much but doesn't matter */
 			2 + assoc_data->ssid_len + /* SSID */
@@ -739,7 +743,8 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 			2 + 1 + sizeof(struct ieee80211_he_6ghz_capa) +
 			assoc_data->ie_len + /* extra IEs */
 			(assoc_data->fils_kek_len ? 16 /* AES-SIV */ : 0) +
-			9, /* WMM */
+			9 + /* WMM */
+			(iftd ? iftd->vendor_elems.len : 0),
 			GFP_KERNEL);
 	if (!skb)
 		return;
@@ -1012,6 +1017,9 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		ieee80211_add_s1g_capab_ie(sdata, &sband->s1g_cap, skb);
 	}
 
+	if (iftd && iftd->vendor_elems.data && iftd->vendor_elems.len)
+		skb_put_data(skb, iftd->vendor_elems.data, iftd->vendor_elems.len);
+
 	/* add any remaining custom (i.e. vendor specific here) IEs */
 	if (assoc_data->ie_len) {
 		noffset = assoc_data->ie_len;
-- 
2.32.0


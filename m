Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9AC14EB80
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 12:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgAaLNN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 06:13:13 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55782 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728342AbgAaLNM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 06:13:12 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixUEY-0002GC-95; Fri, 31 Jan 2020 13:13:10 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 13:12:41 +0200
Message-Id: <20200131111300.891737-5-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131111300.891737-1-luca@coelho.fi>
References: <20200131111300.891737-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 04/23] mac80211: set station bandwidth from HE capability
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Set the station bandwidth in HE capability parsing and from
HE capability as the HT/VHT information will not be present
on the 6 GHz band.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/he.c  |  4 ++++
 net/mac80211/vht.c | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 736da0035135..5245c19f39bf 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -3,6 +3,7 @@
  * HE handling
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
+ * Copyright(c) 2019 Intel Corporation
  */
 
 #include "ieee80211_i.h"
@@ -49,6 +50,9 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 		       he_ppe_size);
 
 	he_cap->has_he = true;
+
+	sta->cur_max_bandwidth = ieee80211_sta_cap_rx_bw(sta);
+	sta->sta.bandwidth = ieee80211_sta_cur_vht_bw(sta);
 }
 
 void
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index ccdcb9ad9ac7..a7cd22594a14 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -333,11 +333,33 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 	}
 }
 
+/* FIXME: move this to some better location - parses HE now */
 enum ieee80211_sta_rx_bandwidth ieee80211_sta_cap_rx_bw(struct sta_info *sta)
 {
 	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.vht_cap;
+	struct ieee80211_sta_he_cap *he_cap = &sta->sta.he_cap;
 	u32 cap_width;
 
+	if (he_cap->has_he) {
+		u8 info = he_cap->he_cap_elem.phy_cap_info[0];
+
+		if (sta->sdata->vif.bss_conf.chandef.chan->band ==
+				NL80211_BAND_2GHZ) {
+			if (info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G)
+				return IEEE80211_STA_RX_BW_40;
+			else
+				return IEEE80211_STA_RX_BW_20;
+		}
+
+		if (info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G ||
+		    info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
+			return IEEE80211_STA_RX_BW_160;
+		else if (info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G)
+			return IEEE80211_STA_RX_BW_80;
+
+		return IEEE80211_STA_RX_BW_20;
+	}
+
 	if (!vht_cap->vht_supported)
 		return sta->sta.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
 				IEEE80211_STA_RX_BW_40 :
@@ -433,6 +455,7 @@ ieee80211_chan_width_to_rx_bw(enum nl80211_chan_width width)
 	}
 }
 
+/* FIXME: rename/move - this deals with everything not just VHT */
 enum ieee80211_sta_rx_bandwidth ieee80211_sta_cur_vht_bw(struct sta_info *sta)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
-- 
2.24.1


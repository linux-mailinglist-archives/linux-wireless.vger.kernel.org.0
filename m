Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC694B5631
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 17:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356398AbiBNQa0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 11:30:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356375AbiBNQaW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 11:30:22 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D554260AAD
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 08:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=6Kud32n0do9zl2xzu2Tk56srHwYH4xqtQ6RCzwoRfBM=;
        t=1644856213; x=1646065813; b=tmCcDLUeal1hfsuDXFIorksuOZy1JnvcXP36pAny5yvAQkt
        O/EEQOsXMKgOyyr8ezHcz2dFbHZvAxQ4H9yh7benJPOb7ObdVEArp8s0Lego8/QEpAX7WHhNVJ3+W
        1H7IwnjSibRvWlx4AkcIQCvT7jZ/LTxd/6E8x2PWOf3M8J7SIXcc0aWzkiFQy8BkQc3BBRWlpXmeF
        GO0ftjIzMXzaKx7DFlTGnvOxmD5Gk3TxEJjr6vPyMYULh9RlObaBa4rQaySiMTflV0NcgMu3hf5vi
        Z5pV0szFX3Mbws2FoFGBGU/y+sipw4iWermbJSz89xD9E1QVd5ohFcoLJ4FotSFQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJeEu-0011mw-6X;
        Mon, 14 Feb 2022 17:30:12 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v3 15/19] mac80211: Handle station association response with EHT
Date:   Mon, 14 Feb 2022 17:30:02 +0100
Message-Id: <20220214173004.f33574718755.I21182234c5303d9423eabd5eb997e7cf75f8e0c8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
References: <20220214173004.9fd154d2c3c2.Ia0cd152357a373149bab017d479ab7d5ded289c0@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

When the association is an EHT association, parse the EHT
element from the association response and update the
station's EHT capabilities accordingly.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h     |  4 ++
 net/mac80211/Makefile      |  3 +-
 net/mac80211/eht.c         | 76 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  7 ++++
 net/mac80211/mlme.c        | 15 ++++++++
 net/mac80211/vht.c         | 16 +++++++-
 6 files changed, 118 insertions(+), 3 deletions(-)
 create mode 100644 net/mac80211/eht.c

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 586d3c26c8ac..f118b8fe667a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -636,6 +636,7 @@ struct ieee80211_fils_discovery {
  * @tx_pwr_env: transmit power envelope array of BSS.
  * @tx_pwr_env_num: number of @tx_pwr_env.
  * @pwr_reduction: power constraint of BSS.
+ * @eht_support: does this BSS support EHT
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -710,6 +711,7 @@ struct ieee80211_bss_conf {
 	struct ieee80211_tx_pwr_env tx_pwr_env[IEEE80211_TPE_MAX_IE_COUNT];
 	u8 tx_pwr_env_num;
 	u8 pwr_reduction;
+	bool eht_support;
 };
 
 /**
@@ -2071,6 +2073,7 @@ struct ieee80211_sta_txpwr {
  * @vht_cap: VHT capabilities of this STA; restricted to our own capabilities
  * @he_cap: HE capabilities of this STA
  * @he_6ghz_capa: on 6 GHz, holds the HE 6 GHz band capabilities
+ * @eht_cap: EHT capabilities of this STA
  * @max_rx_aggregation_subframes: maximal amount of frames in a single AMPDU
  *	that this station is allowed to transmit to us.
  *	Can be modified by driver.
@@ -2111,6 +2114,7 @@ struct ieee80211_sta {
 	struct ieee80211_sta_vht_cap vht_cap;
 	struct ieee80211_sta_he_cap he_cap;
 	struct ieee80211_he_6ghz_capa he_6ghz_capa;
+	struct ieee80211_sta_eht_cap eht_cap;
 	u16 max_rx_aggregation_subframes;
 	bool wme;
 	u8 uapsd_queues;
diff --git a/net/mac80211/Makefile b/net/mac80211/Makefile
index 23d25e8b2358..af1df3a6bd55 100644
--- a/net/mac80211/Makefile
+++ b/net/mac80211/Makefile
@@ -34,7 +34,8 @@ mac80211-y := \
 	trace.o mlme.o \
 	tdls.o \
 	ocb.o \
-	airtime.o
+	airtime.o \
+	eht.o
 
 mac80211-$(CONFIG_MAC80211_LEDS) += led.o
 mac80211-$(CONFIG_MAC80211_DEBUGFS) += \
diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
new file mode 100644
index 000000000000..364ad0ef7692
--- /dev/null
+++ b/net/mac80211/eht.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * EHT handling
+ *
+ * Copyright(c) 2021-2022 Intel Corporation
+ */
+
+#include "ieee80211_i.h"
+
+void
+ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
+				    struct ieee80211_supported_band *sband,
+				    const u8 *he_cap_ie, u8 he_cap_len,
+				    const struct ieee80211_eht_cap_elem *eht_cap_ie_elem,
+				    u8 eht_cap_len, struct sta_info *sta)
+{
+	struct ieee80211_sta_eht_cap *eht_cap = &sta->sta.eht_cap;
+	struct ieee80211_he_cap_elem *he_cap_ie_elem = (void *)he_cap_ie;
+	u8 eht_ppe_size = 0;
+	u8 mcs_nss_size;
+	u8 eht_total_size = sizeof(eht_cap->eht_cap_elem);
+	u8 *pos = (u8 *)eht_cap_ie_elem;
+
+	memset(eht_cap, 0, sizeof(*eht_cap));
+
+	if (!eht_cap_ie_elem ||
+	    !ieee80211_get_eht_iftype_cap(sband,
+					 ieee80211_vif_type_p2p(&sdata->vif)))
+		return;
+
+	mcs_nss_size = ieee80211_eht_mcs_nss_size(he_cap_ie_elem,
+						  &eht_cap_ie_elem->fixed);
+
+	eht_total_size += mcs_nss_size;
+
+	/* Calculate the PPE thresholds length only if the header is present */
+	if (eht_cap_ie_elem->fixed.phy_cap_info[5] &
+			IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT) {
+		u16 eht_ppe_hdr;
+
+		if (eht_cap_len < eht_total_size + sizeof(u16))
+			return;
+
+		eht_ppe_hdr = get_unaligned_le16(eht_cap_ie_elem->optional + mcs_nss_size);
+		eht_ppe_size =
+			ieee80211_eht_ppe_size(eht_ppe_hdr,
+					       eht_cap_ie_elem->fixed.phy_cap_info);
+		eht_total_size += eht_ppe_size;
+
+		/* we calculate as if NSS > 8 are valid, but don't handle that */
+		if (eht_ppe_size > sizeof(eht_cap->eht_ppe_thres))
+			return;
+	}
+
+	if (eht_cap_len < eht_total_size)
+		return;
+
+	/* Copy the static portion of the EHT capabilities */
+	memcpy(&eht_cap->eht_cap_elem, pos, sizeof(eht_cap->eht_cap_elem));
+	pos += sizeof(eht_cap->eht_cap_elem);
+
+	/* Copy MCS/NSS which depends on the peer capabilities */
+	memset(&eht_cap->eht_mcs_nss_supp, 0,
+	       sizeof(eht_cap->eht_mcs_nss_supp));
+	memcpy(&eht_cap->eht_mcs_nss_supp, pos, mcs_nss_size);
+
+	if (eht_ppe_size)
+		memcpy(eht_cap->eht_ppe_thres,
+		       &eht_cap_ie_elem->optional[mcs_nss_size],
+		       eht_ppe_size);
+
+	eht_cap->has_eht = true;
+
+	sta->cur_max_bandwidth = ieee80211_sta_cap_rx_bw(sta);
+	sta->sta.bandwidth = ieee80211_sta_cur_vht_bw(sta);
+}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 39844267f09e..6a2421a066fb 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2525,4 +2525,11 @@ u8 *ieee80211_ie_build_eht_cap(u8 *pos,
 			       const struct ieee80211_sta_he_cap *he_cap,
 			       const struct ieee80211_sta_eht_cap *eht_cap,
 			       u8 *end);
+
+void
+ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
+				    struct ieee80211_supported_band *sband,
+				    const u8 *he_cap_ie, u8 he_cap_len,
+				    const struct ieee80211_eht_cap_elem *eht_cap_ie_elem,
+				    u8 eht_cap_len, struct sta_info *sta);
 #endif /* IEEE80211_I_H */
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 752aa8734af6..197cad4a2768 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3579,10 +3579,25 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 			bss_conf->twt_protected = false;
 
 		changed |= ieee80211_recalc_twt_req(sdata, sta, elems);
+
+		if (elems->eht_operation && elems->eht_cap &&
+		    !(ifmgd->flags & IEEE80211_STA_DISABLE_EHT)) {
+			ieee80211_eht_cap_ie_to_sta_eht_cap(sdata, sband,
+							    elems->he_cap,
+							    elems->he_cap_len,
+							    elems->eht_cap,
+							    elems->eht_cap_len,
+							    sta);
+
+			bss_conf->eht_support = sta->sta.eht_cap.has_eht;
+		} else {
+			bss_conf->eht_support = false;
+		}
 	} else {
 		bss_conf->he_support = false;
 		bss_conf->twt_requester = false;
 		bss_conf->twt_protected = false;
+		bss_conf->eht_support = false;
 	}
 
 	bss_conf->twt_broadcast =
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index 904611d681cb..409d2fde83bf 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -329,15 +329,27 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 	}
 }
 
-/* FIXME: move this to some better location - parses HE now */
+/* FIXME: move this to some better location - parses HE/EHT now */
 enum ieee80211_sta_rx_bandwidth ieee80211_sta_cap_rx_bw(struct sta_info *sta)
 {
 	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.vht_cap;
 	struct ieee80211_sta_he_cap *he_cap = &sta->sta.he_cap;
+	struct ieee80211_sta_eht_cap *eht_cap = &sta->sta.eht_cap;
 	u32 cap_width;
 
 	if (he_cap->has_he) {
-		u8 info = he_cap->he_cap_elem.phy_cap_info[0];
+		u8 info;
+
+		if (eht_cap->has_eht &&
+		    sta->sdata->vif.bss_conf.chandef.chan->band ==
+		    NL80211_BAND_6GHZ) {
+			info = eht_cap->eht_cap_elem.phy_cap_info[0];
+
+			if (info & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ)
+				return IEEE80211_STA_RX_BW_320;
+		}
+
+		info = he_cap->he_cap_elem.phy_cap_info[0];
 
 		if (sta->sdata->vif.bss_conf.chandef.chan->band ==
 				NL80211_BAND_2GHZ) {
-- 
2.34.1


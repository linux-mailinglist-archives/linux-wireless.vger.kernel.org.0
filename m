Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FFA461695
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 14:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244757AbhK2NiW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 08:38:22 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:49784 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1377692AbhK2NgQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 08:36:16 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mrgm8-0012xo-R4; Mon, 29 Nov 2021 15:32:57 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:32:36 +0200
Message-Id: <iwlwifi.20211129152938.8efcf1856975.I130f678e4aa390973ab39d838bbfe7b2d54bff8e@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129133248.83829-1-luca@coelho.fi>
References: <20211129133248.83829-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 04/16] cfg80211: Use the HE operation IE to determine a 6GHz BSS channel
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ayala Beker <ayala.beker@intel.com>

A non-collocated AP whose primary channel is not a PSC channel
may transmit a duplicated beacon on the corresponding PSC channel
in which it would indicate its true primary channel.
Use this inforamtion contained in the HE operation IE to determine
the primary channel of the AP.
In case of invalid infomration ignore it and use the channel
the frame was received on.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/wireless/scan.c | 46 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 22e92be61938..3fd0757ead29 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1800,7 +1800,33 @@ int cfg80211_get_ies_channel_number(const u8 *ie, size_t ielen,
 	const u8 *tmp;
 	int channel_number = -1;
 
-	if (band == NL80211_BAND_S1GHZ) {
+	if (channel->band == NL80211_BAND_6GHZ) {
+		const struct element *elem;
+
+		elem = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ie,
+					      ielen);
+		if (elem && elem->datalen >= ieee80211_he_oper_size(&elem->data[1])) {
+			struct ieee80211_he_operation *he_oper =
+				(void *)(&elem->data[1]);
+			const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
+
+			he_6ghz_oper = ieee80211_he_6ghz_oper(he_oper);
+			if (!he_6ghz_oper)
+				return channel;
+
+			freq = ieee80211_channel_to_frequency(he_6ghz_oper->primary,
+							      NL80211_BAND_6GHZ);
+
+			/* duplicated beacon indication is relevant for beacons
+			 * only
+			 */
+			if (freq != channel->center_freq &&
+			    abs(freq - channel->center_freq) <= 80 &&
+			    (ftype != CFG80211_BSS_FTYPE_BEACON ||
+			     he_6ghz_oper->control & IEEE80211_HE_6GHZ_OPER_CTRL_DUP_BEACON))
+				channel_number = he_6ghz_oper->primary;
+		}
+	} else if (band == NL80211_BAND_S1GHZ) {
 		tmp = cfg80211_find_ie(WLAN_EID_S1G_OPERATION, ie, ielen);
 		if (tmp && tmp[1] >= sizeof(struct ieee80211_s1g_oper_ie)) {
 			struct ieee80211_s1g_oper_ie *s1gop = (void *)(tmp + 2);
@@ -1831,12 +1857,13 @@ EXPORT_SYMBOL(cfg80211_get_ies_channel_number);
  * from neighboring channels and the Beacon frames use the DSSS Parameter Set
  * element to indicate the current (transmitting) channel, but this might also
  * be needed on other bands if RX frequency does not match with the actual
- * operating channel of a BSS.
+ * operating channel of a BSS, or if the AP reports a different primary channel.
  */
 static struct ieee80211_channel *
 cfg80211_get_bss_channel(struct wiphy *wiphy, const u8 *ie, size_t ielen,
 			 struct ieee80211_channel *channel,
-			 enum nl80211_bss_scan_width scan_width)
+			 enum nl80211_bss_scan_width scan_width,
+			 enum cfg80211_bss_frame_type ftype)
 {
 	u32 freq;
 	int channel_number;
@@ -1911,7 +1938,7 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 		return NULL;
 
 	channel = cfg80211_get_bss_channel(wiphy, ie, ielen, data->chan,
-					   data->scan_width);
+					   data->scan_width, ftype);
 	if (!channel)
 		return NULL;
 
@@ -2333,6 +2360,7 @@ cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
 	size_t ielen, min_hdr_len = offsetof(struct ieee80211_mgmt,
 					     u.probe_resp.variable);
 	int bss_type;
+	enum cfg80211_bss_frame_type ftype;
 
 	BUILD_BUG_ON(offsetof(struct ieee80211_mgmt, u.probe_resp.variable) !=
 			offsetof(struct ieee80211_mgmt, u.beacon.variable));
@@ -2369,8 +2397,16 @@ cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
 			variable = ext->u.s1g_beacon.variable;
 	}
 
+	if (ieee80211_is_beacon(mgmt->frame_control))
+		ftype = CFG80211_BSS_FTYPE_BEACON;
+	else if (ieee80211_is_probe_resp(mgmt->frame_control))
+		ftype = CFG80211_BSS_FTYPE_PRESP;
+	else
+		ftype = CFG80211_BSS_FTYPE_UNKNOWN;
+
 	channel = cfg80211_get_bss_channel(wiphy, variable,
-					   ielen, data->chan, data->scan_width);
+					   ielen, data->chan, data->scan_width,
+					   ftype);
 	if (!channel)
 		return NULL;
 
-- 
2.33.1


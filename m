Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D1014EB7F
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 12:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgAaLNM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 06:13:12 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55776 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728268AbgAaLNM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 06:13:12 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixUEX-0002GC-Ia; Fri, 31 Jan 2020 13:13:10 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 13:12:40 +0200
Message-Id: <20200131111300.891737-4-luca@coelho.fi>
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
Subject: [PATCH 03/23] mac80211: refactor extended element parsing
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This code was really ugly, refactor it a bit to make it more
readable.

While at it, use sizeof() and fix the UORA element length
check bug.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/util.c | 75 +++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 27 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 780df3e9092e..72039c8dbc38 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -890,6 +890,51 @@ void ieee80211_queue_delayed_work(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_queue_delayed_work);
 
+static void ieee80211_parse_extension_element(u32 *crc,
+					      const struct element *elem,
+					      struct ieee802_11_elems *elems)
+{
+	const void *data = elem->data + 1;
+	u8 len = elem->datalen - 1;
+
+	switch (elem->data[0]) {
+	case WLAN_EID_EXT_HE_MU_EDCA:
+		if (len == sizeof(*elems->mu_edca_param_set)) {
+			elems->mu_edca_param_set = data;
+			if (crc)
+				*crc = crc32_be(*crc, (void *)elem,
+						elem->datalen + 2);
+		}
+		break;
+	case WLAN_EID_EXT_HE_CAPABILITY:
+		elems->he_cap = data;
+		elems->he_cap_len = len;
+		break;
+	case WLAN_EID_EXT_HE_OPERATION:
+		if (len >= sizeof(*elems->he_operation) &&
+		    len == ieee80211_he_oper_size(data) - 1)
+			elems->he_operation = data;
+		break;
+	case WLAN_EID_EXT_UORA:
+		if (len == 1)
+			elems->uora_element = data;
+		break;
+	case WLAN_EID_EXT_MAX_CHANNEL_SWITCH_TIME:
+		if (len == 3)
+			elems->max_channel_switch_time = data;
+		break;
+	case WLAN_EID_EXT_MULTIPLE_BSSID_CONFIGURATION:
+		if (len == sizeof(*elems->mbssid_config_ie))
+			elems->mbssid_config_ie = data;
+		break;
+	case WLAN_EID_EXT_HE_SPR:
+		if (len >= sizeof(*elems->he_spr) &&
+		    len >= ieee80211_he_spr_size(data))
+			elems->he_spr = data;
+		break;
+	}
+}
+
 static u32
 _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 			    struct ieee802_11_elems *elems,
@@ -1220,33 +1265,9 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 				elems->max_idle_period_ie = (void *)pos;
 			break;
 		case WLAN_EID_EXTENSION:
-			if (pos[0] == WLAN_EID_EXT_HE_MU_EDCA &&
-			    elen >= (sizeof(*elems->mu_edca_param_set) + 1)) {
-				elems->mu_edca_param_set = (void *)&pos[1];
-				if (calc_crc)
-					crc = crc32_be(crc, pos - 2, elen + 2);
-			} else if (pos[0] == WLAN_EID_EXT_HE_CAPABILITY) {
-				elems->he_cap = (void *)&pos[1];
-				elems->he_cap_len = elen - 1;
-			} else if (pos[0] == WLAN_EID_EXT_HE_OPERATION &&
-				   elen >= sizeof(*elems->he_operation) &&
-				   elen >= ieee80211_he_oper_size(&pos[1])) {
-				elems->he_operation = (void *)&pos[1];
-			} else if (pos[0] == WLAN_EID_EXT_UORA && elen >= 1) {
-				elems->uora_element = (void *)&pos[1];
-			} else if (pos[0] ==
-				   WLAN_EID_EXT_MAX_CHANNEL_SWITCH_TIME &&
-				   elen == 4) {
-				elems->max_channel_switch_time = pos + 1;
-			} else if (pos[0] ==
-				   WLAN_EID_EXT_MULTIPLE_BSSID_CONFIGURATION &&
-				   elen == 3) {
-				elems->mbssid_config_ie = (void *)&pos[1];
-			} else if (pos[0] == WLAN_EID_EXT_HE_SPR &&
-				   elen >= sizeof(*elems->he_spr) &&
-				   elen >= ieee80211_he_spr_size(&pos[1])) {
-				elems->he_spr = (void *)&pos[1];
-			}
+			ieee80211_parse_extension_element(calc_crc ?
+								&crc : NULL,
+							  elem, elems);
 			break;
 		default:
 			break;
-- 
2.24.1


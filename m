Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8413AC979
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 13:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhFRLMH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 07:12:07 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48296 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229848AbhFRLMG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 07:12:06 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBx3-001YXx-5h; Fri, 18 Jun 2021 13:42:18 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:45 +0300
Message-Id: <iwlwifi.20210618133832.cd101f8040a4.Iadf0e9b37b100c6c6e79c7b298cc657c2be9151a@changeid>
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
Subject: [PATCH 20/31] mac80211: handle various extensible elements correctly
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Various elements are parsed with a requirement to have an
exact size, when really we should only check that they have
the minimum size that we need. Check only that and therefore
ignore any additional data that they might carry.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/util.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 08530da5ac05..c4aff6743552 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -947,7 +947,7 @@ static void ieee80211_parse_extension_element(u32 *crc,
 
 	switch (elem->data[0]) {
 	case WLAN_EID_EXT_HE_MU_EDCA:
-		if (len == sizeof(*elems->mu_edca_param_set)) {
+		if (len >= sizeof(*elems->mu_edca_param_set)) {
 			elems->mu_edca_param_set = data;
 			if (crc)
 				*crc = crc32_be(*crc, (void *)elem,
@@ -968,7 +968,7 @@ static void ieee80211_parse_extension_element(u32 *crc,
 		}
 		break;
 	case WLAN_EID_EXT_UORA:
-		if (len == 1)
+		if (len >= 1)
 			elems->uora_element = data;
 		break;
 	case WLAN_EID_EXT_MAX_CHANNEL_SWITCH_TIME:
@@ -976,7 +976,7 @@ static void ieee80211_parse_extension_element(u32 *crc,
 			elems->max_channel_switch_time = data;
 		break;
 	case WLAN_EID_EXT_MULTIPLE_BSSID_CONFIGURATION:
-		if (len == sizeof(*elems->mbssid_config_ie))
+		if (len >= sizeof(*elems->mbssid_config_ie))
 			elems->mbssid_config_ie = data;
 		break;
 	case WLAN_EID_EXT_HE_SPR:
@@ -985,7 +985,7 @@ static void ieee80211_parse_extension_element(u32 *crc,
 			elems->he_spr = data;
 		break;
 	case WLAN_EID_EXT_HE_6GHZ_CAPA:
-		if (len == sizeof(*elems->he_6ghz_capa))
+		if (len >= sizeof(*elems->he_6ghz_capa))
 			elems->he_6ghz_capa = data;
 		break;
 	}
@@ -1074,14 +1074,14 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 
 		switch (id) {
 		case WLAN_EID_LINK_ID:
-			if (elen + 2 != sizeof(struct ieee80211_tdls_lnkie)) {
+			if (elen + 2 < sizeof(struct ieee80211_tdls_lnkie)) {
 				elem_parse_failed = true;
 				break;
 			}
 			elems->lnk_id = (void *)(pos - 2);
 			break;
 		case WLAN_EID_CHAN_SWITCH_TIMING:
-			if (elen != sizeof(struct ieee80211_ch_switch_timing)) {
+			if (elen < sizeof(struct ieee80211_ch_switch_timing)) {
 				elem_parse_failed = true;
 				break;
 			}
@@ -1244,7 +1244,7 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 			elems->sec_chan_offs = (void *)pos;
 			break;
 		case WLAN_EID_CHAN_SWITCH_PARAM:
-			if (elen !=
+			if (elen <
 			    sizeof(*elems->mesh_chansw_params_ie)) {
 				elem_parse_failed = true;
 				break;
@@ -1253,7 +1253,7 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 			break;
 		case WLAN_EID_WIDE_BW_CHANNEL_SWITCH:
 			if (!action ||
-			    elen != sizeof(*elems->wide_bw_chansw_ie)) {
+			    elen < sizeof(*elems->wide_bw_chansw_ie)) {
 				elem_parse_failed = true;
 				break;
 			}
@@ -1272,7 +1272,7 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 			ie = cfg80211_find_ie(WLAN_EID_WIDE_BW_CHANNEL_SWITCH,
 					      pos, elen);
 			if (ie) {
-				if (ie[1] == sizeof(*elems->wide_bw_chansw_ie))
+				if (ie[1] >= sizeof(*elems->wide_bw_chansw_ie))
 					elems->wide_bw_chansw_ie =
 						(void *)(ie + 2);
 				else
@@ -1316,7 +1316,7 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 			elems->cisco_dtpc_elem = pos;
 			break;
 		case WLAN_EID_ADDBA_EXT:
-			if (elen != sizeof(struct ieee80211_addba_ext_ie)) {
+			if (elen < sizeof(struct ieee80211_addba_ext_ie)) {
 				elem_parse_failed = true;
 				break;
 			}
@@ -1342,7 +1342,7 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 							  elem, elems);
 			break;
 		case WLAN_EID_S1G_CAPABILITIES:
-			if (elen == sizeof(*elems->s1g_capab))
+			if (elen >= sizeof(*elems->s1g_capab))
 				elems->s1g_capab = (void *)pos;
 			else
 				elem_parse_failed = true;
-- 
2.32.0


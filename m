Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7D1114EBBB
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 12:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgAaLaX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 06:30:23 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55946 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728268AbgAaLaX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 06:30:23 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixUEn-0002GC-94; Fri, 31 Jan 2020 13:13:25 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 13:12:57 +0200
Message-Id: <20200131111300.891737-21-luca@coelho.fi>
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
Subject: [PATCH 20/23] mac80211: parse also the RSNXE IE
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

Parse also the RSN Extension IE when parsing the rest of the IEs.
It will be used in a later patch.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/linux/ieee80211.h  | 8 ++++++++
 net/mac80211/ieee80211_i.h | 2 ++
 net/mac80211/util.c        | 7 ++++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 1c4409b4c012..9e6decee24be 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2532,6 +2532,7 @@ enum ieee80211_eid {
 	WLAN_EID_FILS_INDICATION = 240,
 	WLAN_EID_DILS = 241,
 	WLAN_EID_FRAGMENT = 242,
+	WLAN_EID_RSNX = 244,
 	WLAN_EID_EXTENSION = 255
 };
 
@@ -3421,4 +3422,11 @@ static inline bool for_each_element_completed(const struct element *element,
 	return (const u8 *)element == (const u8 *)data + datalen;
 }
 
+/**
+ * RSNX Capabilities:
+ * bits 0-3: Field length (n-1)
+ */
+#define WLAN_RSNX_CAPA_PROTECTED_TWT BIT(4)
+#define WLAN_RSNX_CAPA_SAE_H2E BIT(5)
+
 #endif /* LINUX_IEEE80211_H */
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 7074af92b536..8a49d78ad7c9 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1472,6 +1472,7 @@ struct ieee802_11_elems {
 	const struct ieee80211_tim_ie *tim;
 	const u8 *challenge;
 	const u8 *rsn;
+	const u8 *rsnx;
 	const u8 *erp_info;
 	const u8 *ext_supp_rates;
 	const u8 *wmm_info;
@@ -1519,6 +1520,7 @@ struct ieee802_11_elems {
 	u8 tim_len;
 	u8 challenge_len;
 	u8 rsn_len;
+	u8 rsnx_len;
 	u8 ext_supp_rates_len;
 	u8 wmm_info_len;
 	u8 wmm_param_len;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 72039c8dbc38..7ddf0508779f 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -6,7 +6,7 @@
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2019 Intel Corporation
+ * Copyright (C) 2018-2020 Intel Corporation
  *
  * utilities for mac80211
  */
@@ -994,6 +994,7 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 		case WLAN_EID_CHAN_SWITCH_TIMING:
 		case WLAN_EID_LINK_ID:
 		case WLAN_EID_BSS_MAX_IDLE_PERIOD:
+		case WLAN_EID_RSNX:
 		/*
 		 * not listing WLAN_EID_CHANNEL_SWITCH_WRAPPER -- it seems possible
 		 * that if the content gets bigger it might be needed more than once
@@ -1264,6 +1265,10 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 			if (elen >= sizeof(*elems->max_idle_period_ie))
 				elems->max_idle_period_ie = (void *)pos;
 			break;
+		case WLAN_EID_RSNX:
+			elems->rsnx = pos;
+			elems->rsnx_len = elen;
+			break;
 		case WLAN_EID_EXTENSION:
 			ieee80211_parse_extension_element(calc_crc ?
 								&crc : NULL,
-- 
2.24.1


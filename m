Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F4A4A6D50
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Feb 2022 09:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245246AbiBBIuG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Feb 2022 03:50:06 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37934 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245236AbiBBIuF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Feb 2022 03:50:05 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFBL0-0004v8-Uc;
        Wed, 02 Feb 2022 10:50:03 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Wed,  2 Feb 2022 10:49:39 +0200
Message-Id: <iwlwifi.20220202104617.6a1d52213019.I92d82e7251cf712faa43fd09db3142327a3bce3d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202084947.370289-1-luca@coelho.fi>
References: <20220202084947.370289-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 06/14] cfg80211: fix -Wcast-qual warnings
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When enabling -Wcast-qual e.g. via W=3, we get a lot of
warnings from this file, whenever it's included. Since
the fixes are simple, just do that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/cfg80211.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d19e48f9fdc6..f6db085ff3df 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2604,7 +2604,7 @@ const struct element *ieee80211_bss_get_elem(struct cfg80211_bss *bss, u8 id);
  */
 static inline const u8 *ieee80211_bss_get_ie(struct cfg80211_bss *bss, u8 id)
 {
-	return (void *)ieee80211_bss_get_elem(bss, id);
+	return (const void *)ieee80211_bss_get_elem(bss, id);
 }
 
 
@@ -5970,9 +5970,9 @@ cfg80211_find_ie_match(u8 eid, const u8 *ies, unsigned int len,
 		    (!match_len && match_offset)))
 		return NULL;
 
-	return (void *)cfg80211_find_elem_match(eid, ies, len,
-						match, match_len,
-						match_offset ?
+	return (const void *)cfg80211_find_elem_match(eid, ies, len,
+						      match, match_len,
+						      match_offset ?
 							match_offset - 2 : 0);
 }
 
@@ -6099,7 +6099,7 @@ static inline const u8 *
 cfg80211_find_vendor_ie(unsigned int oui, int oui_type,
 			const u8 *ies, unsigned int len)
 {
-	return (void *)cfg80211_find_vendor_elem(oui, oui_type, ies, len);
+	return (const void *)cfg80211_find_vendor_elem(oui, oui_type, ies, len);
 }
 
 /**
-- 
2.34.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573284A6D51
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Feb 2022 09:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245230AbiBBIuE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Feb 2022 03:50:04 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37932 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245225AbiBBIuE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Feb 2022 03:50:04 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFBL0-0004v8-4l;
        Wed, 02 Feb 2022 10:50:03 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Wed,  2 Feb 2022 10:49:38 +0200
Message-Id: <iwlwifi.20220202104617.79ec4a4bab29.I8177a0c79d656c552e22c88931d8da06f2977896@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202084947.370289-1-luca@coelho.fi>
References: <20220202084947.370289-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 05/14] ieee80211: fix -Wcast-qual warnings
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
 include/linux/ieee80211.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 559b6c644938..60ee7b3f58e7 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2427,7 +2427,7 @@ struct ieee80211_tx_pwr_env {
 static inline u8
 ieee80211_he_oper_size(const u8 *he_oper_ie)
 {
-	struct ieee80211_he_operation *he_oper = (void *)he_oper_ie;
+	const struct ieee80211_he_operation *he_oper = (const void *)he_oper_ie;
 	u8 oper_len = sizeof(struct ieee80211_he_operation);
 	u32 he_oper_params;
 
@@ -2460,7 +2460,7 @@ ieee80211_he_oper_size(const u8 *he_oper_ie)
 static inline const struct ieee80211_he_6ghz_oper *
 ieee80211_he_6ghz_oper(const struct ieee80211_he_operation *he_oper)
 {
-	const u8 *ret = (void *)&he_oper->optional;
+	const u8 *ret = (const void *)&he_oper->optional;
 	u32 he_oper_params;
 
 	if (!he_oper)
@@ -2475,7 +2475,7 @@ ieee80211_he_6ghz_oper(const struct ieee80211_he_operation *he_oper)
 	if (he_oper_params & IEEE80211_HE_OPERATION_CO_HOSTED_BSS)
 		ret++;
 
-	return (void *)ret;
+	return (const void *)ret;
 }
 
 /* HE Spatial Reuse defines */
@@ -2496,7 +2496,7 @@ ieee80211_he_6ghz_oper(const struct ieee80211_he_operation *he_oper)
 static inline u8
 ieee80211_he_spr_size(const u8 *he_spr_ie)
 {
-	struct ieee80211_he_spr *he_spr = (void *)he_spr_ie;
+	const struct ieee80211_he_spr *he_spr = (const void *)he_spr_ie;
 	u8 spr_len = sizeof(struct ieee80211_he_spr);
 	u8 he_spr_params;
 
-- 
2.34.1


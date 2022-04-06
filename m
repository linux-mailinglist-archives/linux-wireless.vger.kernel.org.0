Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971DB4F63E7
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 17:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbiDFPjM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 11:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbiDFPih (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 11:38:37 -0400
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AB4CA6F1
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 05:53:24 -0700 (PDT)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nc4Tf-000pov-TN;
        Wed, 06 Apr 2022 15:09:36 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net, kvalo@kernel.org
Cc:     luca@coelho.fi, gregory.greenman@intel.com,
        linux-wireless@vger.kernel.org
Date:   Wed,  6 Apr 2022 15:09:22 +0300
Message-Id: <iwlwifi.20220406145756.64f5db8e16b8.I7383765c26f894a7a156a41255bfb9e58e7eaecb@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406120924.979792-1-luca@coelho.fi>
References: <20220406120924.979792-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 5/7] ieee80211: add helper functions for detecting TM/FTM frames
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/linux/ieee80211.h | 54 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 75d40acb60c1..313aabb2d511 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1301,6 +1301,15 @@ struct ieee80211_mgmt {
 					u8 action_code;
 					u8 variable[];
 				} __packed s1g;
+				struct {
+					u8 action_code;
+					u8 dialog_token;
+					u8 follow_up;
+					u32 tod;
+					u32 toa;
+					u8 max_tod_error;
+					u8 max_toa_error;
+				} __packed wnm_timing_msr;
 			} u;
 		} __packed action;
 	} u;
@@ -3464,6 +3473,17 @@ enum ieee80211_mesh_actioncode {
 	WLAN_MESH_ACTION_TBTT_ADJUSTMENT_RESPONSE,
 };
 
+/* Unprotected WNM action codes */
+enum ieee80211_unprotected_wnm_actioncode {
+	WLAN_UNPROTECTED_WNM_ACTION_TIM = 0,
+	WLAN_UNPROTECTED_WNM_ACTION_TIMING_MEASUREMENT_RESPONSE = 1,
+};
+
+/* Public action codes */
+enum ieee80211_public_actioncode {
+	WLAN_PUBLIC_ACTION_FTM_RESPONSE = 33,
+};
+
 /* Security key length */
 enum ieee80211_key_len {
 	WLAN_KEY_LEN_WEP40 = 5,
@@ -4252,6 +4272,40 @@ static inline bool ieee80211_action_contains_tpc(struct sk_buff *skb)
 	return true;
 }
 
+static inline bool ieee80211_is_timing_measurement(struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (void *)skb->data;
+
+	if (!ieee80211_is_action(mgmt->frame_control))
+		return false;
+
+	if (skb->len < IEEE80211_MIN_ACTION_SIZE)
+		return false;
+
+	if (mgmt->u.action.category == WLAN_CATEGORY_WNM_UNPROTECTED &&
+	    mgmt->u.action.u.wnm_timing_msr.action_code ==
+		WLAN_UNPROTECTED_WNM_ACTION_TIMING_MEASUREMENT_RESPONSE &&
+	    skb->len >= offsetofend(typeof(*mgmt), u.action.u.wnm_timing_msr))
+		return true;
+
+	return false;
+}
+
+static inline bool ieee80211_is_ftm(struct sk_buff *skb)
+{
+	struct ieee80211_mgmt *mgmt = (void *)skb->data;
+
+	if (!ieee80211_is_public_action((void *)mgmt, skb->len))
+		return false;
+
+	if (mgmt->u.action.u.ftm.action_code ==
+		WLAN_PUBLIC_ACTION_FTM_RESPONSE &&
+	    skb->len >= offsetofend(typeof(*mgmt), u.action.u.ftm))
+		return true;
+
+	return false;
+}
+
 struct element {
 	u8 id;
 	u8 datalen;
-- 
2.35.1


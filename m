Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FC46D2354
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 16:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjCaO7b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 10:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjCaO7U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 10:59:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858751C1F9
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 07:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=+7tvm49NcOHKGCqItby6M5kGI4Dpp1Ur5CUEEE/FNn0=; t=1680274754; x=1681484354; 
        b=XEDoZUKRv8wITQy9IZf+fRG0zmewfnXWlC5pNyTbpA64zpzGR7EQZSy1KDuSLDYVbvG6NBXASxY
        cRL83yx+P7kWFioMkzM0bwkYDcQrvO3ut9/rhOrMxRscreAYDEO/XeEIV10dG20SOH8vF4UsXYigq
        7tCXKHfebzOsWtJ3oWUjFrJK5bT8iWx4Fda87s6nWIJGsEwN8I/S4UYKZ7FkVrez/7o0sJyO6eD3+
        T3jbXcBQTO6DOMtL3Cvm7fIJMgtS5jCX+s0ERSU43Zg0LsVdpTEkvTqtQ0LcsLEu8AUWcDY/4StX/
        bFFiqu7LF9aGRUepQ54JtFcX+M15yI4NiW9g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1piGDf-002ICn-1s;
        Fri, 31 Mar 2023 16:59:11 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] wifi: ieee80211: clean up public action codes
Date:   Fri, 31 Mar 2023 16:59:07 +0200
Message-Id: <20230331160543.a831d2a29cbb.I75620751b3752528d0e06526b2e2a5fe2d731070@changeid>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

WLAN_PUBLIC_ACTION_FTM_RESPONSE is duplicated with
WLAN_PUB_ACTION_FTM, but that might better be called
WLAN_PUB_ACTION_FTM_RESPONSE; clean up here.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 2463bdd2a382..0583b2b0ce1f 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -9,7 +9,7 @@
  * Copyright (c) 2006, Michael Wu <flamingice@sourmilk.net>
  * Copyright (c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (c) 2018 - 2022 Intel Corporation
+ * Copyright (c) 2018 - 2023 Intel Corporation
  */
 
 #ifndef LINUX_IEEE80211_H
@@ -3557,11 +3557,6 @@ enum ieee80211_unprotected_wnm_actioncode {
 	WLAN_UNPROTECTED_WNM_ACTION_TIMING_MEASUREMENT_RESPONSE = 1,
 };
 
-/* Public action codes */
-enum ieee80211_public_actioncode {
-	WLAN_PUBLIC_ACTION_FTM_RESPONSE = 33,
-};
-
 /* Security key length */
 enum ieee80211_key_len {
 	WLAN_KEY_LEN_WEP40 = 5,
@@ -3653,7 +3648,7 @@ enum ieee80211_pub_actioncode {
 	WLAN_PUB_ACTION_NETWORK_CHANNEL_CONTROL = 30,
 	WLAN_PUB_ACTION_WHITE_SPACE_MAP_ANN = 31,
 	WLAN_PUB_ACTION_FTM_REQUEST = 32,
-	WLAN_PUB_ACTION_FTM = 33,
+	WLAN_PUB_ACTION_FTM_RESPONSE = 33,
 	WLAN_PUB_ACTION_FILS_DISCOVERY = 34,
 };
 
@@ -4383,7 +4378,7 @@ static inline bool ieee80211_is_ftm(struct sk_buff *skb)
 		return false;
 
 	if (mgmt->u.action.u.ftm.action_code ==
-		WLAN_PUBLIC_ACTION_FTM_RESPONSE &&
+		WLAN_PUB_ACTION_FTM_RESPONSE &&
 	    skb->len >= offsetofend(typeof(*mgmt), u.action.u.ftm))
 		return true;
 
-- 
2.39.2


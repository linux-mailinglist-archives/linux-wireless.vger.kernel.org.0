Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A355AC61E
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Sep 2022 21:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbiIDT3a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Sep 2022 15:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbiIDT3Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Sep 2022 15:29:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2102A9
        for <linux-wireless@vger.kernel.org>; Sun,  4 Sep 2022 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=286l/mBXFdy7JvDZ6GJznj7ef9gXPpBcfEHSW032al8=;
        t=1662319761; x=1663529361; b=XGOHEo6OL+hdhT2nYhTEGvxIBm+9vg7ZxGqeU6l7RrzvSVp
        pBB6HD9rIiC3+WH6RSXpgO0qH7ipLe9xlxQwNYYOS2dx/SksItAO5lpi4rqUBzuCcoflj0qWHZRMs
        LcDZAKQxPMF3WYh62K02Zm0BDicwRsSnSXxgQoKxsJBoEphk3y7ut7pi+0K8ZBLnzWGhp2QdHc3ox
        Q66iDAjIOBJlvFHOXNVgDG3YE7XeDHtYof8V+kyPMEfxYuWhY7HTAGtIW1VVMMMmtl9pI8Y6QCYm7
        QdEBLzkJ+CsCF8KrVr8WPXwnrfLleP1qckmUmKHry81G1bLjRvS/TG7Ll63C4+dA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oUvIz-007pTZ-1G;
        Sun, 04 Sep 2022 21:29:17 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/12] wifi: ipw2x00: fix array of flexible structures warnings
Date:   Sun,  4 Sep 2022 21:29:02 +0200
Message-Id: <20220904212910.645346411660.I471e8fadce54ea262920828f25b8e84545bcd07e@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
References: <20220904212910.8169e8c9090c.I0357e80cc86be2d4ac6205d1f53568444dcf7c9b@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

There are a number of these here, fix them by using
appropriate casts. No binary changes.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/ipw2x00/libipw.h    | 13 ++++++-------
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c | 10 +++++-----
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/libipw.h b/drivers/net/wireless/intel/ipw2x00/libipw.h
index 7964ef7d15f0..bec7bc273748 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw.h
+++ b/drivers/net/wireless/intel/ipw2x00/libipw.h
@@ -405,7 +405,7 @@ struct libipw_auth {
 	__le16 transaction;
 	__le16 status;
 	/* challenge */
-	struct libipw_info_element info_element[];
+	u8 variable[];
 } __packed;
 
 struct libipw_channel_switch {
@@ -423,7 +423,6 @@ struct libipw_action {
 	union {
 		struct libipw_action_exchange {
 			u8 token;
-			struct libipw_info_element info_element[0];
 		} exchange;
 		struct libipw_channel_switch channel_switch;
 
@@ -441,7 +440,7 @@ struct libipw_disassoc {
 struct libipw_probe_request {
 	struct libipw_hdr_3addr header;
 	/* SSID, supported rates */
-	struct libipw_info_element info_element[];
+	u8 variable[];
 } __packed;
 
 struct libipw_probe_response {
@@ -451,7 +450,7 @@ struct libipw_probe_response {
 	__le16 capability;
 	/* SSID, supported rates, FH params, DS params,
 	 * CF params, IBSS params, TIM (if beacon), RSN */
-	struct libipw_info_element info_element[];
+	u8 variable[];
 } __packed;
 
 /* Alias beacon for probe_response */
@@ -462,7 +461,7 @@ struct libipw_assoc_request {
 	__le16 capability;
 	__le16 listen_interval;
 	/* SSID, supported rates, RSN */
-	struct libipw_info_element info_element[];
+	u8 variable[];
 } __packed;
 
 struct libipw_reassoc_request {
@@ -470,7 +469,7 @@ struct libipw_reassoc_request {
 	__le16 capability;
 	__le16 listen_interval;
 	u8 current_ap[ETH_ALEN];
-	struct libipw_info_element info_element[];
+	u8 variable[];
 } __packed;
 
 struct libipw_assoc_response {
@@ -479,7 +478,7 @@ struct libipw_assoc_response {
 	__le16 status;
 	__le16 aid;
 	/* supported rates */
-	struct libipw_info_element info_element[];
+	u8 variable[];
 } __packed;
 
 struct libipw_txb {
diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
index 7a684b76f39b..48d6870bbf4e 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
@@ -1329,8 +1329,8 @@ static int libipw_handle_assoc_resp(struct libipw_device *ieee, struct libipw_as
 	network->wpa_ie_len = 0;
 	network->rsn_ie_len = 0;
 
-	if (libipw_parse_info_param
-	    (frame->info_element, stats->len - sizeof(*frame), network))
+	if (libipw_parse_info_param((void *)frame->variable,
+				    stats->len - sizeof(*frame), network))
 		return 1;
 
 	network->mode = 0;
@@ -1389,8 +1389,8 @@ static int libipw_network_init(struct libipw_device *ieee, struct libipw_probe_r
 	network->wpa_ie_len = 0;
 	network->rsn_ie_len = 0;
 
-	if (libipw_parse_info_param
-	    (beacon->info_element, stats->len - sizeof(*beacon), network))
+	if (libipw_parse_info_param((void *)beacon->variable,
+				    stats->len - sizeof(*beacon), network))
 		return 1;
 
 	network->mode = 0;
@@ -1510,7 +1510,7 @@ static void libipw_process_probe_response(struct libipw_device
 	struct libipw_network *target;
 	struct libipw_network *oldest = NULL;
 #ifdef CONFIG_LIBIPW_DEBUG
-	struct libipw_info_element *info_element = beacon->info_element;
+	struct libipw_info_element *info_element = (void *)beacon->variable;
 #endif
 	unsigned long flags;
 
-- 
2.37.2


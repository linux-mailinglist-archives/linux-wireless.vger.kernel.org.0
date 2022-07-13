Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376E2573A48
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 17:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbiGMPey (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 11:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236951AbiGMPeo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3130841D3A
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=hfIkoZFbhsb8c49thvM9DtEIbRl0dhXgdw3pdwdyRcQ=;
        t=1657726483; x=1658936083; b=nF8EmrPFRRrepJranncumgzdAVNH+nosUdmZTVpnmrYMrv6
        RfWMQmY5oW/sY2Xnt/p3awIg2FUWYHWBChLNx4zFCRgL3kY+wgTK+iHFjpGkOcXVVP6iQGcv1hq1b
        Zb2CBdHKZEMi3F6+2CB7I1e2NihioU19gPg5rtSHNGGQNgn+qjW9jMUlErSjPZKuDY1o6NbKhuxnT
        2jXzaKdiJgitdZVwVw7kR8z9zr75M9+SKwUE57DE6/uYYRVcJ7fdK1hm4WKypphwCP6xlFKesOdIS
        tRFp26CzW+M5n2d9w5L0DJCDe7OCdLBhippCV4iLD7nAC4N8fhCI1ZdD5FOXGDnQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBeNt-00EnaA-KZ;
        Wed, 13 Jul 2022 17:34:41 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 17/21] wifi: mac80211: mlme: remove address arg to ieee80211_mark_sta_auth()
Date:   Wed, 13 Jul 2022 17:34:29 +0200
Message-Id: <20220713173301.525ca9d43170.Idfca3a6359d1f0d71c7963e5e3fb130487d0296b@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713153433.279227-1-johannes@sipsolutions.net>
References: <20220713153433.279227-1-johannes@sipsolutions.net>
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

There's no need to pass the address, we can look at the auth_data
inside the function rather than outside.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 873f7f6e03ce..62bb5fec01c9 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3166,10 +3166,10 @@ static void ieee80211_auth_challenge(struct ieee80211_sub_if_data *sdata,
 			    auth_data->key_idx, tx_flags);
 }
 
-static bool ieee80211_mark_sta_auth(struct ieee80211_sub_if_data *sdata,
-				    const u8 *ap_addr)
+static bool ieee80211_mark_sta_auth(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
+	const u8 *ap_addr = ifmgd->auth_data->bss->bssid;
 	struct sta_info *sta;
 	bool result = true;
 
@@ -3296,7 +3296,7 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 	if (ifmgd->auth_data->algorithm != WLAN_AUTH_SAE ||
 	    (auth_transaction == 2 &&
 	     ifmgd->auth_data->expected_transaction == 2)) {
-		if (!ieee80211_mark_sta_auth(sdata, bssid))
+		if (!ieee80211_mark_sta_auth(sdata))
 			return; /* ignore frame -- wait for timeout */
 	} else if (ifmgd->auth_data->algorithm == WLAN_AUTH_SAE &&
 		   auth_transaction == 2) {
@@ -6098,7 +6098,7 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	 */
 	if (cont_auth && req->auth_type == NL80211_AUTHTYPE_SAE &&
 	    auth_data->peer_confirmed && auth_data->sae_trans == 2)
-		ieee80211_mark_sta_auth(sdata, req->bss->bssid);
+		ieee80211_mark_sta_auth(sdata);
 
 	if (ifmgd->associated) {
 		u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
-- 
2.36.1


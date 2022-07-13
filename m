Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FD257333C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiGMJp5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiGMJpS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:18 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B737FBFACF
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=iMfA0Io3lBcxcqNeKRPwe9pPJ0eho/1FPAaJF0wDRaI=;
        t=1657705517; x=1658915117; b=og8uZqwJlxGkhl0I0Ycy5nZgbZG59EbP462/ZeQwoZxPUPa
        A5Dt9m4YsHefjQY+AmDpoEipkCVFOPdpPMj0WxzJh9fJe9LQ4A5Y5zU3u8g/lphGq8XlpT02ouVbb
        cjanfk6xw8nFHbZHwqUO4T8tR117CE/5VOJNW/BdIkOyntluPnQ26pH56GVyySAOciHGqhwSnSlOn
        YfYtEcGByhQH+G8/DfQTmaE4mki2YtVG6pTLwoUPsBBvG72O7KhXIGLCSanZ7o/GB2TAXkuk0VfdS
        nNiqtS3T6hlFdolObXCJybLpKm9JSfzpo7HmXhs0rDFKdzzh1tsZmA6pCVfkRHRA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvj-00EgvB-PT;
        Wed, 13 Jul 2022 11:45:15 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 36/76] wifi: mac80211: mlme: remove sta argument from ieee80211_config_bw
Date:   Wed, 13 Jul 2022 11:44:22 +0200
Message-Id: <20220713114425.8c3281ff8db1.I7e89503c562a13bc927e52a18a46d73c325c0ac0@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
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

The argument is unused except for NULL checking, but we already
do that anyway, so it's not needed. Remove the argument.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index edd7f74f1ef3..fcd964e634d5 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -405,7 +405,6 @@ ieee80211_determine_chantype(struct ieee80211_link_data *link,
 }
 
 static int ieee80211_config_bw(struct ieee80211_link_data *link,
-			       struct sta_info *sta,
 			       const struct ieee80211_ht_cap *ht_cap,
 			       const struct ieee80211_vht_cap *vht_cap,
 			       const struct ieee80211_ht_operation *ht_oper,
@@ -449,9 +448,6 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 					 ieee80211_vif_type_p2p(&sdata->vif)))
 		eht_oper = NULL;
 
-	if (WARN_ON_ONCE(!sta))
-		return -EINVAL;
-
 	/*
 	 * if bss configuration changed store the new one -
 	 * this may be applicable even if channel is identical
@@ -4438,7 +4434,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 
 	changed |= ieee80211_recalc_twt_req(link, sta, elems);
 
-	if (ieee80211_config_bw(link, sta, elems->ht_cap_elem,
+	if (ieee80211_config_bw(link, elems->ht_cap_elem,
 				elems->vht_cap_elem, elems->ht_operation,
 				elems->vht_operation, elems->he_operation,
 				elems->eht_operation,
-- 
2.36.1


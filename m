Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C965539E83
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jun 2022 09:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350315AbiFAHkI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jun 2022 03:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344265AbiFAHkF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jun 2022 03:40:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE79B941A8
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jun 2022 00:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=hk43RedASXEo/UF5VvUsPRNg+1WdduTV3aJ3+1y/694=;
        t=1654069204; x=1655278804; b=crd5/WWXGku8MqHPW/1Rqqv/pvU8xfZ+r9kvIP5UsoTWbTP
        qHX+1UzG3uo6RXdRBc5xReAYU/iSunn4/1JIOqGDR9RZf4jig8R5ksBeEX9KetVVc5/HizfZwgIRz
        55GdgdSVRKrA+TxhpMFuE0MLGTVeEk9aBbc4vVllm8BgSHGDNwqQuHGTNcfwLQ8fZPJfiyaMvqVUK
        7IKlw5HTrnC5mvorsBczekPmT72oORbwER/EscojItX6CxycO6Vbm9TvLL9YxwpM2T4a63VIViG8C
        hpAqYLJpPxEn53Pboy3kXMptdk3xDemTDIRm4uSp6vMQC6FmnmdLdj/tYoX1N08A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nwIxV-00AJPK-V0;
        Wed, 01 Jun 2022 09:40:02 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/15] mac80211: pass link ID where already present
Date:   Wed,  1 Jun 2022 09:39:46 +0200
Message-Id: <20220601093922.0b5932ea2115.Ie1343ee1963ca51cf4e8905522fd1c44278c7617@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601073958.8345-1-johannes@sipsolutions.net>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
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

In a few cases we already have the link ID in the APIs,
pass it already even if it cannot be non-zero yet.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ffd26db89f33..b9a03548c89a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1338,7 +1338,7 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 		err |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
-	ieee80211_link_info_change_notify(sdata, 0, err);
+	ieee80211_link_info_change_notify(sdata, params->link_id, err);
 	return 0;
 }
 
@@ -1419,7 +1419,8 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	sdata->beacon_rate_set = false;
 	sdata->vif.cfg.ssid_len = 0;
 	clear_bit(SDATA_STATE_OFFCHANNEL_BEACON_STOPPED, &sdata->state);
-	ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_BEACON_ENABLED);
+	ieee80211_link_info_change_notify(sdata, link_id,
+					  BSS_CHANGED_BEACON_ENABLED);
 
 	if (sdata->wdev.cac_started) {
 		chandef = sdata->vif.bss_conf.chandef;
@@ -3985,7 +3986,7 @@ static int ieee80211_set_ap_chanwidth(struct wiphy *wiphy,
 
 	ret = ieee80211_vif_change_bandwidth(sdata, chandef, &changed);
 	if (ret == 0)
-		ieee80211_link_info_change_notify(sdata, 0, changed);
+		ieee80211_link_info_change_notify(sdata, link_id, changed);
 
 	return ret;
 }
-- 
2.36.1


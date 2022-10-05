Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806DE5F54DF
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiJENBR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiJENA5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D451DF06
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8/1aZphbTXlzedC3VXig31FnYAQaOXU4xM4QEJnbHtY=;
        t=1664974855; x=1666184455; b=VDf/VfG/GtDeQ0ehnvDXisDs6dji/rxDBiAQvIP0myCKf5i
        P5pmWSdzYKcw0IDQLYAU1S5wYLAd6qud4OhdyRGOOVIei1bT1vwsIkzwwFjXOo5uTPXGFRI5V7foT
        s56/GrTCop0HZmrtiLSpsyeta1m95CBvOURcs4C0N4tORDH2cB5zg/JX9dp0Mwgse64dvUJheeu6O
        IJpHOWBqsG5q+OHVN9a3v850rwuB/CNDLi3s7b0QYFieS4vfXZpQZR0WZuiF+NH4egcTXxS4JT68c
        FWmB5e4IGhEHWI5XFWGkAAWuxTWlJQUE+NB9dYh8rAhozY1xrrxSthzpRM7IHVMQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og417-00G2RL-1m;
        Wed, 05 Oct 2022 15:00:53 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/28] wifi: mac80211: transmit AddBA with MLD address
Date:   Wed,  5 Oct 2022 15:00:32 +0200
Message-Id: <20221005145226.5b764ca03b64.I1e20899eb7858a5927209bd39a7e56daee69ac2e@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005130048.217341-1-johannes@sipsolutions.net>
References: <20221005130048.217341-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This management frame is intended for the MLD so we
treat it in mac80211 as MLD addressed as well, and
should therefore use the MLD address of the AP for
the BSSID field in the frame, address translation
applies.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/agg-tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 07c892aa8c73..9c40f8d3bce8 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -82,7 +82,7 @@ static void ieee80211_send_addba_request(struct ieee80211_sub_if_data *sdata,
 	    sdata->vif.type == NL80211_IFTYPE_MESH_POINT)
 		memcpy(mgmt->bssid, sdata->vif.addr, ETH_ALEN);
 	else if (sdata->vif.type == NL80211_IFTYPE_STATION)
-		memcpy(mgmt->bssid, sdata->deflink.u.mgd.bssid, ETH_ALEN);
+		memcpy(mgmt->bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
 	else if (sdata->vif.type == NL80211_IFTYPE_ADHOC)
 		memcpy(mgmt->bssid, sdata->u.ibss.bssid, ETH_ALEN);
 
-- 
2.37.3


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DC35F54E4
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJENBW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiJENA6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76BB1EEC4
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=/fh6SckArTpaG4pii7wCsWBmsY1sWRhhf5oDakDk13s=;
        t=1664974856; x=1666184456; b=yZnDKpxnirieg02tw04gyCupEgeSX9fV95Mgbmz02t0lSUx
        XTQ/cL33vpVzrbtZwzDBgXU+ECwQtS8Pv1xW0xAcRU6qUSGKelNMOXRHfGFKRQpQuOxSWPFJdWNd4
        4YVgLi1HWLnxVo+hJKEwlAnBoTqXLWkr1N5oAH/mrP9ax4nCyuoK5Cd16DxuSAuuxaMVVfa67FI1Q
        pNNj3uY/OTysQooL1UtZWb7zZG4RiYgaV+ChEf66SsBCU2kRse+aNp6a+10JUklEzlSqDceQ2h9Tl
        qTck6LAimGS+CyhPhClJgGCPWijF+n90/EQsL1/w2hXjQ1xbUvbUiAInm58cD52w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og418-00G2RL-2j;
        Wed, 05 Oct 2022 15:00:54 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 17/28] wifi: mac80211: fix AddBA response addressing
Date:   Wed,  5 Oct 2022 15:00:37 +0200
Message-Id: <20221005145226.83b788b596f2.Id8ee3b435d10b656d4b23bc16419432e5db03049@changeid>
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

Since this frame is addressed from/to an MLD, it should be
built with the correct AP MLD address (in station mode) to
be encrypted properly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/agg-rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 9414d3bbd65f..eaef88a603e5 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -242,7 +242,7 @@ static void ieee80211_send_addba_resp(struct sta_info *sta, u8 *da, u16 tid,
 	    sdata->vif.type == NL80211_IFTYPE_MESH_POINT)
 		memcpy(mgmt->bssid, sdata->vif.addr, ETH_ALEN);
 	else if (sdata->vif.type == NL80211_IFTYPE_STATION)
-		memcpy(mgmt->bssid, sdata->deflink.u.mgd.bssid, ETH_ALEN);
+		memcpy(mgmt->bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
 	else if (sdata->vif.type == NL80211_IFTYPE_ADHOC)
 		memcpy(mgmt->bssid, sdata->u.ibss.bssid, ETH_ALEN);
 
-- 
2.37.3


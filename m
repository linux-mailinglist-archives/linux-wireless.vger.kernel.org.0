Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17474526677
	for <lists+linux-wireless@lfdr.de>; Fri, 13 May 2022 17:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378980AbiEMPqe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 May 2022 11:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378538AbiEMPqb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 May 2022 11:46:31 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2877890D
        for <linux-wireless@vger.kernel.org>; Fri, 13 May 2022 08:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=KVL3igQkNKBiZlNHb0ywwgObE0JV9FXtyZNUOcsrbQY=;
        t=1652456789; x=1653666389; b=VZpCA28youg52JobXx7Sx3ci/UIpecV2ktKJXOymbogvYYh
        CQoA7jUA0uTWVvBN1kQRmnyBwEk4ygFgk10c7mDgoLPh0+1N5yGBPp3dX/aDYwjQhaWhxTQpy54+F
        dcHipriqLOLthTjoBuh3xXbXSWjuSg2ygAv+/c/xRT08cUis/6laXc+qIFx653UJuQbUmMPqt+264
        iqjop6ARu8G/m9LLGHiWSxic7/iHL+AJV5So03ZBxhxKrnxzvixNNQTq5T4IEcZcl8dFO9HO5C/6W
        IF5ktIqhK3hiLH9oondoxWHzLUME9mvDWjo2p7RwuFWGxLNqLIbjn0gCdswFI0+g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1npXUp-00Aeu2-Nb;
        Fri, 13 May 2022 17:46:27 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] mac80211: remove useless bssid copy
Date:   Fri, 13 May 2022 17:46:24 +0200
Message-Id: <20220513174623.0d659c04ecee.I0809095c59f04c312e6b594ccde238db34e45af6@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220513174623.a713706d6970.I43b954414c811cfcc6bc394809b31a6bb78d6d12@changeid>
References: <20220513174623.a713706d6970.I43b954414c811cfcc6bc394809b31a6bb78d6d12@changeid>
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

We don't need to copy this locally, we now only use the
variable to print before doing other things.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e2637404ccd1..d38d100b5aed 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4734,11 +4734,9 @@ void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata)
 
 	if (ifmgd->flags & IEEE80211_STA_CONNECTION_POLL &&
 	    ifmgd->associated) {
-		u8 bssid[ETH_ALEN];
+		u8 *bssid = ifmgd->bssid;
 		int max_tries;
 
-		memcpy(bssid, ifmgd->bssid, ETH_ALEN);
-
 		if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS))
 			max_tries = max_nullfunc_tries;
 		else
-- 
2.35.3


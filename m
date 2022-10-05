Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD775F54EC
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJENBg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiJENBA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:01:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06DC7858D
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=zPXv8CpRqSfC+2E07BiyKX6p+qPItrMKN0h1iuIuiXg=;
        t=1664974858; x=1666184458; b=cSSiHy1olbOJynNb+Hea0aaRjC3IQYMsm9DfN6cQ9/aMIoz
        SlSGaezFCQliaP8fAzMImHoy0LFN3EKgiTkpeNCcLc4vG4+dUhhgdmAIlVt6Z7G44+1MWoCKtNh1X
        jRMOgNrCku17nbiEU9TJ8Bli4eHfXUeD9kD/uK2QVxOFExxBEPt22MfDuGSGD9nXSduhmUTp+desr
        ehOcpzuK/6CGVGU4DGMWasocA47XcwC5QLkO326jQc3dlhId0GlgcOwjVTZO+z967W5pVz0SunGb2
        reH1yhmmCCZqCFOK/lqUpqY0GIVvwTOTBx20ejAC5pBAJ6e2vhSjcz4YbzOQrQbQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og41B-00G2RL-0O;
        Wed, 05 Oct 2022 15:00:57 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 26/28] wifi: mac80211: agg-rx: avoid band check
Date:   Wed,  5 Oct 2022 15:00:46 +0200
Message-Id: <20221005145226.f32e23c8ab35.I8453a5e212e30c8afc456a54c73cead6ba928b05@changeid>
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

If the deflink of the station is on 6 GHz, then it won't have HT.
If at the same time we're using MLO, then vif.bss_conf isn't used,
and thus vif.bss_conf.chandef.chan is NULL, causing the code to
crash.

Fix this by just checking for both HT and HE, and refusing the
aggregation session if both are not present. This might be a bit
wrong since it would accept an aggregation session from a peer
that has HE but no HT on 2.4 or 5 GHz, but such a peer shouldn't
exist in the first place, and it probably supports aggregation if
it has HE support.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/agg-rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index f8bec5ee5b44..bd41022f4894 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -297,7 +297,7 @@ void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
 	}
 
 	if (!sta->sta.deflink.ht_cap.ht_supported &&
-	    sta->sdata->vif.bss_conf.chandef.chan->band != NL80211_BAND_6GHZ) {
+	    !sta->sta.deflink.he_cap.has_he) {
 		ht_dbg(sta->sdata,
 		       "STA %pM erroneously requests BA session on tid %d w/o HT\n",
 		       sta->sta.addr, tid);
-- 
2.37.3


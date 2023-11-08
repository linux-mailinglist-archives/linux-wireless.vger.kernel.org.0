Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94827E6109
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Nov 2023 00:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjKHXax (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 18:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjKHXaw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 18:30:52 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BEE259F
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 15:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ULjNDhRCHzCMzyECCH/VPkyLwedLWPjPhvYK4wx2F28=;
        t=1699486249; x=1700695849; b=yGiABc9rBn7DgFAoFISmshBb8RZYUtcpHShkyQZs68/birS
        2l0NiSPp25YRtWIFUqAwvNXlgTx3ILhB2HvOpJG5/SS6hA8RJBKw/EbD/sQNdh4M/n6EBqPLuvLc7
        kG6nMPSvC4NuV3zGpec5qqK+1Yxonx+mPRn2a9U0pRIsAXE0GSY4Mn3X97eeejz7oy7yP0MWJCSMl
        A4QUOMVT9mptz46kuU7cwKPOg0wdK5aCj/58OMMjCUsCnZVobVnnkFhsYkwvks1cMpIPTZcrBFP2h
        O32dw9gx2HhLqAnAyrOrmzqKurGaQwDBYOdVRvQ9oQbypEhXA82/K3rQym3ALVag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r0s0U-00000000r6s-0ssk;
        Thu, 09 Nov 2023 00:30:46 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 2/2] wifi: mac80211: chan: chandef is non-NULL for reserved
Date:   Thu,  9 Nov 2023 00:30:42 +0100
Message-ID: <20231109003040.a490f0117800.I12287452f42c54baf75821e75491cf6d021af20a@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109003040.4b25d42b8b14.I60d093b2fc81ca1853925a4d0ac3a2337d5baa5b@changeid>
References: <20231109003040.4b25d42b8b14.I60d093b2fc81ca1853925a4d0ac3a2337d5baa5b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The last caller of this with a NULL argument was related to
the non-chanctx code, so we can now remove this odd logic.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 0a08dc7b7976..085ea7ce5750 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -90,11 +90,11 @@ ieee80211_chanctx_reserved_chandef(struct ieee80211_local *local,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	if (WARN_ON(!compat))
+		return NULL;
+
 	list_for_each_entry(link, &ctx->reserved_links,
 			    reserved_chanctx_list) {
-		if (!compat)
-			compat = &link->reserved_chandef;
-
 		compat = cfg80211_chandef_compatible(&link->reserved_chandef,
 						     compat);
 		if (!compat)
-- 
2.41.0


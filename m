Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BA357336B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbiGMJqe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbiGMJpf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD584F6BBF
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=yrMzir8MmVZ2ZjX5Ztuo97Rbxl1FyQu+7LN86zcsNAo=;
        t=1657705526; x=1658915126; b=K/2/1yoDlJokM3Z5njr8ME5jKS+x+UDjsluzQUyDyZsguZc
        BAp9Od57u2E6CWe0wV4sRkOffkMOOl4cv6pu0zqqNjbjg2HgSnaFgxaE+A7MSvUJhxXnMdBy8RAgj
        aADxlFlCMyfmhDt5JGCV/HL3/IqOnM9Um8walZO2TMfzaciK0P2wiJHojaKwsxFGrVJqJ/AnyEgyA
        o+ohT82ozRnMKAb2KmwSoaejowTnexv3ELsnVH3REeQAM/vYz573Ny3Xfpx7m93kn52CPgtRqdSeB
        bET1UMg2KYDp80ldsOhIg7G9tYdvDHrxsvf1C+vNDkaKAP8788eJWtfz+hF5V6Yg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvt-00EgvB-5U;
        Wed, 13 Jul 2022 11:45:25 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 58/76] wifi: mac80211: tighten locking check
Date:   Wed, 13 Jul 2022 11:44:44 +0200
Message-Id: <20220713114426.44559c362531.I6872bd8db06d1b95c654a5e197c554e6151488a8@changeid>
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

When we remove a link that doesn't have a channel context,
we don't really need the local->mtx locking. Tighten the
check here.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 92fe40539091..5ab210706123 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1991,10 +1991,11 @@ void ieee80211_link_release_channel(struct ieee80211_link_data *link)
 
 	WARN_ON(sdata->dev && netif_carrier_ok(sdata->dev));
 
-	lockdep_assert_held(&sdata->local->mtx);
-
 	mutex_lock(&sdata->local->chanctx_mtx);
-	__ieee80211_link_release_channel(link);
+	if (rcu_access_pointer(link->conf->chanctx_conf)) {
+		lockdep_assert_held(&sdata->local->mtx);
+		__ieee80211_link_release_channel(link);
+	}
 	mutex_unlock(&sdata->local->chanctx_mtx);
 }
 
-- 
2.36.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C53B573363
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbiGMJq6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbiGMJpm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E663F6B8C
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=9i0+Y6BJhdZObmwXL8pbMHrzRCCoYihLJWRJ3Sgnm1M=;
        t=1657705531; x=1658915131; b=iWW6QloMGrA42AkwXGrpj1xvH9cZAxC4HouzcZby482e7H8
        ISsWAk5hcuL8DWUuwcOZUhF5Fo3K6hqQW2spFQMGMFDT4m1kwxC0JX8VSxkzKB9Sz2QJLnBPAAiC7
        R1SnpsDEzz3ax/g5fUduZ3SlRPH6H26tajEzD+QRMnGgjSJLUqgD6NbdjI8h1qLOjaKqrqr4nzIX8
        YGmP97UDLtqrMKAPY2rM7uSSnEmpibuOcs91Mdwksw1FF8hYY+2tXFPd1yGVqFFFDP1UYmNbn/FT/
        zbAdesYuTsa7w3EaNbzMwbCqF5ZgtXRzJZm3WD8HFhrv5p/8t0xMSYDLgskKzUVw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvx-00EgvB-AA;
        Wed, 13 Jul 2022 11:45:29 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [PATCH 71/76] wifi: mac80211: don't check carrier in chanctx code
Date:   Wed, 13 Jul 2022 11:44:57 +0200
Message-Id: <20220713114426.2dbf640f068d.I4e28ba43aa4a0ec15993aa5ef0879549e8a767a0@changeid>
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

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

We check here that we don't enable TX (netif_carrier_ok())
before we actually start using some channel context, but to
our knowledge this check has never triggered, and with MLO
it's just wrong since links can be added and removed much
more dynamically than before.

Simply remove the checks, there's no really good way to do
anything that would replace them.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 5ab210706123..2e9bc285f0a5 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1800,8 +1800,6 @@ int ieee80211_link_use_channel(struct ieee80211_link_data *link,
 
 	lockdep_assert_held(&local->mtx);
 
-	WARN_ON(sdata->dev && netif_carrier_ok(sdata->dev));
-
 	mutex_lock(&local->chanctx_mtx);
 
 	ret = cfg80211_chandef_dfs_required(local->hw.wiphy,
@@ -1989,8 +1987,6 @@ void ieee80211_link_release_channel(struct ieee80211_link_data *link)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 
-	WARN_ON(sdata->dev && netif_carrier_ok(sdata->dev));
-
 	mutex_lock(&sdata->local->chanctx_mtx);
 	if (rcu_access_pointer(link->conf->chanctx_conf)) {
 		lockdep_assert_held(&sdata->local->mtx);
-- 
2.36.1


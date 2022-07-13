Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF0657333D
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbiGMJpn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbiGMJpP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5554E0279
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=PeBNybZtri/YEfvBgYuHATnDQTwZssoziBYs0uzehgc=;
        t=1657705514; x=1658915114; b=MHwN6RiHgv6X5m8ZWy2v7QdfmzQDQ45u1OszDbN3NpM/Wc8
        XLzK9zZeNKe5f/j4zT9G9lPbQ6g2PGgIiDMZlayAlzcRBBJNpOdLHCjpDJklDzx910jhgr0xvEJgU
        W1xAYTYSIRIK0XmzsAZHpUWPIxPy9maZ5ngbMwDNkdXTtkW/NwAwqFyNA2O9bBcljriDMA2Lqu8td
        VBywthGLAmEzYSW3Dt9le+vBrgKK0D1X3RvYUz45B5/pYrxq4VVwQvOs82BSQar/wt+Rl8iSVwQ2c
        cQ1Y9xwk94B2pijn4cz6AO0VwsAmB5Tb4qKBqBKPMPvhEt1CAsTB9gl3pF8aLW2A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvg-00EgvB-Lt;
        Wed, 13 Jul 2022 11:45:12 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 28/76] wifi: mac80211: expect powersave handling in driver for MLO
Date:   Wed, 13 Jul 2022 11:44:14 +0200
Message-Id: <20220713114425.e4d19d275aaf.If82f6ab725e6b755f1f821810df4050e285db3ed@changeid>
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

In MLO, expect the driver fully handles powersave handling,
including tracking whether or not a beacon was received,
the DTIM period, etc.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/main.c | 3 ++-
 net/mac80211/mlme.c | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 1258e506377e..8d5b18318b20 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -984,7 +984,8 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 			return -EINVAL;
 
 		if (WARN_ON(ieee80211_hw_check(hw, SUPPORTS_PS) &&
-			    !ieee80211_hw_check(hw, SUPPORTS_DYNAMIC_PS)))
+			    (!ieee80211_hw_check(hw, SUPPORTS_DYNAMIC_PS) ||
+			     ieee80211_hw_check(hw, PS_NULLFUNC_STACK))))
 			return -EINVAL;
 
 		if (WARN_ON(!ieee80211_hw_check(hw, MFP_CAPABLE)))
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1035d6d433b1..7b9211d16193 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1785,6 +1785,7 @@ static void ieee80211_change_ps(struct ieee80211_local *local)
 
 static bool ieee80211_powersave_allowed(struct ieee80211_sub_if_data *sdata)
 {
+	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *mgd = &sdata->u.mgd;
 	struct sta_info *sta = NULL;
 	bool authorized = false;
@@ -1801,7 +1802,8 @@ static bool ieee80211_powersave_allowed(struct ieee80211_sub_if_data *sdata)
 	if (mgd->flags & IEEE80211_STA_CONNECTION_POLL)
 		return false;
 
-	if (!sdata->deflink.u.mgd.have_beacon)
+	if (!(local->hw.wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO) &&
+	    !sdata->deflink.u.mgd.have_beacon)
 		return false;
 
 	rcu_read_lock();
-- 
2.36.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61FC78AFA4
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjH1MGZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjH1MFz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC4812A
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=wXVnY7aGNgA3Y6PmWf/XZLrBe0ID1EwhIAClkZJ2tXI=;
        t=1693224352; x=1694433952; b=VxF70tLK1r90pnyMgb0rFPWmTZFrD34/7gCiqg8JKRmfwMk
        MY+DQsuAlwtthIm19bQvomfm8SqMY/queQxO1KMYfEMJz8MqrSTyIxKF5Ctu2atBAzfdUaaXG7Cu/
        C4xqqofgYAM7T4jgAzuvEdjnhv0dRjCmy/epd69sTi5fTK+WAo6rZf38x5aoN6YvjXivR/alBd1e1
        ugAv/kXYdKJYknZ/AFfESIdMlI3msCiPFm2lIho0JFTBs++lm1VFUMuY32aw1rTAvKuuhG0bWOHo2
        aHtMU3xzuAbuGPtFtIn15XJ36ZsNbhU3vCpZOLVr586HDRHRTvwobURhUekuHhHA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qab0A-00Gjgt-0i;
        Mon, 28 Aug 2023 14:05:50 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 39/40] wifi: mac80211: set wiphy for virtual monitors
Date:   Mon, 28 Aug 2023 14:00:07 +0200
Message-ID: <20230828135928.e55a2df1ca8b.I54569d0e2936e44debeb0a79bf20c77a88d18a66@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828115927.116700-41-johannes@sipsolutions.net>
References: <20230828115927.116700-41-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Drivers might plausibly want to have this, but also the
locking assertions will need it later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index f7f58c3e8349..fc407be04ce9 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1134,6 +1134,7 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 		 wiphy_name(local->hw.wiphy));
 	sdata->wdev.iftype = NL80211_IFTYPE_MONITOR;
 	mutex_init(&sdata->wdev.mtx);
+	sdata->wdev.wiphy = local->hw.wiphy;
 
 	ieee80211_sdata_init(local, sdata);
 
-- 
2.41.0


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C83B7242FC
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 14:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237737AbjFFMuI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 08:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237710AbjFFMuF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 08:50:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C95170F
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8bDiSiBLDPQDg9RTuEdpv5Vc0A/XhtmmaO8d09+w+nQ=;
        t=1686055781; x=1687265381; b=hhdhJ47E1mAksWP8FBp8qAWbdwZWsZ3D5up2FuNDHU6Bte3
        C6SQ28Y3MaOvgX+691eoNhmGOIojn8lGerEsxQYCjoQeTgsF7MIJs5ISZyMMQPYBDzavIFDjBAzkd
        T88vzu5kMEdgEtvFeAEsBaz0pxk4hMRn4jCW/YS21vLfclQqUaXOUj7aVeMVr1/Tpr7hFYkp9uJMp
        OrEejmgp4SUQZuEbzuaDSuxcXjI4i45K+UiPzLizXAXRwiZf1KFx/mwvM02P1Yq4+/NIO6duP01KI
        RUWNaoOnqDqmTH+eLGnwk2NR2vOR9r40DpmCQgKdGcXJvhxwLrcnZ/m5TyK8IkAA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6W82-00FZDP-1D;
        Tue, 06 Jun 2023 14:49:38 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/14] wifi: cfg80211: move wowlan disable under locks
Date:   Tue,  6 Jun 2023 14:49:22 +0200
Message-Id: <20230606144753.0278a2238807.I9453f32618ba16c0e48e0fda7fd5a7019056b01e@changeid>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606124933.181107-1-johannes@sipsolutions.net>
References: <20230606124933.181107-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is a driver callback, and the driver should be able
to assume that it's called with the wiphy lock held. Move
the call up so that's true, it has no other effect since
the device is already unregistering and we cannot reach
this function through other paths.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 8215b2060136..0ae36653c49c 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1065,6 +1065,10 @@ void wiphy_unregister(struct wiphy *wiphy)
 	cfg80211_rdev_list_generation++;
 	device_del(&rdev->wiphy.dev);
 
+#ifdef CONFIG_PM
+	if (rdev->wiphy.wowlan_config && rdev->ops->set_wakeup)
+		rdev_set_wakeup(rdev, false);
+#endif
 	wiphy_unlock(&rdev->wiphy);
 	rtnl_unlock();
 
@@ -1080,10 +1084,6 @@ void wiphy_unregister(struct wiphy *wiphy)
 	flush_work(&rdev->mgmt_registrations_update_wk);
 	flush_work(&rdev->background_cac_abort_wk);
 
-#ifdef CONFIG_PM
-	if (rdev->wiphy.wowlan_config && rdev->ops->set_wakeup)
-		rdev_set_wakeup(rdev, false);
-#endif
 	cfg80211_rdev_free_wowlan(rdev);
 	cfg80211_rdev_free_coalesce(rdev);
 }
-- 
2.40.1


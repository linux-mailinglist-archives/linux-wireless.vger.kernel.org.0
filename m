Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3D9539E86
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jun 2022 09:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345110AbiFAHkO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jun 2022 03:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346505AbiFAHkH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jun 2022 03:40:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAF4986EB
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jun 2022 00:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=lojIq1zlQlZ7/qjd0G6TeOJ4z9KxMnwBQCbUjyie160=;
        t=1654069206; x=1655278806; b=iKGwARluRLpXnHkfHwibaebNUdZ47mwYOAGCfT2DvrhLh8g
        mg4YpTDoDayHs+ub6yDdEAydcZuAe/JSw7ecurcgi5hff4mKYNEAw/jEkwGrn3siapHZkZjyVRM9Q
        3dJ1jbYcLQKxChRi/KieCLSXjzGZukRdmXUZosja+JJWBxusbqpgKGQT1czoah+AeBxF0kXM6jlqF
        Ug+uXukEChDIJFphO+tj2W7X3UJIxNmzZ2VNGIxB05nY6fDU5+Lf+0Cvu+ZK08oZU0tlFdjla76n2
        /bixwFuBnilTGLUK0ioMQ3FkJIlAoIIcQUlJkpkkLH9LlnyWrBVhWeb3N0UYcejA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nwIxX-00AJPK-ET;
        Wed, 01 Jun 2022 09:40:03 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/15] mac80211: validate some driver features for MLO
Date:   Wed,  1 Jun 2022 09:39:51 +0200
Message-Id: <20220601093922.ae4718d24726.I81112aa6318e50bebba53117f8b39f255b41b28e@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601073958.8345-1-johannes@sipsolutions.net>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
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

If MLO is enabled by the driver then validate a set of
capabilities that mac80211 will initially not support
in MLO. This might change if features are implemented.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/main.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 6165b90bf0e2..c5553d68d779 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -951,6 +951,48 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		    (!local->ops->start_nan || !local->ops->stop_nan)))
 		return -EINVAL;
 
+	if (hw->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO) {
+		/*
+		 * For drivers capable of doing MLO, assume modern driver
+		 * or firmware facilities, so software doesn't have to do
+		 * as much, e.g. monitoring beacons would be hard if we
+		 * might not even know which link is active at which time.
+		 */
+		if (WARN_ON(!local->use_chanctx))
+			return -EINVAL;
+
+		if (WARN_ON(!local->ops->link_info_changed))
+			return -EINVAL;
+
+		if (WARN_ON(!ieee80211_hw_check(hw, HAS_RATE_CONTROL)))
+			return -EINVAL;
+
+		if (WARN_ON(!ieee80211_hw_check(hw, AMPDU_AGGREGATION)))
+			return -EINVAL;
+
+		if (WARN_ON(ieee80211_hw_check(hw, HOST_BROADCAST_PS_BUFFERING)))
+			return -EINVAL;
+
+		if (WARN_ON(ieee80211_hw_check(hw, SUPPORTS_PS) &&
+			    !ieee80211_hw_check(hw, SUPPORTS_DYNAMIC_PS)))
+			return -EINVAL;
+
+		if (WARN_ON(!ieee80211_hw_check(hw, MFP_CAPABLE)))
+			return -EINVAL;
+
+		if (WARN_ON(!ieee80211_hw_check(hw, CONNECTION_MONITOR)))
+			return -EINVAL;
+
+		if (WARN_ON(ieee80211_hw_check(hw, NEED_DTIM_BEFORE_ASSOC)))
+			return -EINVAL;
+
+		if (WARN_ON(ieee80211_hw_check(hw, TIMING_BEACON_ONLY)))
+			return -EINVAL;
+
+		if (WARN_ON(!ieee80211_hw_check(hw, AP_LINK_PS)))
+			return -EINVAL;
+	}
+
 #ifdef CONFIG_PM
 	if (hw->wiphy->wowlan && (!local->ops->suspend || !local->ops->resume))
 		return -EINVAL;
-- 
2.36.1


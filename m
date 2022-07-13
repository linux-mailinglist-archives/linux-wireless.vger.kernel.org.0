Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF42B573A47
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 17:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236980AbiGMPe5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 11:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236957AbiGMPeo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBC54D14D
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8R4gLuaWO4yBwmjU8j2mRUm6l1qV5IC6zelvF/k2iRA=;
        t=1657726484; x=1658936084; b=jZTKadCmfhu6Cdbw1rPw8urngRozd5HQsNzSyP7BAcA5cJT
        tTCKAEyuXRmlKEqnaXiMB42ORc8I8OY5uNpX93uhmQi4aHY0EX0W+B/5e8ZloT40oX8lLXAhLdL7W
        vCB8v1+eB3I+pDijQmTNVpBKaJ2YngnyNBLEZoV5BqmeGVLCLkQ1Prw33AXXIZKcmU83vPR6ho2Cn
        bzT6gxH9BhE8kvYvlnvys3q+1BGD1KKpMD+tusawOI5kheVTOR/piBoR99gLg2agB3ji3OMf7ONEp
        HUidFuxrVjkoqZu1oEN9vc2kBS5MNCOlB2gYwQKA6ldhvHsb9Kp/Q1YasmaauD0g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBeNu-00EnaA-Ag;
        Wed, 13 Jul 2022 17:34:42 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 20/21] wifi: cfg80211: add cfg80211_get_iftype_ext_capa()
Date:   Wed, 13 Jul 2022 17:34:32 +0200
Message-Id: <20220713173301.4046adad13f5.I49eec9ff191d8cde7e17d37f6ddca714cc02a7da@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713153433.279227-1-johannes@sipsolutions.net>
References: <20220713153433.279227-1-johannes@sipsolutions.net>
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

Add a helper function cfg80211_get_iftype_ext_capa() to
look up interface type-specific (extended) capabilities.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h |  8 ++++++++
 net/wireless/util.c    | 14 ++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c2fd971e5c4d..6324e1b15ee0 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5005,6 +5005,14 @@ struct wiphy_iftype_ext_capab {
 	u16 mld_capa_and_ops;
 };
 
+/**
+ * cfg80211_get_iftype_ext_capa - lookup interface type extended capability
+ * @wiphy: the wiphy to look up from
+ * @type: the interface type to look up
+ */
+const struct wiphy_iftype_ext_capab *
+cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
+
 /**
  * struct cfg80211_pmsr_capabilities - cfg80211 peer measurement capabilities
  * @max_peers: maximum number of peers in a single measurement
diff --git a/net/wireless/util.c b/net/wireless/util.c
index fe7956c8c6da..2c127951764a 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2490,3 +2490,17 @@ int cfg80211_remove_virtual_intf(struct cfg80211_registered_device *rdev,
 
 	return rdev_del_virtual_intf(rdev, wdev);
 }
+
+const struct wiphy_iftype_ext_capab *
+cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type)
+{
+	int i;
+
+	for (i = 0; i < wiphy->num_iftype_ext_capab; i++) {
+		if (wiphy->iftype_ext_capab[i].iftype == type)
+			return &wiphy->iftype_ext_capab[i];
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(cfg80211_get_iftype_ext_capa);
-- 
2.36.1


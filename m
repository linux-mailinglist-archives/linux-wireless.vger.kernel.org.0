Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FA1375C1B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 May 2021 22:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhEFUNG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 May 2021 16:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhEFUNF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 May 2021 16:13:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F15C061574
        for <linux-wireless@vger.kernel.org>; Thu,  6 May 2021 13:12:06 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lekLr-0058f3-JY; Thu, 06 May 2021 22:12:03 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] cfg80211: remove CFG80211_MAX_NUM_DIFFERENT_CHANNELS
Date:   Thu,  6 May 2021 22:12:00 +0200
Message-Id: <20210506221159.d1d61db1d31c.Iac4da68d54b9f1fdc18a03586bbe06aeb9515425@changeid>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We no longer need to put any limits here, hardware will and
mac80211-hwsim can do whatever it likes. The reason we had
this was some accounting code (still mentioned in the comment)
but that code was deleted in commit c781944b71f8 ("cfg80211:
Remove unused cfg80211_can_use_iftype_chan()").

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 5 -----
 include/net/cfg80211.h                | 2 --
 net/wireless/core.c                   | 8 --------
 3 files changed, 15 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index fa7d4c20dc13..8fe42114d8d6 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3791,11 +3791,6 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, struct genl_info *info)
 		return -EINVAL;
 	}
 
-	if (param.channels > CFG80211_MAX_NUM_DIFFERENT_CHANNELS) {
-		GENL_SET_ERR_MSG(info, "too many channels specified");
-		return -EINVAL;
-	}
-
 	if (info->attrs[HWSIM_ATTR_NO_VIF])
 		param.no_vif = true;
 
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 394c4269901c..473d291b9017 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1244,8 +1244,6 @@ struct cfg80211_csa_settings {
 	u8 count;
 };
 
-#define CFG80211_MAX_NUM_DIFFERENT_CHANNELS 10
-
 /**
  * struct iface_combination_params - input parameters for interface combinations
  *
diff --git a/net/wireless/core.c b/net/wireless/core.c
index a2785379df6e..04b8fbae3943 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -576,14 +576,6 @@ static int wiphy_verify_combinations(struct wiphy *wiphy)
 		if (WARN_ON(!c->num_different_channels))
 			return -EINVAL;
 
-		/*
-		 * Put a sane limit on maximum number of different
-		 * channels to simplify channel accounting code.
-		 */
-		if (WARN_ON(c->num_different_channels >
-				CFG80211_MAX_NUM_DIFFERENT_CHANNELS))
-			return -EINVAL;
-
 		/* DFS only works on one channel. */
 		if (WARN_ON(c->radar_detect_widths &&
 			    (c->num_different_channels > 1)))
-- 
2.30.2


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0799464E44
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 13:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349430AbhLAM67 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 07:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349429AbhLAM66 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 07:58:58 -0500
X-Greylist: delayed 374 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Dec 2021 04:55:38 PST
Received: from gimli.kloenk.dev (gimli.kloenk.dev [IPv6:2a0f:4ac0:0:1::cb2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E66C061748
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 04:55:37 -0800 (PST)
Date:   Wed, 1 Dec 2021 13:49:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.de; s=mail;
        t=1638362959; bh=TPkQQlKpJp7z/9ZpSfG0JzYmAdfQ4m6LqWUMTanravM=;
        h=Date:From:To:Cc:Subject;
        b=hOQ66IIF159IPsBbcdG02j9rBzqRdxcQNOnQDq/BQaVmDpOj4GkIHZyiVgVFh28SX
         Qzk2jssHQ0O78bLXUywdTf/QNmTqnnhF83AOhrk/5qj75nZ7MCZ3X4GjHcId5MM7LV
         2erQ+PhACh6l+tCBh/S9jt7UGMAsWJRaMuO18tNY=
From:   Finn Behrens <me@kloenk.de>
To:     johannes@sipsolutions.net, nathan@kernel.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] nl80211: remove reload flag from regulatory_request
Message-ID: <YadvTolO8rQcNCd/@gimli.kloenk.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This removes the previously unused reload flag, which was introduced in
1eda919126b4.
The request is handled as NL80211_REGDOM_SET_BY_CORE, which is parsed
unconditionally.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Fixes: 1eda919126b4 ("nl80211: reset regdom when reloading regdb")
Link: https://lore.kernel.org/all/YaZuKYM5bfWe2Urn@archlinux-ax161/
Signed-off-by: Finn Behrens <me@kloenk.de>
---
Hi,

I removed the reload flag, and set it to NL80211_REGDOM_SET_BY_CORE, as
it already was by accident.

Thanks,
Finn

 include/net/regulatory.h | 1 -
 net/wireless/reg.c       | 6 ++----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/net/regulatory.h b/include/net/regulatory.h
index 0cf9335431e0..47f06f6f5a67 100644
--- a/include/net/regulatory.h
+++ b/include/net/regulatory.h
@@ -83,7 +83,6 @@ struct regulatory_request {
 	enum nl80211_dfs_regions dfs_region;
 	bool intersect;
 	bool processed;
-	bool reload;
 	enum environment_cap country_ie_env;
 	struct list_head list;
 };
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 61f1bf1bc4a7..8148a3b5f607 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1134,9 +1134,8 @@ int reg_reload_regdb(void)
 	request->wiphy_idx = WIPHY_IDX_INVALID;
 	request->alpha2[0] = current_regdomain->alpha2[0];
 	request->alpha2[1] = current_regdomain->alpha2[1];
-	request->initiator = NL80211_USER_REG_HINT_USER;
+	request->initiator = NL80211_REGDOM_SET_BY_CORE;
 	request->user_reg_hint_type = NL80211_USER_REG_HINT_USER;
-	request->reload = true;
 
 	reg_process_hint(request);
 
@@ -2712,8 +2711,7 @@ reg_process_hint_user(struct regulatory_request *user_request)
 
 	treatment = __reg_process_hint_user(user_request);
 	if (treatment == REG_REQ_IGNORE ||
-	    (treatment == REG_REQ_ALREADY_SET &&
-	     !user_request->reload))
+	    treatment == REG_REQ_ALREADY_SET)
 		return REG_REQ_IGNORE;
 
 	user_request->intersect = treatment == REG_REQ_INTERSECT;
-- 
2.31.1


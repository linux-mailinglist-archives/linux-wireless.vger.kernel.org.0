Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AED45FE1A
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Nov 2021 11:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350511AbhK0KeL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Nov 2021 05:34:11 -0500
Received: from gimli.kloenk.dev ([195.39.247.182]:59150 "EHLO gimli.kloenk.dev"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhK0KcL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Nov 2021 05:32:11 -0500
Date:   Sat, 27 Nov 2021 11:28:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
        t=1638008934; bh=JTkxyIFQ+eEZnQUgMzK2aGEKOqlZL5kP3d19nZ5RaPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=fbAYEEi6G1GVaDj9eJrhwbvVsDcY2rmyV6g/e40KrqwxR8HorXxrBi1ZflXT3ju98
         KvEMKQOcOAID2a9HRnzdV2lVN10XRJ/VMk3q3Av62iIFvwDyIpaPxiiEAIFex8iIzH
         gnmupARiFwLr8O5bwngh67e1iB6Jk/yHWYOp+ml8=
From:   Finn Behrens <me@kloenk.dev>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v5] nl80211: reset regdom when reloading regdb
Message-ID: <YaIIZfxHgqc/UTA7@gimli.kloenk.dev>
References: <20210526112418.cdwkn7ed4twctimc@imap.mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526112418.cdwkn7ed4twctimc@imap.mailbox.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

this reloads the regdom when the regulatory db is reloaded.
Without this patch the user had to change the regulatoy domain to a
different, and then reset it to the one the user is in, to have the new
regulatory db take effect

Signed-off-by: Finn Behrens <fin@nyantec.com>
---
Hi,
I moved the rtnl_unlock into a label, and requested the current domain from inside the lock.
Finn

 include/net/regulatory.h |  1 +
 net/wireless/reg.c       | 27 +++++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/net/regulatory.h b/include/net/regulatory.h
index 47f06f6f5a67..0cf9335431e0 100644
--- a/include/net/regulatory.h
+++ b/include/net/regulatory.h
@@ -83,6 +83,7 @@ struct regulatory_request {
 	enum nl80211_dfs_regions dfs_region;
 	bool intersect;
 	bool processed;
+	bool reload;
 	enum environment_cap country_ie_env;
 	struct list_head list;
 };
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index df87c7f3a049..61f1bf1bc4a7 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -133,6 +133,7 @@ static u32 reg_is_indoor_portid;
 
 static void restore_regulatory_settings(bool reset_user, bool cached);
 static void print_regdomain(const struct ieee80211_regdomain *rd);
+static void reg_process_hint(struct regulatory_request *reg_request);
 
 static const struct ieee80211_regdomain *get_cfg80211_regdom(void)
 {
@@ -1098,6 +1099,8 @@ int reg_reload_regdb(void)
 	const struct firmware *fw;
 	void *db;
 	int err;
+	const struct ieee80211_regdomain *current_regdomain;
+	struct regulatory_request *request;
 
 	err = request_firmware(&fw, "regulatory.db", &reg_pdev->dev);
 	if (err)
@@ -1118,8 +1121,27 @@ int reg_reload_regdb(void)
 	if (!IS_ERR_OR_NULL(regdb))
 		kfree(regdb);
 	regdb = db;
-	rtnl_unlock();
 
+	/* reset regulatory domain */
+	current_regdomain = get_cfg80211_regdom();
+
+	request = kzalloc(sizeof(*request), GFP_KERNEL);
+	if (!request) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
+	request->wiphy_idx = WIPHY_IDX_INVALID;
+	request->alpha2[0] = current_regdomain->alpha2[0];
+	request->alpha2[1] = current_regdomain->alpha2[1];
+	request->initiator = NL80211_USER_REG_HINT_USER;
+	request->user_reg_hint_type = NL80211_USER_REG_HINT_USER;
+	request->reload = true;
+
+	reg_process_hint(request);
+
+out_unlock:
+	rtnl_unlock();
  out:
 	release_firmware(fw);
 	return err;
@@ -2690,7 +2712,8 @@ reg_process_hint_user(struct regulatory_request *user_request)
 
 	treatment = __reg_process_hint_user(user_request);
 	if (treatment == REG_REQ_IGNORE ||
-	    treatment == REG_REQ_ALREADY_SET)
+	    (treatment == REG_REQ_ALREADY_SET &&
+	     !user_request->reload))
 		return REG_REQ_IGNORE;
 
 	user_request->intersect = treatment == REG_REQ_INTERSECT;
-- 
2.31.1


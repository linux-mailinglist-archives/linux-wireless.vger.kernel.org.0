Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26C944F2A4
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Nov 2021 12:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhKMLG4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Nov 2021 06:06:56 -0500
Received: from gimli.kloenk.dev ([195.39.247.182]:59128 "EHLO gimli.kloenk.dev"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231735AbhKMLGz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Nov 2021 06:06:55 -0500
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Nov 2021 06:06:55 EST
Date:   Sat, 13 Nov 2021 11:54:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
        t=1636800860; bh=1FVZ6VoGSeZNL+Ck/OUnZE6eqju1Yj/iXfDu6YhRgEY=;
        h=Date:From:To:Cc:Subject:In-Reply-To;
        b=mfJGslkdYwGkTl5Kfi02fcMIgehGYw8nX+e+RXOJVCFuwJcf7emUKwq0/mcayN2iV
         eKvT8MP5IYboTMX1ZVa8dqcslC03pGYeeu+OBf0DJgPCRvPU9OsUjy3f9N6Gb89QEl
         wtIw0s6AFop/5ovgFyjf2o2WobjSG071+jM7om+I=
From:   Finn Behrens <me@kloenk.dev>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v4] nl80211: reset regdom when reloading regdb
Message-ID: <20210526112418.cdwkn7ed4twctimc@imap.mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X7+F/ht8T7aGiIl7@bombur.kloenk.de>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

this reloads the regdom when the regulatory db is reloaded.
Without this patch the user had to change the regulatoy domain to a
different, and then reset it to the one the user is in, to have the new
regulatory db take effect

Signed-off-by: Finn Behrens <fin@nyantec.com>
---
Sorry for taking so long for a new version. The mail provider my company
is using had some major problems connecting to the LKML.
This is why I now are using my personal mail server.

 include/net/regulatory.h |  1 +
 net/wireless/reg.c       | 26 +++++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

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
index 0406ce7334fa..3460c0e75c6d 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -133,6 +133,7 @@ static u32 reg_is_indoor_portid;
 
 static void restore_regulatory_settings(bool reset_user, bool cached);
 static void print_regdomain(const struct ieee80211_regdomain *rd);
+static void reg_process_hint(struct regulatory_request *reg_request);
 
 static const struct ieee80211_regdomain *get_cfg80211_regdom(void)
 {
@@ -1091,6 +1092,8 @@ int reg_reload_regdb(void)
 	const struct firmware *fw;
 	void *db;
 	int err;
+	const struct ieee80211_regdomain *current_regdomain;
+	struct regulatory_request *request;
 
 	err = request_firmware(&fw, "regulatory.db", &reg_pdev->dev);
 	if (err)
@@ -1113,6 +1116,26 @@ int reg_reload_regdb(void)
 	regdb = db;
 	rtnl_unlock();
 
+	/* reset regulatory domain */
+	current_regdomain = get_cfg80211_regdom();
+
+	request = kzalloc(sizeof(*request), GFP_KERNEL);
+	if (!request) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	request->wiphy_idx = WIPHY_IDX_INVALID;
+	request->alpha2[0] = current_regdomain->alpha2[0];
+	request->alpha2[1] = current_regdomain->alpha2[1];
+	request->initiator = NL80211_USER_REG_HINT_USER;
+	request->user_reg_hint_type = NL80211_USER_REG_HINT_USER;
+	request->reload = true;
+
+	rtnl_lock();
+	reg_process_hint(request);
+	rtnl_unlock();
+
  out:
 	release_firmware(fw);
 	return err;
@@ -2683,7 +2706,8 @@ reg_process_hint_user(struct regulatory_request *user_request)
 
 	treatment = __reg_process_hint_user(user_request);
 	if (treatment == REG_REQ_IGNORE ||
-	    treatment == REG_REQ_ALREADY_SET)
+	    (treatment == REG_REQ_ALREADY_SET &&
+				!user_request->reload))
 		return REG_REQ_IGNORE;
 
 	user_request->intersect = treatment == REG_REQ_INTERSECT;
-- 
2.31.1


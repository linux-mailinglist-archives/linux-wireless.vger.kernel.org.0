Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8571D2C5235
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Nov 2020 11:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgKZKkH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Nov 2020 05:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbgKZKkH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Nov 2020 05:40:07 -0500
Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [IPv6:2001:67c:2050:101:465::203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8904C0613D4
        for <linux-wireless@vger.kernel.org>; Thu, 26 Nov 2020 02:40:06 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4ChZ5b3fQczQlk6;
        Thu, 26 Nov 2020 11:40:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nyantec.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received; s=default; t=1606387200; bh=uGltq9Bkfm9AOy4
        u+CN7L6+lcZhlZ6cQTyqMLNVWgXU=; b=io9aCR6UYJ9OHgKjliH9O0ObsFtKl5p
        USfnJVq+eiWolRiXkgkiA1SKSr5LqMm+G27czyOFPQ8fKoXuE7nEaPDyXtU7EKnB
        0netk49Pig0mt9LTQw2whnvm7eM6MY49KkUXW7abKibPsDbNfEr1wbyL+4o9Sumv
        nBJttHrV+UPtjU6m/kUnua8G7588ZKlMZ5/cbY83uzZvajlN1SZHKXZsx2WApwPg
        0ofdy4cgBfEo8csZWIh+5/bGkT6/+8cR1EHzZejGfex7BxVT5XBQUyy3/Y3PoEGJ
        ZUVkNvaoKHvXxE6fS1jIB2u3vK4n3b/IOrX2bES64u19FS3LlJg6CRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyantec.com; s=default;
        t=1606387201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7NfHCaEvKkqX/8tamyP6d81SRFx40twmOZtTjoUsiPg=;
        b=uaCTl0XEGnoaD40GSKSB5oYxRJYs/cNYaSyXXSFqeNvd3tMm/NFZXqZD2HxndH4DKpDRiC
        F0WrH8KdYWA8IXbVs13bHVw5uo4f7oT4hYb3Hh92XiMKKH+AvO3ssPcuAHYzuTIKBSZ3nF
        0AZxOtJLWj7W4yWAqz3coiW/HRQeVzAbw5judSa0zWlfmRMJUUGsmP83T+ws8u8/hut4qJ
        qTZ+Cd/Ir816s27hO97nWiFdvfB2irQa2eP8sPugheLeF9uOW8+dUO48ip3cbq4LHI3zTC
        hTpRD6hkn3+a18OdwxbyIJQbfxkbwwILBxyHQAdAuGiob7N8osSBBbqJLdU2sw==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id GhyChzLa-Q1U; Thu, 26 Nov 2020 11:40:00 +0100 (CET)
Date:   Thu, 26 Nov 2020 11:39:58 +0100
From:   Finn Behrens <fin@nyantec.com>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH v2] nl80211: reset regdom when reloading regdb
Message-ID: <X7+F/ht8T7aGiIl7@bombur.kloenk.de>
References: <8c3e46ac-331b-0922-5379-0cb1ef61a83b@nyantec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c3e46ac-331b-0922-5379-0cb1ef61a83b@nyantec.com>
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -1.95 / 15.00 / 15.00
X-Rspamd-Queue-Id: 7F5E21833
X-Rspamd-UID: b9b342
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

reset the regdom when NL80211_CMD_RELOAD_REGDB is send

Signed-off-by: Finn Behrens <fin@nyantec.com>
---
resend, as patchwork showed it malformed.

 include/net/regulatory.h |  1 +
 net/wireless/reg.c       | 31 +++++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

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
index a04fdfb35f07..50314916b020 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -199,6 +199,7 @@ static struct regulatory_request *get_last_request(void)
 /* Used to queue up regulatory hints */
 static LIST_HEAD(reg_requests_list);
 static spinlock_t reg_requests_lock;
+static void queue_regulatory_request(struct regulatory_request *request);
 
 /* Used to queue up beacon hints for review */
 static LIST_HEAD(reg_pending_beacons);
@@ -1081,10 +1082,13 @@ int reg_reload_regdb(void)
 	int err;
 
 	err = request_firmware(&fw, "regulatory.db", &reg_pdev->dev);
-	if (err)
+	if (err) {
+		pr_info("failed to load regulatory.db\n");
 		return err;
+	}
 
 	if (!valid_regdb(fw->data, fw->size)) {
+		pr_info("loaded regulatory.db is malformed or signature is missing/invalid\n");
 		err = -ENODATA;
 		goto out;
 	}
@@ -1101,6 +1105,28 @@ int reg_reload_regdb(void)
 	regdb = db;
 	rtnl_unlock();
 
+	// reset regulatory
+	const struct ieee80211_regdomain *current_regdomain = NULL;
+
+	current_regdomain = get_cfg80211_regdom();
+
+	struct regulatory_request *request = NULL;
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
+	queue_regulatory_request(request);
+
  out:
 	release_firmware(fw);
 	return err;
@@ -2657,7 +2683,8 @@ reg_process_hint_user(struct regulatory_request *user_request)
 
 	treatment = __reg_process_hint_user(user_request);
 	if (treatment == REG_REQ_IGNORE ||
-	    treatment == REG_REQ_ALREADY_SET)
+	    treatment == REG_REQ_ALREADY_SET &&
+			!user_request->reload)
 		return REG_REQ_IGNORE;
 
 	user_request->intersect = treatment == REG_REQ_INTERSECT;
-- 
2.29.2


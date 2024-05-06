Return-Path: <linux-wireless+bounces-7230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E278BD500
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 20:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8611C20DE2
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 18:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4851B158DB7;
	Mon,  6 May 2024 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gAdM71wk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5004D158DB4
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021893; cv=none; b=eVRSvDgOCjJaQphjKLWfKzO2acqb032RBHnWcRxViFVLMHYMZcdZx9ICSecybAUo6ce5oM3wLQUit+JdazrcrtEfYT/m5DclkJ+8Q4SI6SMO7TAgUR/VEidZAmtvH5mtp+ou6QEgvs5hxMVJE1u328CDuCcCQkvbXjYKKyb7/ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021893; c=relaxed/simple;
	bh=5zFJt0Xifs6APigaFSS3c1DXRDiK/pJj2o64pX4/j84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XSXNoVPbAqjd5q05+15ZONSuL0QwrctS6HWBXM3fbSq1SA4BRpqgnvUgPjgZlSrEwjjZr/cdm2FUqWFmOc7wJLkeYGcMcVL083Fn2++u8i8a5UB7iijo4VkYibwwghNhNyOt6QOCoZttwp5nLgMc0HE37atrKQ/AMaWYnzcVqys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gAdM71wk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=XxAlB3N3L+d2m7+9AkWlurxUTc8PNtsvdasvb/iixJA=; t=1715021888; x=1716231488; 
	b=gAdM71wktL/Xzi0fUUnpXKL+XKa+MsJRNYuzgfMyynsz68c/kft/iOm0ohiGhmtoLQViJ0ST2Sa
	1glKFkIS/pKHhelq013bw546pwq6k98uAjsbcj9eD7Jvha1wFnhKU1J18xl73v1KGvnmE7lO4OEru
	ip1szleUNeJNW5R/NaUSOuBcUIgmlnAk0BML0k+5myRJXIlcGxYWNtyhnYh3mNkWHjyhztAlNqVRJ
	LSFKYxc4UmQcbhM0MtZU8YhBWkckIUB2Z7J2JprelyyyDPw294hVuE/u2u7dOyR1tBszpJb9yN86T
	xdRYeb7sU+lhDZzaPd8ApVCmZNpzhwAE2D/A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s43XC-00000008904-0sE4;
	Mon, 06 May 2024 20:57:58 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: nl80211: clean up coalescing rule handling
Date: Mon,  6 May 2024 20:57:55 +0200
Message-ID: <20240506205754.d9670dbb41ec.Ia02bf8f8fefbf533c64c5fa26175848d4a3a7899@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's no need to allocate a tiny struct and then an
array again, just allocate the two together and use
__counted_by(). Also unify the freeing, removing the
useless NULL pointer check.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h |  2 +-
 net/wireless/core.c    |  3 ++-
 net/wireless/nl80211.c | 44 ++++++++++++++----------------------------
 net/wireless/nl80211.h |  4 ++--
 4 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index cbf1664dc569..56ac69070060 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3566,8 +3566,8 @@ struct cfg80211_coalesce_rules {
  * @n_rules: number of rules
  */
 struct cfg80211_coalesce {
-	struct cfg80211_coalesce_rules *rules;
 	int n_rules;
+	struct cfg80211_coalesce_rules rules[] __counted_by(n_rules);
 };
 
 /**
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 3fb1b637352a..6092f7b66cd6 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1141,7 +1141,8 @@ void wiphy_unregister(struct wiphy *wiphy)
 	flush_work(&rdev->background_cac_abort_wk);
 
 	cfg80211_rdev_free_wowlan(rdev);
-	cfg80211_rdev_free_coalesce(rdev);
+	cfg80211_free_coalesce(rdev->coalesce);
+	rdev->coalesce = NULL;
 }
 EXPORT_SYMBOL(wiphy_unregister);
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3c0bca4238d3..583298dd55f4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13861,9 +13861,8 @@ static int nl80211_get_coalesce(struct sk_buff *skb, struct genl_info *info)
 	return -ENOBUFS;
 }
 
-void cfg80211_rdev_free_coalesce(struct cfg80211_registered_device *rdev)
+void cfg80211_free_coalesce(struct cfg80211_coalesce *coalesce)
 {
-	struct cfg80211_coalesce *coalesce = rdev->coalesce;
 	int i, j;
 	struct cfg80211_coalesce_rules *rule;
 
@@ -13878,7 +13877,6 @@ void cfg80211_rdev_free_coalesce(struct cfg80211_registered_device *rdev)
 	}
 	kfree(coalesce->rules);
 	kfree(coalesce);
-	rdev->coalesce = NULL;
 }
 
 static int nl80211_parse_coalesce_rule(struct cfg80211_registered_device *rdev,
@@ -13976,17 +13974,16 @@ static int nl80211_set_coalesce(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	const struct wiphy_coalesce_support *coalesce = rdev->wiphy.coalesce;
-	struct cfg80211_coalesce new_coalesce = {};
-	struct cfg80211_coalesce *n_coalesce;
-	int err, rem_rule, n_rules = 0, i, j;
+	struct cfg80211_coalesce *new_coalesce;
+	int err, rem_rule, n_rules = 0, i;
 	struct nlattr *rule;
-	struct cfg80211_coalesce_rules *tmp_rule;
 
 	if (!rdev->wiphy.coalesce || !rdev->ops->set_coalesce)
 		return -EOPNOTSUPP;
 
 	if (!info->attrs[NL80211_ATTR_COALESCE_RULE]) {
-		cfg80211_rdev_free_coalesce(rdev);
+		cfg80211_free_coalesce(rdev->coalesce);
+		rdev->coalesce = NULL;
 		rdev_set_coalesce(rdev, NULL);
 		return 0;
 	}
@@ -13997,47 +13994,34 @@ static int nl80211_set_coalesce(struct sk_buff *skb, struct genl_info *info)
 	if (n_rules > coalesce->n_rules)
 		return -EINVAL;
 
-	new_coalesce.rules = kcalloc(n_rules, sizeof(new_coalesce.rules[0]),
-				     GFP_KERNEL);
-	if (!new_coalesce.rules)
+	new_coalesce = kzalloc(struct_size(new_coalesce, rules, n_rules),
+			       GFP_KERNEL);
+	if (!new_coalesce)
 		return -ENOMEM;
 
-	new_coalesce.n_rules = n_rules;
+	new_coalesce->n_rules = n_rules;
 	i = 0;
 
 	nla_for_each_nested(rule, info->attrs[NL80211_ATTR_COALESCE_RULE],
 			    rem_rule) {
 		err = nl80211_parse_coalesce_rule(rdev, rule,
-						  &new_coalesce.rules[i]);
+						  &new_coalesce->rules[i]);
 		if (err)
 			goto error;
 
 		i++;
 	}
 
-	err = rdev_set_coalesce(rdev, &new_coalesce);
+	err = rdev_set_coalesce(rdev, new_coalesce);
 	if (err)
 		goto error;
 
-	n_coalesce = kmemdup(&new_coalesce, sizeof(new_coalesce), GFP_KERNEL);
-	if (!n_coalesce) {
-		err = -ENOMEM;
-		goto error;
-	}
-	cfg80211_rdev_free_coalesce(rdev);
-	rdev->coalesce = n_coalesce;
+	cfg80211_free_coalesce(rdev->coalesce);
+	rdev->coalesce = new_coalesce;
 
 	return 0;
 error:
-	for (i = 0; i < new_coalesce.n_rules; i++) {
-		tmp_rule = &new_coalesce.rules[i];
-		if (!tmp_rule)
-			continue;
-		for (j = 0; j < tmp_rule->n_patterns; j++)
-			kfree(tmp_rule->patterns[j].mask);
-		kfree(tmp_rule->patterns);
-	}
-	kfree(new_coalesce.rules);
+	cfg80211_free_coalesce(new_coalesce);
 
 	return err;
 }
diff --git a/net/wireless/nl80211.h b/net/wireless/nl80211.h
index 6376f3a87f8a..ffaab9a92e5b 100644
--- a/net/wireless/nl80211.h
+++ b/net/wireless/nl80211.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Portions of this file
- * Copyright (C) 2018, 2020-2022 Intel Corporation
+ * Copyright (C) 2018, 2020-2024 Intel Corporation
  */
 #ifndef __NET_WIRELESS_NL80211_H
 #define __NET_WIRELESS_NL80211_H
@@ -119,7 +119,7 @@ nl80211_radar_notify(struct cfg80211_registered_device *rdev,
 
 void nl80211_send_ap_stopped(struct wireless_dev *wdev, unsigned int link_id);
 
-void cfg80211_rdev_free_coalesce(struct cfg80211_registered_device *rdev);
+void cfg80211_free_coalesce(struct cfg80211_coalesce *coalesce);
 
 /* peer measurement */
 int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info);
-- 
2.44.0



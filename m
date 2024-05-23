Return-Path: <linux-wireless+bounces-7993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B941A8CCFD6
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 12:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F8C1F23750
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 10:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1218054FA9;
	Thu, 23 May 2024 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Ls6OhkrR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DA2140E2F
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458555; cv=none; b=lQYsrsBEr3pZ6maVb/eX3BwJJkD0qbfKsgojft5Ff7O70ghszUjb3drVQhe6z1okW2LYrrs8cYMVfgWl0qX2HqjAbMq7koSs+HmDdmxF5UDMseTecAcmquBHFDH0Go/BlsnSazzDc951DCMQ6BnqUT49IO4EVfM80/pP1EOyTfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458555; c=relaxed/simple;
	bh=Fb/GDrrb5YDlChX1l/pAMKDPVmFrW4GmcbUrYUA5MV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i7x+5vpBpqc5UvW0FeRRTfIwza5LNFrZeDihI7o2OQP2vWOI8pxlECMEVk+h9Ja1YA+D0bk+HjogFxIYYHLdVmmUPOVrtnSG6JOmK47dQFYcuP74Tn6D8biKBGLSS69iQPkm4ovUCjsohFCusNNKbOzUpCeLLlAXH7zM0puCs2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ls6OhkrR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=3sFuL6EXuKeZOXi46aeHAxIwdxLecnUA8C5c1f/Q2V4=; t=1716458553; x=1717668153; 
	b=Ls6OhkrR5blxO4I2TN4D6f/aqqGJCoEiGvvhCa/V/wzUXoB43gtIOfcIei9y1u8XN6d4tVbUOPA
	EjdqI3LoTosDe5TKZaQbtvX3y+K33t5F4ZXs+Do9n6pUMTNqp9CiDk8f534XVEjD6bfqqYZrOWxDD
	AxKZuKBa5ZfJGUWk5DlSVaEGnaYHNPQ/jK2z3/JX+47LlKYD1YdAJDM7vv3em1gZtGWJzMeHUFK5i
	HK/D2Y3sAkUwuvyxwOjAWZVGv1iBm0RqN7G9jgeQJBCgCo1lrQnlQ78RYBAFWmbuVk5AzZJ+MYLwA
	rfen92UUMXA16c+vVeYZnDcukAizMLKoXu5w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sA5HH-00000005w2X-45Kb;
	Thu, 23 May 2024 12:02:28 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH v2] wifi: nl80211: clean up coalescing rule handling
Date: Thu, 23 May 2024 12:02:13 +0200
Message-ID: <20240523120213.48a40cfb96f9.Ia02bf8f8fefbf533c64c5fa26175848d4a3a7899@changeid>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's no need to allocate a tiny struct and then
an array again, just allocate the two together and
use __counted_by(). Also unify the freeing.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: don't free embedded rules
---
 include/net/cfg80211.h |  2 +-
 net/wireless/core.c    |  3 ++-
 net/wireless/nl80211.c | 47 ++++++++++++++----------------------------
 net/wireless/nl80211.h |  4 ++--
 4 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d79180bec7a1..5da9bb0ac6a4 100644
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
index 61f7cd8a8e9c..7c35349b9596 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1145,7 +1145,8 @@ void wiphy_unregister(struct wiphy *wiphy)
 	flush_work(&rdev->background_cac_abort_wk);
 
 	cfg80211_rdev_free_wowlan(rdev);
-	cfg80211_rdev_free_coalesce(rdev);
+	cfg80211_free_coalesce(rdev->coalesce);
+	rdev->coalesce = NULL;
 }
 EXPORT_SYMBOL(wiphy_unregister);
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 6ba988a6f5a2..8ff5f79d446a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -13897,9 +13897,8 @@ static int nl80211_get_coalesce(struct sk_buff *skb, struct genl_info *info)
 	return -ENOBUFS;
 }
 
-void cfg80211_rdev_free_coalesce(struct cfg80211_registered_device *rdev)
+void cfg80211_free_coalesce(struct cfg80211_coalesce *coalesce)
 {
-	struct cfg80211_coalesce *coalesce = rdev->coalesce;
 	int i, j;
 	struct cfg80211_coalesce_rules *rule;
 
@@ -13908,13 +13907,13 @@ void cfg80211_rdev_free_coalesce(struct cfg80211_registered_device *rdev)
 
 	for (i = 0; i < coalesce->n_rules; i++) {
 		rule = &coalesce->rules[i];
+		if (!rule)
+			continue;
 		for (j = 0; j < rule->n_patterns; j++)
 			kfree(rule->patterns[j].mask);
 		kfree(rule->patterns);
 	}
-	kfree(coalesce->rules);
 	kfree(coalesce);
-	rdev->coalesce = NULL;
 }
 
 static int nl80211_parse_coalesce_rule(struct cfg80211_registered_device *rdev,
@@ -14012,17 +14011,16 @@ static int nl80211_set_coalesce(struct sk_buff *skb, struct genl_info *info)
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
@@ -14033,47 +14031,34 @@ static int nl80211_set_coalesce(struct sk_buff *skb, struct genl_info *info)
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
2.45.1



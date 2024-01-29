Return-Path: <linux-wireless+bounces-2696-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A15AC8412C9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05B8B227AC
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 18:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F1D179AB;
	Mon, 29 Jan 2024 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cQXteq3a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3361D687
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554467; cv=none; b=RKG5ORqLKaFbLwATc6jnVnOhwEuOcWdpIFjKN0DN7y/8MamjPBzMKyu0RD8/RexE336QRzlGE9zsWcLNBbvqYuDPl7dgVLXiUm96k3x9BWH4d75V6c8lKdne6KxCI+cY61KMymHvDAr7+uve33ZJqMpOF/EO+vrPsj2QOdGARDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554467; c=relaxed/simple;
	bh=lHkKYaIgPWjMSaVmy6oPj/bOVxkU+/43rv42Bo9i1+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pkz4z3e/LpOzUOoBMGdmnlHoxrJrWIQhId08g1+VwE7SJw+oqFeFxqCxiLfqQyeTlR56qjVx7jp/9zfvD/n0o8AXQeIUb4W06fhI2GFXAkNF6LKIzY5qT7ZzPZn5lqBc+XG5YbbMOAb0rBvDKZ5pISKvoY5gMZ2IsMtTR5t3Hlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cQXteq3a; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=wVVLQBzzoWKJBCyUS2/thIvBapzi0ktmox5YgF5AgSA=; t=1706554466; x=1707764066; 
	b=cQXteq3ah4tXrK6+OcZao3esgvgcWiXRP8aYpeA0lQy9rGHf8urs1/RKw8tEBJ3yZGTliiSSNDi
	Db0qq8BTrZjEZVHf6xYFBx9eSRjhRwV0sdaqcPOB+3Gh4BFTztnwmZgSqIKSUYn7xSCtaKN9s23uG
	q81fJLvFxR+7K7b7WJzY8CFB0Ph8F79M9O26kMAv2YKL/v7Z7a6TiBWsYPzcDdj3BovoWKVMqk8FW
	nZa/apsDEQiaOero+m/GFcqDH+m56GSho+7jPr4QKZ+mk/iiGdtTd5v/gaQG84H5j6BOJR2Wgciwh
	SfDw//xMtS5gWzSJtR7BiLTJTOVaF6ujR2XA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWlz-00000004ziA-12WU;
	Mon, 29 Jan 2024 19:54:23 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: nl80211: move WPA version validation to policy
Date: Mon, 29 Jan 2024 19:54:21 +0100
Message-ID: <20240129195421.e8cae9866ccb.I2539b395e3476307d702c6867e51a937e52e57a0@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned

From: Johannes Berg <johannes.berg@intel.com>

For a contiguous mask (starting with bit 0) of allowed values
in a bitmap, it's equivalent to check "!(val & ~mask)" and
"val ∈ [0, mask]". Use that to move the WPA versions check to
the policy, for better error reporting.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1331e39da0e6..b533412ad1e0 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 
 #include <linux/if.h>
@@ -581,7 +581,11 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_PRIVACY] = { .type = NLA_FLAG },
 	[NL80211_ATTR_STATUS_CODE] = { .type = NLA_U16 },
 	[NL80211_ATTR_CIPHER_SUITE_GROUP] = { .type = NLA_U32 },
-	[NL80211_ATTR_WPA_VERSIONS] = { .type = NLA_U32 },
+	[NL80211_ATTR_WPA_VERSIONS] =
+		NLA_POLICY_RANGE(NLA_U32, 0,
+				 NL80211_WPA_VERSION_1 |
+				 NL80211_WPA_VERSION_2 |
+				 NL80211_WPA_VERSION_3),
 	[NL80211_ATTR_PID] = { .type = NLA_U32 },
 	[NL80211_ATTR_4ADDR] = { .type = NLA_U8 },
 	[NL80211_ATTR_PMKID] = NLA_POLICY_EXACT_LEN_WARN(WLAN_PMKID_LEN),
@@ -10590,13 +10594,6 @@ static int nl80211_dump_survey(struct sk_buff *skb, struct netlink_callback *cb)
 	return res;
 }
 
-static bool nl80211_valid_wpa_versions(u32 wpa_versions)
-{
-	return !(wpa_versions & ~(NL80211_WPA_VERSION_1 |
-				  NL80211_WPA_VERSION_2 |
-				  NL80211_WPA_VERSION_3));
-}
-
 static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -10822,12 +10819,9 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
 			return -EINVAL;
 	}
 
-	if (info->attrs[NL80211_ATTR_WPA_VERSIONS]) {
+	if (info->attrs[NL80211_ATTR_WPA_VERSIONS])
 		settings->wpa_versions =
 			nla_get_u32(info->attrs[NL80211_ATTR_WPA_VERSIONS]);
-		if (!nl80211_valid_wpa_versions(settings->wpa_versions))
-			return -EINVAL;
-	}
 
 	if (info->attrs[NL80211_ATTR_AKM_SUITES]) {
 		void *data;
-- 
2.43.0



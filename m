Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B54730F555
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Feb 2021 15:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbhBDOrX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Feb 2021 09:47:23 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:52032 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbhBDOq7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Feb 2021 09:46:59 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id C48FB13C2B0;
        Thu,  4 Feb 2021 06:46:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C48FB13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1612449974;
        bh=D3+Ty0CmNN1bkAtpX5jUeaG21NCfK/ogK4JWIdWlq04=;
        h=From:To:Cc:Subject:Date:From;
        b=NHDyeS0baCZl0in8BoxjUa4QnBnQLpLkHfo9/tAPdE7uI98MUNjD7YaPhFww1eYKq
         3unJhAqC4TuO5me1xG0hpYwXVZ8B00hCqLXrGfh8KN6m2mviGV2UsvRowMtMmQg5kT
         o3/VQNkOXiUbBGPktzfbGiQrLZKa7z4mvP+CqJrY=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wireless: Support disabling HE mode
Date:   Thu,  4 Feb 2021 06:46:10 -0800
Message-Id: <20210204144610.25971-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Allow user to disable HE mode, similar to how VHT and HT
can be disabled.  Useful for testing.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 include/net/cfg80211.h       | 2 ++
 include/uapi/linux/nl80211.h | 2 ++
 net/mac80211/mlme.c          | 3 +++
 net/wireless/nl80211.c       | 7 +++++++
 4 files changed, 14 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index f04f5439da71..76360dcb7867 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2581,12 +2581,14 @@ struct cfg80211_auth_request {
  *	authentication capability. Drivers can offload authentication to
  *	userspace if this flag is set. Only applicable for cfg80211_connect()
  *	request (connect callback).
+ * @ASSOC_REQ_DISABLE_HE:  Disable HE
  */
 enum cfg80211_assoc_req_flags {
 	ASSOC_REQ_DISABLE_HT			= BIT(0),
 	ASSOC_REQ_DISABLE_VHT			= BIT(1),
 	ASSOC_REQ_USE_RRM			= BIT(2),
 	CONNECT_REQ_EXTERNAL_AUTH_SUPPORT	= BIT(3),
+	ASSOC_REQ_DISABLE_HE			= BIT(4),
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 40832d13c2f1..5188fe581efc 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3045,6 +3045,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_SAR_SPEC,
 
+	NL80211_ATTR_DISABLE_HE,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 9ac6eb8dc2e2..50cb97f94162 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5796,6 +5796,9 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	if (req->flags & ASSOC_REQ_DISABLE_VHT)
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
 
+	if (req->flags & ASSOC_REQ_DISABLE_HE)
+		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
+
 	err = ieee80211_prep_connection(sdata, req->bss, true, override);
 	if (err)
 		goto err_clear;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2dc930e6f96f..ea169cd232c8 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -732,6 +732,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 				 NL80211_SAE_PWE_BOTH),
 	[NL80211_ATTR_RECONNECT_REQUESTED] = { .type = NLA_REJECT },
 	[NL80211_ATTR_SAR_SPEC] = NLA_POLICY_NESTED(sar_policy),
+	[NL80211_ATTR_DISABLE_HE] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -10121,6 +10122,9 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_VHT]))
 		req.flags |= ASSOC_REQ_DISABLE_VHT;
 
+	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_HE]))
+		req.flags |= ASSOC_REQ_DISABLE_HE;
+
 	if (info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK])
 		memcpy(&req.vht_capa_mask,
 		       nla_data(info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK]),
@@ -10930,6 +10934,9 @@ static int nl80211_connect(struct sk_buff *skb, struct genl_info *info)
 	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_VHT]))
 		connect.flags |= ASSOC_REQ_DISABLE_VHT;
 
+	if (nla_get_flag(info->attrs[NL80211_ATTR_DISABLE_HE]))
+		connect.flags |= ASSOC_REQ_DISABLE_HE;
+
 	if (info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK])
 		memcpy(&connect.vht_capa_mask,
 		       nla_data(info->attrs[NL80211_ATTR_VHT_CAPABILITY_MASK]),
-- 
2.20.1


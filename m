Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54821BDF73
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2020 15:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgD2Ns7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 09:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgD2Ns6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 09:48:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD4BC035493;
        Wed, 29 Apr 2020 06:48:57 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jTn56-001vkM-4d; Wed, 29 Apr 2020 15:48:56 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     netdev@vger.kernel.org
Cc:     Antonio Quartulli <ordex@autistici.org>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/7] nl80211: link recursive netlink nested policy
Date:   Wed, 29 Apr 2020 15:48:39 +0200
Message-Id: <20200429154836.b2e6bb0b4731.I697e382aa8ac181afe32ffac50b330c558bc34b1@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200429134843.42224-1-johannes@sipsolutions.net>
References: <20200429134843.42224-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Now that we have limited recursive policy validation to avoid
stack overflows, change nl80211 to actually link the nested
policy (linking back to itself eventually), which allows some
code cleanups.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 10 ++++------
 net/wireless/nl80211.h |  2 --
 net/wireless/pmsr.c    |  3 +--
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 692bcd35f809..57c618b6cb0e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -253,6 +253,8 @@ static int validate_ie_attr(const struct nlattr *attr,
 }
 
 /* policy for the attributes */
+static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR];
+
 static const struct nla_policy
 nl80211_ftm_responder_policy[NL80211_FTM_RESP_ATTR_MAX + 1] = {
 	[NL80211_FTM_RESP_ATTR_ENABLED] = { .type = NLA_FLAG, },
@@ -296,11 +298,7 @@ nl80211_pmsr_req_attr_policy[NL80211_PMSR_REQ_ATTR_MAX + 1] = {
 static const struct nla_policy
 nl80211_psmr_peer_attr_policy[NL80211_PMSR_PEER_ATTR_MAX + 1] = {
 	[NL80211_PMSR_PEER_ATTR_ADDR] = NLA_POLICY_ETH_ADDR,
-	/*
-	 * we could specify this again to be the top-level policy,
-	 * but that would open us up to recursion problems ...
-	 */
-	[NL80211_PMSR_PEER_ATTR_CHAN] = { .type = NLA_NESTED },
+	[NL80211_PMSR_PEER_ATTR_CHAN] = NLA_POLICY_NESTED(nl80211_policy),
 	[NL80211_PMSR_PEER_ATTR_REQ] =
 		NLA_POLICY_NESTED(nl80211_pmsr_req_attr_policy),
 	[NL80211_PMSR_PEER_ATTR_RESP] = { .type = NLA_REJECT },
@@ -347,7 +345,7 @@ nl80211_tid_config_attr_policy[NL80211_TID_CONFIG_ATTR_MAX + 1] = {
 			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
 };
 
-const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
+static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
 	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
 	[NL80211_ATTR_WIPHY_NAME] = { .type = NLA_NUL_STRING,
diff --git a/net/wireless/nl80211.h b/net/wireless/nl80211.h
index a41e94a49a89..d3e8e426c486 100644
--- a/net/wireless/nl80211.h
+++ b/net/wireless/nl80211.h
@@ -11,8 +11,6 @@
 int nl80211_init(void);
 void nl80211_exit(void);
 
-extern const struct nla_policy nl80211_policy[NUM_NL80211_ATTR];
-
 void *nl80211hdr_put(struct sk_buff *skb, u32 portid, u32 seq,
 		     int flags, u8 cmd);
 bool nl80211_put_sta_rate(struct sk_buff *msg, struct rate_info *info,
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 63dc8023447f..a95c79d18349 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -187,10 +187,9 @@ static int pmsr_parse_peer(struct cfg80211_registered_device *rdev,
 
 	/* reuse info->attrs */
 	memset(info->attrs, 0, sizeof(*info->attrs) * (NL80211_ATTR_MAX + 1));
-	/* need to validate here, we don't want to have validation recursion */
 	err = nla_parse_nested_deprecated(info->attrs, NL80211_ATTR_MAX,
 					  tb[NL80211_PMSR_PEER_ATTR_CHAN],
-					  nl80211_policy, info->extack);
+					  NULL, info->extack);
 	if (err)
 		return err;
 
-- 
2.25.1


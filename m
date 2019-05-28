Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52FE62C1DC
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 10:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfE1I4M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 04:56:12 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:45126 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfE1I4M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 04:56:12 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hVXty-000815-0H; Tue, 28 May 2019 10:56:10 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] nl80211: require and validate vendor command policy
Date:   Tue, 28 May 2019 10:56:03 +0200
Message-Id: <20190528085603.24770-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.17.2
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Require that each vendor command give a policy of its sub-attributes
in NL80211_ATTR_VENDOR_DATA, and then (stricly) check the contents,
including the NLA_F_NESTED flag that we couldn't check on the outer
layer because there we don't know yet.

It is possible to use VENDOR_CMD_RAW_DATA for raw data, but then no
nested data can be given (NLA_F_NESTED flag must be clear) and the
data is just passed as is to the command.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c |  2 ++
 include/net/cfg80211.h                |  8 ++++++
 include/net/netlink.h                 |  9 +++++++
 net/wireless/core.c                   | 13 +++++++++
 net/wireless/nl80211.c                | 39 +++++++++++++++++++++++++--
 5 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index b5274d1f30fa..0ddfce6b94ea 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -457,6 +457,8 @@ static struct wiphy_vendor_command mac80211_hwsim_vendor_commands[] = {
 			  .subcmd = QCA_NL80211_SUBCMD_TEST },
 		.flags = WIPHY_VENDOR_CMD_NEED_NETDEV,
 		.doit = mac80211_hwsim_vendor_cmd_test,
+		.policy = hwsim_vendor_test_policy,
+		.maxattr = QCA_WLAN_VENDOR_ATTR_MAX,
 	}
 };
 
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 948139690a58..56dd141d8c89 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4152,6 +4152,8 @@ struct sta_opmode_info {
 	u8 rx_nss;
 };
 
+#define VENDOR_CMD_RAW_DATA ((const struct nla_policy *)ERR_PTR(-ENODATA))
+
 /**
  * struct wiphy_vendor_command - vendor command definition
  * @info: vendor command identifying information, as used in nl80211
@@ -4162,6 +4164,10 @@ struct sta_opmode_info {
  * @dumpit: dump callback, for transferring bigger/multiple items. The
  *	@storage points to cb->args[5], ie. is preserved over the multiple
  *	dumpit calls.
+ * @policy: policy pointer for attributes within %NL80211_ATTR_VENDOR_DATA.
+ *	Set this to %VENDOR_CMD_RAW_DATA if no policy can be given and the
+ *	attribute is just raw data (e.g. a firmware command).
+ * @maxattr: highest attribute number in policy
  * It's recommended to not have the same sub command with both @doit and
  * @dumpit, so that userspace can assume certain ones are get and others
  * are used with dump requests.
@@ -4174,6 +4180,8 @@ struct wiphy_vendor_command {
 	int (*dumpit)(struct wiphy *wiphy, struct wireless_dev *wdev,
 		      struct sk_buff *skb, const void *data, int data_len,
 		      unsigned long *storage);
+	const struct nla_policy *policy;
+	unsigned int maxattr;
 };
 
 /**
diff --git a/include/net/netlink.h b/include/net/netlink.h
index 395b4406f4b0..28ece67f5312 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1754,6 +1754,15 @@ static inline int __nla_validate_nested(const struct nlattr *start, int maxtype,
 			      validate, extack);
 }
 
+static inline int
+nl80211_validate_nested(const struct nlattr *start, int maxtype,
+			const struct nla_policy *policy,
+			struct netlink_ext_ack *extack)
+{
+	return __nla_validate_nested(start, maxtype, policy,
+				     NL_VALIDATE_STRICT, extack);
+}
+
 static inline int
 nla_validate_nested_deprecated(const struct nlattr *start, int maxtype,
 			       const struct nla_policy *policy,
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 4e83892f1ac2..305290a109c0 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -858,6 +858,19 @@ int wiphy_register(struct wiphy *wiphy)
 		return -EINVAL;
 	}
 
+	for (i = 0; i < rdev->wiphy.n_vendor_commands; i++) {
+		/*
+		 * Validate we have a policy (can be explicitly set to
+		 * VENDOR_CMD_RAW_DATA which is non-NULL) and also that
+		 * we have at least one of doit/dumpit.
+		 */
+		if (WARN_ON(!rdev->wiphy.vendor_commands[i].policy))
+			return -EINVAL;
+		if (WARN_ON(!rdev->wiphy.vendor_commands[i].doit &&
+			    !rdev->wiphy.vendor_commands[i].dumpit))
+			return -EINVAL;
+	}
+
 #ifdef CONFIG_PM
 	if (WARN_ON(rdev->wiphy.wowlan && rdev->wiphy.wowlan->n_patterns &&
 		    (!rdev->wiphy.wowlan->pattern_min_len ||
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 140d24e5718f..70eb841a56c4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12623,6 +12623,29 @@ static int nl80211_crit_protocol_stop(struct sk_buff *skb,
 	return 0;
 }
 
+static int nl80211_vendor_check_policy(const struct wiphy_vendor_command *vcmd,
+				       struct nlattr *attr,
+				       struct netlink_ext_ack *extack)
+{
+	if (vcmd->policy == VENDOR_CMD_RAW_DATA) {
+		if (attr->nla_type & NLA_F_NESTED) {
+			NL_SET_ERR_MSG_ATTR(extack, attr,
+					    "unexpected nested data");
+			return -EINVAL;
+		}
+
+		return 0;
+	}
+
+	if (!(attr->nla_type & NLA_F_NESTED)) {
+		NL_SET_ERR_MSG_ATTR(extack, attr, "expected nested data");
+		return -EINVAL;
+	}
+
+	return nl80211_validate_nested(attr, vcmd->maxattr, vcmd->policy,
+				       extack);
+}
+
 static int nl80211_vendor_cmd(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -12681,11 +12704,16 @@ static int nl80211_vendor_cmd(struct sk_buff *skb, struct genl_info *info)
 		if (info->attrs[NL80211_ATTR_VENDOR_DATA]) {
 			data = nla_data(info->attrs[NL80211_ATTR_VENDOR_DATA]);
 			len = nla_len(info->attrs[NL80211_ATTR_VENDOR_DATA]);
+
+			err = nl80211_vendor_check_policy(vcmd,
+					info->attrs[NL80211_ATTR_VENDOR_DATA],
+					info->extack);
+			if (err)
+				return err;
 		}
 
 		rdev->cur_cmd_info = info;
-		err = rdev->wiphy.vendor_commands[i].doit(&rdev->wiphy, wdev,
-							  data, len);
+		err = vcmd->doit(&rdev->wiphy, wdev, data, len);
 		rdev->cur_cmd_info = NULL;
 		return err;
 	}
@@ -12772,6 +12800,13 @@ static int nl80211_prepare_vendor_dump(struct sk_buff *skb,
 	if (attrbuf[NL80211_ATTR_VENDOR_DATA]) {
 		data = nla_data(attrbuf[NL80211_ATTR_VENDOR_DATA]);
 		data_len = nla_len(attrbuf[NL80211_ATTR_VENDOR_DATA]);
+
+		err = nl80211_vendor_check_policy(
+				&(*rdev)->wiphy.vendor_commands[vcmd_idx],
+				attrbuf[NL80211_ATTR_VENDOR_DATA],
+				cb->extack);
+		if (err)
+			return err;
 	}
 
 	/* 0 is the first index - add 1 to parse only once */
-- 
2.17.2


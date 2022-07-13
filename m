Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC82573361
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbiGMJqo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236255AbiGMJpi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:38 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE9BF7894
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=lBN3m9+IPsURJqENjHO3U5mQ2gPeiRlx/wQpyPjNcGA=;
        t=1657705528; x=1658915128; b=QNqaMI1VD6SuDg+oFgOw53QimqfJ4CgT4xGCuGyz51VOW6F
        GKo9P6ftmQdNgRebojBGY00Ee3w64av/fkcnjKDw+sjKXFGdtD8xemdntEl51RElFPLR+lBU3eZth
        dKTNNHihfDBaEczJAZ4SuJB6Upduzu5OK5dO9uCS1HDXFEf3fIQCMaOozhdj0/F0lyX3iajj5B5N1
        N0hsYFcEEBYewkeSosRfUl1USYHnscP5MMMZTV6rbElYx512KuMOQx4vVPDmsij6ooiZscR1VDiLk
        yaG5qQ7FfhK42oqdkuYLoDn+ZCSfiA/KbTNe9dKp42z8dlI0SOtljD4c101tvHJQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvu-00EgvB-5L;
        Wed, 13 Jul 2022 11:45:26 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 61/76] wifi: nl80211: add EML/MLD capabilities to per-iftype capabilities
Date:   Wed, 13 Jul 2022 11:44:47 +0200
Message-Id: <20220713114426.4dfc9ebd0461.Ice7b841051cfeb23da17bb2caa0e45191b34c4db@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We have the per-interface type capabilities, currently for
extended capabilities, add the EML/MLD capabilities there
to have this advertised by the driver.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h       |  4 ++++
 include/uapi/linux/nl80211.h | 12 ++++++++++--
 net/wireless/nl80211.c       |  9 +++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index ca26e3b7341a..44abaa9d74ea 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4993,12 +4993,16 @@ struct wiphy_vendor_command {
  *	802.11-2012 8.4.2.29 for the defined fields.
  * @extended_capabilities_mask: mask of the valid values
  * @extended_capabilities_len: length of the extended capabilities
+ * @eml_capabilities: EML capabilities (for MLO)
+ * @mld_capa_and_ops: MLD capabilities and operations (for MLO)
  */
 struct wiphy_iftype_ext_capab {
 	enum nl80211_iftype iftype;
 	const u8 *extended_capabilities;
 	const u8 *extended_capabilities_mask;
 	u8 extended_capabilities_len;
+	u16 eml_capabilities;
+	u16 mld_capa_and_ops;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 37bfc934325a..3fa586e38f88 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2368,8 +2368,10 @@ enum nl80211_commands {
  *
  * @NL80211_ATTR_IFTYPE_EXT_CAPA: Nested attribute of the following attributes:
  *	%NL80211_ATTR_IFTYPE, %NL80211_ATTR_EXT_CAPA,
- *	%NL80211_ATTR_EXT_CAPA_MASK, to specify the extended capabilities per
- *	interface type.
+ *	%NL80211_ATTR_EXT_CAPA_MASK, to specify the extended capabilities and
+ *	other interface-type specific capabilities per interface type. For MLO,
+ *	%NL80211_ATTR_EML_CAPABILITY and %NL80211_ATTR_MLD_CAPA_AND_OPS are
+ *	present.
  *
  * @NL80211_ATTR_MU_MIMO_GROUP_DATA: array of 24 bytes that defines a MU-MIMO
  *	groupID for monitor mode.
@@ -2709,6 +2711,9 @@ enum nl80211_commands {
  *	suites allowed as %NL80211_MAX_NR_AKM_SUITES which is the legacy maximum
  *	number prior to the introduction of this attribute.
  *
+ * @NL80211_ATTR_EML_CAPABILITY: EML Capability information (u16)
+ * @NL80211_ATTR_MLD_CAPA_AND_OPS: MLD Capabilities and Operations (u16)
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3231,6 +3236,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_MAX_NUM_AKM_SUITES,
 
+	NL80211_ATTR_EML_CAPABILITY,
+	NL80211_ATTR_MLD_CAPA_AND_OPS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 37ec8b3897b4..35fb2b0517d9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2867,6 +2867,15 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 					    capab->extended_capabilities_mask))
 					goto nla_put_failure;
 
+				if (rdev->wiphy.flags & WIPHY_FLAG_SUPPORTS_MLO &&
+				    (nla_put_u16(msg,
+						 NL80211_ATTR_EML_CAPABILITY,
+						 capab->eml_capabilities) ||
+				     nla_put_u16(msg,
+						 NL80211_ATTR_MLD_CAPA_AND_OPS,
+						 capab->mld_capa_and_ops)))
+					goto nla_put_failure;
+
 				nla_nest_end(msg, nested_ext_capab);
 				if (state->split)
 					break;
-- 
2.36.1


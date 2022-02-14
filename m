Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62DB4B5629
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 17:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356361AbiBNQ3k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 11:29:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356348AbiBNQ3j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 11:29:39 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A74560D87
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 08:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Nfp7QzOMlKwwb1wQFYR0FAEOQmH91J88KUhxDcXsJgE=;
        t=1644856171; x=1646065771; b=VWaxXg0p8ZebC+Zqui39bsM7iCw/2iaU4/y3bNSGkakzpSG
        lYU4xPljBz8wZ9Gq1FMYYOROqSl3u93vFozvxdfmYL9M95l2cDlT3KrvJN99n21PoaMQ+eIwHusRb
        vs6NfNm/JbHQ6vv6F3ohmx1E7EVti536YiGwYnOvXsDlABwWFzkUk7/LFmxAwqYph9YbfjkGzzAkW
        1buueVawsxxSXKVKjl3YceVBjWUlMCAkikzuyQcMyPmkorXqEfUkfMer48AW7rbMMMhYKJpyGYAsP
        Fu0/Fzp4w8p9QktkkV1OuBKKn91ZQF+dD1nvPbNEZoBXCZbdmnuu/m5uJ62fWkXQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nJeEB-0011jK-Vh;
        Mon, 14 Feb 2022 17:29:28 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 3/3] nl80211: accept only HE capability elements with valid size
Date:   Mon, 14 Feb 2022 17:29:23 +0100
Message-Id: <20220214172921.80b710d45cb7.Id57ce32f9538a40e36c620fabedbd2c73346ef56@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214172920.750bee9eaf37.Ie18359bd38143b7dc949078f10752413e6d36854@changeid>
References: <20220214172920.750bee9eaf37.Ie18359bd38143b7dc949078f10752413e6d36854@changeid>
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

The kernel (driver code) should be able to assume that a station's
HE capabilities are not badly sized, so reject them if they are.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 578bff9c378b..0bdd11abe815 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -285,6 +285,18 @@ static int validate_ie_attr(const struct nlattr *attr,
 	return -EINVAL;
 }
 
+static int validate_he_capa(const struct nlattr *attr,
+			    struct netlink_ext_ack *extack)
+{
+	if (nla_len(attr) < NL80211_HE_MIN_CAPABILITY_LEN)
+		return -EINVAL;
+
+	if (!ieee80211_he_capa_size_ok(nla_data(attr), nla_len(attr)))
+		return -EINVAL;
+
+	return 0;
+}
+
 /* policy for the attributes */
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR];
 
@@ -730,9 +742,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_TXQ_MEMORY_LIMIT] = { .type = NLA_U32 },
 	[NL80211_ATTR_TXQ_QUANTUM] = { .type = NLA_U32 },
 	[NL80211_ATTR_HE_CAPABILITY] =
-		NLA_POLICY_RANGE(NLA_BINARY,
-				 NL80211_HE_MIN_CAPABILITY_LEN,
-				 NL80211_HE_MAX_CAPABILITY_LEN),
+		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_he_capa,
+				       NL80211_HE_MAX_CAPABILITY_LEN),
 	[NL80211_ATTR_FTM_RESPONDER] =
 		NLA_POLICY_NESTED(nl80211_ftm_responder_policy),
 	[NL80211_ATTR_TIMEOUT] = NLA_POLICY_MIN(NLA_U32, 1),
-- 
2.34.1


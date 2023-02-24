Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117986A1C45
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Feb 2023 13:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjBXMhU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Feb 2023 07:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjBXMhT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Feb 2023 07:37:19 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A85126D8
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 04:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=lfsvLhjWaQYG8UEr2bdPGWWJf7uOgR0HMoJsVrooZTY=; t=1677242223; x=1678451823; 
        b=ZFufst6TAjzlaNdeQA6t+fmPWOnFtwdH1wlrZF0RWGT6/PPEKa1DUqqMHRDTDzaEoywVlOSlnqE
        dQJOKY3T5scyn6sT1OXkjLQ2YZcXCkaNSEa6sMaxjmv2s2yxSjg5ttPCrOEUjpJyRqnvhg+VGZctJ
        k0MFHXDqTu1O/HuZ+0BNOwnsmSF18RMsnMKO8zsn2a77YYZw42G8iThCPEw1bdadT+yMXSNT4uB4/
        RSvPZFvL8sdlDtmD/7A+HqkAPGxW2kbcsYfRnLhP+fbyPp5l4CjXcRovX3bc8Wm+1c+xKYD7Kl7+B
        rn2ASvKF+bCB1x3aZWlvklLkfHfOhxbnLatg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pVXJs-004Bxd-26;
        Fri, 24 Feb 2023 13:37:00 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Aloka Dixit <quic_alokad@quicinc.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless] wifi: nl80211: fix puncturing bitmap policy
Date:   Fri, 24 Feb 2023 13:36:57 +0100
Message-Id: <20230224133656.b53b1fea182c.Ifa95124e8851df90e69776bcc3b0e3ebd1cf1687@changeid>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This was meant to be a u32, and while applying the patch
I tried to use policy validation for it. However, not only
did I copy/paste it to u8 instead of u32, but also used
the policy range erroneously. Fix both of these issues.

Fixes: d7c1a9a0ed18 ("wifi: nl80211: validate and configure puncturing bitmap")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 112b4bb009c8..1c3b9a305f42 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -462,6 +462,11 @@ nl80211_sta_wme_policy[NL80211_STA_WME_MAX + 1] = {
 	[NL80211_STA_WME_MAX_SP] = { .type = NLA_U8 },
 };
 
+static struct netlink_range_validation nl80211_punct_bitmap_range = {
+	.min = 0,
+	.max = 0xffff,
+};
+
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
 	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
@@ -805,7 +810,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
 	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
-	[NL80211_ATTR_PUNCT_BITMAP] = NLA_POLICY_RANGE(NLA_U8, 0, 0xffff),
+	[NL80211_ATTR_PUNCT_BITMAP] =
+		NLA_POLICY_FULL_RANGE(NLA_U32, &nl80211_punct_bitmap_range),
 };
 
 /* policy for the key attributes */
-- 
2.39.2


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9B4573A35
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 17:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbiGMPep (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 11:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbiGMPem (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE22332060
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=kkm/OG427Lc0msYf2+SEk0QmCZYQY/OWdZpMSIeKX/I=;
        t=1657726481; x=1658936081; b=gpgF/JpS3ljJw1SD6u88aEOdd6VMWJ67ylTVnHB2YNNY68d
        yCmQMTAfWNL/Qo0BZca+ksQ9YBexiTGwPT2aamQ12+oi7oTyailkm+0e3h33DEnD0WuKi7B0kdw4s
        PiNzSIcbOBhT/qVD8NWqtpETUYYlwYW0Qr+rX1y5/OAMKwS1zXLX5P1q+pWPCHHEUWOD1iBbyWsVI
        kVnOKWjzL34+p99MNtya7iupv0BKPvBZ9m/QOlnpWPNjkHyPs1GMlZKmYVVyX4qrZkxFyBGki5k+w
        KzqXXWHKTDsvofz8D4mm+yYQWjftjSe1HnaSW/B55lyX4gP5CmTXt6c7qDKoNwPg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBeNq-00EnaA-1E;
        Wed, 13 Jul 2022 17:34:38 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/21] wifi: nl80211: fix some attribute policy entries
Date:   Wed, 13 Jul 2022 17:34:15 +0200
Message-Id: <20220713173301.cba3a18d91b8.I2a913d5de4d7674bb62804a389666010ecf36553@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713153433.279227-1-johannes@sipsolutions.net>
References: <20220713153433.279227-1-johannes@sipsolutions.net>
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

The new NL80211_CMD_ADD_LINK_STA and NL80211_CMD_MODIFY_LINK_STA
commands have strict policy validation, so fix the policy so it
can be validated correctly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e2d1efe0174e..b6e640437568 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -456,6 +456,12 @@ nl80211_mbssid_config_policy[NL80211_MBSSID_CONFIG_ATTR_MAX + 1] = {
 	[NL80211_MBSSID_CONFIG_ATTR_EMA] = { .type = NLA_FLAG },
 };
 
+static const struct nla_policy
+nl80211_sta_wme_policy[NL80211_STA_WME_MAX + 1] = {
+	[NL80211_STA_WME_UAPSD_QUEUES] = { .type = NLA_U8 },
+	[NL80211_STA_WME_MAX_SP] = { .type = NLA_U8 },
+};
+
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
 	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
@@ -560,9 +566,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_USE_MFP] = NLA_POLICY_RANGE(NLA_U32,
 						  NL80211_MFP_NO,
 						  NL80211_MFP_OPTIONAL),
-	[NL80211_ATTR_STA_FLAGS2] = {
-		.len = sizeof(struct nl80211_sta_flag_update),
-	},
+	[NL80211_ATTR_STA_FLAGS2] =
+		NLA_POLICY_EXACT_LEN_WARN(sizeof(struct nl80211_sta_flag_update)),
 	[NL80211_ATTR_CONTROL_PORT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_CONTROL_PORT_ETHERTYPE] = { .type = NLA_U16 },
 	[NL80211_ATTR_CONTROL_PORT_NO_ENCRYPT] = { .type = NLA_FLAG },
@@ -615,6 +620,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_ie_attr,
 				       IEEE80211_MAX_DATA_LEN),
 	[NL80211_ATTR_ROAM_SUPPORT] = { .type = NLA_FLAG },
+	[NL80211_ATTR_STA_WME] = NLA_POLICY_NESTED(nl80211_sta_wme_policy),
 	[NL80211_ATTR_SCHED_SCAN_MATCH] = { .type = NLA_NESTED },
 	[NL80211_ATTR_TX_NO_CCK_RATE] = { .type = NLA_FLAG },
 	[NL80211_ATTR_TDLS_ACTION] = { .type = NLA_U8 },
@@ -6722,12 +6728,6 @@ static struct net_device *get_vlan(struct genl_info *info,
 	return ERR_PTR(ret);
 }
 
-static const struct nla_policy
-nl80211_sta_wme_policy[NL80211_STA_WME_MAX + 1] = {
-	[NL80211_STA_WME_UAPSD_QUEUES] = { .type = NLA_U8 },
-	[NL80211_STA_WME_MAX_SP] = { .type = NLA_U8 },
-};
-
 static int nl80211_parse_sta_wme(struct genl_info *info,
 				 struct station_parameters *params)
 {
-- 
2.36.1


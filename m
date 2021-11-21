Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4ED458327
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Nov 2021 12:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbhKULpN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Nov 2021 06:45:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237944AbhKULpM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Nov 2021 06:45:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0932160E54;
        Sun, 21 Nov 2021 11:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637494927;
        bh=/PunNOW3O1jF6keNVQXOcZ2/sdekFic4HRR4zDfgjvQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ofKg/eAR2lm/TH6QmNSOWNpQOTmCzl+LR3xR1DI2S9nTdIWLqkspw0CV/ROM2Lsis
         o43YhCjaYRR5M6OLnrkH9p4gr0hx2lWIpDwCdmbb4cRDAfetgYblrb8v8BTZGQ2YXI
         DVOtq1FQccHFv0rGEVKyHN4c94HlGqVs6o/TJSDmE2XqpOzHc6jhmeMEep1ldm76Hb
         3PEMaUXLTRPBiVGX5bpcKmHfFiZH8pkPA2fqBL5Dz3HB3jehmtmP557cdubn+6xmki
         GQ2srmvONV4KjxMrt3UGyxAaSiIwQEUR3fCiiuAGRzbAMpDMSv6hpRgXIRDNH1mY5H
         quTunqM3Y4yfg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        cjhuang@codeaurora.org
Subject: [PATCH mac80211] cfg80211: check nla_parse_nested return code in nl80211_set_sar_specs
Date:   Sun, 21 Nov 2021 12:41:56 +0100
Message-Id: <3b6fee130e2d264242463cff063bcfb6d6f5da83.1637494779.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Check error code returned by nla_parse_nested in nl80211_set_sar_specs
routine before parsing SAR sub-specs.

Fixes: 6bdb68cef7bf5 ("nl80211: add common API to configure SAR power limitations")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/wireless/nl80211.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index a27b3b5fa210..c2b005d0d29a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -15294,9 +15294,11 @@ static int nl80211_set_sar_specs(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[NL80211_ATTR_SAR_SPEC])
 		return -EINVAL;
 
-	nla_parse_nested(tb, NL80211_SAR_ATTR_MAX,
-			 info->attrs[NL80211_ATTR_SAR_SPEC],
-			 NULL, NULL);
+	err = nla_parse_nested(tb, NL80211_SAR_ATTR_MAX,
+			       info->attrs[NL80211_ATTR_SAR_SPEC],
+			       NULL, NULL);
+	if (err)
+		return err;
 
 	if (!tb[NL80211_SAR_ATTR_TYPE] || !tb[NL80211_SAR_ATTR_SPECS])
 		return -EINVAL;
@@ -15319,16 +15321,17 @@ static int nl80211_set_sar_specs(struct sk_buff *skb, struct genl_info *info)
 	sar_spec->type = type;
 	specs = 0;
 	nla_for_each_nested(spec_list, tb[NL80211_SAR_ATTR_SPECS], rem) {
-		nla_parse_nested(spec, NL80211_SAR_ATTR_SPECS_MAX,
-				 spec_list, NULL, NULL);
+		err = nla_parse_nested(spec, NL80211_SAR_ATTR_SPECS_MAX,
+				       spec_list, NULL, NULL);
+		if (err)
+			goto error;
 
 		switch (type) {
 		case NL80211_SAR_TYPE_POWER:
-			if (nl80211_set_sar_sub_specs(rdev, sar_spec,
-						      spec, specs)) {
-				err = -EINVAL;
+			err = nl80211_set_sar_sub_specs(rdev, sar_spec, spec,
+							specs);
+			if (err)
 				goto error;
-			}
 			break;
 		default:
 			err = -EINVAL;
-- 
2.31.1


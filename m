Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DD957332F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiGMJp0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiGMJpL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF47DBEB6C
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=jqpbrq9kUH/5bPfTEeXF7NNDJwd7RQKgl/QVcaEUiy4=;
        t=1657705510; x=1658915110; b=dtKt+1dSTRSHTKiSV+7TdqKvuSUkMxeS3WwDRcF+NaCHW0i
        zOmCEkbY5bxt70JsIgtqhQ7dd6IIwDn1CKvu4nHXdBQE++QpWv8JE3BYJ0ud1b6h4rfZ3JDPiiQyk
        0ZvXnJwQX7d+b1uWU5Mgyq0o3sk34dDTeAl2DT3g3dLmg0mXQoK7Ingo97oQE2iC4XniJDJ3l1Nxn
        xUt8abbsh3x0y5Kp5XH6lAWH9Fb7lRpoEC0n3SvZsheB9YkU4Be6gdq77ltBRAWt+NRSnRvGGThqw
        o+la0Eztg7jEubuB8D5Clrd5HCrLsSg8PrFPYB3ZgF0xME0cAfQooxGJG3oCSSew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvc-00EgvB-UT;
        Wed, 13 Jul 2022 11:45:09 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 15/76] wifi: nl80211: enable setting the link address at new station
Date:   Wed, 13 Jul 2022 11:44:01 +0200
Message-Id: <20220713114425.fa2a5cbeea3a.I66b26def7c72f9734219ba9a63153c6783ca6fb1@changeid>
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

From: Shaul Triebitz <shaul.triebitz@intel.com>

Since for an MLD station the default link is added together
with the add station command, allow also setting the link
MAC address.
Otherwise, it is needed to use the modify link API only
for setting the link MAC address.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 9eee853efd57..b50ba1803595 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7017,7 +7017,25 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 	params.link_sta_params.link_id =
 		nl80211_link_id_or_invalid(info->attrs);
 
-	mac_addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
+	if (info->attrs[NL80211_ATTR_MLD_ADDR]) {
+		/* If MLD_ADDR attribute is set then this is an MLD station
+		 * and the MLD_ADDR attribute holds the MLD address and the
+		 * MAC attribute holds for the LINK address.
+		 * In that case, the link_id is also expected to be valid.
+		 */
+		if (params.link_sta_params.link_id < 0)
+			return -EINVAL;
+
+		mac_addr = nla_data(info->attrs[NL80211_ATTR_MLD_ADDR]);
+		params.link_sta_params.mld_mac = mac_addr;
+		params.link_sta_params.link_mac =
+			nla_data(info->attrs[NL80211_ATTR_MAC]);
+		if (!is_valid_ether_addr(params.link_sta_params.link_mac))
+			return -EINVAL;
+	} else {
+		mac_addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
+	}
+
 	params.link_sta_params.supported_rates =
 		nla_data(info->attrs[NL80211_ATTR_STA_SUPPORTED_RATES]);
 	params.link_sta_params.supported_rates_len =
-- 
2.36.1


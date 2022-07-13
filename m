Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3317D57336E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiGMJqu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbiGMJpj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2089F78AF
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=wEdpcr1F/ACTecWeaMzahrcUrWtOeR1lwC5w2QHRhic=;
        t=1657705529; x=1658915129; b=yKYBUdDseXa8DpK5R7EMc+KByCBma9+ZSyGJtLlZhgxkekN
        OnXgKE0B7IcoWJWTXeRt+BD7g1aP7vL0B2Z+kYc+myHwmo+Yyoq25hzfc7xpKfAcwFblHM0PQnMMB
        jevQ7qtO93wX7Y3HsPF2q5aOxSaRfTt323+YA+TuuCmBKa/yDh33G12sG4vCkaxYLIRdjssz6Pz8P
        3E88R684rJOc2jO2Kkxw6nH/c6qxssK9iD7ngAR8wA4k2rO6h20oKmiFB/96s92fG24gG96fiQ+8i
        aiTZLj4pqv7rbghNY4mepDJCxWQZjUcRnUMkLrzVLpq8AfnR1H0wiSWyopjNp9tQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvv-00EgvB-K4;
        Wed, 13 Jul 2022 11:45:27 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [PATCH 66/76] wifi: nl80211: Support MLD parameters in nl80211_set_station()
Date:   Wed, 13 Jul 2022 11:44:52 +0200
Message-Id: <20220713114426.5e05616288de.I1f8376fb2e7f79b4131ed0f138478d2490ddaf4f@changeid>
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

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

Set the MLD parameters in NL80211_CMD_SET_STATION handling
to be able to change an MLD station.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ee3826e8e52b..35fcf36bbaad 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6894,7 +6894,28 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[NL80211_ATTR_MAC])
 		return -EINVAL;
 
-	mac_addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
+	params.link_sta_params.link_id =
+		nl80211_link_id_or_invalid(info->attrs);
+
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
 
 	if (info->attrs[NL80211_ATTR_STA_SUPPORTED_RATES]) {
 		params.link_sta_params.supported_rates =
-- 
2.36.1


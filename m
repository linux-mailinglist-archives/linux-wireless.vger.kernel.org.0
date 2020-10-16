Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68D2290CA0
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Oct 2020 22:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393393AbgJPUPt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Oct 2020 16:15:49 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:12722 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393350AbgJPUPs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Oct 2020 16:15:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602879348; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=1TX0PxBwrq+f4Qn7FreN6v6f/D4ornlO3gJsQgn9Ee0=; b=ouWSUZZ77jeOfUWSreeK6ZpqhZQ/VRYt/ysvZZ2FhfRs/2QZEKmsDJ+wRN6THn41jdT5x4Gq
 WzDUXd16DNT4fL02LPLBge8MLPlgTYbYRBtGrL5Mz36RjvoiyXIOjoKBZ153+v3DnBZNLByG
 ZPFXUP4t18A0j9ulyHOiZExQUns=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f89ff683711fec7b1010dce (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Oct 2020 20:15:36
 GMT
Sender: rmanohar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CFABEC433C9; Fri, 16 Oct 2020 20:15:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 298CFC433FF;
        Fri, 16 Oct 2020 20:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 298CFC433FF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH 1/2] nl80211: fix beacon tx rate mask validation
Date:   Fri, 16 Oct 2020 13:15:26 -0700
Message-Id: <1602879327-29488-1-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

While adding HE MCS beacon tx rate support, it is observed that legacy
beacon tx rate in VHT hwsim test suite is failed. Whenever the
application doesn't explicitly set VHT/MCS rate attribute in fixed rate
command, by default all HE MCS masks are enabled in cfg80211. In beacon
fixed rate, more than one rate mask is not allowed. Fix that by not
setting all rate mask by default in case of beacon tx rate.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 net/wireless/nl80211.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 554796a6c6fe..b61699a04dc4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4594,7 +4594,8 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 					 struct nlattr *attrs[],
 					 enum nl80211_attrs attr,
 					 struct cfg80211_bitrate_mask *mask,
-					 struct net_device *dev)
+					 struct net_device *dev,
+					 bool default_all_enabled)
 {
 	struct nlattr *tb[NL80211_TXRATE_MAX + 1];
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -4609,6 +4610,9 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 	for (i = 0; i < NUM_NL80211_BANDS; i++) {
 		const struct ieee80211_sta_he_cap *he_cap;
 
+		if (!default_all_enabled)
+			break;
+
 		sband = rdev->wiphy.bands[i];
 
 		if (!sband)
@@ -5243,7 +5247,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
 						    NL80211_ATTR_TX_RATES,
 						    &params.beacon_rate,
-						    dev);
+						    dev, false);
 		if (err)
 			return err;
 
@@ -11087,7 +11091,7 @@ static int nl80211_set_tx_bitrate_mask(struct sk_buff *skb,
 
 	err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
 					    NL80211_ATTR_TX_RATES, &mask,
-					    dev);
+					    dev, true);
 	if (err)
 		return err;
 
@@ -11696,7 +11700,7 @@ static int nl80211_join_mesh(struct sk_buff *skb, struct genl_info *info)
 		err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
 						    NL80211_ATTR_TX_RATES,
 						    &setup.beacon_rate,
-						    dev);
+						    dev, false);
 		if (err)
 			return err;
 
@@ -14476,7 +14480,8 @@ static int parse_tid_conf(struct cfg80211_registered_device *rdev,
 		if (tid_conf->txrate_type != NL80211_TX_RATE_AUTOMATIC) {
 			attr = NL80211_TID_CONFIG_ATTR_TX_RATE;
 			err = nl80211_parse_tx_bitrate_mask(info, attrs, attr,
-						    &tid_conf->txrate_mask, dev);
+						    &tid_conf->txrate_mask, dev,
+						    true);
 			if (err)
 				return err;
 
-- 
2.7.4


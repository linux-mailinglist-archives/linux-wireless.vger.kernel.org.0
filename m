Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7384A573368
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiGMJqt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236260AbiGMJpi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:38 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAEBF6B82
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=UsWdLTowwZ7OBU9n/A/NHQawzMdN3volBhQj58kiJ/s=;
        t=1657705529; x=1658915129; b=B0gIzFRXzlEBxKlwLWTCxFMgiOZ7EBQmQBdBUucelrRvaUs
        pwA51SxcsAdrQC9wtgWDMYgmRsTecuaZyJEB4H6WPqNwv4Cxtz1N9xQZLJvDLLAOqEDuYUw+ZOHNt
        mroOJrsfPJeGn6+ICf3VqHAmof6aiQYGar42YJUDBC5HCJLb4RPOEV4FRk8FlRBkCTLQ36ojzBZSu
        AxupGaj4yx+VGpGZ0y0e7W/QmG2Rlc1kOTszQAeGiJ+a5OpZyMnwpiuXmfJfZnZS8ECSqsLTY7TQI
        c2rzm2hqrSm6OiEM83sVgce4UTupFFszLveZDFWDI7FPXZFykJYpmong9H9NHfyA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvv-00EgvB-Ah;
        Wed, 13 Jul 2022 11:45:27 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 65/76] wifi: nl80211: check MLO support in authenticate
Date:   Wed, 13 Jul 2022 11:44:51 +0200
Message-Id: <20220713114426.1969ed1b1e54.I9a4d1235561ff868742abeed69a2f558040607e5@changeid>
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

We should check that MLO connections are supported before
attempting to authenticate with MLO parameters, check that.

Fixes: d648c23024bd ("wifi: nl80211: support MLO in auth/assoc")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b75398f0d5b4..ee3826e8e52b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10410,6 +10410,8 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 	req.key_idx = key.idx;
 	req.link_id = nl80211_link_id_or_invalid(info->attrs);
 	if (req.link_id >= 0) {
+		if (!(rdev->wiphy.flags & WIPHY_FLAG_SUPPORTS_MLO))
+			return -EINVAL;
 		if (!info->attrs[NL80211_ATTR_MLD_ADDR])
 			return -EINVAL;
 		req.ap_mld_addr = nla_data(info->attrs[NL80211_ATTR_MLD_ADDR]);
-- 
2.36.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4081E573A34
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 17:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbiGMPen (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 11:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiGMPel (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2EA30F46
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=dowT5/fbHMQCPQq7DYbtU6a7iyOiKETaI20mzGTRkqk=;
        t=1657726480; x=1658936080; b=G8lVgFIvIE143HJ4RDOo68DLO41VSvbIjXVqaU+OGH7WcG2
        IrtdbqCfBSeqq6MrFGybdm0bDIp/Hem7yXGZqAyGZlLFv3jIJFAhB4YdV4j9HCvNp1vBHJhhkJFnr
        yNb1HwWFWwsVrDeCcevKU5JbXn0HBLXqAkSXp5XxgOG3ZhA7dbrvskF0DCoMhnzgM8ReMRAj9qyvg
        4Vby4Y0k5azDEuVCJhBW402RrqKx/y//gtQDj4zjFvrSZUhOtEPUTAhOsEt1h2ngB6Q2OmWCYMXbH
        r965z3OfrCn+CpjTGemgpAfzwQI/hSraz/Z+T6ddrCJQ8011xod11zI2qSYeK/Cg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBeNp-00EnaA-Hr;
        Wed, 13 Jul 2022 17:34:37 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/21] wifi: nl80211: reject link specific elements on assoc link
Date:   Wed, 13 Jul 2022 17:34:13 +0200
Message-Id: <20220713173301.0c5d0302c561.I01b2db7b91d0f03790751b6bee9c7001ce323317@changeid>
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

When we associate, we'll include all the elements for the
link we're sending the association request on in the frame
and the specific ones for other links in the multi-link
element container. Prohibit adding link-specific elements
for the association link.

Fixes: d648c23024bd ("wifi: nl80211: support MLO in auth/assoc")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ead9bd111280..be969f64b5c3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10813,6 +10813,13 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 			goto free;
 		}
 
+		if (req.links[req.link_id].elems_len) {
+			GENL_SET_ERR_MSG(info,
+					 "cannot have per-link elems on assoc link");
+			err = -EINVAL;
+			goto free;
+		}
+
 		kfree(attrs);
 		attrs = NULL;
 	} else {
-- 
2.36.1


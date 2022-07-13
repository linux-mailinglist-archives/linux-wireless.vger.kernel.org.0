Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8D5573369
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiGMJrB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbiGMJpn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE105F894F
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Am6D8nollX5HPnNflOrD50F0gzf0h82ZqA/F0Mp2hNw=;
        t=1657705531; x=1658915131; b=AHj7tkNo7koxCXO4NliMOBStIyBkOMrjJ7Moi5xMMY748+0
        mbvVvYGKb5BF5v+JHL148xDXiVLzp8m4CPNd3pnFtdXchD7mcYd8OqLv8C79ySOvr2p8MqZPzVNyP
        syWOYd5VkQV3C8F9yXiYBgWf6Q8H03XIT83jaDghUXoQENvMflX9xkz/CXs8BjO1vX1+WjHQuvUyw
        8uYw2zxDayyCmhW+DjtGGfaLlWUY4PsJ7ZrO1F+w0X6/TZmEOHIGeOXXr2nr35L7rCcb4vElWcHS8
        Qd0BT8R1f36IehMJ1f7R8t1qZz9oYvXVz0b1gslGxzYKzDgGdHTFV6I/iwpFoQMg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvx-00EgvB-R0;
        Wed, 13 Jul 2022 11:45:29 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 73/76] wifi: nl80211: advertise MLO support
Date:   Wed, 13 Jul 2022 11:44:59 +0200
Message-Id: <20220713114426.fe80cd30a7c9.I8b5d683613586d2005bb667d0cbb7f985eb27d75@changeid>
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

At least while we don't have any more specific interface
combinations support, add a simple flag for MLO support,
we can keep this later based on something other than the
wiphy flag.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0bf1f7267b89..ead9bd111280 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2946,6 +2946,9 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 				rdev->wiphy.max_num_akm_suites))
 			goto nla_put_failure;
 
+		if (rdev->wiphy.flags & WIPHY_FLAG_SUPPORTS_MLO)
+			nla_put_flag(msg, NL80211_ATTR_MLO_SUPPORT);
+
 		/* done */
 		state->split_start = 0;
 		break;
-- 
2.36.1


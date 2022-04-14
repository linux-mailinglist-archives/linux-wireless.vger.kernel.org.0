Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D46E500CBE
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Apr 2022 14:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241513AbiDNMGe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Apr 2022 08:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiDNMGe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Apr 2022 08:06:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF5AB1DF
        for <linux-wireless@vger.kernel.org>; Thu, 14 Apr 2022 05:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=Q90vOXqt5hrmr6HZTmRQ4zKEq2Gxpl13HJ5XyToIqvI=; t=1649937849; x=1651147449; 
        b=AOrC9PjPidHFzO3i43GZpuHZpqPZJ8LA161REfvGHOxxpQTeLymUeUuV0bgbWmHOuQJHh2l+aqM
        PF7Uyygy/dFx2b0q520/TjbOlOySdvse0Eq0CwThSnDx3w6mZ1fKvezIpU+C2ZPY0NA3s6XEA3giH
        uzgj796/wHMPvtenL2pCa5ElJxduqpSNJNqW2M7JR/bTzgiskWICJA2dkWgwWxM8+orT8w+Nt2b7R
        cR6QK0s2189pFy4p0p0/BRkDeleveVWN879tYtwmxCxc2gZ7JIRHdWZP3gCNSewT2iSYgjT55oRZF
        C9RUE7nWCye2yZYDkahVYKP2ar9lWbEtvhNw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1neyCk-009rpd-RL;
        Thu, 14 Apr 2022 14:04:06 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] nl80211: don't hold RTNL in color change request
Date:   Thu, 14 Apr 2022 14:04:02 +0200
Message-Id: <20220414140402.32e03e8c261b.I5e7dc6bc563a129b938c43298da6bb4e812400a5@changeid>
X-Mailer: git-send-email 2.35.1
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

It's not necessary to hold the RTNL across color change
requests, since all the inner locking needs only the
wiphy mutex which we already hold as well.

Fixes: 0d2ab3aea50b ("nl80211: add support for BSS coloring")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 711061cd02d1..087ad3accad8 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16272,8 +16272,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_color_change,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_SET_FILS_AAD,
-- 
2.35.1


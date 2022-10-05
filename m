Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDF25F54E0
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJENBR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiJENA5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6D41F619
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=fk7QTKv+txphYCbm6e2QV+zaModpfM+XhJJ/DzsWMKI=;
        t=1664974856; x=1666184456; b=V6Z3z6caAmGawZtk9iCrcFj6cjjj8z9xDzoRkKVgNUXuVCV
        QVuB6UOUt8nIpb0WA6JmRsP9DgbDyvbhGHaWgUOp8hdyyGykq6k3rkFRS/lAhT/ludH3r9DrRyXZG
        NHdnrBfMzrqVA2rBsX9OcEkP9gDSh8QG+xpSjUbDRUgnQtdToSSJ23qmyEAbSg+Q4N0pP/DLFDPY8
        OZW8mGnIKGlIPACFdU+5wGgiweSVsQ04fOedeqjO1wPiqNbljYJoGDXnR72LGK0cHCHhrsyJvsP9V
        BWy6hoKafgtz/Xda+X7rd/b47r22Vx3YV7Y8gdTn62XcaU6Oi0lkCLBq2xxjmpPw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og417-00G2RL-2X;
        Wed, 05 Oct 2022 15:00:53 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/28] wifi: nl80211: use link ID in NL80211_CMD_SET_BSS
Date:   Wed,  5 Oct 2022 15:00:33 +0200
Message-Id: <20221005145226.3c9f8b71f53e.Id8cbedd0a18273dbe9f25a2bd4d987f22cfc3aac@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005130048.217341-1-johannes@sipsolutions.net>
References: <20221005130048.217341-1-johannes@sipsolutions.net>
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

We clearly need the link ID here, to know the right BSS
to configure. Use/require it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 2 ++
 net/wireless/nl80211.c | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4d35a4234417..659dd1bee70f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2105,6 +2105,7 @@ struct mpath_info {
  *
  * Used to change BSS parameters (mainly for AP mode).
  *
+ * @link_id: link_id or -1 for non-MLD
  * @use_cts_prot: Whether to use CTS protection
  *	(0 = no, 1 = yes, -1 = do not change)
  * @use_short_preamble: Whether the use of short preambles is allowed
@@ -2122,6 +2123,7 @@ struct mpath_info {
  * @p2p_opp_ps: P2P opportunistic PS (-1 = no change)
  */
 struct bss_parameters {
+	int link_id;
 	int use_cts_prot;
 	int use_short_preamble;
 	int use_short_slot_time;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ad7393cd3d18..1d0277758d0e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7780,6 +7780,7 @@ static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
 	int err;
 
 	memset(&params, 0, sizeof(params));
+	params.link_id = nl80211_link_id_or_invalid(info->attrs);
 	/* default to not changing parameters */
 	params.use_cts_prot = -1;
 	params.use_short_preamble = -1;
@@ -16564,7 +16565,8 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_bss,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_MLO_VALID_LINK_ID),
 	},
 	{
 		.cmd = NL80211_CMD_GET_REG,
-- 
2.37.3


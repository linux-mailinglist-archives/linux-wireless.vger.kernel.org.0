Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62A650CCC7
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Apr 2022 19:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiDWR6R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Apr 2022 13:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiDWR6Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Apr 2022 13:58:16 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836AD626A
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 10:55:17 -0700 (PDT)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id A5AF2100002;
        Sat, 23 Apr 2022 17:55:14 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] iw: fix 'upto' -> 'up to'
Date:   Sat, 23 Apr 2022 19:54:51 +0200
Message-Id: <20220423175451.27215-1-didi.debian@cknow.org>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As reported by Debian's lintian tool.

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
In https://www.usingenglish.com/forum/threads/upto-or-up-to.137090/post-691624
a retired English teacher agrees: "Up to should always be two words."

 info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/info.c b/info.c
index fa79ec7..ba33073 100644
--- a/info.c
+++ b/info.c
@@ -713,7 +713,7 @@ broken_combination:
 		rule = nla_data(tb_msg[NL80211_ATTR_COALESCE_RULE]);
 		pat = &rule->pat;
 		printf("\t\t * Maximum %u coalesce rules supported\n"
-		       "\t\t * Each rule contains upto %u patterns of %u-%u bytes,\n"
+		       "\t\t * Each rule contains up to %u patterns of %u-%u bytes,\n"
 		       "\t\t   maximum packet offset %u bytes\n"
 		       "\t\t * Maximum supported coalescing delay %u msecs\n",
 			rule->max_rules, pat->max_patterns, pat->min_pattern_len,
-- 
2.36.0


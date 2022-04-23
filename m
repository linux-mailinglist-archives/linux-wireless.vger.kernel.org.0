Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAED50CC30
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Apr 2022 18:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiDWQMq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Apr 2022 12:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbiDWQMk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Apr 2022 12:12:40 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D662A14B2EA
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 09:09:41 -0700 (PDT)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id BA9331BF205;
        Sat, 23 Apr 2022 16:09:36 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] iw: fix double tab in mesh path header
Date:   Sat, 23 Apr 2022 18:09:22 +0200
Message-Id: <20220423160922.14952-1-didi.debian@cknow.org>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As reported in https://bugs.debian.org/974833, the double tab char
causes a mismatch of the header and contents after 'EXPTIME'.

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 mpath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mpath.c b/mpath.c
index a88f89f..2a559c2 100644
--- a/mpath.c
+++ b/mpath.c
@@ -226,7 +226,7 @@ static int handle_mpath_dump(struct nl80211_state *state,
 			     enum id_input id)
 {
 	printf("DEST ADDR         NEXT HOP          IFACE\tSN\tMETRIC\tQLEN\t"
-	       "EXPTIME\t\tDTIM\tDRET\tFLAGS\tHOP_COUNT\tPATH_CHANGE\n");
+	       "EXPTIME\tDTIM\tDRET\tFLAGS\tHOP_COUNT\tPATH_CHANGE\n");
 	register_handler(print_mpath_handler, NULL);
 	return 0;
 }
-- 
2.35.2


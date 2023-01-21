Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74648676892
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Jan 2023 20:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjAUTn1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Jan 2023 14:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjAUTn1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Jan 2023 14:43:27 -0500
X-Greylist: delayed 396 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 21 Jan 2023 11:43:24 PST
Received: from mail.v2201612906741603.powersrv.de (mail.weilnetz.de [37.120.169.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8903F1BAE1
        for <linux-wireless@vger.kernel.org>; Sat, 21 Jan 2023 11:43:24 -0800 (PST)
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
        by mail.v2201612906741603.powersrv.de (Postfix) with ESMTP id AE786DA101C;
        Sat, 21 Jan 2023 20:36:46 +0100 (CET)
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
        id DAD75460C94; Sat, 21 Jan 2023 20:36:45 +0100 (CET)
From:   Stefan Weil <sw@weilnetz.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Stefan Weil <sw@weilnetz.de>
Subject: [PATCH] iw: event: fix printf format error
Date:   Sat, 21 Jan 2023 20:36:37 +0100
Message-Id: <20230121193637.347109-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tv_usec can be a 64 bit integer which causes a compiler warning:

event.c: In function 'print_event':
event.c:930:41: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'suseconds_t' {aka 'long long int'} [-Wformat=]
  930 |                         printf("[%s.%06lu]: ", buf, args->ts.tv_usec);
      |                                     ~~~~^           ~~~~~~~~~~~~~~~~
      |                                         |                   |
      |                                         long unsigned int   suseconds_t {aka long long int}
      |                                     %06llu

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---

I got this compiler warning when building gluon for arm_cortex-a7.

 event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/event.c b/event.c
index 4c37297..fa2e125 100644
--- a/event.c
+++ b/event.c
@@ -942,7 +942,7 @@ static int print_event(struct nl_msg *msg, void *arg)
 
 			memset(buf, 0, 255);
 			strftime(buf, sizeof(buf), "%Y-%m-%d %H:%M:%S", tm);
-			printf("[%s.%06lu]: ", buf, args->ts.tv_usec);
+			printf("[%s.%06lu]: ", buf, (unsigned long )args->ts.tv_usec);
 		} else {
 			printf("%llu.%06llu: ", usecs/1000000, usecs % 1000000);
 		}
-- 
2.37.1 (Apple Git-137.1)

